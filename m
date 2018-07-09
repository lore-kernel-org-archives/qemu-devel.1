Received: from eggs.gnu.org ([2001:4830:134:3::10]:55959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fcZ3p-0008N5-7H
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fcZ3m-0008NZ-3p
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:30:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:48908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fcZ3l-0008N5-UP
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:30:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fcZ3k-0003Lh-Kv
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 16:30:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9A3C12E8199
	for <qemu-devel@nongnu.org>; Mon,  9 Jul 2018 16:30:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Jul 2018 16:23:47 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1780814 <1780814@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153115132054.17859.168324292889810627.malonedeb@chaenomeles.canonical.com>
Message-Id: <153115342783.6872.7332561350718462000.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1780814] Re: lib/raid6/neon4.c:118:1: internal
 compiler error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi -- this is an internal compiler error reported by your compiler. It's
not a QEMU bug. The message suggests that you report it as a GCC bug:
"See <https://bugs.launchpad.net/gcc-linaro> for instructions".


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1780814

Title:
  lib/raid6/neon4.c:118:1: internal compiler error

Status in QEMU:
  Invalid

Bug description:
  I am facing below issue when i am trying to cross compile kernel for rasp=
berry pi 3.
  please give solution .

  =

  Below is log


  CHK     include/config/kernel.release
    CHK     include/generated/uapi/linux/version.h
    CHK     include/generated/utsrelease.h
    CHK     include/generated/bounds.h
    CHK     include/generated/timeconst.h
    CHK     include/generated/asm-offsets.h
    CALL    scripts/checksyscalls.sh
    CHK     scripts/mod/devicetable-offsets.h
    CHK     include/generated/compile.h
    CHK     kernel/config_data.h
    CC [M]  lib/raid6/neon4.o
  lib/raid6/neon4.c: In function =E2=80=98raid6_neon4_gen_syndrome_real=E2=
=80=99:
  lib/raid6/neon4.c:118:1: internal compiler error: in dwarf2out_frame_debu=
g_adjust_cfa, at dwarf2cfi.c:1078
   }
   ^
  Please submit a full bug report,
  with preprocessed source if appropriate.
  See <https://bugs.launchpad.net/gcc-linaro> for instructions.
  scripts/Makefile.build:328: recipe for target 'lib/raid6/neon4.o' failed
  make[2]: *** [lib/raid6/neon4.o] Error 1
  scripts/Makefile.build:587: recipe for target 'lib/raid6' failed
  make[1]: *** [lib/raid6] Error 2
  Makefile:1034: recipe for target 'lib' failed

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1780814/+subscriptions
