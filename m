Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D55C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013ED22CF7
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WyAihLEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013ED22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dRk-0001t4-7F
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3dOX-0005UO-LV
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:45:09 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:36546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3dOQ-0007IQ-O8
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:45:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id 3so9208974wmi.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UFF5f+eJ9S3MOWSlwF3nLC25z1jwDMEdd5QQVZv2OZA=;
 b=WyAihLEv0ZTl0tyI2mlk9FZFJ7wWDH3S4Qw3KcoEOYAxo07nlRIOxuXOgZvDmnaVXL
 gorDr7M1ofsi9VPFTUswEuTgr+TGvgKzNPCff9NdGwqM/UbRe5bxrIfxVIjqwZf4P7pp
 ZLE1YfMnFg2euqLg2K7rnp4k/wBa5Ytaz8UR681yRUV2oKRJn7zwJZ009pqI4iWXXcDG
 UjfBnbeCV32B85YoGPtFxneBZwmxoYFOSjZIqWs9Tw+sFkHpAMY6YFKBdIhzGs0kLIht
 9xcgANQaG7BZ7eB/roPvgei50c4M0857twdxgVhExLxRVCP4c1XwKUeGaOb/GQbCvsmX
 ZPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UFF5f+eJ9S3MOWSlwF3nLC25z1jwDMEdd5QQVZv2OZA=;
 b=ZuEw9ilPmeWjV8tj8QJVlxcf9OFlSKa0Es5PIRuqAeRv/ysgyJX0UAwLZuJVbS9Fqy
 GgLOrBtq62iRcNE9PKdDh0f349Uhc0T9YoaStWMvMeAxaXuOIVeqs/ggpg2VCLcUsmbF
 m6cAKk60dD1RtNnTre+qEfZnBmYgQeG5h4M1EyJNIWziSjYaaLpAohG6BDOL7o+leAUT
 jO1SmA7IvRyO491/lFBzwdwKBl7/xb3LG4fngwH8XOagj7/kxU+VKiUUBHL03LULlwX+
 NFQ2IVTpCM4p/G/NwNsO98nUC5KMYtNTo2KUEmhb4waVEgX4aPIzkE/gjIyDxEX13aGG
 GrOQ==
X-Gm-Message-State: AOAM530LmAarWWURpDA8i85ZnM8icJUfnXM2q6nUNwb5tDUnwkxawn5x
 MTPm77gb7DX+UKV6rY8iTjiBZw==
X-Google-Smtp-Source: ABdhPJxhqdVVUDka4ftLPZATUq8SRgo6kLO6gsumjqx0yzi4VoYQytp+CWqoIqfVcf3lVBimjrBNMA==
X-Received: by 2002:a1c:1d2:: with SMTP id 201mr6917750wmb.132.1596710698919; 
 Thu, 06 Aug 2020 03:44:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a10sm6042189wrx.15.2020.08.06.03.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:44:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/4] target/arm: Make A32/T32 use new fpstatus_ptr() API
Date: Thu,  6 Aug 2020 11:44:51 +0100
Message-Id: <20200806104453.30393-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200806104453.30393-1-peter.maydell@linaro.org>
References: <20200806104453.30393-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Make A32/T32 code use the new fpstatus_ptr() API:
 get_fpstatus_ptr(0) -> fpstatus_ptr(FPST_FPCR)
 get_fpstatus_ptr(1) -> fpstatus_ptr(FPST_STD)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 28 ++++++++++-----------
 target/arm/translate-vfp.inc.c  | 44 ++++++++++++++++-----------------
 target/arm/translate.c          | 13 ----------
 3 files changed, 36 insertions(+), 49 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index f6cb9215739..5158dd14ad2 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -181,7 +181,7 @@ static bool trans_VCMLA(DisasContext *s, arg_VCMLA *a)
     }
 
     opr_sz = (1 + a->q) * 8;
-    fpst = get_fpstatus_ptr(1);
+    fpst = fpstatus_ptr(FPST_STD);
     fn_gvec_ptr = a->size ? gen_helper_gvec_fcmlas : gen_helper_gvec_fcmlah;
     tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
@@ -218,7 +218,7 @@ static bool trans_VCADD(DisasContext *s, arg_VCADD *a)
     }
 
     opr_sz = (1 + a->q) * 8;
-    fpst = get_fpstatus_ptr(1);
+    fpst = fpstatus_ptr(FPST_STD);
     fn_gvec_ptr = a->size ? gen_helper_gvec_fcadds : gen_helper_gvec_fcaddh;
     tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
@@ -322,7 +322,7 @@ static bool trans_VCMLA_scalar(DisasContext *s, arg_VCMLA_scalar *a)
     fn_gvec_ptr = (a->size ? gen_helper_gvec_fcmlas_idx
                    : gen_helper_gvec_fcmlah_idx);
     opr_sz = (1 + a->q) * 8;
-    fpst = get_fpstatus_ptr(1);
+    fpst = fpstatus_ptr(FPST_STD);
     tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
                        vfp_reg_offset(1, a->vm),
@@ -358,7 +358,7 @@ static bool trans_VDOT_scalar(DisasContext *s, arg_VDOT_scalar *a)
 
     fn_gvec = a->u ? gen_helper_gvec_udot_idx_b : gen_helper_gvec_sdot_idx_b;
     opr_sz = (1 + a->q) * 8;
-    fpst = get_fpstatus_ptr(1);
+    fpst = fpstatus_ptr(FPST_STD);
     tcg_gen_gvec_3_ool(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
                        vfp_reg_offset(1, a->rm),
@@ -1063,7 +1063,7 @@ static bool do_3same_fp(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn,
         return true;
     }
 
-    TCGv_ptr fpstatus = get_fpstatus_ptr(1);
+    TCGv_ptr fpstatus = fpstatus_ptr(FPST_STD);
     for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
         tmp = neon_load_reg(a->vn, pass);
         tmp2 = neon_load_reg(a->vm, pass);
@@ -1091,7 +1091,7 @@ static bool do_3same_fp(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn,
                                 uint32_t rn_ofs, uint32_t rm_ofs,       \
                                 uint32_t oprsz, uint32_t maxsz)         \
     {                                                                   \
-        TCGv_ptr fpst = get_fpstatus_ptr(1);                            \
+        TCGv_ptr fpst = fpstatus_ptr(FPST_STD);                         \
         tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, fpst,                \
                            oprsz, maxsz, 0, FUNC);                      \
         tcg_temp_free_ptr(fpst);                                        \
@@ -1287,7 +1287,7 @@ static bool do_3same_fp_pair(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
      * early. Since Q is 0 there are always just two passes, so instead
      * of a complicated loop over each pass we just unroll.
      */
-    fpstatus = get_fpstatus_ptr(1);
+    fpstatus = fpstatus_ptr(FPST_STD);
     tmp = neon_load_reg(a->vn, 0);
     tmp2 = neon_load_reg(a->vn, 1);
     fn(tmp, tmp, tmp2, fpstatus);
@@ -1790,7 +1790,7 @@ static bool do_fp_2sh(DisasContext *s, arg_2reg_shift *a,
         return true;
     }
 
-    fpstatus = get_fpstatus_ptr(1);
+    fpstatus = fpstatus_ptr(FPST_STD);
     shiftv = tcg_const_i32(a->shift);
     for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
         tmp = neon_load_reg(a->vm, pass);
@@ -2591,7 +2591,7 @@ static bool trans_VMLS_2sc(DisasContext *s, arg_2scalar *a)
 #define WRAP_FP_FN(WRAPNAME, FUNC)                              \
     static void WRAPNAME(TCGv_i32 rd, TCGv_i32 rn, TCGv_i32 rm) \
     {                                                           \
-        TCGv_ptr fpstatus = get_fpstatus_ptr(1);                \
+        TCGv_ptr fpstatus = fpstatus_ptr(FPST_STD);             \
         FUNC(rd, rn, rm, fpstatus);                             \
         tcg_temp_free_ptr(fpstatus);                            \
     }
@@ -3480,7 +3480,7 @@ static bool trans_VCVT_F16_F32(DisasContext *s, arg_2misc *a)
         return true;
     }
 
-    fpst = get_fpstatus_ptr(true);
+    fpst = fpstatus_ptr(FPST_STD);
     ahp = get_ahp_flag();
     tmp = neon_load_reg(a->vm, 0);
     gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
@@ -3528,7 +3528,7 @@ static bool trans_VCVT_F32_F16(DisasContext *s, arg_2misc *a)
         return true;
     }
 
-    fpst = get_fpstatus_ptr(true);
+    fpst = fpstatus_ptr(FPST_STD);
     ahp = get_ahp_flag();
     tmp3 = tcg_temp_new_i32();
     tmp = neon_load_reg(a->vm, 0);
@@ -3838,7 +3838,7 @@ static bool do_2misc_fp(DisasContext *s, arg_2misc *a,
         return true;
     }
 
-    fpst = get_fpstatus_ptr(1);
+    fpst = fpstatus_ptr(FPST_STD);
     for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
         TCGv_i32 tmp = neon_load_reg(a->vm, pass);
         fn(tmp, tmp, fpst);
@@ -3932,7 +3932,7 @@ static bool do_vrint(DisasContext *s, arg_2misc *a, int rmode)
         return true;
     }
 
-    fpst = get_fpstatus_ptr(1);
+    fpst = fpstatus_ptr(FPST_STD);
     tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
     gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode, cpu_env);
     for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
@@ -3993,7 +3993,7 @@ static bool do_vcvt(DisasContext *s, arg_2misc *a, int rmode, bool is_signed)
         return true;
     }
 
-    fpst = get_fpstatus_ptr(1);
+    fpst = fpstatus_ptr(FPST_STD);
     tcg_shift = tcg_const_i32(0);
     tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
     gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode, cpu_env);
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 463253de90b..4e0458e4206 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -359,7 +359,7 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         return true;
     }
 
-    fpst = get_fpstatus_ptr(0);
+    fpst = fpstatus_ptr(FPST_FPCR);
 
     tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
@@ -422,7 +422,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
         return true;
     }
 
-    fpst = get_fpstatus_ptr(0);
+    fpst = fpstatus_ptr(FPST_FPCR);
 
     tcg_shift = tcg_const_i32(0);
 
@@ -1231,7 +1231,7 @@ static bool do_vfp_3op_sp(DisasContext *s, VFPGen3OpSPFn *fn,
     f0 = tcg_temp_new_i32();
     f1 = tcg_temp_new_i32();
     fd = tcg_temp_new_i32();
-    fpst = get_fpstatus_ptr(0);
+    fpst = fpstatus_ptr(FPST_FPCR);
 
     neon_load_reg32(f0, vn);
     neon_load_reg32(f1, vm);
@@ -1314,7 +1314,7 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
     f0 = tcg_temp_new_i64();
     f1 = tcg_temp_new_i64();
     fd = tcg_temp_new_i64();
-    fpst = get_fpstatus_ptr(0);
+    fpst = fpstatus_ptr(FPST_FPCR);
 
     neon_load_reg64(f0, vn);
     neon_load_reg64(f1, vm);
@@ -1796,7 +1796,7 @@ static bool do_vfm_sp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
         /* VFNMA, VFNMS */
         gen_helper_vfp_negs(vd, vd);
     }
-    fpst = get_fpstatus_ptr(0);
+    fpst = fpstatus_ptr(FPST_FPCR);
     gen_helper_vfp_muladds(vd, vn, vm, vd, fpst);
     neon_store_reg32(vd, a->vd);
 
@@ -1887,7 +1887,7 @@ static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
         /* VFNMA, VFNMS */
         gen_helper_vfp_negd(vd, vd);
     }
-    fpst = get_fpstatus_ptr(0);
+    fpst = fpstatus_ptr(FPST_FPCR);
     gen_helper_vfp_muladdd(vd, vn, vm, vd, fpst);
     neon_store_reg64(vd, a->vd);
 
@@ -2171,7 +2171,7 @@ static bool trans_VCVT_f32_f16(DisasContext *s, arg_VCVT_f32_f16 *a)
         return true;
     }
 
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
     /* The T bit tells us if we want the low or high 16 bits of Vm */
@@ -2208,7 +2208,7 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
         return true;
     }
 
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
     /* The T bit tells us if we want the low or high 16 bits of Vm */
@@ -2237,7 +2237,7 @@ static bool trans_VCVT_f16_f32(DisasContext *s, arg_VCVT_f16_f32 *a)
         return true;
     }
 
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
 
@@ -2274,7 +2274,7 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
         return true;
     }
 
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
     vm = tcg_temp_new_i64();
@@ -2304,7 +2304,7 @@ static bool trans_VRINTR_sp(DisasContext *s, arg_VRINTR_sp *a)
 
     tmp = tcg_temp_new_i32();
     neon_load_reg32(tmp, a->vm);
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     gen_helper_rints(tmp, tmp, fpst);
     neon_store_reg32(tmp, a->vd);
     tcg_temp_free_ptr(fpst);
@@ -2336,7 +2336,7 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
 
     tmp = tcg_temp_new_i64();
     neon_load_reg64(tmp, a->vm);
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     gen_helper_rintd(tmp, tmp, fpst);
     neon_store_reg64(tmp, a->vd);
     tcg_temp_free_ptr(fpst);
@@ -2360,7 +2360,7 @@ static bool trans_VRINTZ_sp(DisasContext *s, arg_VRINTZ_sp *a)
 
     tmp = tcg_temp_new_i32();
     neon_load_reg32(tmp, a->vm);
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     tcg_rmode = tcg_const_i32(float_round_to_zero);
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
     gen_helper_rints(tmp, tmp, fpst);
@@ -2397,7 +2397,7 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
 
     tmp = tcg_temp_new_i64();
     neon_load_reg64(tmp, a->vm);
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     tcg_rmode = tcg_const_i32(float_round_to_zero);
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
     gen_helper_rintd(tmp, tmp, fpst);
@@ -2424,7 +2424,7 @@ static bool trans_VRINTX_sp(DisasContext *s, arg_VRINTX_sp *a)
 
     tmp = tcg_temp_new_i32();
     neon_load_reg32(tmp, a->vm);
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     gen_helper_rints_exact(tmp, tmp, fpst);
     neon_store_reg32(tmp, a->vd);
     tcg_temp_free_ptr(fpst);
@@ -2456,7 +2456,7 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
 
     tmp = tcg_temp_new_i64();
     neon_load_reg64(tmp, a->vm);
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     gen_helper_rintd_exact(tmp, tmp, fpst);
     neon_store_reg64(tmp, a->vd);
     tcg_temp_free_ptr(fpst);
@@ -2535,7 +2535,7 @@ static bool trans_VCVT_int_sp(DisasContext *s, arg_VCVT_int_sp *a)
 
     vm = tcg_temp_new_i32();
     neon_load_reg32(vm, a->vm);
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     if (a->s) {
         /* i32 -> f32 */
         gen_helper_vfp_sitos(vm, vm, fpst);
@@ -2571,7 +2571,7 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
     vm = tcg_temp_new_i32();
     vd = tcg_temp_new_i64();
     neon_load_reg32(vm, a->vm);
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     if (a->s) {
         /* i32 -> f64 */
         gen_helper_vfp_sitod(vd, vm, fpst);
@@ -2637,7 +2637,7 @@ static bool trans_VCVT_fix_sp(DisasContext *s, arg_VCVT_fix_sp *a)
     vd = tcg_temp_new_i32();
     neon_load_reg32(vd, a->vd);
 
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     shift = tcg_const_i32(frac_bits);
 
     /* Switch on op:U:sx bits */
@@ -2702,7 +2702,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     vd = tcg_temp_new_i64();
     neon_load_reg64(vd, a->vd);
 
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     shift = tcg_const_i32(frac_bits);
 
     /* Switch on op:U:sx bits */
@@ -2755,7 +2755,7 @@ static bool trans_VCVT_sp_int(DisasContext *s, arg_VCVT_sp_int *a)
         return true;
     }
 
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     vm = tcg_temp_new_i32();
     neon_load_reg32(vm, a->vm);
 
@@ -2797,7 +2797,7 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
         return true;
     }
 
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     vm = tcg_temp_new_i64();
     vd = tcg_temp_new_i32();
     neon_load_reg64(vm, a->vm);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e1f5357c367..3bce39c953a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1094,19 +1094,6 @@ static inline void gen_hlt(DisasContext *s, int imm)
     unallocated_encoding(s);
 }
 
-static TCGv_ptr get_fpstatus_ptr(int neon)
-{
-    TCGv_ptr statusptr = tcg_temp_new_ptr();
-    int offset;
-    if (neon) {
-        offset = offsetof(CPUARMState, vfp.standard_fp_status);
-    } else {
-        offset = offsetof(CPUARMState, vfp.fp_status);
-    }
-    tcg_gen_addi_ptr(statusptr, cpu_env, offset);
-    return statusptr;
-}
-
 static inline long vfp_reg_offset(bool dp, unsigned reg)
 {
     if (dp) {
-- 
2.20.1


