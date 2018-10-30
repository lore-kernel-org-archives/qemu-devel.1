Received: from eggs.gnu.org ([2001:4830:134:3::10]:37857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gHWCH-0002c0-C9
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gHWCC-0001kq-TP
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:44:49 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:51532 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gHWCC-0008VO-24
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:44:44 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 30 Oct 2018 16:44:07 +0100
Message-Id: <1540914249-3392-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540914249-3392-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540914249-3392-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/5] target/mips: Rename MMI-related
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Rename MMI-related functions.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 702d7ed..cbb80b3 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24682,7 +24682,7 @@ static void decode_opc_special3_legacy(CPUMIPSSta=
te *env, DisasContext *ctx)
     }
 }
=20
-static void decode_tx79_mmi0(CPUMIPSState *env, DisasContext *ctx)
+static void decode_mmi0(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc =3D MASK_MMI0(ctx->opcode);
=20
@@ -24715,13 +24715,13 @@ static void decode_tx79_mmi0(CPUMIPSState *env,=
 DisasContext *ctx)
         generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI=
0 */
         break;
     default:
-        MIPS_INVAL("TX79 MMI class MMI0");
+        MIPS_INVAL("MMI class MMI0");
         generate_exception_end(ctx, EXCP_RI);
         break;
     }
 }
=20
-static void decode_tx79_mmi1(CPUMIPSState *env, DisasContext *ctx)
+static void decode_mmi1(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc =3D MASK_MMI1(ctx->opcode);
=20
@@ -24747,13 +24747,13 @@ static void decode_tx79_mmi1(CPUMIPSState *env,=
 DisasContext *ctx)
         generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI=
1 */
         break;
     default:
-        MIPS_INVAL("TX79 MMI class MMI1");
+        MIPS_INVAL("MMI class MMI1");
         generate_exception_end(ctx, EXCP_RI);
         break;
     }
 }
=20
-static void decode_tx79_mmi2(CPUMIPSState *env, DisasContext *ctx)
+static void decode_mmi2(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc =3D MASK_MMI2(ctx->opcode);
=20
@@ -24783,13 +24783,13 @@ static void decode_tx79_mmi2(CPUMIPSState *env,=
 DisasContext *ctx)
         generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI=
2 */
         break;
     default:
-        MIPS_INVAL("TX79 MMI class MMI2");
+        MIPS_INVAL("MMI class MMI2");
         generate_exception_end(ctx, EXCP_RI);
         break;
     }
 }
=20
-static void decode_tx79_mmi3(CPUMIPSState *env, DisasContext *ctx)
+static void decode_mmi3(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc =3D MASK_MMI3(ctx->opcode);
=20
@@ -24810,13 +24810,13 @@ static void decode_tx79_mmi3(CPUMIPSState *env,=
 DisasContext *ctx)
         generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI=
3 */
         break;
     default:
-        MIPS_INVAL("TX79 MMI class MMI3");
+        MIPS_INVAL("MMI class MMI3");
         generate_exception_end(ctx, EXCP_RI);
         break;
     }
 }
=20
-static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
+static void decode_mmi(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc =3D MASK_MMI(ctx->opcode);
     int rs =3D extract32(ctx->opcode, 21, 5);
@@ -24825,16 +24825,16 @@ static void decode_tx79_mmi(CPUMIPSState *env, =
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
@@ -24868,18 +24868,18 @@ static void decode_tx79_mmi(CPUMIPSState *env, =
DisasContext *ctx)
         generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_CLASS_MMI =
*/
         break;
     default:
-        MIPS_INVAL("TX79 MMI class");
+        MIPS_INVAL("MMI class");
         generate_exception_end(ctx, EXCP_RI);
         break;
     }
 }
=20
-static void decode_tx79_lq(CPUMIPSState *env, DisasContext *ctx)
+static void decode_mmi_lq(CPUMIPSState *env, DisasContext *ctx)
 {
     generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_LQ */
 }
=20
-static void gen_tx79_sq(DisasContext *ctx, int base, int rt, int offset)
+static void gen_mmi_sq(DisasContext *ctx, int base, int rt, int offset)
 {
     generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_SQ */
 }
@@ -24905,7 +24905,7 @@ static void gen_tx79_sq(DisasContext *ctx, int ba=
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
@@ -24923,7 +24923,7 @@ static void decode_tx79_sq(CPUMIPSState *env, Dis=
asContext *ctx)
     }
 #endif
=20
-    gen_tx79_sq(ctx, base, rt, offset);
+    gen_mmi_sq(ctx, base, rt, offset);
 }
=20
 static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
@@ -26232,14 +26232,14 @@ static void decode_opc(CPUMIPSState *env, Disas=
Context *ctx)
         break;
     case OPC_SPECIAL2:
         if ((ctx->insn_flags & INSN_R5900) && (ctx->insn_flags & ASE_MMI=
)) {
-            decode_tx79_mmi(env, ctx);
+            decode_mmi(env, ctx);
         } else {
             decode_opc_special2_legacy(env, ctx);
         }
         break;
     case OPC_SPECIAL3:
         if (ctx->insn_flags & INSN_R5900) {
-            decode_tx79_sq(env, ctx);    /* MMI_SQ */
+            decode_mmi_sq(env, ctx);    /* MMI_SQ */
         } else {
             decode_opc_special3(env, ctx);
         }
@@ -26903,7 +26903,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
         break;
     case OPC_MSA: /* OPC_MDMX */
         if (ctx->insn_flags & INSN_R5900) {
-            decode_tx79_lq(env, ctx);    /* MMI_LQ */
+            decode_mmi_lq(env, ctx);    /* MMI_LQ */
         } else {
             /* MDMX: Not implemented. */
             gen_msa(env, ctx);
--=20
2.7.4
