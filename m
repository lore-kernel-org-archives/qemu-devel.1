Received: from eggs.gnu.org ([2001:4830:134:3::10]:46696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPD6a-0005oz-0f
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPD6V-0003kh-4P
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:21:56 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:64125)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dPD6U-0003jx-QQ
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:21:51 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 25 Jun 2017 21:21:18 +0200
Message-Id: <20170625192125.9992-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/7] target/m68k: implement 680x0 FPU (part 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Second part of patches submitted in the v3.

This series adds a subset of single precision and
double precision instructions using
set_floatx80_rounding_precision() to round the result.

For some other instructions, we introduce a new
function, floatx80_round(), to round them manually.

It also adds instructions fsglmul, fsgldiv,
fmovecr and fscc (since v3, use tcg_gen_setcond())

fmovem manages static and dynamic register list,
all the code has been moved to an helper.

Laurent Vivier (7):
  target/m68k: add fscc.
  target/m68k: add fmovecr
  target/m68k: add fsglmul and fsgldiv
  target/m68k: add explicit single and double precision operations
  softfloat: define floatx80_round()
  target/m68k: add explicit single and double precision operations (part
    2)
  target/m68k: add fmovem

 fpu/softfloat.c          |  15 ++
 include/fpu/softfloat.h  |   1 +
 target/m68k/fpu_helper.c | 283 ++++++++++++++++++++++++++++++++++++-
 target/m68k/helper.h     |  22 ++-
 target/m68k/translate.c  | 357 +++++++++++++++++++++++++++++++----------------
 5 files changed, 555 insertions(+), 123 deletions(-)

-- 
2.9.4
