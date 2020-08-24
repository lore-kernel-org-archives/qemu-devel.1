Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0591C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85807205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMBRPCEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85807205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADX9-0005Sx-NS
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTk-00086w-IH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:44 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTi-0002fn-Jl
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id y3so8898448wrl.4
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=z0LweSzTMeWl7kBbeDzTSWVJVjJb29j+OfSsLTkCIBs=;
 b=ZMBRPCEUQhQt9V+B3uHD7qRFP8dqUq1u44OCNuKwkz8DK4hQYsC1ZnM55e6Hf/7p5f
 RvhlUYn6Kb54S0gfEgnbLjDWPHlHEbyQkJKLUtA2EEv0j1Y1+ifbyoa6LafuRublvwTf
 dsBBUXwE94xSNTsLSPTteD2CTGVg3b98HDEPlJBpQ5oPOXUHheLlKNGCIzm5FAoaH1dD
 w6Q1xf+4ngQsOK2DZMj2HCu6bl2anmuL+/iISI7Ts33wWONUuHxPWbU1mB79ncOAlBxV
 hoyyDj0+RlyfbRQIttVuPH+RETvxDIWDMEXC6wxGtwmVjRa0do87wEthGdBhXCF1MJUC
 Iqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z0LweSzTMeWl7kBbeDzTSWVJVjJb29j+OfSsLTkCIBs=;
 b=DZ6tQJ3Rx2wSTW/4eWy9v72IDCg6GQIk3BKQW+GQGM/53AtthyI+SwP+5Jy8H5CvLI
 J5cFPL4I/zS/e09pdbGRYO3MFt1vr8aEjsBx8FkfNMKrzDxly4b1XmaYBsYdb9aylcgE
 p9++aCowjKdoJO71p4T403oMeMMABVecpjh/pcstZRbFzQK9OApuGYnj/Mv/D9HcxfEA
 bIW5dmkp9T0CvKi2HnFQB8DHUj9+SM9XuCY8PKYrw9rZ8OhLy+JRorC23TEp3c1V3AHo
 NcyIq57CY5TUgxYo6q/5YFxPpkNCd2dVK98o5IYCDx9Snb4ZyK1zSw0a9V50ur4v4sEh
 si/A==
X-Gm-Message-State: AOAM5332q2k+kEKNXd9MDYxFn4uJWCXUgqj1qDh27t6KMV18zLjl1bGj
 ZJK0eTy7EyQoxdvpIZSHufz6+w==
X-Google-Smtp-Source: ABdhPJyJ5SrSdRunFIzuWWrOJ3mT9o8qmwnFv7k7JCEqPZe5GhwyKA0exWEZyP9MPkkQ0rSb1fOzOw==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr6107253wrl.250.1598279381215; 
 Mon, 24 Aug 2020 07:29:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b14sm24499091wrj.93.2020.08.24.07.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 07:29:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/22] target/arm: Implement VFP fp16 VMLA, VMLS, VNMLS, VNMLA,
 VNMUL
Date: Mon, 24 Aug 2020 15:29:16 +0100
Message-Id: <20200824142934.20850-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824142934.20850-1-peter.maydell@linaro.org>
References: <20200824142934.20850-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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

Implement fp16 versions of the VFP VMLA, VMLS, VNMLS, VNMLA, VNMUL
instructions. (These are all the remaining ones which we implement
via do_vfp_3op_[hsd]p().)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |  1 +
 target/arm/vfp.decode          |  5 ++
 target/arm/vfp_helper.c        |  5 ++
 target/arm/translate-vfp.c.inc | 84 ++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 2c0c89a34b6..662076d54a6 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -125,6 +125,7 @@ DEF_HELPER_3(vfp_maxnumd, f64, f64, f64, ptr)
 DEF_HELPER_3(vfp_minnumh, f32, f32, f32, ptr)
 DEF_HELPER_3(vfp_minnums, f32, f32, f32, ptr)
 DEF_HELPER_3(vfp_minnumd, f64, f64, f64, ptr)
+DEF_HELPER_1(vfp_negh, f32, f32)
 DEF_HELPER_1(vfp_negs, f32, f32)
 DEF_HELPER_1(vfp_negd, f64, f64)
 DEF_HELPER_1(vfp_abss, f32, f32)
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 1ecd5e28ca0..e5545076a51 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -103,15 +103,19 @@ VLDM_VSTM_dp ---- 1101 0.1 l:1 rn:4 .... 1011 imm:8 \
              vd=%vd_dp p=1 u=0 w=1
 
 # 3-register VFP data-processing; bits [23,21:20,6] identify the operation.
+VMLA_hp      ---- 1110 0.00 .... .... 1001 .0.0 ....        @vfp_dnm_s
 VMLA_sp      ---- 1110 0.00 .... .... 1010 .0.0 ....        @vfp_dnm_s
 VMLA_dp      ---- 1110 0.00 .... .... 1011 .0.0 ....        @vfp_dnm_d
 
+VMLS_hp      ---- 1110 0.00 .... .... 1001 .1.0 ....        @vfp_dnm_s
 VMLS_sp      ---- 1110 0.00 .... .... 1010 .1.0 ....        @vfp_dnm_s
 VMLS_dp      ---- 1110 0.00 .... .... 1011 .1.0 ....        @vfp_dnm_d
 
+VNMLS_hp     ---- 1110 0.01 .... .... 1001 .0.0 ....        @vfp_dnm_s
 VNMLS_sp     ---- 1110 0.01 .... .... 1010 .0.0 ....        @vfp_dnm_s
 VNMLS_dp     ---- 1110 0.01 .... .... 1011 .0.0 ....        @vfp_dnm_d
 
+VNMLA_hp     ---- 1110 0.01 .... .... 1001 .1.0 ....        @vfp_dnm_s
 VNMLA_sp     ---- 1110 0.01 .... .... 1010 .1.0 ....        @vfp_dnm_s
 VNMLA_dp     ---- 1110 0.01 .... .... 1011 .1.0 ....        @vfp_dnm_d
 
@@ -119,6 +123,7 @@ VMUL_hp      ---- 1110 0.10 .... .... 1001 .0.0 ....        @vfp_dnm_s
 VMUL_sp      ---- 1110 0.10 .... .... 1010 .0.0 ....        @vfp_dnm_s
 VMUL_dp      ---- 1110 0.10 .... .... 1011 .0.0 ....        @vfp_dnm_d
 
+VNMUL_hp     ---- 1110 0.10 .... .... 1001 .1.0 ....        @vfp_dnm_s
 VNMUL_sp     ---- 1110 0.10 .... .... 1010 .1.0 ....        @vfp_dnm_s
 VNMUL_dp     ---- 1110 0.10 .... .... 1011 .1.0 ....        @vfp_dnm_d
 
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 38473315996..410f0216db0 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -261,6 +261,11 @@ VFP_BINOP(minnum)
 VFP_BINOP(maxnum)
 #undef VFP_BINOP
 
+float32 VFP_HELPER(neg, h)(float32 a)
+{
+    return float16_chs(a);
+}
+
 float32 VFP_HELPER(neg, s)(float32 a)
 {
     return float32_chs(a);
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 01a5fd65115..15bb23688bd 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -1547,6 +1547,21 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
     return true;
 }
 
+static void gen_VMLA_hp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
+{
+    /* Note that order of inputs to the add matters for NaNs */
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    gen_helper_vfp_mulh(tmp, vn, vm, fpst);
+    gen_helper_vfp_addh(vd, vd, tmp, fpst);
+    tcg_temp_free_i32(tmp);
+}
+
+static bool trans_VMLA_hp(DisasContext *s, arg_VMLA_sp *a)
+{
+    return do_vfp_3op_hp(s, gen_VMLA_hp, a->vd, a->vn, a->vm, true);
+}
+
 static void gen_VMLA_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
 {
     /* Note that order of inputs to the add matters for NaNs */
@@ -1577,6 +1592,25 @@ static bool trans_VMLA_dp(DisasContext *s, arg_VMLA_dp *a)
     return do_vfp_3op_dp(s, gen_VMLA_dp, a->vd, a->vn, a->vm, true);
 }
 
+static void gen_VMLS_hp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
+{
+    /*
+     * VMLS: vd = vd + -(vn * vm)
+     * Note that order of inputs to the add matters for NaNs.
+     */
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    gen_helper_vfp_mulh(tmp, vn, vm, fpst);
+    gen_helper_vfp_negh(tmp, tmp);
+    gen_helper_vfp_addh(vd, vd, tmp, fpst);
+    tcg_temp_free_i32(tmp);
+}
+
+static bool trans_VMLS_hp(DisasContext *s, arg_VMLS_sp *a)
+{
+    return do_vfp_3op_hp(s, gen_VMLS_hp, a->vd, a->vn, a->vm, true);
+}
+
 static void gen_VMLS_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
 {
     /*
@@ -1615,6 +1649,27 @@ static bool trans_VMLS_dp(DisasContext *s, arg_VMLS_dp *a)
     return do_vfp_3op_dp(s, gen_VMLS_dp, a->vd, a->vn, a->vm, true);
 }
 
+static void gen_VNMLS_hp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
+{
+    /*
+     * VNMLS: -fd + (fn * fm)
+     * Note that it isn't valid to replace (-A + B) with (B - A) or similar
+     * plausible looking simplifications because this will give wrong results
+     * for NaNs.
+     */
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    gen_helper_vfp_mulh(tmp, vn, vm, fpst);
+    gen_helper_vfp_negh(vd, vd);
+    gen_helper_vfp_addh(vd, vd, tmp, fpst);
+    tcg_temp_free_i32(tmp);
+}
+
+static bool trans_VNMLS_hp(DisasContext *s, arg_VNMLS_sp *a)
+{
+    return do_vfp_3op_hp(s, gen_VNMLS_hp, a->vd, a->vn, a->vm, true);
+}
+
 static void gen_VNMLS_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
 {
     /*
@@ -1657,6 +1712,23 @@ static bool trans_VNMLS_dp(DisasContext *s, arg_VNMLS_dp *a)
     return do_vfp_3op_dp(s, gen_VNMLS_dp, a->vd, a->vn, a->vm, true);
 }
 
+static void gen_VNMLA_hp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
+{
+    /* VNMLA: -fd + -(fn * fm) */
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    gen_helper_vfp_mulh(tmp, vn, vm, fpst);
+    gen_helper_vfp_negh(tmp, tmp);
+    gen_helper_vfp_negh(vd, vd);
+    gen_helper_vfp_addh(vd, vd, tmp, fpst);
+    tcg_temp_free_i32(tmp);
+}
+
+static bool trans_VNMLA_hp(DisasContext *s, arg_VNMLA_sp *a)
+{
+    return do_vfp_3op_hp(s, gen_VNMLA_hp, a->vd, a->vn, a->vm, true);
+}
+
 static void gen_VNMLA_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
 {
     /* VNMLA: -fd + -(fn * fm) */
@@ -1706,6 +1778,18 @@ static bool trans_VMUL_dp(DisasContext *s, arg_VMUL_dp *a)
     return do_vfp_3op_dp(s, gen_helper_vfp_muld, a->vd, a->vn, a->vm, false);
 }
 
+static void gen_VNMUL_hp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
+{
+    /* VNMUL: -(fn * fm) */
+    gen_helper_vfp_mulh(vd, vn, vm, fpst);
+    gen_helper_vfp_negh(vd, vd);
+}
+
+static bool trans_VNMUL_hp(DisasContext *s, arg_VNMUL_sp *a)
+{
+    return do_vfp_3op_hp(s, gen_VNMUL_hp, a->vd, a->vn, a->vm, false);
+}
+
 static void gen_VNMUL_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
 {
     /* VNMUL: -(fn * fm) */
-- 
2.20.1


