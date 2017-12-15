Received: from eggs.gnu.org ([2001:4830:134:3::10]:58565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePk02-00010w-1x
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 02:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePjzx-0001se-42
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 02:01:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:44364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePjzw-0001qW-U8
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 02:01:33 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePjzs-0006bo-KC
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 07:01:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1A98C2E80CB
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 07:01:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 06:45:45 -0000
From: Michal Nowak <mnowak@startmail.com>
Reply-To: Bug 1738283 <1738283@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151328724563.26325.11755910452939969450.malonedeb@wampee.canonical.com>
Message-Id: <151332034562.11277.1553141599212676664.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1738283] Re: 'Less than' (<), 'more than' (>),
 and 'pipe' (|) can't be typed via VNC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Should have mention I use openSUSE Leap 42.3 with above mentioned
virtualization repo.

Removed the 0026-Fix-tigervnc-long-press-issue patch and rebuilt QEMU
but no change.

But I noticed that if I run the ISO via libvirt and connect to it via
virt-manager (virt-manager-1.4.1-4.1.noarch), the keys are there as
expected:

/usr/bin/qemu-system-x86_64 -machine accel=3Dkvm -name guest=3DOI,debug-
threads=3Don -S -object
secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-2-OI
/master-key.aes -machine pc-i440fx-2.11,accel=3Dkvm,usb=3Doff,vmport=3Doff
,dump-guest-core=3Doff -cpu kvm64 -m 2048 -realtime mlock=3Doff -smp
1,sockets=3D1,cores=3D1,threads=3D1 -uuid 5664149e-26ad-4ee8-8170-16701f107=
b4b
-no-user-config -nodefaults -chardev
socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-2-OI/monitor.so=
ck,server,nowait
-mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
base=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -=
no-
hpet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global
PIIX4_PM.disable_s4=3D1 -boot strict=3Don -device ich9-usb-
ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x3.0x7 -device ich9-usb-
uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=
=3D0x3
-device ich9-usb-
uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=3D0x3.0x1 -device ic=
h9
-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=3D0x3.0x2 -drive
file=3D/var/lib/libvirt/images/OI-hipster-
minimal-20171031.iso,format=3Draw,if=3Dnone,id=3Ddrive-ide0-0-0,readonly=3D=
on
-device ide-cd,bus=3Dide.0,unit=3D0,drive=3Ddrive-
ide0-0-0,id=3Dide0-0-0,bootindex=3D1 -vnc 127.0.0.1:0 -device
VGA,id=3Dvideo0,vgamem_mb=3D16,bus=3Dpci.0,addr=3D0x2 -device virtio-balloo=
n-
pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x4 -msg timestamp=3Don

Connection via TigerVNC (tigervnc-1.6.0-21.1.x86_64) to the same VM is
unable to write those characters.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1738283

Title:
  'Less than' (<), 'more than' (>), and 'pipe' (|) can't be typed via
  VNC

Status in QEMU:
  New

Bug description:
  If I start QEMU 2.11 (from
  https://build.opensuse.org/package/show/Virtualization/qemu) VM with
  VNC, I am unable to type following three characters: 'less than' (<),
  'more than' (>), and 'pipe' (|) on en_US QWERTY keyboard. Other
  characters work fine. QEMu version 2.10.1 worked fine.

  /usr/bin/qemu-kvm -m 2048 -cpu kvm64 -drive
  media=3Dcdrom,if=3Dnone,id=3Dcd0,format=3Draw,file=3DOI-hipster-
  minimal-20171031.iso -device ide-cd,drive=3Dcd0 -boot once=3Dd,menu=3Don
  ,splash-time=3D5000 -device usb-ehci -device usb-tablet -smp 1 -enable-
  kvm -vnc :91,share=3Dforce-shared

  The ISO can be downloaded here: https://www.openindiana.org/download/

  Also tried Fedora-Server-dvd-x86_64-25-1.3.iso and it's the same
  situation.

  If I run the same command without '-vnc :91,share=3Dforce-shared',
  everything works just fine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1738283/+subscriptions
