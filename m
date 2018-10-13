Received: from eggs.gnu.org ([2001:4830:134:3::10]:42942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gBHow-00076G-G0
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gBHos-00005o-UB
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:10:58 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:48545)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gBHos-000059-Ms
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:10:54 -0400
Date: Sat, 13 Oct 2018 13:10:33 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <5cf3590d5354b9be53d596a44023fdbe669c749b.1539428198.git.noring@nocrew.org>
References: <cover.1539428198.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1539428198.git.noring@nocrew.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 3/7] target/mips: Support R5900 instructions
 MOVN, MOVZ and PREF from MIPS IV
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

The R5900 is taken to be MIPS III with certain modifications. From
MIPS IV it implements the instructions MOVN, MOVZ and PREF.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 target/mips/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index a32e021745..9d9be199e4 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -22422,7 +22422,7 @@ static void decode_opc_special_legacy(CPUMIPSStat=
e *env, DisasContext *ctx)
     case OPC_MOVN:         /* Conditional move */
     case OPC_MOVZ:
         check_insn(ctx, ISA_MIPS4 | ISA_MIPS32 |
-                   INSN_LOONGSON2E | INSN_LOONGSON2F);
+                   INSN_LOONGSON2E | INSN_LOONGSON2F | INSN_R5900);
         gen_cond_move(ctx, op1, rd, rs, rt);
         break;
     case OPC_MFHI:          /* Move from HI/LO */
@@ -25006,7 +25006,8 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
         break;
     case OPC_PREF:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
-        check_insn(ctx, ISA_MIPS4 | ISA_MIPS32);
+        check_insn(ctx, ISA_MIPS4 | ISA_MIPS32 |
+                   INSN_R5900);
         /* Treat as NOP. */
         break;
=20
--=20
2.16.4
