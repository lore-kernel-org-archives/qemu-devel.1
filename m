Received: from eggs.gnu.org ([209.51.188.92]:39639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gmfiP-0002HW-CI
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gmfiM-0004QF-VF
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:10:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:36990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gmfiM-0004OM-Pk
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:10:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gmfiK-0001LC-Rn
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:10:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C7FCD2E8033
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:10:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Jan 2019 13:59:44 -0000
From: Thomas <1813165@bugs.launchpad.net>
Reply-To: Bug 1813165 <1813165@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154833838504.19548.14915901097039330455.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813165] [NEW] KVM internal error. Suberror: 1
 emulation failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Hello Devs.

Having problems getting VM to run with qemu 3.1.0.

2019-01-24 13:46:08.648+0000: starting up libvirt version: 4.10.0, qemu ver=
sion: 3.1.0, kernel: 4.14.94, hostname: one....
LC_ALL=3DC PATH=3D/bin:/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/bin:/usr/sb=
in:/usr/local/bin:/usr/local/sbin:/opt/bin HOME=3D/root USER=3Droot QEMU_AU=
DIO_DRV=3Dnone /usr/bin/kvm -name guest=3Done-266,debug-threads=3Don -S -ob=
ject secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domai=
n-1-one-266/master-key.aes -machine pc-i440fx-2.9,accel=3Dkvm,usb=3Doff,dum=
p-guest-core=3Doff -cpu Skylake-Client-IBRS,ss=3Don,hypervisor=3Don,tsc_adj=
ust=3Don,clflushopt=3Don,ssbd=3Don,xsaves=3Don,pdpe1gb=3Don -m 1024 -realti=
me mlock=3Doff -smp 2,sockets=3D2,cores=3D1,threads=3D1 -uuid b219b45d-a2f0=
-4128-a948-8673a7abf968 -no-user-config -nodefaults -chardev socket,id=3Dch=
armonitor,fd=3D21,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mod=
e=3Dcontrol -rtc base=3Dutc -no-shutdown -boot strict=3Don -device piix3-us=
b-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive file=3D/var/lib/one//data=
stores/0/266/disk.0,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0,cache=
=3Dnone -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Ddr=
ive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1,write-cache=3Don -drive fi=
le=3D/var/lib/one//datastores/0/266/disk.1,format=3Draw,if=3Dnone,id=3Ddriv=
e-ide0-0-0,readonly=3Don -device ide-cd,bus=3Dide.0,unit=3D0,drive=3Ddrive-=
ide0-0-0,id=3Dide0-0-0 -netdev tap,fd=3D23,id=3Dhostnet0 -device rtl8139,ne=
tdev=3Dhostnet0,id=3Dnet0,mac=3D02:00:00:76:69:85,bus=3Dpci.0,addr=3D0x3 -c=
hardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,id=3Ds=
erial0 -vnc 0.0.0.0:266 -device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0=
x2 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5 -sandbox=
 on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=
=3Ddeny -msg timestamp=3Don
char device redirected to /dev/pts/1 (label charserial0)
KVM internal error. Suberror: 1
emulation failure
EAX=3D00000001 EBX=3D000f7c2c ECX=3D00000001 EDX=3D00000001
ESI=3D00006a26 EDI=3D3ffbdc48 EBP=3D000069e6 ESP=3D000a8000
EIP=3D000fd057 EFL=3D00010016 [----AP-] CPL=3D0 II=3D0 A20=3D1 SMM=3D1 HLT=
=3D0
ES =3D0010 00000000 ffffffff 00c09300
CS =3D0000 00000000 00000fff 00809b00
SS =3D0010 00000000 ffffffff 00c09300
DS =3D0010 00000000 ffffffff 00c09300
FS =3D0010 00000000 ffffffff 00c09300
GS =3D0010 00000000 ffffffff 00c09300
LDT=3D0000 00000000 0000ffff 00008200
TR =3D0000 00000000 0000ffff 00008b00
GDT=3D     10387cfe 0000fe6c
IDT=3D     0010387c 00003810
CR0=3D00000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=3D=
0000000000000000
DR6=3D00000000fffecffc DR7=3D000000000e1e0400
EFER=3D0000000000000000
Code=3Dcb 66 ba 4d d0 0f 00 e9 c8 fe bc 00 80 0a 00 e8 31 3a ff ff <0f> aa =
fa fc 66 ba 66 d0 0f 00 e9 b1 fe f3 90 f0 0f ba 2d ac 3b 0f 00 00 72 f3 8b =
25 a8 3b
2019-01-24T13:47:39.383366Z kvm: terminating on signal 15 from pid 2708 (/u=
sr/sbin/libvirtd)

Someone has an idea whats going wrong here?

thanks and cheers
t.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813165

Title:
  KVM internal error. Suberror: 1 emulation failure

Status in QEMU:
  New

Bug description:
  Hello Devs.

  Having problems getting VM to run with qemu 3.1.0.

  2019-01-24 13:46:08.648+0000: starting up libvirt version: 4.10.0, qemu v=
ersion: 3.1.0, kernel: 4.14.94, hostname: one....
  LC_ALL=3DC PATH=3D/bin:/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/bin:/usr/=
sbin:/usr/local/bin:/usr/local/sbin:/opt/bin HOME=3D/root USER=3Droot QEMU_=
AUDIO_DRV=3Dnone /usr/bin/kvm -name guest=3Done-266,debug-threads=3Don -S -=
object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/dom=
ain-1-one-266/master-key.aes -machine pc-i440fx-2.9,accel=3Dkvm,usb=3Doff,d=
ump-guest-core=3Doff -cpu Skylake-Client-IBRS,ss=3Don,hypervisor=3Don,tsc_a=
djust=3Don,clflushopt=3Don,ssbd=3Don,xsaves=3Don,pdpe1gb=3Don -m 1024 -real=
time mlock=3Doff -smp 2,sockets=3D2,cores=3D1,threads=3D1 -uuid b219b45d-a2=
f0-4128-a948-8673a7abf968 -no-user-config -nodefaults -chardev socket,id=3D=
charmonitor,fd=3D21,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,m=
ode=3Dcontrol -rtc base=3Dutc -no-shutdown -boot strict=3Don -device piix3-=
usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive file=3D/var/lib/one//da=
tastores/0/266/disk.0,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0,cach=
e=3Dnone -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Dd=
rive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1,write-cache=3Don -drive f=
ile=3D/var/lib/one//datastores/0/266/disk.1,format=3Draw,if=3Dnone,id=3Ddri=
ve-ide0-0-0,readonly=3Don -device ide-cd,bus=3Dide.0,unit=3D0,drive=3Ddrive=
-ide0-0-0,id=3Dide0-0-0 -netdev tap,fd=3D23,id=3Dhostnet0 -device rtl8139,n=
etdev=3Dhostnet0,id=3Dnet0,mac=3D02:00:00:76:69:85,bus=3Dpci.0,addr=3D0x3 -=
chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,id=3D=
serial0 -vnc 0.0.0.0:266 -device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D=
0x2 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5 -sandbo=
x on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=
=3Ddeny -msg timestamp=3Don
  char device redirected to /dev/pts/1 (label charserial0)
  KVM internal error. Suberror: 1
  emulation failure
  EAX=3D00000001 EBX=3D000f7c2c ECX=3D00000001 EDX=3D00000001
  ESI=3D00006a26 EDI=3D3ffbdc48 EBP=3D000069e6 ESP=3D000a8000
  EIP=3D000fd057 EFL=3D00010016 [----AP-] CPL=3D0 II=3D0 A20=3D1 SMM=3D1 HL=
T=3D0
  ES =3D0010 00000000 ffffffff 00c09300
  CS =3D0000 00000000 00000fff 00809b00
  SS =3D0010 00000000 ffffffff 00c09300
  DS =3D0010 00000000 ffffffff 00c09300
  FS =3D0010 00000000 ffffffff 00c09300
  GS =3D0010 00000000 ffffffff 00c09300
  LDT=3D0000 00000000 0000ffff 00008200
  TR =3D0000 00000000 0000ffff 00008b00
  GDT=3D     10387cfe 0000fe6c
  IDT=3D     0010387c 00003810
  CR0=3D00000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000
  DR6=3D00000000fffecffc DR7=3D000000000e1e0400
  EFER=3D0000000000000000
  Code=3Dcb 66 ba 4d d0 0f 00 e9 c8 fe bc 00 80 0a 00 e8 31 3a ff ff <0f> a=
a fa fc 66 ba 66 d0 0f 00 e9 b1 fe f3 90 f0 0f ba 2d ac 3b 0f 00 00 72 f3 8=
b 25 a8 3b
  2019-01-24T13:47:39.383366Z kvm: terminating on signal 15 from pid 2708 (=
/usr/sbin/libvirtd)

  Someone has an idea whats going wrong here?

  thanks and cheers
  t.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813165/+subscriptions
