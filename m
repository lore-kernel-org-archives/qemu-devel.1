Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE4DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B18206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ekt41+up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B18206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8E5-0003ti-5u
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83k-0008K3-Mr
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:57 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:56289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83i-0006Ds-QU
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:56 -0400
Received: by mail-wm1-x330.google.com with SMTP id a65so1537694wme.5
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SVukAYLj//Ec4lyJ0DXM2Y62/+Blel5+e6wJ+BGYTtI=;
 b=ekt41+up6ZnM/vl6ujXDLt52D7Wc2GPFOKhYY0PINX1UigC/68YDyh0Giq+IG3ZZYX
 6alfK8ovxroZ6Lj63CZG0xC085NRnTPFDt4cER30kSknpad0PmjyIcms7zhfBxlkZ/fk
 cRqpmPuNqSjkF7cgy400O+3Ew7SH2+kOszRKBxIUWxDivaPd3O7/JunDYFYHmWINnKKr
 yFWb4C370ivYKiwCQYctuMd3t7EZVD681dtirosa/V5ME/+YbUkY0OCuwFf8kVoPd7LN
 KKOaF7n48wJlef12mRoppRr+UhJqKhmtDUyQcqNUQIijzXIp8h4zW/uX7U1MpBRpZBvh
 liTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SVukAYLj//Ec4lyJ0DXM2Y62/+Blel5+e6wJ+BGYTtI=;
 b=OiUqzvaVCPBmCx7jUAfVHSvFGpKuBwcLmo/fwQHIVqdD0j4kFyj2WB3uay0QvfI2YV
 KxkwQXpCqoLmHeH7FWsDxMpqRv05+cASTbv+/Nhff/kLyr6kP/z8NeuGomCjT62i0XKf
 wlmFLYAdO0E6s/HqqR9WCJEz6PRh/QbU2NEd7OTp4TzuEBcYvGMRJj9eXHJru7N4nezC
 1tH7Pf6gXEUcIRJ0QaMZRXlP4xlyI1A6G52KGLzCGs+a7o4lUv3KSoyE1bQdIJKJT7jB
 CIbVFSdBQqKhSn8k22Lo7hB7k3y1IyWBw5UTPBrr23wp7VoPhBj8VzSSa3Z34xOPPDEK
 DXGQ==
X-Gm-Message-State: AOAM532gGZO6u5WUxcC9M2pOEwQg+gjOhQdBtmxG2Z0JEMAYd5RbSpd0
 xl39zlwJK6Z1G/m/rXrTFepEWUmX1TVkRG6V
X-Google-Smtp-Source: ABdhPJxo9miPKRO1/eRjC1fxYuzFO5/GJPEagtG0in3troAZfHzN7P34FROfjLYTrJ3XGD6Lj0/Frw==
X-Received: by 2002:a05:600c:24d:: with SMTP id
 13mr2363483wmj.86.1598973527363; 
 Tue, 01 Sep 2020 08:18:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/47] target/arm: Implement VFP vp16
 VCVT-with-specified-rounding-mode
Date: Tue,  1 Sep 2020 16:17:52 +0100
Message-Id: <20200901151823.29785-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Implement the fp16 versions of the VFP VCVT instruction forms
which convert between floating point and integer with a specified
rounding mode.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-17-peter.maydell@linaro.org
---
 target/arm/vfp-uncond.decode   |  6 ++++--
 target/arm/translate-vfp.c.inc | 32 ++++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index ee700e51972..b7cd9d11ed5 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -64,7 +64,9 @@ VRINT       1111 1110 1.11 10 rm:2 .... 1011 01.0 .... \
             vm=%vm_dp vd=%vd_dp dp=1
 
 # VCVT float to int with specified rounding mode; Vd is always single-precision
+VCVT        1111 1110 1.11 11 rm:2 .... 1001 op:1 1.0 .... \
+            vm=%vm_sp vd=%vd_sp sz=1
 VCVT        1111 1110 1.11 11 rm:2 .... 1010 op:1 1.0 .... \
-            vm=%vm_sp vd=%vd_sp dp=0
+            vm=%vm_sp vd=%vd_sp sz=2
 VCVT        1111 1110 1.11 11 rm:2 .... 1011 op:1 1.0 .... \
-            vm=%vm_dp vd=%vd_sp dp=1
+            vm=%vm_dp vd=%vd_sp sz=3
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index fdf486b7c15..583e7ccdb20 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -396,7 +396,7 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
 static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
 {
     uint32_t rd, rm;
-    bool dp = a->dp;
+    int sz = a->sz;
     TCGv_ptr fpst;
     TCGv_i32 tcg_rmode, tcg_shift;
     int rounding = fp_decode_rm[a->rm];
@@ -406,12 +406,16 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
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
-    if (dp && !dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (sz == 3 && !dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -422,14 +426,18 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    if (sz == 1) {
+        fpst = fpstatus_ptr(FPST_FPCR_F16);
+    } else {
+        fpst = fpstatus_ptr(FPST_FPCR);
+    }
 
     tcg_shift = tcg_const_i32(0);
 
     tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
 
-    if (dp) {
+    if (sz == 3) {
         TCGv_i64 tcg_double, tcg_res;
         TCGv_i32 tcg_tmp;
         tcg_double = tcg_temp_new_i64();
@@ -451,10 +459,18 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
         tcg_single = tcg_temp_new_i32();
         tcg_res = tcg_temp_new_i32();
         neon_load_reg32(tcg_single, rm);
-        if (is_signed) {
-            gen_helper_vfp_tosls(tcg_res, tcg_single, tcg_shift, fpst);
+        if (sz == 1) {
+            if (is_signed) {
+                gen_helper_vfp_toslh(tcg_res, tcg_single, tcg_shift, fpst);
+            } else {
+                gen_helper_vfp_toulh(tcg_res, tcg_single, tcg_shift, fpst);
+            }
         } else {
-            gen_helper_vfp_touls(tcg_res, tcg_single, tcg_shift, fpst);
+            if (is_signed) {
+                gen_helper_vfp_tosls(tcg_res, tcg_single, tcg_shift, fpst);
+            } else {
+                gen_helper_vfp_touls(tcg_res, tcg_single, tcg_shift, fpst);
+            }
         }
         neon_store_reg32(tcg_res, rd);
         tcg_temp_free_i32(tcg_res);
-- 
2.20.1


