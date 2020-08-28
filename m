Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9EAC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002CE20838
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xu3s+WJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002CE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjZ5-0005t6-3b
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCt-0002za-V4
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:35 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:32823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCr-00063J-3q
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id y8so186851wma.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=inXY03xGdyZBdSKyNEIZuqr9D88x76DuBRO96S6LpR8=;
 b=Xu3s+WJGPA/9Cdbgq8xSyEYqx0keUo1u/wuHbASUIjBwgIwkXFk+2c4HjuHKVhG+mC
 b8BDTBlL0HtQHl6bIpNaawOUBd6I/QnON9ykdnPfPR4QylcnnYRe+hvEkj6nPG5f/k0U
 1K0TjaAiqW6CxKlnDHuFTjEjhe14oyhawX452jQ7iIZZ9y8OcJx/0iCHUCiu69LiKP85
 fvMng/Yc1Js+qoOUPjXtVZzDIL0MSuSeF2lOIHPPWNj68jx6qyktSDBSp7r5vf6lIzPB
 YKsYuAUdeigQUAKDGJYKi/rIX7UnBbnR15xXe7hk+u9Mbqgjsbe42ZpPpmIAvXg49U13
 KNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=inXY03xGdyZBdSKyNEIZuqr9D88x76DuBRO96S6LpR8=;
 b=VwZE7ul2zGC6sUtlQkiB5Um94F5vqu6QH37/eMABOBArdSDZnTdhlgPZWvtNxIN+Yy
 +HAz50nrJj6RQUGJ7gjN5NR9+1HGNSGwKGlHZKew0+miDKPAXhz7ZdkUCOCF6p6Yxgp5
 7PELtXSbbEMQMzhOCc+7/p+OJizGEJ+EeJzgBFe9TzeQu6613Wp0kmlY9a9yFv0oQoQV
 Ltdb9FqiQv2IOTsuxEPTK8pUtgTs2zyNpixpzqjTAJ0Iljl17tYZc7NOvmcZfKsHv0//
 9AVdMOGBskU85+/2Okll6VQGDNmno5Tj/t1/ES6d/qoQ8ovNrXPa67XVaKURD30rS7aW
 kdqQ==
X-Gm-Message-State: AOAM530PwhkBD4iIdV6bSJTiY8Me8TnvAOD4V7r1mGmEL+h4IHhCT+YV
 +wS3ZBl3B2qvVzZ0+533iTR67A==
X-Google-Smtp-Source: ABdhPJzl77I8/p4w2x+YYTfTwKuvviRX6g+D9rOBFtN2+g5GAzQ0lkHW2K+I69ZKY6l2W0Ix59aSFA==
X-Received: by 2002:a1c:9910:: with SMTP id b16mr17245wme.79.1598639671716;
 Fri, 28 Aug 2020 11:34:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 29/45] target/arm: Implement fp16 for Neon VMAXNM, VMINNM
Date: Fri, 28 Aug 2020 19:33:38 +0100
Message-Id: <20200828183354.27913-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
index 621d6524df1..13858aaa08b 100644
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


