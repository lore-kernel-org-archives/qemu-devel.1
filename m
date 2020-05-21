Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3717C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3B7207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnNuNSdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3B7207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbobC-0006Lw-OA
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIj-0003YK-Jn
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:09 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:40814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIi-0006b5-Id
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:09 -0400
Received: by mail-qk1-x742.google.com with SMTP id g185so7846555qke.7
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yGVX5kDKORVWzWyGlj0YwmQls1Q4ENhSP5KQMqWdryo=;
 b=PnNuNSdiscK9zZByW9Q9FHuJsaSawEAEhX4G1K9tT0Il1Yy0rgKX38wsSLAoBrT3l4
 5Sp1OwBk016raKFaypH/c/EwNpdr1gc/zpv3dC3jqbDoMqJ8aYyzq7PusgBRjO9hpmjO
 ieL2HrKusmEbRzD27Mn7G2LCviU6YXjLGJqR7+2RE12+jMWaNVzZX7RTvNAb9ZB2KZHs
 6QAf1qls0gjP5hVPwMoBULz4bjtpd9dJJ4G0TPrOsECwoU/NCJkODQ8G9rSk6p3Qq32W
 T0NeTw+xMcpon/Kvfn7Q2m9lT9u8PW6pEpCcAOf68jKFlxZaLftr2LJ1hGEDlCksE/y5
 y0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yGVX5kDKORVWzWyGlj0YwmQls1Q4ENhSP5KQMqWdryo=;
 b=rUMy1qNK3/5fDq+As+3V6wBJWmJN+U6UuY8HeDGlN2agt9eb9OwkuBxEQmwChskb5V
 +6U0UDZVWmmMEuKBj0uY18fnCf7CLYSt565DsWZJLwQJn2FrIfHpi3azNhiSX/JIe3+s
 JB/z5Zf3osNbt9GtfUShw84djQN2TsQCte0IhHpmwAuagrQSOPrBgfDLFZOhQolKDmqo
 fjnaOfyVgL8eB2lEL7XT4o1cbA9o7FeoG5+vLsRFYLnhBeRTl310aooMyRwGO5xVG9sV
 zTur3GEUU6v7G6UcA+Ikk55nI2UFlNcS997/AwqP/0NLmNc3kARqYgFd4iZndQFcnHXn
 LdzQ==
X-Gm-Message-State: AOAM532GoGJ8p6J+9qv3Mxv6sGerTbX7QIEtMUArfuezl4Fw0Dmh0/vH
 XIFy6ru3MG9MHt2gkU+tI6WJm3fsm31Kuw==
X-Google-Smtp-Source: ABdhPJwVipEc+70rUkpGn5Lvk1kyNeCvJKL4TGjOc8O6aQBBiWdbJZUaOzHQjJWK3C/nZPGprQpbYg==
X-Received: by 2002:a37:46c9:: with SMTP id t192mr7538363qka.3.1590079447298; 
 Thu, 21 May 2020 09:44:07 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:06 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 39/74] arm: convert to cpu_interrupt_request
Date: Thu, 21 May 2020 12:39:36 -0400
Message-Id: <20200521164011.638-40-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, robert.foley@linaro.org,
 richard.henderson@linaro.org, cota@braap.org, qemu-arm@nongnu.org,
 peter.puhov@linaro.org, alex.bennee@linaro.org
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
index dc435a18a1..6c308268a9 100644
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
index a92ae55672..5d018b2d88 100644
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


