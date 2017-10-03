Received: from eggs.gnu.org ([2001:4830:134:3::10]:34945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzK5f-0004zD-UL
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzK5b-00052Y-Sg
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:06:15 -0400
Received: from indium.canonical.com ([91.189.90.7]:47464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dzK5b-00051s-Ld
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:06:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dzK5a-0006SI-1I
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 10:06:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 07D9F2E80D0
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 10:06:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Oct 2017 09:54:52 -0000
From: Thomas Huth <1660035@bugs.launchpad.net>
Reply-To: Bug 1660035 <1660035@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170128131607.26951.44105.malonedeb@wampee.canonical.com>
Message-Id: <150702449222.21028.14118892942425383580.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1660035] Re: hw/timer/altera_timer.c:207: bad
 size in memset ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This problem should have been fixed with QEMU v2.10.0:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dcc16ee9d4ecec35ea04e

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1660035

Title:
  hw/timer/altera_timer.c:207: bad size in memset ?

Status in QEMU:
  Fix Released

Bug description:
  hw/timer/altera_timer.c:207:5: warning: =E2=80=98memset=E2=80=99 used wit=
h length
  equal to number of elements without multiplication by element size
  [-Wmemset-elt-size]

  Source code is

       memset(t->regs, 0, ARRAY_SIZE(t->regs));

  Maybe better code

       memset(t->regs, 0, R_MAX * sizeof( uint32_t));

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1660035/+subscriptions
