Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD54C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B8C2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k99wxtIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B8C2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjHa-0001dm-DK
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCi-0002UF-6q
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:24 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:41556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCb-0005yQ-PE
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:23 -0400
Received: by mail-wr1-x434.google.com with SMTP id w5so46628wrp.8
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qNhJwLO6ObTREAr+RR8PmJaX5VQxkvMB5+PhvG7DTPI=;
 b=k99wxtIVNFvzVPWDk6sI1dv9LIBZKAhnzQGfsJrZ2IS/GksPmsy18d0smXwtsNoEOA
 tr+BKrb56NiuQ9iONuGa1G5bFrV5RN10yQS2XHriZSG+u72XH7pUt61dy39TaOBpEhGc
 cCEyHVOx+Fw05BjF+FGn72RU2LUi5yaudFlIB0ERfcZzTrd+gSvkPjezWmuqKE92khGM
 +1HwiohMSK+GpiN+ABi8WS2CXjuj1R7o3vQOUORwa4STt6LdOlnKw2fQ1JZ6PdqiVKFh
 eysT2Spge/QwkDDGTjhLR7Wxf1TTFYeZzQk1ohz9EO2/o8tlC+4SqKT1l59/YsHqq5N+
 MkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qNhJwLO6ObTREAr+RR8PmJaX5VQxkvMB5+PhvG7DTPI=;
 b=j++itPIH8XCJqjk+wVwF4rHIenu1R25MOAEWp/7Bh7PzIR+954Ryxs36+114llasPc
 fO+hW2C8TDq3oe2ya5Krzm8OPOaG4XeLHW6D6mDiGkLvQpDlX8ZF4RUdJkJleZB3Z1ON
 4D13Nx/Nvoy5wYklnfy5BgZlp3C42mdHNfZh1IAj6kcmxsF7v0B28m2XPwwfX4xTuBRK
 +Sojo5ro6pBWeqs9rzzyRJMW5ovqg+A6M66SvAEZ+/FefAoa8xFH3P0VyFOsRKexIWwB
 dP8IAwtnm8IBFD3PivsaLEngrB/Z0FZOoEySHuG7O7aWvdehp/XXMUjpJQBApsp7K5oH
 mkEw==
X-Gm-Message-State: AOAM530rO9+/A/p/9zCw9U3Yq6W2SVSUDtEisbUhdD9Zv/O4b5LZRm89
 9MzTWw0MjKf5UaqjiLG+nsYSQw==
X-Google-Smtp-Source: ABdhPJwrpOLx5ueBBqN3Y5JkDGenPoPkXHHO7FTApai0KKK3eWSFXdqraueKPwjlWlQKjVV3GLWsHQ==
X-Received: by 2002:a05:6000:48:: with SMTP id k8mr267868wrx.201.1598639656129; 
 Fri, 28 Aug 2020 11:34:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 16/45] target/arm: Implement VFP vp16
 VCVT-with-specified-rounding-mode
Date: Fri, 28 Aug 2020 19:33:25 +0100
Message-Id: <20200828183354.27913-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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


