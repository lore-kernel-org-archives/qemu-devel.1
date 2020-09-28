Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9908FC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0839E2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWHMcctr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0839E2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwrB-0004KY-18
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwkl-0004Bw-Rv
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:15:56 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:40268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwkk-0006MJ-2n
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:15:55 -0400
Received: by mail-wr1-x435.google.com with SMTP id j2so2203531wrx.7
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nV1TKIg/u52Ts1S/ZitAGgYmEsezh0Rxsw6P1iX3beg=;
 b=OWHMcctro7BRn0S27C3rvtw5JjfuqgAWWFL79rCa/ApfqceoP6gx7FTasT1meSsidu
 Lqjl4ZqjqUCNCBtZk8eEjgDZd7XADW9E2vFqxMlreJtNcejwSVLeKu2/nV2wgzFCeK9f
 65xfBx+7fbOI3ivuvieusGZ9vYXmFXB3WRhC0CkGY2KKJp2ufx722mlJtKkFrPo83Jc6
 wC1PB/RYf0NnLEv7l1v3HzCYr5ckuX366/30vDuFfeOZy9ysi2l+9nwDfEyqXyR37j9y
 JnR0K5Fcr6VPvFHWJoc835gaLf61N7+qyppCqH+Zh/Z8QtEFR7vk+OlWa3pZYZmRDhc8
 d/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nV1TKIg/u52Ts1S/ZitAGgYmEsezh0Rxsw6P1iX3beg=;
 b=hm9VfD4jvE7cb4G+wCcCr/RAiQl848nKxxLJkGtuJWeuDB21/p5fiRVTOSLHyJClaz
 kJ3YXMdc22GfeAcCUIdh1l0axQxijkb4Fos89tElwRqhTi4oO1Pvbp1w99u8zQvHF28c
 8cwjAGQbv85llsenqK++KEuZ6MKFBvYzSUwFYmJ0HNhtNmv3S/JydO73u3Tu31ABhqSZ
 uKmT9Orv2WFKpkDyqaHzW95QGs43sAMAC2QfeGyduSQSW1Qo0iW4FdjYatOjww+Fe8Te
 eLVkFsMSJ763vrbL/O8wZSocGCo9JmZOKlJZ0MhBMntIcDjith9IQF0eZoWNI8+nihmm
 bp3w==
X-Gm-Message-State: AOAM5318+xdWs+TnFTvA/v99vAhmSa/SU5iinbjuqrCljn2iqjB8Qf4P
 WD4QW03xGtPwBpsX1gVWFjTqgN6Ot2Q=
X-Google-Smtp-Source: ABdhPJw1/M1sUi+8nOmvW6mF+8Pc26aSVdgzrLZA4XyhMHJXpCfxq8cXMMZgQv/qd2aySb6Y0nRykQ==
X-Received: by 2002:a5d:4c4c:: with SMTP id n12mr2756136wrt.162.1601313351531; 
 Mon, 28 Sep 2020 10:15:51 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z67sm464787wme.41.2020.09.28.10.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:15:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/16] target/mips: Keep CP0 counter in sync with the CPU
 frequency
Date: Mon, 28 Sep 2020 19:15:29 +0200
Message-Id: <20200928171539.788309-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 6af0bf9c7c3 the CP0 counter is running at half the
frequency of a 200 MHz CPU: a static 100 MHz value is used.

By using the Clock API we can change the CPU frequency at runtime,
so the CP0 counter might run out of sync with the CPU clock.
Avoid that by using the recently introduced CPUClass::clock_update()
callback. If the CPU clock is dynamically changed, our CP0 counter
will be updated correspondingly.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cpu.h       |  9 +++++++++
 target/mips/cp0_timer.c | 13 ++++++-------
 target/mips/cpu.c       | 20 ++++++++++++++++++++
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7cf7f5239f7..66d6124ae02 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1145,6 +1145,7 @@ struct CPUMIPSState {
     struct MIPSITUState *itu;
     MemoryRegion *itc_tag; /* ITC Configuration Tags */
     target_ulong exception_base; /* ExceptionBase input to the core */
+    unsigned cp0_count_ns; /* CP0_Count clock period (in nanoseconds) */
 };
 
 /**
@@ -1160,6 +1161,14 @@ struct MIPSCPU {
 
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
 
 
diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
index 5194c967ae3..5ec0d6249e9 100644
--- a/target/mips/cp0_timer.c
+++ b/target/mips/cp0_timer.c
@@ -27,8 +27,6 @@
 #include "sysemu/kvm.h"
 #include "internal.h"
 
-#define TIMER_PERIOD 10 /* 10 ns period for 100 Mhz frequency */
-
 /* MIPS R4K timer */
 static void cpu_mips_timer_update(CPUMIPSState *env)
 {
@@ -37,8 +35,8 @@ static void cpu_mips_timer_update(CPUMIPSState *env)
 
     now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     wait = env->CP0_Compare - env->CP0_Count -
-           (uint32_t)(now_ns / TIMER_PERIOD);
-    next_ns = now_ns + (uint64_t)wait * TIMER_PERIOD;
+           (uint32_t)(now_ns / env->cp0_count_ns);
+    next_ns = now_ns + (uint64_t)wait * env->cp0_count_ns;
     timer_mod(env->timer, next_ns);
 }
 
@@ -66,7 +64,7 @@ uint32_t cpu_mips_get_count(CPUMIPSState *env)
             cpu_mips_timer_expire(env);
         }
 
-        return env->CP0_Count + (uint32_t)(now_ns / TIMER_PERIOD);
+        return env->CP0_Count + (uint32_t)(now_ns / env->cp0_count_ns);
     }
 }
 
@@ -82,7 +80,8 @@ void cpu_mips_store_count(CPUMIPSState *env, uint32_t count)
     } else {
         /* Store new count register */
         env->CP0_Count = count -
-               (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / TIMER_PERIOD);
+               (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
+                          env->cp0_count_ns);
         /* Update timer timer */
         cpu_mips_timer_update(env);
     }
@@ -109,7 +108,7 @@ void cpu_mips_stop_count(CPUMIPSState *env)
 {
     /* Store the current value */
     env->CP0_Count += (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
-                                 TIMER_PERIOD);
+                                 env->cp0_count_ns);
 }
 
 static void mips_timer_cb(void *opaque)
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 8d07a293a2e..2f75216c324 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -26,6 +26,7 @@
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
 #include "exec/exec-all.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 
 static void mips_cpu_set_pc(CPUState *cs, vaddr value)
@@ -134,6 +135,22 @@ static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)
     }
 }
 
+static void mips_cp0_period_set(MIPSCPU *cpu)
+{
+    CPUMIPSState *env = &cpu->env;
+
+    /* Recompute CP0's period on clock change */
+    env->cp0_count_ns = cpu->cp0_count_rate * clock_get_ns(CPU(cpu)->clock);
+}
+
+static void mips_cpu_clk_update(CPUState *cs)
+{
+    MIPSCPU *cpu = MIPS_CPU(cs);
+
+    /* Recompute CP0's period on clock change */
+    mips_cp0_period_set(cpu);
+}
+
 static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -148,6 +165,7 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
          */
         clock_set_hz(cs->clock, 200000000);
     }
+    mips_cpu_clk_update(cs);
 
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
@@ -190,6 +208,7 @@ static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
 }
 
 static Property mips_cpu_properties[] = {
+    DEFINE_PROP_UINT32("CP0_Count-rate", MIPSCPU, cp0_count_rate, 2),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -224,6 +243,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     cc->tcg_initialize = mips_tcg_init;
     cc->tlb_fill = mips_cpu_tlb_fill;
 #endif
+    cc->clock_update = mips_cpu_clk_update;
 
     cc->gdb_num_core_regs = 73;
     cc->gdb_stop_before_watchpoint = true;
-- 
2.26.2


