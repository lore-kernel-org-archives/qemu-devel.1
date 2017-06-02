Received: from eggs.gnu.org ([2001:4830:134:3::10]:56021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dGfo2-0004ly-3Z
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 02:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dGfnw-0004CO-V6
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 02:11:30 -0400
Received: from indium.canonical.com ([91.189.90.7]:34314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dGfnw-0004C5-P4
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 02:11:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dGfnv-0001dI-UH
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 06:11:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E172D2E8199
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 06:11:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Jun 2017 06:02:59 -0000
From: ChristianEhrhardt <1694808@bugs.launchpad.net>
Reply-To: Bug 1694808 <1694808@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149625981140.25356.9191241290348673100.malonedeb@soybean.canonical.com>
Message-Id: <149638337962.24782.5922810078863937613.malone@soybean.canonical.com>
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

Thanks Thomas, definitely worth to check.
@Colin - if you want a quick and easy short with qemu 2.8 you can try  [1].

[1]: https://wiki.ubuntu.com/OpenStack/CloudArchive

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1694808

Title:
  Passthrough USB Host Keyboard doesn't work on Q35 platform on boot-up

Status in QEMU:
  Incomplete
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
