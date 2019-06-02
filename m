Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F60C282DC
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 11:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E525278D7
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 11:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E525278D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47677 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXORb-0004Zb-7C
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 07:14:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hXOPg-0003Ls-Dw
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 07:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hXOPd-0003Z0-Nj
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 07:12:32 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:51402
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hXOPd-0002kU-I2; Sun, 02 Jun 2019 07:12:29 -0400
Received: from host81-158-188-206.range81-158.btcentralplus.com
	([81.158.188.206] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hXOLg-0008A4-F8; Sun, 02 Jun 2019 12:08:24 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
	rth@twiddle.net, gkurz@kaod.org
Date: Sun,  2 Jun 2019 12:08:56 +0100
Message-Id: <20190602110903.3431-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 81.158.188.206
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH v2 08/15] target/ppc: introduce
 GEN_VSX_HELPER_X2_AB macro to fpu_helper.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than perform the VSR register decoding within the helper itself,
introduce a new GEN_VSX_HELPER_X2_AB macro which performs the decode based
upon xA and xB at translation time.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/fpu_helper.c             | 15 ++++++---------
 target/ppc/helper.h                 | 12 ++++++------
 target/ppc/translate/vsx-impl.inc.c | 30 ++++++++++++++++++++++++------
 3 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index c7f5b49e03..628621d1b2 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2179,10 +2179,9 @@ VSX_RSQRTE(xvrsqrtesp, 4, float32, VsrW(i), 0, 0)
  *   nbits - number of fraction bits
  */
 #define VSX_TDIV(op, nels, tp, fld, emin, emax, nbits)                  \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                     \
+                 ppc_vsr_t *xa, ppc_vsr_t *xb)                          \
 {                                                                       \
-    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                              \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                              \
     int i;                                                              \
     int fe_flag = 0;                                                    \
     int fg_flag = 0;                                                    \
@@ -2431,10 +2430,9 @@ VSX_SCALAR_CMP_DP(xscmpgedp, le, 1, 1)
 VSX_SCALAR_CMP_DP(xscmpgtdp, lt, 1, 1)
 VSX_SCALAR_CMP_DP(xscmpnedp, eq, 0, 0)
 
-void helper_xscmpexpdp(CPUPPCState *env, uint32_t opcode)
+void helper_xscmpexpdp(CPUPPCState *env, uint32_t opcode,
+                       ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xa = &env->vsr[xA(opcode)];
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];
     int64_t exp_a, exp_b;
     uint32_t cc;
 
@@ -2492,10 +2490,9 @@ void helper_xscmpexpqp(CPUPPCState *env, uint32_t opcode)
 }
 
 #define VSX_SCALAR_CMP(op, ordered)                                      \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                      \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                      \
+                 ppc_vsr_t *xa, ppc_vsr_t *xb)                           \
 {                                                                        \
-    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                               \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                               \
     uint32_t cc = 0;                                                     \
     bool vxsnan_flag = false, vxvc_flag = false;                         \
                                                                          \
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index f56476ec41..0ab1ef2aee 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -375,7 +375,7 @@ DEF_HELPER_2(xsdivqp, void, env, i32)
 DEF_HELPER_3(xsredp, void, env, vsr, vsr)
 DEF_HELPER_3(xssqrtdp, void, env, vsr, vsr)
 DEF_HELPER_3(xsrsqrtedp, void, env, vsr, vsr)
-DEF_HELPER_2(xstdivdp, void, env, i32)
+DEF_HELPER_4(xstdivdp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xstsqrtdp, void, env, i32)
 DEF_HELPER_4(xsmaddadp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xsmaddmdp, void, env, vsr, vsr, vsr)
@@ -389,10 +389,10 @@ DEF_HELPER_4(xscmpeqdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xscmpgtdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xscmpgedp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xscmpnedp, void, env, vsr, vsr, vsr)
-DEF_HELPER_2(xscmpexpdp, void, env, i32)
+DEF_HELPER_4(xscmpexpdp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscmpexpqp, void, env, i32)
-DEF_HELPER_2(xscmpodp, void, env, i32)
-DEF_HELPER_2(xscmpudp, void, env, i32)
+DEF_HELPER_4(xscmpodp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xscmpudp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscmpoqp, void, env, i32)
 DEF_HELPER_2(xscmpuqp, void, env, i32)
 DEF_HELPER_4(xsmaxdp, void, env, vsr, vsr, vsr)
@@ -460,7 +460,7 @@ DEF_HELPER_4(xvdivdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_3(xvredp, void, env, vsr, vsr)
 DEF_HELPER_3(xvsqrtdp, void, env, vsr, vsr)
 DEF_HELPER_3(xvrsqrtedp, void, env, vsr, vsr)
-DEF_HELPER_2(xvtdivdp, void, env, i32)
+DEF_HELPER_4(xvtdivdp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xvtsqrtdp, void, env, i32)
 DEF_HELPER_4(xvmaddadp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvmaddmdp, void, env, vsr, vsr, vsr)
@@ -498,7 +498,7 @@ DEF_HELPER_4(xvdivsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_3(xvresp, void, env, vsr, vsr)
 DEF_HELPER_3(xvsqrtsp, void, env, vsr, vsr)
 DEF_HELPER_3(xvrsqrtesp, void, env, vsr, vsr)
-DEF_HELPER_2(xvtdivsp, void, env, i32)
+DEF_HELPER_4(xvtdivsp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xvtsqrtsp, void, env, i32)
 DEF_HELPER_4(xvmaddasp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvmaddmsp, void, env, vsr, vsr, vsr)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 1fb2bf7064..d8e9b80d4a 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1060,6 +1060,24 @@ static void gen_##name(DisasContext *ctx)                                     \
     tcg_temp_free_ptr(xb);                                                    \
 }
 
+#define GEN_VSX_HELPER_X2_AB(name, op1, op2, inval, type)                     \
+static void gen_##name(DisasContext *ctx)                                     \
+{                                                                             \
+    TCGv_i32 opc;                                                             \
+    TCGv_ptr xa, xb;                                                          \
+    if (unlikely(!ctx->vsx_enabled)) {                                        \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
+        return;                                                               \
+    }                                                                         \
+    opc = tcg_const_i32(ctx->opcode);                                         \
+    xa = gen_vsr_ptr(xA(ctx->opcode));                                        \
+    xb = gen_vsr_ptr(xB(ctx->opcode));                                        \
+    gen_helper_##name(cpu_env, opc, xa, xb);                                  \
+    tcg_temp_free_i32(opc);                                                   \
+    tcg_temp_free_ptr(xa);                                                    \
+    tcg_temp_free_ptr(xb);                                                    \
+}
+
 #define GEN_VSX_HELPER_XT_XB_ENV(name, op1, op2, inval, type) \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
@@ -1088,7 +1106,7 @@ GEN_VSX_HELPER_2(xsdivqp, 0x04, 0x11, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X2(xsredp, 0x14, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xssqrtdp, 0x16, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrsqrtedp, 0x14, 0x04, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xstdivdp, 0x14, 0x07, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2_AB(xstdivdp, 0x14, 0x07, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xstsqrtdp, 0x14, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaddadp, 0x04, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaddmdp, 0x04, 0x05, 0, PPC2_VSX)
@@ -1102,10 +1120,10 @@ GEN_VSX_HELPER_X3(xscmpeqdp, 0x0C, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xscmpgtdp, 0x0C, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xscmpgedp, 0x0C, 0x02, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xscmpnedp, 0x0C, 0x03, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscmpexpdp, 0x0C, 0x07, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X2_AB(xscmpexpdp, 0x0C, 0x07, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscmpexpqp, 0x04, 0x05, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscmpodp, 0x0C, 0x05, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xscmpudp, 0x0C, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2_AB(xscmpodp, 0x0C, 0x05, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2_AB(xscmpudp, 0x0C, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpoqp, 0x04, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpuqp, 0x04, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
@@ -1173,7 +1191,7 @@ GEN_VSX_HELPER_X3(xvdivdp, 0x00, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvredp, 0x14, 0x0D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvsqrtdp, 0x16, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtedp, 0x14, 0x0C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvtdivdp, 0x14, 0x0F, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2_AB(xvtdivdp, 0x14, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtsqrtdp, 0x14, 0x0E, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddadp, 0x04, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddmdp, 0x04, 0x0D, 0, PPC2_VSX)
@@ -1207,7 +1225,7 @@ GEN_VSX_HELPER_X3(xvdivsp, 0x00, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvresp, 0x14, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvsqrtsp, 0x16, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtesp, 0x14, 0x08, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvtdivsp, 0x14, 0x0B, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2_AB(xvtdivsp, 0x14, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtsqrtsp, 0x14, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddasp, 0x04, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddmsp, 0x04, 0x09, 0, PPC2_VSX)
-- 
2.11.0


