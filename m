Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C88C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BCD32071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sWB3ujRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BCD32071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADbw-0005R3-Nh
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADU3-0000Ld-R5
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:30:05 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTx-0002kY-5V
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:30:02 -0400
Received: by mail-wm1-x343.google.com with SMTP id x9so4445949wmi.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=lToFvDlw9oyjU7u0m49zZtnOxlYUPIttxS3GCs2ugGI=;
 b=sWB3ujRs63dcMv22yWHQA0+ADdWEUx+c+4qTN1x6vbtBqdapnJtewLpXyRqb8IuPUs
 K4KPuX2XbDi9piytby35hDKP76gd4PDxbpIwO+JkkF7mhgWu1qlMR6r1r2uC50dXhzGp
 JgJyM+8I+BGXRTgRnuPVyNGlYciysNtJpanH/7ZYgB1QYAMWWeRbWMjkhx4x4jv/j/fu
 P7l0gCmffEzUCQXN/UAWsePhFiGj1Qw8LtFkjBru912QOnrPqLq/EDW47Vd1A6GWrB2G
 Yxj1BDHwbSXWQEEcgJlN3nTA+MmsF2yGVRSuHX6S4m49YEagG89NDpm83wwiFcfVszFz
 XzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lToFvDlw9oyjU7u0m49zZtnOxlYUPIttxS3GCs2ugGI=;
 b=lIP/2vsK6bdd4eLYnziXMnZWBDPYdS4kecq68BTDTMI/SlBOumq9ebsF1ZYX+GJbNK
 45AXt0KNtcqkkw6tlK/LiAToWBAwPmr0yutg21KjTkU8Rwk9UKeiazmrxttJWSIKlGwI
 a+DT161MpTeh5NbNLTAFshZbRTZr2vhqClRwk8EaiiDqhzmIXRGlrJBBgObZRRsAg+GY
 rXW0Thu+4FwveyX3arw/HL6dwUxS8rmmv+B7vGsP/ZPBzB9Zjlk8PT81DmpjLAjOVN3A
 pQaSi7cwahpeJKmV15lHmvTaHPAh5H/YetBYOGgVCPjs1+WKaAXvdnojQDsSmFaSPmV4
 qRaA==
X-Gm-Message-State: AOAM533/MTVRkyz/0kSPwJyE+hn0WDbGL0oqF9nLIm4e4zwCtlPCLVs4
 EF3aqRgTFYisF4c6yIuDCzzScw==
X-Google-Smtp-Source: ABdhPJzS/w7nci9XOxfM2hljgSNTh1IU6RehKiQzUfshivkjqeG4swfv8W6u5+5e5UDx53puKuA9TA==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr5791186wmj.36.1598279395725;
 Mon, 24 Aug 2020 07:29:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b14sm24499091wrj.93.2020.08.24.07.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 07:29:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 18/22] target/arm: Implement VFP fp16 VRINT*
Date: Mon, 24 Aug 2020 15:29:30 +0100
Message-Id: <20200824142934.20850-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824142934.20850-1-peter.maydell@linaro.org>
References: <20200824142934.20850-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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
---
 target/arm/helper.h            |  2 +
 target/arm/vfp-uncond.decode   |  6 ++-
 target/arm/vfp.decode          |  3 ++
 target/arm/vfp_helper.c        | 21 ++++++++
 target/arm/translate-vfp.c.inc | 98 +++++++++++++++++++++++++++++++---
 5 files changed, 122 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index eefd1ac2a72..d1315e0ef3e 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -242,8 +242,10 @@ DEF_HELPER_3(shr_cc, i32, env, i32, i32)
 DEF_HELPER_3(sar_cc, i32, env, i32, i32)
 DEF_HELPER_3(ror_cc, i32, env, i32, i32)
 
+DEF_HELPER_FLAGS_2(rinth_exact, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(rints_exact, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(rintd_exact, TCG_CALL_NO_RWG, f64, f64, ptr)
+DEF_HELPER_FLAGS_2(rinth, TCG_CALL_NO_RWG, f32, f32, ptr)
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
index c88ace3c566..5b8b4219615 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1018,6 +1018,11 @@ float64 VFP_HELPER(muladd, d)(float64 a, float64 b, float64 c, void *fpstp)
 }
 
 /* ARMv8 round to integral */
+float32 HELPER(rinth_exact)(float32 x, void *fp_status)
+{
+    return float16_round_to_int(x, fp_status);
+}
+
 float32 HELPER(rints_exact)(float32 x, void *fp_status)
 {
     return float32_round_to_int(x, fp_status);
@@ -1028,6 +1033,22 @@ float64 HELPER(rintd_exact)(float64 x, void *fp_status)
     return float64_round_to_int(x, fp_status);
 }
 
+float32 HELPER(rinth)(float32 x, void *fp_status)
+{
+    int old_flags = get_float_exception_flags(fp_status), new_flags;
+    float32 ret;
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


