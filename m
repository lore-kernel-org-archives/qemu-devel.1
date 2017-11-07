Received: from eggs.gnu.org ([2001:4830:134:3::10]:36320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBvX3-0005c0-U5
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 23:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBvX1-0005xV-U6
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 23:30:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:52362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBvX1-0005vw-Of
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 23:30:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBvX0-0000ND-TQ
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 04:30:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DCE202E80C3
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 04:30:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 04:17:32 -0000
From: Launchpad Bug Tracker <1326986@bugs.launchpad.net>
Reply-To: Bug 1326986 <1326986@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140605222643.4583.85001.malonedeb@soybean.canonical.com>
Message-Id: <151002825308.21207.2692112706867902819.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1326986] Re: e1000 - no link detected by VXWorks
 based guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1326986

Title:
  e1000 - no link detected by VXWorks based guest

Status in QEMU:
  Expired

Bug description:
  I'm trying to get a VXWorks image running inside a qemu guest.  I have
  the machine running, however, the vxworks image only has support for
  the 82544EI device so I had to change the device ID in e1000.c to get
  the device even recognized so I'm not sure if this is a bug or an
  issue for the development list.

  =

  After changing e1000.c, the device is now seen by the guest OS, however, =
it never gets a link.  I've attached the e1000 debug logs in the hopes that=
 someone can help me understand where to start looking into why this guest =
won't get a link.

  I tested the updated e1000 driver with a debian live CD and the card
  works under it, so it doesn't appear that the issue is with the driver
  string change but rather something in the e1000 driver itself.

  Here is the command I'm using to start QEMU:

  /opt/qemu/bin/qemu-system-i386  -cpu coreduo -hda /root/vxworks_test
  -m 2048 -netdev tap,ifname=3Dtap0,id=3Dnet0 -netdev
  tap,ifname=3Dtap1,id=3Dnet1 -device
  e1000,netdev=3Dnet0,mac=3D00:00:e8:01:02:03 -device
  e1000,netdev=3Dnet1,mac=3D00:00:e8:01:02:04 -boot c -curses -no-kvm -D
  /tmp/qemu.log 2>/tmp/e1000.log

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1326986/+subscriptions
