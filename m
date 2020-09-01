Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602E3C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 284FE2100A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8XL5FIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284FE2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD881-0000Wn-9r
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83P-0007RM-FM
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:39306)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83N-0006AE-42
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:35 -0400
Received: by mail-wm1-x32f.google.com with SMTP id b79so1544762wmb.4
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=NRCYxYD6Ps/2crTCSF14qpUjfZ9wd/skTMJbgHl2LUk=;
 b=B8XL5FIKH1R/3CMUEpI+cbqFpSVPIkCIc7zO32R+hn/xWaVlY9cZ6vLFTojBve1rmL
 ycIft6CznRlLPlqtJIlmt/cEua7XyKWfepdA+0XbpOlUUGFIxWifT56/TqsMtKZ6favw
 T1MY7YTz/hjkXKw2dQlfusPRgA3IcuW/13nuta+ABqBwDSSDStcFabZak800hnE1tXD/
 E3+fb23XVmD7oX3n4Mf8UJL8gvwUnSZ3Qi25Wk6yHzVdAV8CaPRjyWdZUX5SecSaMUH0
 dmc47JqSag6fRnn0jdP7AOcwu0usNr1c+fivEGi5ShgadV8ERuhSJID3SCho/SuLBK9q
 pb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NRCYxYD6Ps/2crTCSF14qpUjfZ9wd/skTMJbgHl2LUk=;
 b=CGukIKKyEn1YARzSMCt8buHAfG5T4tUCfIkCqJJRXbBpSryfSBN5+Td9PM9APTUR8e
 noLpEG52U0S9IX22ffFu/NQ+8WUo0GCTH754HlbdRf20ezbX08DM7KK4p+BQ9qxaUbMD
 VkRuUc8xHN1DsMAqTZDzZ4FjnAcyAsKNw8p+PEp5guTYcHve+F2svR081DB3nIfd8BBN
 v+XmogMJg+Rhd5tqJ5Wko82btUccAGsDq80oXPqGWl30bwMZnPCBIZrjGDEs8OoF01ci
 ZNjizQTXmzTx/hSb6CzNXR5iXDLVCN66zgRUtN/7YKO8OIeWYZ+Z9vpMk+r9mypvE5nU
 mfXw==
X-Gm-Message-State: AOAM530Xk+4GKKzlkaQZfKa8KKFu7gVhRyP9Qugh9J0EvrOD5OSo+Ydl
 u441hZ7LuQB64Zn61pfL7CmCvOgdb7vA6ZVj
X-Google-Smtp-Source: ABdhPJwfhlsTsE2j2O9zljvTQptzuP0HbePYiLsu6yumtXXlBUjrnBCCUWXsv1TMFFJlPvncejhYZQ==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr2289934wmh.20.1598973511090;
 Tue, 01 Sep 2020 08:18:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/47] target/arm: Implement VFP fp16 VMLA, VMLS, VNMLS, VNMLA,
 VNMUL
Date: Tue,  1 Sep 2020 16:17:40 +0100
Message-Id: <20200901151823.29785-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-5-peter.maydell@linaro.org
---
 target/arm/helper.h            |  1 +
 target/arm/vfp.decode          |  5 ++
 target/arm/vfp_helper.c        |  5 ++
 target/arm/translate-vfp.c.inc | 84 ++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 61e4e938861..58f9c4e933e 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -125,6 +125,7 @@ DEF_HELPER_3(vfp_maxnumd, f64, f64, f64, ptr)
 DEF_HELPER_3(vfp_minnumh, f16, f16, f16, ptr)
 DEF_HELPER_3(vfp_minnums, f32, f32, f32, ptr)
 DEF_HELPER_3(vfp_minnumd, f64, f64, f64, ptr)
+DEF_HELPER_1(vfp_negh, f16, f16)
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
index b8ca744bccc..f93ddf0b208 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -261,6 +261,11 @@ VFP_BINOP(minnum)
 VFP_BINOP(maxnum)
 #undef VFP_BINOP
 
+dh_ctype_f16 VFP_HELPER(neg, h)(dh_ctype_f16 a)
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


