Received: from eggs.gnu.org ([2001:4830:134:3::10]:51539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpdtM-0003Ns-4o
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpdsq-0005ts-Aj
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:04 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50089 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpdsp-0005bh-Sr
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:17:32 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 14 Aug 2018 20:16:45 +0200
Message-Id: <1534270621-27332-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534270621-27332-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534270621-27332-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 03/19] target/mips: Avoid case statements
 formulated by ranges - part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Remove "range style" case statements to make code analysis easier.
This patch handles cases when the values in the range in question
were not properly defined.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 78 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 7 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 051dda5..b944ea2 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -902,8 +902,21 @@ enum {
     OPC_MTTR     = (0x0C << 21) | OPC_CP0,
     OPC_WRPGPR   = (0x0E << 21) | OPC_CP0,
     OPC_C0       = (0x10 << 21) | OPC_CP0,
-    OPC_C0_FIRST = (0x10 << 21) | OPC_CP0,
-    OPC_C0_LAST  = (0x1F << 21) | OPC_CP0,
+    OPC_C0_1     = (0x11 << 21) | OPC_CP0,
+    OPC_C0_2     = (0x12 << 21) | OPC_CP0,
+    OPC_C0_3     = (0x13 << 21) | OPC_CP0,
+    OPC_C0_4     = (0x14 << 21) | OPC_CP0,
+    OPC_C0_5     = (0x15 << 21) | OPC_CP0,
+    OPC_C0_6     = (0x16 << 21) | OPC_CP0,
+    OPC_C0_7     = (0x17 << 21) | OPC_CP0,
+    OPC_C0_8     = (0x18 << 21) | OPC_CP0,
+    OPC_C0_9     = (0x19 << 21) | OPC_CP0,
+    OPC_C0_A     = (0x1A << 21) | OPC_CP0,
+    OPC_C0_B     = (0x1B << 21) | OPC_CP0,
+    OPC_C0_C     = (0x1C << 21) | OPC_CP0,
+    OPC_C0_D     = (0x1D << 21) | OPC_CP0,
+    OPC_C0_E     = (0x1E << 21) | OPC_CP0,
+    OPC_C0_F     = (0x1F << 21) | OPC_CP0,
 };
 
 /* MFMC0 opcodes */
@@ -12490,10 +12503,22 @@ enum {
 /* PCREL Instructions perform PC-Relative address calculation. bits 20..16 */
 enum {
     ADDIUPC_00 = 0x00,
+    ADDIUPC_01 = 0x01,
+    ADDIUPC_02 = 0x02,
+    ADDIUPC_03 = 0x03,
+    ADDIUPC_04 = 0x04,
+    ADDIUPC_05 = 0x05,
+    ADDIUPC_06 = 0x06,
     ADDIUPC_07 = 0x07,
     AUIPC = 0x1e,
     ALUIPC = 0x1f,
     LWPC_08 = 0x08,
+    LWPC_09 = 0x09,
+    LWPC_0A = 0x0A,
+    LWPC_0B = 0x0B,
+    LWPC_0C = 0x0C,
+    LWPC_0D = 0x0D,
+    LWPC_0E = 0x0E,
     LWPC_0F = 0x0F,
 };
 
@@ -12928,12 +12953,16 @@ enum {
     R6_LWM16    = 0x02,
     R6_JRC16    = 0x03,
     MOVEP       = 0x04,
+    MOVEP_05    = 0x05,
+    MOVEP_06    = 0x06,
     MOVEP_07    = 0x07,
     R6_XOR16    = 0x08,
     R6_OR16     = 0x09,
     R6_SWM16    = 0x0a,
     JALRC16     = 0x0b,
     MOVEP_0C    = 0x0c,
+    MOVEP_0D    = 0x0d,
+    MOVEP_0E    = 0x0e,
     MOVEP_0F    = 0x0f,
     JRCADDIUSP  = 0x13,
     R6_BREAK16  = 0x1b,
@@ -13251,8 +13280,14 @@ static void gen_pool16c_r6_insn(DisasContext *ctx)
             gen_compute_branch(ctx, OPC_JR, 2, rs, 0, 0, 0);
         }
         break;
-    case MOVEP ... MOVEP_07:
-    case MOVEP_0C ... MOVEP_0F:
+    case MOVEP:
+    case MOVEP_05:
+    case MOVEP_06:
+    case MOVEP_07:
+    case MOVEP_0C:
+    case MOVEP_0D:
+    case MOVEP_0E:
+    case MOVEP_0F:
         {
             int enc_dest = uMIPS_RD(ctx->opcode);
             int enc_rt = uMIPS_RS2(ctx->opcode);
@@ -15230,7 +15265,14 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
         if (ctx->insn_flags & ISA_MIPS32R6) {
             /* PCREL: ADDIUPC, AUIPC, ALUIPC, LWPC */
             switch ((ctx->opcode >> 16) & 0x1f) {
-            case ADDIUPC_00 ... ADDIUPC_07:
+            case ADDIUPC_00:
+            case ADDIUPC_01:
+            case ADDIUPC_02:
+            case ADDIUPC_03:
+            case ADDIUPC_04:
+            case ADDIUPC_05:
+            case ADDIUPC_06:
+            case ADDIUPC_07:
                 gen_pcrel(ctx, OPC_ADDIUPC, ctx->base.pc_next & ~0x3, rt);
                 break;
             case AUIPC:
@@ -15239,7 +15281,14 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             case ALUIPC:
                 gen_pcrel(ctx, OPC_ALUIPC, ctx->base.pc_next, rt);
                 break;
-            case LWPC_08 ... LWPC_0F:
+            case LWPC_08:
+            case LWPC_09:
+            case LWPC_0A:
+            case LWPC_0B:
+            case LWPC_0C:
+            case LWPC_0D:
+            case LWPC_0E:
+            case LWPC_0F:
                 gen_pcrel(ctx, R6_OPC_LWPC, ctx->base.pc_next & ~0x3, rt);
                 break;
             default:
@@ -19790,7 +19839,22 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
             gen_cp0(env, ctx, op1, rt, rd);
 #endif /* !CONFIG_USER_ONLY */
             break;
-        case OPC_C0_FIRST ... OPC_C0_LAST:
+        case OPC_C0:
+        case OPC_C0_1:
+        case OPC_C0_2:
+        case OPC_C0_3:
+        case OPC_C0_4:
+        case OPC_C0_5:
+        case OPC_C0_6:
+        case OPC_C0_7:
+        case OPC_C0_8:
+        case OPC_C0_9:
+        case OPC_C0_A:
+        case OPC_C0_B:
+        case OPC_C0_C:
+        case OPC_C0_D:
+        case OPC_C0_E:
+        case OPC_C0_F:
 #ifndef CONFIG_USER_ONLY
             gen_cp0(env, ctx, MASK_C0(ctx->opcode), rt, rd);
 #endif /* !CONFIG_USER_ONLY */
-- 
2.7.4
