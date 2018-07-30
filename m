Received: from eggs.gnu.org ([2001:4830:134:3::10]:35696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAsM-0003mT-BQ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAsJ-00063j-JO
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:18:26 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54701 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fkAsJ-00063E-C8
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:18:23 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 30 Jul 2018 18:11:49 +0200
Message-Id: <1532967169-22265-17-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 16/76] target/mips: Mark switch fallthroughs
 with interpretable comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Mark switch fallthroughs with comments, in cases fallthroughs
are intentional.

The comments "/* fall through */" are interpreted by compilers and
other tools, and they will not issue warnings in such cases. For gcc,
the warning is turnend on by -Wimplicit-fallthrough. With this patch,
there will be no such warnings in target/mips directory. If such
warning appears in future, it should be checked if it is intentional,
and, if yes, marked with a comment similar to those from this patch.

The comment must be just before next "case", otherwise gcc won't
understand it.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index ae9df4b..c1843c1 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -14287,8 +14287,8 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
         case SDP:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
-            /* Fallthrough */
 #endif
+            /* fall through */
         case LWP:
         case SWP:
             gen_ldst_pair(ctx, minor, rt, rs, SIMM(ctx->opcode, 0, 12));
@@ -14298,8 +14298,8 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
         case SDM:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
-            /* Fallthrough */
 #endif
+            /* fall through */
         case LWM32:
         case SWM32:
             gen_ldst_multiple(ctx, minor, rt, rs, SIMM(ctx->opcode, 0, 12));
@@ -20867,6 +20867,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         case OPC_MTHC1:
             check_cp1_enabled(ctx);
             check_insn(ctx, ISA_MIPS32R2);
+            /* fall through */
         case OPC_MFC1:
         case OPC_CFC1:
         case OPC_MTC1:
-- 
2.7.4
