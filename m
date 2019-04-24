Received: from eggs.gnu.org ([209.51.188.92]:57309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBGw-0008Gh-SV
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBGv-0000zB-AH
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:43908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJBGv-0000xC-3I
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJBGu-0007fT-Be
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 567B42E80C8
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 06:10:31 -0000
From: Thomas Huth <1815078@bugs.launchpad.net>
Reply-To: Bug 1815078 <1815078@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154955529480.22127.1382747582342462477.malonedeb@chaenomeles.canonical.com>
Message-Id: <155608623235.13778.2342619145028300095.launchpad@gac.canonical.com>
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

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815078

Title:
  Qemu 3.1.0 risc-v mie.MEIE

Status in QEMU:
  Fix Released

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
