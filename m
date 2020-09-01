Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A372C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C04AF21582
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zqlHu/Tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04AF21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8O0-0006Wp-UM
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83c-0007xq-Eh
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:33291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83a-0006CM-Ia
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:48 -0400
Received: by mail-wm1-x32e.google.com with SMTP id e11so1184769wme.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OfI3cohWeU4QVLfb3VkS3Q79oLjkfLcWCPuj9bUOnJ0=;
 b=zqlHu/TjfXB8relzzI+FwnPEdzbkIXIdft1DwHN9iWcsWzouxcmxBourtRrrB6QYDf
 yLSk3YPUsJW6ImVJuwiZeEHOFI0BMisIRSv5jqgPvx4Sk4arHte/WaKsCtic/rpEYBJD
 +s8FFMFmCyezVHhKqsuYpSiyFkElRsUhIi5D7OkhO+tMKizdQrwpaNJMxTDYmKG1GTir
 ZikL3bhCdRxZ7xtat4XMk4d+DZtQy+tszhFYXNeBzy23gKP2BnIs6NYT/zzUAmpY3G2c
 dZF8pNYusqaKAd4pQ+pgnxne5OmOYEV3ul8DG4c19uwHmcOioqhrwk+m8mTafhqN8WA+
 FJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OfI3cohWeU4QVLfb3VkS3Q79oLjkfLcWCPuj9bUOnJ0=;
 b=NAthRWc5WkI+0fOzjjKhtKNhfYczz0Hw/U3RcZiiSSMTcLhRw3vxv+w6IBA/Fa24UF
 E4MB4VDzpInoJaZkzkblUfCTBiWGsLRgB3jhvCeoDFqdCnEArwlBdZjxPQ1vOEB/zezO
 f3EXqUdvUe28ZUrUxiY5mH858L8LEBfInpLE8kr4zOap0tkdkbe35mitNOCzN5+FX0tk
 EVHqN2FTPhp2mf5tTnTViXRQixV1awWEwzuEupeajoB6ee1woaEMIEE5qoLVjPHw6kL0
 jdKihUU3/w2HWQX+HPBbvw8TNf87xCd37UJvWELUo7rMy1zkRyrweiT4WsU/7utHwAEP
 ZaRw==
X-Gm-Message-State: AOAM533XwVBehOSAe/FSwnrp79ovXyK55mYGmNFvtpi9oMd5cc0eDKuj
 o90heHsKRqBhrfszeA4468dSsbIGhMLqKoTe
X-Google-Smtp-Source: ABdhPJwszRvzU3t0mg9yXzwl0KI6H8ahuztuhxdbbw62utiV3WvLCUp67RFWztz9Yegav9qGguuREg==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr2312684wmb.11.1598973525002; 
 Tue, 01 Sep 2020 08:18:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/47] target/arm: Use macros instead of open-coding fp16
 conversion helpers
Date: Tue,  1 Sep 2020 16:17:50 +0100
Message-Id: <20200901151823.29785-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
Message-id: 20200828183354.27913-15-peter.maydell@linaro.org
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


