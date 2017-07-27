Received: from eggs.gnu.org ([2001:4830:134:3::10]:44936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1daeGG-0001p7-Qk
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1daeGC-0002KE-Vy
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:35:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:36856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1daeGC-0002Ir-PX
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:35:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1daeGB-0002vr-Vp
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 08:35:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EBF222E80CC
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 08:35:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Jul 2017 08:22:12 -0000
From: Gerd Hoffmann <1096714@bugs.launchpad.net>
Reply-To: Bug 1096714 <1096714@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130107012337.1165.80927.malonedeb@gac.canonical.com>
Message-Id: <150114373233.31693.11556062340537331908.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1096714] Re: qemu 1.3.0: usb devices shouldn't
 have same vendor/product ID and same serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Try "-device usb-tablet,serial=3D1234"

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1096714

Title:
  qemu 1.3.0: usb devices shouldn't have same vendor/product ID and same
  serial

Status in QEMU:
  New

Bug description:
  Boot Windows XP with
  ./qemu-system-i386 -device pci-ohci -device usb-tablet
  and then with
  ./qemu-system-i386 -device pci-ohci -device usb-kbd

  and you will notice, that the usb keyboard is not detected. In fact,
  Windows XP detects the usb tablet and loads the driver for the tablet
  instead of the driver for the keyboard.

  The problem seems to be, that vendor and product ID and even the
  seriel of both the usb tablet and the usb keyboard are the same as an
  lsusb reveiles. Hence, Windows XP doesn't detect when you replace the
  tablet by a keyboard and vice versa. I didn't check other USB devices,
  but it seems a bad idea to me to have devices with the same
  vendor/product Id. I'm not aware, whether it is sufficient to change
  the seriel numbers of the devices.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1096714/+subscriptions
