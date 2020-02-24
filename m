Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1805CC38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C275921744
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RESOnh7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C275921744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MB4-0002b8-Vf
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7h-0004FX-QY
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7g-0005q7-2O
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:45 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7f-0005pV-Qw
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:44 -0500
Received: by mail-pg1-x543.google.com with SMTP id j4so5853440pgi.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=04w4nAykREQYlFaDlCPkF+ClHIRvIg4T3qLIcZORCLQ=;
 b=RESOnh7ZVqABL9e9EkhNypENrNTmIKFmCDKjHRkcvufJlnIaC9RFyKDoEJFf1Smggp
 ZHSp1nb9lEGqnGBLq73Y9irDfXnuXHdtMPad+XEFGkD4utjPp3p+Co1jO5R37pkxmhmY
 1n2d2LjG7T/OGZA9V2uOoy6YC/RJLnH1kbxK8dU9UtV4rSsyANp6vNN4oEW64CdttH07
 MyIZwJbXfwT0pMB1M+uOd5dUVgFelzZBvOAMkyk7+bk0pSHvDbHE7y0lW3Gf7O7F2cbi
 MEGUhJT+kUlf0pCrO6X4bLOegZ+tHoUoO0424X1zVf7iqMrrEMvhhckceleTAZmOItfS
 ZFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=04w4nAykREQYlFaDlCPkF+ClHIRvIg4T3qLIcZORCLQ=;
 b=Uwj/q6BQPRIEttvUzaJgPSvn193ULyVgtN2itYuTY9/7FeXfzwr77zzQb5UPBNdXao
 yBsumYCi3pN6TCf3HOlvekR9gOZXjntdaE0RQ9xeLcXUxbVzuf6tE/v449ZYQwWn0gb1
 OBwE8NUg16GqpTFgHMCDANriqwGFPL5vS7goNdr8tH/toEK7oYXRTt6hcXjg6zftRyn/
 qQEP5ERYE/ZUt9bQh8UC3zMCI4qJqjSzonZHkC5KJ+oYBXMFIuua6Ao2XbeWRwlXjthG
 c40e3rwBzSlMXbG9jVRVxHLMvnQBt0SMSMAUuUu3pHfJPdp87zaKP2tPChFqIFwqP7ch
 DzdQ==
X-Gm-Message-State: APjAAAVAYTzlDprM9c/dtm/t3Q7K7Ga8MewrJ4DBLan7irqLWHM5WQtG
 usVbj7da6Mo0y+jzrcsRov4RnCYPR2U=
X-Google-Smtp-Source: APXvYqxKy6234epOsW9E8YZ1XRGBdazrx2Qb1QMsg5KAAe/ZZ+zEX7myG2O9gp0PyO+Sulp0peJMWQ==
X-Received: by 2002:a65:65c8:: with SMTP id y8mr25943548pgv.36.1582582962103; 
 Mon, 24 Feb 2020 14:22:42 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/17] target/arm: Perform fpdp_v2 check first
Date: Mon, 24 Feb 2020 14:22:21 -0800
Message-Id: <20200224222232.13807-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Shuffle the order of the checks so that we test the ISA
before we test anything else, such as the register arguments.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 140 +++++++++++++++++----------------
 1 file changed, 71 insertions(+), 69 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index e94876c30c..ff30165045 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -200,13 +200,13 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
         return false;
     }
 
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vm | a->vn | a->vd) & 0x10)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vm | a->vn | a->vd) & 0x10)) {
         return false;
     }
 
@@ -333,13 +333,13 @@ static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
         return false;
     }
 
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vm | a->vn | a->vd) & 0x10)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vm | a->vn | a->vd) & 0x10)) {
         return false;
     }
 
@@ -419,13 +419,13 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         return false;
     }
 
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vm | a->vd) & 0x10)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vm | a->vd) & 0x10)) {
         return false;
     }
 
@@ -483,12 +483,12 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
         return false;
     }
 
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -1308,12 +1308,12 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
     TCGv_i64 f0, f1, fd;
     TCGv_ptr fpst;
 
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vn | vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vn | vm) & 0x10)) {
         return false;
     }
 
@@ -1457,12 +1457,12 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
     int veclen = s->vec_len;
     TCGv_i64 f0, fd;
 
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vm) & 0x10)) {
         return false;
     }
 
@@ -1827,7 +1827,9 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
         return false;
     }
 
@@ -1921,12 +1923,12 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
 
     vd = a->vd;
 
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (vd & 0x10)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (vd & 0x10)) {
         return false;
     }
 
@@ -2060,6 +2062,10 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
 {
     TCGv_i64 vd, vm;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     /* Vm/M bits must be zero for the Z variant */
     if (a->z && a->vm != 0) {
         return false;
@@ -2070,10 +2076,6 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2134,6 +2136,10 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
     TCGv_i32 tmp;
     TCGv_i64 vd;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fp16_dpconv, s)) {
         return false;
     }
@@ -2143,10 +2149,6 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2200,6 +2202,10 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
     TCGv_i32 tmp;
     TCGv_i64 vm;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fp16_dpconv, s)) {
         return false;
     }
@@ -2209,10 +2215,6 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2260,6 +2262,10 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
     TCGv_ptr fpst;
     TCGv_i64 tmp;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_vrint, s)) {
         return false;
     }
@@ -2269,10 +2275,6 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2321,6 +2323,10 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
     TCGv_i64 tmp;
     TCGv_i32 tcg_rmode;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_vrint, s)) {
         return false;
     }
@@ -2330,10 +2336,6 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2380,6 +2382,10 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
     TCGv_ptr fpst;
     TCGv_i64 tmp;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_vrint, s)) {
         return false;
     }
@@ -2389,10 +2395,6 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2412,12 +2414,12 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
     TCGv_i64 vd;
     TCGv_i32 vm;
 
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
         return false;
     }
 
@@ -2440,12 +2442,12 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
     TCGv_i64 vm;
     TCGv_i32 vd;
 
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -2494,12 +2496,12 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
     TCGv_i64 vd;
     TCGv_ptr fpst;
 
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
         return false;
     }
 
@@ -2530,6 +2532,10 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
     TCGv_i32 vd;
     TCGv_i64 vm;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_jscvt, s)) {
         return false;
     }
@@ -2539,10 +2545,6 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2623,6 +2625,10 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     TCGv_ptr fpst;
     int frac_bits;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
         return false;
     }
@@ -2632,10 +2638,6 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2723,12 +2725,12 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
     TCGv_i64 vm;
     TCGv_ptr fpst;
 
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
-- 
2.20.1


