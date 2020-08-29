Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3E0C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E93020707
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxSBSII+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E93020707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC2j5-0003s3-M8
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kC2dG-0001UK-3U; Sat, 29 Aug 2020 11:19:06 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kC2dD-0005GG-Pz; Sat, 29 Aug 2020 11:19:05 -0400
Received: by mail-ot1-x342.google.com with SMTP id a65so1773913otc.8;
 Sat, 29 Aug 2020 08:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=624U7P8Anlw1P84aa7K8bjFHRKvTacCVw6UcCLOjDio=;
 b=sxSBSII+d5ZTBs/rvc8Ac0Vefv4Lu8t2xHWoG8dElZQwQewoR9D6YD1TwVteM9MsiM
 B5MV2NVBWRLlNu9bqwM+EQHeeZt4OsieqxGKL5HRfx6MTf+anZRaMkjCV5gvuQJdAOoD
 jHpi4x+V5tteZvwpofTG7WJF+TJ/CuPP4XOvMgM6p/tPJSp0DpD/xa56mnxl7gyTdk/p
 Weft92mysYpc/gAAULvAXDUt/ViHYf4gWxfewN4cV5It7NDc5mfcANqx8Z76bqotyVVT
 DepFBLIHFaGzW+W9452VmF3I9KomxrWbVxOf7u3rvfdYsB7gBXoTH3iKx9MZ8cmAYbdm
 KLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=624U7P8Anlw1P84aa7K8bjFHRKvTacCVw6UcCLOjDio=;
 b=TPUymYUyS8KGkeD5pjehY2+72ZIg3VGOTGeKXsyCor2Yz8RvSYLwVtJb05KSNkIMig
 h4gkV67qpMfAe93kU8uAMfv706F9Kbci+hH9NJ5iJTsd+EFekbWavvJ6o11otGmneZrl
 GoOMQVsqW7TgiSPMCzF67qBYfT+kTMIyYalBolnoQlQEh8v+UYf9sLUQw/mIQjOBb0G7
 nTL0LCSRf7UPZJbSTCQIk0jLOZwmPkGAEm2YdeSqKPcDQjNRbxjWV1aaWAEd5Jt2dVfj
 /Z4W/uC4Btvp8skguc1yJimOvu51Akh9VIETmO5VAwojogpxJVn8bfSQK4iPywwecKvA
 u06w==
X-Gm-Message-State: AOAM531nAxK8d9WF50qE2DV8sQUnUAHg2yisHPfaSG4qPerCki+kAsCw
 TgbTY45RO95+k5JMVg+wANQnkib8CrM=
X-Google-Smtp-Source: ABdhPJwZW42XYNnGbdHjQRMLHqW18IBkIM4H+HP2ijnK//beAkTF7IhoiMambAy86W/6P/vujKRZGQ==
X-Received: by 2002:a9d:6e8b:: with SMTP id a11mr2428802otr.363.1598714342374; 
 Sat, 29 Aug 2020 08:19:02 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id f50sm58181otf.47.2020.08.29.08.18.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Aug 2020 08:19:02 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 15/16] hw/riscv: clint: Avoid using hard-coded timebase
 frequency
Date: Sat, 29 Aug 2020 23:17:39 +0800
Message-Id: <1598714261-8320-16-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
References: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=bmeng.cn@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

At present the CLINT timestamp is using a hard-coded timebase
frequency value SIFIVE_CLINT_TIMEBASE_FREQ. This might not be
true for all boards.

Add a new 'timebase-freq' property to the CLINT device, and
update various functions to accept this as a parameter.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

(no changes since v1)

 include/hw/riscv/sifive_clint.h |  4 +++-
 target/riscv/cpu.h              |  6 ++++--
 hw/riscv/microchip_pfsoc.c      |  6 +++++-
 hw/riscv/sifive_clint.c         | 26 +++++++++++++++-----------
 hw/riscv/sifive_e.c             |  3 ++-
 hw/riscv/sifive_u.c             |  3 ++-
 hw/riscv/spike.c                |  3 ++-
 hw/riscv/virt.c                 |  3 ++-
 target/riscv/cpu_helper.c       |  4 +++-
 target/riscv/csr.c              |  4 ++--
 10 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/riscv/sifive_clint.h
index 9f5fb3d..a30be0f 100644
--- a/include/hw/riscv/sifive_clint.h
+++ b/include/hw/riscv/sifive_clint.h
@@ -39,11 +39,13 @@ typedef struct SiFiveCLINTState {
     uint32_t timecmp_base;
     uint32_t time_base;
     uint32_t aperture_size;
+    uint32_t timebase_freq;
 } SiFiveCLINTState;
 
 DeviceState *sifive_clint_create(hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts, uint32_t sip_base,
-    uint32_t timecmp_base, uint32_t time_base, bool provide_rdtime);
+    uint32_t timecmp_base, uint32_t time_base, uint32_t timebase_freq,
+    bool provide_rdtime);
 
 enum {
     SIFIVE_SIP_BASE     = 0x0,
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index dc350f0..a003d83 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -219,7 +219,8 @@ struct CPURISCVState {
     pmp_table_t pmp_state;
 
     /* machine specific rdtime callback */
-    uint64_t (*rdtime_fn)(void);
+    uint64_t (*rdtime_fn)(uint32_t);
+    uint32_t rdtime_fn_arg;
 
     /* True if in debugger mode.  */
     bool debugger;
@@ -349,7 +350,8 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
-void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void));
+void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(uint32_t),
+                             uint32_t arg);
 #endif
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 11ebdd1..da6bd29 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -60,6 +60,9 @@
 #define BIOS_FILENAME   "hss.bin"
 #define RESET_VECTOR    0x20220000
 
+/* CLINT timebase frequency */
+#define CLINT_TIMEBASE_FREQ 1000000
+
 /* GEM version */
 #define GEM_REVISION    0x0107010c
 
@@ -187,7 +190,8 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     /* CLINT */
     sifive_clint_create(memmap[MICROCHIP_PFSOC_CLINT].base,
         memmap[MICROCHIP_PFSOC_CLINT].size, 0, ms->smp.cpus,
-        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
+        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
+        CLINT_TIMEBASE_FREQ, false);
 
     /* L2 cache controller */
     create_unimplemented_device("microchip.pfsoc.l2cc",
diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index 15e13d5..fa1ddf2 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -29,22 +29,23 @@
 #include "hw/riscv/sifive_clint.h"
 #include "qemu/timer.h"
 
-static uint64_t cpu_riscv_read_rtc(void)
+static uint64_t cpu_riscv_read_rtc(uint32_t timebase_freq)
 {
     return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-        SIFIVE_CLINT_TIMEBASE_FREQ, NANOSECONDS_PER_SECOND);
+        timebase_freq, NANOSECONDS_PER_SECOND);
 }
 
 /*
  * Called when timecmp is written to update the QEMU timer or immediately
  * trigger timer interrupt if mtimecmp <= current timer value.
  */
-static void sifive_clint_write_timecmp(RISCVCPU *cpu, uint64_t value)
+static void sifive_clint_write_timecmp(RISCVCPU *cpu, uint64_t value,
+                                       uint32_t timebase_freq)
 {
     uint64_t next;
     uint64_t diff;
 
-    uint64_t rtc_r = cpu_riscv_read_rtc();
+    uint64_t rtc_r = cpu_riscv_read_rtc(timebase_freq);
 
     cpu->env.timecmp = value;
     if (cpu->env.timecmp <= rtc_r) {
@@ -59,7 +60,7 @@ static void sifive_clint_write_timecmp(RISCVCPU *cpu, uint64_t value)
     diff = cpu->env.timecmp - rtc_r;
     /* back to ns (note args switched in muldiv64) */
     next = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-        muldiv64(diff, NANOSECONDS_PER_SECOND, SIFIVE_CLINT_TIMEBASE_FREQ);
+        muldiv64(diff, NANOSECONDS_PER_SECOND, timebase_freq);
     timer_mod(cpu->env.timer, next);
 }
 
@@ -112,10 +113,10 @@ static uint64_t sifive_clint_read(void *opaque, hwaddr addr, unsigned size)
         }
     } else if (addr == clint->time_base) {
         /* time_lo */
-        return cpu_riscv_read_rtc() & 0xFFFFFFFF;
+        return cpu_riscv_read_rtc(clint->timebase_freq) & 0xFFFFFFFF;
     } else if (addr == clint->time_base + 4) {
         /* time_hi */
-        return (cpu_riscv_read_rtc() >> 32) & 0xFFFFFFFF;
+        return (cpu_riscv_read_rtc(clint->timebase_freq) >> 32) & 0xFFFFFFFF;
     }
 
     error_report("clint: invalid read: %08x", (uint32_t)addr);
@@ -153,13 +154,13 @@ static void sifive_clint_write(void *opaque, hwaddr addr, uint64_t value,
             /* timecmp_lo */
             uint64_t timecmp_hi = env->timecmp >> 32;
             sifive_clint_write_timecmp(RISCV_CPU(cpu),
-                timecmp_hi << 32 | (value & 0xFFFFFFFF));
+                timecmp_hi << 32 | (value & 0xFFFFFFFF), clint->timebase_freq);
             return;
         } else if ((addr & 0x7) == 4) {
             /* timecmp_hi */
             uint64_t timecmp_lo = env->timecmp;
             sifive_clint_write_timecmp(RISCV_CPU(cpu),
-                value << 32 | (timecmp_lo & 0xFFFFFFFF));
+                value << 32 | (timecmp_lo & 0xFFFFFFFF), clint->timebase_freq);
         } else {
             error_report("clint: invalid timecmp write: %08x", (uint32_t)addr);
         }
@@ -194,6 +195,7 @@ static Property sifive_clint_properties[] = {
     DEFINE_PROP_UINT32("timecmp-base", SiFiveCLINTState, timecmp_base, 0),
     DEFINE_PROP_UINT32("time-base", SiFiveCLINTState, time_base, 0),
     DEFINE_PROP_UINT32("aperture-size", SiFiveCLINTState, aperture_size, 0),
+    DEFINE_PROP_UINT32("timebase-freq", SiFiveCLINTState, timebase_freq, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -232,7 +234,8 @@ type_init(sifive_clint_register_types)
  */
 DeviceState *sifive_clint_create(hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts, uint32_t sip_base,
-    uint32_t timecmp_base, uint32_t time_base, bool provide_rdtime)
+    uint32_t timecmp_base, uint32_t time_base, uint32_t timebase_freq,
+    bool provide_rdtime)
 {
     int i;
     for (i = 0; i < num_harts; i++) {
@@ -242,7 +245,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr size,
             continue;
         }
         if (provide_rdtime) {
-            riscv_cpu_set_rdtime_fn(env, cpu_riscv_read_rtc);
+            riscv_cpu_set_rdtime_fn(env, cpu_riscv_read_rtc, timebase_freq);
         }
         env->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                   &sifive_clint_timer_cb, cpu);
@@ -256,6 +259,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr size,
     qdev_prop_set_uint32(dev, "timecmp-base", timecmp_base);
     qdev_prop_set_uint32(dev, "time-base", time_base);
     qdev_prop_set_uint32(dev, "aperture-size", size);
+    qdev_prop_set_uint32(dev, "timebase-freq", timebase_freq);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     return dev;
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index cd7560d..36ccfb2 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -213,7 +213,8 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_E_PLIC].size);
     sifive_clint_create(memmap[SIFIVE_E_CLINT].base,
         memmap[SIFIVE_E_CLINT].size, 0, ms->smp.cpus,
-        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
+        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
+        SIFIVE_CLINT_TIMEBASE_FREQ, false);
     create_unimplemented_device("riscv.sifive.e.aon",
         memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
     sifive_e_prci_create(memmap[SIFIVE_E_PRCI].base);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 404d5e6..2bc3992 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -706,7 +706,8 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
         serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
         memmap[SIFIVE_U_CLINT].size, 0, ms->smp.cpus,
-        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
+        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
+        SIFIVE_CLINT_TIMEBASE_FREQ, false);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->prci), errp)) {
         return;
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 56f5fe7..b54a396 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -242,7 +242,8 @@ static void spike_board_init(MachineState *machine)
         sifive_clint_create(
             memmap[SPIKE_CLINT].base + i * memmap[SPIKE_CLINT].size,
             memmap[SPIKE_CLINT].size, base_hartid, hart_count,
-            SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
+            SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
+            SIFIVE_CLINT_TIMEBASE_FREQ, false);
     }
 
     /* register system main memory (actual RAM) */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 6fca513..c67a910 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -541,7 +541,8 @@ static void virt_machine_init(MachineState *machine)
         sifive_clint_create(
             memmap[VIRT_CLINT].base + i * memmap[VIRT_CLINT].size,
             memmap[VIRT_CLINT].size, base_hartid, hart_count,
-            SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, true);
+            SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
+            SIFIVE_CLINT_TIMEBASE_FREQ, true);
 
         /* Per-socket PLIC hart topology configuration string */
         plic_hart_config_len =
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dc7ae3e..b0b91d4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -276,9 +276,11 @@ uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
     return old;
 }
 
-void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void))
+void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(uint32_t),
+                             uint32_t arg)
 {
     env->rdtime_fn = fn;
+    env->rdtime_fn_arg = arg;
 }
 
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 200001d..26ae347 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -351,7 +351,7 @@ static int read_time(CPURISCVState *env, int csrno, target_ulong *val)
         return -RISCV_EXCP_ILLEGAL_INST;
     }
 
-    *val = env->rdtime_fn() + delta;
+    *val = env->rdtime_fn(env->rdtime_fn_arg) + delta;
     return 0;
 }
 
@@ -364,7 +364,7 @@ static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
         return -RISCV_EXCP_ILLEGAL_INST;
     }
 
-    *val = (env->rdtime_fn() + delta) >> 32;
+    *val = (env->rdtime_fn(env->rdtime_fn_arg) + delta) >> 32;
     return 0;
 }
 #endif
-- 
2.7.4


