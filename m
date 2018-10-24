Received: from eggs.gnu.org ([2001:4830:134:3::10]:59848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQI-0004rt-CX
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQE-0001lf-6l
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:09 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48976 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFJQC-0001GX-7b
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:05 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 15:40:15 +0200
Message-Id: <1540388447-27062-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 01/33] target/mips: Define R5900 ISA, MMI ASE,
 and R5900 CPU preprocessor constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Fredrik Noring <noring@nocrew.org>

The R5900 implements the 64-bit MIPS III instruction set except
DMULT, DMULTU, DDIV, DDIVU, LL, SC, LLD and SCD. The MIPS IV
instructions MOVN, MOVZ and PREF are implemented. It has the
R5900-specific three-operand instructions MADD, MADDU, MULT and
MULTU as well as pipeline 1 versions MULT1, MULTU1, DIV1, DIVU1,
MADD1, MADDU1, MFHI1, MFLO1, MTHI1 and MTLO1. A set of 93 128-bit
multimedia instructions specific to the R5900 is also implemented.

The Toshiba TX System RISC TX79 Core Architecture manual:

https://wiki.qemu.org/File:C790.pdf

describes the C790 processor that is a follow-up to the R5900. There
are a few notable differences in that the R5900 FPU

- is not IEEE 754-1985 compliant,
- does not implement double format, and
- its machine code is nonstandard.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/mips-defs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index 71ea4ef..5177618 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -64,9 +64,11 @@
 #define INSN_LOONGSON2E   0x0001000000000000ULL
 #define INSN_LOONGSON2F   0x0002000000000000ULL
 #define INSN_VR54XX       0x0004000000000000ULL
+#define INSN_R5900        0x0008000000000000ULL
 /*
  *   bits 56-63: vendor-specific ASEs
  */
+#define ASE_MMI           0x0100000000000000ULL
=20
 /* MIPS CPU defines. */
 #define		CPU_MIPS1	(ISA_MIPS1)
@@ -74,6 +76,7 @@
 #define		CPU_MIPS3	(CPU_MIPS2 | ISA_MIPS3)
 #define		CPU_MIPS4	(CPU_MIPS3 | ISA_MIPS4)
 #define		CPU_VR54XX	(CPU_MIPS4 | INSN_VR54XX)
+#define         CPU_R5900       (CPU_MIPS3 | INSN_R5900)
 #define		CPU_LOONGSON2E  (CPU_MIPS3 | INSN_LOONGSON2E)
 #define		CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F)
=20
--=20
2.7.4
