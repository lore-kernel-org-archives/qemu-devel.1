Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBD4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7270F20759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hv5Mpjgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7270F20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboeG-0007q3-KI
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIr-0003vu-Ur
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:17 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30]:46680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIq-0006co-Vn
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:17 -0400
Received: by mail-qv1-xf30.google.com with SMTP id dh1so3333959qvb.13
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tPdNOnecxbiLcmdfOUrNbZfK0O1sIcOj2h20T8/5h6g=;
 b=Hv5MpjgxKmzxDRaA2DFfvRV5Rpmcj9BGOuOOnjTSIfPpY2jJ91RNqmwDNk7A2I/jlP
 zsNDkrASEIbTI7bvU3WypoeLEplAnysfLFCSRi8lTzE5S2UkA7rZWvDPXzv9RoBhSF2x
 DWUYhQZPCqe9x9xfDswkebcHlUD6eTGqyqMe4U9VvHv1Chny9x2smDR+gR+pVAMmcWRy
 uUPs9gISWWdD3ONjNyaMbNwCvVJO+7g7aMNWX9sji/slNVCm/Y50xpsIiRL5GZI/Z3Kc
 q4HD/erjV9D4KQXb8mKMMsqduxYjHLVqgs3Ol4gMVQRlwnRnI5uv9GxabShNyYTvIIpx
 279w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tPdNOnecxbiLcmdfOUrNbZfK0O1sIcOj2h20T8/5h6g=;
 b=JnWDBWOmQGazjBOaU6zCZFv5KlhidunuRmGxsejc2SaV83DPSAwpviTakToAcgYZyp
 O21PidPQKFycvHFzlm/MK+6ibUAEa65TbhT2Dwf78sfbpUSMANdGZVRsJDwnRjbBNA/Y
 EjwdwiJLgfLy2zfzgOxADQG017SoJ5PdSiRCU8iLLa5ZA8EAh2DUa1WW+QHTR7VnRNla
 koqZoT9A27e+1gV5L7yKaeJa3lhtnwqxhVu3958uRAKOCpcDW/5CPvw1TdEy3/bg3sZy
 TwUIYuWBATEJFoNJhnWmrKA+lizKsXJNqTylEEkHpeYcLovRVKs6xibldC0tyacFt076
 9fzg==
X-Gm-Message-State: AOAM5314ZJhFbEBEoZH1eu9CzaOURtr2SYG0+ok8XyQVW+TkL69o2RY4
 YWcqXhzJmQHs920tVSPiybWc0XdGGhTNUg==
X-Google-Smtp-Source: ABdhPJzVe3NqVMCMik4u7ARBkDJQYEcHYgLYOE8jFJRizC5Frs0wSWNII3wxEx6ks6PxrpzKDyiR5A==
X-Received: by 2002:a05:6214:6a7:: with SMTP id
 s7mr11101743qvz.142.1590079455521; 
 Thu, 21 May 2020 09:44:15 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:14 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 45/74] ppc: convert to cpu_interrupt_request
Date: Thu, 21 May 2020 12:39:42 -0400
Message-Id: <20200521164011.638-46-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf30.google.com
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org, cota@braap.org,
 qemu-ppc@nongnu.org, peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: qemu-ppc@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[RF: Minor adjustment for new code in hvf_inject_interrupts]
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/ppc/ppc.c                    |  2 +-
 target/i386/hvf/x86hvf.c        |  1 -
 target/ppc/kvm.c                |  2 +-
 target/ppc/translate_init.inc.c | 14 +++++++-------
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 0e7386ff88..89f92c4a88 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -89,7 +89,7 @@ void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level)
 
     LOG_IRQ("%s: %p n_IRQ %d level %d => pending %08" PRIx32
                 "req %08x\n", __func__, env, n_IRQ, level,
-                env->pending_interrupts, CPU(cpu)->interrupt_request);
+                env->pending_interrupts, cpu_interrupt_request(CPU(cpu)));
 
     if (locked) {
         qemu_mutex_unlock_iothread();
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 892ae0e99a..68175074e4 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -352,7 +352,6 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
 
     uint8_t vector;
     uint64_t intr_type;
-    uint32_t interrupt_request;
     bool have_event = true;
     if (env->interrupt_injected != -1) {
         vector = env->interrupt_injected;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index aae2ef0ad4..084e158c34 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1350,7 +1350,7 @@ static int kvmppc_handle_halt(PowerPCCPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
 
-    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD) && (msr_ee)) {
+    if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) && (msr_ee)) {
         cpu_halted_set(cs, 1);
         cs->exception_index = EXCP_HLT;
     }
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 5838b6f7bc..e61ba39982 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8540,7 +8540,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cpu_halted(cs)) {
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
@@ -8564,7 +8564,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -8702,7 +8702,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cpu_halted(cs)) {
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
@@ -8734,7 +8734,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -8904,7 +8904,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
     if (cpu_halted(cs)) {
         uint64_t psscr = env->spr[SPR_PSSCR];
 
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
 
@@ -8950,7 +8950,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -10655,7 +10655,7 @@ static bool ppc_cpu_has_work(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
-    return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+    return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
 }
 
 static void ppc_cpu_reset(DeviceState *dev)
-- 
2.17.1


