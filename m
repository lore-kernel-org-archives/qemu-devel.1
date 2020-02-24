Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D577C38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1567021744
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxvrA+og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1567021744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MKV-0001LX-AA
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7j-0004LC-T2
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7i-0005rm-Eg
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:47 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7i-0005rG-8v
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:46 -0500
Received: by mail-pl1-x644.google.com with SMTP id p11so4611651plq.10
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nZ29NUYH0rX/kvQeepGmU3q2/jzjoKfkqGWPwiKmojM=;
 b=xxvrA+ogSQK5y+8pjt/5xu+j9hsVv24loOIm+bdauHtMM2SQWn2Nq3tSXsmW6h4/Rl
 Fx9QkPuJqgiaNXdzImh97cao6XiPvw5Gf7F9GTDKpcaAav/lVC99oH3SBGFqWFdkpxdV
 bbVzoN0aRklZwTaO/TEVXdT55mxPY26ZHyc8Xz6xajt0T+8qtUBDEpuL7olNRJMKSKAD
 R74cgMCYhDAfCtfQ7eH3+BIeEO9xnpazBVEWhLxiWOO6cRFUL2ZebfmV1xxz9kNxyvt8
 5sPxVXZBUhqSXqG8+Pry3qLsTquv6lG49B5lBx9JgPSCZEIQ5QL5mBR5Y+Co6f2x5Kx7
 lSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nZ29NUYH0rX/kvQeepGmU3q2/jzjoKfkqGWPwiKmojM=;
 b=oV3p01GQKvVc2lMbk8EceaMvENam4UY4k8WigIR8UQuozWfUPQ+P4kaZOta5Pb81mG
 iUABZPGrP3E0TAgyjjTdiziOKC3uybhSdVoGStm440IoTqLjaHi98HOII/8cIx6b3U3u
 4Q3t/KvDO39tt0Qe60ysyAR3YGtsHAdbEyIk2Y/feDrrIK5BX0Dz3Ha3vEt/Gu4F0cuQ
 CJKE8M4O0M4z9UxsYj7OHUe6fQke14UbxTdUv/nLa8QWvjILzLOnvIwgfHMBTm9KDS8p
 /ovNKEFfk8T08yfSTG4D91iMUUZbRs404j0EFRSpj+boA542KK9k0B6IwBdjL6iRke5Y
 rNlg==
X-Gm-Message-State: APjAAAWnc49pdcWms20jAJC9WcQ8WWj4rXt4tG9i5iVxue8HvGgk7tI7
 f2whGle/UsYTNrAekfiN8lKjNtlICGw=
X-Google-Smtp-Source: APXvYqyllfHpBWYyI0Ol06uRoeeRdNsHuQBPpn+6TQJByEebhRzNAYL/PZl4oN1SLv4oRqJIpbWGDg==
X-Received: by 2002:a17:902:8b85:: with SMTP id
 ay5mr48009211plb.253.1582582964790; 
 Mon, 24 Feb 2020 14:22:44 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/17] target/arm: Add missing checks for fpsp_v2
Date: Mon, 24 Feb 2020 14:22:23 -0800
Message-Id: <20200224222232.13807-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

We will eventually remove the early ARM_FEATURE_VFP test,
so add a proper test for each trans_* that does not already
have another ISA test.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 78 ++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 51d46f4302..f88a95438f 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -555,6 +555,13 @@ static bool trans_VMOV_to_gp(DisasContext *s, arg_VMOV_to_gp *a)
     int pass;
     uint32_t offset;
 
+    /* SIZE == 2 is a VFP instruction; otherwise NEON.  */
+    if (a->size == 2
+        ? !dc_isar_feature(aa32_fpsp_v2, s)
+        : !arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
     /* UNDEF accesses to D16-D31 if they don't exist */
     if (!dc_isar_feature(aa32_simd_r32, s) && (a->vn & 0x10)) {
         return false;
@@ -564,10 +571,6 @@ static bool trans_VMOV_to_gp(DisasContext *s, arg_VMOV_to_gp *a)
     pass = extract32(offset, 2, 1);
     offset = extract32(offset, 0, 2) * 8;
 
-    if (a->size != 2 && !arm_dc_feature(s, ARM_FEATURE_NEON)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -614,6 +617,13 @@ static bool trans_VMOV_from_gp(DisasContext *s, arg_VMOV_from_gp *a)
     int pass;
     uint32_t offset;
 
+    /* SIZE == 2 is a VFP instruction; otherwise NEON.  */
+    if (a->size == 2
+        ? !dc_isar_feature(aa32_fpsp_v2, s)
+        : !arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
     /* UNDEF accesses to D16-D31 if they don't exist */
     if (!dc_isar_feature(aa32_simd_r32, s) && (a->vn & 0x10)) {
         return false;
@@ -623,10 +633,6 @@ static bool trans_VMOV_from_gp(DisasContext *s, arg_VMOV_from_gp *a)
     pass = extract32(offset, 2, 1);
     offset = extract32(offset, 0, 2) * 8;
 
-    if (a->size != 2 && !arm_dc_feature(s, ARM_FEATURE_NEON)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -700,6 +706,10 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
     TCGv_i32 tmp;
     bool ignore_vfp_enabled = false;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     if (arm_dc_feature(s, ARM_FEATURE_M)) {
         /*
          * The only M-profile VFP vmrs/vmsr sysreg is FPSCR.
@@ -844,6 +854,10 @@ static bool trans_VMOV_single(DisasContext *s, arg_VMOV_single *a)
 {
     TCGv_i32 tmp;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -873,6 +887,10 @@ static bool trans_VMOV_64_sp(DisasContext *s, arg_VMOV_64_sp *a)
 {
     TCGv_i32 tmp;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     /*
      * VMOV between two general-purpose registers and two single precision
      * floating point registers
@@ -908,8 +926,12 @@ static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_dp *a)
 
     /*
      * VMOV between two general-purpose registers and one double precision
-     * floating point register
+     * floating point register.  Note that this does not require support
+     * for double precision arithmetic.
      */
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
     if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
@@ -946,6 +968,10 @@ static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
     uint32_t offset;
     TCGv_i32 addr, tmp;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -977,6 +1003,11 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_dp *a)
     TCGv_i32 addr;
     TCGv_i64 tmp;
 
+    /* Note that this does not require support for double arithmetic.  */
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     /* UNDEF accesses to D16-D31 if they don't exist */
     if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
         return false;
@@ -1013,6 +1044,10 @@ static bool trans_VLDM_VSTM_sp(DisasContext *s, arg_VLDM_VSTM_sp *a)
     TCGv_i32 addr, tmp;
     int i, n;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     n = a->imm;
 
     if (n == 0 || (a->vd + n) > 32) {
@@ -1086,6 +1121,11 @@ static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
     TCGv_i64 tmp;
     int i, n;
 
+    /* Note that this does not require support for double arithmetic.  */
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     n = a->imm >> 1;
 
     if (n == 0 || (a->vd + n) > 32 || n > 16) {
@@ -1234,6 +1274,10 @@ static bool do_vfp_3op_sp(DisasContext *s, VFPGen3OpSPFn *fn,
     TCGv_i32 f0, f1, fd;
     TCGv_ptr fpst;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fpshvec, s) &&
         (veclen != 0 || s->vec_stride != 0)) {
         return false;
@@ -1388,6 +1432,10 @@ static bool do_vfp_2op_sp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
     int veclen = s->vec_len;
     TCGv_i32 f0, fd;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fpshvec, s) &&
         (veclen != 0 || s->vec_stride != 0)) {
         return false;
@@ -2023,6 +2071,10 @@ static bool trans_VCMP_sp(DisasContext *s, arg_VCMP_sp *a)
 {
     TCGv_i32 vd, vm;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     /* Vm/M bits must be zero for the Z variant */
     if (a->z && a->vm != 0) {
         return false;
@@ -2466,6 +2518,10 @@ static bool trans_VCVT_int_sp(DisasContext *s, arg_VCVT_int_sp *a)
     TCGv_i32 vm;
     TCGv_ptr fpst;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2684,6 +2740,10 @@ static bool trans_VCVT_sp_int(DisasContext *s, arg_VCVT_sp_int *a)
     TCGv_i32 vm;
     TCGv_ptr fpst;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
-- 
2.20.1


