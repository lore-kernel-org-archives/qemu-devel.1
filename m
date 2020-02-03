Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07416C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75072082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/jTU8I/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75072082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd5J-0006qF-Tx
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0g-000735-CB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0f-0003K8-31
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:34 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39866)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0e-0003Io-9I
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:33 -0500
Received: by mail-wm1-x344.google.com with SMTP id c84so17460914wme.4
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LdEIwR4tXW88OebyAe9sT02I9h4JxavRP0Kmc9yS4sc=;
 b=K/jTU8I/+Mtqu3Hpko6DMMrKVbygJbXNlwjj48HH/fj7r+F3Yv/Xs5cAYV6w0HErb7
 PVTMGa/Sn9wObfxpI/JvtfwxGxl7z+DPx5CZHAmglE9nOy24DlXueri1IA5lqUqGKvjT
 gTOHfO9H3JNnBoHd/Ir5fFbcRS5RuAOsY7818Eyt/WE+xkrOQWpkKSw/Yg05ib6RpPQu
 Ij4Zz5hCiDqmaPFsPPYXyfTGMZpwY9JVz3H8ToQNi7xTWZ5sgb7kAYiUsr9d7NodNTVm
 BHgxDnGFiUzFD81ExiBQrXdXPfdjOT3SluU/AY5cCRuuRMU3qGne1KGG/BISfRsAp+gE
 /lJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LdEIwR4tXW88OebyAe9sT02I9h4JxavRP0Kmc9yS4sc=;
 b=QVU5KxtbDk1vP47FnbS4OEY8R2nX+hs1K+DSrmwyqkiKMNQaLiA9tkzXrpj9f7rvF2
 RdERLYtGCmYa65e9+rmAzJvFWbmqLWhowHinsxseYKa20DZ3FMa+KpTElg4lUQLDfpYt
 H8ZB0smvvvVjhIKRV6J7NW2hpFEu327xoowHzDgEIBCnvizdmHvhUGZFPbYyIxiZPECM
 0KsF0cLC5p440DjcNruEWY9ZEaPa2Jg01SRPwXTepbhlLCB2zLFEVGx7SNTWhU4sxmLl
 bAxJ6jj1mLBqN2c+h5eGsBjAaKrcqUoldADjxIp3cIgZ0+QQoxaAOyjIzyXr1mHnqBvi
 3+Vg==
X-Gm-Message-State: APjAAAVkLWD99wbthmw4EXuZR2nAUrgoEHET4LD1Yva/WdhyE8TB4Jkp
 sYuYdYqEsq1klfFSBkhYwX1qSIxo7MIV3A==
X-Google-Smtp-Source: APXvYqyXaPYeeTnpk7b2l6yL3WScnDn+N1aChU2GGMfAk+JZopSAbSoDzFS0NhkRQc0eDFEuuzIrWQ==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr30109691wmi.89.1580741251096; 
 Mon, 03 Feb 2020 06:47:31 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/20] target/arm: Set PAN bit as required on exception
 entry
Date: Mon,  3 Feb 2020 14:47:10 +0000
Message-Id: <20200203144716.32204-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203144716.32204-1-richard.henderson@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

The PAN bit is preserved, or set as per SCTLR_ELx.SPAN,
plus several other conditions listed in the ARM ARM.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Tidy preservation of CPSR_PAN in take_aarch32_exception (pmm).
---
 target/arm/helper.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 18e4cbb63c..4c0eb7e7d9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8772,8 +8772,12 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
                                    uint32_t mask, uint32_t offset,
                                    uint32_t newpc)
 {
+    int new_el;
+
     /* Change the CPU state so as to actually take the exception. */
     switch_mode(env, new_mode);
+    new_el = arm_current_el(env);
+
     /*
      * For exceptions taken to AArch32 we must clear the SS bit in both
      * PSTATE and in the old-state value we save to SPSR_<mode>, so zero it now.
@@ -8786,7 +8790,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
     env->uncached_cpsr = (env->uncached_cpsr & ~CPSR_M) | new_mode;
     /* Set new mode endianness */
     env->uncached_cpsr &= ~CPSR_E;
-    if (env->cp15.sctlr_el[arm_current_el(env)] & SCTLR_EE) {
+    if (env->cp15.sctlr_el[new_el] & SCTLR_EE) {
         env->uncached_cpsr |= CPSR_E;
     }
     /* J and IL must always be cleared for exception entry */
@@ -8797,6 +8801,12 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
         env->thumb = (env->cp15.sctlr_el[2] & SCTLR_TE) != 0;
         env->elr_el[2] = env->regs[15];
     } else {
+        /* CPSR.PAN is preserved unless target is EL1 and SCTLR.SPAN == 0. */
+        if (cpu_isar_feature(aa64_pan, env_archcpu(env))
+            && new_el == 1
+            && !(env->cp15.sctlr_el[1] & SCTLR_SPAN)) {
+            env->uncached_cpsr |= CPSR_PAN;
+        }
         /*
          * this is a lie, as there was no c1_sys on V4T/V5, but who cares
          * and we should just guard the thumb mode on V4
@@ -9059,6 +9069,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     unsigned int new_el = env->exception.target_el;
     target_ulong addr = env->cp15.vbar_el[new_el];
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
+    unsigned int old_mode;
     unsigned int cur_el = arm_current_el(env);
 
     /*
@@ -9138,20 +9149,43 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     }
 
     if (is_a64(env)) {
-        env->banked_spsr[aarch64_banked_spsr_index(new_el)] = pstate_read(env);
+        old_mode = pstate_read(env);
         aarch64_save_sp(env, arm_current_el(env));
         env->elr_el[new_el] = env->pc;
     } else {
-        env->banked_spsr[aarch64_banked_spsr_index(new_el)] = cpsr_read(env);
+        old_mode = cpsr_read(env);
         env->elr_el[new_el] = env->regs[15];
 
         aarch64_sync_32_to_64(env);
 
         env->condexec_bits = 0;
     }
+    env->banked_spsr[aarch64_banked_spsr_index(new_el)] = old_mode;
+
     qemu_log_mask(CPU_LOG_INT, "...with ELR 0x%" PRIx64 "\n",
                   env->elr_el[new_el]);
 
+    if (cpu_isar_feature(aa64_pan, cpu)) {
+        /* The value of PSTATE.PAN is normally preserved, except when ... */
+        new_mode |= old_mode & PSTATE_PAN;
+        switch (new_el) {
+        case 2:
+            /* ... the target is EL2 with HCR_EL2.{E2H,TGE} == '11' ...  */
+            if ((arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE))
+                != (HCR_E2H | HCR_TGE)) {
+                break;
+            }
+            /* fall through */
+        case 1:
+            /* ... the target is EL1 ... */
+            /* ... and SCTLR_ELx.SPAN == 0, then set to 1.  */
+            if ((env->cp15.sctlr_el[new_el] & SCTLR_SPAN) == 0) {
+                new_mode |= PSTATE_PAN;
+            }
+            break;
+        }
+    }
+
     pstate_write(env, PSTATE_DAIF | new_mode);
     env->aarch64 = 1;
     aarch64_restore_sp(env, new_el);
-- 
2.20.1


