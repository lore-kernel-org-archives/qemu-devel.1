Received: from eggs.gnu.org ([2001:4830:134:3::10]:52534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmiti-0002PG-Bc
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmitf-0004fb-Ma
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:02:22 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:42804 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fmitf-0004en-E2
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:02:19 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  6 Aug 2018 18:59:31 +0200
Message-Id: <1533574847-19294-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 04/80] target/mips: Fix two instances of
 shadow variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com, thuth@redhat.com, armbru@redhat.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix two instances of shadow variables. This cleans up entire file
translate.c from shadow variables.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e32fd5f..d6eccc9 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -13247,7 +13247,7 @@ static void gen_pool16c_r6_insn(DisasContext *ctx)
             gen_arith_imm(ctx, OPC_ADDIU, 29, 29, imm << 2);
         } else {
             /* JRC16 */
-            int rs = extract32(ctx->opcode, 5, 5);
+            rs = extract32(ctx->opcode, 5, 5);
             gen_compute_branch(ctx, OPC_JR, 2, rs, 0, 0, 0);
         }
         break;
@@ -15249,7 +15249,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
         } else {
             /* ADDIUPC */
             int reg = mmreg(ZIMM(ctx->opcode, 23, 3));
-            int offset = SIMM(ctx->opcode, 0, 23) << 2;
+            offset = SIMM(ctx->opcode, 0, 23) << 2;
 
             gen_addiupc(ctx, reg, offset, 0, 0);
         }
-- 
2.7.4
