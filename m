Received: from eggs.gnu.org ([2001:4830:134:3::10]:37722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gHqRi-0004v5-8e
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gHqRe-0003CR-LQ
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:22:06 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Wed, 31 Oct 2018 14:20:22 +0100
Message-Id: <20181031132029.4887-29-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 28/35] target/riscv: Rename trans_arith to
 gen_arith
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, kbastian@mail.uni-paderborn.de, Alistair.Francis@wdc.com
Cc: richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/riscv/insn_trans/trans_rvi.inc.c | 14 +++++++-------
 target/riscv/insn_trans/trans_rvm.inc.c | 14 +++++++-------
 target/riscv/translate.c                |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index 65548d1281..227742232c 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -301,12 +301,12 @@ static bool trans_srai(DisasContext *ctx, arg_srai *a)
 
 static bool trans_add(DisasContext *ctx, arg_add *a)
 {
-    return trans_arith(ctx, a, &tcg_gen_add_tl);
+    return gen_arith(ctx, a, &tcg_gen_add_tl);
 }
 
 static bool trans_sub(DisasContext *ctx, arg_sub *a)
 {
-    return trans_arith(ctx, a, &tcg_gen_sub_tl);
+    return gen_arith(ctx, a, &tcg_gen_sub_tl);
 }
 
 static bool trans_sll(DisasContext *ctx, arg_sll *a)
@@ -348,7 +348,7 @@ static bool trans_sltu(DisasContext *ctx, arg_sltu *a)
 
 static bool trans_xor(DisasContext *ctx, arg_xor *a)
 {
-    return trans_arith(ctx, a, &tcg_gen_xor_tl);
+    return gen_arith(ctx, a, &tcg_gen_xor_tl);
 }
 
 static bool trans_srl(DisasContext *ctx, arg_srl *a)
@@ -363,12 +363,12 @@ static bool trans_sra(DisasContext *ctx, arg_sra *a)
 
 static bool trans_or(DisasContext *ctx, arg_or *a)
 {
-    return trans_arith(ctx, a, &tcg_gen_or_tl);
+    return gen_arith(ctx, a, &tcg_gen_or_tl);
 }
 
 static bool trans_and(DisasContext *ctx, arg_and *a)
 {
-    return trans_arith(ctx, a, &tcg_gen_and_tl);
+    return gen_arith(ctx, a, &tcg_gen_and_tl);
 }
 
 #ifdef TARGET_RISCV64
@@ -417,12 +417,12 @@ static bool trans_sraiw(DisasContext *ctx, arg_sraiw *a)
 
 static bool trans_addw(DisasContext *ctx, arg_addw *a)
 {
-    return trans_arith(ctx, a, &tcg_gen_add_tl);
+    return gen_arith(ctx, a, &tcg_gen_add_tl);
 }
 
 static bool trans_subw(DisasContext *ctx, arg_subw *a)
 {
-    return trans_arith(ctx, a, &tcg_gen_sub_tl);
+    return gen_arith(ctx, a, &tcg_gen_sub_tl);
 }
 
 static bool trans_sllw(DisasContext *ctx, arg_sllw *a)
diff --git a/target/riscv/insn_trans/trans_rvm.inc.c b/target/riscv/insn_trans/trans_rvm.inc.c
index 949f59ddb2..5844d6f5be 100644
--- a/target/riscv/insn_trans/trans_rvm.inc.c
+++ b/target/riscv/insn_trans/trans_rvm.inc.c
@@ -21,7 +21,7 @@
 
 static bool trans_mul(DisasContext *ctx, arg_mul *a)
 {
-    return trans_arith(ctx, a, &tcg_gen_mul_tl);
+    return gen_arith(ctx, a, &tcg_gen_mul_tl);
 }
 
 static bool trans_mulh(DisasContext *ctx, arg_mulh *a)
@@ -41,7 +41,7 @@ static bool trans_mulh(DisasContext *ctx, arg_mulh *a)
 
 static bool trans_mulhsu(DisasContext *ctx, arg_mulhsu *a)
 {
-    return trans_arith(ctx, a, &gen_mulhsu);
+    return gen_arith(ctx, a, &gen_mulhsu);
 }
 
 static bool trans_mulhu(DisasContext *ctx, arg_mulhu *a)
@@ -61,28 +61,28 @@ static bool trans_mulhu(DisasContext *ctx, arg_mulhu *a)
 
 static bool trans_div(DisasContext *ctx, arg_div *a)
 {
-    return trans_arith(ctx, a, &gen_div);
+    return gen_arith(ctx, a, &gen_div);
 }
 
 static bool trans_divu(DisasContext *ctx, arg_divu *a)
 {
-    return trans_arith(ctx, a, &gen_divu);
+    return gen_arith(ctx, a, &gen_divu);
 }
 
 static bool trans_rem(DisasContext *ctx, arg_rem *a)
 {
-    return trans_arith(ctx, a, &gen_rem);
+    return gen_arith(ctx, a, &gen_rem);
 }
 
 static bool trans_remu(DisasContext *ctx, arg_remu *a)
 {
-    return trans_arith(ctx, a, &gen_remu);
+    return gen_arith(ctx, a, &gen_remu);
 }
 
 #ifdef TARGET_RISCV64
 static bool trans_mulw(DisasContext *ctx, arg_mulw *a)
 {
-    return trans_arith(ctx, a, &gen_mulw);
+    return gen_arith(ctx, a, &gen_mulw);
 }
 
 static bool trans_divw(DisasContext *ctx, arg_divw *a)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index fd4b63b4c4..68223925ba 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -569,8 +569,8 @@ static bool gen_arith_div_w(DisasContext *ctx, arg_r *a,
 }
 #endif
 
-static bool trans_arith(DisasContext *ctx, arg_r *a,
-                        void(*func)(TCGv, TCGv, TCGv))
+static bool gen_arith(DisasContext *ctx, arg_r *a,
+                      void(*func)(TCGv, TCGv, TCGv))
 {
     TCGv source1, source2;
     source1 = tcg_temp_new();
-- 
2.19.1
