Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F54FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7C4207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAHSVicl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7C4207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLsp-00048f-CY
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiN-0000hy-8M
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiL-0007U0-Am
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id h7so14195419wre.4
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i1cGbjc5Cl94JMQEfZlvF0v5MlNUEPZb+r7dtqjcBUs=;
 b=OAHSViclCH/bbCqb7RZmhzeDW4aZl0yYqSiS6s4ksBZAQvZzx31vqpnDq3QUjawWv8
 Nga9uGXmLo+LrT1jHyNgB8jVWqdRXfsKA5R1nvEKj2ZiPgIWS201U1LgKxjSWxl2jYU+
 kRLA3hd8gbnDyDZaqMf7lwAMahZViJMCgERDbKliOtDadCN3iVUWWBgqIZPoH8sM72c6
 l6JI5pRI9qJuRQoFRFWxVDlcwovvVV318CaMMijSmZ5+32AvS7Oh1c1UYp32oUtt+ov4
 s9EX7c7+pvxK4xSH0p3LxImDkKPT6u4GhD64/46AAQju7iwvyzNrvpH3LbPbcYiHVprG
 LFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=i1cGbjc5Cl94JMQEfZlvF0v5MlNUEPZb+r7dtqjcBUs=;
 b=Pg3gYPNAPVBpWknoPWHjGxwb9GxMCYUoQoIC19e2ob9awXfh35J4F20SNRty87tOT3
 x02StFU3c0JAI/2VYcr6jOk9QoUrLFCSj+N4CDhlz2k0eCfEJRk2zqvFJzbV3mjaJKX5
 9sKFbzF9YqkHEgW8k7BSHcimdMLcxYeUe5zF9qqIoMegVVJjlI/Bzm6YI2Hs2syllGbx
 jNAzgBH2CjQVQE++MoOuoY3X+cwe1ffk80IjsWUzC0MrOUsWzzcSN3obFoh3ohBs8fvq
 ZEIA2HqDMcb7K7WWCmdovTfYpviPIKmmy9cRKzmZeqhW52w5ayKyrNlwEDvLMvwh2Dvh
 ai3g==
X-Gm-Message-State: AOAM530OiApjrin1BAmbH+32u6dCR4t1QVj/YmPxbyXNCuzAuoJviN1p
 30s5GR4oQVrBCRYFgKDXvHQ9Ovqaepc=
X-Google-Smtp-Source: ABdhPJyPltsDh4l7z9svck+1Znqoj9dwZUxxi9Jxc6vzjIl6MJDosdL1OsFUK2DkGllGcrSvcaKGeg==
X-Received: by 2002:a5d:4f09:: with SMTP id c9mr20627407wru.427.1602362615706; 
 Sat, 10 Oct 2020 13:43:35 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/20] target/mips/cpu: Make cp0_count_rate a property
Date: Sat, 10 Oct 2020 22:43:09 +0200
Message-Id: <20201010204319.3119239-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010204319.3119239-1-f4bug@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since not all CPU implementations use a cores use a CP0 timer
at half the frequency of the CPU, make this variable a property.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cpu.h |  9 +++++++++
 target/mips/cpu.c | 19 +++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 085a88e9550..baeceb892ef 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1151,6 +1151,7 @@ struct CPUMIPSState {
 /**
  * MIPSCPU:
  * @env: #CPUMIPSState
+ * @cp0_count_rate: rate at which the coprocessor 0 counter increments
  *
  * A MIPS CPU.
  */
@@ -1161,6 +1162,14 @@ struct MIPSCPU {
 
     CPUNegativeOffsetState neg;
     CPUMIPSState env;
+    /*
+     * The Count register acts as a timer, incrementing at a constant rate,
+     * whether or not an instruction is executed, retired, or any forward
+     * progress is made through the pipeline. The rate at which the counter
+     * increments is implementation dependent, and is a function of the
+     * pipeline clock of the processor, not the issue width of the processor.
+     */
+    unsigned cp0_count_rate;
 };
 
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 46188139b7b..461edfe22b7 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -26,7 +26,7 @@
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
 #include "exec/exec-all.h"
-
+#include "hw/qdev-properties.h"
 
 static void mips_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -135,12 +135,7 @@ static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 }
 
 /*
- * Since commit 6af0bf9c7c3 this model assumes a CPU clocked at 200MHz
- * and a CP0 timer running at half the clock of the CPU (cp0_count_rate = 2).
- *
- * TIMER_FREQ_HZ = CPU_FREQ_HZ / CP0_COUNT_RATE = 200 MHz / 2 = 100 MHz
- *
- * TIMER_PERIOD_NS = 1 / TIMER_FREQ_HZ = 10 ns
+ * Since commit 6af0bf9c7c3 this model assumes a CPU clocked at 200MHz.
  */
 #define CPU_FREQ_HZ_DEFAULT     200000000
 #define CP0_COUNT_RATE_DEFAULT  2
@@ -149,7 +144,7 @@ static void mips_cp0_period_set(MIPSCPU *cpu)
 {
     CPUMIPSState *env = &cpu->env;
 
-    env->cp0_count_ns = muldiv64(NANOSECONDS_PER_SECOND, CP0_COUNT_RATE_DEFAULT,
+    env->cp0_count_ns = muldiv64(NANOSECONDS_PER_SECOND, cpu->cp0_count_rate,
                                  CPU_FREQ_HZ_DEFAULT);
 }
 
@@ -202,6 +197,13 @@ static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
+static Property mips_cpu_properties[] = {
+    /* CP0 timer running at half the clock of the CPU */
+    DEFINE_PROP_UINT32("cp0-count-rate", MIPSCPU, cp0_count_rate,
+                       CP0_COUNT_RATE_DEFAULT),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void mips_cpu_class_init(ObjectClass *c, void *data)
 {
     MIPSCPUClass *mcc = MIPS_CPU_CLASS(c);
@@ -211,6 +213,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_parent_realize(dc, mips_cpu_realizefn,
                                     &mcc->parent_realize);
     device_class_set_parent_reset(dc, mips_cpu_reset, &mcc->parent_reset);
+    device_class_set_props(dc, mips_cpu_properties);
 
     cc->class_by_name = mips_cpu_class_by_name;
     cc->has_work = mips_cpu_has_work;
-- 
2.26.2


