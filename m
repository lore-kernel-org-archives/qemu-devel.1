Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D072C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 17:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E2F2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 17:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E2F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9uRf-0005hk-76
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 13:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1i9uPx-00042x-Sf
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1i9uPt-0001qy-P9
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:04:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12020
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>)
 id 1i9uPf-0001gp-DB; Mon, 16 Sep 2019 13:03:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8GGxoAO107385; Mon, 16 Sep 2019 13:03:10 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v2bcjqbbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2019 13:03:01 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8GH1QKv021552;
 Mon, 16 Sep 2019 17:02:17 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma03dal.us.ibm.com with ESMTP id 2v0svqee4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2019 17:02:17 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8GH2Gai53019076
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Sep 2019 17:02:16 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4C862805A;
 Mon, 16 Sep 2019 17:02:16 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8636D2805C;
 Mon, 16 Sep 2019 17:02:16 +0000 (GMT)
Received: from localhost (unknown [9.41.247.5])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 16 Sep 2019 17:02:16 +0000 (GMT)
From: "Paul A. Clarke" <pc@us.ibm.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 12:02:16 -0500
Message-Id: <1568653336-16819-1-git-send-email-pc@us.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-16_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=844 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909160168
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v2 1/2] ppc: Add support for 'mffscrn',
 'mffscrni' instructions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Paul A. Clarke" <pc@us.ibm.com>

ISA 3.0B added a set of Floating-Point Status and Control Register (FPSCR)
instructions: mffsce, mffscdrn, mffscdrni, mffscrn, mffscrni, mffsl.
This patch adds support for 'mffscrn' and 'mffscrni' instructions.

'mffscrn' and 'mffscrni' are similar to 'mffsl', except they do not return
the status bits (FI, FR, FPRF) and they also set the rounding mode in the
FPSCR.

On CPUs without support for 'mffscrn'/'mffscrni' (below ISA 3.0), the
instructions will execute identically to 'mffs'.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
v2:
- Add DRN to returned FPSCR value.
- Add DRN defines to target/ppc/cpu.h.

 target/ppc/cpu.h                   | 10 +++++-
 target/ppc/dfp_helper.c            |  2 +-
 target/ppc/internal.h              |  3 ++
 target/ppc/translate/fp-impl.inc.c | 67 ++++++++++++++++++++++++++++++++++++++
 target/ppc/translate/fp-ops.inc.c  |  4 +++
 5 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index eaee1a5..dcea2f0 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -559,6 +559,9 @@ enum {
 
 /*****************************************************************************/
 /* Floating point status and control register                                */
+#define FPSCR_DRN2   34 /* Decimal Floating-Point rounding control           */
+#define FPSCR_DRN1   33 /* Decimal Floating-Point rounding control           */
+#define FPSCR_DRN0   32 /* Decimal Floating-Point rounding control           */
 #define FPSCR_FX     31 /* Floating-point exception summary                  */
 #define FPSCR_FEX    30 /* Floating-point enabled exception summary          */
 #define FPSCR_VX     29 /* Floating-point invalid operation exception summ.  */
@@ -592,6 +595,7 @@ enum {
 #define FPSCR_NI     2  /* Floating-point non-IEEE mode                      */
 #define FPSCR_RN1    1
 #define FPSCR_RN0    0  /* Floating-point rounding control                   */
+#define fpscr_drn    (((env->fpscr) & FP_DRN) >> FPSCR_DRN0)
 #define fpscr_fex    (((env->fpscr) >> FPSCR_FEX)    & 0x1)
 #define fpscr_vx     (((env->fpscr) >> FPSCR_VX)     & 0x1)
 #define fpscr_ox     (((env->fpscr) >> FPSCR_OX)     & 0x1)
@@ -627,6 +631,10 @@ enum {
 #define fpscr_eex (((env->fpscr) >> FPSCR_XX) & ((env->fpscr) >> FPSCR_XE) &  \
                    0x1F)
 
+#define FP_DRN2         (1ull << FPSCR_DRN2)
+#define FP_DRN1         (1ull << FPSCR_DRN1)
+#define FP_DRN0         (1ull << FPSCR_DRN0)
+#define FP_DRN          (FP_DRN2 | FP_DRN1 | FP_DRN0)
 #define FP_FX           (1ull << FPSCR_FX)
 #define FP_FEX          (1ull << FPSCR_FEX)
 #define FP_VX           (1ull << FPSCR_VX)
@@ -662,7 +670,7 @@ enum {
 #define FP_RN0          (1ull << FPSCR_RN0)
 #define FP_RN           (FP_RN1 | FP_RN0)
 
-#define FP_MODE         FP_RN
+#define FP_MODE         (FP_DRN | FP_RN)
 #define FP_ENABLES      (FP_VE | FP_OE | FP_UE | FP_ZE | FP_XE)
 #define FP_STATUS       (FP_FR | FP_FI | FP_FPRF)
 
diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
index f102177..da8e08a 100644
--- a/target/ppc/dfp_helper.c
+++ b/target/ppc/dfp_helper.c
@@ -48,7 +48,7 @@ static void dfp_prepare_rounding_mode(decContext *context, uint64_t fpscr)
 {
     enum rounding rnd;
 
-    switch ((fpscr >> 32) & 0x7) {
+    switch ((fpscr & FP_DRN) >> FPSCR_DRN0) {
     case 0:
         rnd = DEC_ROUND_HALF_EVEN;
         break;
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index d3d327e..15d655b 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -157,6 +157,9 @@ EXTRACT_HELPER(FPL, 25, 1);
 EXTRACT_HELPER(FPFLM, 17, 8);
 EXTRACT_HELPER(FPW, 16, 1);
 
+/* mffscrni */
+EXTRACT_HELPER(RM, 11, 2);
+
 /* addpcis */
 EXTRACT_HELPER_SPLIT_3(DX, 10, 6, 6, 5, 16, 1, 1, 0, 0)
 #if defined(TARGET_PPC64)
diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp-impl.inc.c
index 7cd9d8d..59a4faf 100644
--- a/target/ppc/translate/fp-impl.inc.c
+++ b/target/ppc/translate/fp-impl.inc.c
@@ -639,6 +639,73 @@ static void gen_mffsl(DisasContext *ctx)
     tcg_temp_free_i64(t0);
 }
 
+static void gen_helper_mffscrn(DisasContext *ctx, TCGv_i64 t1)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i32 mask = tcg_const_i32(0x0001);
+
+    gen_reset_fpstatus();
+    tcg_gen_extu_tl_i64(t0, cpu_fpscr);
+    tcg_gen_andi_i64(t0, t0, FP_MODE | FP_ENABLES);
+    set_fpr(rD(ctx->opcode), t0);
+
+    /* Mask FPSCR value to clear RN.  */
+    tcg_gen_andi_i64(t0, t0, ~FP_MODE);
+
+    /* Merge RN into FPSCR value.  */
+    tcg_gen_or_i64(t0, t0, t1);
+
+    gen_helper_store_fpscr(cpu_env, t0, mask);
+
+    tcg_temp_free_i32(mask);
+    tcg_temp_free_i64(t0);
+}
+
+/* mffscrn */
+static void gen_mffscrn(DisasContext *ctx)
+{
+    TCGv_i64 t1;
+
+    if (unlikely(!(ctx->insns_flags2 & PPC2_ISA300))) {
+        return gen_mffs(ctx);
+    }
+
+    if (unlikely(!ctx->fpu_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_FPU);
+        return;
+    }
+
+    t1 = tcg_temp_new_i64();
+    get_fpr(t1, rB(ctx->opcode));
+    /* Mask FRB to get just RN.  */
+    tcg_gen_andi_i64(t1, t1, FP_MODE);
+
+    gen_helper_mffscrn(ctx, t1);
+
+    tcg_temp_free_i64(t1);
+}
+
+/* mffscrni */
+static void gen_mffscrni(DisasContext *ctx)
+{
+    TCGv_i64 t1;
+
+    if (unlikely(!(ctx->insns_flags2 & PPC2_ISA300))) {
+        return gen_mffs(ctx);
+    }
+
+    if (unlikely(!ctx->fpu_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_FPU);
+        return;
+    }
+
+    t1 = tcg_const_i64((uint64_t)RM(ctx->opcode));
+
+    gen_helper_mffscrn(ctx, t1);
+
+    tcg_temp_free_i64(t1);
+}
+
 /* mtfsb0 */
 static void gen_mtfsb0(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/fp-ops.inc.c b/target/ppc/translate/fp-ops.inc.c
index 88ebc25..f2bcf0e 100644
--- a/target/ppc/translate/fp-ops.inc.c
+++ b/target/ppc/translate/fp-ops.inc.c
@@ -107,6 +107,10 @@ GEN_HANDLER(mcrfs, 0x3F, 0x00, 0x02, 0x0063F801, PPC_FLOAT),
 GEN_HANDLER_E_2(mffs, 0x3F, 0x07, 0x12, 0x00, 0x00000000, PPC_FLOAT, PPC_NONE),
 GEN_HANDLER_E_2(mffsl, 0x3F, 0x07, 0x12, 0x18, 0x00000000, PPC_FLOAT,
     PPC2_ISA300),
+GEN_HANDLER_E_2(mffscrn, 0x3F, 0x07, 0x12, 0x16, 0x00000000, PPC_FLOAT,
+    PPC_NONE),
+GEN_HANDLER_E_2(mffscrni, 0x3F, 0x07, 0x12, 0x17, 0x00000000, PPC_FLOAT,
+    PPC_NONE),
 GEN_HANDLER(mtfsb0, 0x3F, 0x06, 0x02, 0x001FF800, PPC_FLOAT),
 GEN_HANDLER(mtfsb1, 0x3F, 0x06, 0x01, 0x001FF800, PPC_FLOAT),
 GEN_HANDLER(mtfsf, 0x3F, 0x07, 0x16, 0x00000000, PPC_FLOAT),
-- 
1.8.3.1


