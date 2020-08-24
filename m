Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21578C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD03020738
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMqxQHMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD03020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADbP-0004UQ-3t
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTv-000075-2D
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTs-0002jF-Vh
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:54 -0400
Received: by mail-wm1-x342.google.com with SMTP id k20so8318103wmi.5
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=6lKoVS6w1NCGfCNGEILkzyyeD2MIZFL+MD3lJ0uI0KM=;
 b=eMqxQHMp6wl1AnKvC5hLmE85048n2ghdrMvZ6jbt3vNrCUTaSXOU+PzykGvr0hIL/A
 kLAFojvL+hGVkSEQmPqKmz4Zu3jFqjxTTrtFShvJYAoBBfxCIvZB3LJsfOpr2q/WBknU
 eAkh2/yDSrzA/IrsvjNYma7AjTVqhqCtxpxCqqX+GxV4AwDojieO+Gz1as55WOdHOhLa
 /Buvcqa7heR1k2m8uyZWh5r3wcA8YeJ09xeatB3O7NONr4wHN/wqKb9wmrnLaE9tOsUt
 pJS8mhxmLvWkzuzL63faHKPwSk74YmvCihNwRnHaFbyyhbhZkORvexcUwPJBJmTAx46g
 7nQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6lKoVS6w1NCGfCNGEILkzyyeD2MIZFL+MD3lJ0uI0KM=;
 b=MK0ih2/y3OrmkNcauSEtWGT7yW2tCkHA59WiIB6NlJ5dGeKzfv4zoYxrLRnYjywLq7
 8laKo9m4PPUFD9h+rtOGWgTOCg/q3r9HK/7LHS91EHPAip79rcd/3q+4luYpxoIk212B
 tAlNZp05k7NTKfpi7vLfCzZVbip8eQzbqflU/URamwbmLWlzRMW++DmwoBZIQXT32cLt
 rDE4QfrZr+5OiVRaOLoXlO2YVLpkDHANVu//5kdB6wvywkrhr+XS58DNHeVTL+VJ4HsP
 FasAVjYrJpqt+C7UiDVigRk55lCtv0/dxUNmz7+1tpheOHRZSa37w9ss/BxpVinUOIq0
 vM2Q==
X-Gm-Message-State: AOAM531LEoaYGSnrPvAnYlQmeXUaKZkxYon3A6vOmXsDc0vjidjN7QkY
 lQV5irE9C+SLvqDTAH3s304VFQ==
X-Google-Smtp-Source: ABdhPJz7BicA9EwqAOhpPS04623/e8TV41PXVIZ39rNGkYiZHEkiOCXtdGraE0qvbrlXo09dgykKMg==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr6114840wms.165.1598279391540; 
 Mon, 24 Aug 2020 07:29:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b14sm24499091wrj.93.2020.08.24.07.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 07:29:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 14/22] target/arm: Use macros instead of open-coding fp16
 conversion helpers
Date: Mon, 24 Aug 2020 15:29:26 +0100
Message-Id: <20200824142934.20850-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824142934.20850-1-peter.maydell@linaro.org>
References: <20200824142934.20850-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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

Now the VFP_CONV_FIX macros can handle fp16's distinction between the
width of the operation and the width of the type used to pass operands,
use the macros rather than the open-coded functions.

This creates an extra six helper functions, all of which we are going
to need for the AArch32 VFP fp16 instructions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h     |  6 +++
 target/arm/vfp_helper.c | 86 +++--------------------------------------
 2 files changed, 12 insertions(+), 80 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 278b4e47fd2..eefd1ac2a72 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -164,6 +164,10 @@ DEF_HELPER_2(vfp_tosizh, s32, f16, ptr)
 DEF_HELPER_2(vfp_tosizs, s32, f32, ptr)
 DEF_HELPER_2(vfp_tosizd, s32, f64, ptr)
 
+DEF_HELPER_3(vfp_toshh_round_to_zero, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_toslh_round_to_zero, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_touhh_round_to_zero, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_toulh_round_to_zero, i32, f32, i32, ptr)
 DEF_HELPER_3(vfp_toshs_round_to_zero, i32, f32, i32, ptr)
 DEF_HELPER_3(vfp_tosls_round_to_zero, i32, f32, i32, ptr)
 DEF_HELPER_3(vfp_touhs_round_to_zero, i32, f32, i32, ptr)
@@ -202,6 +206,8 @@ DEF_HELPER_3(vfp_sqtod, f64, i64, i32, ptr)
 DEF_HELPER_3(vfp_uhtod, f64, i64, i32, ptr)
 DEF_HELPER_3(vfp_ultod, f64, i64, i32, ptr)
 DEF_HELPER_3(vfp_uqtod, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_shtoh, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_uhtoh, f32, i32, i32, ptr)
 DEF_HELPER_3(vfp_sltoh, f16, i32, i32, ptr)
 DEF_HELPER_3(vfp_ultoh, f16, i32, i32, ptr)
 DEF_HELPER_3(vfp_sqtoh, f16, i64, i32, ptr)
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 7f7dbe4257f..c88ace3c566 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -434,92 +434,18 @@ VFP_CONV_FIX_A64(sq, s, 32, float32, 64, int64)
 VFP_CONV_FIX(uh, s, 32, float32, 32, uint16)
 VFP_CONV_FIX(ul, s, 32, float32, 32, uint32)
 VFP_CONV_FIX_A64(uq, s, 32, float32, 64, uint64)
+VFP_CONV_FIX(sh, h, 16, float32, 32, int16)
+VFP_CONV_FIX(sl, h, 16, float32, 32, int32)
+VFP_CONV_FIX_A64(sq, h, 16, float32, 64, int64)
+VFP_CONV_FIX(uh, h, 16, float32, 32, uint16)
+VFP_CONV_FIX(ul, h, 16, float32, 32, uint32)
+VFP_CONV_FIX_A64(uq, h, 16, float32, 64, uint64)
 
 #undef VFP_CONV_FIX
 #undef VFP_CONV_FIX_FLOAT
 #undef VFP_CONV_FLOAT_FIX_ROUND
 #undef VFP_CONV_FIX_A64
 
-uint32_t HELPER(vfp_sltoh)(uint32_t x, uint32_t shift, void *fpst)
-{
-    return int32_to_float16_scalbn(x, -shift, fpst);
-}
-
-uint32_t HELPER(vfp_ultoh)(uint32_t x, uint32_t shift, void *fpst)
-{
-    return uint32_to_float16_scalbn(x, -shift, fpst);
-}
-
-uint32_t HELPER(vfp_sqtoh)(uint64_t x, uint32_t shift, void *fpst)
-{
-    return int64_to_float16_scalbn(x, -shift, fpst);
-}
-
-uint32_t HELPER(vfp_uqtoh)(uint64_t x, uint32_t shift, void *fpst)
-{
-    return uint64_to_float16_scalbn(x, -shift, fpst);
-}
-
-uint32_t HELPER(vfp_toshh)(uint32_t x, uint32_t shift, void *fpst)
-{
-    if (unlikely(float16_is_any_nan(x))) {
-        float_raise(float_flag_invalid, fpst);
-        return 0;
-    }
-    return float16_to_int16_scalbn(x, get_float_rounding_mode(fpst),
-                                   shift, fpst);
-}
-
-uint32_t HELPER(vfp_touhh)(uint32_t x, uint32_t shift, void *fpst)
-{
-    if (unlikely(float16_is_any_nan(x))) {
-        float_raise(float_flag_invalid, fpst);
-        return 0;
-    }
-    return float16_to_uint16_scalbn(x, get_float_rounding_mode(fpst),
-                                    shift, fpst);
-}
-
-uint32_t HELPER(vfp_toslh)(uint32_t x, uint32_t shift, void *fpst)
-{
-    if (unlikely(float16_is_any_nan(x))) {
-        float_raise(float_flag_invalid, fpst);
-        return 0;
-    }
-    return float16_to_int32_scalbn(x, get_float_rounding_mode(fpst),
-                                   shift, fpst);
-}
-
-uint32_t HELPER(vfp_toulh)(uint32_t x, uint32_t shift, void *fpst)
-{
-    if (unlikely(float16_is_any_nan(x))) {
-        float_raise(float_flag_invalid, fpst);
-        return 0;
-    }
-    return float16_to_uint32_scalbn(x, get_float_rounding_mode(fpst),
-                                    shift, fpst);
-}
-
-uint64_t HELPER(vfp_tosqh)(uint32_t x, uint32_t shift, void *fpst)
-{
-    if (unlikely(float16_is_any_nan(x))) {
-        float_raise(float_flag_invalid, fpst);
-        return 0;
-    }
-    return float16_to_int64_scalbn(x, get_float_rounding_mode(fpst),
-                                   shift, fpst);
-}
-
-uint64_t HELPER(vfp_touqh)(uint32_t x, uint32_t shift, void *fpst)
-{
-    if (unlikely(float16_is_any_nan(x))) {
-        float_raise(float_flag_invalid, fpst);
-        return 0;
-    }
-    return float16_to_uint64_scalbn(x, get_float_rounding_mode(fpst),
-                                    shift, fpst);
-}
-
 /* Set the current fp rounding mode and return the old one.
  * The argument is a softfloat float_round_ value.
  */
-- 
2.20.1


