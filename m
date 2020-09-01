Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27ADC28E83
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E2F621582
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOSBU17D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2F621582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8L2-0001Bx-QI
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83v-0000OA-SD
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:36593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83t-0006Gf-LV
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id z9so1560893wmk.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=vyfdSW/Bd1MGPjA5ljkSDhyfC37FOO2jsu8Bx4KsDE8=;
 b=sOSBU17Dkg0GeidcvU/W+pYjcagZyhrEEPy6BX+l+o0lYZB0wkKyB7wGjEQXD1Oi87
 MRi1YWwGUuMFvta8AWuS/u+aB6QOTLeZ3LoA0NEzO2gq2ZwgzbQ2sX6y196S7mrJoye7
 ED6RQiRezn0WAAyXiYViV1a9ukXCxmo9rbHJP5qEM5v4zvkI9cf2SQfWBVQU3qvWQ/f/
 lXFe0rg+R1u7bGul/QOrkmJHgWTfXf9lEMlwE8AQRgFFG5Z/jCEAmXNBrkPBx+dbtIxq
 u8BPmQlnlEn6RuYrk/e8JU7mewNYd+UObjQFgf5dBMrY7DKhqmA3PJ4WCzcK+nfLDC1d
 s5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vyfdSW/Bd1MGPjA5ljkSDhyfC37FOO2jsu8Bx4KsDE8=;
 b=dMxXBx7cePA8gERRhHG3Bcom8EtWKOh+NAAkT0hcXLIRIvw7W64G5fmBYEmj/K2Iuo
 E0r8zi8hjOnyQzVmLBfJPaAevtmF9lFlvESjQ/1i8WI4kvRpWsofElNd+YlRTxNNefwj
 TaF6aAG5fp3Tnvqw/MYRN7GAb93lSL5NZEsYxy5JoUvFkPFF8NgO7FtV1wG/ROZ82rVQ
 WNpbAgKadPtptS6Cxrq9s7pYvLcg9ks0ME7GItCFPgoeDIKYBe45YfHaIey8F+uob9GI
 HQ1wTwQZ9RyFM5JQs7vaU1A+RVlrnOCCVX/SpYPM94FWSN3S3aXsWyHDlnQ5E3gXQDLT
 GMYw==
X-Gm-Message-State: AOAM533zx1aQIqcKo/t7CIZBPa6HyweFZlhBDqSY3/DiFXyF//P2lyVq
 G9NLBp8BUxhUmEmbSuxCK91vpyUlef2uob+e
X-Google-Smtp-Source: ABdhPJxd/ja3Aey0Pxqt8SKDpFCK8GINf5DIYHIV0dEB3aaWPW0JLynN76ktbADsbBzd7IIAa7Tk8A==
X-Received: by 2002:a05:600c:4142:: with SMTP id
 h2mr2246935wmm.128.1598973544033; 
 Tue, 01 Sep 2020 08:19:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.19.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:19:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/47] target/arm: Implement fp16 for Neon VFMA, VMFS
Date: Tue,  1 Sep 2020 16:18:06 +0100
Message-Id: <20200901151823.29785-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Convert the neon floating-point vector operations VFMA and VFMS
to use a gvec helper, and use this to implement the fp16 case.

This is the last use of do_3same_fp() so we can now delete
that function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-32-peter.maydell@linaro.org
---
 target/arm/helper.h             |  6 +++
 target/arm/vec_helper.c         | 33 +++++++++++-
 target/arm/translate-neon.c.inc | 92 +--------------------------------
 3 files changed, 40 insertions(+), 91 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 6f6c96711b7..e6f65c74614 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -665,6 +665,12 @@ DEF_HELPER_FLAGS_5(gvec_fmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fmls_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fmls_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_vfma_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vfma_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 5da5969c1c0..995f09fb71e 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -867,7 +867,32 @@ static float32 float32_mulsub_nf(float32 dest, float32 op1, float32 op2,
     return float32_sub(dest, float32_mul(op1, op2, stat), stat);
 }
 
-#define DO_MULADD(NAME, FUNC, TYPE) \
+/* Fused versions; these have the semantics Neon VFMA/VFMS want */
+static float16 float16_muladd_f(float16 dest, float16 op1, float16 op2,
+                                float_status *stat)
+{
+    return float16_muladd(op1, op2, dest, 0, stat);
+}
+
+static float32 float32_muladd_f(float32 dest, float32 op1, float32 op2,
+                                 float_status *stat)
+{
+    return float32_muladd(op1, op2, dest, 0, stat);
+}
+
+static float16 float16_mulsub_f(float16 dest, float16 op1, float16 op2,
+                                 float_status *stat)
+{
+    return float16_muladd(float16_chs(op1), op2, dest, 0, stat);
+}
+
+static float32 float32_mulsub_f(float32 dest, float32 op1, float32 op2,
+                                 float_status *stat)
+{
+    return float32_muladd(float32_chs(op1), op2, dest, 0, stat);
+}
+
+#define DO_MULADD(NAME, FUNC, TYPE)                                     \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
 {                                                                          \
     intptr_t i, oprsz = simd_oprsz(desc);                                  \
@@ -884,6 +909,12 @@ DO_MULADD(gvec_fmla_s, float32_muladd_nf, float32)
 DO_MULADD(gvec_fmls_h, float16_mulsub_nf, float16)
 DO_MULADD(gvec_fmls_s, float32_mulsub_nf, float32)
 
+DO_MULADD(gvec_vfma_h, float16_muladd_f, float16)
+DO_MULADD(gvec_vfma_s, float32_muladd_f, float32)
+
+DO_MULADD(gvec_vfms_h, float16_mulsub_f, float16)
+DO_MULADD(gvec_vfms_s, float32_mulsub_f, float32)
+
 /* For the indexed ops, SVE applies the index per 128-bit vector segment.
  * For AdvSIMD, there is of course only one such vector segment.
  */
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index ab39127026b..4f2378a19b3 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -1033,55 +1033,6 @@ DO_3SAME_PAIR(VPADD, padd_u)
 DO_3SAME_VQDMULH(VQDMULH, qdmulh)
 DO_3SAME_VQDMULH(VQRDMULH, qrdmulh)
 
-static bool do_3same_fp(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn,
-                        bool reads_vd)
-{
-    /*
-     * FP operations handled elementwise 32 bits at a time.
-     * If reads_vd is true then the old value of Vd will be
-     * loaded before calling the callback function. This is
-     * used for multiply-accumulate type operations.
-     */
-    TCGv_i32 tmp, tmp2;
-    int pass;
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
-        return false;
-    }
-
-    if ((a->vn | a->vm | a->vd) & a->q) {
-        return false;
-    }
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    TCGv_ptr fpstatus = fpstatus_ptr(FPST_STD);
-    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
-        tmp = neon_load_reg(a->vn, pass);
-        tmp2 = neon_load_reg(a->vm, pass);
-        if (reads_vd) {
-            TCGv_i32 tmp_rd = neon_load_reg(a->vd, pass);
-            fn(tmp_rd, tmp, tmp2, fpstatus);
-            neon_store_reg(a->vd, pass, tmp_rd);
-            tcg_temp_free_i32(tmp);
-        } else {
-            fn(tmp, tmp, tmp2, fpstatus);
-            neon_store_reg(a->vd, pass, tmp);
-        }
-        tcg_temp_free_i32(tmp2);
-    }
-    tcg_temp_free_ptr(fpstatus);
-    return true;
-}
-
 #define WRAP_FP_GVEC(WRAPNAME, FPST, FUNC)                              \
     static void WRAPNAME(unsigned vece, uint32_t rd_ofs,                \
                          uint32_t rn_ofs, uint32_t rm_ofs,              \
@@ -1121,6 +1072,8 @@ DO_3S_FP_GVEC(VMAX, gen_helper_gvec_fmax_s, gen_helper_gvec_fmax_h)
 DO_3S_FP_GVEC(VMIN, gen_helper_gvec_fmin_s, gen_helper_gvec_fmin_h)
 DO_3S_FP_GVEC(VMLA, gen_helper_gvec_fmla_s, gen_helper_gvec_fmla_h)
 DO_3S_FP_GVEC(VMLS, gen_helper_gvec_fmls_s, gen_helper_gvec_fmls_h)
+DO_3S_FP_GVEC(VFMA, gen_helper_gvec_vfma_s, gen_helper_gvec_vfma_h)
+DO_3S_FP_GVEC(VFMS, gen_helper_gvec_vfms_s, gen_helper_gvec_vfms_h)
 
 WRAP_FP_GVEC(gen_VMAXNM_fp32_3s, FPST_STD, gen_helper_gvec_fmaxnum_s)
 WRAP_FP_GVEC(gen_VMAXNM_fp16_3s, FPST_STD_F16, gen_helper_gvec_fmaxnum_h)
@@ -1197,47 +1150,6 @@ static bool trans_VRSQRTS_fp_3s(DisasContext *s, arg_3same *a)
     return do_3same(s, a, gen_VRSQRTS_fp_3s);
 }
 
-static void gen_VFMA_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
-                            TCGv_ptr fpstatus)
-{
-    gen_helper_vfp_muladds(vd, vn, vm, vd, fpstatus);
-}
-
-static bool trans_VFMA_fp_3s(DisasContext *s, arg_3same *a)
-{
-    if (!dc_isar_feature(aa32_simdfmac, s)) {
-        return false;
-    }
-
-    if (a->size != 0) {
-        /* TODO fp16 support */
-        return false;
-    }
-
-    return do_3same_fp(s, a, gen_VFMA_fp_3s, true);
-}
-
-static void gen_VFMS_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
-                            TCGv_ptr fpstatus)
-{
-    gen_helper_vfp_negs(vn, vn);
-    gen_helper_vfp_muladds(vd, vn, vm, vd, fpstatus);
-}
-
-static bool trans_VFMS_fp_3s(DisasContext *s, arg_3same *a)
-{
-    if (!dc_isar_feature(aa32_simdfmac, s)) {
-        return false;
-    }
-
-    if (a->size != 0) {
-        /* TODO fp16 support */
-        return false;
-    }
-
-    return do_3same_fp(s, a, gen_VFMS_fp_3s, true);
-}
-
 static bool do_3same_fp_pair(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
 {
     /* FP operations handled pairwise 32 bits at a time */
-- 
2.20.1


