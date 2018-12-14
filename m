Received: from eggs.gnu.org ([2001:4830:134:3::10]:49592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gXmh6-0007tQ-NK
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:35:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gXmh2-00063g-JS
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:35:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:43374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gXmh2-00063G-BN
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:35:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gXmh0-0002vW-9w
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 12:35:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 341FD2E8081
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 12:35:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Dec 2018 12:29:38 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1796520 <1796520@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153886120838.22456.12836438866392888832.malonedeb@gac.canonical.com>
Message-Id: <154479057842.1298.8235426186557744129.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1796520] Re: autogen crashes on qemu-sh4-user
 after 61dedf2af7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is still reproducible on git master:

(sid-sh4-sbuild)root@nofan:/# autogen
Unhandled trap: 0x180
pc=3D0x7f4da99e sr=3D0x00000000 pr=3D0x7f3bfc74 fpscr=3D0x00080000
spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0x7f114320 vbr=3D0x00000000
sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0x7f4da960 fpul=3D0x00000003
r0=3D0x7ffc130c r1=3D0x00000000 r2=3D0xffff5dc4 r3=3D0x7f7bfb54
r4=3D0x7ffc121c r5=3D0x7ffc1408 r6=3D0x000003ff r7=3D0x00000000
r8=3D0x00000004 r9=3D0x7f3e80bc r10=3D0x7ffc1408 r11=3D0x7f3e88f0
r12=3D0x7f3e8258 r13=3D0x7f3f0e1c r14=3D0x00000804 r15=3D0x7ffc120c
r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
(sid-sh4-sbuild)root@nofan:/#

Can we just revert 61dedf2af7 which fixes the problem?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1796520

Title:
  autogen crashes on qemu-sh4-user after 61dedf2af7

Status in QEMU:
  New

Bug description:
  Running "autogen --help" crashes on qemu-sh4-user with:

  (sid-sh4-sbuild)root@nofan:/# autogen --help
  Unhandled trap: 0x180
  pc=3D0xf64dd2de sr=3D0x00000000 pr=3D0xf63b9c74 fpscr=3D0x00080000
  spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf61102a8 vbr=3D0x00000000
  sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf64dd2a0 fpul=3D0x000000=
03
  r0=3D0xf6fc1320 r1=3D0x00000000 r2=3D0xffff5dc4 r3=3D0xf67bfb50
  r4=3D0xf6fc1230 r5=3D0xf6fc141c r6=3D0x000003ff r7=3D0x00000000
  r8=3D0x00000004 r9=3D0xf63e20bc r10=3D0xf6fc141c r11=3D0xf63e28f0
  r12=3D0xf63e2258 r13=3D0xf63eae1c r14=3D0x00000804 r15=3D0xf6fc1220
  r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
  r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
  (sid-sh4-sbuild)root@nofan:/#

  Bi-secting found this commit to be the culprit:

  61dedf2af79fb5866dc7a0f972093682f2185e17 is the first bad commit
  commit 61dedf2af79fb5866dc7a0f972093682f2185e17
  Author: Richard Henderson <rth@twiddle.net>
  Date:   Tue Jul 18 10:02:50 2017 -1000

      target/sh4: Add missing FPSCR.PR =3D=3D 0 checks
      =

      Both frchg and fschg require PR =3D=3D 0, otherwise undefined_operati=
on.
      =

      Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
      Signed-off-by: Richard Henderson <rth@twiddle.net>
      Message-Id: <20170718200255.31647-26-rth@twiddle.net>
      Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

  :040000 040000 980d79b69ae712f23a1e4c56983e97a843153b4a
  1024c109f506c7ad57367c63bc8bbbc8a7a36cd7 M      target

  Reverting 61dedf2af79fb5866dc7a0f972093682f2185e17 fixes the problem
  for me.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1796520/+subscriptions
