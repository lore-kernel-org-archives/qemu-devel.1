Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641C7C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F65620737
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wA1LJRFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F65620737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjMj-00024J-As
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCf-0002Mv-Fa
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCX-0005xe-KJ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id a5so55564wrm.6
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=FHUFQV4FXXHkAhMkndvZsQ9Vo9mjapkfHTwxSOIt/l0=;
 b=wA1LJRFmANZRhoMDSzF/eLoNuFzKYRS7FgDydVoMnQxheKrL+cb3yy09zcgwh9gzsn
 c2ACeUIE4TjscPAmEYOvWasQwrdkhticOuX1LKF/8Kw1Pm91nKVvv4JEN+bKClWr9hts
 +EAT+/lI4v/rjCO2OUy4SVCagy3rVp7QoKcMu/5yhPyLqs+qlWkqLkWLVYY0pIo4C1kT
 Tz0tDNKcbVSyGWttngYi+K9Bkbq08NzNBF92sRGicrncd1g99TPGKNu8BxxX8qnWa+y7
 flhkq97fjte91cjlMB2Ud8ZxreAjWrElkpxfr+MTiEfjmramAAPL652FMxLMe6agV/wL
 5ScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FHUFQV4FXXHkAhMkndvZsQ9Vo9mjapkfHTwxSOIt/l0=;
 b=iEccw0ronRcRM2LiJ98MizVRmRiC2/tyPr+voIiMrmPbL4DySaFUA95pLLOGhI+7Od
 /aIYlJ0OpY1BV0u9TqJMVm86eHCpwwKE/TFcdotdaXf/8JdeX9/oZfua8lmLJp/APvHX
 wdJbZjbzU9Dk98YGx7M2Cg7m9GN3OkkVC+vl3MuZ5HENfYE3thzmiM5evAVV9RJ67o4I
 jB8GZjNOGOQCKMqZJccEjyvsngIqnqmuXKyaewmo/psRt0MefUahv4uqw0eRMtt4Yfia
 NmxufEEJ2drwsAr3hGqyiYdKm27Y+E6fSvDeajZsEHD4FzVqjG9DT68/VQEIoQZ4WrWQ
 fTlQ==
X-Gm-Message-State: AOAM530TCVow6wAoCVcvkXK+5cWrqf+oRS6kM2v4+2M9DxkVpMsr0A2L
 a9y4o73LsS1+vrSXQNS3f0xAmxaw18Sj6k24
X-Google-Smtp-Source: ABdhPJwcI+KACIjiCZgEv3k68nKe04BGcccxzJwRCQSujx90bzOGQYWzXzT4T4bYeZ/SUAQs/THJRg==
X-Received: by 2002:adf:dd44:: with SMTP id u4mr266229wrm.366.1598639652225;
 Fri, 28 Aug 2020 11:34:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 13/45] target/arm: Make VFP_CONV_FIX macros take separate
 float type and float size
Date: Fri, 28 Aug 2020 19:33:22 +0100
Message-Id: <20200828183354.27913-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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

Currently the VFP_CONV_FIX macros take a single fsz argument for the
size of the float type, which is used both to select the name of
the functions to call (eg float32_is_any_nan()) and also for the
type to use for the float inputs and outputs (eg float32).

Separate these into fsz and ftype arguments, so that we can use them
for fp16, which uses 'float16' in the function names but is still
passing inputs and outputs in a 32-bit sized type.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp_helper.c | 46 ++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 55aa38f0ce8..7650890d440 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -394,13 +394,13 @@ float32 VFP_HELPER(fcvts, d)(float64 x, CPUARMState *env)
 }
 
 /* VFP3 fixed point conversion.  */
-#define VFP_CONV_FIX_FLOAT(name, p, fsz, isz, itype) \
-float##fsz HELPER(vfp_##name##to##p)(uint##isz##_t  x, uint32_t shift, \
+#define VFP_CONV_FIX_FLOAT(name, p, fsz, ftype, isz, itype)            \
+ftype HELPER(vfp_##name##to##p)(uint##isz##_t  x, uint32_t shift,      \
                                      void *fpstp) \
 { return itype##_to_##float##fsz##_scalbn(x, -shift, fpstp); }
 
-#define VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, isz, itype, ROUND, suff)   \
-uint##isz##_t HELPER(vfp_to##name##p##suff)(float##fsz x, uint32_t shift, \
+#define VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, ftype, isz, itype, ROUND, suff) \
+uint##isz##_t HELPER(vfp_to##name##p##suff)(ftype x, uint32_t shift,      \
                                             void *fpst)                   \
 {                                                                         \
     if (unlikely(float##fsz##_is_any_nan(x))) {                           \
@@ -410,30 +410,30 @@ uint##isz##_t HELPER(vfp_to##name##p##suff)(float##fsz x, uint32_t shift, \
     return float##fsz##_to_##itype##_scalbn(x, ROUND, shift, fpst);       \
 }
 
-#define VFP_CONV_FIX(name, p, fsz, isz, itype)                   \
-VFP_CONV_FIX_FLOAT(name, p, fsz, isz, itype)                     \
-VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, isz, itype,               \
+#define VFP_CONV_FIX(name, p, fsz, ftype, isz, itype)            \
+VFP_CONV_FIX_FLOAT(name, p, fsz, ftype, isz, itype)              \
+VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, ftype, isz, itype,        \
                          float_round_to_zero, _round_to_zero)    \
-VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, isz, itype,               \
+VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, ftype, isz, itype,        \
                          get_float_rounding_mode(fpst), )
 
-#define VFP_CONV_FIX_A64(name, p, fsz, isz, itype)               \
-VFP_CONV_FIX_FLOAT(name, p, fsz, isz, itype)                     \
-VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, isz, itype,               \
+#define VFP_CONV_FIX_A64(name, p, fsz, ftype, isz, itype)        \
+VFP_CONV_FIX_FLOAT(name, p, fsz, ftype, isz, itype)              \
+VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, ftype, isz, itype,        \
                          get_float_rounding_mode(fpst), )
 
-VFP_CONV_FIX(sh, d, 64, 64, int16)
-VFP_CONV_FIX(sl, d, 64, 64, int32)
-VFP_CONV_FIX_A64(sq, d, 64, 64, int64)
-VFP_CONV_FIX(uh, d, 64, 64, uint16)
-VFP_CONV_FIX(ul, d, 64, 64, uint32)
-VFP_CONV_FIX_A64(uq, d, 64, 64, uint64)
-VFP_CONV_FIX(sh, s, 32, 32, int16)
-VFP_CONV_FIX(sl, s, 32, 32, int32)
-VFP_CONV_FIX_A64(sq, s, 32, 64, int64)
-VFP_CONV_FIX(uh, s, 32, 32, uint16)
-VFP_CONV_FIX(ul, s, 32, 32, uint32)
-VFP_CONV_FIX_A64(uq, s, 32, 64, uint64)
+VFP_CONV_FIX(sh, d, 64, float64, 64, int16)
+VFP_CONV_FIX(sl, d, 64, float64, 64, int32)
+VFP_CONV_FIX_A64(sq, d, 64, float64, 64, int64)
+VFP_CONV_FIX(uh, d, 64, float64, 64, uint16)
+VFP_CONV_FIX(ul, d, 64, float64, 64, uint32)
+VFP_CONV_FIX_A64(uq, d, 64, float64, 64, uint64)
+VFP_CONV_FIX(sh, s, 32, float32, 32, int16)
+VFP_CONV_FIX(sl, s, 32, float32, 32, int32)
+VFP_CONV_FIX_A64(sq, s, 32, float32, 64, int64)
+VFP_CONV_FIX(uh, s, 32, float32, 32, uint16)
+VFP_CONV_FIX(ul, s, 32, float32, 32, uint32)
+VFP_CONV_FIX_A64(uq, s, 32, float32, 64, uint64)
 
 #undef VFP_CONV_FIX
 #undef VFP_CONV_FIX_FLOAT
-- 
2.20.1


