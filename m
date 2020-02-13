Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C55BC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279632082F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PstuYtpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279632082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Ftk-0003xa-6w
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fh0-0004UW-Er
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgz-0001xO-8P
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:14 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgz-0001wA-1c
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:13 -0500
Received: by mail-wr1-x443.google.com with SMTP id k11so6971582wrd.9
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+ZCL+35F1Ez3bM5+edPRdLJ0LuMquABU+ROVw/U0SwM=;
 b=PstuYtpgEPP12b6vN8PiJ6mYqNJM419/x9HUH3AuAXnhfsDySteIO9PrRZFO3dAzOd
 bHOr4S4djzBikcecXMazQL5LjZn1hLEg2rn6NrFuCXEovvHLaBAXDefx6bLzv364yifj
 GGEjKXbCnqjMkMa8eSNeulhh9oveMuPUaEu4C1Dcv9yRpxu0YaOLI0FPVbU0iRecUbj1
 5vLn1tA4Ef3DfaWlDeDqJV5ZdxYxhNT/bPydWOi/2Uq0t069FQ5JJJXikRM9dnoUaD7l
 NhES/FpM4s6pCLscJxufNHKT5pRSinuZzayPcK4AEXdl0plViDYUkdIZzapj+Wmg4io3
 wI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+ZCL+35F1Ez3bM5+edPRdLJ0LuMquABU+ROVw/U0SwM=;
 b=CM89X0lmGR9rI+VtwIDshu3fapXd1s51KEbqXAJVBlE/RqiMRberu4KFhy5ximkeng
 luFmxByRcpTCKcnbJbg/cGWKlXxf80wbcs8EY38h9TkcdFSJ31F+IFQygOVX3MC9DZPK
 zGU8Q3jcmBGoroEO9UePreJ0JsW/jMv0LFAcHOFKbhSXETmwMm9qlc97THytmrh1dAiu
 OPxJSa3OAsfU27wjwO4mPx6K1I0NZoHBcngbvcVoidjjTIumb32dVOCDWEH+n1aicJT6
 DE93wkWUQwmWxV4Icl119YtE7QDHyQN39/S46+pgBWDu3akq4oufgWyxWxPSuWrSGSvI
 8+2w==
X-Gm-Message-State: APjAAAVDps1SKdxJ92orl1SgtzLv2minRRtj9R/aIFqBVdo9XAxDPMm+
 aH3OYUxW+PJJAj46dWXLqNjGMR+8/SQ=
X-Google-Smtp-Source: APXvYqx8MFq3e5zSpxMldtUrG5JWaJJfxXrTE8vn9hQ4Q00e2vufO+plELhOnA43vQm2EEG3wCwUNQ==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr23349659wru.220.1581604931778; 
 Thu, 13 Feb 2020 06:42:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/46] target/arm: Update MSR access for PAN
Date: Thu, 13 Feb 2020 14:41:19 +0000
Message-Id: <20200213144145.818-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

From: Richard Henderson <richard.henderson@linaro.org>

For aarch64, there's a dedicated msr (imm, reg) insn.
For aarch32, this is done via msr to cpsr.  Writes from el0
are ignored, which is already handled by the CPSR_USER mask.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200208125816.14954-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  2 ++
 target/arm/internals.h     |  6 ++++++
 target/arm/helper.c        | 21 +++++++++++++++++++++
 target/arm/translate-a64.c | 14 ++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c6dff1d55b6..65a0ef8cd6b 100644
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
index 034d98ad538..f6709a2b08d 100644
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
index e4f17c7e839..058fb239592 100644
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
@@ -7599,6 +7617,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_lor, cpu)) {
         define_arm_cp_regs(cpu, lor_reginfo);
     }
+    if (cpu_isar_feature(aa64_pan, cpu)) {
+        define_one_arm_cp_reg(cpu, &pan_reginfo);
+    }
 
     if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
         define_arm_cp_regs(cpu, vhe_reginfo);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 49631c23404..d8ba240a155 100644
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


