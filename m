Received: from eggs.gnu.org ([2001:4830:134:3::10]:49496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBZFy-0000wa-EQ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 01:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBZFv-0007jn-A2
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 01:15:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:46242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fBZFv-0007j4-3D
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 01:15:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fBZFt-0000j1-SE
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 05:15:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C292C2E80C8
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 05:15:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Apr 2018 05:10:32 -0000
From: Thomas Huth <1759264@bugs.launchpad.net>
Reply-To: Bug 1759264 <1759264@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152215564388.18893.1601223531883570946.malonedeb@chaenomeles.canonical.com>
Message-Id: <152471943364.21355.1583286891507486091.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1759264] Re: fpu/softfloat: round_to_int_and_pack
 refactor broke TriCore ftoi insns
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
https://bugs.launchpad.net/bugs/1759264

Title:
  fpu/softfloat: round_to_int_and_pack refactor broke TriCore ftoi insns

Status in QEMU:
  Fix Released

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
