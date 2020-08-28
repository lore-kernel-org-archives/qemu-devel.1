Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B14AC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A842075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2HGo66B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A842075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjOm-0005WZ-Az
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCg-0002P6-9v
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCZ-0005xr-5U
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id z9so124174wmk.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wog/DDcjxmwzPzd3wKUUXbXIEInR2+mr6YMMIRusMRo=;
 b=z2HGo66BNR+iMV4BhVkgM0X/IPgr+t4eoO/GSfQCRzls3MNh5sdm+VcUTP7nJHlf4r
 e3+PjES8Ad0HGwhY0jVN+DhZudDWyokrRO6fQlEPikmP7nwm6dnit306SQ5NRQwynhrM
 4g/jEPCRc0bIzMBL9ELHL9NIHdfV3BO2lLOmB+5xssHKa0lMRsRjR5hlizgo2SJj/wO0
 LD20ePec4NIHRZfjwv6t2nq1pJ4YL9bIszSmo3ua6cLESk+UlKVIh7RSIaGURKxJrJh8
 NrN8q597QeCOfe17FEZU0vQC59OPvMAXQ8C2HxXQuHagA0SmabJds7oz0vQEa81pNdkL
 iIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wog/DDcjxmwzPzd3wKUUXbXIEInR2+mr6YMMIRusMRo=;
 b=iJlJr5rLnafWkhDgjNaSzBYoKehXsdRQI2bnmVKMNaAWC3WoVQaHiYJCDEs6pZEHCV
 6VyZQ+VOWwhRWqG2VXDrJW4le0o6RQ4mMRk+R/FV+13wFjI8Ki+hw4IghrMCnb7L/RWO
 EAwtlFYdNqgx3QHl1eTVo7yPoP/JnUAoVO9CahKYo6h+I0rWiIgW2T17N59qiTZVcY/w
 5sgu8r/Dg9b2fiQoDTxRwZdGuSNbqMEjfsyRphIcLtLIMgYfAj7yFLUDeAhoDxl7YLeM
 xkLYwJTQ+xOcIwKwPLL0ttxeiVDDIttwAUd7jN4weSf6qpEAJb7xK8Y+w58FFjFV5VLp
 vzGw==
X-Gm-Message-State: AOAM530syYA71MQhjB5RZEcHybjOPHoEl+4pGBTntcktLWLob7GTN4t5
 LnoaxEEf2xKU+0sbjiunvAcn/JzNntQIMDVJ
X-Google-Smtp-Source: ABdhPJw8yMihllAvlWeFpjeZCn3uf1bRg7iwrJLyejrU186PETbl3XLYxzmwPa+DUKFkYnzgpxZy0w==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr33583wmh.140.1598639653808;
 Fri, 28 Aug 2020 11:34:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 14/45] target/arm: Use macros instead of open-coding fp16
 conversion helpers
Date: Fri, 28 Aug 2020 19:33:23 +0100
Message-Id: <20200828183354.27913-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h     |  6 +++
 target/arm/vfp_helper.c | 86 +++--------------------------------------
 2 files changed, 12 insertions(+), 80 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 18afad634c9..03193728476 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -164,6 +164,10 @@ DEF_HELPER_2(vfp_tosizh, s32, f16, ptr)
 DEF_HELPER_2(vfp_tosizs, s32, f32, ptr)
 DEF_HELPER_2(vfp_tosizd, s32, f64, ptr)
 
+DEF_HELPER_3(vfp_toshh_round_to_zero, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toslh_round_to_zero, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_touhh_round_to_zero, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toulh_round_to_zero, i32, f16, i32, ptr)
 DEF_HELPER_3(vfp_toshs_round_to_zero, i32, f32, i32, ptr)
 DEF_HELPER_3(vfp_tosls_round_to_zero, i32, f32, i32, ptr)
 DEF_HELPER_3(vfp_touhs_round_to_zero, i32, f32, i32, ptr)
@@ -202,6 +206,8 @@ DEF_HELPER_3(vfp_sqtod, f64, i64, i32, ptr)
 DEF_HELPER_3(vfp_uhtod, f64, i64, i32, ptr)
 DEF_HELPER_3(vfp_ultod, f64, i64, i32, ptr)
 DEF_HELPER_3(vfp_uqtod, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_shtoh, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_uhtoh, f16, i32, i32, ptr)
 DEF_HELPER_3(vfp_sltoh, f16, i32, i32, ptr)
 DEF_HELPER_3(vfp_ultoh, f16, i32, i32, ptr)
 DEF_HELPER_3(vfp_sqtoh, f16, i64, i32, ptr)
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 7650890d440..ab3f0b170a7 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -434,92 +434,18 @@ VFP_CONV_FIX_A64(sq, s, 32, float32, 64, int64)
 VFP_CONV_FIX(uh, s, 32, float32, 32, uint16)
 VFP_CONV_FIX(ul, s, 32, float32, 32, uint32)
 VFP_CONV_FIX_A64(uq, s, 32, float32, 64, uint64)
+VFP_CONV_FIX(sh, h, 16, dh_ctype_f16, 32, int16)
+VFP_CONV_FIX(sl, h, 16, dh_ctype_f16, 32, int32)
+VFP_CONV_FIX_A64(sq, h, 16, dh_ctype_f16, 64, int64)
+VFP_CONV_FIX(uh, h, 16, dh_ctype_f16, 32, uint16)
+VFP_CONV_FIX(ul, h, 16, dh_ctype_f16, 32, uint32)
+VFP_CONV_FIX_A64(uq, h, 16, dh_ctype_f16, 64, uint64)
 
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


