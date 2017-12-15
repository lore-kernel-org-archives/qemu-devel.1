Received: from eggs.gnu.org ([2001:4830:134:3::10]:40447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsi1-0003ez-2z
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePshz-0008R7-PR
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:19:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:53756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePshz-0008Q3-IL
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:19:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePshy-0004j8-Kj
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:19:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 99A902E80D1
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:19:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 16:07:57 -0000
From: Thomas Huth <1180924@bugs.launchpad.net>
Reply-To: Bug 1180924 <1180924@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130516173517.573.9514.malonedeb@soybean.canonical.com>
Message-Id: <151335407789.16825.2822385184415176207.launchpad@soybean.canonical.com>
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

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1180924

Title:
  fails to handle a usb serial port with a specific vendorid

Status in QEMU:
  Fix Released

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
