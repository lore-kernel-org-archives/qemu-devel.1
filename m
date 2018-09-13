Received: from eggs.gnu.org ([2001:4830:134:3::10]:35479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g0KlR-0002BZ-JK
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g0KlM-0004aF-AT
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:06:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:60112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1g0KlM-0004Zh-41
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:06:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1g0KlL-0006U9-08
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 06:05:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EFA1A2E8019
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 06:05:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Sep 2018 05:55:11 -0000
From: Thomas Huth <588691@bugs.launchpad.net>
Reply-To: Bug 588691 <588691@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100602124923.430.9797.malonedeb@wampee.canonical.com>
Message-Id: <153681811121.31735.17526308871746872894.malone@soybean.canonical.com>
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

OK, thanks for the confirmation, John, so seems like this bug has been
fixed in the past and we can close it now.

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/588691

Title:
  QEMU is not correctly detecting host CDs

Status in QEMU:
  Fix Released

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
