Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419EEC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0ED215A4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qiWHxe+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0ED215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8HT-0002a8-5B
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83n-0008Pt-2e
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:59 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:56295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83k-0006EV-Oy
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:58 -0400
Received: by mail-wm1-x336.google.com with SMTP id a65so1537795wme.5
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=vDUYcD7pvi3Ifu5u3OJmIJiYp59u5Ae51Z8NHkuIuqw=;
 b=qiWHxe+MEVtc5Z39KDJHXfliCiA5vsdKzSxt8e/CNYtplS9atmU2eMXJmU4RSOfUHi
 hitxpj2mh1BwdjlS3gVWvnygFplGnsa12iujbUHuUhvQTxLyurJknUrsqjM3hyARtPiP
 N6RjUK3s0zCii6d/fFODvxNvqplwAcy9iIhVZEcS2wpjunpdsTBoqUSQirvCQ8Aw6eZb
 3YNUveEvfPs+yhvm0w6Z4aJA8H+NHi/rZA2VnVaiSZBQzQz1s09j1ErB8SwxC8u7q+3D
 qbc6vPuaWDLeow4PptPn6v06zRzNwtIPc71ZbMEcrrsMusiBOzTl/jkrQ9AOiR4up2JM
 9XmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vDUYcD7pvi3Ifu5u3OJmIJiYp59u5Ae51Z8NHkuIuqw=;
 b=EiGoDpKJeVyFgyfjzcwMZC0KJWEaTGzjuo8phDof4qO46j8MMqPcDvr903v/JOJMiH
 YWIKSJs4kK2VaZ6slbQvUxzjaORKp1GvqOLTW0Mn1dmlU+hzMxJuVK8MHCz57y5u4Hhq
 BQNzr77AyCHW4WKHwXtuuHJPkB+w+sxunoFW8MyUBzKSrfR+5Qpp8dPGMW6qwJG/VHbm
 jbyI9sBN//gbIxtCkmlbEJ1ucBZpP8ob+oKSTNZ+7RkbogSZXJ36HxPTlX4T1lu6rthh
 eaOmN6UV4iKIKqSMa8zgasayd7Nihk/sYGiOS5G1or5tn244FPiVSlN6r/N2BxFH/Cxe
 H0rg==
X-Gm-Message-State: AOAM533O3i78BDC8yZE4d1EQhHOAkpsuz+Re6x2k/aKZPPoV2TuyDKSh
 bG1+UpXKAJw/SOGHFtgzOk6aV0AJafJIbUH3
X-Google-Smtp-Source: ABdhPJyligUbsEHZtDJ9ceYW+J24uJK3bwAsseGbUpldbaCW//bb2DL1VjjtgG6DVI72IVFf4CkOhA==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr2289138wmi.20.1598973529525; 
 Tue, 01 Sep 2020 08:18:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/47] target/arm: Implement VFP fp16 VRINT*
Date: Tue,  1 Sep 2020 16:17:54 +0100
Message-Id: <20200901151823.29785-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Implement the fp16 version of the VFP VRINT* insns.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-19-peter.maydell@linaro.org
---
 target/arm/helper.h            |  2 +
 target/arm/vfp-uncond.decode   |  6 ++-
 target/arm/vfp.decode          |  3 ++
 target/arm/vfp_helper.c        | 21 ++++++++
 target/arm/translate-vfp.c.inc | 98 +++++++++++++++++++++++++++++++---
 5 files changed, 122 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 03193728476..f5ad5088bf1 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -242,8 +242,10 @@ DEF_HELPER_3(shr_cc, i32, env, i32, i32)
 DEF_HELPER_3(sar_cc, i32, env, i32, i32)
 DEF_HELPER_3(ror_cc, i32, env, i32, i32)
 
+DEF_HELPER_FLAGS_2(rinth_exact, TCG_CALL_NO_RWG, f16, f16, ptr)
 DEF_HELPER_FLAGS_2(rints_exact, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(rintd_exact, TCG_CALL_NO_RWG, f64, f64, ptr)
+DEF_HELPER_FLAGS_2(rinth, TCG_CALL_NO_RWG, f16, f16, ptr)
 DEF_HELPER_FLAGS_2(rints, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(rintd, TCG_CALL_NO_RWG, f64, f64, ptr)
 
diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 8ba7b1703e0..9615544623a 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -60,10 +60,12 @@ VMINNM_sp   1111 1110 1.00 .... .... 1010 .1.0 ....         @vfp_dnm_s
 VMAXNM_dp   1111 1110 1.00 .... .... 1011 .0.0 ....         @vfp_dnm_d
 VMINNM_dp   1111 1110 1.00 .... .... 1011 .1.0 ....         @vfp_dnm_d
 
+VRINT       1111 1110 1.11 10 rm:2 .... 1001 01.0 .... \
+            vm=%vm_sp vd=%vd_sp sz=1
 VRINT       1111 1110 1.11 10 rm:2 .... 1010 01.0 .... \
-            vm=%vm_sp vd=%vd_sp dp=0
+            vm=%vm_sp vd=%vd_sp sz=2
 VRINT       1111 1110 1.11 10 rm:2 .... 1011 01.0 .... \
-            vm=%vm_dp vd=%vd_dp dp=1
+            vm=%vm_dp vd=%vd_dp sz=3
 
 # VCVT float to int with specified rounding mode; Vd is always single-precision
 VCVT        1111 1110 1.11 11 rm:2 .... 1001 op:1 1.0 .... \
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index a8f1137be1e..9a79e99f1b0 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -195,12 +195,15 @@ VCVT_f16_f32 ---- 1110 1.11 0011 .... 1010 t:1 1.0 .... \
 VCVT_f16_f64 ---- 1110 1.11 0011 .... 1011 t:1 1.0 .... \
              vd=%vd_sp vm=%vm_dp
 
+VRINTR_hp    ---- 1110 1.11 0110 .... 1001 01.0 ....        @vfp_dm_ss
 VRINTR_sp    ---- 1110 1.11 0110 .... 1010 01.0 ....        @vfp_dm_ss
 VRINTR_dp    ---- 1110 1.11 0110 .... 1011 01.0 ....        @vfp_dm_dd
 
+VRINTZ_hp    ---- 1110 1.11 0110 .... 1001 11.0 ....        @vfp_dm_ss
 VRINTZ_sp    ---- 1110 1.11 0110 .... 1010 11.0 ....        @vfp_dm_ss
 VRINTZ_dp    ---- 1110 1.11 0110 .... 1011 11.0 ....        @vfp_dm_dd
 
+VRINTX_hp    ---- 1110 1.11 0111 .... 1001 01.0 ....        @vfp_dm_ss
 VRINTX_sp    ---- 1110 1.11 0111 .... 1010 01.0 ....        @vfp_dm_ss
 VRINTX_dp    ---- 1110 1.11 0111 .... 1011 01.0 ....        @vfp_dm_dd
 
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index ab3f0b170a7..586dfd22e5e 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1019,6 +1019,11 @@ float64 VFP_HELPER(muladd, d)(float64 a, float64 b, float64 c, void *fpstp)
 }
 
 /* ARMv8 round to integral */
+dh_ctype_f16 HELPER(rinth_exact)(dh_ctype_f16 x, void *fp_status)
+{
+    return float16_round_to_int(x, fp_status);
+}
+
 float32 HELPER(rints_exact)(float32 x, void *fp_status)
 {
     return float32_round_to_int(x, fp_status);
@@ -1029,6 +1034,22 @@ float64 HELPER(rintd_exact)(float64 x, void *fp_status)
     return float64_round_to_int(x, fp_status);
 }
 
+dh_ctype_f16 HELPER(rinth)(dh_ctype_f16 x, void *fp_status)
+{
+    int old_flags = get_float_exception_flags(fp_status), new_flags;
+    float16 ret;
+
+    ret = float16_round_to_int(x, fp_status);
+
+    /* Suppress any inexact exceptions the conversion produced */
+    if (!(old_flags & float_flag_inexact)) {
+        new_flags = get_float_exception_flags(fp_status);
+        set_float_exception_flags(new_flags & ~float_flag_inexact, fp_status);
+    }
+
+    return ret;
+}
+
 float32 HELPER(rints)(float32 x, void *fp_status)
 {
     int old_flags = get_float_exception_flags(fp_status), new_flags;
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 869b67b2b93..7ce044fa896 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -341,7 +341,7 @@ static const uint8_t fp_decode_rm[] = {
 static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
 {
     uint32_t rd, rm;
-    bool dp = a->dp;
+    int sz = a->sz;
     TCGv_ptr fpst;
     TCGv_i32 tcg_rmode;
     int rounding = fp_decode_rm[a->rm];
@@ -350,12 +350,16 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
+    if (sz == 3 && !dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
+    if (sz == 1 && !dc_isar_feature(aa32_fp16_arith, s)) {
         return false;
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
+    if (sz == 3 && !dc_isar_feature(aa32_simd_r32, s) &&
         ((a->vm | a->vd) & 0x10)) {
         return false;
     }
@@ -367,12 +371,16 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    if (sz == 1) {
+        fpst = fpstatus_ptr(FPST_FPCR_F16);
+    } else {
+        fpst = fpstatus_ptr(FPST_FPCR);
+    }
 
     tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
 
-    if (dp) {
+    if (sz == 3) {
         TCGv_i64 tcg_op;
         TCGv_i64 tcg_res;
         tcg_op = tcg_temp_new_i64();
@@ -388,7 +396,11 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         tcg_op = tcg_temp_new_i32();
         tcg_res = tcg_temp_new_i32();
         neon_load_reg32(tcg_op, rm);
-        gen_helper_rints(tcg_res, tcg_op, fpst);
+        if (sz == 1) {
+            gen_helper_rinth(tcg_res, tcg_op, fpst);
+        } else {
+            gen_helper_rints(tcg_res, tcg_op, fpst);
+        }
         neon_store_reg32(tcg_res, rd);
         tcg_temp_free_i32(tcg_op);
         tcg_temp_free_i32(tcg_res);
@@ -2638,6 +2650,29 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
     return true;
 }
 
+static bool trans_VRINTR_hp(DisasContext *s, arg_VRINTR_sp *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 tmp;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = tcg_temp_new_i32();
+    neon_load_reg32(tmp, a->vm);
+    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    gen_helper_rinth(tmp, tmp, fpst);
+    neon_store_reg32(tmp, a->vd);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(tmp);
+    return true;
+}
+
 static bool trans_VRINTR_sp(DisasContext *s, arg_VRINTR_sp *a)
 {
     TCGv_ptr fpst;
@@ -2693,6 +2728,34 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
     return true;
 }
 
+static bool trans_VRINTZ_hp(DisasContext *s, arg_VRINTZ_sp *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 tmp;
+    TCGv_i32 tcg_rmode;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = tcg_temp_new_i32();
+    neon_load_reg32(tmp, a->vm);
+    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    tcg_rmode = tcg_const_i32(float_round_to_zero);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+    gen_helper_rinth(tmp, tmp, fpst);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+    neon_store_reg32(tmp, a->vd);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(tcg_rmode);
+    tcg_temp_free_i32(tmp);
+    return true;
+}
+
 static bool trans_VRINTZ_sp(DisasContext *s, arg_VRINTZ_sp *a)
 {
     TCGv_ptr fpst;
@@ -2758,6 +2821,29 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
     return true;
 }
 
+static bool trans_VRINTX_hp(DisasContext *s, arg_VRINTX_sp *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 tmp;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = tcg_temp_new_i32();
+    neon_load_reg32(tmp, a->vm);
+    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    gen_helper_rinth_exact(tmp, tmp, fpst);
+    neon_store_reg32(tmp, a->vd);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(tmp);
+    return true;
+}
+
 static bool trans_VRINTX_sp(DisasContext *s, arg_VRINTX_sp *a)
 {
     TCGv_ptr fpst;
-- 
2.20.1


