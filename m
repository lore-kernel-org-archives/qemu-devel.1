Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF074C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6485E2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idGGDqpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6485E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjSt-0003Eu-ES
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCz-0003En-NW
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:51318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCw-00064v-Qq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id w2so133478wmi.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Tlt4PCJ9QBY32aAXI7MSrrhV4Lcy2WR5guUFVfkz0K8=;
 b=idGGDqpuAa/CaHCZHNNJyxpoY+3gF4+jXlVO53JX+ctrTT+DuUnZd/4p28BnlwtFL+
 tU/a6JfShaItzZraGwgS6OUZfT6kO16rehoA77vueMUsYCA8R/bWsSoYAmaeHYwQWvHu
 9mtYlSkeyUGvS9JnJUVj3+5b7Qtl/agFU+XMeZ9abG8I02diPYwcjTW3+55m3tbZhZ02
 wvvB60MVfDDE6eLFoS2vEddIIZc3+MikFeyI4JkVyO8oyPqWplJDVdeVgceVJLArkWn0
 +YkPwKA6vO+pJ8lytS7atxZx5d3TR/GnJ73rOLuPe21H1PV7HXtoZeuTp0XNjxAshUO3
 wUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tlt4PCJ9QBY32aAXI7MSrrhV4Lcy2WR5guUFVfkz0K8=;
 b=d/3Dzo3VZiSJu67SxMtMVOQJzJwYT4S41ATnZD6+uN8VAPx48dfiT8/he+6XINC0hj
 93sKkYoFW/+s8Y9lrpNuBEOeGqA1adtncTxPr+n4rkLDFWcrOws4t77n+Nq8MD6mopVA
 k52uRM2oetFTZGq84KxeF7/Lrdz95sHvgZTPZeWjMIkXvX3UN1k4h3QZP42tB3rui6Jh
 6FE31IUtJcnuINh9LOdu6b1sSPMcevnesPYpFVdnKinTqobdTSkAcNpToFLd/2l95XGk
 XlitNH2PqHJd8LdbekXvY6mJ9F49zfcEi3KUhkHuEPweGYCwGn1rZvfIc6+ciTSMxT2V
 C/fA==
X-Gm-Message-State: AOAM53096ameIppZ+2BjoZDQ+O7LBig1tT8mrIfuDwOzc9rM1m3gD8CB
 UBOrn+jyv6RuHFE0GJ62melG8W+gScZn/QyU
X-Google-Smtp-Source: ABdhPJwMgO5q8zpdSffUxzanXhD5h7bexr9+ipIMCTCsXtBlieIPDB+pd843I/t04R377DS7e+E/bA==
X-Received: by 2002:a1c:f60e:: with SMTP id w14mr23467wmc.19.1598639677393;
 Fri, 28 Aug 2020 11:34:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 34/45] target/arm: Implement fp16 for Neon VRSQRTS
Date: Fri, 28 Aug 2020 19:33:43 +0100
Message-Id: <20200828183354.27913-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Convert the Neon VRSQRTS insn to using a gvec helper,
and use this to implement the fp16 case.

As with VRECPS, we adjust the phrasing of the new implementation
slightly so that the fp32 version parallels the fp16 one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             |  4 +++-
 target/arm/vec_helper.c         | 30 ++++++++++++++++++++++++++++++
 target/arm/vfp_helper.c         | 15 ---------------
 target/arm/translate-neon.c.inc | 21 +--------------------
 4 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 114039c4c33..5a716498913 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -225,7 +225,6 @@ DEF_HELPER_4(vfp_muladdd, f64, f64, f64, f64, ptr)
 DEF_HELPER_4(vfp_muladds, f32, f32, f32, f32, ptr)
 DEF_HELPER_4(vfp_muladdh, f16, f16, f16, f16, ptr)
 
-DEF_HELPER_3(rsqrts_f32, f32, env, f32, f32)
 DEF_HELPER_FLAGS_2(recpe_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
 DEF_HELPER_FLAGS_2(recpe_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(recpe_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
@@ -676,6 +675,9 @@ DEF_HELPER_FLAGS_5(gvec_fminnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i3
 DEF_HELPER_FLAGS_5(gvec_recps_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_recps_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_rsqrts_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_rsqrts_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_fmla_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 0111a230244..e5bb5e395cb 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -825,6 +825,33 @@ static float32 float32_recps_nf(float32 op1, float32 op2, float_status *stat)
     return float32_sub(float32_two, float32_mul(op1, op2, stat), stat);
 }
 
+/* Reciprocal square-root step. AArch32 non-fused semantics. */
+static float16 float16_rsqrts_nf(float16 op1, float16 op2, float_status *stat)
+{
+    op1 = float16_squash_input_denormal(op1, stat);
+    op2 = float16_squash_input_denormal(op2, stat);
+
+    if ((float16_is_infinity(op1) && float16_is_zero(op2)) ||
+        (float16_is_infinity(op2) && float16_is_zero(op1))) {
+        return float16_one_point_five;
+    }
+    op1 = float16_sub(float16_three, float16_mul(op1, op2, stat), stat);
+    return float16_div(op1, float16_two, stat);
+}
+
+static float32 float32_rsqrts_nf(float32 op1, float32 op2, float_status *stat)
+{
+    op1 = float32_squash_input_denormal(op1, stat);
+    op2 = float32_squash_input_denormal(op2, stat);
+
+    if ((float32_is_infinity(op1) && float32_is_zero(op2)) ||
+        (float32_is_infinity(op2) && float32_is_zero(op1))) {
+        return float32_one_point_five;
+    }
+    op1 = float32_sub(float32_three, float32_mul(op1, op2, stat), stat);
+    return float32_div(op1, float32_two, stat);
+}
+
 #define DO_3OP(NAME, FUNC, TYPE) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
 {                                                                          \
@@ -885,6 +912,9 @@ DO_3OP(gvec_fminnum_s, float32_minnum, float32)
 DO_3OP(gvec_recps_nf_h, float16_recps_nf, float16)
 DO_3OP(gvec_recps_nf_s, float32_recps_nf, float32)
 
+DO_3OP(gvec_rsqrts_nf_h, float16_rsqrts_nf, float16)
+DO_3OP(gvec_rsqrts_nf_s, float32_rsqrts_nf, float32)
+
 #ifdef TARGET_AARCH64
 
 DO_3OP(gvec_recps_h, helper_recpsf_f16, float16)
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 1f452409d4d..8a3dd176819 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -529,21 +529,6 @@ uint32_t HELPER(vfp_fcvt_f64_to_f16)(float64 a, void *fpstp, uint32_t ahp_mode)
     return r;
 }
 
-float32 HELPER(rsqrts_f32)(CPUARMState *env, float32 a, float32 b)
-{
-    float_status *s = &env->vfp.standard_fp_status;
-    float32 product;
-    if ((float32_is_infinity(a) && float32_is_zero_or_denormal(b)) ||
-        (float32_is_infinity(b) && float32_is_zero_or_denormal(a))) {
-        if (!(float32_is_zero(a) || float32_is_zero(b))) {
-            float_raise(float_flag_input_denormal, s);
-        }
-        return float32_one_point_five;
-    }
-    product = float32_mul(a, b, s);
-    return float32_div(float32_sub(float32_three, product, s), float32_two, s);
-}
-
 /* NEON helpers.  */
 
 /* Constants 256 and 512 are used in some helpers; we avoid relying on
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 9d077be976d..e11e1e9043c 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -1075,6 +1075,7 @@ DO_3S_FP_GVEC(VMLS, gen_helper_gvec_fmls_s, gen_helper_gvec_fmls_h)
 DO_3S_FP_GVEC(VFMA, gen_helper_gvec_vfma_s, gen_helper_gvec_vfma_h)
 DO_3S_FP_GVEC(VFMS, gen_helper_gvec_vfms_s, gen_helper_gvec_vfms_h)
 DO_3S_FP_GVEC(VRECPS, gen_helper_gvec_recps_nf_s, gen_helper_gvec_recps_nf_h)
+DO_3S_FP_GVEC(VRSQRTS, gen_helper_gvec_rsqrts_nf_s, gen_helper_gvec_rsqrts_nf_h)
 
 WRAP_FP_GVEC(gen_VMAXNM_fp32_3s, FPST_STD, gen_helper_gvec_fmaxnum_s)
 WRAP_FP_GVEC(gen_VMAXNM_fp16_3s, FPST_STD_F16, gen_helper_gvec_fmaxnum_h)
@@ -1111,26 +1112,6 @@ static bool trans_VMINNM_fp_3s(DisasContext *s, arg_3same *a)
     return do_3same(s, a, gen_VMINNM_fp32_3s);
 }
 
-WRAP_ENV_FN(gen_VRSQRTS_tramp, gen_helper_rsqrts_f32)
-
-static void gen_VRSQRTS_fp_3s(unsigned vece, uint32_t rd_ofs,
-                              uint32_t rn_ofs, uint32_t rm_ofs,
-                              uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen3 ops = { .fni4 = gen_VRSQRTS_tramp };
-    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &ops);
-}
-
-static bool trans_VRSQRTS_fp_3s(DisasContext *s, arg_3same *a)
-{
-    if (a->size != 0) {
-        /* TODO fp16 support */
-        return false;
-    }
-
-    return do_3same(s, a, gen_VRSQRTS_fp_3s);
-}
-
 static bool do_3same_fp_pair(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
 {
     /* FP operations handled pairwise 32 bits at a time */
-- 
2.20.1


