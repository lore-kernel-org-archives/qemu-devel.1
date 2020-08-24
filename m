Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DDBC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4064205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUteb7xf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4064205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADV1-0001Yg-1d
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTh-00081w-CN
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTf-0002es-J4
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:41 -0400
Received: by mail-wr1-x441.google.com with SMTP id l2so8915591wrc.7
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=bJjPsrivssu5AFGU0GHe8QW+4C7NJ4zaWEp8nyO14bs=;
 b=NUteb7xfBsXChWoGpvfQK34P1MGve0qQWzExVnDuouDw0Sxsh9vlvzu72ujN5p49Kt
 v4ktEkMpG6O4xcj8nOQpw5YIC83LWG4QhcZKgdyhG0HzbtqvthA8TC0qaRttxJvjx/Vl
 UDi5Y2Jy5er/EsU0n9gK1J/bmgdigzkbSf563G3OZT15aFBOuw56pWdJtrJWYiEmdgQb
 5NyhN+TB7mxt5VszFscF3TTf7vzs7ZTQTGq2IweGM30cDFdXNVhxodNiak7x/Qt0v2kM
 EMpCE7coDVEKXgXg/RFqcFWgEdnq6dE29KdkYVAp4pb1b4gV51e+OfDRDYzml+g2M+S6
 a6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bJjPsrivssu5AFGU0GHe8QW+4C7NJ4zaWEp8nyO14bs=;
 b=rcNEwNhQDSOefrnnhPYe3SJJ7uw1ivc8Z0DUu/ljPoK+JzPlEK7nO0HxVA3b3+fucB
 TD2q4O6SPK3h7coOi78t7qxzrR7MdAl0ageUKxbtVMZpuDL2ACjBacHRkFWo4lYwcNdw
 pxAwe6GAA4emleNOGH/GK/FpwFDR95/3X2MLh5hZDxFgdUTtuC3F/r9ijpwt18FCLdVX
 LOTpN77DzFvxgHb6EvPE+MGD6GPhVS9BpsaPmaEQ54Qat0D6PF3F13F9WGmckrLxLg+V
 mCaMA1uEKOA9ybYVOu21nrSzwuqjrO9BsGMz9HETimR9p39EruCM4HIYADrD7Iw0pXUF
 /T7Q==
X-Gm-Message-State: AOAM532l0e2HND2TETPTPIOsk+hmBtjJU1Z4SjQnWWrmfyr82mT10KNa
 CJTgMQnZ53wceHgbRBixQ+fJyg==
X-Google-Smtp-Source: ABdhPJzujpp5C0RVwb+DpFlscFm5V7CVxDxufrnipZzHez8iOgGuUyqlY47bEJg1MiNjJ7OnS7+TtQ==
X-Received: by 2002:a5d:4746:: with SMTP id o6mr6497149wrs.410.1598279378153; 
 Mon, 24 Aug 2020 07:29:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b14sm24499091wrj.93.2020.08.24.07.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 07:29:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/22] target/arm: Remove local definitions of float constants
Date: Mon, 24 Aug 2020 15:29:13 +0100
Message-Id: <20200824142934.20850-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824142934.20850-1-peter.maydell@linaro.org>
References: <20200824142934.20850-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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

In several places the target/arm code defines local float constants
for 2, 3 and 1.5, which are also provided by include/fpu/softfloat.h.
Remove the unnecessary local duplicate versions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.c    | 11 -----------
 target/arm/translate-sve.c |  4 ----
 target/arm/vfp_helper.c    |  4 ----
 3 files changed, 19 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 8682630ff6c..030821489b3 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -234,17 +234,6 @@ uint64_t HELPER(neon_cgt_f64)(float64 a, float64 b, void *fpstp)
  * versions, these do a fully fused multiply-add or
  * multiply-add-and-halve.
  */
-#define float16_two make_float16(0x4000)
-#define float16_three make_float16(0x4200)
-#define float16_one_point_five make_float16(0x3e00)
-
-#define float32_two make_float32(0x40000000)
-#define float32_three make_float32(0x40400000)
-#define float32_one_point_five make_float32(0x3fc00000)
-
-#define float64_two make_float64(0x4000000000000000ULL)
-#define float64_three make_float64(0x4008000000000000ULL)
-#define float64_one_point_five make_float64(0x3FF8000000000000ULL)
 
 uint32_t HELPER(recpsf_f16)(uint32_t a, uint32_t b, void *fpstp)
 {
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index d97cb37d83f..1e2bcf840e7 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3872,10 +3872,6 @@ static bool trans_##NAME##_zpzi(DisasContext *s, arg_rpri_esz *a)         \
     return true;                                                          \
 }
 
-#define float16_two  make_float16(0x4000)
-#define float32_two  make_float32(0x40000000)
-#define float64_two  make_float64(0x4000000000000000ULL)
-
 DO_FP_IMM(FADD, fadds, half, one)
 DO_FP_IMM(FSUB, fsubs, half, one)
 DO_FP_IMM(FMUL, fmuls, half, two)
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 64266ece620..02ab8d7f2d8 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -582,10 +582,6 @@ uint32_t HELPER(vfp_fcvt_f64_to_f16)(float64 a, void *fpstp, uint32_t ahp_mode)
     return r;
 }
 
-#define float32_two make_float32(0x40000000)
-#define float32_three make_float32(0x40400000)
-#define float32_one_point_five make_float32(0x3fc00000)
-
 float32 HELPER(recps_f32)(CPUARMState *env, float32 a, float32 b)
 {
     float_status *s = &env->vfp.standard_fp_status;
-- 
2.20.1


