Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE55BC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 14:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B8120665
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 14:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B8120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAb3r-0002jV-RM
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 10:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1iAb1x-0001XO-K7
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 10:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1iAb1u-0007PW-5d
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 10:34:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>)
 id 1iAb1p-0007N8-Et; Wed, 18 Sep 2019 10:33:57 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8IEPaIU131495; Wed, 18 Sep 2019 10:32:52 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v3nwf9f2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2019 10:32:52 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8IEV3Op032517;
 Wed, 18 Sep 2019 14:32:51 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03dal.us.ibm.com with ESMTP id 2v37jwfeqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2019 14:32:51 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8IEWoXs59244968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Sep 2019 14:32:50 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FB6A136059;
 Wed, 18 Sep 2019 14:32:50 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05F06136053;
 Wed, 18 Sep 2019 14:32:49 +0000 (GMT)
Received: from localhost (unknown [9.160.70.45])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 18 Sep 2019 14:32:49 +0000 (GMT)
From: "Paul A. Clarke" <pc@us.ibm.com>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 09:32:49 -0500
Message-Id: <1568817169-1721-1-git-send-email-pc@us.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-18_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=822 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909180144
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH] ppc: Use FPSCR defines instead of constants
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

There are FPSCR-related defines in target/ppc/cpu.h which can be used in
place of constants and explicit shifts which arguably improve the code a
bit in places.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
I confirmed that the generated assembly is identical before and after
the patch.

 target/ppc/dfp_helper.c |   8 ++--
 target/ppc/fpu_helper.c | 122 ++++++++++++++++++++++++------------------------
 2 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
index da8e08a..7533991 100644
--- a/target/ppc/dfp_helper.c
+++ b/target/ppc/dfp_helper.c
@@ -220,8 +220,8 @@ static void dfp_set_FPRF_from_FRT_with_context(struct PPC_DFP *dfp,
     default:
         assert(0); /* should never get here */
     }
-    dfp->env->fpscr &= ~(0x1F << 12);
-    dfp->env->fpscr |= (fprf << 12);
+    dfp->env->fpscr &= ~FP_FPRF;
+    dfp->env->fpscr |= (fprf << FPSCR_FPRF);
 }
 
 static void dfp_set_FPRF_from_FRT(struct PPC_DFP *dfp)
@@ -369,8 +369,8 @@ static void dfp_set_CRBF_from_T(struct PPC_DFP *dfp)
 
 static void dfp_set_FPCC_from_CRBF(struct PPC_DFP *dfp)
 {
-    dfp->env->fpscr &= ~(0xF << 12);
-    dfp->env->fpscr |= (dfp->crbf << 12);
+    dfp->env->fpscr &= ~FP_FPCC;
+    dfp->env->fpscr |= (dfp->crbf << FPSCR_FPCC);
 }
 
 static inline void dfp_makeQNaN(decNumber *dn)
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 4b1a2e6..dc38324 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -180,7 +180,7 @@ static void set_fprf_from_class(CPUPPCState *env, int class)
     };
     bool isneg = class & is_neg;
 
-    env->fpscr &= ~(0x1F << FPSCR_FPRF);
+    env->fpscr &= ~FP_FPRF;
     env->fpscr |= fprf[ctz32(class)][isneg] << FPSCR_FPRF;
 }
 
@@ -199,12 +199,12 @@ COMPUTE_FPRF(float128)
 static void finish_invalid_op_excp(CPUPPCState *env, int op, uintptr_t retaddr)
 {
     /* Update the floating-point invalid operation summary */
-    env->fpscr |= 1 << FPSCR_VX;
+    env->fpscr |= FP_VX;
     /* Update the floating-point exception summary */
     env->fpscr |= FP_FX;
     if (fpscr_ve != 0) {
         /* Update the floating-point enabled exception summary */
-        env->fpscr |= 1 << FPSCR_FEX;
+        env->fpscr |= FP_FEX;
         if (fp_exceptions_enabled(env)) {
             raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
                                    POWERPC_EXCP_FP | op, retaddr);
@@ -215,11 +215,11 @@ static void finish_invalid_op_excp(CPUPPCState *env, int op, uintptr_t retaddr)
 static void finish_invalid_op_arith(CPUPPCState *env, int op,
                                     bool set_fpcc, uintptr_t retaddr)
 {
-    env->fpscr &= ~((1 << FPSCR_FR) | (1 << FPSCR_FI));
+    env->fpscr &= ~(FP_FR | FP_FI);
     if (fpscr_ve == 0) {
         if (set_fpcc) {
-            env->fpscr &= ~(0xF << FPSCR_FPCC);
-            env->fpscr |= 0x11 << FPSCR_FPCC;
+            env->fpscr &= ~FP_FPCC;
+            env->fpscr |= (FP_C | FP_FU);
         }
     }
     finish_invalid_op_excp(env, op, retaddr);
@@ -228,7 +228,7 @@ static void finish_invalid_op_arith(CPUPPCState *env, int op,
 /* Signalling NaN */
 static void float_invalid_op_vxsnan(CPUPPCState *env, uintptr_t retaddr)
 {
-    env->fpscr |= 1 << FPSCR_VXSNAN;
+    env->fpscr |= FP_VXSNAN;
     finish_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, retaddr);
 }
 
@@ -236,7 +236,7 @@ static void float_invalid_op_vxsnan(CPUPPCState *env, uintptr_t retaddr)
 static void float_invalid_op_vxisi(CPUPPCState *env, bool set_fpcc,
                                    uintptr_t retaddr)
 {
-    env->fpscr |= 1 << FPSCR_VXISI;
+    env->fpscr |= FP_VXISI;
     finish_invalid_op_arith(env, POWERPC_EXCP_FP_VXISI, set_fpcc, retaddr);
 }
 
@@ -244,7 +244,7 @@ static void float_invalid_op_vxisi(CPUPPCState *env, bool set_fpcc,
 static void float_invalid_op_vxidi(CPUPPCState *env, bool set_fpcc,
                                    uintptr_t retaddr)
 {
-    env->fpscr |= 1 << FPSCR_VXIDI;
+    env->fpscr |= FP_VXIDI;
     finish_invalid_op_arith(env, POWERPC_EXCP_FP_VXIDI, set_fpcc, retaddr);
 }
 
@@ -252,7 +252,7 @@ static void float_invalid_op_vxidi(CPUPPCState *env, bool set_fpcc,
 static void float_invalid_op_vxzdz(CPUPPCState *env, bool set_fpcc,
                                    uintptr_t retaddr)
 {
-    env->fpscr |= 1 << FPSCR_VXZDZ;
+    env->fpscr |= FP_VXZDZ;
     finish_invalid_op_arith(env, POWERPC_EXCP_FP_VXZDZ, set_fpcc, retaddr);
 }
 
@@ -260,7 +260,7 @@ static void float_invalid_op_vxzdz(CPUPPCState *env, bool set_fpcc,
 static void float_invalid_op_vximz(CPUPPCState *env, bool set_fpcc,
                                    uintptr_t retaddr)
 {
-    env->fpscr |= 1 << FPSCR_VXIMZ;
+    env->fpscr |= FP_VXIMZ;
     finish_invalid_op_arith(env, POWERPC_EXCP_FP_VXIMZ, set_fpcc, retaddr);
 }
 
@@ -268,7 +268,7 @@ static void float_invalid_op_vximz(CPUPPCState *env, bool set_fpcc,
 static void float_invalid_op_vxsqrt(CPUPPCState *env, bool set_fpcc,
                                     uintptr_t retaddr)
 {
-    env->fpscr |= 1 << FPSCR_VXSQRT;
+    env->fpscr |= FP_VXSQRT;
     finish_invalid_op_arith(env, POWERPC_EXCP_FP_VXSQRT, set_fpcc, retaddr);
 }
 
@@ -276,13 +276,13 @@ static void float_invalid_op_vxsqrt(CPUPPCState *env, bool set_fpcc,
 static void float_invalid_op_vxvc(CPUPPCState *env, bool set_fpcc,
                                   uintptr_t retaddr)
 {
-    env->fpscr |= 1 << FPSCR_VXVC;
+    env->fpscr |= FP_VXVC;
     if (set_fpcc) {
-        env->fpscr &= ~(0xF << FPSCR_FPCC);
-        env->fpscr |= 0x11 << FPSCR_FPCC;
+        env->fpscr &= ~FP_FPCC;
+        env->fpscr |= (FP_C | FP_FU);
     }
     /* Update the floating-point invalid operation summary */
-    env->fpscr |= 1 << FPSCR_VX;
+    env->fpscr |= FP_VX;
     /* Update the floating-point exception summary */
     env->fpscr |= FP_FX;
     /* We must update the target FPR before raising the exception */
@@ -292,7 +292,7 @@ static void float_invalid_op_vxvc(CPUPPCState *env, bool set_fpcc,
         cs->exception_index = POWERPC_EXCP_PROGRAM;
         env->error_code = POWERPC_EXCP_FP | POWERPC_EXCP_FP_VXVC;
         /* Update the floating-point enabled exception summary */
-        env->fpscr |= 1 << FPSCR_FEX;
+        env->fpscr |= FP_FEX;
         /* Exception is differed */
     }
 }
@@ -301,12 +301,12 @@ static void float_invalid_op_vxvc(CPUPPCState *env, bool set_fpcc,
 static void float_invalid_op_vxcvi(CPUPPCState *env, bool set_fpcc,
                                    uintptr_t retaddr)
 {
-    env->fpscr |= 1 << FPSCR_VXCVI;
-    env->fpscr &= ~((1 << FPSCR_FR) | (1 << FPSCR_FI));
+    env->fpscr |= FP_VXCVI;
+    env->fpscr &= ~(FP_FR | FP_FI);
     if (fpscr_ve == 0) {
         if (set_fpcc) {
-            env->fpscr &= ~(0xF << FPSCR_FPCC);
-            env->fpscr |= 0x11 << FPSCR_FPCC;
+            env->fpscr &= ~FP_FPCC;
+            env->fpscr |= (FP_C | FP_FU);
         }
     }
     finish_invalid_op_excp(env, POWERPC_EXCP_FP_VXCVI, retaddr);
@@ -314,13 +314,13 @@ static void float_invalid_op_vxcvi(CPUPPCState *env, bool set_fpcc,
 
 static inline void float_zero_divide_excp(CPUPPCState *env, uintptr_t raddr)
 {
-    env->fpscr |= 1 << FPSCR_ZX;
-    env->fpscr &= ~((1 << FPSCR_FR) | (1 << FPSCR_FI));
+    env->fpscr |= FP_ZX;
+    env->fpscr &= ~(FP_FR | FP_FI);
     /* Update the floating-point exception summary */
     env->fpscr |= FP_FX;
     if (fpscr_ze != 0) {
         /* Update the floating-point enabled exception summary */
-        env->fpscr |= 1 << FPSCR_FEX;
+        env->fpscr |= FP_FEX;
         if (fp_exceptions_enabled(env)) {
             raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
                                    POWERPC_EXCP_FP | POWERPC_EXCP_FP_ZX,
@@ -333,19 +333,19 @@ static inline void float_overflow_excp(CPUPPCState *env)
 {
     CPUState *cs = env_cpu(env);
 
-    env->fpscr |= 1 << FPSCR_OX;
+    env->fpscr |= FP_OX;
     /* Update the floating-point exception summary */
     env->fpscr |= FP_FX;
     if (fpscr_oe != 0) {
         /* XXX: should adjust the result */
         /* Update the floating-point enabled exception summary */
-        env->fpscr |= 1 << FPSCR_FEX;
+        env->fpscr |= FP_FEX;
         /* We must update the target FPR before raising the exception */
         cs->exception_index = POWERPC_EXCP_PROGRAM;
         env->error_code = POWERPC_EXCP_FP | POWERPC_EXCP_FP_OX;
     } else {
-        env->fpscr |= 1 << FPSCR_XX;
-        env->fpscr |= 1 << FPSCR_FI;
+        env->fpscr |= FP_XX;
+        env->fpscr |= FP_FI;
     }
 }
 
@@ -353,13 +353,13 @@ static inline void float_underflow_excp(CPUPPCState *env)
 {
     CPUState *cs = env_cpu(env);
 
-    env->fpscr |= 1 << FPSCR_UX;
+    env->fpscr |= FP_UX;
     /* Update the floating-point exception summary */
     env->fpscr |= FP_FX;
     if (fpscr_ue != 0) {
         /* XXX: should adjust the result */
         /* Update the floating-point enabled exception summary */
-        env->fpscr |= 1 << FPSCR_FEX;
+        env->fpscr |= FP_FEX;
         /* We must update the target FPR before raising the exception */
         cs->exception_index = POWERPC_EXCP_PROGRAM;
         env->error_code = POWERPC_EXCP_FP | POWERPC_EXCP_FP_UX;
@@ -370,13 +370,13 @@ static inline void float_inexact_excp(CPUPPCState *env)
 {
     CPUState *cs = env_cpu(env);
 
-    env->fpscr |= 1 << FPSCR_FI;
-    env->fpscr |= 1 << FPSCR_XX;
+    env->fpscr |= FP_FI;
+    env->fpscr |= FP_XX;
     /* Update the floating-point exception summary */
     env->fpscr |= FP_FX;
     if (fpscr_xe != 0) {
         /* Update the floating-point enabled exception summary */
-        env->fpscr |= 1 << FPSCR_FEX;
+        env->fpscr |= FP_FEX;
         /* We must update the target FPR before raising the exception */
         cs->exception_index = POWERPC_EXCP_PROGRAM;
         env->error_code = POWERPC_EXCP_FP | POWERPC_EXCP_FP_XX;
@@ -433,7 +433,7 @@ void helper_fpscr_clrbit(CPUPPCState *env, uint32_t bit)
         case FPSCR_VXCVI:
             if (!fpscr_ix) {
                 /* Set VX bit to zero */
-                env->fpscr &= ~(1 << FPSCR_VX);
+                env->fpscr &= ~FP_VX;
             }
             break;
         case FPSCR_OX:
@@ -447,7 +447,7 @@ void helper_fpscr_clrbit(CPUPPCState *env, uint32_t bit)
         case FPSCR_XE:
             if (!fpscr_eex) {
                 /* Set the FEX bit */
-                env->fpscr &= ~(1 << FPSCR_FEX);
+                env->fpscr &= ~FP_FEX;
             }
             break;
         default:
@@ -504,7 +504,7 @@ void helper_fpscr_setbit(CPUPPCState *env, uint32_t bit)
         case FPSCR_VXSOFT:
         case FPSCR_VXSQRT:
         case FPSCR_VXCVI:
-            env->fpscr |= 1 << FPSCR_VX;
+            env->fpscr |= FP_VX;
             env->fpscr |= FP_FX;
             if (fpscr_ve != 0) {
                 goto raise_ve;
@@ -580,7 +580,7 @@ void helper_fpscr_setbit(CPUPPCState *env, uint32_t bit)
             break;
         raise_excp:
             /* Update the floating-point enabled exception summary */
-            env->fpscr |= 1 << FPSCR_FEX;
+            env->fpscr |= FP_FEX;
             /* We have to update Rc1 before raising the exception */
             cs->exception_index = POWERPC_EXCP_PROGRAM;
             break;
@@ -596,8 +596,8 @@ void helper_store_fpscr(CPUPPCState *env, uint64_t arg, uint32_t mask)
 
     prev = env->fpscr;
     new = (target_ulong)arg;
-    new &= ~0x60000000LL;
-    new |= prev & 0x60000000LL;
+    new &= ~(FP_FEX | FP_VX);
+    new |= prev & (FP_FEX | FP_VX);
     for (i = 0; i < sizeof(target_ulong) * 2; i++) {
         if (mask & (1 << i)) {
             env->fpscr &= ~(0xFLL << (4 * i));
@@ -606,17 +606,17 @@ void helper_store_fpscr(CPUPPCState *env, uint64_t arg, uint32_t mask)
     }
     /* Update VX and FEX */
     if (fpscr_ix != 0) {
-        env->fpscr |= 1 << FPSCR_VX;
+        env->fpscr |= FP_VX;
     } else {
-        env->fpscr &= ~(1 << FPSCR_VX);
+        env->fpscr &= ~FP_VX;
     }
     if ((fpscr_ex & fpscr_eex) != 0) {
-        env->fpscr |= 1 << FPSCR_FEX;
+        env->fpscr |= FP_FEX;
         cs->exception_index = POWERPC_EXCP_PROGRAM;
         /* XXX: we should compute it properly */
         env->error_code = POWERPC_EXCP_FP;
     } else {
-        env->fpscr &= ~(1 << FPSCR_FEX);
+        env->fpscr &= ~FP_FEX;
     }
     fpscr_set_rounding_mode(env);
 }
@@ -639,7 +639,7 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
     if (status & float_flag_inexact) {
         float_inexact_excp(env);
     } else {
-        env->fpscr &= ~(1 << FPSCR_FI); /* clear the FPSCR[FI] bit */
+        env->fpscr &= ~FP_FI; /* clear the FPSCR[FI] bit */
     }
 
     if (cs->exception_index == POWERPC_EXCP_PROGRAM &&
@@ -1138,8 +1138,8 @@ void helper_fcmpu(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
         ret = 0x02UL;
     }
 
-    env->fpscr &= ~(0x0F << FPSCR_FPRF);
-    env->fpscr |= ret << FPSCR_FPRF;
+    env->fpscr &= ~FP_FPCC;
+    env->fpscr |= ret << FPSCR_FPCC;
     env->crf[crfD] = ret;
     if (unlikely(ret == 0x01UL
                  && (float64_is_signaling_nan(farg1.d, &env->fp_status) ||
@@ -1169,9 +1169,9 @@ void helper_fcmpo(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
         ret = 0x02UL;
     }
 
-    env->fpscr &= ~(0x0F << FPSCR_FPRF);
-    env->fpscr |= ret << FPSCR_FPRF;
-    env->crf[crfD] = ret;
+    env->fpscr &= ~FP_FPCC;
+    env->fpscr |= ret << FPSCR_FPCC;
+    env->crf[crfD] = (uint32_t) ret;
     if (unlikely(ret == 0x01UL)) {
         float_invalid_op_vxvc(env, 1, GETPC());
         if (float64_is_signaling_nan(farg1.d, &env->fp_status) ||
@@ -2431,8 +2431,8 @@ void helper_xscmpexpdp(CPUPPCState *env, uint32_t opcode,
         }
     }
 
-    env->fpscr &= ~(0x0F << FPSCR_FPRF);
-    env->fpscr |= cc << FPSCR_FPRF;
+    env->fpscr &= ~FP_FPCC;
+    env->fpscr |= cc << FPSCR_FPCC;
     env->crf[BF(opcode)] = cc;
 
     do_float_check_status(env, GETPC());
@@ -2460,8 +2460,8 @@ void helper_xscmpexpqp(CPUPPCState *env, uint32_t opcode,
         }
     }
 
-    env->fpscr &= ~(0x0F << FPSCR_FPRF);
-    env->fpscr |= cc << FPSCR_FPRF;
+    env->fpscr &= ~FP_FPCC;
+    env->fpscr |= cc << FPSCR_FPCC;
     env->crf[BF(opcode)] = cc;
 
     do_float_check_status(env, GETPC());
@@ -2505,8 +2505,8 @@ void helper_##op(CPUPPCState *env, uint32_t opcode,                      \
         cc |= CRF_EQ;                                                    \
     }                                                                    \
                                                                          \
-    env->fpscr &= ~(0x0F << FPSCR_FPRF);                                 \
-    env->fpscr |= cc << FPSCR_FPRF;                                      \
+    env->fpscr &= ~FP_FPCC;                                              \
+    env->fpscr |= cc << FPSCR_FPCC;                                      \
     env->crf[BF(opcode)] = cc;                                           \
                                                                          \
     do_float_check_status(env, GETPC());                                 \
@@ -2553,8 +2553,8 @@ void helper_##op(CPUPPCState *env, uint32_t opcode,                     \
         cc |= CRF_EQ;                                                   \
     }                                                                   \
                                                                         \
-    env->fpscr &= ~(0x0F << FPSCR_FPRF);                                \
-    env->fpscr |= cc << FPSCR_FPRF;                                     \
+    env->fpscr &= ~FP_FPCC;                                             \
+    env->fpscr |= cc << FPSCR_FPCC;                                     \
     env->crf[BF(opcode)] = cc;                                          \
                                                                         \
     do_float_check_status(env, GETPC());                                \
@@ -3242,8 +3242,8 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)         \
                                                             \
         if (scrf) {                                         \
             cc = sign << CRF_LT_BIT | match << CRF_EQ_BIT;  \
-            env->fpscr &= ~(0x0F << FPSCR_FPRF);            \
-            env->fpscr |= cc << FPSCR_FPRF;                 \
+            env->fpscr &= ~FP_FPCC;                         \
+            env->fpscr |= cc << FPSCR_FPCC;                 \
             env->crf[BF(opcode)] = cc;                      \
         } else {                                            \
             t.tfld = match ? fld_max : 0;                   \
@@ -3286,8 +3286,8 @@ void helper_xststdcsp(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xb)
                              &env->fp_status), &env->fp_status);
 
     cc = sign << CRF_LT_BIT | match << CRF_EQ_BIT | not_sp << CRF_SO_BIT;
-    env->fpscr &= ~(0x0F << FPSCR_FPRF);
-    env->fpscr |= cc << FPSCR_FPRF;
+    env->fpscr &= ~FP_FPCC;
+    env->fpscr |= cc << FPSCR_FPCC;
     env->crf[BF(opcode)] = cc;
 }
 
-- 
1.8.3.1


