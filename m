Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735D9C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1A3206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wgaUhX3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1A3206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8CA-0008S3-7R
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83z-0000Yb-F6
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:11 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83x-0006HT-1G
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:11 -0400
Received: by mail-wr1-x434.google.com with SMTP id e16so1996886wrm.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KAD5HVkWKqGNkcxnQI+l8QfJja7b5Jol+ZJ/P/xze8M=;
 b=wgaUhX3aLqqDqzA087J5Ta4UVQPgCSPZ9aj6/wzR9jBMaYSm2okYvo7B17ttboKdsS
 6XfaGmDsJjnVDs3Bsa9eQH9YEksplYeywJWz1or/IARVoThFSWFK5UyiIU3+1nmuuTrl
 RXXYuoYrhGuLjE/vKzbzmjdiMnnqhmsoFgleYDZ2TiqzgA7Re+qBpcakMVp4wb/lLPE/
 Apej2MKk5l2E44KIMVYhyIkKvXXfykljBpG/hfpz/C6DTPT1c4LfXorC16CqPbzmKMzF
 BszibNez5LkpVQ1xP8WwPhz+AcIDYJz6JxqsBlFLrs6u6x6Pc6WBIB4ET9JTrf/PSqNF
 /qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KAD5HVkWKqGNkcxnQI+l8QfJja7b5Jol+ZJ/P/xze8M=;
 b=GTcj2kcqL5UdsfFNVF649ZomRMjvhWQeJFhTXHTjM6ctiCosTedI5wWYbxGhQgm8fc
 nJstQew1Wa76PTh/e8hkjopBJKykfPfTPwVBepxDiIgx9s21Oyxu0QCYTeSiSzjnBv2s
 EJannoG2Q0q/IuDqxVuef+ZIL+M5jdgQ4XutuWpm8ebGWZY/ZLGWDW9ao4XRf6ZyPBRo
 JnS8aurTlMmpp2pluRalvP9sxGtbL3iK/IImVpoy5JOzLo5yPrLD5c8rpRM568b7f0ir
 9PBvzcrkLgMH9+rarrG+kr9+yDSvsNZwXtY4LWhSQaiJ3ROnZsQQ70QPeC2zzHV8PSPr
 CAOg==
X-Gm-Message-State: AOAM530S36gw9PyR512hbI7h4BMIiaG+kBFe5ZYKPOobwzyCLp9jzvGB
 OiyiEjfyK/4JjsRQsrTGKGzDlg4K91Z7pUX/
X-Google-Smtp-Source: ABdhPJxF8GGI6ApNCYwheq3H08bH9rv9QbDqeqkkqkz3/FcT8ZiHDBwkpnveoMPECS/jzSRpn8NzZQ==
X-Received: by 2002:adf:9c93:: with SMTP id d19mr2433605wre.275.1598973547259; 
 Tue, 01 Sep 2020 08:19:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.19.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:19:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/47] target/arm: Implement fp16 for Neon VRSQRTS
Date: Tue,  1 Sep 2020 16:18:09 +0100
Message-Id: <20200901151823.29785-34-peter.maydell@linaro.org>
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

Convert the Neon VRSQRTS insn to using a gvec helper,
and use this to implement the fp16 case.

As with VRECPS, we adjust the phrasing of the new implementation
slightly so that the fp32 version parallels the fp16 one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-35-peter.maydell@linaro.org
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
index 63e7be8e01d..4c6d63be3d3 100644
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


