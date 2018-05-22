Received: from eggs.gnu.org ([2001:4830:134:3::10]:38003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fL7uD-0004BC-5B
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fL7uA-0005LR-57
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:04:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:46782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fL7uA-0005Ky-0M
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:04:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fL7u8-00079V-C7
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 14:04:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2DA322E8F52
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 13:55:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 May 2018 13:44:52 -0000
From: Thomas Huth <1101210@bugs.launchpad.net>
Reply-To: Bug 1101210 <1101210@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130118141238.13697.51258.malonedeb@chaenomeles.canonical.com>
Message-Id: <152699669274.8113.12849501114281782768.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1101210] Re: qemu 1.4.2: usb keyboard not fully
 working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: Confirmed =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1101210

Title:
  qemu 1.4.2: usb keyboard not fully working

Status in QEMU:
  Incomplete

Bug description:
  When using the usb keyboard, I can't type the | character. I'm using
  german keyboard layout (de) on the host and inside the guest. As a
  guest OS, I use Linux (e.g. a recent KNOPPIX cd). To obtain the |
  character on a german keyboard, I need to press AltGr + the < or >
  key, i.e. the key right to the left shift.

  The qemu command line is something like this:
  ./qemu-system-i386 -device pci-ohci -device usb-kbd
  I also tried
  ./qemu-system-i386 -usb -usbdevice keyboard
  with the same effect.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1101210/+subscriptions
