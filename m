Received: from eggs.gnu.org ([2001:4830:134:3::10]:50486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUW2-0003Vj-CN
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUW1-0000Vn-5G
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:05:30 -0400
Received: from indium.canonical.com ([91.189.90.7]:43259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwUW0-0000VA-VR
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:05:29 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwUVz-0003OZ-2C
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 14:05:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0C6B52E80C3
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 14:05:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 13:52:30 -0000
From: Thomas Huth <1077708@bugs.launchpad.net>
Reply-To: Bug 1077708 <1077708@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121111202941.16575.73601.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170407135230.31374.90881.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1077708] Re: Video capture from webcam with USB
 passthrough freezes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this issue with the
latest version of QEMU (version 2.9)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1077708

Title:
  Video capture from webcam with USB passthrough freezes

Status in QEMU:
  Incomplete

Bug description:
  QEMU version: 1.2.0
  Graphics: Spice
  Guest: Windows 7 32-bit
  Host: Ubuntu 12.10 amd64 (using distro package qemu-kvm-spice)

  I am using USB 2.0 passthrough of a Logitech C920 webcam. The guest is
  running the proprietary Logitech drivers. When video chatting with
  either Google+ Hangouts or Skype 3.8.0.115, video capture from the
  webcam is initially fine but eventually freezes. It remains frozen for
  up to several minutes and then resumes on its own. The process then
  repeats. Audio recorded from the webcam's mic works continuously.

  The problem also affects video recording in Logitech's bundled
  software. Strangely though, the live preview is _not_ affected. The
  freezing is only present in the recorded video file.

  I can tell that the problem is not introduced by Spice during
  playback, because the user on the other end of Hangouts/Skype sees the
  same problem, and the freezes in a recorded video file are seen at the
  same point every time the file is played.

  Command line:

  /usr/bin/kvm-spice -name Windows7 -S -M pc-1.0 -enable-kvm -m 2048
  -smp 3,sockets=3D3,cores=3D1,threads=3D1 -uuid
  cfcc7e85-7873-1c32-0a00-d1c35f3eb073 -no-user-config -nodefaults
  -chardev
  socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/Windows7.monitor,ser=
ver,nowait
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dlocalt=
ime
  -no-shutdown -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x6.0x7
  -device ich9-usb-
  uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=
=3D0x6
  -device ich9-usb-
  uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=3D0x6.0x1 -device =
ich9
  -usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=3D0x6.0x2 -dr=
ive
  file=3D/data/libvirt/images/Windows7.img,if=3Dnone,id=3Ddrive-
  ide0-0-0,format=3Draw -device ide-hd,bus=3Dide.0,unit=3D0,drive=3Ddrive-
  ide0-0-0,id=3Dide0-0-0,bootindex=3D1 -drive if=3Dnone,id=3Ddrive-
  ide0-1-0,readonly=3Don,format=3Draw -device ide-cd,bus=3Dide.1,unit=3D0,d=
rive
  =3Ddrive-ide0-1-0,id=3Dide0-1-0 -netdev tap,fd=3D21,id=3Dhostnet0 -device
  rtl8139,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:7e:0b:d9,bus=3Dpci.0,a=
ddr=3D0x3
  -chardev pty,id=3Dcharserial0 -device isa-
  serial,chardev=3Dcharserial0,id=3Dserial0 -device usb-tablet,id=3Dinput0
  -spice port=3D5900,addr=3D127.0.0.1,disable-ticketing -vga std -device
  intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -device hda-
  duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -device usb-
  host,hostbus=3D2,hostaddr=3D8,id=3Dhostdev0 -device virtio-balloon-
  pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1077708/+subscriptions
