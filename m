Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71F8C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B162082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r177u88x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B162082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd6W-0001kt-LW
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0d-0006wN-1R
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0b-0003Gt-NW
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:30 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0b-0003GH-Gy
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:29 -0500
Received: by mail-wm1-x343.google.com with SMTP id s10so16217338wmh.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nUOaAe5msZQVUzw7VQcCZtKtZ1DmxqUChU+tqPOWLLg=;
 b=r177u88xyyUst+RS2vi+GtG/gMWs+ikpfXmekZKgX3PPXgKCmQl17MOymL/ajJAjF3
 0ZyXu/1WUzGXH9w5KDva96wRcplboOEFSvh+wHS+YW5hj7nyf3EP1AiMwzYugm0UsxMX
 dnK6ut8F3pgDSwHCezZKZAag05XRc/AIcCxAKdAzvpALbWVRXuNcb+4wlnBypfiOy/Uy
 VWOGXrFnH5MWa8cb1hnRIahIxczrRrsLQiCIMg8XszI2zQTwj4f2eFxCrT8flLxJmjMI
 uCxgosSIrAOXvOOqTPDDFD0IkLfHITRUKJsSvwfQQKF0VZBgbNe4lIddQK8j31q9uIe7
 2B6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nUOaAe5msZQVUzw7VQcCZtKtZ1DmxqUChU+tqPOWLLg=;
 b=fUnABCvueQthdx5g0aCCbZGbMbkogZknYzTh/hcSm1uVOrfLPnbXKxMDZS2G2H9Ibg
 RBPNsz2stuoyauLcK42PwGYq0RaHcDGlfoWE4K3EFMvUSRkEaqQ9G7RHZ1hCkfO7aflC
 BnIK2c5aLr7PrGVtzEAI3K/vpuoCIBDUp/v0umfD9q8Bitg7KubHba+buODfqsLbojjv
 VwIKhMe0k3X5CeN6MyYF9HKRG04rYq8jGTtpHCy+Prmm2AM8X7ZuSJzaZU/M3KlJ8Y16
 0nTaVGvJLHZUTYUItbNo9Hvpin8+BHZ+2vH2F0QHWJ+2xl3iquBqX9j/u4EH8RJz82ed
 GtCg==
X-Gm-Message-State: APjAAAUo+OOVCxS++rl81l4Vd7CfwUUDjYiLtrEA29G0DHCKap0YlChc
 eRuAuLZ+2RFwo0NR0b10olNxcp8ld/R/Pg==
X-Google-Smtp-Source: APXvYqz7no7TZS5bstypyqzx7fB4UVdkAR+X53hmw1M10IU/DkdFtmcvgXP86Z+b76IkycQVTYhL9g==
X-Received: by 2002:a05:600c:2109:: with SMTP id
 u9mr30905584wml.183.1580741248306; 
 Mon, 03 Feb 2020 06:47:28 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/20] target/arm: Update MSR access for PAN
Date: Mon,  3 Feb 2020 14:47:07 +0000
Message-Id: <20200203144716.32204-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203144716.32204-1-richard.henderson@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For aarch64, there's a dedicated msr (imm, reg) insn.
For aarch32, this is done via msr to cpsr; and writes
from el0 are ignored.

Since v8.0, the CPSR_RESERVED bits have been allocated.
We are not yet implementing ARMv8.0-SSBS or ARMv8.4-DIT,
so retain CPSR_RESERVED for now, so that the bits remain RES0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Move regdef to file scope; merge patch for CPSR_RESERVED:
    do not remove CPSR_SSBS from CPSR_RESERVED yet, mask PAN
    from CPSR if feature not enabled (pmm).
v3: Update for cpsr_valid_mask etc.
---
 target/arm/cpu.h           |  2 ++
 target/arm/internals.h     |  6 ++++++
 target/arm/helper.c        | 21 +++++++++++++++++++++
 target/arm/translate-a64.c | 14 ++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c6dff1d55b..65a0ef8cd6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1186,6 +1186,7 @@ void pmu_init(ARMCPU *cpu);
 #define CPSR_IT_2_7 (0xfc00U)
 #define CPSR_GE (0xfU << 16)
 #define CPSR_IL (1U << 20)
+#define CPSR_PAN (1U << 22)
 #define CPSR_J (1U << 24)
 #define CPSR_IT_0_1 (3U << 25)
 #define CPSR_Q (1U << 27)
@@ -1250,6 +1251,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_BTYPE (3U << 10)
 #define PSTATE_IL (1U << 20)
 #define PSTATE_SS (1U << 21)
+#define PSTATE_PAN (1U << 22)
 #define PSTATE_V (1U << 28)
 #define PSTATE_C (1U << 29)
 #define PSTATE_Z (1U << 30)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 034d98ad53..f6709a2b08 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1081,6 +1081,9 @@ static inline uint32_t aarch32_cpsr_valid_mask(uint64_t features,
     if (isar_feature_jazelle(id)) {
         valid |= CPSR_J;
     }
+    if (isar_feature_aa32_pan(id)) {
+        valid |= CPSR_PAN;
+    }
 
     return valid;
 }
@@ -1093,6 +1096,9 @@ static inline uint32_t aarch64_pstate_valid_mask(const ARMISARegisters *id)
     if (isar_feature_aa64_bti(id)) {
         valid |= PSTATE_BTYPE;
     }
+    if (isar_feature_aa64_pan(id)) {
+        valid |= PSTATE_PAN;
+    }
 
     return valid;
 }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 795ef727d0..90a22921dc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4163,6 +4163,24 @@ static void aa64_daif_write(CPUARMState *env, const ARMCPRegInfo *ri,
     env->daif = value & PSTATE_DAIF;
 }
 
+static uint64_t aa64_pan_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return env->pstate & PSTATE_PAN;
+}
+
+static void aa64_pan_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    env->pstate = (env->pstate & ~PSTATE_PAN) | (value & PSTATE_PAN);
+}
+
+static const ARMCPRegInfo pan_reginfo = {
+    .name = "PAN", .state = ARM_CP_STATE_AA64,
+    .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 2, .opc2 = 3,
+    .type = ARM_CP_NO_RAW, .access = PL1_RW,
+    .readfn = aa64_pan_read, .writefn = aa64_pan_write
+};
+
 static CPAccessResult aa64_cacheop_access(CPUARMState *env,
                                           const ARMCPRegInfo *ri,
                                           bool isread)
@@ -7608,6 +7626,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_lor, cpu)) {
         define_arm_cp_regs(cpu, lor_reginfo);
     }
+    if (cpu_isar_feature(aa64_pan, cpu)) {
+        define_one_arm_cp_reg(cpu, &pan_reginfo);
+    }
 
     if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
         define_arm_cp_regs(cpu, vhe_reginfo);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 49631c2340..d8ba240a15 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1602,6 +1602,20 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
         s->base.is_jmp = DISAS_NEXT;
         break;
 
+    case 0x04: /* PAN */
+        if (!dc_isar_feature(aa64_pan, s) || s->current_el == 0) {
+            goto do_unallocated;
+        }
+        if (crm & 1) {
+            set_pstate_bits(PSTATE_PAN);
+        } else {
+            clear_pstate_bits(PSTATE_PAN);
+        }
+        t1 = tcg_const_i32(s->current_el);
+        gen_helper_rebuild_hflags_a64(cpu_env, t1);
+        tcg_temp_free_i32(t1);
+        break;
+
     case 0x05: /* SPSel */
         if (s->current_el == 0) {
             goto do_unallocated;
-- 
2.20.1


