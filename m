Received: from eggs.gnu.org ([2001:4830:134:3::10]:44454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gO2x0-0003xI-Kc
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gO2wy-0000gs-NH
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:56:02 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60467 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gO2wy-0000gA-Aw
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:56:00 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Sat, 17 Nov 2018 16:54:38 +0100
Message-Id: <1542470080-5797-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1542470080-5797-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1542470080-5797-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/11] target/mips: Rename MMI-related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Rename MMI-related functions.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 98dc468..e9c23a5 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -26464,7 +26464,7 @@ static void decode_opc_special3_legacy(CPUMIPSSta=
te *env, DisasContext *ctx)
     }
 }
=20
-static void decode_tx79_mmi0(CPUMIPSState *env, DisasContext *ctx)
+static void decode_mmi0(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc =3D MASK_MMI0(ctx->opcode);
=20
@@ -26503,7 +26503,7 @@ static void decode_tx79_mmi0(CPUMIPSState *env, D=
isasContext *ctx)
     }
 }
=20
-static void decode_tx79_mmi1(CPUMIPSState *env, DisasContext *ctx)
+static void decode_mmi1(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc =3D MASK_MMI1(ctx->opcode);
=20
@@ -26535,7 +26535,7 @@ static void decode_tx79_mmi1(CPUMIPSState *env, D=
isasContext *ctx)
     }
 }
=20
-static void decode_tx79_mmi2(CPUMIPSState *env, DisasContext *ctx)
+static void decode_mmi2(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc =3D MASK_MMI2(ctx->opcode);
=20
@@ -26571,7 +26571,7 @@ static void decode_tx79_mmi2(CPUMIPSState *env, D=
isasContext *ctx)
     }
 }
=20
-static void decode_tx79_mmi3(CPUMIPSState *env, DisasContext *ctx)
+static void decode_mmi3(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc =3D MASK_MMI3(ctx->opcode);
=20
@@ -26598,7 +26598,7 @@ static void decode_tx79_mmi3(CPUMIPSState *env, D=
isasContext *ctx)
     }
 }
=20
-static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
+static void decode_mmi(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc =3D MASK_MMI(ctx->opcode);
     int rs =3D extract32(ctx->opcode, 21, 5);
@@ -26607,16 +26607,16 @@ static void decode_tx79_mmi(CPUMIPSState *env, =
DisasContext *ctx)
=20
     switch (opc) {
     case MMI_OPC_CLASS_MMI0:
-        decode_tx79_mmi0(env, ctx);
+        decode_mmi0(env, ctx);
         break;
     case MMI_OPC_CLASS_MMI1:
-        decode_tx79_mmi1(env, ctx);
+        decode_mmi1(env, ctx);
         break;
     case MMI_OPC_CLASS_MMI2:
-        decode_tx79_mmi2(env, ctx);
+        decode_mmi2(env, ctx);
         break;
     case MMI_OPC_CLASS_MMI3:
-        decode_tx79_mmi3(env, ctx);
+        decode_mmi3(env, ctx);
         break;
     case MMI_OPC_MULT1:
     case MMI_OPC_MULTU1:
@@ -26656,12 +26656,12 @@ static void decode_tx79_mmi(CPUMIPSState *env, =
DisasContext *ctx)
     }
 }
=20
-static void decode_tx79_lq(CPUMIPSState *env, DisasContext *ctx)
+static void gen_mmi_lq(CPUMIPSState *env, DisasContext *ctx)
 {
     generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_OPC_LQ */
 }
=20
-static void gen_tx79_sq(DisasContext *ctx, int base, int rt, int offset)
+static void gen_mmi_sq(DisasContext *ctx, int base, int rt, int offset)
 {
     generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_OPC_SQ */
 }
@@ -26687,7 +26687,7 @@ static void gen_tx79_sq(DisasContext *ctx, int ba=
se, int rt, int offset)
  * In user mode, QEMU must verify the upper and lower 11 bits to disting=
uish
  * between SQ and RDHWR, as the Linux kernel does.
  */
-static void decode_tx79_sq(CPUMIPSState *env, DisasContext *ctx)
+static void decode_mmi_sq(CPUMIPSState *env, DisasContext *ctx)
 {
     int base =3D extract32(ctx->opcode, 21, 5);
     int rt =3D extract32(ctx->opcode, 16, 5);
@@ -26705,7 +26705,7 @@ static void decode_tx79_sq(CPUMIPSState *env, Dis=
asContext *ctx)
     }
 #endif
=20
-    gen_tx79_sq(ctx, base, rt, offset);
+    gen_mmi_sq(ctx, base, rt, offset);
 }
=20
 static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
@@ -28014,7 +28014,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
         break;
     case OPC_SPECIAL2:
         if ((ctx->insn_flags & INSN_R5900) && (ctx->insn_flags & ASE_MMI=
)) {
-            decode_tx79_mmi(env, ctx);
+            decode_mmi(env, ctx);
         } else if (ctx->insn_flags & ASE_MXU) {
             decode_opc_mxu(env, ctx);
         } else {
@@ -28023,7 +28023,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
         break;
     case OPC_SPECIAL3:
         if (ctx->insn_flags & INSN_R5900) {
-            decode_tx79_sq(env, ctx);    /* MMI_OPC_SQ */
+            decode_mmi_sq(env, ctx);    /* MMI_OPC_SQ */
         } else {
             decode_opc_special3(env, ctx);
         }
@@ -28698,7 +28698,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
         break;
     case OPC_MSA: /* OPC_MDMX */
         if (ctx->insn_flags & INSN_R5900) {
-            decode_tx79_lq(env, ctx);    /* MMI_OPC_LQ */
+            gen_mmi_lq(env, ctx);    /* MMI_OPC_LQ */
         } else {
             /* MDMX: Not implemented. */
             gen_msa(env, ctx);
--=20
2.7.4
