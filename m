Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B041C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054092075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054092075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Odh-0003Nm-3j
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1i8OcO-0001yC-JX
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1i8OcN-0007pv-Cu
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:54:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29726)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>)
 id 1i8OcI-0007n1-5q; Thu, 12 Sep 2019 08:54:30 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8CCq0nj085751; Thu, 12 Sep 2019 08:54:23 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uyn5du6aa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2019 08:54:23 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8CCpDSp027896;
 Thu, 12 Sep 2019 12:54:22 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma03dal.us.ibm.com with ESMTP id 2uv468xfxy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2019 12:54:22 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8CCsLDr47579522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2019 12:54:21 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59BD678060;
 Thu, 12 Sep 2019 12:54:21 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 264B67805C;
 Thu, 12 Sep 2019 12:54:21 +0000 (GMT)
Received: from localhost (unknown [9.160.39.69])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2019 12:54:20 +0000 (GMT)
From: "Paul A. Clarke" <pc@us.ibm.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 07:54:20 -0500
Message-Id: <1568292860-4928-1-git-send-email-pc@us.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-12_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=879 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909120137
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v2] ppc: Add support for 'mffscrn',
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
- Additionally mask status bits from return value.
- Wrap a couple of too-long lines.

 target/ppc/internal.h              |  3 ++
 target/ppc/translate/fp-impl.inc.c | 67 ++++++++++++++++++++++++++++++++++++++
 target/ppc/translate/fp-ops.inc.c  |  4 +++
 3 files changed, 74 insertions(+)

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


