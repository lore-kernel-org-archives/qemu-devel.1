Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9C7C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421A820684
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmsXESMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421A820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8CX-0000vO-Cm
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83t-0000GI-83
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:05 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83r-0006GF-Cy
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:04 -0400
Received: by mail-wr1-x434.google.com with SMTP id e16so1996502wrm.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hTnTNWqAsvw3C12Hfk5CoY6hMRc1DVsRUnF8YSLdmhA=;
 b=HmsXESMW9n+Ye2cpGp6sadHN1H6K3Fhf76wcecIQKoJn3L1dS5w+ex8Qp+ItMhI/1B
 nvO+XBBq1NGbKHu7FTjaNra5BglakltF2wVivntwlrl2uL7c3N7+SAYHik7P9S67nWfr
 UFMtHcyQCXCRjUb7nZrRJrgmJVO4OjsnF7lzmTBcmraTR3oAEQxb6VZm3q3vLPT2znfl
 EnEWxlZKf15X4vqJ2DDY49UXnxZYdx1FWYnad8qtCNTpYCZJ9VUDZ/ICuS44fOG5aTUO
 fkYUvVjd08lKsHKZPPJuSkonqMXI/4D9VwC2/4RbZhtBJIJR+gRWMrotAjcXencCE6e+
 vaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hTnTNWqAsvw3C12Hfk5CoY6hMRc1DVsRUnF8YSLdmhA=;
 b=hBgNPV6wCrBZXFbZhAab4F52TE6F+RmgUBLwDjsewZ17MqplfKCoQnzrFkgtmS4Kkc
 Q8khJrmsJyBByXuNc54nG9IZ5onNNIcF9AAdLO2bBAShDGJ2Pw9BLkoD4ILUyuKAPU2q
 I4s0XSr/nN4/QiSqyHrfo838oZY7MZutZMaJTwA3PI4RctlJ9sFbSRWYLqKEOGw5VkMh
 9GWtBu+1+koP/jYmRNPF5KVLoXaoEtzrlDTTCBql1BMcwujw/Ibdjjp16GgSqwdPcjma
 mnP0YNzb5OHuC2i2wtqzyIRryRdGmXuWRSyeugriQYwprlXUWPB9MqNeoAK/lw3mc50c
 zyDA==
X-Gm-Message-State: AOAM532nU1ui3u1EOzVtvqaHuorjCrtcnfoKx7iENQhe7WVKElfF6sL/
 GZ9gnqeJaVV930F19PREARk7JiV4F5NuXYXW
X-Google-Smtp-Source: ABdhPJwZS/1BF0SR7w5QeGYDEJ/0tpD5092KwvlFuxR1SLyiP2sOqDwXdv7/bj08akDlBm7mVlZHoA==
X-Received: by 2002:adf:8b1d:: with SMTP id n29mr2306107wra.383.1598973541840; 
 Tue, 01 Sep 2020 08:19:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.19.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:19:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/47] target/arm: Implement fp16 for Neon VMAXNM, VMINNM
Date: Tue,  1 Sep 2020 16:18:04 +0100
Message-Id: <20200901151823.29785-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Convert the Neon floating point VMAXNM and VMINNM insns to
using a gvec helper and use this to implement the fp16 case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-30-peter.maydell@linaro.org
---
 target/arm/helper.h             |  6 ++++++
 target/arm/vec_helper.c         |  6 ++++++
 target/arm/translate-neon.c.inc | 23 +++++++++++++++--------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index e252f380a89..f621940e69d 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -653,6 +653,12 @@ DEF_HELPER_FLAGS_5(gvec_fmax_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fmin_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fmin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fmaxnum_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmaxnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fminnum_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fminnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 9d05e1a568b..f551f86d5a5 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -823,6 +823,12 @@ DO_3OP(gvec_fmax_s, float32_max, float32)
 DO_3OP(gvec_fmin_h, float16_min, float16)
 DO_3OP(gvec_fmin_s, float32_min, float32)
 
+DO_3OP(gvec_fmaxnum_h, float16_maxnum, float16)
+DO_3OP(gvec_fmaxnum_s, float32_maxnum, float32)
+
+DO_3OP(gvec_fminnum_h, float16_minnum, float16)
+DO_3OP(gvec_fminnum_s, float32_minnum, float32)
+
 #ifdef TARGET_AARCH64
 
 DO_3OP(gvec_recps_h, helper_recpsf_f16, float16)
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 018bfde1098..27afa45e602 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -1151,6 +1151,11 @@ static void gen_VMLS_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
 DO_3S_FP(VMLA, gen_VMLA_fp_3s, true)
 DO_3S_FP(VMLS, gen_VMLS_fp_3s, true)
 
+WRAP_FP_GVEC(gen_VMAXNM_fp32_3s, FPST_STD, gen_helper_gvec_fmaxnum_s)
+WRAP_FP_GVEC(gen_VMAXNM_fp16_3s, FPST_STD_F16, gen_helper_gvec_fmaxnum_h)
+WRAP_FP_GVEC(gen_VMINNM_fp32_3s, FPST_STD, gen_helper_gvec_fminnum_s)
+WRAP_FP_GVEC(gen_VMINNM_fp16_3s, FPST_STD_F16, gen_helper_gvec_fminnum_h)
+
 static bool trans_VMAXNM_fp_3s(DisasContext *s, arg_3same *a)
 {
     if (!arm_dc_feature(s, ARM_FEATURE_V8)) {
@@ -1158,11 +1163,12 @@ static bool trans_VMAXNM_fp_3s(DisasContext *s, arg_3same *a)
     }
 
     if (a->size != 0) {
-        /* TODO fp16 support */
-        return false;
+        if (!dc_isar_feature(aa32_fp16_arith, s)) {
+            return false;
+        }
+        return do_3same(s, a, gen_VMAXNM_fp16_3s);
     }
-
-    return do_3same_fp(s, a, gen_helper_vfp_maxnums, false);
+    return do_3same(s, a, gen_VMAXNM_fp32_3s);
 }
 
 static bool trans_VMINNM_fp_3s(DisasContext *s, arg_3same *a)
@@ -1172,11 +1178,12 @@ static bool trans_VMINNM_fp_3s(DisasContext *s, arg_3same *a)
     }
 
     if (a->size != 0) {
-        /* TODO fp16 support */
-        return false;
+        if (!dc_isar_feature(aa32_fp16_arith, s)) {
+            return false;
+        }
+        return do_3same(s, a, gen_VMINNM_fp16_3s);
     }
-
-    return do_3same_fp(s, a, gen_helper_vfp_minnums, false);
+    return do_3same(s, a, gen_VMINNM_fp32_3s);
 }
 
 WRAP_ENV_FN(gen_VRECPS_tramp, gen_helper_recps_f32)
-- 
2.20.1


