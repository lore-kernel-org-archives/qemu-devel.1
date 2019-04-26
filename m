Received: from eggs.gnu.org ([209.51.188.92]:60476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu12-00065V-25
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu10-00059e-47
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:19 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:15 +1000
Message-Id: <20190426060627.18153-25-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/36] target/ppc: Style fixes for
 translate/fp-impl.inc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/translate/fp-impl.inc.c | 52 ++++++++++++++++++------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp=
-impl.inc.c
index 0f21a4e477..9dcff947c0 100644
--- a/target/ppc/translate/fp-impl.inc.c
+++ b/target/ppc/translate/fp-impl.inc.c
@@ -585,11 +585,13 @@ static void gen_mcrfs(DisasContext *ctx)
     shift =3D 4 * nibble;
     tcg_gen_shri_tl(tmp, cpu_fpscr, shift);
     tcg_gen_trunc_tl_i32(cpu_crf[crfD(ctx->opcode)], tmp);
-    tcg_gen_andi_i32(cpu_crf[crfD(ctx->opcode)], cpu_crf[crfD(ctx->opcod=
e)], 0xf);
+    tcg_gen_andi_i32(cpu_crf[crfD(ctx->opcode)], cpu_crf[crfD(ctx->opcod=
e)],
+                     0xf);
     tcg_temp_free(tmp);
     tcg_gen_extu_tl_i64(tnew_fpscr, cpu_fpscr);
     /* Only the exception bits (including FX) should be cleared if read =
*/
-    tcg_gen_andi_i64(tnew_fpscr, tnew_fpscr, ~((0xF << shift) & FP_EX_CL=
EAR_BITS));
+    tcg_gen_andi_i64(tnew_fpscr, tnew_fpscr,
+                     ~((0xF << shift) & FP_EX_CLEAR_BITS));
     /* FEX and VX need to be updated, so don't set fpscr directly */
     tmask =3D tcg_const_i32(1 << nibble);
     gen_helper_store_fpscr(cpu_env, tnew_fpscr, tmask);
@@ -735,7 +737,7 @@ static void gen_mtfsfi(DisasContext *ctx)
=20
 /***                         Floating-point load                        =
   ***/
 #define GEN_LDF(name, ldop, opc, type)                                  =
      \
-static void glue(gen_, name)(DisasContext *ctx)                         =
              \
+static void glue(gen_, name)(DisasContext *ctx)                         =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 t0;                                                        =
      \
@@ -754,7 +756,7 @@ static void glue(gen_, name)(DisasContext *ctx)
 }
=20
 #define GEN_LDUF(name, ldop, opc, type)                                 =
      \
-static void glue(gen_, name##u)(DisasContext *ctx)                      =
              \
+static void glue(gen_, name##u)(DisasContext *ctx)                      =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 t0;                                                        =
      \
@@ -778,7 +780,7 @@ static void glue(gen_, name##u)(DisasContext *ctx)
 }
=20
 #define GEN_LDUXF(name, ldop, opc, type)                                =
      \
-static void glue(gen_, name##ux)(DisasContext *ctx)                     =
              \
+static void glue(gen_, name##ux)(DisasContext *ctx)                     =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 t0;                                                        =
      \
@@ -802,7 +804,7 @@ static void glue(gen_, name##ux)(DisasContext *ctx)
 }
=20
 #define GEN_LDXF(name, ldop, opc2, opc3, type)                          =
      \
-static void glue(gen_, name##x)(DisasContext *ctx)                      =
              \
+static void glue(gen_, name##x)(DisasContext *ctx)                      =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 t0;                                                        =
      \
@@ -872,8 +874,10 @@ static void gen_lfdp(DisasContext *ctx)
     EA =3D tcg_temp_new();
     gen_addr_imm_index(ctx, EA, 0);
     t0 =3D tcg_temp_new_i64();
-    /* We only need to swap high and low halves. gen_qemu_ld64_i64 does
-       necessary 64-bit byteswap already. */
+    /*
+     * We only need to swap high and low halves. gen_qemu_ld64_i64
+     * does necessary 64-bit byteswap already.
+     */
     if (unlikely(ctx->le_mode)) {
         gen_qemu_ld64_i64(ctx, t0, EA);
         set_fpr(rD(ctx->opcode) + 1, t0);
@@ -904,8 +908,10 @@ static void gen_lfdpx(DisasContext *ctx)
     EA =3D tcg_temp_new();
     gen_addr_reg_index(ctx, EA);
     t0 =3D tcg_temp_new_i64();
-    /* We only need to swap high and low halves. gen_qemu_ld64_i64 does
-       necessary 64-bit byteswap already. */
+    /*
+     * We only need to swap high and low halves. gen_qemu_ld64_i64
+     * does necessary 64-bit byteswap already.
+     */
     if (unlikely(ctx->le_mode)) {
         gen_qemu_ld64_i64(ctx, t0, EA);
         set_fpr(rD(ctx->opcode) + 1, t0);
@@ -966,7 +972,7 @@ static void gen_lfiwzx(DisasContext *ctx)
 }
 /***                         Floating-point store                       =
   ***/
 #define GEN_STF(name, stop, opc, type)                                  =
      \
-static void glue(gen_, name)(DisasContext *ctx)                         =
              \
+static void glue(gen_, name)(DisasContext *ctx)                         =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 t0;                                                        =
      \
@@ -985,7 +991,7 @@ static void glue(gen_, name)(DisasContext *ctx)
 }
=20
 #define GEN_STUF(name, stop, opc, type)                                 =
      \
-static void glue(gen_, name##u)(DisasContext *ctx)                      =
              \
+static void glue(gen_, name##u)(DisasContext *ctx)                      =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 t0;                                                        =
      \
@@ -1009,7 +1015,7 @@ static void glue(gen_, name##u)(DisasContext *ctx)
 }
=20
 #define GEN_STUXF(name, stop, opc, type)                                =
      \
-static void glue(gen_, name##ux)(DisasContext *ctx)                     =
              \
+static void glue(gen_, name##ux)(DisasContext *ctx)                     =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 t0;                                                        =
      \
@@ -1033,7 +1039,7 @@ static void glue(gen_, name##ux)(DisasContext *ctx)
 }
=20
 #define GEN_STXF(name, stop, opc2, opc3, type)                          =
      \
-static void glue(gen_, name##x)(DisasContext *ctx)                      =
              \
+static void glue(gen_, name##x)(DisasContext *ctx)                      =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 t0;                                                        =
      \
@@ -1103,8 +1109,10 @@ static void gen_stfdp(DisasContext *ctx)
     EA =3D tcg_temp_new();
     t0 =3D tcg_temp_new_i64();
     gen_addr_imm_index(ctx, EA, 0);
-    /* We only need to swap high and low halves. gen_qemu_st64_i64 does
-       necessary 64-bit byteswap already. */
+    /*
+     * We only need to swap high and low halves. gen_qemu_st64_i64
+     * does necessary 64-bit byteswap already.
+     */
     if (unlikely(ctx->le_mode)) {
         get_fpr(t0, rD(ctx->opcode) + 1);
         gen_qemu_st64_i64(ctx, t0, EA);
@@ -1135,8 +1143,10 @@ static void gen_stfdpx(DisasContext *ctx)
     EA =3D tcg_temp_new();
     t0 =3D tcg_temp_new_i64();
     gen_addr_reg_index(ctx, EA);
-    /* We only need to swap high and low halves. gen_qemu_st64_i64 does
-       necessary 64-bit byteswap already. */
+    /*
+     * We only need to swap high and low halves. gen_qemu_st64_i64
+     * does necessary 64-bit byteswap already.
+     */
     if (unlikely(ctx->le_mode)) {
         get_fpr(t0, rD(ctx->opcode) + 1);
         gen_qemu_st64_i64(ctx, t0, EA);
@@ -1204,8 +1214,9 @@ static void gen_lfqu(DisasContext *ctx)
     gen_addr_add(ctx, t1, t0, 8);
     gen_qemu_ld64_i64(ctx, t2, t1);
     set_fpr((rd + 1) % 32, t2);
-    if (ra !=3D 0)
+    if (ra !=3D 0) {
         tcg_gen_mov_tl(cpu_gpr[ra], t0);
+    }
     tcg_temp_free(t0);
     tcg_temp_free(t1);
     tcg_temp_free_i64(t2);
@@ -1229,8 +1240,9 @@ static void gen_lfqux(DisasContext *ctx)
     gen_qemu_ld64_i64(ctx, t2, t1);
     set_fpr((rd + 1) % 32, t2);
     tcg_temp_free(t1);
-    if (ra !=3D 0)
+    if (ra !=3D 0) {
         tcg_gen_mov_tl(cpu_gpr[ra], t0);
+    }
     tcg_temp_free(t0);
     tcg_temp_free_i64(t2);
 }
--=20
2.20.1
