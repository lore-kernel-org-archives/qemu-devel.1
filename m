Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D70C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBCD206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uwQRFchy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBCD206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYdT-0001nj-Dx
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLD-0008Bu-EF
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLC-00027i-4r
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:59 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:34265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYLC-00027Y-0k
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:58 -0400
Received: by mail-qt1-x843.google.com with SMTP id 10so6559801qtp.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vTZZ/kHNyF+wmPfkKEvG91Ao0Id6+gZs4oPmDCc+3GU=;
 b=uwQRFchyQb1g3o+w8lemLCYmIwVt8puWVk0h5liY5o2wydx358mCWLulD/hVeNelCF
 26uEiUVpFmFZ4LBHIMW5G445iRcUCZQW6+r9IA34tXNE47GJ3ebfxm5tFWKCh2GNPing
 WPW3+qbJySn187xc+9KJbVeDm5dMBbNK4L/r4J4J4+V30+d55T3HHuGefJM7HWwGavyl
 r5//FMZ2+6h6eL1XapnljW9yVV0Whf7iqVzmnILhu5OHhubaAM8gFoiYfRSYodsVz/lM
 Btvw5V3TC2FfNMFXvZ0QCMSPgw30FNohWp3X1YV2vN84HWHp4MkioObRQUPGUFWqtO6X
 ZkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vTZZ/kHNyF+wmPfkKEvG91Ao0Id6+gZs4oPmDCc+3GU=;
 b=EDDMG7ifpU/YXmBhLkntMBPh9J1agNdYVMSPHeGvc0fxhVtQxbCKeMKOO0OoKgcCje
 JXuYXBESK4c/t3IuEMrzpHJBr6/2G5U2ZdHfM08ydZXVDRDBlSXPdafD5kNdrjiruaDO
 f2zl7qpypOpA2cus8XeaAma8r8lkF/chRrO42N49zO+aC1qW4QJicqj2Dlqty0n18s66
 EYj+XsfX6EK8aQp/K1BFU2ZxU+hQWoJ/SyQF7lhjerp2X0CwI7ytelbmVaMxKbPWt9/p
 APSk5nqIqKx4MxCwoz8AbNgB+Dbi/ZlcS5neZdujgDUdemzFpzYuL4oXRevXFpgWOehh
 EEUg==
X-Gm-Message-State: ANhLgQ2HtZVUlhIp3Trtc7HoAA4g26sUJe8w+BBGbc9i1CpHeLh9TgHP
 hprAwbSMXDqW2PudTqDXQZ48lQlVEdbn4Q==
X-Google-Smtp-Source: ADFU+vutPYvJvqzWPGcWxHAXK9BtwJbVbXKU5evkP4OwBlfkpSxbhV3XXkXLh87nPN2C1+9tK9J8xA==
X-Received: by 2002:ac8:ecc:: with SMTP id w12mr10249837qti.102.1585251514388; 
 Thu, 26 Mar 2020 12:38:34 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:33 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 44/74] i386/hvf: convert to cpu_request_interrupt
Date: Thu, 26 Mar 2020 15:31:26 -0400
Message-Id: <20200326193156.4322-45-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
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
index bf60ce9d66..52ccdf85e4 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -262,7 +262,7 @@ void update_apic_tpr(CPUState *cpu)
 
 static void hvf_handle_interrupt(CPUState * cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
     }
@@ -733,10 +733,12 @@ int hvf_vcpu_exec(CPUState *cpu)
         ret = 0;
         switch (exit_reason) {
         case EXIT_REASON_HLT: {
+            uint32_t interrupt_request = cpu_interrupt_request(cpu);
+
             macvm_set_rip(cpu, rip + ins_len);
-            if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+            if (!((interrupt_request & CPU_INTERRUPT_HARD) &&
                 (EFLAGS(env) & IF_MASK))
-                && !(cpu->interrupt_request & CPU_INTERRUPT_NMI) &&
+                && !(interrupt_request & CPU_INTERRUPT_NMI) &&
                 !(idtvec_info & VMCS_IDT_VEC_VALID)) {
                 cpu_halted_set(cpu, 1);
                 ret = EXCP_HLT;
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 90f1662d0c..892ae0e99a 100644
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
         (EFLAGS(env) & IF_MASK) && !(info & VMCS_INTR_VALID)) {
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
 
     EFLAGS(env) = rreg(cpu_state->hvf_fd, HV_X86_RFLAGS);
 
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
         (EFLAGS(env) & IF_MASK)) ||
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


