/*
 
 CustomSurroundStringViewController.swift
 
 CotEditor
 https://coteditor.com
 
 Created by 1024jp on 2017-03-19.
 
 ------------------------------------------------------------------------------
 
 © 2017-2018 1024jp
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 https://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
 */

import Cocoa

final class CustomSurroundStringViewController: NSViewController {
    
    // MARK: Private Properties
    
    @objc private dynamic var beginString: String = ""
    @objc private dynamic var endString: String = ""
    
    @IBOutlet fileprivate weak var beginStringField: NSTextField?
    @IBOutlet fileprivate weak var endStringField: NSTextField?
    
    
    
    // MARK: -
    // MARK: Action Messages
    
    /// apply
    @IBAction func ok(_ sender: Any?) {
        
        self.endEditing()
        
        guard
            let textView = self.representedObject as? NSTextView,
            !self.beginString.isEmpty else {
                NSSound.beep()
                return
        }
        
        // use beginString also for end delimiter if endString is empty
        let endString = self.endString.isEmpty ? self.beginString : self.endString
        
        textView.surroundSelections(begin: self.beginString, end: endString)
        
        self.dismiss(sender)
    }
    
}


extension CustomSurroundStringViewController: NSTextFieldDelegate {
    
    /// keep setting beginString to the placeholder of endStringField
    override func controlTextDidChange(_ obj: Notification) {
        
        self.endStringField?.placeholderString = self.beginStringField?.stringValue
    }
    
}
