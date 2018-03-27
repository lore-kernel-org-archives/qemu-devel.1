Received: from eggs.gnu.org ([2001:4830:134:3::10]:56921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f0oNE-0005lK-Qc
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f0oN9-0000zX-Ri
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:10:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:49808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f0oN9-0000xJ-LK
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:10:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f0oN8-0006yt-QP
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 13:10:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C3F252E80C9
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 13:10:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Mar 2018 13:00:43 -0000
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reply-To: Bug 1759264 <1759264@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152215564388.18893.1601223531883570946.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1759264] [NEW] fpu/softfloat:
 round_to_int_and_pack refactor broke TriCore ftoi insns
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

After the refactor from ab52f973a504f8de0c5df64631ba4caea70a7d9e the
bahaviour of int32_to_float32() was altered.

helper_ftoi() in target/tricore/fpu_helper.c relied on int32_to_float32
to raise the invalid flag if the input was NaN to properly return 0.
Likewise if the input is infinity.

The obvious fix for softfloat would be to raise this flag in round_to_int_a=
nd_pack(). However,
I'm not sure if this breaks other targets and I have no easy way to test it.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1759264

Title:
  fpu/softfloat: round_to_int_and_pack refactor broke TriCore ftoi insns

Status in QEMU:
  New

Bug description:
  After the refactor from ab52f973a504f8de0c5df64631ba4caea70a7d9e the
  bahaviour of int32_to_float32() was altered.

  helper_ftoi() in target/tricore/fpu_helper.c relied on
  int32_to_float32 to raise the invalid flag if the input was NaN to
  properly return 0. Likewise if the input is infinity.

  The obvious fix for softfloat would be to raise this flag in round_to_int=
_and_pack(). However,
  I'm not sure if this breaks other targets and I have no easy way to test =
it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1759264/+subscriptions
