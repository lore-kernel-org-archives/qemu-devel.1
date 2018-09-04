Received: from eggs.gnu.org ([2001:4830:134:3::10]:58065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=778d471cf=Alistair.Francis@wdc.com>)
	id 1fxKXr-0000EJ-6h
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=778d471cf=Alistair.Francis@wdc.com>)
	id 1fxKXm-0002CF-Tl
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:15:39 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:45245)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=778d471cf=Alistair.Francis@wdc.com>)
	id 1fxKXm-0002AQ-EW
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:15:34 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Tue,  4 Sep 2018 16:14:38 -0700
Message-Id: <20180904231442.18932-6-alistair.francis@wdc.com>
In-Reply-To: <20180904231442.18932-1-alistair.francis@wdc.com>
References: <20180904231442.18932-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 5/9] target/riscv: optimize indirect branches
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
index 0b6be74f2d..c769edc359 100644
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
