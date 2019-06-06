Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40C2C28EB3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D54D2083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zj0gt/M5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D54D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36018 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwcB-0003XZ-Ko
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:55:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU2-0004OC-He
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTx-0003tE-38
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:25 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwTt-0002uF-HF
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:18 -0400
Received: by mail-wm1-x343.google.com with SMTP id f10so812302wmb.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=UGVcH6sTteiHDcjJBr1jYE8bG2UG4UEyZfFmVaer4Is=;
	b=zj0gt/M5Yh8lPRCCaoEmD4iNVjGV5/YDdjOuUO0kytFgfZo2sH/VlFV028cXWaLz/k
	lecknrakCfEPBQPeT09BXaA+XSpnaJxCyy8dJTVnkVIasjUP8lzdF3wK6RAwbEh+2Evv
	qIjt8PF+gecKg9sg7DZSAOnSP4B85LyJxGyD57InQk4fUkwlTfse6pCcIOd9lDt1I1Jl
	gcDEUboB5f/IMKkE3zv09eRPKYXt4Cem8CfiGJ//iuHnBUKlTghIrjilpYriOGFAVAtk
	PrKXLzRTlG3AEA/duvs1S7k4F5q/3mCj+HzkltUO8ldUMm/qxPGxwyHxGo4t/CIoiHk9
	zFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=UGVcH6sTteiHDcjJBr1jYE8bG2UG4UEyZfFmVaer4Is=;
	b=mFb9GcTLQ99UMmjfc7Qmpxnms77cWmt4N2kx02juwCLmhdTUeqBC4GrL4+zUDbTqV0
	U8k3OvdbD0YDNjNTg2f3Xo+MgF+FuTaaZpIlNzN2s8VvRTZvK4KBN2DE4mtMUgLIYsNQ
	P2OlV56Ri2Qt4N11VkC4uh/UWDclB5P+fbLNQWUoelxxHFwNIO+vXbXgtiY/x+xgPHx7
	iRC+TY41PoHngv8iq/MLIJsCbJOy0ShICAGvU8z6wl+ST72z2XcqdNmp/NRnSW707d0L
	jqXW1gAQJBbgAlsq0ZzrzgO94EX7OsRKbExp3rlk/rQ20Yx5xuQbyiZwjUmgQwKqVeW9
	GTyA==
X-Gm-Message-State: APjAAAXPTifnSmhGf05i2/FwvVZE8mirPRHkr85ielA3FvWJYpU6emB5
	n2NyA6f8c3bnWT/LRdRGRu9QNQ==
X-Google-Smtp-Source: APXvYqxb3ZWmgxh2KbJMWlxiaC1sbYF85AK3xtV5HyeCNC1jsd0lzGm9oqWtfw/Jxv1qR8gEhQq/Tg==
X-Received: by 2002:a1c:b4d4:: with SMTP id d203mr905782wmf.34.1559843182806; 
	Thu, 06 Jun 2019 10:46:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:37 +0100
Message-Id: <20190606174609.20487-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 10/42] target/arm: Move the VFP trans_*
 functions to translate-vfp.inc.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the trans_*() functions we've just created from translate.c
to translate-vfp.inc.c. This is pure code motion with no textual
changes (this can be checked with 'git show --color-moved').

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 337 +++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 337 ---------------------------------
 2 files changed, 337 insertions(+), 337 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index f7535138d0f..2f070a6e0d9 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -138,3 +138,340 @@ static bool vfp_access_check(DisasContext *s)
 {
     return full_vfp_access_check(s, false);
 }
+
+static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
+{
+    uint32_t rd, rn, rm;
+    bool dp = a->dp;
+
+    if (!dc_isar_feature(aa32_vsel, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
+        ((a->vm | a->vn | a->vd) & 0x10)) {
+        return false;
+    }
+    rd = a->vd;
+    rn = a->vn;
+    rm = a->vm;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (dp) {
+        TCGv_i64 frn, frm, dest;
+        TCGv_i64 tmp, zero, zf, nf, vf;
+
+        zero = tcg_const_i64(0);
+
+        frn = tcg_temp_new_i64();
+        frm = tcg_temp_new_i64();
+        dest = tcg_temp_new_i64();
+
+        zf = tcg_temp_new_i64();
+        nf = tcg_temp_new_i64();
+        vf = tcg_temp_new_i64();
+
+        tcg_gen_extu_i32_i64(zf, cpu_ZF);
+        tcg_gen_ext_i32_i64(nf, cpu_NF);
+        tcg_gen_ext_i32_i64(vf, cpu_VF);
+
+        tcg_gen_ld_f64(frn, cpu_env, vfp_reg_offset(dp, rn));
+        tcg_gen_ld_f64(frm, cpu_env, vfp_reg_offset(dp, rm));
+        switch (a->cc) {
+        case 0: /* eq: Z */
+            tcg_gen_movcond_i64(TCG_COND_EQ, dest, zf, zero,
+                                frn, frm);
+            break;
+        case 1: /* vs: V */
+            tcg_gen_movcond_i64(TCG_COND_LT, dest, vf, zero,
+                                frn, frm);
+            break;
+        case 2: /* ge: N == V -> N ^ V == 0 */
+            tmp = tcg_temp_new_i64();
+            tcg_gen_xor_i64(tmp, vf, nf);
+            tcg_gen_movcond_i64(TCG_COND_GE, dest, tmp, zero,
+                                frn, frm);
+            tcg_temp_free_i64(tmp);
+            break;
+        case 3: /* gt: !Z && N == V */
+            tcg_gen_movcond_i64(TCG_COND_NE, dest, zf, zero,
+                                frn, frm);
+            tmp = tcg_temp_new_i64();
+            tcg_gen_xor_i64(tmp, vf, nf);
+            tcg_gen_movcond_i64(TCG_COND_GE, dest, tmp, zero,
+                                dest, frm);
+            tcg_temp_free_i64(tmp);
+            break;
+        }
+        tcg_gen_st_f64(dest, cpu_env, vfp_reg_offset(dp, rd));
+        tcg_temp_free_i64(frn);
+        tcg_temp_free_i64(frm);
+        tcg_temp_free_i64(dest);
+
+        tcg_temp_free_i64(zf);
+        tcg_temp_free_i64(nf);
+        tcg_temp_free_i64(vf);
+
+        tcg_temp_free_i64(zero);
+    } else {
+        TCGv_i32 frn, frm, dest;
+        TCGv_i32 tmp, zero;
+
+        zero = tcg_const_i32(0);
+
+        frn = tcg_temp_new_i32();
+        frm = tcg_temp_new_i32();
+        dest = tcg_temp_new_i32();
+        tcg_gen_ld_f32(frn, cpu_env, vfp_reg_offset(dp, rn));
+        tcg_gen_ld_f32(frm, cpu_env, vfp_reg_offset(dp, rm));
+        switch (a->cc) {
+        case 0: /* eq: Z */
+            tcg_gen_movcond_i32(TCG_COND_EQ, dest, cpu_ZF, zero,
+                                frn, frm);
+            break;
+        case 1: /* vs: V */
+            tcg_gen_movcond_i32(TCG_COND_LT, dest, cpu_VF, zero,
+                                frn, frm);
+            break;
+        case 2: /* ge: N == V -> N ^ V == 0 */
+            tmp = tcg_temp_new_i32();
+            tcg_gen_xor_i32(tmp, cpu_VF, cpu_NF);
+            tcg_gen_movcond_i32(TCG_COND_GE, dest, tmp, zero,
+                                frn, frm);
+            tcg_temp_free_i32(tmp);
+            break;
+        case 3: /* gt: !Z && N == V */
+            tcg_gen_movcond_i32(TCG_COND_NE, dest, cpu_ZF, zero,
+                                frn, frm);
+            tmp = tcg_temp_new_i32();
+            tcg_gen_xor_i32(tmp, cpu_VF, cpu_NF);
+            tcg_gen_movcond_i32(TCG_COND_GE, dest, tmp, zero,
+                                dest, frm);
+            tcg_temp_free_i32(tmp);
+            break;
+        }
+        tcg_gen_st_f32(dest, cpu_env, vfp_reg_offset(dp, rd));
+        tcg_temp_free_i32(frn);
+        tcg_temp_free_i32(frm);
+        tcg_temp_free_i32(dest);
+
+        tcg_temp_free_i32(zero);
+    }
+
+    return true;
+}
+
+static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
+{
+    uint32_t rd, rn, rm;
+    bool dp = a->dp;
+    bool vmin = a->op;
+    TCGv_ptr fpst;
+
+    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
+        ((a->vm | a->vn | a->vd) & 0x10)) {
+        return false;
+    }
+    rd = a->vd;
+    rn = a->vn;
+    rm = a->vm;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(0);
+
+    if (dp) {
+        TCGv_i64 frn, frm, dest;
+
+        frn = tcg_temp_new_i64();
+        frm = tcg_temp_new_i64();
+        dest = tcg_temp_new_i64();
+
+        tcg_gen_ld_f64(frn, cpu_env, vfp_reg_offset(dp, rn));
+        tcg_gen_ld_f64(frm, cpu_env, vfp_reg_offset(dp, rm));
+        if (vmin) {
+            gen_helper_vfp_minnumd(dest, frn, frm, fpst);
+        } else {
+            gen_helper_vfp_maxnumd(dest, frn, frm, fpst);
+        }
+        tcg_gen_st_f64(dest, cpu_env, vfp_reg_offset(dp, rd));
+        tcg_temp_free_i64(frn);
+        tcg_temp_free_i64(frm);
+        tcg_temp_free_i64(dest);
+    } else {
+        TCGv_i32 frn, frm, dest;
+
+        frn = tcg_temp_new_i32();
+        frm = tcg_temp_new_i32();
+        dest = tcg_temp_new_i32();
+
+        tcg_gen_ld_f32(frn, cpu_env, vfp_reg_offset(dp, rn));
+        tcg_gen_ld_f32(frm, cpu_env, vfp_reg_offset(dp, rm));
+        if (vmin) {
+            gen_helper_vfp_minnums(dest, frn, frm, fpst);
+        } else {
+            gen_helper_vfp_maxnums(dest, frn, frm, fpst);
+        }
+        tcg_gen_st_f32(dest, cpu_env, vfp_reg_offset(dp, rd));
+        tcg_temp_free_i32(frn);
+        tcg_temp_free_i32(frm);
+        tcg_temp_free_i32(dest);
+    }
+
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
+
+/*
+ * Table for converting the most common AArch32 encoding of
+ * rounding mode to arm_fprounding order (which matches the
+ * common AArch64 order); see ARM ARM pseudocode FPDecodeRM().
+ */
+static const uint8_t fp_decode_rm[] = {
+    FPROUNDING_TIEAWAY,
+    FPROUNDING_TIEEVEN,
+    FPROUNDING_POSINF,
+    FPROUNDING_NEGINF,
+};
+
+static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
+{
+    uint32_t rd, rm;
+    bool dp = a->dp;
+    TCGv_ptr fpst;
+    TCGv_i32 tcg_rmode;
+    int rounding = fp_decode_rm[a->rm];
+
+    if (!dc_isar_feature(aa32_vrint, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
+        ((a->vm | a->vd) & 0x10)) {
+        return false;
+    }
+    rd = a->vd;
+    rm = a->vm;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(0);
+
+    tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+
+    if (dp) {
+        TCGv_i64 tcg_op;
+        TCGv_i64 tcg_res;
+        tcg_op = tcg_temp_new_i64();
+        tcg_res = tcg_temp_new_i64();
+        tcg_gen_ld_f64(tcg_op, cpu_env, vfp_reg_offset(dp, rm));
+        gen_helper_rintd(tcg_res, tcg_op, fpst);
+        tcg_gen_st_f64(tcg_res, cpu_env, vfp_reg_offset(dp, rd));
+        tcg_temp_free_i64(tcg_op);
+        tcg_temp_free_i64(tcg_res);
+    } else {
+        TCGv_i32 tcg_op;
+        TCGv_i32 tcg_res;
+        tcg_op = tcg_temp_new_i32();
+        tcg_res = tcg_temp_new_i32();
+        tcg_gen_ld_f32(tcg_op, cpu_env, vfp_reg_offset(dp, rm));
+        gen_helper_rints(tcg_res, tcg_op, fpst);
+        tcg_gen_st_f32(tcg_res, cpu_env, vfp_reg_offset(dp, rd));
+        tcg_temp_free_i32(tcg_op);
+        tcg_temp_free_i32(tcg_res);
+    }
+
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+    tcg_temp_free_i32(tcg_rmode);
+
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
+
+static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
+{
+    uint32_t rd, rm;
+    bool dp = a->dp;
+    TCGv_ptr fpst;
+    TCGv_i32 tcg_rmode, tcg_shift;
+    int rounding = fp_decode_rm[a->rm];
+    bool is_signed = a->op;
+
+    if (!dc_isar_feature(aa32_vcvt_dr, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+        return false;
+    }
+    rd = a->vd;
+    rm = a->vm;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(0);
+
+    tcg_shift = tcg_const_i32(0);
+
+    tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+
+    if (dp) {
+        TCGv_i64 tcg_double, tcg_res;
+        TCGv_i32 tcg_tmp;
+        tcg_double = tcg_temp_new_i64();
+        tcg_res = tcg_temp_new_i64();
+        tcg_tmp = tcg_temp_new_i32();
+        tcg_gen_ld_f64(tcg_double, cpu_env, vfp_reg_offset(1, rm));
+        if (is_signed) {
+            gen_helper_vfp_tosld(tcg_res, tcg_double, tcg_shift, fpst);
+        } else {
+            gen_helper_vfp_tould(tcg_res, tcg_double, tcg_shift, fpst);
+        }
+        tcg_gen_extrl_i64_i32(tcg_tmp, tcg_res);
+        tcg_gen_st_f32(tcg_tmp, cpu_env, vfp_reg_offset(0, rd));
+        tcg_temp_free_i32(tcg_tmp);
+        tcg_temp_free_i64(tcg_res);
+        tcg_temp_free_i64(tcg_double);
+    } else {
+        TCGv_i32 tcg_single, tcg_res;
+        tcg_single = tcg_temp_new_i32();
+        tcg_res = tcg_temp_new_i32();
+        tcg_gen_ld_f32(tcg_single, cpu_env, vfp_reg_offset(0, rm));
+        if (is_signed) {
+            gen_helper_vfp_tosls(tcg_res, tcg_single, tcg_shift, fpst);
+        } else {
+            gen_helper_vfp_touls(tcg_res, tcg_single, tcg_shift, fpst);
+        }
+        tcg_gen_st_f32(tcg_res, cpu_env, vfp_reg_offset(0, rd));
+        tcg_temp_free_i32(tcg_res);
+        tcg_temp_free_i32(tcg_single);
+    }
+
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+    tcg_temp_free_i32(tcg_rmode);
+
+    tcg_temp_free_i32(tcg_shift);
+
+    tcg_temp_free_ptr(fpst);
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2cf8fd99404..dc22b2aa7ff 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3076,343 +3076,6 @@ static void gen_neon_dup_high16(TCGv_i32 var)
     tcg_temp_free_i32(tmp);
 }
 
-static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
-{
-    uint32_t rd, rn, rm;
-    bool dp = a->dp;
-
-    if (!dc_isar_feature(aa32_vsel, s)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
-        ((a->vm | a->vn | a->vd) & 0x10)) {
-        return false;
-    }
-    rd = a->vd;
-    rn = a->vn;
-    rm = a->vm;
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    if (dp) {
-        TCGv_i64 frn, frm, dest;
-        TCGv_i64 tmp, zero, zf, nf, vf;
-
-        zero = tcg_const_i64(0);
-
-        frn = tcg_temp_new_i64();
-        frm = tcg_temp_new_i64();
-        dest = tcg_temp_new_i64();
-
-        zf = tcg_temp_new_i64();
-        nf = tcg_temp_new_i64();
-        vf = tcg_temp_new_i64();
-
-        tcg_gen_extu_i32_i64(zf, cpu_ZF);
-        tcg_gen_ext_i32_i64(nf, cpu_NF);
-        tcg_gen_ext_i32_i64(vf, cpu_VF);
-
-        tcg_gen_ld_f64(frn, cpu_env, vfp_reg_offset(dp, rn));
-        tcg_gen_ld_f64(frm, cpu_env, vfp_reg_offset(dp, rm));
-        switch (a->cc) {
-        case 0: /* eq: Z */
-            tcg_gen_movcond_i64(TCG_COND_EQ, dest, zf, zero,
-                                frn, frm);
-            break;
-        case 1: /* vs: V */
-            tcg_gen_movcond_i64(TCG_COND_LT, dest, vf, zero,
-                                frn, frm);
-            break;
-        case 2: /* ge: N == V -> N ^ V == 0 */
-            tmp = tcg_temp_new_i64();
-            tcg_gen_xor_i64(tmp, vf, nf);
-            tcg_gen_movcond_i64(TCG_COND_GE, dest, tmp, zero,
-                                frn, frm);
-            tcg_temp_free_i64(tmp);
-            break;
-        case 3: /* gt: !Z && N == V */
-            tcg_gen_movcond_i64(TCG_COND_NE, dest, zf, zero,
-                                frn, frm);
-            tmp = tcg_temp_new_i64();
-            tcg_gen_xor_i64(tmp, vf, nf);
-            tcg_gen_movcond_i64(TCG_COND_GE, dest, tmp, zero,
-                                dest, frm);
-            tcg_temp_free_i64(tmp);
-            break;
-        }
-        tcg_gen_st_f64(dest, cpu_env, vfp_reg_offset(dp, rd));
-        tcg_temp_free_i64(frn);
-        tcg_temp_free_i64(frm);
-        tcg_temp_free_i64(dest);
-
-        tcg_temp_free_i64(zf);
-        tcg_temp_free_i64(nf);
-        tcg_temp_free_i64(vf);
-
-        tcg_temp_free_i64(zero);
-    } else {
-        TCGv_i32 frn, frm, dest;
-        TCGv_i32 tmp, zero;
-
-        zero = tcg_const_i32(0);
-
-        frn = tcg_temp_new_i32();
-        frm = tcg_temp_new_i32();
-        dest = tcg_temp_new_i32();
-        tcg_gen_ld_f32(frn, cpu_env, vfp_reg_offset(dp, rn));
-        tcg_gen_ld_f32(frm, cpu_env, vfp_reg_offset(dp, rm));
-        switch (a->cc) {
-        case 0: /* eq: Z */
-            tcg_gen_movcond_i32(TCG_COND_EQ, dest, cpu_ZF, zero,
-                                frn, frm);
-            break;
-        case 1: /* vs: V */
-            tcg_gen_movcond_i32(TCG_COND_LT, dest, cpu_VF, zero,
-                                frn, frm);
-            break;
-        case 2: /* ge: N == V -> N ^ V == 0 */
-            tmp = tcg_temp_new_i32();
-            tcg_gen_xor_i32(tmp, cpu_VF, cpu_NF);
-            tcg_gen_movcond_i32(TCG_COND_GE, dest, tmp, zero,
-                                frn, frm);
-            tcg_temp_free_i32(tmp);
-            break;
-        case 3: /* gt: !Z && N == V */
-            tcg_gen_movcond_i32(TCG_COND_NE, dest, cpu_ZF, zero,
-                                frn, frm);
-            tmp = tcg_temp_new_i32();
-            tcg_gen_xor_i32(tmp, cpu_VF, cpu_NF);
-            tcg_gen_movcond_i32(TCG_COND_GE, dest, tmp, zero,
-                                dest, frm);
-            tcg_temp_free_i32(tmp);
-            break;
-        }
-        tcg_gen_st_f32(dest, cpu_env, vfp_reg_offset(dp, rd));
-        tcg_temp_free_i32(frn);
-        tcg_temp_free_i32(frm);
-        tcg_temp_free_i32(dest);
-
-        tcg_temp_free_i32(zero);
-    }
-
-    return true;
-}
-
-static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
-{
-    uint32_t rd, rn, rm;
-    bool dp = a->dp;
-    bool vmin = a->op;
-    TCGv_ptr fpst;
-
-    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
-        ((a->vm | a->vn | a->vd) & 0x10)) {
-        return false;
-    }
-    rd = a->vd;
-    rn = a->vn;
-    rm = a->vm;
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    fpst = get_fpstatus_ptr(0);
-
-    if (dp) {
-        TCGv_i64 frn, frm, dest;
-
-        frn = tcg_temp_new_i64();
-        frm = tcg_temp_new_i64();
-        dest = tcg_temp_new_i64();
-
-        tcg_gen_ld_f64(frn, cpu_env, vfp_reg_offset(dp, rn));
-        tcg_gen_ld_f64(frm, cpu_env, vfp_reg_offset(dp, rm));
-        if (vmin) {
-            gen_helper_vfp_minnumd(dest, frn, frm, fpst);
-        } else {
-            gen_helper_vfp_maxnumd(dest, frn, frm, fpst);
-        }
-        tcg_gen_st_f64(dest, cpu_env, vfp_reg_offset(dp, rd));
-        tcg_temp_free_i64(frn);
-        tcg_temp_free_i64(frm);
-        tcg_temp_free_i64(dest);
-    } else {
-        TCGv_i32 frn, frm, dest;
-
-        frn = tcg_temp_new_i32();
-        frm = tcg_temp_new_i32();
-        dest = tcg_temp_new_i32();
-
-        tcg_gen_ld_f32(frn, cpu_env, vfp_reg_offset(dp, rn));
-        tcg_gen_ld_f32(frm, cpu_env, vfp_reg_offset(dp, rm));
-        if (vmin) {
-            gen_helper_vfp_minnums(dest, frn, frm, fpst);
-        } else {
-            gen_helper_vfp_maxnums(dest, frn, frm, fpst);
-        }
-        tcg_gen_st_f32(dest, cpu_env, vfp_reg_offset(dp, rd));
-        tcg_temp_free_i32(frn);
-        tcg_temp_free_i32(frm);
-        tcg_temp_free_i32(dest);
-    }
-
-    tcg_temp_free_ptr(fpst);
-    return true;
-}
-
-/*
- * Table for converting the most common AArch32 encoding of
- * rounding mode to arm_fprounding order (which matches the
- * common AArch64 order); see ARM ARM pseudocode FPDecodeRM().
- */
-static const uint8_t fp_decode_rm[] = {
-    FPROUNDING_TIEAWAY,
-    FPROUNDING_TIEEVEN,
-    FPROUNDING_POSINF,
-    FPROUNDING_NEGINF,
-};
-
-static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
-{
-    uint32_t rd, rm;
-    bool dp = a->dp;
-    TCGv_ptr fpst;
-    TCGv_i32 tcg_rmode;
-    int rounding = fp_decode_rm[a->rm];
-
-    if (!dc_isar_feature(aa32_vrint, s)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
-        ((a->vm | a->vd) & 0x10)) {
-        return false;
-    }
-    rd = a->vd;
-    rm = a->vm;
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    fpst = get_fpstatus_ptr(0);
-
-    tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-
-    if (dp) {
-        TCGv_i64 tcg_op;
-        TCGv_i64 tcg_res;
-        tcg_op = tcg_temp_new_i64();
-        tcg_res = tcg_temp_new_i64();
-        tcg_gen_ld_f64(tcg_op, cpu_env, vfp_reg_offset(dp, rm));
-        gen_helper_rintd(tcg_res, tcg_op, fpst);
-        tcg_gen_st_f64(tcg_res, cpu_env, vfp_reg_offset(dp, rd));
-        tcg_temp_free_i64(tcg_op);
-        tcg_temp_free_i64(tcg_res);
-    } else {
-        TCGv_i32 tcg_op;
-        TCGv_i32 tcg_res;
-        tcg_op = tcg_temp_new_i32();
-        tcg_res = tcg_temp_new_i32();
-        tcg_gen_ld_f32(tcg_op, cpu_env, vfp_reg_offset(dp, rm));
-        gen_helper_rints(tcg_res, tcg_op, fpst);
-        tcg_gen_st_f32(tcg_res, cpu_env, vfp_reg_offset(dp, rd));
-        tcg_temp_free_i32(tcg_op);
-        tcg_temp_free_i32(tcg_res);
-    }
-
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-    tcg_temp_free_i32(tcg_rmode);
-
-    tcg_temp_free_ptr(fpst);
-    return true;
-}
-
-static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
-{
-    uint32_t rd, rm;
-    bool dp = a->dp;
-    TCGv_ptr fpst;
-    TCGv_i32 tcg_rmode, tcg_shift;
-    int rounding = fp_decode_rm[a->rm];
-    bool is_signed = a->op;
-
-    if (!dc_isar_feature(aa32_vcvt_dr, s)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
-        return false;
-    }
-    rd = a->vd;
-    rm = a->vm;
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    fpst = get_fpstatus_ptr(0);
-
-    tcg_shift = tcg_const_i32(0);
-
-    tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-
-    if (dp) {
-        TCGv_i64 tcg_double, tcg_res;
-        TCGv_i32 tcg_tmp;
-        tcg_double = tcg_temp_new_i64();
-        tcg_res = tcg_temp_new_i64();
-        tcg_tmp = tcg_temp_new_i32();
-        tcg_gen_ld_f64(tcg_double, cpu_env, vfp_reg_offset(1, rm));
-        if (is_signed) {
-            gen_helper_vfp_tosld(tcg_res, tcg_double, tcg_shift, fpst);
-        } else {
-            gen_helper_vfp_tould(tcg_res, tcg_double, tcg_shift, fpst);
-        }
-        tcg_gen_extrl_i64_i32(tcg_tmp, tcg_res);
-        tcg_gen_st_f32(tcg_tmp, cpu_env, vfp_reg_offset(0, rd));
-        tcg_temp_free_i32(tcg_tmp);
-        tcg_temp_free_i64(tcg_res);
-        tcg_temp_free_i64(tcg_double);
-    } else {
-        TCGv_i32 tcg_single, tcg_res;
-        tcg_single = tcg_temp_new_i32();
-        tcg_res = tcg_temp_new_i32();
-        tcg_gen_ld_f32(tcg_single, cpu_env, vfp_reg_offset(0, rm));
-        if (is_signed) {
-            gen_helper_vfp_tosls(tcg_res, tcg_single, tcg_shift, fpst);
-        } else {
-            gen_helper_vfp_touls(tcg_res, tcg_single, tcg_shift, fpst);
-        }
-        tcg_gen_st_f32(tcg_res, cpu_env, vfp_reg_offset(0, rd));
-        tcg_temp_free_i32(tcg_res);
-        tcg_temp_free_i32(tcg_single);
-    }
-
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-    tcg_temp_free_i32(tcg_rmode);
-
-    tcg_temp_free_i32(tcg_shift);
-
-    tcg_temp_free_ptr(fpst);
-
-    return true;
-}
-
 /*
  * Disassemble a VFP instruction.  Returns nonzero if an error occurred
  * (ie. an undefined instruction).
-- 
2.20.1


