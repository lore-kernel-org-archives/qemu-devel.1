Received: from eggs.gnu.org ([2001:4830:134:3::10]:33674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1foBOA-0004Kq-K8
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1foBO6-0001Qc-MH
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:39:50 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1foBO6-0001PW-2Y
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:39:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 10 Aug 2018 13:39:40 -0400
Message-Id: <20180810173941.5301-3-cota@braap.org>
In-Reply-To: <20180810173941.5301-1-cota@braap.org>
References: <20180810173941.5301-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 2/3] target/riscv: optimize indirect branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/riscv/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ec2988b4f6..66a80ca772 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -548,7 +548,7 @@ static void gen_jalr(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
         if (rd != 0) {
             tcg_gen_movi_tl(cpu_gpr[rd], ctx->pc_succ_insn);
         }
-        tcg_gen_exit_tb(NULL, 0);
+        tcg_gen_lookup_and_goto_ptr();
 
         if (misaligned) {
             gen_set_label(misaligned);
-- 
2.17.1
