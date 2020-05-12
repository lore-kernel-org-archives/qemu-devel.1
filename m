Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417BECA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A54E206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vdTzzdS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A54E206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYY9P-0006tz-7I
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXwH-0006qo-Kl
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXwG-0006K9-J2
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:29 -0400
Received: by mail-wr1-x444.google.com with SMTP id y16so9132693wrs.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5kP2tavJeHXFNyw0D0tAlIReOM6uXCl1ajq9fRhVF/U=;
 b=vdTzzdS2ByFH3nPVXqLeqletGredx5trALGRyfWMbXsBxdE/sFOM/8noIu/oJvA0nw
 7wbDcawcvL4RYm3t8/H2nzgLggocvu3Wo2OjqgkZ6hqAzlDfFIJMiCC5HCLfyLfvQJ8F
 q+fI1svyqeu6ycsVzNEUjKR7EqRsTqkmLzve9tkAbL1ZMG7+7ocWe3NTnl5BAsS4sakC
 +3C3u25RV8hNO50sGrdGliqr+ipBUEhdABgF8Y/IR2Lzk3OaWPGdDkLVbZWQCJlYF+bW
 Y6xSeFFBUy6qEBPd+Dp2fmCT7ejUw6gXgo8BqBVS2lIhlTwPE1oH0ZLrCXKoCFLVvh3m
 QHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5kP2tavJeHXFNyw0D0tAlIReOM6uXCl1ajq9fRhVF/U=;
 b=RVlz64X4xwATsymYg0zECxMzeDcd8oP5KPd5SeB9ZyNvfnpUqb0qe77867wiQO1sUm
 E6UK251DWERknjyeFq9YiBSLKaP/14R+VSMcHEeIak83Jb3hPqNc+5vhKOxbysHdm83t
 UyC1Garo6Va2aHiOVkZD2kELCAXnP0YGSLwnahZaFz7MPqTYvq1nPm4WJwnCwRo/DGDp
 1qZeMlx6mHz0PLt6YDoDu5qM/TxN50BETsiXmiGM5s2EK79acIapA2MJKtJhVUqxKi49
 fXHlBgx5MDL9Z9rdxFaTv6azSDW8cySPgrqFR0wkmllCqV8HdrkPro1GJ+uJ3Xb/uUSe
 Bx2A==
X-Gm-Message-State: AGi0PubTsyFHUqeEVKPnOmunXkK2V6sNxpnWlTH0UCB+XUQy+wsPqZAX
 LYdCQUhseHXE4jVpVA4XQwPZTQ==
X-Google-Smtp-Source: APiQypLf4h7skDhPjAmBdCIxKMoKISjeBUnfdiesVUTlcsrJY2HA8/5SXS6WrtjWNSo7W42sb2qZcg==
X-Received: by 2002:a5d:4806:: with SMTP id l6mr26390535wrq.121.1589301567302; 
 Tue, 12 May 2020 09:39:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o205sm18525981wmo.32.2020.05.12.09.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:39:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 15/17] target/arm: Move 'env' argument of recps_f32 and
 rsqrts_f32 helpers to usual place
Date: Tue, 12 May 2020 17:39:02 +0100
Message-Id: <20200512163904.10918-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512163904.10918-1-peter.maydell@linaro.org>
References: <20200512163904.10918-1-peter.maydell@linaro.org>
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The usual location for the env argument in the argument list of a TCG helper
is immediately after the return-value argument. recps_f32 and rsqrts_f32
differ in that they put it at the end.

Move the env argument to its usual place; this will allow us to
more easily use these helper functions with the gvec APIs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index a7926611665..f5ecaab2d4a 100644
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


