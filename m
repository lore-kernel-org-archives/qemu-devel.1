Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BFEC31E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8293620B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zDqslaU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8293620B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPEC-0007in-Oj
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59461)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOde-0008PQ-FP
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdW-0004en-0M
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:29 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdV-0004Ii-H3
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:21 -0400
Received: by mail-wm1-x343.google.com with SMTP id c6so9907878wml.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ePUtfqYkh2qkpSIViahtoMcVRf0/pRm/M8l5xG6Fj2o=;
 b=zDqslaU80NGzl9NmPRtgN5gtHzKKuPy5WQaPqHRfjhW0DdA3ldAluWokG8rLLdyobu
 Qlv2/LpDb7ND0a/h9yScLU3RYuvJM5/IMwlzwJ+FR0yHriDJDfbXnCgZGgjZRO4Y/h5G
 NiBSNNIJlZZ5oY7lK3B0SrvkbWIJFo6bczRzvfSrGudohjRNHPKu23ttnCyvi9+QgQpZ
 FLuQEWonS+TLNSS1GH76pbYPSG68WhIBQAX0r1csUmq0WOIwg4fuJoN5Xnv8s9eLEWLu
 wUdZ4sJZScWY1bKM91qhpg1rXt4Rz03k6zFb96bkrd7YQVwvvCoO0W7V3yABrKppCflg
 +eKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ePUtfqYkh2qkpSIViahtoMcVRf0/pRm/M8l5xG6Fj2o=;
 b=n38RBd8YtAE2Nx2N7VBfQn4Ld2IIDPn4gs3D2XbdFT8mo8POpGj2TlwL52E50PsZOA
 J/SZbhOmz7G+QCXjDN998hnZptw+MxBd69PTyAUioXTMY8FK3tungNu8bAXgPSG3aOZG
 jk+hWiKLuYe25ZXZLNc679LgLorxKaUwljbhRSVsAA3Y5+lk95t8n2cqKSi2nXydSouQ
 G5YGJA00ebo/UCxjpadmybKPNXN1pe9oplwpZ/wGMQnZm40eOwvYb9yOAqi3U22eesVL
 y5MqlLeWWeVYZ5CDVuujSeaz1bmAD7Eb3dHxbibZY7dvm3VFd7sLgHAA9ng6fEjuiJ2n
 7fXQ==
X-Gm-Message-State: APjAAAWWcb9mC81CzAWNC0SOd1lagqdp7g+xcukenjbspLM0A8R24HlR
 XEaEvTxlBS06kDEF375Y60n8kFfA1Fv4oA==
X-Google-Smtp-Source: APXvYqxDIo4Cgn0q7eZBaORvJ9CzOhbSzq8HIjIjCAWsix1iweV7g9Tf6xfwkkJS0dWiFOwp9ycuxg==
X-Received: by 2002:a1c:b68a:: with SMTP id g132mr3720442wmf.66.1560428104383; 
 Thu, 13 Jun 2019 05:15:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:11 +0100
Message-Id: <20190613121433.5246-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PULL 26/48] target/arm: Convert VFP VNMLS to
 decodetree
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VFP VNMLS instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 2afab7fbc20..42701884101 100644
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


