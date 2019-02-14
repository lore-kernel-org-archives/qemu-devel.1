Received: from eggs.gnu.org ([209.51.188.92]:45811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gu6dt-0007cq-Ie
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gu6di-0004x2-PU
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:20:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:40740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gu6di-0004vb-IG
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:20:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gu6dg-0006vZ-Nn
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 02:20:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B12702E8037
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 02:20:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Feb 2019 02:15:19 -0000
From: Palmer Dabbelt <palmer@dabbelt.com>
Reply-To: Bug 1815078 <1815078@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154955529480.22127.1382747582342462477.malonedeb@chaenomeles.canonical.com>
Message-Id: <155011051975.28410.6754389822057678818.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815078] Re: Qemu 3.1.0 risc-v mie.MEIE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

LMK if that patch doesn't fix your issue.  QEMU master is pretty stable
for RISC-V right now and since there's a handful of intertwined patches
the best bet is probably just to use the commit hash above.

This should be fixed in the 4.0 release, which is targeted for the
middle of April.

** Changed in: qemu
     Assignee: (unassigned) =3D> Palmer Dabbelt (palmerdabbelt)

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815078

Title:
  Qemu 3.1.0 risc-v mie.MEIE

Status in QEMU:
  Fix Committed

Bug description:
  Hello all,

  There is a bug in qemu for Risc-v, related to the mie register: when
  we try to set the MEIE bit (11) nothing is done, even when we are
  running at machine mode.

  Li   a0 , 1 << 11
  Csrs mie , a0

  And when we read mie it is as though nothing was done.

  Going through the qemu source code I was able to correct it: on file
  op_helper.c, line 94, the variable all_ints should be initialized
  with:

  uint64_t all_ints =3D delegable_ints | MIP_MSIP | MIP_MTIP | MIP_MEIP;

  That is, the MIP_MEIP was missing.

  I've successfully triggered uart interrupts with this patch (virt
  machine).

  All the best,
  Pharos team

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815078/+subscriptions
