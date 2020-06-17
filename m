Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0286C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C1320FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GozekeXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C1320FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfb1-0001jL-1L
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEE-0003Vm-SH
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:14 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:35146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEC-00006U-Qs
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:14 -0400
Received: by mail-qt1-x841.google.com with SMTP id z1so2777492qtn.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w3X/TBVNKMn8EXCp7BpdBrJlJ5hMtFe3cm30uQpq+d0=;
 b=GozekeXFYlWQXc1tMVUl/JqyJ9gj3I7wtlDcVuLTMgtCkIfkbkJSx66XqbZX6HxjoW
 xCTsRkmRhQmNSiIw3YYxP5pPqAP5gYylI4rPfzid97zPwDhcrSSDjgV6zBDuB1AACSad
 VKcvAdjwP2F0UgMR59wTRkSGMBy0FyxyLA4jScOfkz0Wja3f1qpwzzySRiKEij+xlNGE
 NrFf/C+jji+/nRN0A1eQIjENRQiM9lzVkepDE5DczAy/ZsXzlJsyWI7J77ox2rbkHsve
 MLmLE+ww80hJYbPM6Dat6tcyxeuBSOivaHKkjcl8hhuXco23AAsBmU/ec7CceBYzrzdu
 DFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w3X/TBVNKMn8EXCp7BpdBrJlJ5hMtFe3cm30uQpq+d0=;
 b=JOHxrSkGMOjQG91UJH2/5od5vVC4dDwocbEpIAx/JYwSf9XfeYrYqfbjhnTJ47pZLn
 thS57iLHDcW7IBwhUmI7wKh9mAGf5ymGQ3nsAegCnFC5iSLHhaT1Koc9yY+LuNSwoftm
 C91FfuG3Dw5dmxfpAtdZHQ3BRrlotBqc3wkXMcMfpr0SbA7ZphI699tS2xk113VtXyMD
 JkvE0ABvTSUAITHA9agOrRjdeimrqAjljMONOuBkavAOVgBIsrFjYXLG80e2q+u4LBJv
 wEbdZ+BLCk9EXCV1osYVhyoyeS4pINoxqLspAg3sh9RoXUbbXmJLzr/TuTJxUJlXsbwO
 UpWg==
X-Gm-Message-State: AOAM532gqvhQbdmxzKBbFzaSIE+Jz6GwZ0x2Wt57qnLLBFteG7s/e4up
 zblyBsGw17URi2YPueWzTcP2ciGTvBkSjw==
X-Google-Smtp-Source: ABdhPJw7/ieyWQ3tZwJNV12DlE9QivM4axAwt8bvqYtOPk6CdxHncwUi33b7qpMrvkTRJltoS05k+w==
X-Received: by 2002:ac8:5354:: with SMTP id d20mr1105252qto.363.1592427851478; 
 Wed, 17 Jun 2020 14:04:11 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:10 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 38/73] arm: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:01:56 -0400
Message-Id: <20200617210231.4393-39-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x841.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, robert.foley@linaro.org,
 cota@braap.org, qemu-arm@nongnu.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/arm/cpu.c     |  6 +++---
 target/arm/helper.c  | 16 +++++++---------
 target/arm/machine.c |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index df5c019145..2b11e126a8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -75,7 +75,7 @@ static bool arm_cpu_has_work(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
 
     return (cpu->power_state != PSCI_OFF)
-        && cs->interrupt_request &
+        && cpu_interrupt_request(cs) &
         (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
          | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ
          | CPU_INTERRUPT_EXITTB);
@@ -586,7 +586,7 @@ void arm_cpu_update_virq(ARMCPU *cpu)
     bool new_state = (env->cp15.hcr_el2 & HCR_VI) ||
         (env->irq_line_state & CPU_INTERRUPT_VIRQ);
 
-    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VIRQ) != 0)) {
+    if (new_state != ((cpu_interrupt_request(cs) & CPU_INTERRUPT_VIRQ) != 0)) {
         if (new_state) {
             cpu_interrupt(cs, CPU_INTERRUPT_VIRQ);
         } else {
@@ -607,7 +607,7 @@ void arm_cpu_update_vfiq(ARMCPU *cpu)
     bool new_state = (env->cp15.hcr_el2 & HCR_VF) ||
         (env->irq_line_state & CPU_INTERRUPT_VFIQ);
 
-    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VFIQ) != 0)) {
+    if (new_state != ((cpu_interrupt_request(cs) & CPU_INTERRUPT_VFIQ) != 0)) {
         if (new_state) {
             cpu_interrupt(cs, CPU_INTERRUPT_VFIQ);
         } else {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 972a766730..37ac1cabfe 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2079,26 +2079,27 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     CPUState *cs = env_cpu(env);
     uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     uint64_t ret = 0;
+    uint32_t interrupt_request = cpu_interrupt_request(cs);
     bool allow_virt = (arm_current_el(env) == 1 &&
                        (!arm_is_secure_below_el3(env) ||
                         (env->cp15.scr_el3 & SCR_EEL2)));
 
     if (allow_virt && (hcr_el2 & HCR_IMO)) {
-        if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
+        if (interrupt_request & CPU_INTERRUPT_VIRQ) {
             ret |= CPSR_I;
         }
     } else {
-        if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+        if (interrupt_request & CPU_INTERRUPT_HARD) {
             ret |= CPSR_I;
         }
     }
 
     if (allow_virt && (hcr_el2 & HCR_FMO)) {
-        if (cs->interrupt_request & CPU_INTERRUPT_VFIQ) {
+        if (interrupt_request & CPU_INTERRUPT_VFIQ) {
             ret |= CPSR_F;
         }
     } else {
-        if (cs->interrupt_request & CPU_INTERRUPT_FIQ) {
+        if (interrupt_request & CPU_INTERRUPT_FIQ) {
             ret |= CPSR_F;
         }
     }
@@ -9591,10 +9592,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     }
 #endif
 
-    /* Hooks may change global state so BQL should be held, also the
-     * BQL needs to be held for any modification of
-     * cs->interrupt_request.
-     */
+    /* Hooks may change global state so BQL should be held */
     g_assert(qemu_mutex_iothread_locked());
 
     arm_call_pre_el_change_hook(cpu);
@@ -9609,7 +9607,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     arm_call_el_change_hook(cpu);
 
     if (!kvm_enabled()) {
-        cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+        cpu_interrupt_request_or(cs, CPU_INTERRUPT_EXITTB);
     }
 }
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/arm/machine.c b/target/arm/machine.c
index c5a2114f51..42f4368de3 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -713,7 +713,7 @@ static int cpu_post_load(void *opaque, int version_id)
     if (env->irq_line_state == UINT32_MAX) {
         CPUState *cs = CPU(cpu);
 
-        env->irq_line_state = cs->interrupt_request &
+        env->irq_line_state = cpu_interrupt_request(cs) &
             (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ |
              CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VFIQ);
     }
-- 
2.17.1


