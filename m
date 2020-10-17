Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F80C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DE12072C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpwL15+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DE12072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmvp-0003lD-7I
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmol-0002Mz-AI
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:43718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmoi-0003mm-75
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:18 -0400
Received: by mail-wr1-x436.google.com with SMTP id g12so6554771wrp.10
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gcSFIGw0lHwM+wP/lVQPID0kXeFa2b1r5NkvHKAKJbE=;
 b=MpwL15+QPtIZ6xCu9ADESAqOwHrqfRTIZdDmRTaFxyMJUMPCzJnwXCMdYuYQUH4sRD
 AQYDr0mxi0MePgS2QoZYDvVa8jepqDiH6nYmxJo6DkWQep9nHkjBKkuYk417keIAL+z7
 mGz/oWrNdG0wzGvx38Dds5ERj5vv0noEls5of+E6bepKb1T6kiSnTvQhA/7HHnyw+Gtu
 9YufzxmlUA6fOrM64zj5JIASKnfE3hb/7F1/+BYQdLlUXG1Tx8C1r2seCxfa7xJNlMyx
 kr8jTeN+s0NB9Zwy3mHOv9F/gMGXurpkGoBxrR6hlTAgJ9tRZUdEBcjPOafFJf1pomhs
 l8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gcSFIGw0lHwM+wP/lVQPID0kXeFa2b1r5NkvHKAKJbE=;
 b=m4NXs3qlVhI1A8tCyjnMQubrE7NLBpf5SZF3zZPKLgpY4ApAiIVLqJf++pWBebKhqt
 uFEjEoIBWPzj2wjUVKDXnAvJMJZoX9KLtdAKjBdlngfF9FMsUSXK+gS1W+/SFIF2LY/3
 InY5LCad7AT3PS1wuCGF48ieyu+Dj+r6bO2+yDGzfLkaFTST9mghwNn9xpfuQtmiei94
 0KEer1rGPDgbpZySdr3klIgPwTlqy21jWThCZ36nEMnbKvF8AhCnZhmVVbyR/pblhcwj
 PFayY5cTD91HNUl7aVUARG9t/lUkBJaGjDsDiBR1lRdjnfb9+8O5N4uLCT2mfaveLNs1
 A1kA==
X-Gm-Message-State: AOAM5307XUqyUdYGvs1dVHk4OvZNQaUF1I/hXZp8SNsF6lklJ0e1sDJL
 KdLKZ+dUrPxgqfDjEXl54+f2EtgpvEY=
X-Google-Smtp-Source: ABdhPJzRtyBDoPYqNfT0aWPyzm/wJqvJoIlqEmjN9V64pFenmfVscg+msq3e/MvC4ANacWN21ug0Rw==
X-Received: by 2002:a05:6000:1112:: with SMTP id
 z18mr10086418wrw.3.1602943454712; 
 Sat, 17 Oct 2020 07:04:14 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id t12sm8996734wrm.25.2020.10.17.07.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:04:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/44] target/mips/cpu: Make cp0_count_rate a property
Date: Sat, 17 Oct 2020 16:02:18 +0200
Message-Id: <20201017140243.1078718-20-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since not all CPU implementations use a cores use a CP0 timer
at half the frequency of the CPU, make this variable a property.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201012095804.3335117-11-f4bug@amsat.org>
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


