Received: from eggs.gnu.org ([2001:4830:134:3::10]:46036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmp-0000Bl-KX
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmn-0008BG-An
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:23 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33435 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZmk-00084e-GW
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:18 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:44 +0200
Message-Id: <1540213077-15211-22-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/34] target/mips: Support R5900 MOVN,
 MOVZ and PREF instructions from MIPS IV
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

The R5900 is taken to be MIPS III with certain modifications. From
MIPS IV it implements the instructions MOVN, MOVZ and PREF.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index f2aeaf4..551928d 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23552,7 +23552,7 @@ static void decode_opc_special_legacy(CPUMIPSStat=
e *env, DisasContext *ctx)
     case OPC_MOVN:         /* Conditional move */
     case OPC_MOVZ:
         check_insn(ctx, ISA_MIPS4 | ISA_MIPS32 |
-                   INSN_LOONGSON2E | INSN_LOONGSON2F);
+                   INSN_LOONGSON2E | INSN_LOONGSON2F | INSN_R5900);
         gen_cond_move(ctx, op1, rd, rs, rt);
         break;
     case OPC_MFHI:          /* Move from HI/LO */
@@ -26388,7 +26388,8 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
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
2.7.4
