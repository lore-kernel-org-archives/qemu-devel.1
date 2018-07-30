Received: from eggs.gnu.org ([2001:4830:134:3::10]:60304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fjzpP-0005dl-QG
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 00:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fjzpM-00063s-Hh
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 00:30:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:56698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fjzpM-00063U-BV
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 00:30:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fjzpK-0006AS-RW
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 04:30:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C7BD32E8042
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 04:30:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Jul 2018 04:17:37 -0000
From: Launchpad Bug Tracker <685096@bugs.launchpad.net>
Reply-To: Bug 685096 <685096@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101204070046.21747.93608.malonedeb@gandwana.canonical.com>
Message-Id: <153292425794.28894.7907808752095296162.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 685096] Re: USB Passthrough not working for
 Windows 7 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for qemu (Ubuntu) because there has been no activity for 60
days.]

** Changed in: qemu (Ubuntu)
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/685096

Title:
  USB Passthrough not working for Windows 7 guest

Status in QEMU:
  Won't Fix
Status in qemu package in Ubuntu:
  Expired
Status in qemu package in Debian:
  Incomplete

Bug description:
  USB Passthrough from host to guest is not working for a 32-bit Windows
  7 guest, while it works perfectly for a 32-bit Windows XP guest.

  The device appears in the device manager of Windows 7, but with "Error
  code 10: device cannot start". I have tried this with numerous USB
  thumbdrives and a USB wireless NIC, all with the same result. The
  device name and functionality is recognized, so at least some USB
  negotiation is taking place.

  I am trying this with the latest git-pull of QEMU-KVM.

  The command line to launch qemu-kvm for win7 is:
  sudo /home/user/local_install/bin/qemu-system-x86_64 -cpu core2duo -m 102=
4 -smp 2 -vga std -hda ./disk_images/win7.qcow -vnc :1 -boot c -usb -usbdev=
ice tablet -usbdevice host:0781:5150

  The command line to launch qemu-kvm for winxp is:
  sudo /home/user/local_install/bin/qemu-system-x86_64 -cpu core2duo -m 102=
4 -smp 2 -usb -vga std -hda ./winxpsp3.qcow -vnc :0 -boot c -usbdevice tabl=
et -usbdevice host:0781:5150

  Any help is appreciated.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/685096/+subscriptions
