:: To be run locally after initially running (once on a Windows Computer) 1_System-Cleanup_Setup-n-Run.bat
::
@ECHO OFF
REM Run cleanup
IF EXIST %SystemRoot%\SYSTEM32\cleanmgr.exe START /WAIT cleanmgr /sagerun:100

ECHO Cleanup Update Files:
net.exe stop wuauserv
REM Option 1
::cd %Windir%\SoftwareDistribution
::del /f /s /q Download
REM Option 2
::cmd.exe /c del c:\windows\SoftwareDistribution /q /s
::rmdir %windir%\SoftwareDistribution /s /q
REM Option 3
rd /S /Q C:\Windows\SoftwareDistribution
rd /S /Q C:\$WINDOWS.~BT
rd /S /Q C:\Windows.old
net start wuauserv
del %windir%\$NT* /f /s /q /a:h
del c:\Windows\Prefetch\*.* /f /s /Q
REM Remove Shadow Copies
vssadmin delete shadows /All /Quiet
REM Clear IE Cache:
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255
REM Shrink Image by deleting rollback
ECHO Cleaning Windows Image:
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
::REM Defrag
::defrag c: /U /V
PAUSE
