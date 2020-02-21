Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3E1C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919CD208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjrI6/hO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919CD208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58dT-0001Bo-Nl
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582x-0000Ea-MX
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582v-0004AO-RS
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:47 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34916)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582v-00047r-Ip
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:45 -0500
Received: by mail-wr1-x441.google.com with SMTP id w12so2012500wrt.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=o70TLclVtljlg7/9KQCzXuefdakLjZMqljQvUwUXHGo=;
 b=AjrI6/hOiCLrgWDC0YOwxOFtCJUKz1hirHOAoDmtRlgKG4fZgCyumiRuM5a2LlpWeU
 Z1JaOwQ5LCukfrOU4kWS8IwKEI8W23a3RbwUIfX1eFJD/2b2MSs7V40zrZs3vpcjno8o
 o66dKkeUh6Yl2MT88lSPOTj0h89ZDXUXoUFnDv9RzuGCpfVN8ro8TlAsm7yXh0CJ5mjI
 WCmbp6Y4js2Zn2D7OZTjyfDLCb5YwLdf78yAImBauAM/V1QK4i0trdkdX0w8SK6tMksC
 HxKkUHaEtZStTLt47qy6FlZW4HcJ158oAOFx/JM2CDFcr+EiTM7ryLanhMiDL4+sDjOb
 5c1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o70TLclVtljlg7/9KQCzXuefdakLjZMqljQvUwUXHGo=;
 b=X/Vg5Ria5TGRlWF55wcHEhDFX6WI6u0wVQhbLXMONPpPnntMqLwKSBz2xNoteBWplD
 ZdXG9r5B/Rp1UjLDOPiH16fSOKiFwnoOa8W+1UUU8N41dT+51I2lvLPB8mCZr3l+LCiy
 5Zovu2lOgjqtuPIhKj7cTHnNQdi7kCdnFmBI7LVo6DphWPw2z+IolQwlF2fIndC6hZHM
 2JFFnfO5YKruB/ursI8+rsbFCJcbl91MeDQ47kY2cAXQCtEKsskvcAjr7HKF2LzhNE7y
 YrHB9Nya1HWG3/uu/TKJyEeqCOZsBe741tnIGkncGeo2/1prjyhABm22THa/rHglwiDr
 sbcw==
X-Gm-Message-State: APjAAAWI5fSq9ql2Z1rySYwUpuMNOgWrJCfGXCBwvoBiwf9j96FbuKt/
 IwUwPT1zQJVvTDeIncPdAsn2fpOCFILamw==
X-Google-Smtp-Source: APXvYqw8wodvLyqB4cZq3gdysHWrq9iN0zmzOjQYry5i3GNHIYs79GZWVcIKCLWYH+VxZDdaj38HmQ==
X-Received: by 2002:a5d:560d:: with SMTP id l13mr22514211wrv.222.1582290524024; 
 Fri, 21 Feb 2020 05:08:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/52] target/arm: Perform fpdp_v2 check first
Date: Fri, 21 Feb 2020 13:07:38 +0000
Message-Id: <20200221130740.7583-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

From: Richard Henderson <richard.henderson@linaro.org>

Shuffle the order of the checks so that we test the ISA
before we test anything else, such as the register arguments.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200214181547.21408-9-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 144 ++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index e94876c30ca..0c551401273 100644
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
 
@@ -1821,13 +1821,13 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
         return false;
     }
 
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
         return false;
     }
 
@@ -1921,12 +1921,12 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
 
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
 
@@ -2060,6 +2060,10 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
 {
     TCGv_i64 vd, vm;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     /* Vm/M bits must be zero for the Z variant */
     if (a->z && a->vm != 0) {
         return false;
@@ -2070,10 +2074,6 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2134,6 +2134,10 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
     TCGv_i32 tmp;
     TCGv_i64 vd;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fp16_dpconv, s)) {
         return false;
     }
@@ -2143,10 +2147,6 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2200,6 +2200,10 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
     TCGv_i32 tmp;
     TCGv_i64 vm;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fp16_dpconv, s)) {
         return false;
     }
@@ -2209,10 +2213,6 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2260,6 +2260,10 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
     TCGv_ptr fpst;
     TCGv_i64 tmp;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_vrint, s)) {
         return false;
     }
@@ -2269,10 +2273,6 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2321,6 +2321,10 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
     TCGv_i64 tmp;
     TCGv_i32 tcg_rmode;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_vrint, s)) {
         return false;
     }
@@ -2330,10 +2334,6 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2380,6 +2380,10 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
     TCGv_ptr fpst;
     TCGv_i64 tmp;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_vrint, s)) {
         return false;
     }
@@ -2389,10 +2393,6 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2412,12 +2412,12 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
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
 
@@ -2440,12 +2440,12 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
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
 
@@ -2494,12 +2494,12 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
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
 
@@ -2530,6 +2530,10 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
     TCGv_i32 vd;
     TCGv_i64 vm;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_jscvt, s)) {
         return false;
     }
@@ -2539,10 +2543,6 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2623,6 +2623,10 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     TCGv_ptr fpst;
     int frac_bits;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
         return false;
     }
@@ -2632,10 +2636,6 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2723,12 +2723,12 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
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


