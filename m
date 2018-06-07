Received: from eggs.gnu.org ([2001:4830:134:3::10]:45151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fQsR2-0008No-In
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fQsQx-0008AF-Ia
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:46:28 -0400
Received: from indium.canonical.com ([91.189.90.7]:37806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fQsQx-00089k-C3
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:46:23 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fQsQw-000477-C1
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 10:46:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3BC522E88D2
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 10:46:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Jun 2018 10:26:24 -0000
From: Thomas Huth <1101210@bugs.launchpad.net>
Reply-To: Bug 1101210 <1101210@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130118141238.13697.51258.malonedeb@chaenomeles.canonical.com>
Message-Id: <152836718454.24946.7574429418222193777.malone@gac.canonical.com>
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

Looks like people report different issues here... if you report a
keyboard mapping problem, please try to either make sure that it matches
the bug, or open a new ticket.

So the original problem (with the < > | not working at all) seems to be
fixed nowadays, at least it works for me with a Linux guest running on a
Linux host.

But I'll leave this ticket opened for the Windows problems that have
been reported.

Jos=C3=A9, could you please add the information about your guest? Are you
running Linux or Windows in QEMU?

** Changed in: qemu
       Status: Incomplete =3D> New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1101210

Title:
  qemu 1.4.2: usb keyboard not fully working

Status in QEMU:
  New

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
