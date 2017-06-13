Received: from eggs.gnu.org ([2001:4830:134:3::10]:51625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKiB9-0002WU-65
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKiB5-0004xN-8H
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:32:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:37892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dKiB5-0004x8-3L
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:31:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dKiB2-0008Mu-Ml
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:31:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 653772E81D1
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:31:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2017 09:21:36 -0000
From: Colin Finck <mail@colinfinck.de>
Reply-To: Bug 1694808 <1694808@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149625981140.25356.9191241290348673100.malonedeb@soybean.canonical.com>
Message-Id: <149734569640.2288.835690437546096564.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1694808] Re: Passthrough USB Host Keyboard
 doesn't work on Q35 platform on boot-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Doesn't happen when adding another UHCI controller and explicitly
connecting the keyboard to it, like: -device vt82c686b-usb-uhci,id=3Dmyusb
-device usb-host,bus=3Dmyusb.0,hostbus=3D3,hostaddr=3D2

Is QEMU just incorrectly connecting my full-speed USB keyboard to USB 2.0 E=
HCI instead of USB 1.x UHCI?
Or is SeaBIOS lacking support for anything involving USB 2.0 controllers, e=
ven simple HID devices?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1694808

Title:
  Passthrough USB Host Keyboard doesn't work on Q35 platform on boot-up

Status in QEMU:
  New
Status in qemu-kvm package in Ubuntu:
  New

Bug description:
  Using qemu-kvm as shipped with Ubuntu 16.04, I cannot get a passed-
  through USB Host Keyboard to work at boot-up using the Q35 platform.

  My minimal example to verify this bug is the following:

    qemu-system-x86_64 -M q35 -m 128 -cdrom mini.iso -usb -usbdevice
  host:04ca:005a -vnc :1 -display none

  Using a noname USB Keyboard with ID 04ca:005a and the Ubuntu 16.04
  NetBoot mini.iso, I can see the boot screen of the Ubuntu ISO through
  VNC, but pressing the arrow keys doesn't do anything.

  By taking out the "-M q35" parameter, QEMU switches to the traditional
  i440FX system. The passed-through USB Host Keyboard works there, but
  the old platform is no option for me.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1694808/+subscriptions
