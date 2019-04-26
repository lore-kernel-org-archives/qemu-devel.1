Received: from eggs.gnu.org ([209.51.188.92]:60449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu10-00063D-2D
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0y-00056m-7P
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:18 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:18 +1000
Message-Id: <20190426060627.18153-28-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/36] target/ppc: Style fixes for
 translate/spe-impl.inc.c
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
 target/ppc/translate/spe-impl.inc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate/spe-impl.inc.c b/target/ppc/translate/s=
pe-impl.inc.c
index 8c1c16c63e..7ab0a29b5f 100644
--- a/target/ppc/translate/spe-impl.inc.c
+++ b/target/ppc/translate/spe-impl.inc.c
@@ -18,7 +18,8 @@ static inline void gen_evmra(DisasContext *ctx)
     TCGv_i64 tmp =3D tcg_temp_new_i64();
=20
     /* tmp :=3D rA_lo + rA_hi << 32 */
-    tcg_gen_concat_tl_i64(tmp, cpu_gpr[rA(ctx->opcode)], cpu_gprh[rA(ctx=
->opcode)]);
+    tcg_gen_concat_tl_i64(tmp, cpu_gpr[rA(ctx->opcode)],
+                          cpu_gprh[rA(ctx->opcode)]);
=20
     /* spe_acc :=3D tmp */
     tcg_gen_st_i64(tmp, cpu_env, offsetof(CPUPPCState, spe_acc));
@@ -780,7 +781,7 @@ static inline void gen_op_evstwwo(DisasContext *ctx, =
TCGv addr)
 }
=20
 #define GEN_SPEOP_LDST(name, opc2, sh)                                  =
      \
-static void glue(gen_, name)(DisasContext *ctx)                         =
              \
+static void glue(gen_, name)(DisasContext *ctx)                         =
      \
 {                                                                       =
      \
     TCGv t0;                                                            =
      \
     if (unlikely(!ctx->spe_enabled)) {                                  =
      \
@@ -1089,7 +1090,8 @@ static inline void gen_efsabs(DisasContext *ctx)
         gen_exception(ctx, POWERPC_EXCP_SPEU);
         return;
     }
-    tcg_gen_andi_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)], =
(target_long)~0x80000000LL);
+    tcg_gen_andi_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
+                    (target_long)~0x80000000LL);
 }
 static inline void gen_efsnabs(DisasContext *ctx)
 {
@@ -1097,7 +1099,8 @@ static inline void gen_efsnabs(DisasContext *ctx)
         gen_exception(ctx, POWERPC_EXCP_SPEU);
         return;
     }
-    tcg_gen_ori_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)], 0=
x80000000);
+    tcg_gen_ori_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
+                   0x80000000);
 }
 static inline void gen_efsneg(DisasContext *ctx)
 {
@@ -1105,7 +1108,8 @@ static inline void gen_efsneg(DisasContext *ctx)
         gen_exception(ctx, POWERPC_EXCP_SPEU);
         return;
     }
-    tcg_gen_xori_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)], =
0x80000000);
+    tcg_gen_xori_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
+                    0x80000000);
 }
=20
 /* Conversion */
--=20
2.20.1
