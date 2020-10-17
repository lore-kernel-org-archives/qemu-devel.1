Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC52C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD5B20714
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp7diaAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD5B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTn2m-00074Z-76
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmob-0002J5-OV
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:12 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmoY-0003mL-Vm
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:08 -0400
Received: by mail-wr1-x429.google.com with SMTP id t9so6551558wrq.11
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sUvsBgE8lqeGgpqBP2TiIkm6s4bhzj/3ycAdv64yLQA=;
 b=Pp7diaAgsS4FJ7mRd+CTmuBBGj9+4eZFWSgA7UjfBNWwNRCjejmzgKhcTs4FopZmFI
 q57zf1mmSZB1FSB5rgr0/H6XPskLG6qyKl+CXIrtY5AcAjJCF9MC6bZUsgOoBMFJjrlE
 iSZVbizlXj+CO5aYYq1RJzpPwqUeCnFXTaATcCyZbL/syGmtMhiZcifm5yE4ZLQFxOuN
 CqrqSwHxolrTTsvvwLjUMwYfLcGvXPIO1hYoRMQTQLvyeF53a9zAhQkdRhZSZlGV/R8I
 lSlW5pdVdr8Cy3a6K7xTplCE78lVyJ7cChNNj+d6TTUX/S6i/2YLIkp5qUlqdNbVzpbZ
 SFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sUvsBgE8lqeGgpqBP2TiIkm6s4bhzj/3ycAdv64yLQA=;
 b=MsK1uwc3Q+uu6f4CPeBvsnqerttj94vJaG+S/uW4ipKTIiU+VkbDs6/UvHb+SMkCfp
 1zGHRgNMoCduRQW+Ki64VnnJqRHdIXThUY6COmxXeTYR+TDO5CVol8WRhlH9eeNi9LtV
 SdryBEN3Z88W+DxWjQ8fK1aIooimdmoSbrlmuqHEdYGwkhLYcPtR8zQSd8KHrz8cXCPs
 J4P3waa6uLG7z5dGktB/x0B7+iwnwec6uygeHzCtvDEwOijsRgfZ1T7ijZBjkklQvyW0
 anX7MlWbH+vTj1R/7uRwRORajA71oOsfHyfrIhq1bXacekBDVgbBCRfo/pE++2mJfD+W
 PBBA==
X-Gm-Message-State: AOAM531YYx1eqtglF0kZkAKMxmHF2EWqKMcVEdZkWW8HoKp5MuoNQ3q5
 rEUcaavfbQlLyQdCPdv2j39+aeMC0wA=
X-Google-Smtp-Source: ABdhPJxsueWVIAKlVmpmTj2PWDv7ldxqtapggtb6nMpfS2wwKjTxCzVRsLtXL0K1ofNTwSlCh/Z0Vw==
X-Received: by 2002:adf:84a5:: with SMTP id 34mr10949869wrg.152.1602943445414; 
 Sat, 17 Oct 2020 07:04:05 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id z11sm8559575wrh.70.2020.10.17.07.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:04:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/44] target/mips: Move cp0_count_ns to CPUMIPSState
Date: Sat, 17 Oct 2020 16:02:16 +0200
Message-Id: <20201017140243.1078718-18-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x429.google.com
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

Currently the CP0 timer period is fixed at 10 ns, corresponding
to a fixed CPU frequency of 200 MHz (using half the speed of the
CPU).

In few commits we will be able to use a different CPU frequency.
In preparation, move the cp0_count_ns variable to CPUMIPSState
so we can modify it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20201012095804.3335117-9-f4bug@amsat.org>
---
 target/mips/cpu.h       |  1 +
 target/mips/cp0_timer.c | 23 ++++++-----------------
 target/mips/cpu.c       | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7cf7f5239f7..085a88e9550 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1145,6 +1145,7 @@ struct CPUMIPSState {
     struct MIPSITUState *itu;
     MemoryRegion *itc_tag; /* ITC Configuration Tags */
     target_ulong exception_base; /* ExceptionBase input to the core */
+    uint64_t cp0_count_ns; /* CP0_Count clock period (in nanoseconds) */
 };
 
 /**
diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
index 6fec5fe0ff7..5ec0d6249e9 100644
--- a/target/mips/cp0_timer.c
+++ b/target/mips/cp0_timer.c
@@ -27,18 +27,6 @@
 #include "sysemu/kvm.h"
 #include "internal.h"
 
-/*
- * Since commit 6af0bf9c7c3 this model assumes a CPU clocked at 200MHz
- * and a CP0 timer running at half the clock of the CPU (cp0_count_rate = 2).
- *
- * TIMER_FREQ_HZ = CPU_FREQ_HZ / CP0_COUNT_RATE = 200 MHz / 2 = 100 MHz
- *
- * TIMER_PERIOD_NS = 1 / TIMER_FREQ_HZ = 10 ns
- */
-#define CPU_FREQ_HZ_DEFAULT     200000000
-#define CP0_COUNT_RATE_DEFAULT  2
-#define TIMER_PERIOD            10  /* 1 / (CPU_FREQ_HZ / CP0_COUNT_RATE) */
-
 /* MIPS R4K timer */
 static void cpu_mips_timer_update(CPUMIPSState *env)
 {
@@ -47,8 +35,8 @@ static void cpu_mips_timer_update(CPUMIPSState *env)
 
     now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     wait = env->CP0_Compare - env->CP0_Count -
-           (uint32_t)(now_ns / TIMER_PERIOD);
-    next_ns = now_ns + (uint64_t)wait * TIMER_PERIOD;
+           (uint32_t)(now_ns / env->cp0_count_ns);
+    next_ns = now_ns + (uint64_t)wait * env->cp0_count_ns;
     timer_mod(env->timer, next_ns);
 }
 
@@ -76,7 +64,7 @@ uint32_t cpu_mips_get_count(CPUMIPSState *env)
             cpu_mips_timer_expire(env);
         }
 
-        return env->CP0_Count + (uint32_t)(now_ns / TIMER_PERIOD);
+        return env->CP0_Count + (uint32_t)(now_ns / env->cp0_count_ns);
     }
 }
 
@@ -92,7 +80,8 @@ void cpu_mips_store_count(CPUMIPSState *env, uint32_t count)
     } else {
         /* Store new count register */
         env->CP0_Count = count -
-               (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / TIMER_PERIOD);
+               (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
+                          env->cp0_count_ns);
         /* Update timer timer */
         cpu_mips_timer_update(env);
     }
@@ -119,7 +108,7 @@ void cpu_mips_stop_count(CPUMIPSState *env)
 {
     /* Store the current value */
     env->CP0_Count += (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
-                                 TIMER_PERIOD);
+                                 env->cp0_count_ns);
 }
 
 static void mips_timer_cb(void *opaque)
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index e86cd065483..84b727fefa8 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -134,6 +134,25 @@ static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)
     }
 }
 
+/*
+ * Since commit 6af0bf9c7c3 this model assumes a CPU clocked at 200MHz
+ * and a CP0 timer running at half the clock of the CPU (cp0_count_rate = 2).
+ *
+ * TIMER_FREQ_HZ = CPU_FREQ_HZ / CP0_COUNT_RATE = 200 MHz / 2 = 100 MHz
+ *
+ * TIMER_PERIOD_NS = 1 / TIMER_FREQ_HZ = 10 ns
+ */
+#define CPU_FREQ_HZ_DEFAULT     200000000
+#define CP0_COUNT_RATE_DEFAULT  2
+#define TIMER_PERIOD_DEFAULT    10  /* 1 / (CPU_FREQ_HZ / CP0_COUNT_RATE) */
+
+static void mips_cp0_period_set(MIPSCPU *cpu)
+{
+    CPUMIPSState *env = &cpu->env;
+
+    env->cp0_count_ns = TIMER_PERIOD_DEFAULT;
+}
+
 static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -141,6 +160,8 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    mips_cp0_period_set(cpu);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
-- 
2.26.2


