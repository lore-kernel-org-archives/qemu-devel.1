Received: from eggs.gnu.org ([209.51.188.92]:60165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0d-0005aR-LK
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0b-0004ZK-P9
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:55 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:17 +1000
Message-Id: <20190426060627.18153-27-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/36] target/ppc: Style fixes for
 translate/vmx-impl.inc.c
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
 target/ppc/translate/vmx-impl.inc.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
index eb10c533ca..bd3ff40e68 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -15,7 +15,7 @@ static inline TCGv_ptr gen_avr_ptr(int reg)
 }
=20
 #define GEN_VR_LDX(name, opc2, opc3)                                    =
      \
-static void glue(gen_, name)(DisasContext *ctx)                         =
              \
+static void glue(gen_, name)(DisasContext *ctx)                         =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 avr;                                                       =
      \
@@ -28,8 +28,10 @@ static void glue(gen_, name)(DisasContext *ctx)
     EA =3D tcg_temp_new();                                              =
        \
     gen_addr_reg_index(ctx, EA);                                        =
      \
     tcg_gen_andi_tl(EA, EA, ~0xf);                                      =
      \
-    /* We only need to swap high and low halves. gen_qemu_ld64_i64 does =
      \
-       necessary 64-bit byteswap already. */                            =
      \
+    /*                                                                  =
      \
+     * We only need to swap high and low halves. gen_qemu_ld64_i64      =
      \
+     * does necessary 64-bit byteswap already.                          =
      \
+     */                                                                 =
      \
     if (ctx->le_mode) {                                                 =
      \
         gen_qemu_ld64_i64(ctx, avr, EA);                                =
      \
         set_avr64(rD(ctx->opcode), avr, false);                         =
      \
@@ -61,8 +63,10 @@ static void gen_st##name(DisasContext *ctx)           =
                        \
     EA =3D tcg_temp_new();                                              =
        \
     gen_addr_reg_index(ctx, EA);                                        =
      \
     tcg_gen_andi_tl(EA, EA, ~0xf);                                      =
      \
-    /* We only need to swap high and low halves. gen_qemu_st64_i64 does =
      \
-       necessary 64-bit byteswap already. */                            =
      \
+    /*                                                                  =
      \
+     * We only need to swap high and low halves. gen_qemu_st64_i64      =
      \
+     * does necessary 64-bit byteswap already.                          =
      \
+     */                                                                 =
      \
     if (ctx->le_mode) {                                                 =
      \
         get_avr64(avr, rD(ctx->opcode), false);                         =
      \
         gen_qemu_st64_i64(ctx, avr, EA);                                =
      \
@@ -296,7 +300,7 @@ GEN_VXFORM_V(vnand, MO_64, tcg_gen_gvec_nand, 2, 22);
 GEN_VXFORM_V(vorc, MO_64, tcg_gen_gvec_orc, 2, 21);
=20
 #define GEN_VXFORM(name, opc2, opc3)                                    =
\
-static void glue(gen_, name)(DisasContext *ctx)                         =
        \
+static void glue(gen_, name)(DisasContext *ctx)                         =
\
 {                                                                       =
\
     TCGv_ptr ra, rb, rd;                                                =
\
     if (unlikely(!ctx->altivec_enabled)) {                              =
\
@@ -306,7 +310,7 @@ static void glue(gen_, name)(DisasContext *ctx)
     ra =3D gen_avr_ptr(rA(ctx->opcode));                                =
  \
     rb =3D gen_avr_ptr(rB(ctx->opcode));                                =
  \
     rd =3D gen_avr_ptr(rD(ctx->opcode));                                =
  \
-    gen_helper_##name (rd, ra, rb);                                     =
\
+    gen_helper_##name(rd, ra, rb);                                      =
\
     tcg_temp_free_ptr(ra);                                              =
\
     tcg_temp_free_ptr(rb);                                              =
\
     tcg_temp_free_ptr(rd);                                              =
\
@@ -758,7 +762,7 @@ GEN_VXFORM_DUPI(vspltish, tcg_gen_gvec_dup16i, 6, 13)=
;
 GEN_VXFORM_DUPI(vspltisw, tcg_gen_gvec_dup32i, 6, 14);
=20
 #define GEN_VXFORM_NOA(name, opc2, opc3)                                =
\
-static void glue(gen_, name)(DisasContext *ctx)                         =
        \
+static void glue(gen_, name)(DisasContext *ctx)                         =
\
     {                                                                   =
\
         TCGv_ptr rb, rd;                                                =
\
         if (unlikely(!ctx->altivec_enabled)) {                          =
\
@@ -767,9 +771,9 @@ static void glue(gen_, name)(DisasContext *ctx)
         }                                                               =
\
         rb =3D gen_avr_ptr(rB(ctx->opcode));                            =
  \
         rd =3D gen_avr_ptr(rD(ctx->opcode));                            =
  \
-        gen_helper_##name (rd, rb);                                     =
\
+        gen_helper_##name(rd, rb);                                      =
\
         tcg_temp_free_ptr(rb);                                          =
\
-        tcg_temp_free_ptr(rd);                                         \
+        tcg_temp_free_ptr(rd);                                          =
\
     }
=20
 #define GEN_VXFORM_NOA_ENV(name, opc2, opc3)                            =
\
@@ -943,7 +947,7 @@ static void gen_vsldoi(DisasContext *ctx)
     rb =3D gen_avr_ptr(rB(ctx->opcode));
     rd =3D gen_avr_ptr(rD(ctx->opcode));
     sh =3D tcg_const_i32(VSH(ctx->opcode));
-    gen_helper_vsldoi (rd, ra, rb, sh);
+    gen_helper_vsldoi(rd, ra, rb, sh);
     tcg_temp_free_ptr(ra);
     tcg_temp_free_ptr(rb);
     tcg_temp_free_ptr(rd);
--=20
2.20.1
