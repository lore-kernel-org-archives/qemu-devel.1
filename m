Received: from eggs.gnu.org ([2001:4830:134:3::10]:56732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPc75-00078f-AW
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPc72-0005AR-7U
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:07 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60143)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dPc71-0005AJ-TN
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:04 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 27 Jun 2017 00:03:23 +0200
Message-Id: <20170626220330.6785-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 0/7] target/m68k: implement 680x0 FPU (part
 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

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

v2:
  Fix gen_fcc_cond(): g[12] mark global variables,
  not variables to free.
  use floatx80_round() to compute fsglmul and fsgldiv
  split fmovem helper into 6 helpers

Laurent Vivier (7):
  target/m68k: add fscc.
  target/m68k: add fmovecr
  target/m68k: add explicit single and double precision operations
  softfloat: define floatx80_round()
  target/m68k: add fsglmul and fsgldiv
  target/m68k: add explicit single and double precision operations (part
    2)
  target/m68k: add fmovem

 fpu/softfloat.c          |  15 ++
 include/fpu/softfloat.h  |   1 +
 target/m68k/fpu_helper.c | 300 +++++++++++++++++++++++++++++++++++-
 target/m68k/helper.h     |  27 +++-
 target/m68k/translate.c  | 391 ++++++++++++++++++++++++++++++++---------------
 5 files changed, 611 insertions(+), 123 deletions(-)

-- 
2.9.4
