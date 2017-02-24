Received: from eggs.gnu.org ([2001:4830:134:3::10]:33737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1chF5N-0008Ox-Uy
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1chF5K-0007L6-Sb
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:34:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:41178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1chF5K-0007Jr-Ml
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:34:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1chF5J-0000zM-BC
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 12:34:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 521052E80CD
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 12:34:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Feb 2017 12:21:52 -0000
From: Martin Husemann <martin@NetBSD.org>
Reply-To: Bug 1014099 <1014099@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120616165038.8986.77631.malonedeb@gac.canonical.com>
Message-Id: <20170224122152.5013.90483.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1014099] Re: hw/esp.c does not properly deal with
 TEST_UNIT_READY in NetBSD/sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Yes. Just to make sure I tested qemu 2.8 against an old disk image from
2012 and it boots fine w/o any  complaints during the device probes.

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1014099

Title:
  hw/esp.c does not properly deal with TEST_UNIT_READY in NetBSD/sparc

Status in QEMU:
  Fix Released

Bug description:
  The NetBSD ncr53c9x.c driver does a TEST_UNIT_READY command with
  SELATN but dma disabled sometimes (early during bus enumeration). This
  is fine, as the command will not produce nor consume any data, and
  works on real hardware.

  However, the qemu emulation does not allow this (for reasons I don't
  understand).

  The change below fixes the problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1014099/+subscriptions
