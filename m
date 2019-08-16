Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE61C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 19:04:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3F5206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 19:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3F5206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyhWT-0008O1-5K
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 15:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1hyhVl-0007rN-HI
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 15:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1hyhVj-0006z0-UC
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 15:03:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>)
 id 1hyhVe-0006uU-Px; Fri, 16 Aug 2019 15:03:34 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7GIx3R6135991; Fri, 16 Aug 2019 15:03:28 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2udy92pc23-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Aug 2019 15:03:27 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7GJ0Bb0022291;
 Fri, 16 Aug 2019 19:03:26 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma01wdc.us.ibm.com with ESMTP id 2u9nj7bgfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Aug 2019 19:03:26 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7GJ3PfH47776186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2019 19:03:25 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EA8D7805E;
 Fri, 16 Aug 2019 19:03:25 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D39D47805C;
 Fri, 16 Aug 2019 19:03:24 +0000 (GMT)
Received: from localhost (unknown [9.85.198.236])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 16 Aug 2019 19:03:24 +0000 (GMT)
From: "Paul A. Clarke" <pc@us.ibm.com>
To: david@gibson.dropbear.id.au
Date: Fri, 16 Aug 2019 14:03:23 -0500
Message-Id: <1565982203-11048-1-git-send-email-pc@us.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-16_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=938 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160194
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v4] ppc: Add support for 'mffsl' instruction
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
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Paul A. Clarke" <pc@us.ibm.com>

ISA 3.0B added a set of Floating-Point Status and Control Register (FPSCR)
instructions: mffsce, mffscdrn, mffscdrni, mffscrn, mffscrni, mffsl.
This patch adds support for 'mffsl'.

'mffsl' is identical to 'mffs', except it only returns mode, status, and enable
bits from the FPSCR.

On CPUs without support for 'mffsl' (below ISA 3.0), the 'mffsl' instruction
will execute identically to 'mffs'.

Note: I renamed FPSCR_RN to FPSCR_RN0 so I could create an FPSCR_RN mask which
is both bits of the FPSCR rounding mode, as defined in the ISA.

I also fixed a typo in the definition of FPSCR_FR.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>

v4:
- nit: added some braces to resolve a checkpatch complaint.

v3:
- Changed tcg_gen_and_i64 to tcg_gen_andi_i64, eliminating the need for a
  temporary, per review from Richard Henderson.

v2:
- I found that I copied too much of the 'mffs' implementation.
  The 'Rc' condition code bits are not needed for 'mffsl'.  Removed.
- I now free the (renamed) 'tmask' temporary.
- I now bail early for older ISA to the original 'mffs' implementation.

---
 disas/ppc.c                        |  5 +++++
 target/ppc/cpu.h                   | 15 ++++++++++-----
 target/ppc/fpu_helper.c            |  4 ++--
 target/ppc/translate/fp-impl.inc.c | 22 ++++++++++++++++++++++
 target/ppc/translate/fp-ops.inc.c  |  4 +++-
 5 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/disas/ppc.c b/disas/ppc.c
index a545437..63e97cf 100644
--- a/disas/ppc.c
+++ b/disas/ppc.c
@@ -1765,6 +1765,9 @@ extract_tbr (unsigned long insn,
 /* An X_MASK with the RA and RB fields fixed.  */
 #define XRARB_MASK (X_MASK | RA_MASK | RB_MASK)
 
+/* An X form instruction with the RA field fixed.  */
+#define XRA(op, xop, ra) (X((op), (xop)) | (((ra) << 16) & XRA_MASK))
+
 /* An XRARB_MASK, but with the L bit clear.  */
 #define XRLARB_MASK (XRARB_MASK & ~((unsigned long) 1 << 16))
 
@@ -4998,6 +5001,8 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 { "ddivq",   XRC(63,546,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
 { "ddivq.",  XRC(63,546,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
 
+{ "mffsl",   XRA(63,583,12), XRARB_MASK,	POWER9,	{ FRT } },
+
 { "mffs",    XRC(63,583,0), XRARB_MASK,	COM,		{ FRT } },
 { "mffs.",   XRC(63,583,1), XRARB_MASK,	COM,		{ FRT } },
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c9beba2..74e8da4 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -591,7 +591,7 @@ enum {
 #define FPSCR_XE     3  /* Floating-point inexact exception enable           */
 #define FPSCR_NI     2  /* Floating-point non-IEEE mode                      */
 #define FPSCR_RN1    1
-#define FPSCR_RN     0  /* Floating-point rounding control                   */
+#define FPSCR_RN0    0  /* Floating-point rounding control                   */
 #define fpscr_fex    (((env->fpscr) >> FPSCR_FEX)    & 0x1)
 #define fpscr_vx     (((env->fpscr) >> FPSCR_VX)     & 0x1)
 #define fpscr_ox     (((env->fpscr) >> FPSCR_OX)     & 0x1)
@@ -614,7 +614,7 @@ enum {
 #define fpscr_ze     (((env->fpscr) >> FPSCR_ZE)     & 0x1)
 #define fpscr_xe     (((env->fpscr) >> FPSCR_XE)     & 0x1)
 #define fpscr_ni     (((env->fpscr) >> FPSCR_NI)     & 0x1)
-#define fpscr_rn     (((env->fpscr) >> FPSCR_RN)     & 0x3)
+#define fpscr_rn     (((env->fpscr) >> FPSCR_RN0)    & 0x3)
 /* Invalid operation exception summary */
 #define fpscr_ix ((env->fpscr) & ((1 << FPSCR_VXSNAN) | (1 << FPSCR_VXISI)  | \
                                   (1 << FPSCR_VXIDI)  | (1 << FPSCR_VXZDZ)  | \
@@ -640,7 +640,7 @@ enum {
 #define FP_VXZDZ        (1ull << FPSCR_VXZDZ)
 #define FP_VXIMZ        (1ull << FPSCR_VXIMZ)
 #define FP_VXVC         (1ull << FPSCR_VXVC)
-#define FP_FR           (1ull << FSPCR_FR)
+#define FP_FR           (1ull << FPSCR_FR)
 #define FP_FI           (1ull << FPSCR_FI)
 #define FP_C            (1ull << FPSCR_C)
 #define FP_FL           (1ull << FPSCR_FL)
@@ -648,7 +648,7 @@ enum {
 #define FP_FE           (1ull << FPSCR_FE)
 #define FP_FU           (1ull << FPSCR_FU)
 #define FP_FPCC         (FP_FL | FP_FG | FP_FE | FP_FU)
-#define FP_FPRF         (FP_C  | FP_FL | FP_FG | FP_FE | FP_FU)
+#define FP_FPRF         (FP_C | FP_FPCC)
 #define FP_VXSOFT       (1ull << FPSCR_VXSOFT)
 #define FP_VXSQRT       (1ull << FPSCR_VXSQRT)
 #define FP_VXCVI        (1ull << FPSCR_VXCVI)
@@ -659,7 +659,12 @@ enum {
 #define FP_XE           (1ull << FPSCR_XE)
 #define FP_NI           (1ull << FPSCR_NI)
 #define FP_RN1          (1ull << FPSCR_RN1)
-#define FP_RN           (1ull << FPSCR_RN)
+#define FP_RN0          (1ull << FPSCR_RN0)
+#define FP_RN           (FP_RN1 | FP_RN0)
+
+#define FP_MODE         FP_RN
+#define FP_ENABLES      (FP_VE | FP_OE | FP_UE | FP_ZE | FP_XE)
+#define FP_STATUS       (FP_FR | FP_FI | FP_FPRF)
 
 /* the exception bits which can be cleared by mcrfs - includes FX */
 #define FP_EX_CLEAR_BITS (FP_FX     | FP_OX     | FP_UX     | FP_ZX     | \
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index f437c88..5611cf0 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -403,7 +403,7 @@ void helper_fpscr_clrbit(CPUPPCState *env, uint32_t bit)
     if (prev == 1) {
         switch (bit) {
         case FPSCR_RN1:
-        case FPSCR_RN:
+        case FPSCR_RN0:
             fpscr_set_rounding_mode(env);
             break;
         case FPSCR_VXSNAN:
@@ -557,7 +557,7 @@ void helper_fpscr_setbit(CPUPPCState *env, uint32_t bit)
             }
             break;
         case FPSCR_RN1:
-        case FPSCR_RN:
+        case FPSCR_RN0:
             fpscr_set_rounding_mode(env);
             break;
         default:
diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp-impl.inc.c
index 9dcff94..7cd9d8d 100644
--- a/target/ppc/translate/fp-impl.inc.c
+++ b/target/ppc/translate/fp-impl.inc.c
@@ -617,6 +617,28 @@ static void gen_mffs(DisasContext *ctx)
     tcg_temp_free_i64(t0);
 }
 
+/* mffsl */
+static void gen_mffsl(DisasContext *ctx)
+{
+    TCGv_i64 t0;
+
+    if (unlikely(!(ctx->insns_flags2 & PPC2_ISA300))) {
+        return gen_mffs(ctx);
+    }
+
+    if (unlikely(!ctx->fpu_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_FPU);
+        return;
+    }
+    t0 = tcg_temp_new_i64();
+    gen_reset_fpstatus();
+    tcg_gen_extu_tl_i64(t0, cpu_fpscr);
+    /* Mask everything except mode, status, and enables.  */
+    tcg_gen_andi_i64(t0, t0, FP_MODE | FP_STATUS | FP_ENABLES);
+    set_fpr(rD(ctx->opcode), t0);
+    tcg_temp_free_i64(t0);
+}
+
 /* mtfsb0 */
 static void gen_mtfsb0(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/fp-ops.inc.c b/target/ppc/translate/fp-ops.inc.c
index 621f6bf..88ebc25 100644
--- a/target/ppc/translate/fp-ops.inc.c
+++ b/target/ppc/translate/fp-ops.inc.c
@@ -104,7 +104,9 @@ GEN_HANDLER_E(fcpsgn, 0x3F, 0x08, 0x00, 0x00000000, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER_E(fmrgew, 0x3F, 0x06, 0x1E, 0x00000001, PPC_NONE, PPC2_VSX207),
 GEN_HANDLER_E(fmrgow, 0x3F, 0x06, 0x1A, 0x00000001, PPC_NONE, PPC2_VSX207),
 GEN_HANDLER(mcrfs, 0x3F, 0x00, 0x02, 0x0063F801, PPC_FLOAT),
-GEN_HANDLER(mffs, 0x3F, 0x07, 0x12, 0x001FF800, PPC_FLOAT),
+GEN_HANDLER_E_2(mffs, 0x3F, 0x07, 0x12, 0x00, 0x00000000, PPC_FLOAT, PPC_NONE),
+GEN_HANDLER_E_2(mffsl, 0x3F, 0x07, 0x12, 0x18, 0x00000000, PPC_FLOAT,
+    PPC2_ISA300),
 GEN_HANDLER(mtfsb0, 0x3F, 0x06, 0x02, 0x001FF800, PPC_FLOAT),
 GEN_HANDLER(mtfsb1, 0x3F, 0x06, 0x01, 0x001FF800, PPC_FLOAT),
 GEN_HANDLER(mtfsf, 0x3F, 0x07, 0x16, 0x00000000, PPC_FLOAT),
-- 
1.8.3.1


