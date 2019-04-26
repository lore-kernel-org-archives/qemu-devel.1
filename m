Received: from eggs.gnu.org ([209.51.188.92]:60670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1J-0006QO-8w
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1I-0005bx-87
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:37 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:16 +1000
Message-Id: <20190426060627.18153-26-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/36] target/ppc: Style fixes for
 translate/vsx-impl.inc.c
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
 target/ppc/translate/vsx-impl.inc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 489b2436e4..11d9b75d01 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -751,7 +751,7 @@ static void gen_xxpermdi(DisasContext *ctx)
 #define SGN_MASK_SP 0x8000000080000000ull
=20
 #define VSX_SCALAR_MOVE(name, op, sgn_mask)                       \
-static void glue(gen_, name)(DisasContext * ctx)                  \
+static void glue(gen_, name)(DisasContext *ctx)                   \
     {                                                             \
         TCGv_i64 xb, sgm;                                         \
         if (unlikely(!ctx->vsx_enabled)) {                        \
@@ -848,7 +848,7 @@ VSX_SCALAR_MOVE_QP(xsnegqp, OP_NEG, SGN_MASK_DP)
 VSX_SCALAR_MOVE_QP(xscpsgnqp, OP_CPSGN, SGN_MASK_DP)
=20
 #define VSX_VECTOR_MOVE(name, op, sgn_mask)                      \
-static void glue(gen_, name)(DisasContext * ctx)                 \
+static void glue(gen_, name)(DisasContext *ctx)                  \
     {                                                            \
         TCGv_i64 xbh, xbl, sgm;                                  \
         if (unlikely(!ctx->vsx_enabled)) {                       \
@@ -910,7 +910,7 @@ VSX_VECTOR_MOVE(xvnegsp, OP_NEG, SGN_MASK_SP)
 VSX_VECTOR_MOVE(xvcpsgnsp, OP_CPSGN, SGN_MASK_SP)
=20
 #define GEN_VSX_HELPER_2(name, op1, op2, inval, type)                   =
      \
-static void gen_##name(DisasContext * ctx)                              =
      \
+static void gen_##name(DisasContext *ctx)                               =
      \
 {                                                                       =
      \
     TCGv_i32 opc;                                                       =
      \
     if (unlikely(!ctx->vsx_enabled)) {                                  =
      \
@@ -923,7 +923,7 @@ static void gen_##name(DisasContext * ctx)           =
                         \
 }
=20
 #define GEN_VSX_HELPER_XT_XB_ENV(name, op1, op2, inval, type) \
-static void gen_##name(DisasContext * ctx)                    \
+static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
     TCGv_i64 t0;                                              \
     TCGv_i64 t1;                                              \
@@ -1230,7 +1230,7 @@ static void gen_xxbrw(DisasContext *ctx)
 }
=20
 #define VSX_LOGICAL(name, vece, tcg_op)                              \
-static void glue(gen_, name)(DisasContext * ctx)                     \
+static void glue(gen_, name)(DisasContext *ctx)                      \
     {                                                                \
         if (unlikely(!ctx->vsx_enabled)) {                           \
             gen_exception(ctx, POWERPC_EXCP_VSXU);                   \
@@ -1251,7 +1251,7 @@ VSX_LOGICAL(xxlnand, MO_64, tcg_gen_gvec_nand)
 VSX_LOGICAL(xxlorc, MO_64, tcg_gen_gvec_orc)
=20
 #define VSX_XXMRG(name, high)                               \
-static void glue(gen_, name)(DisasContext * ctx)            \
+static void glue(gen_, name)(DisasContext *ctx)             \
     {                                                       \
         TCGv_i64 a0, a1, b0, b1, tmp;                       \
         if (unlikely(!ctx->vsx_enabled)) {                  \
@@ -1444,7 +1444,8 @@ static void gen_##name(DisasContext *ctx)          =
             \
     xb =3D tcg_const_tl(xB(ctx->opcode));                         \
     t0 =3D tcg_temp_new_i32();                                    \
     t1 =3D tcg_temp_new_i64();                                    \
-    /* uimm > 15 out of bound and for                           \
+    /*                                                          \
+     * uimm > 15 out of bound and for                           \
      * uimm > 12 handle as per hardware in helper               \
      */                                                         \
     if (uimm > 15) {                                            \
--=20
2.20.1
