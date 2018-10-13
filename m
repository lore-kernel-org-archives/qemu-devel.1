Received: from eggs.gnu.org ([2001:4830:134:3::10]:42715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gBHoQ-0006li-Bj
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gBHoL-0008J6-FK
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:10:26 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:6247)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gBHoL-0008IY-8B
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:10:21 -0400
Date: Sat, 13 Oct 2018 13:10:07 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <c33bd47dc5382728314e200f0e9fd713898540d9.1539428198.git.noring@nocrew.org>
References: <cover.1539428198.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1539428198.git.noring@nocrew.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 1/7] target/mips: Define R5900 instructions
 and CPU preprocessor constants
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
MOVZ and PREF are implemented. It has the R5900 specific three-operand
instructions MADD, MADDU, MULT and MULTU as well as pipeline 1 versions
MULT1, MULTU1, DIV1, DIVU1, MADD1, MADDU1, MFHI1, MFLO1, MTHI1 and
MTLO1. A set of 93 128-bit multimedia instructions specific to the
R5900 is also implemented.

The Toshiba TX System RISC TX79 Core Architecture manual

http://www.lukasz.dk/files/tx79architecture.pdf

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
index c8e99791ad..76550de2da 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -53,6 +53,7 @@
 #define   ASE_MSA       0x01000000
=20
 /* Chip specific instructions. */
+#define         INSN_R5900       0x10000000
 #define		INSN_LOONGSON2E  0x20000000
 #define		INSN_LOONGSON2F  0x40000000
 #define		INSN_VR54XX	0x80000000
@@ -63,6 +64,7 @@
 #define		CPU_MIPS3	(CPU_MIPS2 | ISA_MIPS3)
 #define		CPU_MIPS4	(CPU_MIPS3 | ISA_MIPS4)
 #define		CPU_VR54XX	(CPU_MIPS4 | INSN_VR54XX)
+#define         CPU_R5900       (CPU_MIPS3 | INSN_R5900)
 #define		CPU_LOONGSON2E  (CPU_MIPS3 | INSN_LOONGSON2E)
 #define		CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F)
=20
--=20
2.16.4
