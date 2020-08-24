Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC50FC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:01:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571AD2074D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W693syUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571AD2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9Hg-000428-7I
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 06:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95u-0005ro-Q4
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95q-0004qE-CO
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id r15so7963123wrp.13
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LAl/MClU8bQ+8K7XrIqILgs8EvZ3f66imhAW3H8aksA=;
 b=W693syUvpL+PtHq97ntok6Q89KZ5UPLzfpJrOwifAIMzug17uJ7ixcH1I00DImmHx5
 7ioJLTn7wJAdM2xzbEovAfmnKO/+ok4ZxgbWDONRdkwkwtlhCezTDlS8t5dYJr7o47Vv
 kOpsxNUUgctDJcm2IbffSKoXkN9KR2dlXS3kqDjXLu6YmvEn46Oj7TCidg+tjTTMHwbP
 a2z23Gt/hXxtOx/QFP7STR90jlDkV4mS7ZNrtP6TI6WUGqrvaVmjY7OzH7mP1uXMf48I
 jTLnxPgIl5qKtQYXyNOnjnMxIA+WPq5S7JIFZGAIeEl93zW3i+1ahnejS8IM16tFvIXH
 bhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LAl/MClU8bQ+8K7XrIqILgs8EvZ3f66imhAW3H8aksA=;
 b=HMftP6r/Mo2fgz+RNOqhxwke4mP2E6MKXBzkfJrs18kHq5+aCsT9ceJrVsj5hdC0cA
 RNWN4KGdFuyfMflptj/00Ri+dktKz0NezCQoZZaPuuxQiOx0o3MeAsjr4bmUwTxC0bSR
 FxOCte30oB+3/rLJw3HazVqgutlBH2lXJcIxXG+qlsj0VX83XzqIcNZ6TOWD5FCobKtW
 htJljbIAV26lziGe/sf+mf7mkNhqco8Lo5ycAVa+0WH/HcSATsZlKRfClJgHRoRn+o/u
 Nm5UWM3HTNdlTt7RPM99BPBiRER6/ntTnMFnNq7qmMP6MDuNV4yZLpiiuX8+5kkxr5wT
 2/lA==
X-Gm-Message-State: AOAM530x1j4spagHmzfb21mW/25aJXBDPU0wnRfvRnRVr1BWhvLxh8mD
 o30B9UxPNqerkjy1y3peWhVlymQPHnLe9K9x
X-Google-Smtp-Source: ABdhPJwy8SxikkvuJvK+IAq9aY3jf7gUSf7cbQleJ+Y1nE4zOr4hKpjUenaX8WGb9cD8bAHG/VxThw==
X-Received: by 2002:a5d:5352:: with SMTP id t18mr4919353wrv.407.1598262524259; 
 Mon, 24 Aug 2020 02:48:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/27] target/arm: Implement FPST_STD_F16 fpstatus
Date: Mon, 24 Aug 2020 10:48:10 +0100
Message-Id: <20200824094811.15439-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Architecturally, Neon FP16 operations use the "standard FPSCR" like
all other Neon operations.  However, this is defined in the Arm ARM
pseudocode as "a fixed value, except that FZ16 (and AHP) follow the
FPSCR bits". In QEMU, the softfloat float_status doesn't include
separate flush-to-zero for FP16 operations, so we must keep separate
fp_status for "Neon non-FP16" and "Neon fp16" operations, in the
same way we do already for the non-Neon "fp_status" vs "fp_status_f16".

Add the extra float_status field to the CPU state structure,
ensure it is correctly initialized and updated on FPSCR writes,
and make fpstatus_ptr(FPST_STD_F16) return a pointer to it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200806104453.30393-4-peter.maydell@linaro.org
---
 target/arm/cpu.h        | 9 ++++++++-
 target/arm/translate.h  | 3 ++-
 target/arm/cpu.c        | 3 +++
 target/arm/vfp_helper.c | 5 +++++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9d2845c1797..ac857bdc2c1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -609,6 +609,8 @@ typedef struct CPUARMState {
          *  fp_status: is the "normal" fp status.
          *  fp_status_fp16: used for half-precision calculations
          *  standard_fp_status : the ARM "Standard FPSCR Value"
+         *  standard_fp_status_fp16 : used for half-precision
+         *       calculations with the ARM "Standard FPSCR Value"
          *
          * Half-precision operations are governed by a separate
          * flush-to-zero control bit in FPSCR:FZ16. We pass a separate
@@ -619,15 +621,20 @@ typedef struct CPUARMState {
          * Neon) which the architecture defines as controlled by the
          * standard FPSCR value rather than the FPSCR.
          *
+         * The "standard FPSCR but for fp16 ops" is needed because
+         * the "standard FPSCR" tracks the FPSCR.FZ16 bit rather than
+         * using a fixed value for it.
+         *
          * To avoid having to transfer exception bits around, we simply
          * say that the FPSCR cumulative exception flags are the logical
-         * OR of the flags in the three fp statuses. This relies on the
+         * OR of the flags in the four fp statuses. This relies on the
          * only thing which needs to read the exception flags being
          * an explicit FPSCR read.
          */
         float_status fp_status;
         float_status fp_status_f16;
         float_status standard_fp_status;
+        float_status standard_fp_status_f16;
 
         /* ZCR_EL[1-3] */
         uint64_t zcr_el[4];
diff --git a/target/arm/translate.h b/target/arm/translate.h
index e3680e65479..6d6d4c0f425 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -436,7 +436,8 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
         offset = offsetof(CPUARMState, vfp.standard_fp_status);
         break;
     case FPST_STD_F16:
-        /* Not yet used or implemented: fall through to assert */
+        offset = offsetof(CPUARMState, vfp.standard_fp_status_f16);
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 111579554fb..6b382fcd60e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -391,12 +391,15 @@ static void arm_cpu_reset(DeviceState *dev)
     set_flush_to_zero(1, &env->vfp.standard_fp_status);
     set_flush_inputs_to_zero(1, &env->vfp.standard_fp_status);
     set_default_nan_mode(1, &env->vfp.standard_fp_status);
+    set_default_nan_mode(1, &env->vfp.standard_fp_status_f16);
     set_float_detect_tininess(float_tininess_before_rounding,
                               &env->vfp.fp_status);
     set_float_detect_tininess(float_tininess_before_rounding,
                               &env->vfp.standard_fp_status);
     set_float_detect_tininess(float_tininess_before_rounding,
                               &env->vfp.fp_status_f16);
+    set_float_detect_tininess(float_tininess_before_rounding,
+                              &env->vfp.standard_fp_status_f16);
 #ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
         kvm_arm_reset_vcpu(cpu);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 60dcd4bf145..64266ece620 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -93,6 +93,8 @@ static uint32_t vfp_get_fpscr_from_host(CPUARMState *env)
     /* FZ16 does not generate an input denormal exception.  */
     i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
           & ~float_flag_input_denormal);
+    i |= (get_float_exception_flags(&env->vfp.standard_fp_status_f16)
+          & ~float_flag_input_denormal);
     return vfp_exceptbits_from_host(i);
 }
 
@@ -124,7 +126,9 @@ static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
     if (changed & FPCR_FZ16) {
         bool ftz_enabled = val & FPCR_FZ16;
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16);
+        set_flush_to_zero(ftz_enabled, &env->vfp.standard_fp_status_f16);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.standard_fp_status_f16);
     }
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
@@ -146,6 +150,7 @@ static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
     set_float_exception_flags(i, &env->vfp.fp_status);
     set_float_exception_flags(0, &env->vfp.fp_status_f16);
     set_float_exception_flags(0, &env->vfp.standard_fp_status);
+    set_float_exception_flags(0, &env->vfp.standard_fp_status_f16);
 }
 
 #else
-- 
2.20.1


