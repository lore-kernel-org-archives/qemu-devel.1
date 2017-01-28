Received: from eggs.gnu.org ([2001:4830:134:3::10]:45973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cXT0j-0004Yf-4D
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 08:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cXT0f-00038U-Oa
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 08:25:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:37854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cXT0f-00037a-Gk
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 08:25:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cXT0d-00026q-2x
	for <qemu-devel@nongnu.org>; Sat, 28 Jan 2017 13:25:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0D1A12E80C7
	for <qemu-devel@nongnu.org>; Sat, 28 Jan 2017 13:25:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Jan 2017 13:16:07 -0000
From: dcb <1660035@bugs.launchpad.net>
Reply-To: Bug 1660035 <1660035@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170128131607.26951.44105.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1660035] [NEW] hw/timer/altera_timer.c:207: bad
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

Public bug reported:

hw/timer/altera_timer.c:207:5: warning: =E2=80=98memset=E2=80=99 used with =
length equal
to number of elements without multiplication by element size [-Wmemset-
elt-size]

Source code is

     memset(t->regs, 0, ARRAY_SIZE(t->regs));

Maybe better code

     memset(t->regs, 0, R_MAX * sizeof( uint32_t));

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1660035

Title:
  hw/timer/altera_timer.c:207: bad size in memset ?

Status in QEMU:
  New

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
