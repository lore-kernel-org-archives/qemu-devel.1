Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EC5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089562186A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IIdMlYj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089562186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfhQ-0002Yx-8C
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEL-0003m7-Qt
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:21 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:40510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEJ-0000Fo-Ux
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:21 -0400
Received: by mail-qk1-x743.google.com with SMTP id c185so3483114qke.7
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wUXpbIr+0XemeXbqwPqj4NV/3r6BPUZk1p9TVsxJgTg=;
 b=IIdMlYj5yz2hWu4Xu65YBgLkXmLNVn53G+Psk1HqPR8Xtmbp8BKjaVRLHHypSUisy0
 uYX5S8/EIT7N3R/bSAmiOtHIeTD9ziTNjrHil/DKIr3Cf2JoxSKAINsrVS907rcVf7Oe
 iRJ6Sx3RZBkmYlblx77/Vgw9TT2BzwDKOfEolv90yQpzyQKhtRfmLMav5SgBQ6mNHHTn
 kY3EiNTOmi7pwTe9P/SQfl6Q0vPG7yLVVoIq+9vNTg8/dlUSholu7XIKu7eLB/X2imrx
 7o2dmoi9NQl/AsHqRJYbMRnbdz0ouHLvTwzoCIkLNWEQXHP+uxarEJGTfEwokGqaDWRT
 11xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wUXpbIr+0XemeXbqwPqj4NV/3r6BPUZk1p9TVsxJgTg=;
 b=Pjy7bF4tK7ljaLz5AiMdUY9dGQ37WBvqvw8P9AfKgTaL++miAxtbJR6lsVfuuTeP2P
 0ZuiKRxQaW70rBK/hn2+RYPFNiikVL23fXAfK4CCOaRCCo/J6nKBItpzWWS9G4U2Hnmg
 n76evqWDno55ZI3FsO735ou2sHLkxWPFq0JAuDAxBkl4cag9jMSjugyu5tVmY07j0vvR
 Vga0MAolwIX0u2cjrZaXoctRQMKIcsD4jy2LuAZtdGBrCaabIYovLuAsur358aax9NXF
 +PB5kVVr6Qn3mqkckyE/A2WnNVgKeDh+wmOkFoPTM5PMnwsxwGydx7pjkP3VMI7KXPz+
 3mkA==
X-Gm-Message-State: AOAM532CpO3QWfAUfBhLH0OrBB+LuVnv9bNGRacD5iOgTgpfCsfxEDmO
 B1oLnCU3mEjBUTW7DDtqDguKSUbdo9dqFQ==
X-Google-Smtp-Source: ABdhPJzCjfVejbCftVoxD5957JzHtAXgmn73ipiE0ckSMEa0PkW99IKvqhB4pdzt9LJu/LaQxFTEWg==
X-Received: by 2002:a05:620a:14b8:: with SMTP id
 x24mr534431qkj.284.1592427858837; 
 Wed, 17 Jun 2020 14:04:18 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:18 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 43/73] i386/hvf: convert to cpu_request_interrupt
Date: Wed, 17 Jun 2020 17:02:01 -0400
Message-Id: <20200617210231.4393-44-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x743.google.com
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
Cc: robert.foley@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/i386/hvf/hvf.c    |  8 +++++---
 target/i386/hvf/x86hvf.c | 26 +++++++++++++++-----------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index b3bd2285fa..01ee420185 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -262,7 +262,7 @@ static void update_apic_tpr(CPUState *cpu)
 
 static void hvf_handle_interrupt(CPUState * cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
     }
@@ -737,10 +737,12 @@ int hvf_vcpu_exec(CPUState *cpu)
         ret = 0;
         switch (exit_reason) {
         case EXIT_REASON_HLT: {
+            uint32_t interrupt_request = cpu_interrupt_request(cpu);
+
             macvm_set_rip(cpu, rip + ins_len);
-            if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+            if (!((interrupt_request & CPU_INTERRUPT_HARD) &&
                 (env->eflags & IF_MASK))
-                && !(cpu->interrupt_request & CPU_INTERRUPT_NMI) &&
+                && !(interrupt_request & CPU_INTERRUPT_NMI) &&
                 !(idtvec_info & VMCS_IDT_VEC_VALID)) {
                 cpu_halted_set(cpu, 1);
                 ret = EXCP_HLT;
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 8e9b60d0a7..565594bc10 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -352,6 +352,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
 
     uint8_t vector;
     uint64_t intr_type;
+    uint32_t interrupt_request;
     bool have_event = true;
     if (env->interrupt_injected != -1) {
         vector = env->interrupt_injected;
@@ -400,7 +401,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
         };
     }
 
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_NMI) {
+    if (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_NMI) {
         if (!(env->hflags2 & HF2_NMI_MASK) && !(info & VMCS_INTR_VALID)) {
             cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_NMI);
             info = VMCS_INTR_VALID | VMCS_INTR_T_NMI | EXCP02_NMI;
@@ -411,7 +412,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
     }
 
     if (!(env->hflags & HF_INHIBIT_IRQ_MASK) &&
-        (cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
+        (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_HARD) &&
         (env->eflags & IF_MASK) && !(info & VMCS_INTR_VALID)) {
         int line = cpu_get_pic_interrupt(&x86cpu->env);
         cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_HARD);
@@ -420,39 +421,42 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
                   VMCS_INTR_VALID | VMCS_INTR_T_HWINTR);
         }
     }
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_HARD) {
+    if (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_HARD) {
         vmx_set_int_window_exiting(cpu_state);
     }
-    return (cpu_state->interrupt_request
-            & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR));
+    return cpu_interrupt_request(cpu_state) & (CPU_INTERRUPT_INIT |
+                                               CPU_INTERRUPT_TPR);
 }
 
 int hvf_process_events(CPUState *cpu_state)
 {
     X86CPU *cpu = X86_CPU(cpu_state);
     CPUX86State *env = &cpu->env;
+    uint32_t interrupt_request;
 
     env->eflags = rreg(cpu_state->hvf_fd, HV_X86_RFLAGS);
 
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_INIT) {
+    if (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_INIT) {
         hvf_cpu_synchronize_state(cpu_state);
         do_cpu_init(cpu);
     }
 
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_POLL) {
         cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_POLL);
         apic_poll_irq(cpu->apic_state);
     }
-    if (((cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
+
+    interrupt_request = cpu_interrupt_request(cpu_state);
+    if (((interrupt_request & CPU_INTERRUPT_HARD) &&
         (env->eflags & IF_MASK)) ||
-        (cpu_state->interrupt_request & CPU_INTERRUPT_NMI)) {
+        (interrupt_request & CPU_INTERRUPT_NMI)) {
         cpu_halted_set(cpu_state, 0);
     }
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (interrupt_request & CPU_INTERRUPT_SIPI) {
         hvf_cpu_synchronize_state(cpu_state);
         do_cpu_sipi(cpu);
     }
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_TPR) {
+    if (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_TPR) {
         cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_TPR);
         hvf_cpu_synchronize_state(cpu_state);
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
-- 
2.17.1


