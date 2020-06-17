Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC7CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982252186A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8T0vdim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982252186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfgr-0001Xp-PF
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEO-0003sy-JJ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:24 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:45364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEL-0000I2-LR
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:24 -0400
Received: by mail-qk1-x743.google.com with SMTP id q8so3451448qkm.12
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=otzI+vAMFZo6kJ+xiIJJ7YKSc6bvWOvFds+iAtOJpdU=;
 b=S8T0vdim/sT9wr1S5Vdr7TX0r1CXRya8L+qIoKGAskCjcFuyN1of8xNkjvDSanleBb
 p+8m3n3GQ9LKqAn5Rg7ZZUXhe89Jrlqlnu1ir2QSoH+oFHY4TheQigQUMzjuE5kgG1AQ
 zjrFI2eMvIQ5tFZJ4PQ2rTcOLnr6el8s3iYTdKwlPR3BtFVbM6yXg6iT0Bnh7lQ30eTV
 0RZ4bmJvkT/BOD0bBUKmOtD/UCtE4Kmvdc+RkwAMtEN+DIl6Uo2/z8K0SOW9lW3a1+yD
 hkdEhzyb4eQXjzI25Me8swEawHHYYdsFFYuu9UWqp8D/NO2RWRprqTEkltdOhh/3/RWr
 7vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=otzI+vAMFZo6kJ+xiIJJ7YKSc6bvWOvFds+iAtOJpdU=;
 b=ZgUt0F0/50ddJYq/GwDRA6tMIHXz7WL8c9lrds+9CXnbaILzMhBc4J7fhCfDc1+8VY
 SLZG1DRGQQc2lHpdVaws/AsoEPM31YjqID4TwHMdItZ1rkoaVaEhNbdZ0wiX84vEENPR
 AwL97kLH1pcjqIdGFcOtLgvfdFEXRuJdGNYi64Ztbky+vEZj0bMeiry92UCzqLEUlaIs
 XxyM5pWkNKBIgrLNWvBzhJpDhlKyf34ov8RSA7Duc4CKE0UKOjBcYUfBt3pJ6aUvsHdY
 uxga3/v0KUOsWdcPK4OVM+DfQGPxPgJocsIgtqdUfycUP2TuzaxePV5bU1IU/YhpQnhw
 vS8Q==
X-Gm-Message-State: AOAM533Nq79T5ssop9AI2ky82qiXtyg5Gg5exPAmJe8kiVoIDz8vcYMr
 mphqWAz9oBx7heL4Ue/tsG39CzxibU+p+Q==
X-Google-Smtp-Source: ABdhPJz2pEF6XfP5oxWKDDHm+CNN+oDD54jtlq9KimO3MMniYQUkAoqEeC4hSOGIu6237ww6MiQ0TQ==
X-Received: by 2002:a37:d246:: with SMTP id f67mr575324qkj.300.1592427860391; 
 Wed, 17 Jun 2020 14:04:20 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:19 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 44/73] ppc: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:02:02 -0400
Message-Id: <20200617210231.4393-45-robert.foley@linaro.org>
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
 Roman Bolshakov <r.bolshakov@yadro.com>, cota@braap.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 Richard Henderson <rth@twiddle.net>, alex.bennee@linaro.org,
 David Gibson <david@gibson.dropbear.id.au>
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
index 565594bc10..53515d0f0e 100644
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
index ac59648541..d06d9ff204 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8541,7 +8541,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cpu_halted(cs)) {
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
@@ -8565,7 +8565,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -8703,7 +8703,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cpu_halted(cs)) {
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
@@ -8735,7 +8735,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -8905,7 +8905,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
     if (cpu_halted(cs)) {
         uint64_t psscr = env->spr[SPR_PSSCR];
 
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
 
@@ -8951,7 +8951,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -10656,7 +10656,7 @@ static bool ppc_cpu_has_work(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
-    return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+    return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
 }
 
 static void ppc_cpu_reset(DeviceState *dev)
-- 
2.17.1


