Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80B5C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951C120776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxOHV+4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951C120776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjcv-00040X-OL
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 15:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCx-0003A9-Sl
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:39 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCv-00064f-Nl
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:39 -0400
Received: by mail-wm1-x342.google.com with SMTP id z9so124862wmk.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=fvqm8C3dM5TmctflCAJIz9ZcX7WSbouhFM9/Ad7Pr7Q=;
 b=HxOHV+4vZ2srB8AycjUd9A1aGVkM4LVN264XyaWm8hVL1kYhoQ+KWj79XPLVWPeKfB
 mpYRbiQXqfYbvQ19VEourfL8+qKb5ZuFQQzNQFdFON4BloT5V/jGJkD/ICoL620M3AA6
 CjFcboDhEltu2OIsZp/RIrjBFimLD66EnUrEMNlJJpaHzP6nF5xZZJZ3V8ldIKLZGU27
 8D0ryLwLSPC51LgE4nAdiAYtRiyU23357SV6LRZcnleZkmlYE/Ol7zxe73TbZYwhcKWI
 zB5pz9qd5gsF3pTVjSm/Gg1qDdiWN2xBL+pSqZFDDuPoAylFWPQgU+KeurvNgcJ2Ovkg
 RGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fvqm8C3dM5TmctflCAJIz9ZcX7WSbouhFM9/Ad7Pr7Q=;
 b=dMpDyqxx823YhX7bW+aeuQHTqTK8MC9oF+Uxn/cxv2RHp+pRGboO/EZ9yqpIHbg1XH
 JFY1T9nf0JMnqJgIwJG2eljSDT29S+hlvfUCZn8QDqkbTGHsd9uNXrsl2Ga1/QmMFDEH
 zZ2yzR7rPiXyecBY73brwRmLx2U69cscTuX3HDqmg38Y5japS7hYM5LVypI3U6L2iW4v
 ZX9BY9BdQeC5MiJi6MdhV+t3zbvPkuHYgiP5GYVLUAxssIiQdZaytYov5RioRVFNbJu3
 WLfW3TacnZbyb0s4GKg9fRWB4U2iv8xQgZuFjADwXEbOZKS2ZlgesruyjhblneY8bJ8f
 zngQ==
X-Gm-Message-State: AOAM532GCH3MZohAlcDIokjjhomShKln85D3hLPhI9eJUWDkQ7mOHhMS
 buGUZZ1LH+gyeV2SH0c05ww86FdfMtfyFhuO
X-Google-Smtp-Source: ABdhPJwRdTgOAJIHfm6U9cS0EGLzaJHo1OX3iztAiqDAsr0gp/jSSUq4mlGatRiV+Cnj3M/0xs2yTw==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr54680wmc.22.1598639676268;
 Fri, 28 Aug 2020 11:34:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 33/45] target/arm: Implement fp16 for Neon VRECPS
Date: Fri, 28 Aug 2020 19:33:42 +0100
Message-Id: <20200828183354.27913-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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

Convert the Neon VRECPS insn to using a gvec helper, and
use this to implement the fp16 case.

The phrasing of the new float32_recps_nf() is slightly different from
the old recps_f32() so that it parallels the f16 version; for f16 we
can't assume that flush-to-zero is always enabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             |  4 +++-
 target/arm/vec_helper.c         | 31 +++++++++++++++++++++++++++++++
 target/arm/vfp_helper.c         | 13 -------------
 target/arm/translate-neon.c.inc | 21 +--------------------
 4 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index bf2b9a7d028..114039c4c33 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -225,7 +225,6 @@ DEF_HELPER_4(vfp_muladdd, f64, f64, f64, f64, ptr)
 DEF_HELPER_4(vfp_muladds, f32, f32, f32, f32, ptr)
 DEF_HELPER_4(vfp_muladdh, f16, f16, f16, f16, ptr)
 
-DEF_HELPER_3(recps_f32, f32, env, f32, f32)
 DEF_HELPER_3(rsqrts_f32, f32, env, f32, f32)
 DEF_HELPER_FLAGS_2(recpe_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
 DEF_HELPER_FLAGS_2(recpe_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
@@ -674,6 +673,9 @@ DEF_HELPER_FLAGS_5(gvec_fmaxnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i3
 DEF_HELPER_FLAGS_5(gvec_fminnum_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fminnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_recps_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_recps_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_fmla_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 072bcd1a9d5..0111a230244 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -797,6 +797,34 @@ static float32 float32_abd(float32 op1, float32 op2, float_status *stat)
     return float32_abs(float32_sub(op1, op2, stat));
 }
 
+/*
+ * Reciprocal step. These are the AArch32 version which uses a
+ * non-fused multiply-and-subtract.
+ */
+static float16 float16_recps_nf(float16 op1, float16 op2, float_status *stat)
+{
+    op1 = float16_squash_input_denormal(op1, stat);
+    op2 = float16_squash_input_denormal(op2, stat);
+
+    if ((float16_is_infinity(op1) && float16_is_zero(op2)) ||
+        (float16_is_infinity(op2) && float16_is_zero(op1))) {
+        return float16_two;
+    }
+    return float16_sub(float16_two, float16_mul(op1, op2, stat), stat);
+}
+
+static float32 float32_recps_nf(float32 op1, float32 op2, float_status *stat)
+{
+    op1 = float32_squash_input_denormal(op1, stat);
+    op2 = float32_squash_input_denormal(op2, stat);
+
+    if ((float32_is_infinity(op1) && float32_is_zero(op2)) ||
+        (float32_is_infinity(op2) && float32_is_zero(op1))) {
+        return float32_two;
+    }
+    return float32_sub(float32_two, float32_mul(op1, op2, stat), stat);
+}
+
 #define DO_3OP(NAME, FUNC, TYPE) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
 {                                                                          \
@@ -854,6 +882,9 @@ DO_3OP(gvec_fmaxnum_s, float32_maxnum, float32)
 DO_3OP(gvec_fminnum_h, float16_minnum, float16)
 DO_3OP(gvec_fminnum_s, float32_minnum, float32)
 
+DO_3OP(gvec_recps_nf_h, float16_recps_nf, float16)
+DO_3OP(gvec_recps_nf_s, float32_recps_nf, float32)
+
 #ifdef TARGET_AARCH64
 
 DO_3OP(gvec_recps_h, helper_recpsf_f16, float16)
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 586dfd22e5e..1f452409d4d 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -529,19 +529,6 @@ uint32_t HELPER(vfp_fcvt_f64_to_f16)(float64 a, void *fpstp, uint32_t ahp_mode)
     return r;
 }
 
-float32 HELPER(recps_f32)(CPUARMState *env, float32 a, float32 b)
-{
-    float_status *s = &env->vfp.standard_fp_status;
-    if ((float32_is_infinity(a) && float32_is_zero_or_denormal(b)) ||
-        (float32_is_infinity(b) && float32_is_zero_or_denormal(a))) {
-        if (!(float32_is_zero(a) || float32_is_zero(b))) {
-            float_raise(float_flag_input_denormal, s);
-        }
-        return float32_two;
-    }
-    return float32_sub(float32_two, float32_mul(a, b, s), s);
-}
-
 float32 HELPER(rsqrts_f32)(CPUARMState *env, float32 a, float32 b)
 {
     float_status *s = &env->vfp.standard_fp_status;
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index fe9d09973c2..9d077be976d 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -1074,6 +1074,7 @@ DO_3S_FP_GVEC(VMLA, gen_helper_gvec_fmla_s, gen_helper_gvec_fmla_h)
 DO_3S_FP_GVEC(VMLS, gen_helper_gvec_fmls_s, gen_helper_gvec_fmls_h)
 DO_3S_FP_GVEC(VFMA, gen_helper_gvec_vfma_s, gen_helper_gvec_vfma_h)
 DO_3S_FP_GVEC(VFMS, gen_helper_gvec_vfms_s, gen_helper_gvec_vfms_h)
+DO_3S_FP_GVEC(VRECPS, gen_helper_gvec_recps_nf_s, gen_helper_gvec_recps_nf_h)
 
 WRAP_FP_GVEC(gen_VMAXNM_fp32_3s, FPST_STD, gen_helper_gvec_fmaxnum_s)
 WRAP_FP_GVEC(gen_VMAXNM_fp16_3s, FPST_STD_F16, gen_helper_gvec_fmaxnum_h)
@@ -1110,26 +1111,6 @@ static bool trans_VMINNM_fp_3s(DisasContext *s, arg_3same *a)
     return do_3same(s, a, gen_VMINNM_fp32_3s);
 }
 
-WRAP_ENV_FN(gen_VRECPS_tramp, gen_helper_recps_f32)
-
-static void gen_VRECPS_fp_3s(unsigned vece, uint32_t rd_ofs,
-                             uint32_t rn_ofs, uint32_t rm_ofs,
-                             uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen3 ops = { .fni4 = gen_VRECPS_tramp };
-    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &ops);
-}
-
-static bool trans_VRECPS_fp_3s(DisasContext *s, arg_3same *a)
-{
-    if (a->size != 0) {
-        /* TODO fp16 support */
-        return false;
-    }
-
-    return do_3same(s, a, gen_VRECPS_fp_3s);
-}
-
 WRAP_ENV_FN(gen_VRSQRTS_tramp, gen_helper_rsqrts_f32)
 
 static void gen_VRSQRTS_fp_3s(unsigned vece, uint32_t rd_ofs,
-- 
2.20.1


