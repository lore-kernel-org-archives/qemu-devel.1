Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5BCC32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 16:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9177D2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 16:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9177D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxvw1-0007Qt-Io
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 12:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1hxvv3-0006nl-Ha
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1hxvv2-0000pK-07
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:14:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54874
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>)
 id 1hxvux-0000jJ-BJ; Wed, 14 Aug 2019 12:14:31 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7EGBtlD024067; Wed, 14 Aug 2019 12:14:25 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ucmp7jjpa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Aug 2019 12:14:24 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7EGB0uA018412;
 Wed, 14 Aug 2019 16:14:24 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma02wdc.us.ibm.com with ESMTP id 2u9nj6479y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Aug 2019 16:14:24 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7EGENJi53018928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Aug 2019 16:14:23 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A2C778063;
 Wed, 14 Aug 2019 16:14:23 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEFEA7805F;
 Wed, 14 Aug 2019 16:14:22 +0000 (GMT)
Received: from localhost (unknown [9.85.151.40])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 14 Aug 2019 16:14:22 +0000 (GMT)
From: "Paul A. Clarke" <pc@us.ibm.com>
To: david@gibson.dropbear.id.au
Date: Wed, 14 Aug 2019 11:14:21 -0500
Message-Id: <1565799261-498-1-git-send-email-pc@us.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-14_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=900 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140156
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v3] ppc: Add support for 'mffsl' instruction
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
 target/ppc/translate/fp-impl.inc.c | 21 +++++++++++++++++++++
 target/ppc/translate/fp-ops.inc.c  |  4 +++-
 5 files changed, 41 insertions(+), 8 deletions(-)

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
index 9dcff94..f5717e3 100644
--- a/target/ppc/translate/fp-impl.inc.c
+++ b/target/ppc/translate/fp-impl.inc.c
@@ -617,6 +617,27 @@ static void gen_mffs(DisasContext *ctx)
     tcg_temp_free_i64(t0);
 }
 
+/* mffsl */
+static void gen_mffsl(DisasContext *ctx)
+{
+    TCGv_i64 t0;
+
+    if (unlikely(!(ctx->insns_flags2 & PPC2_ISA300)))
+        return gen_mffs(ctx);
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


