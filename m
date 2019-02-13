Received: from eggs.gnu.org ([209.51.188.92]:59456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwtB-0001lX-CL
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwt9-0002Yb-Bs
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:55:57 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:35254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gtwt7-0001vV-CB
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:55:55 -0500
Received: by mail-pg1-x534.google.com with SMTP id s198so1322371pgs.2
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 07:55:23 -0800 (PST)
Date: Wed, 13 Feb 2019 07:54:07 -0800
Message-Id: <20190213155414.22285-29-palmer@sifive.com>
In-Reply-To: <20190213155414.22285-1-palmer@sifive.com>
References: <20190213155414.22285-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PATCH v7 28/35] target/riscv: Rename trans_arith to
 gen_arith
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/riscv/insn_trans/trans_rvi.inc.c | 18 +++++++++---------
 target/riscv/insn_trans/trans_rvm.inc.c | 14 +++++++-------
 target/riscv/translate.c                |  4 ++--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index d94b371b4d00..aed34dc2bb11 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -307,12 +307,12 @@ static bool trans_srai(DisasContext *ctx, arg_srai *a)
 
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
@@ -322,17 +322,17 @@ static bool trans_sll(DisasContext *ctx, arg_sll *a)
 
 static bool trans_slt(DisasContext *ctx, arg_slt *a)
 {
-    return trans_arith(ctx, a, &gen_slt);
+    return gen_arith(ctx, a, &gen_slt);
 }
 
 static bool trans_sltu(DisasContext *ctx, arg_sltu *a)
 {
-    return trans_arith(ctx, a, &gen_sltu);
+    return gen_arith(ctx, a, &gen_sltu);
 }
 
 static bool trans_xor(DisasContext *ctx, arg_xor *a)
 {
-    return trans_arith(ctx, a, &tcg_gen_xor_tl);
+    return gen_arith(ctx, a, &tcg_gen_xor_tl);
 }
 
 static bool trans_srl(DisasContext *ctx, arg_srl *a)
@@ -347,12 +347,12 @@ static bool trans_sra(DisasContext *ctx, arg_sra *a)
 
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
@@ -399,12 +399,12 @@ static bool trans_sraiw(DisasContext *ctx, arg_sraiw *a)
 
 static bool trans_addw(DisasContext *ctx, arg_addw *a)
 {
-    return trans_arith(ctx, a, &gen_addw);
+    return gen_arith(ctx, a, &gen_addw);
 }
 
 static bool trans_subw(DisasContext *ctx, arg_subw *a)
 {
-    return trans_arith(ctx, a, &gen_subw);
+    return gen_arith(ctx, a, &gen_subw);
 }
 
 static bool trans_sllw(DisasContext *ctx, arg_sllw *a)
diff --git a/target/riscv/insn_trans/trans_rvm.inc.c b/target/riscv/insn_trans/trans_rvm.inc.c
index 949f59ddb2f9..5844d6f5beff 100644
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
index 9ae7aaa7ed00..3d49c8ed4054 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -624,8 +624,8 @@ static bool gen_arith_div_w(DisasContext *ctx, arg_r *a,
 
 #endif
 
-static bool trans_arith(DisasContext *ctx, arg_r *a,
-                        void(*func)(TCGv, TCGv, TCGv))
+static bool gen_arith(DisasContext *ctx, arg_r *a,
+                      void(*func)(TCGv, TCGv, TCGv))
 {
     TCGv source1, source2;
     source1 = tcg_temp_new();
-- 
2.18.1
