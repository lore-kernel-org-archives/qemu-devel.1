Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C603FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393DC20714
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtOnN8dK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393DC20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTn5O-0001G8-8Z
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmoo-0002RQ-KI
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:22 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:41364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmom-0003n5-Qy
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:22 -0400
Received: by mail-wr1-x432.google.com with SMTP id s9so6559614wro.8
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W1xmpo/5MfSfKCcSEfsWJ/X7/um0Ds1jiMaA9HUX9Bo=;
 b=KtOnN8dKwibawyLQvWOSFczv1Fl0qnl9KUyyzxbdNuCofXQdOKlZ4HoFUramyVFwXT
 NYGTTGzwxvDIvBx8Z5pwEkXVy0i79W+sI072U0gecAa5QBy1pYGzw4MJZ94C/MBDEXhC
 btfczzsVLmv0a+IT4P7cNGZlto0QJmrkFC5bmAxEi/Iker7gR05388smKHyY97rT0thA
 n3Z0xu8oQZt+EVuNa3FK459czh4DGYGst6feyW+N9/yBUSYgKKBYciGpf+8Q1nb5DQsr
 qkxyKawsnI0Cj4vjM2p0f311IXE3wtBBCUrhUE5FbmrPerfX4M8wI7YYxHqIHQWX8tWt
 L6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=W1xmpo/5MfSfKCcSEfsWJ/X7/um0Ds1jiMaA9HUX9Bo=;
 b=LfdZiq2xbkh6EEs3ZERO22MYjUSX+8gk2mQeLbE+A2peAnpZKFgnjWwbxwyFxOj95Z
 IAptEo0H03RiECnpoK3d5/3cv34UrnMJgJb4vhWgNTOb+VRvWknMLCuHFwR01TJGLoAE
 cRxyGw1FW6WLCI2KvfJITMU4iMCociUmMyYQ8T4aEsgaQhRHBXgZutW2REccAYvGB0rq
 0sJDzX9LWskHxImVGbu+D3EkdcWW98hw7ZZzQHK9HQThop02GDUuhGO098bNQJKCmAFa
 Hn+u6ywFlXZfTCZjE0utTduYpDB9KSjm1cmWNzQPdETM5A4vCkVpFNjumeQuBww8PVkK
 ge3Q==
X-Gm-Message-State: AOAM533BqawEvWNzzFPMHXFFd/L7FT/VyIXHK+hbDggiUPzQIvF/7J08
 nmU4P3n4gT+uJaqMNXLqBmTKlE3JEoA=
X-Google-Smtp-Source: ABdhPJxUlnucNXeT2QVKz5gX2ey58V5Rifh27Yz6DKm8DXt+w271KKAGtptfKQ52Tk/5KYkPYijy8w==
X-Received: by 2002:adf:f212:: with SMTP id p18mr10624065wro.386.1602943459329; 
 Sat, 17 Oct 2020 07:04:19 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id a5sm8534104wrt.80.2020.10.17.07.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:04:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/44] target/mips/cpu: Allow the CPU to use dynamic frequencies
Date: Sat, 17 Oct 2020 16:02:19 +0200
Message-Id: <20201017140243.1078718-21-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
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

Use the Clock API and let the CPU object have an input clock.

If no clock is connected, keep using the default frequency of
200 MHz used since the introduction of the 'r4k' machine in
commit 6af0bf9c7c3.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201012095804.3335117-12-f4bug@amsat.org>
---
 target/mips/cpu.h |  4 ++++
 target/mips/cpu.c | 11 +++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index baeceb892ef..062a4ba6225 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -4,6 +4,7 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat-types.h"
+#include "hw/clock.h"
 #include "mips-defs.h"
 
 #define TCG_GUEST_DEFAULT_MO (0)
@@ -1151,6 +1152,8 @@ struct CPUMIPSState {
 /**
  * MIPSCPU:
  * @env: #CPUMIPSState
+ * @clock: this CPU input clock (may be connected
+ *         to an output clock from another device).
  * @cp0_count_rate: rate at which the coprocessor 0 counter increments
  *
  * A MIPS CPU.
@@ -1160,6 +1163,7 @@ struct MIPSCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    Clock *clock;
     CPUNegativeOffsetState neg;
     CPUMIPSState env;
     /*
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 461edfe22b7..2a6f4840e20 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -27,6 +27,7 @@
 #include "sysemu/kvm.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-clock.h"
 
 static void mips_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -144,8 +145,9 @@ static void mips_cp0_period_set(MIPSCPU *cpu)
 {
     CPUMIPSState *env = &cpu->env;
 
-    env->cp0_count_ns = muldiv64(NANOSECONDS_PER_SECOND, cpu->cp0_count_rate,
-                                 CPU_FREQ_HZ_DEFAULT);
+    env->cp0_count_ns = cpu->cp0_count_rate
+                        * clock_get_ns(MIPS_CPU(cpu)->clock);
+    assert(env->cp0_count_ns);
 }
 
 static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
@@ -155,6 +157,10 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    if (!clock_get(cpu->clock)) {
+        /* Initialize the frequency in case the clock remains unconnected. */
+        clock_set_hz(cpu->clock, CPU_FREQ_HZ_DEFAULT);
+    }
     mips_cp0_period_set(cpu);
 
     cpu_exec_realizefn(cs, &local_err);
@@ -178,6 +184,7 @@ static void mips_cpu_initfn(Object *obj)
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(obj);
 
     cpu_set_cpustate_pointers(cpu);
+    cpu->clock = qdev_init_clock_in(DEVICE(obj), "clk-in", NULL, cpu);
     env->cpu_model = mcc->cpu_def;
 }
 
-- 
2.26.2


