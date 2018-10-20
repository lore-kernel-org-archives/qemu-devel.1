Received: from eggs.gnu.org ([2001:4830:134:3::10]:41091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlU1-0002UR-R7
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlU0-0004jS-4p
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:37 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:40700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gDlTx-0004W9-Uj
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:34 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Sat, 20 Oct 2018 09:14:51 +0200
Message-Id: <20181020071451.27808-30-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 29/29] target/riscv: Rename trans_arith to
 gen_arith
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, kbastian@mail.uni-paderborn.de
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, richard.henderson@linaro.org, qemu-devel@nongnu.org

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/riscv/insn_trans/trans_rvi.inc.c | 14 +++++++-------
 target/riscv/insn_trans/trans_rvm.inc.c | 14 +++++++-------
 target/riscv/translate.c                |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index 5ece5e2f6a..0455f0bf91 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -315,12 +315,12 @@ static bool trans_srai(DisasContext *ctx, arg_srai *a, uint32_t insn)
 
 static bool trans_add(DisasContext *ctx, arg_add *a, uint32_t insn)
 {
-    return trans_arith(ctx, a, &tcg_gen_add_tl);
+    return gen_arith(ctx, a, &tcg_gen_add_tl);
 }
 
 static bool trans_sub(DisasContext *ctx, arg_sub *a, uint32_t insn)
 {
-    return trans_arith(ctx, a, &tcg_gen_sub_tl);
+    return gen_arith(ctx, a, &tcg_gen_sub_tl);
 }
 
 static bool trans_sll(DisasContext *ctx, arg_sll *a, uint32_t insn)
@@ -363,7 +363,7 @@ static bool trans_sltu(DisasContext *ctx, arg_sltu *a, uint32_t insn)
 
 static bool trans_xor(DisasContext *ctx, arg_xor *a, uint32_t insn)
 {
-    return trans_arith(ctx, a, &tcg_gen_xor_tl);
+    return gen_arith(ctx, a, &tcg_gen_xor_tl);
 }
 
 
@@ -379,12 +379,12 @@ static bool trans_sra(DisasContext *ctx, arg_sra *a, uint32_t insn)
 
 static bool trans_or(DisasContext *ctx, arg_or *a, uint32_t insn)
 {
-    return trans_arith(ctx, a, &tcg_gen_or_tl);
+    return gen_arith(ctx, a, &tcg_gen_or_tl);
 }
 
 static bool trans_and(DisasContext *ctx, arg_and *a, uint32_t insn)
 {
-    return trans_arith(ctx, a, &tcg_gen_and_tl);
+    return gen_arith(ctx, a, &tcg_gen_and_tl);
 }
 
 static bool trans_addiw(DisasContext *ctx, arg_addiw *a, uint32_t insn)
@@ -453,7 +453,7 @@ static bool trans_addw(DisasContext *ctx, arg_addw *a, uint32_t insn)
 #if !defined(TARGET_RISCV64)
     return false;
 #endif
-    return trans_arith(ctx, a, &tcg_gen_add_tl);
+    return gen_arith(ctx, a, &tcg_gen_add_tl);
 }
 
 static bool trans_subw(DisasContext *ctx, arg_subw *a, uint32_t insn)
@@ -461,7 +461,7 @@ static bool trans_subw(DisasContext *ctx, arg_subw *a, uint32_t insn)
 #if !defined(TARGET_RISCV64)
     return false;
 #endif
-    return trans_arith(ctx, a, &tcg_gen_sub_tl);
+    return gen_arith(ctx, a, &tcg_gen_sub_tl);
 }
 
 static bool trans_sllw(DisasContext *ctx, arg_sllw *a, uint32_t insn)
diff --git a/target/riscv/insn_trans/trans_rvm.inc.c b/target/riscv/insn_trans/trans_rvm.inc.c
index 93859745b8..0bc9b4347a 100644
--- a/target/riscv/insn_trans/trans_rvm.inc.c
+++ b/target/riscv/insn_trans/trans_rvm.inc.c
@@ -21,7 +21,7 @@
 
 static bool trans_mul(DisasContext *ctx, arg_mul *a, uint32_t insn)
 {
-    return trans_arith(ctx, a, &tcg_gen_mul_tl);
+    return gen_arith(ctx, a, &tcg_gen_mul_tl);
 }
 
 static bool trans_mulh(DisasContext *ctx, arg_mulh *a, uint32_t insn)
@@ -41,7 +41,7 @@ static bool trans_mulh(DisasContext *ctx, arg_mulh *a, uint32_t insn)
 
 static bool trans_mulhsu(DisasContext *ctx, arg_mulhsu *a, uint32_t insn)
 {
-    return trans_arith(ctx, a, &gen_mulhsu);
+    return gen_arith(ctx, a, &gen_mulhsu);
 }
 
 static bool trans_mulhu(DisasContext *ctx, arg_mulhu *a, uint32_t insn)
@@ -61,28 +61,28 @@ static bool trans_mulhu(DisasContext *ctx, arg_mulhu *a, uint32_t insn)
 
 static bool trans_div(DisasContext *ctx, arg_div *a, uint32_t insn)
 {
-    return trans_arith(ctx, a, &gen_div);
+    return gen_arith(ctx, a, &gen_div);
 }
 
 static bool trans_divu(DisasContext *ctx, arg_divu *a, uint32_t insn)
 {
-    return trans_arith(ctx, a, &gen_divu);
+    return gen_arith(ctx, a, &gen_divu);
 }
 
 static bool trans_rem(DisasContext *ctx, arg_rem *a, uint32_t insn)
 {
-    return trans_arith(ctx, a, &gen_rem);
+    return gen_arith(ctx, a, &gen_rem);
 }
 
 static bool trans_remu(DisasContext *ctx, arg_remu *a, uint32_t insn)
 {
-    return trans_arith(ctx, a, &gen_remu);
+    return gen_arith(ctx, a, &gen_remu);
 }
 
 static bool trans_mulw(DisasContext *ctx, arg_mulw *a, uint32_t insn)
 {
 #ifdef TARGET_RISCV64
-    return trans_arith(ctx, a, &tcg_gen_mul_tl);
+    return gen_arith(ctx, a, &tcg_gen_mul_tl);
 #else
     return false;
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 66241ecf33..ece163e69f 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -344,8 +344,8 @@ static bool gen_arith_imm(DisasContext *ctx, arg_arith_imm *a,
     return true;
 }
 
-static bool trans_arith(DisasContext *ctx, arg_arith *a,
-                        void(*func)(TCGv, TCGv, TCGv))
+static bool gen_arith(DisasContext *ctx, arg_arith *a,
+                      void(*func)(TCGv, TCGv, TCGv))
 {
     TCGv source1, source2;
     source1 = tcg_temp_new();
-- 
2.19.1
