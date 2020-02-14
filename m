Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE45FC3B1B9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8CE20873
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UI6JmzRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8CE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fZz-0004rT-I3
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVS-0004Nu-2r
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVQ-0000Cx-4b
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:01 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVP-00009V-Sa
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:00 -0500
Received: by mail-pf1-x441.google.com with SMTP id y73so5269407pfg.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MPCJ7dRq2fpTnBkIuHG7jADk+0h3hLWHD3XSDLeSg9g=;
 b=UI6JmzRnpNrL7G0Cvnr4KMvYPBy9+Wy+5LG6IQOz9Yxa8YAmXA7C7YYVFDx0Uy4/W6
 YAX1WRpxfid8LtBratA385xm2d/in01gRJxsQRznOBhuUAPVs6sDMk5xxSkWgQWtxujS
 MsLBTKdCIx80dlURaYh5Oew7gQU2FMJPwRyLBoxexKOzLsFAeKiOIajMsA651WCfuyTz
 HbE+rlmfulxXmrjI6pmKiTlYzQfIyTA3aGLsaim6QYApiSvAo7AkBYIklQCRF7zVAr7H
 xGMLB3m6wY81mCMQ+AXxg3T1vGwiisHVR0GVpdE1lfPR1vZ72alTLfo1c12Fypxkp3rx
 Arjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MPCJ7dRq2fpTnBkIuHG7jADk+0h3hLWHD3XSDLeSg9g=;
 b=S3XafJrtvIz5mHfgg+szSPNj693zuIw/G8h4tQXr9+8k+yZo0zExjrorzZrqq84b2s
 BZYmBnnFUTl26iUESkC2sfN8yJSJKGZJSgOxlTAYmNiV1o8XWIGXrdCcYsZO2LCARfJ5
 FWCMyI2BVkTU/aioWGI0WqSJNGwPLHVDSgvbfi3ZuiwliYMo2hkkNH90ZRN20/PbbIqd
 BQmBC2MXUMz4XOJdf/SBXF3zuppuLzIDFUeqSQZOJSRfrl6oVGnBEWCgTd/CdWXDIlXi
 g2qm31WlIXx0Lks85WMev+9RjMlUQ9xHSqOhuEc+tzvCvfHf+Wq+3kHNUjLvA6r/heVK
 7cZQ==
X-Gm-Message-State: APjAAAVF7RgheAsDzMfdurMkNBTS8rwR7zd71iyTaBImHwpGg+4tyOcv
 oUWRzIOS3rbvhHXWOC4wYnMiM04U/Ck=
X-Google-Smtp-Source: APXvYqxVUK0ku6IaYqJXcjT0RjyFCO9IODq6R8MjqxDaG1pnF0oadPvBU1/qgcc/OeGEawCqAOEWmQ==
X-Received: by 2002:a63:451b:: with SMTP id s27mr4713938pga.233.1581704158059; 
 Fri, 14 Feb 2020 10:15:58 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:15:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/19] target/arm: Perform fpdp_v2 check first
Date: Fri, 14 Feb 2020 10:15:36 -0800
Message-Id: <20200214181547.21408-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Shuffle the order of the checks so that we test the ISA
before we test anything else, such as the register arguments.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 143 +++++++++++++++++----------------
 1 file changed, 72 insertions(+), 71 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 5290828d0d..0c55140127 100644
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
 
@@ -1821,12 +1821,13 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
         return false;
     }
 
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
         return false;
     }
 
@@ -1920,12 +1921,12 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
 
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
 
@@ -2059,6 +2060,10 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
 {
     TCGv_i64 vd, vm;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     /* Vm/M bits must be zero for the Z variant */
     if (a->z && a->vm != 0) {
         return false;
@@ -2069,10 +2074,6 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2133,6 +2134,10 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
     TCGv_i32 tmp;
     TCGv_i64 vd;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fp16_dpconv, s)) {
         return false;
     }
@@ -2142,10 +2147,6 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2199,6 +2200,10 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
     TCGv_i32 tmp;
     TCGv_i64 vm;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fp16_dpconv, s)) {
         return false;
     }
@@ -2208,10 +2213,6 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2259,6 +2260,10 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
     TCGv_ptr fpst;
     TCGv_i64 tmp;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_vrint, s)) {
         return false;
     }
@@ -2268,10 +2273,6 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2320,6 +2321,10 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
     TCGv_i64 tmp;
     TCGv_i32 tcg_rmode;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_vrint, s)) {
         return false;
     }
@@ -2329,10 +2334,6 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2379,6 +2380,10 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
     TCGv_ptr fpst;
     TCGv_i64 tmp;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_vrint, s)) {
         return false;
     }
@@ -2388,10 +2393,6 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2411,12 +2412,12 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
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
 
@@ -2439,12 +2440,12 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
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
 
@@ -2493,12 +2494,12 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
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
 
@@ -2529,6 +2530,10 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
     TCGv_i32 vd;
     TCGv_i64 vm;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_jscvt, s)) {
         return false;
     }
@@ -2538,10 +2543,6 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2622,6 +2623,10 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     TCGv_ptr fpst;
     int frac_bits;
 
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
     if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
         return false;
     }
@@ -2631,10 +2636,6 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2722,12 +2723,12 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
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


