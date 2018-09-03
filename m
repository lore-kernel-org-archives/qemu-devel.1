Received: from eggs.gnu.org ([2001:4830:134:3::10]:37803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fwsgT-0000kZ-NP
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fwsgQ-0003lm-L0
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:30:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:36830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fwsgQ-0003lR-E0
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:30:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fwsgP-00078m-CZ
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 17:30:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3DB422E802D
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 17:30:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Sep 2018 17:19:25 -0000
From: John Arbuckle <programmingkidx@gmail.com>
Reply-To: Bug 588691 <588691@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100602124923.430.9797.malonedeb@wampee.canonical.com>
Message-Id: <153599516529.24459.5906846555366828127.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 588691] Re: QEMU is not correctly detecting host
 CDs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I use real CD-ROM disc in Mac OS and Windows guests on my Mac OS 10.12
host. I have to run QEMU in root mode using the sudo command in order to
access the CD-ROM drive. So I know QEMU's support for using real optical
media on Mac OS hosts does work.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/588691

Title:
  QEMU is not correctly detecting host CDs

Status in QEMU:
  Incomplete

Bug description:
  QEMU's block layer contains code for detecting and using ioctls when
  real CD-ROM host devices are attached.

  This detection is not working in some host OSes while bad implemented
  on anothers.

  E.g., in Linux host qemu -cdrom /dev/sr0 is not detecting it as a CD-ROM
  E.g., in Mac OS X host qemu asks the kernel to enumerate optical devices =
and the compares it to the constant string "/dev/cdrom". This is useless, t=
hat enumeration is just enough, and "/dev/cdrom" will NEVER exist in Mac OS=
 X unless manually created by the user.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/588691/+subscriptions
