Received: from eggs.gnu.org ([2001:4830:134:3::10]:40039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fziRO-0006Ep-Lj
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fziRL-0001SZ-Gg
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:10:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:38810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fziRL-0001S3-9a
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:10:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fziRJ-0004XS-V2
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 13:10:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E2B5D2E805B
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 13:10:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Sep 2018 13:00:24 -0000
From: Florian Kaiser <1791947@bugs.launchpad.net>
Reply-To: Bug 1791947 <1791947@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153667023142.28323.15936320266422135285.malonedeb@wampee.canonical.com>
Message-Id: <153667082519.32162.16370828987952141221.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1791947] Re: isochronous usb device forwarding
 with windows 10 and xhci freezes
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

- When I try to forward isochronous usb devices (webcam, HID-Audio) into th=
e VM the devices work for a few minutes then the device stops working and s=
tays that way until a VM reboot or a windows driver reload.
+ When I try to forward isochronous usb devices (webcam, HID-Audio) via usb=
redir into the VM, the devices work for a few minutes then the device stops=
 working and stays that way until a VM reboot or a windows driver reload.
  It does not matter if I use qemu-xhci or nec-xhci.
  I can gather more information, if its helpful!
  =

  Windows build:
  windows 10 pro 1803 jun 2018
  =

+ Linux Version:
+ Fedora 28
+ $ uname -a
+ Linux 4.17.19-200.fc28.x86_64 #1 SMP Fri Aug 24 15:47:41 UTC 2018 x86_64 =
x86_64 x86_64 GNU/Linux
+ =

+ Qemu Version:
+ $ qemu-system-x86_64 -version
+ QEMU emulator version 2.11.2(qemu-2.11.2-2.fc28)
+ Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
+ =

  Qemu command line:
  /usr/bin/qemu-system-x86_64 -machine accel=3Dkvm -name guest=3Dwin10,debu=
g-threads=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/l=
ib/libvirt/qemu/domain-1-win10/master-key.aes -machine pc-q35-2.11,accel=3D=
kvm,usb=3Doff,vmport=3Doff,dump-guest-core=3Doff -cpu Skylake-Client-IBRS,s=
s=3Don,hypervisor=3Don,tsc_adjust=3Don,clflushopt=3Don,ssbd=3Don,xsaves=3Do=
n,pdpe1gb=3Don,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff -m 8192 -r=
ealtime mlock=3Doff -smp 4,sockets=3D4,cores=3D1,threads=3D1 -uuid 38b1258e=
-fea4-41fe-9e21-07c426c5b2b2 -no-user-config -nodefaults -chardev socket,id=
=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-1-win10/monitor.sock,ser=
ver,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=
=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-h=
pet -no-shutdown -global ICH9-LPC.disable_s3=3D1 -global ICH9-LPC.disable_s=
4=3D1 -boot strict=3Don -device i82801b11-bridge,id=3Dpci.1,bus=3Dpcie.0,ad=
dr=3D0x1e -device pci-bridge,chassis_nr=3D2,id=3Dpci.2,bus=3Dpci.1,addr=3D0=
x0 -device pcie-root-port,port=3D0x10,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,m=
ultifunction=3Don,addr=3D0x2 -device pcie-root-port,port=3D0x11,chassis=3D4=
,id=3Dpci.4,bus=3Dpcie.0,addr=3D0x2.0x1 -device pcie-root-port,port=3D0x12,=
chassis=3D5,id=3Dpci.5,bus=3Dpcie.0,addr=3D0x2.0x2 -device pcie-root-port,p=
ort=3D0x13,chassis=3D6,id=3Dpci.6,bus=3Dpcie.0,addr=3D0x2.0x3 -device qemu-=
xhci,id=3Dusb,bus=3Dpci.3,addr=3D0x0 -device virtio-serial-pci,id=3Dvirtio-=
serial0,bus=3Dpci.4,addr=3D0x0 -drive file=3D/var/lib/libvirt/images/win10.=
qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-sata0-0-0 -device ide-hd,bus=3Did=
e.0,drive=3Ddrive-sata0-0-0,id=3Dsata0-0-0,bootindex=3D1 -drive file=3D/var=
/lib/libvirt/images/en_windows_10_multiple_editions_version_1803_jun_2018.i=
so,format=3Draw,if=3Dnone,id=3Ddrive-sata0-0-1,media=3Dcdrom,readonly=3Don =
-device ide-cd,bus=3Dide.1,drive=3Ddrive-sata0-0-1,id=3Dsata0-0-1 -netdev t=
ap,fd=3D25,id=3Dhostnet0 -device e1000,netdev=3Dhostnet0,id=3Dnet0,mac=3D52=
:54:00:ab:33:11,bus=3Dpci.2,addr=3D0x1 -chardev pty,id=3Dcharserial0 -devic=
e isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev spicevmc,id=3Dchar=
channel0,name=3Dvdagent -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D=
1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.spice.0 -device us=
b-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -spice port=3D5900,addr=3D127.0.0=
.1,disable-ticketing,image-compression=3Doff,seamless-migration=3Don -devic=
e qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_=
mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpcie.0,addr=3D0x1 -chardev spic=
evmc,id=3Dcharredir0,name=3Dusbredir -device usb-redir,chardev=3Dcharredir0=
,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev spicevmc,id=3Dcharredir1,name=3D=
usbredir -device usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,por=
t=3D3 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.5,addr=3D0x0 -msg =
timestamp=3Don
  =

  Cheers,
  Florian

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1791947

Title:
  isochronous usb device forwarding with windows 10 and xhci freezes

Status in QEMU:
  New

Bug description:
  When I try to forward isochronous usb devices (webcam, HID-Audio) via usb=
redir into the VM, the devices work for a few minutes then the device stops=
 working and stays that way until a VM reboot or a windows driver reload.
  It does not matter if I use qemu-xhci or nec-xhci.
  I can gather more information, if its helpful!

  Windows build:
  windows 10 pro 1803 jun 2018

  Linux Version:
  Fedora 28
  $ uname -a
  Linux 4.17.19-200.fc28.x86_64 #1 SMP Fri Aug 24 15:47:41 UTC 2018 x86_64 =
x86_64 x86_64 GNU/Linux

  Qemu Version:
  $ qemu-system-x86_64 -version
  QEMU emulator version 2.11.2(qemu-2.11.2-2.fc28)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  Qemu command line:
  /usr/bin/qemu-system-x86_64 -machine accel=3Dkvm -name guest=3Dwin10,debu=
g-threads=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/l=
ib/libvirt/qemu/domain-1-win10/master-key.aes -machine pc-q35-2.11,accel=3D=
kvm,usb=3Doff,vmport=3Doff,dump-guest-core=3Doff -cpu Skylake-Client-IBRS,s=
s=3Don,hypervisor=3Don,tsc_adjust=3Don,clflushopt=3Don,ssbd=3Don,xsaves=3Do=
n,pdpe1gb=3Don,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff -m 8192 -r=
ealtime mlock=3Doff -smp 4,sockets=3D4,cores=3D1,threads=3D1 -uuid 38b1258e=
-fea4-41fe-9e21-07c426c5b2b2 -no-user-config -nodefaults -chardev socket,id=
=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-1-win10/monitor.sock,ser=
ver,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=
=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-h=
pet -no-shutdown -global ICH9-LPC.disable_s3=3D1 -global ICH9-LPC.disable_s=
4=3D1 -boot strict=3Don -device i82801b11-bridge,id=3Dpci.1,bus=3Dpcie.0,ad=
dr=3D0x1e -device pci-bridge,chassis_nr=3D2,id=3Dpci.2,bus=3Dpci.1,addr=3D0=
x0 -device pcie-root-port,port=3D0x10,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,m=
ultifunction=3Don,addr=3D0x2 -device pcie-root-port,port=3D0x11,chassis=3D4=
,id=3Dpci.4,bus=3Dpcie.0,addr=3D0x2.0x1 -device pcie-root-port,port=3D0x12,=
chassis=3D5,id=3Dpci.5,bus=3Dpcie.0,addr=3D0x2.0x2 -device pcie-root-port,p=
ort=3D0x13,chassis=3D6,id=3Dpci.6,bus=3Dpcie.0,addr=3D0x2.0x3 -device qemu-=
xhci,id=3Dusb,bus=3Dpci.3,addr=3D0x0 -device virtio-serial-pci,id=3Dvirtio-=
serial0,bus=3Dpci.4,addr=3D0x0 -drive file=3D/var/lib/libvirt/images/win10.=
qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-sata0-0-0 -device ide-hd,bus=3Did=
e.0,drive=3Ddrive-sata0-0-0,id=3Dsata0-0-0,bootindex=3D1 -drive file=3D/var=
/lib/libvirt/images/en_windows_10_multiple_editions_version_1803_jun_2018.i=
so,format=3Draw,if=3Dnone,id=3Ddrive-sata0-0-1,media=3Dcdrom,readonly=3Don =
-device ide-cd,bus=3Dide.1,drive=3Ddrive-sata0-0-1,id=3Dsata0-0-1 -netdev t=
ap,fd=3D25,id=3Dhostnet0 -device e1000,netdev=3Dhostnet0,id=3Dnet0,mac=3D52=
:54:00:ab:33:11,bus=3Dpci.2,addr=3D0x1 -chardev pty,id=3Dcharserial0 -devic=
e isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev spicevmc,id=3Dchar=
channel0,name=3Dvdagent -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D=
1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.spice.0 -device us=
b-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -spice port=3D5900,addr=3D127.0.0=
.1,disable-ticketing,image-compression=3Doff,seamless-migration=3Don -devic=
e qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_=
mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpcie.0,addr=3D0x1 -chardev spic=
evmc,id=3Dcharredir0,name=3Dusbredir -device usb-redir,chardev=3Dcharredir0=
,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev spicevmc,id=3Dcharredir1,name=3D=
usbredir -device usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,por=
t=3D3 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.5,addr=3D0x0 -msg =
timestamp=3Don

  Cheers,
  Florian

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1791947/+subscriptions
