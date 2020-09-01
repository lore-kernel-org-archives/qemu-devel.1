Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439E4C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B336215A4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TLygcW5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B336215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8L2-00019Q-5f
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83X-0007lo-R5
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:43 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:38115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83V-0006BX-U5
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:43 -0400
Received: by mail-wm1-x336.google.com with SMTP id l9so1555124wme.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=6qscLCEYsnlzoWZ+tBuksvb9A5uD8HPfpchW4o6rw2k=;
 b=TLygcW5rYzh8cVop0WF8tyPgwpGzA9VcFAWfpt4ztY+isC6PTr5ZVSB5EUfQL6/YZV
 F4hzM1EN3xVJAUKRRX1qDHsfYCJne0FI/o7JorZZg2r7xpn/+qbich1Gu5o7FeoSod3K
 uBIcYCKUWV8GwY1rgbXjQlLhdXVKWq2Vt6Imt6iMW222eQLxkpRNvjMYniSquGCKyfWo
 ukOYKyC0D7qSZEmx4GKsNNDGHMxFku+I/r9T+i1AS44ktOkTGNkJYoVwwlE912oRRx7g
 B6LVtBkIBbmxptTJqX+uBttjcbuuNMNAIzyBhkVnI2YUgVYwfk8t2+JQUXjXk3zJ+RvO
 KT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6qscLCEYsnlzoWZ+tBuksvb9A5uD8HPfpchW4o6rw2k=;
 b=hcmwXQ2AvHEIjiCIOVPit19y/3Ccyc1PeUJgFLlAtupkNcMGc2cwpTLcyb1xSEymuK
 gnfcFPPXsGFt0s3qhPC7ndw4FLPa8jUrVtdk5qPnXVwhg9ndkRyCQTvBvU4aXasiJQXt
 i+ciTx4k2vk3zCpTWKxudgNvg2JbGMGqxLdf8x/6FclalmP3V+NajH8bQIaPx7c6Z3EC
 xub/LFDDo2FnozNHOb9+eze5H7M953uo+boqqS1zZ2XkyYMmdys6Hk2flC+w6/+cocOG
 Rom0cxUrkaCCx+JdFuSonJYtFE638rLgYM5oeGOOW3GFOogoYxeWhl6fw9Rm5DwXdU0d
 8t7g==
X-Gm-Message-State: AOAM533XgSxtQJ6G04R2ejUU7ZbbjYUCOjni5tgca5cletV2yjnVFoUl
 uN4z7DrdO3MOYJCX66UEn8mmmrXhgq9IhXGM
X-Google-Smtp-Source: ABdhPJzvdhRs6CFVokMIuQs2dYj1NMfNAr45Tv70Vo2OirminBrDTBKgJ5cbsNI/0fAQjD3Lo5v9HQ==
X-Received: by 2002:a1c:9909:: with SMTP id b9mr2256324wme.98.1598973519810;
 Tue, 01 Sep 2020 08:18:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/47] target/arm: Implement VFP fp16 VCMP
Date: Tue,  1 Sep 2020 16:17:46 +0100
Message-Id: <20200901151823.29785-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Implement fp16 version of VCMP.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-11-peter.maydell@linaro.org
---
 target/arm/helper.h            |  2 ++
 target/arm/vfp.decode          |  2 ++
 target/arm/vfp_helper.c        | 15 +++++++------
 target/arm/translate-vfp.c.inc | 39 ++++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 37739b0e788..18afad634c9 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -134,8 +134,10 @@ DEF_HELPER_1(vfp_absd, f64, f64)
 DEF_HELPER_2(vfp_sqrth, f16, f16, env)
 DEF_HELPER_2(vfp_sqrts, f32, f32, env)
 DEF_HELPER_2(vfp_sqrtd, f64, f64, env)
+DEF_HELPER_3(vfp_cmph, void, f16, f16, env)
 DEF_HELPER_3(vfp_cmps, void, f32, f32, env)
 DEF_HELPER_3(vfp_cmpd, void, f64, f64, env)
+DEF_HELPER_3(vfp_cmpeh, void, f16, f16, env)
 DEF_HELPER_3(vfp_cmpes, void, f32, f32, env)
 DEF_HELPER_3(vfp_cmped, void, f64, f64, env)
 
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index c898183771b..b213da4b55d 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -176,6 +176,8 @@ VSQRT_hp     ---- 1110 1.11 0001 .... 1001 11.0 ....        @vfp_dm_ss
 VSQRT_sp     ---- 1110 1.11 0001 .... 1010 11.0 ....        @vfp_dm_ss
 VSQRT_dp     ---- 1110 1.11 0001 .... 1011 11.0 ....        @vfp_dm_dd
 
+VCMP_hp      ---- 1110 1.11 010 z:1 .... 1001 e:1 1.0 .... \
+             vd=%vd_sp vm=%vm_sp
 VCMP_sp      ---- 1110 1.11 010 z:1 .... 1010 e:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCMP_dp      ---- 1110 1.11 010 z:1 .... 1011 e:1 1.0 .... \
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index cc7fb6ddb6a..55aa38f0ce8 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -330,19 +330,20 @@ static void softfloat_to_vfp_compare(CPUARMState *env, FloatRelation cmp)
 }
 
 /* XXX: check quiet/signaling case */
-#define DO_VFP_cmp(p, type) \
-void VFP_HELPER(cmp, p)(type a, type b, CPUARMState *env)  \
+#define DO_VFP_cmp(P, FLOATTYPE, ARGTYPE, FPST) \
+void VFP_HELPER(cmp, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env)  \
 { \
     softfloat_to_vfp_compare(env, \
-        type ## _compare_quiet(a, b, &env->vfp.fp_status)); \
+        FLOATTYPE ## _compare_quiet(a, b, &env->vfp.FPST)); \
 } \
-void VFP_HELPER(cmpe, p)(type a, type b, CPUARMState *env) \
+void VFP_HELPER(cmpe, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env) \
 { \
     softfloat_to_vfp_compare(env, \
-        type ## _compare(a, b, &env->vfp.fp_status)); \
+        FLOATTYPE ## _compare(a, b, &env->vfp.FPST)); \
 }
-DO_VFP_cmp(s, float32)
-DO_VFP_cmp(d, float64)
+DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status_f16)
+DO_VFP_cmp(s, float32, float32, fp_status)
+DO_VFP_cmp(d, float64, float64, fp_status)
 #undef DO_VFP_cmp
 
 /* Integer to float and float to integer conversions */
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index c864178ad4e..00a6363e1e1 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -2325,6 +2325,45 @@ DO_VFP_2OP(VSQRT, hp, gen_VSQRT_hp)
 DO_VFP_2OP(VSQRT, sp, gen_VSQRT_sp)
 DO_VFP_2OP(VSQRT, dp, gen_VSQRT_dp)
 
+static bool trans_VCMP_hp(DisasContext *s, arg_VCMP_sp *a)
+{
+    TCGv_i32 vd, vm;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    /* Vm/M bits must be zero for the Z variant */
+    if (a->z && a->vm != 0) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vd = tcg_temp_new_i32();
+    vm = tcg_temp_new_i32();
+
+    neon_load_reg32(vd, a->vd);
+    if (a->z) {
+        tcg_gen_movi_i32(vm, 0);
+    } else {
+        neon_load_reg32(vm, a->vm);
+    }
+
+    if (a->e) {
+        gen_helper_vfp_cmpeh(vd, vm, cpu_env);
+    } else {
+        gen_helper_vfp_cmph(vd, vm, cpu_env);
+    }
+
+    tcg_temp_free_i32(vd);
+    tcg_temp_free_i32(vm);
+
+    return true;
+}
+
 static bool trans_VCMP_sp(DisasContext *s, arg_VCMP_sp *a)
 {
     TCGv_i32 vd, vm;
-- 
2.20.1


