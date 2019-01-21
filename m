Received: from eggs.gnu.org ([209.51.188.92]:40260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1glexJ-0001mz-Hy
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1glexI-0004Lo-Kv
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:09:57 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:50412 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1glexI-0003uF-5D
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:09:56 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 21 Jan 2019 20:08:15 +0100
Message-Id: <1548097698-28951-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548097698-28951-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1548097698-28951-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 3/6] target/mips: nanoMIPS: Rename macros for
 extracting 3-bit GPR codes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Rename macros for extracting 3-bit GPR codes for better consistency
with the documentation.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index aad760c..ceaa582 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -18391,9 +18391,9 @@ enum {
 
 /* extraction utilities */
 
-#define NANOMIPS_EXTRACT_RD(op) ((op >> 7) & 0x7)
-#define NANOMIPS_EXTRACT_RS(op) ((op >> 4) & 0x7)
-#define NANOMIPS_EXTRACT_RS1(op) ((op >> 1) & 0x7)
+#define NANOMIPS_EXTRACT_RT3(op) ((op >> 7) & 0x7)
+#define NANOMIPS_EXTRACT_RS3(op) ((op >> 4) & 0x7)
+#define NANOMIPS_EXTRACT_RD3(op) ((op >> 1) & 0x7)
 #define NANOMIPS_EXTRACT_RD5(op) ((op >> 5) & 0x1f)
 #define NANOMIPS_EXTRACT_RS5(op) (op & 0x1f)
 
@@ -18490,8 +18490,8 @@ static void gen_restore(DisasContext *ctx, uint8_t rt, uint8_t count,
 
 static void gen_pool16c_nanomips_insn(DisasContext *ctx)
 {
-    int rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD(ctx->opcode));
-    int rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS(ctx->opcode));
+    int rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RT3(ctx->opcode));
+    int rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS3(ctx->opcode));
 
     switch (extract32(ctx->opcode, 2, 2)) {
     case NM_NOT16:
@@ -21792,9 +21792,9 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
 static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t op;
-    int rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD(ctx->opcode));
-    int rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS(ctx->opcode));
-    int rd = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS1(ctx->opcode));
+    int rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RT3(ctx->opcode));
+    int rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS3(ctx->opcode));
+    int rd = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD3(ctx->opcode));
     int offset;
     int imm;
 
@@ -21957,7 +21957,7 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
             break;
         case NM_SB16:
             rt = decode_gpr_gpr3_src_store(
-                     NANOMIPS_EXTRACT_RD(ctx->opcode));
+                     NANOMIPS_EXTRACT_RT3(ctx->opcode));
             gen_st(ctx, OPC_SB, rt, rs, offset);
             break;
         case NM_LBU16:
@@ -21976,7 +21976,7 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
             break;
         case NM_SH16:
             rt = decode_gpr_gpr3_src_store(
-                     NANOMIPS_EXTRACT_RD(ctx->opcode));
+                     NANOMIPS_EXTRACT_RT3(ctx->opcode));
             gen_st(ctx, OPC_SH, rt, rs, offset);
             break;
         case NM_LHU16:
@@ -22031,14 +22031,14 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
         break;
     case NM_SW16:
         rt = decode_gpr_gpr3_src_store(
-                 NANOMIPS_EXTRACT_RD(ctx->opcode));
-        rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS(ctx->opcode));
+                 NANOMIPS_EXTRACT_RT3(ctx->opcode));
+        rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS3(ctx->opcode));
         offset = extract32(ctx->opcode, 0, 4) << 2;
         gen_st(ctx, OPC_SW, rt, rs, offset);
         break;
     case NM_SWGP16:
         rt = decode_gpr_gpr3_src_store(
-                 NANOMIPS_EXTRACT_RD(ctx->opcode));
+                 NANOMIPS_EXTRACT_RT3(ctx->opcode));
         offset = extract32(ctx->opcode, 0, 7) << 2;
         gen_st(ctx, OPC_SW, rt, 28, offset);
         break;
-- 
2.7.4
