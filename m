Received: from eggs.gnu.org ([2001:4830:134:3::10]:57689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7790e8633=Alistair.Francis@wdc.com>)
	id 1fxg0Q-0001DC-02
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7790e8633=Alistair.Francis@wdc.com>)
	id 1fxg0L-00041r-Nc
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:10:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=7790e8633=Alistair.Francis@wdc.com>)
	id 1fxg0L-0003mb-41
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:10:29 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed,  5 Sep 2018 15:09:29 -0700
Message-Id: <20180905220932.6152-7-alistair.francis@wdc.com>
In-Reply-To: <20180905220932.6152-1-alistair.francis@wdc.com>
References: <20180905220932.6152-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL v2 06/10] target/riscv: optimize indirect
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Alistair Francis <alistair.francis@wdc.com>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
