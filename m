Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756DFC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2632089E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5IQ3U0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2632089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36222 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwn1-00071w-Bv
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:07:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwUC-0004be-8z
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU7-0004CR-Ew
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwU7-00034b-44
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id c2so3326486wrm.8
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=GZ0x0o1HQFZ10vVq+O8T2K/nYflpLwHxG+mZSGXfk1c=;
	b=F5IQ3U0+lGe5a2Qb1CD3+VtqncMm81++cPZHMdGZ2PIiPr7XFvkeUTnGdscifQP/eO
	PrnQlmQtx3DED+z3nP+w/TFZqE2XZuGhGyd1g+5xoZ+AJSOLFIH2uQPvv7fkUqTBINVz
	DVqki0qdRq0vCWPipqtx2KDFHVh7wwfg1G1oP2g192ytetxUdgFcwv1dCfv4M19HBj4b
	vAEQbiBsyXW5hb2cusFy/3YAPtSBgb/ficMlO6e8bM8klE6d1+kdirJc8bg06s9pnqmy
	eSjfXL30lOtiwtrfky+jVGU/vCnsu4nOqpHc9h0ccV5s8NXrMI4XJXR0qz0TKUgOSZwG
	qs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=GZ0x0o1HQFZ10vVq+O8T2K/nYflpLwHxG+mZSGXfk1c=;
	b=lPI0jyWpfbEgFPCE51y6bEqxURnYPAcTkMr6NY51HRrGpTrU4wrS3ptL28gL2CJuGe
	lgM0YzLKg+PdXqZ18Mi7aZWKagnNyorHuXYSSk7g6nmP3PTaXlrMX4Y2uqGALmb69543
	6TwlrPk+ylhID1HBsjLgQR9arLzJe7HIO+fh2sO9Kztz0TFlu4suZck09TbQFV4wiq1q
	s2d4V+NbNEOzOkhIA+g/hlXQLzdPdUwd58DDqts8ELboAbTRdPOtzhVPJc7GHgB4V3FL
	N1Gck3W3+NDjAkF/0P7dflYDfXMomh5o5dOy5UMxMMoF9Gv98PTATxAjFRrK0p84cD0A
	cZ0A==
X-Gm-Message-State: APjAAAVPNAelw98TQW7ZPDT6mjz/9mD32mSwpH9YgWAPXvOTowRAXRq5
	E+MBxIU/f0hF5e1mAUagoYrDXQ==
X-Google-Smtp-Source: APXvYqx/Glj6IK59PxfrLQlgZ97u1fp5AeogXe5rkTpXNclXwohQ6V+YdgMMfRC0PlCtbiWc7T4xog==
X-Received: by 2002:adf:8385:: with SMTP id 5mr4068311wre.194.1559843193653;
	Thu, 06 Jun 2019 10:46:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:47 +0100
Message-Id: <20190606174609.20487-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 20/42] target/arm: Convert VFP VNMLS to
 decodetree
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VFP VNMLS instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 42 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 24 +------------------
 target/arm/vfp.decode          |  5 ++++
 3 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 00f64401dda..1d7100debe4 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1341,3 +1341,45 @@ static bool trans_VMLS_dp(DisasContext *s, arg_VMLS_sp *a)
 {
     return do_vfp_3op_dp(s, gen_VMLS_dp, a->vd, a->vn, a->vm, true);
 }
+
+static void gen_VNMLS_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
+{
+    /*
+     * VNMLS: -fd + (fn * fm)
+     * Note that it isn't valid to replace (-A + B) with (B - A) or similar
+     * plausible looking simplifications because this will give wrong results
+     * for NaNs.
+     */
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    gen_helper_vfp_muls(tmp, vn, vm, fpst);
+    gen_helper_vfp_negs(vd, vd);
+    gen_helper_vfp_adds(vd, vd, tmp, fpst);
+    tcg_temp_free_i32(tmp);
+}
+
+static bool trans_VNMLS_sp(DisasContext *s, arg_VNMLS_sp *a)
+{
+    return do_vfp_3op_sp(s, gen_VNMLS_sp, a->vd, a->vn, a->vm, true);
+}
+
+static void gen_VNMLS_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
+{
+    /*
+     * VNMLS: -fd + (fn * fm)
+     * Note that it isn't valid to replace (-A + B) with (B - A) or similar
+     * plausible looking simplifications because this will give wrong results
+     * for NaNs.
+     */
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    gen_helper_vfp_muld(tmp, vn, vm, fpst);
+    gen_helper_vfp_negd(vd, vd);
+    gen_helper_vfp_addd(vd, vd, tmp, fpst);
+    tcg_temp_free_i64(tmp);
+}
+
+static bool trans_VNMLS_dp(DisasContext *s, arg_VNMLS_sp *a)
+{
+    return do_vfp_3op_dp(s, gen_VNMLS_dp, a->vd, a->vn, a->vm, true);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index dc19d8fcab1..bb86c603712 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1393,18 +1393,6 @@ VFP_OP2(div)
 
 #undef VFP_OP2
 
-static inline void gen_vfp_F1_mul(int dp)
-{
-    /* Like gen_vfp_mul() but put result in F1 */
-    TCGv_ptr fpst = get_fpstatus_ptr(0);
-    if (dp) {
-        gen_helper_vfp_muld(cpu_F1d, cpu_F0d, cpu_F1d, fpst);
-    } else {
-        gen_helper_vfp_muls(cpu_F1s, cpu_F0s, cpu_F1s, fpst);
-    }
-    tcg_temp_free_ptr(fpst);
-}
-
 static inline void gen_vfp_F1_neg(int dp)
 {
     /* Like gen_vfp_neg() but put result in F1 */
@@ -3134,7 +3122,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0 ... 1:
+            case 0 ... 2:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3320,16 +3308,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 2: /* VNMLS: -fd + (fn * fm) */
-                    /* Note that it isn't valid to replace (-A + B) with (B - A)
-                     * or similar plausible looking simplifications
-                     * because this will give wrong results for NaNs.
-                     */
-                    gen_vfp_F1_mul(dp);
-                    gen_mov_F0_vreg(dp, rd);
-                    gen_vfp_neg(dp);
-                    gen_vfp_add(dp);
-                    break;
                 case 3: /* VNMLA: -fd + -(fn * fm) */
                     gen_vfp_mul(dp);
                     gen_vfp_F1_neg(dp);
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 7bcf2260eec..08e4f427408 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -107,3 +107,8 @@ VMLS_sp      ---- 1110 0.00 .... .... 1010 .1.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VMLS_dp      ---- 1110 0.00 .... .... 1011 .1.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VNMLS_sp     ---- 1110 0.01 .... .... 1010 .0.0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp
+VNMLS_dp     ---- 1110 0.01 .... .... 1011 .0.0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


