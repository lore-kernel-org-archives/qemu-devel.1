Received: from eggs.gnu.org ([2001:4830:134:3::10]:60619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAfBf-0004jE-TF
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAfBb-0003hg-4u
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:51:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:34382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAfBa-0003hK-UB
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:51:15 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAfBZ-0008HK-Jf
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 16:51:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 562AA2E80D5
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 16:51:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Nov 2017 16:32:51 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1594069 <1594069@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160619053325.24903.2985.malonedeb@gac.canonical.com>
Message-Id: <150972677166.9241.10734596886329541281.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1594069] Re: SIMD instructions translated to
 scalar host instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing this because it isn't a bug. (It looks like some of the vector
TCG improvements are now in progress and might hit master for 2.12; but
in any case having an open bug in the system about this serves no useful
purpose.)


** Changed in: qemu
       Status: Confirmed =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1594069

Title:
  SIMD instructions translated to scalar host instructions

Status in QEMU:
  Invalid

Bug description:
  SIMD instructions inside the guest (NEON, MMX, SSE, SSE2, AVX) are
  translated to scalar instructions on the host instead of SIMD
  instructions.  It appears that there have been a few efforts to
  rectify this [1], and even a submitted patch series, but all
  discussion has effectively died out [2].

  I would like to see better SIMD performance on qemu, especially as
  non-x86 architectures are becoming widely used (e.g. ARM).

  [1] http://dl.acm.org/citation.cfm?id=3D2757098&dl=3DACM&coll=3DDL&CFID=
=3D633095244&CFTOKEN=3D12352103
  [2] https://lists.nongnu.org/archive/html/qemu-devel/2014-10/msg01720.html

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1594069/+subscriptions
