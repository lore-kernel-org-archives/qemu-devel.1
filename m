Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74098C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5FE2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zjiKsNaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5FE2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADct-0007SX-EZ
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTr-0008Ny-0N
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTo-0002hr-Or
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id a15so8898983wrh.10
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=NMSPmq90eeOSm/NXmzjAinaEm6q3yoUxSbTmiLxpgNs=;
 b=zjiKsNaKbr+B2y/Mg9R+HDtm4qAfBEjUnGMCxikmLEoE+wuuQdulBbvFGE30BpYg1O
 w31PZOYl9hgKHhIAY4VsNupdCQZyMYtcnaQgsC/8ILu+wGh1esShVDLaiziuX5xfO7pr
 6V9S3SerHfnHN8vvkm+O3okA6SnaujzPa7FN5vlpEWg8mV82soJewQKWsUVLb7q6ZjwV
 4BR3dWsO/RAwiysvWLxkguGbPJwe5IykXIMMk3FtBXsgg+PkUQxRsTzFas68XRbMJYiL
 9pitx4zOQFDC7pvmGc0oj9voAMJaPajTiSaU+jMZtEt6VggqKcHRaID7JkW8EHxTXHQr
 XzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NMSPmq90eeOSm/NXmzjAinaEm6q3yoUxSbTmiLxpgNs=;
 b=IhwlsUucJQefJalurl60rM876DJlF0IEpUTbPJ28roAlhy5K5c/akVzeGuNmHHfpBh
 hcBAPaQGpcOlv46EGqwq12DENT3M2j4zVE1xpiR8dBDJ/IM+9MipPVhgWpqUIwmeja4o
 Ue4zCj1NhcDgGmFONJjWrCoe8yKjPznd1gXKNtQyScit1g++Wt5nQSVv2rfOVEXy/rPB
 CggYVJc1sx8EG4bQ2xPfh58lDTV2vPBf65t4GV6vGISlG8B+6LPhtwBq255K3zZHez4M
 jHDCj11EeW5zZLQZCGXuHmKGpgotAFaxIZ03ZOLtjn2B6fgvG2/46zrHDdfTp3bZk/ri
 9TOA==
X-Gm-Message-State: AOAM5337P+pLUcuMggPugvzFoVpTJ8+jCzwJQrZhPN1C5denZh409NPa
 6QkSOp0db59ZdZHHXFlA0xXS9wMCA3NcjpZ2
X-Google-Smtp-Source: ABdhPJyaWLb9vFcMfX/phM8PskDFp72QfKxUMgTM6yzeHw2AuJTIq9ABAG8/oeV90bMRiKbcj3xYRw==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr6107643wrl.250.1598279387457; 
 Mon, 24 Aug 2020 07:29:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b14sm24499091wrj.93.2020.08.24.07.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 07:29:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/22] target/arm: Implement VFP fp16 VCMP
Date: Mon, 24 Aug 2020 15:29:22 +0100
Message-Id: <20200824142934.20850-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824142934.20850-1-peter.maydell@linaro.org>
References: <20200824142934.20850-1-peter.maydell@linaro.org>
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

Implement fp16 version of VCMP.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |  2 ++
 target/arm/vfp.decode          |  2 ++
 target/arm/vfp_helper.c        | 15 +++++++------
 target/arm/translate-vfp.c.inc | 39 ++++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index ab3a9bd5d7e..278b4e47fd2 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -134,8 +134,10 @@ DEF_HELPER_1(vfp_absd, f64, f64)
 DEF_HELPER_2(vfp_sqrth, f32, f32, env)
 DEF_HELPER_2(vfp_sqrts, f32, f32, env)
 DEF_HELPER_2(vfp_sqrtd, f64, f64, env)
+DEF_HELPER_3(vfp_cmph, void, f32, f32, env)
 DEF_HELPER_3(vfp_cmps, void, f32, f32, env)
 DEF_HELPER_3(vfp_cmpd, void, f64, f64, env)
+DEF_HELPER_3(vfp_cmpeh, void, f32, f32, env)
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
index 2f04dcf0582..0297b102c24 100644
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
+DO_VFP_cmp(h, float16, float32, fp_status_f16)
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


