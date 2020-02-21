Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EB9C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C24A208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iOLaaStU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C24A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58fD-0003yt-IE
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582z-0000L0-Ne
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582y-0004Dp-8o
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:49 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36081)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582y-0004Ck-21
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:48 -0500
Received: by mail-wr1-x441.google.com with SMTP id z3so2007471wru.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Iz5SxgRp9AmsPyanvIiNpsW+vmai2Z4aR3Ygzd1pADY=;
 b=iOLaaStUh43kskC+45LRVwBoDHwTrL+GKx0yi/1e7qICF2OdtmQc9WNxclg529p8QO
 pw9hBf6nBTvucD6tJ76YfzCG7IyN8F9Jhp0wYCfVEbjpEqC+5HgxXn5PvqRY6/X5Doon
 OZj7bpi5z8c3+VsvLzZyAt7HzhVPhYYvIBwZgjDhYWQRVdxy9bE260fqSxA64qhamcPA
 ARHlcejd4MoOKv4IkxC+jI4/VnbMCTZDgV+5YIOSqhV8oosvJPdYSY0zIlYo8T3nF3sR
 qWaoUpBf1KLXKEZw9IF2Rk65CaRJqTdoY/Zz6q8+zjY/AYpn/weU4033P7DENlVATyJb
 FAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Iz5SxgRp9AmsPyanvIiNpsW+vmai2Z4aR3Ygzd1pADY=;
 b=Peq2/oDepmFMz8/5WFueryg5IqIPfo/1QkJE4Ijy3QfiNNylyaUqmf8a7Wy5lfh42S
 FLsvZrL3FNuNCk1ITDY4Ou153Ic+dnfqC/OtMo/iq1N8BiEDu6ANNTIP8Kqd+h+vfDi1
 skiDAbezIpob80+Q0PLsv5VLc/3cNHEFPSyL9Txz3BXHQPyExEqmHBUHsY5YhID2YAAG
 MZYzNF7IwLNCjQv0yO9hH159yJLgLkqz5yLyOsWmOrthWy9VJauHO5RL8Zk0XkkZMiNG
 XdPOod9/N6MAbLNrqtxlHfFa6qLwus5JWUY46aDMcP8h6zU5YhsncoVIF0dBP0/wwtTh
 0h5w==
X-Gm-Message-State: APjAAAU/Mu90jM5sSHg7oyuwB5iBp3wR0Lg2ryjB1Va7AfCOxnsviwzD
 O0ROtOVDcVthBwomMQHyhl+yCLcnwpGxBQ==
X-Google-Smtp-Source: APXvYqwfFyfHW3TpSDIYNDnI0uSYnuGLe4O/5qu6KWQvtTUxUhsnwme0SOo6DzPdymdOi8X6q/nXAw==
X-Received: by 2002:a5d:65c6:: with SMTP id e6mr21383951wrw.45.1582290526636; 
 Fri, 21 Feb 2020 05:08:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/52] target/arm: Add missing checks for fpsp_v2
Date: Fri, 21 Feb 2020 13:07:40 +0000
Message-Id: <20200221130740.7583-53-peter.maydell@linaro.org>
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

We will eventually remove the early ARM_FEATURE_VFP test,
so add a proper test for each trans_* that does not already
have another ISA test.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200214181547.21408-11-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 78 ++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 9e5516f208b..89133202590 100644
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
@@ -2021,6 +2069,10 @@ static bool trans_VCMP_sp(DisasContext *s, arg_VCMP_sp *a)
 {
     TCGv_i32 vd, vm;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     /* Vm/M bits must be zero for the Z variant */
     if (a->z && a->vm != 0) {
         return false;
@@ -2464,6 +2516,10 @@ static bool trans_VCVT_int_sp(DisasContext *s, arg_VCVT_int_sp *a)
     TCGv_i32 vm;
     TCGv_ptr fpst;
 
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2682,6 +2738,10 @@ static bool trans_VCVT_sp_int(DisasContext *s, arg_VCVT_sp_int *a)
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


