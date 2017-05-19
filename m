Received: from eggs.gnu.org ([2001:4830:134:3::10]:45581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBcDx-0005Rg-6X
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBcDu-0008S2-11
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:21:21 -0400
Received: from indium.canonical.com ([91.189.90.7]:45457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dBcDt-0008Ra-Rd
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:21:17 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dBcDr-0004O2-W8
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 07:21:16 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F1FF92E804A
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 07:21:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 May 2017 07:05:36 -0000
From: Thomas Huth <1180924@bugs.launchpad.net>
Reply-To: Bug 1180924 <1180924@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130516173517.573.9514.malonedeb@soybean.canonical.com>
Message-Id: <149517753644.11684.9985178704613136406.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1180924] Re: fails to handle a usb serial port
 with a specific vendorid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The crash has now been fixed here:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Daa612b364ecbe1dc
Please also note that the "-usbdevice serial" syntax is considered as depre=
cated nowadays - use "-device usb-serial" instead.

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1180924

Title:
  fails to handle a usb serial port with a specific vendorid

Status in QEMU:
  Fix Committed

Bug description:
  If I run qemu-system-i386 with arguments
  -usb -usbdevice serial:vendorid=3D1221:pty
  (this is what the documentation says about how I shoud add a usb device w=
hich has a serial port interface and which has a specific vendor id, I used=
 the documentation located here:
  http://qemu.weilnetz.de/qemu-doc.html
  ), it says =

  char device redirected to /dev/pts/<something> (label usbserial0)
  qemu-system-i386: -usbdevice serial:vendorid=3D1221:pty: Property '.vendo=
rid' not found
  Aborted
  and exits. Moreover, if I try to add such a device to a running machine b=
y typing usb_add serial:vendorid=3D1221:pty in the machine's control termin=
al (to reach it, I press ctrl-alt-2), qemu also writes =

  char device redirected to /dev/pts/<something> (label usbserial0)
  Aborted
  to the terminal where I run it from and exits. To the quest OS this looks=
 like a power failure which causes all the programs inside the virtual mach=
ine to lose their unsaved data.
  I have tested this with qemu-1.5.0-rc2, actually, the issue occured in a =
similar way since 1.0.1, but did not occur in 0.11.1.
  The issue is reproducible always, even if I don't specify any hard disk i=
n the command line, i. e.
  $ qemu-system-i386 -usb -usbdevice serial:vendorid=3D1221:pty
  , so I believe it is guest OS -independent.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1180924/+subscriptions
