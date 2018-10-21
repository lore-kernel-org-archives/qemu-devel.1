Received: from eggs.gnu.org ([2001:4830:134:3::10]:44688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFhY-00067k-4K
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFhT-0000Pn-Uv
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:31:35 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:34832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFhS-0000OC-BY
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:31:30 -0400
Date: Sun, 21 Oct 2018 17:31:26 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <26e9caf740e877425274977ca6af1e8dcb45596e.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 01/38] target/mips: Define R5900
 instructions and CPU preprocessor constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

The R5900 implements the 64-bit MIPS III instruction set except DMULT,
DMULTU, DDIV, DDIVU, LL, SC, LLD and SCD. The MIPS IV instructions MOVN,
MOVZ and PREF are implemented. It has the R5900-specific three-operand
instructions MADD, MADDU, MULT and MULTU as well as pipeline 1 versions
MULT1, MULTU1, DIV1, DIVU1, MADD1, MADDU1, MFHI1, MFLO1, MTHI1 and
MTLO1. A set of 93 128-bit multimedia instructions specific to the
R5900 is also implemented.

The Toshiba TX System RISC TX79 Core Architecture manual

https://wiki.qemu.org/File:C790.pdf

describes the C790 processor that is a follow-up to the R5900. There
are a few notable differences in that the R5900 FPU

- is not IEEE 754-1985 compliant,
- does not implement double format, and
- its machine code is nonstandard.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 target/mips/mips-defs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index 71ea4ef892..f017551e15 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -64,6 +64,7 @@
 #define INSN_LOONGSON2E   0x0001000000000000ULL
 #define INSN_LOONGSON2F   0x0002000000000000ULL
 #define INSN_VR54XX       0x0004000000000000ULL
+#define INSN_R5900        0x0008000000000000ULL
 /*
  *   bits 56-63: vendor-specific ASEs
  */
@@ -74,6 +75,7 @@
 #define		CPU_MIPS3	(CPU_MIPS2 | ISA_MIPS3)
 #define		CPU_MIPS4	(CPU_MIPS3 | ISA_MIPS4)
 #define		CPU_VR54XX	(CPU_MIPS4 | INSN_VR54XX)
+#define         CPU_R5900       (CPU_MIPS3 | INSN_R5900)
 #define		CPU_LOONGSON2E  (CPU_MIPS3 | INSN_LOONGSON2E)
 #define		CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F)
=20
--=20
2.18.1
