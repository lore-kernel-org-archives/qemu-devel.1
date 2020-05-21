Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC91C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A0120759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ps0vx/oU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A0120759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbogZ-0004Nj-Qz
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIq-0003rp-GA
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:16 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:40841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIp-0006ca-CM
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:16 -0400
Received: by mail-qt1-x844.google.com with SMTP id c24so5988102qtw.7
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vTZZ/kHNyF+wmPfkKEvG91Ao0Id6+gZs4oPmDCc+3GU=;
 b=ps0vx/oUNcbiF394xVKpKc2d43SnXgW97RR109R+vPJ4bId3k+t4kJQENqluPE9Jf1
 rYI+yDSIz1QU4VHyi4Eq2Gv4YM5C1kOZQ1bIpBZ/DwvBD4qrZgmsxIyKmPDgqh5wyAq+
 qUsApAt0gVLMo+los8hoXGiVyH8Da6CL8WZ0nR1ItgfVtU9jU60HTJcdqgCJCiSatwZH
 MGI0KcJ4/2LmmGZyV3LmsatrZ1WnUhRJtfQfrxn4ScVrJTT4Rxa/Hv0Sa+jTX8hdF0Y/
 Pq6lBXOFibyGR89nx6DSBS5n+6yinTlWRNPu9aYRnfOssSve3MJDVxB9fCjwVZ4oIbJL
 yy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vTZZ/kHNyF+wmPfkKEvG91Ao0Id6+gZs4oPmDCc+3GU=;
 b=ChZV7ukIMHSG9KWb+MhGSIQB2vwiXZW+mGYUck3FAyg0upnjWjq7qLuQeDoEtXy6Ja
 0SgfyhML0eWJ7pvoeHnjgzvyqB5NQjm+a1zhHTeX/XB7epXi8d3K/Vk9Z3MKcWQ9XLBW
 4TcFDSNs91v2n5y+un0dZbRZ9YzG7fKNz9vRAfGa/U7MGznqnMdgHf3pDhMi1M5taBJQ
 QC9iD/hab+AqZsfEXyDCABWduphA47MOtpCUWxqAVu/ilcEPPNfB/O24f26GpawI/618
 QDlZYiOovNLtVu0zkZ+qPHWmrN/jKt48JTIPUQQz3HjwDryws9ANKLwCrfP0EqurRkNh
 GHng==
X-Gm-Message-State: AOAM5309Rb2d/sAGsqOQMVuh/9V1Rrq8aYG3/KLzFW1p8Fs3+qpJS5b4
 k/Vn2o9Pb7W3DOZbA/qCC2xYET66vnVWow==
X-Google-Smtp-Source: ABdhPJzgvbghOskls/22BeTZxyWRtAtdRw/lT7VTUfQeyL2/S6zMj2TNdVGAj8ScXWm/IIn5QcfWgw==
X-Received: by 2002:ac8:2fb9:: with SMTP id l54mr10851777qta.211.1590079454245; 
 Thu, 21 May 2020 09:44:14 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:13 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 44/74] i386/hvf: convert to cpu_request_interrupt
Date: Thu, 21 May 2020 12:39:41 -0400
Message-Id: <20200521164011.638-45-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x844.google.com
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
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


