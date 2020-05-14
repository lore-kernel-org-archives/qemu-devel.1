Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1EDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C2D205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pKcVzjRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C2D205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFI1-00036d-Du
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkv-00047v-Pz
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:37 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEku-00061V-Q0
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:37 -0400
Received: by mail-wr1-x433.google.com with SMTP id e1so4373044wrt.5
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Y5Eu2fOXO+eWchn2baPnHmqP/C+vDVXQhtqqQOOoM5I=;
 b=pKcVzjRdLI0pFaZnicDkLOKelDgoO2YR4C9UvtRyO2Tn5BQUQ4CMXBWtw8wriMb349
 7TsyV0jLtdaDJkBBfKDqaI0N2p3q8c27SHuYLYWzFL7kieMAyUygvuzjkt3l8NyURJvi
 +8UDCypN00cQOIYScFYcZ/lFnDwihMq6cE3g13GsmT10Zz/eU1TYeGrMWwQVojB48lQU
 V+et9wLOQ1b9uqtMZP900kCtsSFqOCbJACRK8IbAH0SZTf5kG4Ie7/4sYUKjvffMlIks
 j9I/yw9WW8C6EklV4CUJ6NZ44DKCwrZDGZQarEpZDXSI5/hJ+RBYwpQix+ux7i30cV6J
 Z4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y5Eu2fOXO+eWchn2baPnHmqP/C+vDVXQhtqqQOOoM5I=;
 b=jFGlPCZp9wiI8QiPUi3kEchQ7PwcSj7D2iXWDpEo1z2YhhcApbsWH63iaViAleuRv2
 qfWJocBaF7jTsALKGWEEen14kO2HHbpyeUzDOQHjdIaSPhPpkHvCfNuX5dn+1vrYilnz
 B6Dpvfn34JxeIKC3H6zQlSNDschh6+NbZcAxq+SvL4AqnldT5nc2eNbFcM8tedP5j73T
 09fkwuRO/QPiSQFxlbsgCGjkFgEUQQoiS7p2C22Kkq5sD9fF2PZlnLS4ZAC7v547870O
 Hws/a9mNaWZ2t2HhQDGsIpNyVTBoZTRjwPyYQiYtlD4T2KBEQglonqF/1DYdyCwROmld
 hlfw==
X-Gm-Message-State: AOAM5333m9xApdklGRfUTZpkfVEovNirW7qwXPFtS70icUrEoEbEkPAQ
 8AXq6zIhPaIlceF4kNAqmiuOTHR6qoVP8A==
X-Google-Smtp-Source: ABdhPJznDXy+LyJ6ppDXr/VpCXXLf4VCK0b/FawO1Sn2937gxnBKxv34suBzS8GSWnRy/0YDPPM3Pg==
X-Received: by 2002:adf:e784:: with SMTP id n4mr6109054wrm.170.1589466155068; 
 Thu, 14 May 2020 07:22:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/45] target/arm: Move 'env' argument of recps_f32 and
 rsqrts_f32 helpers to usual place
Date: Thu, 14 May 2020 15:21:36 +0100
Message-Id: <20200514142138.20875-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

The usual location for the env argument in the argument list of a TCG helper
is immediately after the return-value argument. recps_f32 and rsqrts_f32
differ in that they put it at the end.

Move the env argument to its usual place; this will allow us to
more easily use these helper functions with the gvec APIs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200512163904.10918-16-peter.maydell@linaro.org
---
 target/arm/helper.h     | 4 ++--
 target/arm/translate.c  | 4 ++--
 target/arm/vfp_helper.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 6e9629c87b0..49336dc432c 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -203,8 +203,8 @@ DEF_HELPER_FLAGS_3(vfp_fcvt_f64_to_f16, TCG_CALL_NO_RWG, f16, f64, ptr, i32)
 DEF_HELPER_4(vfp_muladdd, f64, f64, f64, f64, ptr)
 DEF_HELPER_4(vfp_muladds, f32, f32, f32, f32, ptr)
 
-DEF_HELPER_3(recps_f32, f32, f32, f32, env)
-DEF_HELPER_3(rsqrts_f32, f32, f32, f32, env)
+DEF_HELPER_3(recps_f32, f32, env, f32, f32)
+DEF_HELPER_3(rsqrts_f32, f32, env, f32, f32)
 DEF_HELPER_FLAGS_2(recpe_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
 DEF_HELPER_FLAGS_2(recpe_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(recpe_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index b9fcbbcbcb5..23e3705172b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5494,9 +5494,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 tcg_temp_free_ptr(fpstatus);
             } else {
                 if (size == 0) {
-                    gen_helper_recps_f32(tmp, tmp, tmp2, cpu_env);
+                    gen_helper_recps_f32(tmp, cpu_env, tmp, tmp2);
                 } else {
-                    gen_helper_rsqrts_f32(tmp, tmp, tmp2, cpu_env);
+                    gen_helper_rsqrts_f32(tmp, cpu_env, tmp, tmp2);
               }
             }
             break;
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index ec007fce255..88483d4066d 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -581,7 +581,7 @@ uint32_t HELPER(vfp_fcvt_f64_to_f16)(float64 a, void *fpstp, uint32_t ahp_mode)
 #define float32_three make_float32(0x40400000)
 #define float32_one_point_five make_float32(0x3fc00000)
 
-float32 HELPER(recps_f32)(float32 a, float32 b, CPUARMState *env)
+float32 HELPER(recps_f32)(CPUARMState *env, float32 a, float32 b)
 {
     float_status *s = &env->vfp.standard_fp_status;
     if ((float32_is_infinity(a) && float32_is_zero_or_denormal(b)) ||
@@ -594,7 +594,7 @@ float32 HELPER(recps_f32)(float32 a, float32 b, CPUARMState *env)
     return float32_sub(float32_two, float32_mul(a, b, s), s);
 }
 
-float32 HELPER(rsqrts_f32)(float32 a, float32 b, CPUARMState *env)
+float32 HELPER(rsqrts_f32)(CPUARMState *env, float32 a, float32 b)
 {
     float_status *s = &env->vfp.standard_fp_status;
     float32 product;
-- 
2.20.1


