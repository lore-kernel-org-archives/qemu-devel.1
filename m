Received: from eggs.gnu.org ([2001:4830:134:3::10]:45710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fnsjB-00030X-Nx
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fnsj7-0000wq-OP
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:44:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54241)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fnsj7-0000uD-EI
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:44:13 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  9 Aug 2018 17:43:55 -0400
Message-Id: <20180809214356.27690-3-cota@braap.org>
In-Reply-To: <20180809214356.27690-1-cota@braap.org>
References: <20180809214356.27690-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 2/3] target/riscv: optimize indirect branches
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
