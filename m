Received: from eggs.gnu.org ([2001:4830:134:3::10]:51876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e3qo7-00049v-JV
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 17:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e3qo1-0008M0-HY
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 17:50:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:54536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e3qo1-0008Lf-8O
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 17:50:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e3qnz-0004QD-5j
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 21:50:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 262902E804E
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 21:50:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Oct 2017 21:40:38 -0000
From: Alexander Kuzmin <1723731@bugs.launchpad.net>
Reply-To: Bug 1723731 <1723731@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150806672066.15534.12058555571151449517.malonedeb@soybean.canonical.com>
Message-Id: <150810363862.15354.17308882875159618773.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1723731] Re: Qemu turns to black screen while
 starting to copy installation files of Windows 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Description changed:

  Distribution: Arch Linux, Kernel: linux-4.13.5, Qemu: 2.10.1, OVMF: git (=
built 06.10.17).
  Steps to reproduce: create Qemu VM with such config:
  =

  QEMU_VM_NAME=3D$(basename $(dirname "$0")) #Qemu virtual machine name (ta=
ken from working directory)
  QEMU_WORKING_DIR=3D"$(dirname "$0")" #Qemu current working directory
  DIF=3D12 #set 2-digit number here
  QEMU_MONITOR_PORT=3D370${DIF} #Qemu monitor port
  QEMU_SERIAL_PORT=3D371${DIF} #Qemu serial port
  QEMU_PARALLEL_PORT=3D372${DIF} #Qemu parallel port
- =

  =

  qemu-system-x86_64 -daemonize -display gtk -boot menu=3Don -monitor telne=
t:127.0.0.1:${QEMU_MONITOR_PORT},server,nowait -serial telnet:127.0.0.1:${Q=
EMU_SERIAL_PORT},server,nowait -uuid fafafafa-1234-bcbc-5678-11112222ff${DI=
F} -name ${QEMU_VM_NAME},process=3DQEMU-${QEMU_VM_NAME} -parallel none -net=
 none -nodefconfig -nodefaults -no-user-config -rtc base=3Dlocaltime,clock=
=3Dvm,driftfix=3Dslew -realtime mlock=3Doff -machine type=3Dq35,accel=3Dkvm=
,usb=3Doff,dump-guest-core=3Doff -smp 2,sockets=3D1,cores=3D2,threads=3D1 -=
object iothread,id=3Diothread1 -object iothread,id=3Diothread2 -cpu Penryn,=
kvm=3Doff,check,vendor=3DGenuineIntel,+vmx -m 2G -device qxl-vga,id=3Dvideo=
0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=3D1=
6,max_outputs=3D1,addr=3D0x1b.0x0 -global qxl-vga.revision=3D4 -device ich9=
-intel-hda,addr=3D0x11.0x0,id=3Dsound0 -device hda-duplex,id=3Dsound0-codec=
0,bus=3Dsound0.0,cad=3D0 -device ich9-usb-ehci1,id=3Dehci1,addr=3D0x12.0x7 =
-device ich9-usb-uhci1,id=3Duhci1,masterbus=3Dehci1.0,firstport=3D0,multifu=
nction=3Don,addr=3D0x12.0x0 -device ich9-usb-uhci2,id=3Duhci2,masterbus=3De=
hci1.0,firstport=3D2,addr=3D0x12.0x1 -device ich9-usb-uhci3,id=3Duhci3,mast=
erbus=3Dehci1.0,firstport=3D4,addr=3D0x12.0x2 -device ide-hd,bus=3Dide.0,dr=
ive=3Ddrive-sata0-0-0,id=3Dsata0-0-0 -drive file=3D"${QEMU_WORKING_DIR}"/${=
QEMU_VM_NAME}.qcow2,if=3Dnone,media=3Ddisk,id=3Ddrive-sata0-0-0,format=3Dqc=
ow2 -device ide-cd,bus=3Dide.1,drive=3Ddrive-sata0-0-1,id=3Dsata0-0-1 -driv=
e if=3Dnone,media=3Dcdrom,readonly=3Don,id=3Ddrive-sata0-0-1 -device usb-ta=
blet,id=3Dtbl0,bus=3Dehci1.0,port=3D2,usb_version=3D2,serial=3D1123,display=
=3Dtbl0
  -device usb-kbd,id=3Dkbd0,bus=3Dehci1.0,port=3D1,usb_version=3D1,serial=
=3D1122,display=3Dkbd0
  =

  After that connect to Qemu console, insert Windows 7 installation media
  and start installation. You can successfully choose language, keyboard
  layout and partition your harddrive but after 2-3 seconds after
  beginning of copying installation files the graphical console screen
  turns to black and 1 CPU core on the host raises to 100% permanently and
  nothing happens. But if you installed Windows 7 before - there is no
  problems with VM. Tested on GTK, SDL types of screen.
  =

  Qemu was installed from official repo and also I tried with built by
  myself version. Other OSes: Windows 8, 8.1, 10, Arch Linux, Debian,
  FreeBSD installed successfully.
  =

- When you try to install Windows 7 in BIOS mode - you can pass all the
- installations steps, but after first reboot after installing guest
- agent, qxl and virtio-net drivers - OS freezes on Windows logo.
+ It happens only in OVMF-mode. I've just tested BIOS mode with no
+ problems.

** Description changed:

  Distribution: Arch Linux, Kernel: linux-4.13.5, Qemu: 2.10.1, OVMF: git (=
built 06.10.17).
  Steps to reproduce: create Qemu VM with such config:
  =

  QEMU_VM_NAME=3D$(basename $(dirname "$0")) #Qemu virtual machine name (ta=
ken from working directory)
  QEMU_WORKING_DIR=3D"$(dirname "$0")" #Qemu current working directory
  DIF=3D12 #set 2-digit number here
  QEMU_MONITOR_PORT=3D370${DIF} #Qemu monitor port
  QEMU_SERIAL_PORT=3D371${DIF} #Qemu serial port
  QEMU_PARALLEL_PORT=3D372${DIF} #Qemu parallel port
  =

  qemu-system-x86_64 -daemonize -display gtk -boot menu=3Don -monitor telne=
t:127.0.0.1:${QEMU_MONITOR_PORT},server,nowait -serial telnet:127.0.0.1:${Q=
EMU_SERIAL_PORT},server,nowait -uuid fafafafa-1234-bcbc-5678-11112222ff${DI=
F} -name ${QEMU_VM_NAME},process=3DQEMU-${QEMU_VM_NAME} -parallel none -net=
 none -nodefconfig -nodefaults -no-user-config -rtc base=3Dlocaltime,clock=
=3Dvm,driftfix=3Dslew -realtime mlock=3Doff -machine type=3Dq35,accel=3Dkvm=
,usb=3Doff,dump-guest-core=3Doff -smp 2,sockets=3D1,cores=3D2,threads=3D1 -=
object iothread,id=3Diothread1 -object iothread,id=3Diothread2 -cpu Penryn,=
kvm=3Doff,check,vendor=3DGenuineIntel,+vmx -m 2G -device qxl-vga,id=3Dvideo=
0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=3D1=
6,max_outputs=3D1,addr=3D0x1b.0x0 -global qxl-vga.revision=3D4 -device ich9=
-intel-hda,addr=3D0x11.0x0,id=3Dsound0 -device hda-duplex,id=3Dsound0-codec=
0,bus=3Dsound0.0,cad=3D0 -device ich9-usb-ehci1,id=3Dehci1,addr=3D0x12.0x7 =
-device ich9-usb-uhci1,id=3Duhci1,masterbus=3Dehci1.0,firstport=3D0,multifu=
nction=3Don,addr=3D0x12.0x0 -device ich9-usb-uhci2,id=3Duhci2,masterbus=3De=
hci1.0,firstport=3D2,addr=3D0x12.0x1 -device ich9-usb-uhci3,id=3Duhci3,mast=
erbus=3Dehci1.0,firstport=3D4,addr=3D0x12.0x2 -device ide-hd,bus=3Dide.0,dr=
ive=3Ddrive-sata0-0-0,id=3Dsata0-0-0 -drive file=3D"${QEMU_WORKING_DIR}"/${=
QEMU_VM_NAME}.qcow2,if=3Dnone,media=3Ddisk,id=3Ddrive-sata0-0-0,format=3Dqc=
ow2 -device ide-cd,bus=3Dide.1,drive=3Ddrive-sata0-0-1,id=3Dsata0-0-1 -driv=
e if=3Dnone,media=3Dcdrom,readonly=3Don,id=3Ddrive-sata0-0-1 -device usb-ta=
blet,id=3Dtbl0,bus=3Dehci1.0,port=3D2,usb_version=3D2,serial=3D1123,display=
=3Dtbl0
- -device usb-kbd,id=3Dkbd0,bus=3Dehci1.0,port=3D1,usb_version=3D1,serial=
=3D1122,display=3Dkbd0
+ -device usb-kbd,id=3Dkbd0,bus=3Dehci1.0,port=3D1,usb_version=3D1,serial=
=3D1122,display=3Dkbd0 -drive if=3Dpflash,format=3Draw,unit=3D1,file=3D${QE=
MU_WORKING_DIR}/ovmf_vars_x64.bin -drive if=3Dpflash,format=3Draw,unit=3D0,=
readonly,file=3D${QEMU_WORKING_DIR}/ovmf_code_x64.bin
  =

  After that connect to Qemu console, insert Windows 7 installation media
  and start installation. You can successfully choose language, keyboard
  layout and partition your harddrive but after 2-3 seconds after
  beginning of copying installation files the graphical console screen
  turns to black and 1 CPU core on the host raises to 100% permanently and
  nothing happens. But if you installed Windows 7 before - there is no
  problems with VM. Tested on GTK, SDL types of screen.
  =

  Qemu was installed from official repo and also I tried with built by
  myself version. Other OSes: Windows 8, 8.1, 10, Arch Linux, Debian,
  FreeBSD installed successfully.
  =

  It happens only in OVMF-mode. I've just tested BIOS mode with no
  problems.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1723731

Title:
  Qemu turns to black screen while starting to copy installation files
  of Windows 7

Status in QEMU:
  New

Bug description:
  Distribution: Arch Linux, Kernel: linux-4.13.5, Qemu: 2.10.1, OVMF: git (=
built 06.10.17).
  Steps to reproduce: create Qemu VM with such config:

  QEMU_VM_NAME=3D$(basename $(dirname "$0")) #Qemu virtual machine name (ta=
ken from working directory)
  QEMU_WORKING_DIR=3D"$(dirname "$0")" #Qemu current working directory
  DIF=3D12 #set 2-digit number here
  QEMU_MONITOR_PORT=3D370${DIF} #Qemu monitor port
  QEMU_SERIAL_PORT=3D371${DIF} #Qemu serial port
  QEMU_PARALLEL_PORT=3D372${DIF} #Qemu parallel port

  qemu-system-x86_64 -daemonize -display gtk -boot menu=3Don -monitor telne=
t:127.0.0.1:${QEMU_MONITOR_PORT},server,nowait -serial telnet:127.0.0.1:${Q=
EMU_SERIAL_PORT},server,nowait -uuid fafafafa-1234-bcbc-5678-11112222ff${DI=
F} -name ${QEMU_VM_NAME},process=3DQEMU-${QEMU_VM_NAME} -parallel none -net=
 none -nodefconfig -nodefaults -no-user-config -rtc base=3Dlocaltime,clock=
=3Dvm,driftfix=3Dslew -realtime mlock=3Doff -machine type=3Dq35,accel=3Dkvm=
,usb=3Doff,dump-guest-core=3Doff -smp 2,sockets=3D1,cores=3D2,threads=3D1 -=
object iothread,id=3Diothread1 -object iothread,id=3Diothread2 -cpu Penryn,=
kvm=3Doff,check,vendor=3DGenuineIntel,+vmx -m 2G -device qxl-vga,id=3Dvideo=
0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=3D1=
6,max_outputs=3D1,addr=3D0x1b.0x0 -global qxl-vga.revision=3D4 -device ich9=
-intel-hda,addr=3D0x11.0x0,id=3Dsound0 -device hda-duplex,id=3Dsound0-codec=
0,bus=3Dsound0.0,cad=3D0 -device ich9-usb-ehci1,id=3Dehci1,addr=3D0x12.0x7 =
-device ich9-usb-uhci1,id=3Duhci1,masterbus=3Dehci1.0,firstport=3D0,multifu=
nction=3Don,addr=3D0x12.0x0 -device ich9-usb-uhci2,id=3Duhci2,masterbus=3De=
hci1.0,firstport=3D2,addr=3D0x12.0x1 -device ich9-usb-uhci3,id=3Duhci3,mast=
erbus=3Dehci1.0,firstport=3D4,addr=3D0x12.0x2 -device ide-hd,bus=3Dide.0,dr=
ive=3Ddrive-sata0-0-0,id=3Dsata0-0-0 -drive file=3D"${QEMU_WORKING_DIR}"/${=
QEMU_VM_NAME}.qcow2,if=3Dnone,media=3Ddisk,id=3Ddrive-sata0-0-0,format=3Dqc=
ow2 -device ide-cd,bus=3Dide.1,drive=3Ddrive-sata0-0-1,id=3Dsata0-0-1 -driv=
e if=3Dnone,media=3Dcdrom,readonly=3Don,id=3Ddrive-sata0-0-1 -device usb-ta=
blet,id=3Dtbl0,bus=3Dehci1.0,port=3D2,usb_version=3D2,serial=3D1123,display=
=3Dtbl0
  -device usb-kbd,id=3Dkbd0,bus=3Dehci1.0,port=3D1,usb_version=3D1,serial=
=3D1122,display=3Dkbd0 -drive if=3Dpflash,format=3Draw,unit=3D1,file=3D${QE=
MU_WORKING_DIR}/ovmf_vars_x64.bin -drive if=3Dpflash,format=3Draw,unit=3D0,=
readonly,file=3D${QEMU_WORKING_DIR}/ovmf_code_x64.bin

  After that connect to Qemu console, insert Windows 7 installation
  media and start installation. You can successfully choose language,
  keyboard layout and partition your harddrive but after 2-3 seconds
  after beginning of copying installation files the graphical console
  screen turns to black and 1 CPU core on the host raises to 100%
  permanently and nothing happens. But if you installed Windows 7 before
  - there is no problems with VM. Tested on GTK, SDL types of screen.

  Qemu was installed from official repo and also I tried with built by
  myself version. Other OSes: Windows 8, 8.1, 10, Arch Linux, Debian,
  FreeBSD installed successfully.

  It happens only in OVMF-mode. I've just tested BIOS mode with no
  problems.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1723731/+subscriptions
