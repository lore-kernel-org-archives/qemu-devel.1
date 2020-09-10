Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD330C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12183207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lEGwONpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12183207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRKm-0002SQ-TM
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBq-0004e2-GU
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:58 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBn-0002iJ-LX
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762055; x=1631298055;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Kel2qMKcnNbVOpgvW0DmRMyEhGmUQ5qLlm7Vxzj1CxM=;
 b=lEGwONpxgnSd0iPb8SSsKos05y/+eOM3sk/Q0gZoypWQexZ4VxYrAoT7
 rCVg2Q6OttlYvE2ti1dkcOxate49LOQBnIL6ybwG+WuOurWEnqg4ABbvG
 K9jWFnxTXck59oXenXC7oqh403EPLYOhOdwYe/xLztuoUKQoMgeKWNDWZ
 GOF5XPm3ZBVNqH9x0J7uxqP2LzfU1G6f9ySPxMLYrSKEFhPw90XWhkUDx
 Wdm+VDcKq+d+UzsoPsg0Yd5LIixs161JsWMZ54UnZlk92klbX0w83Glw6
 AV+amTqz38hdhpAvlyo2BcU6OHhNgkX4OypwPiIBmHNGYklvb3ToZi7xc A==;
IronPort-SDR: CrG7qIGxonrONaz71Z+IBv+9k6BGDR9dI5+2f1x3ySOm9AnNcKHpJ5LdvF+LveBKo7y4abluWL
 B3LjZAa17AdrUcQIJad4MR71kFhrnqCNwUz9mNmRjyO2lEhXq2DBogAXO7weWoIvI4ovySYlNF
 em9UpOR5y3sA7ErTFTe/9UWb4tNF/a1IMNoq+ZRxyM89TzHh5/J8RHordp6aYZAETYWyVUvGfg
 D9BtlHMXh1TzNDDGnjJmTCY9P9Khf2+iHR0Pu8jLJ39zwmZJZ112GDkImJSuCphJg2RXNIOq0S
 3cg=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979239"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:19 +0800
IronPort-SDR: unxAXy4PZ60OzkCHfcXjc7Lgcd/JAd2bpMh+W2Jan1w4CP+i0bQdY6syotXpnVhRxj2kfoDPs3
 8GLZz9K9k4Pg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:36 -0700
IronPort-SDR: 6qbCYo3hklRd0pE+N+RPz6KNid7FjGEE9sRpivp+UFvIp2y2qryPwn1fZPOjbgyGlpOLBzmdBl
 lGRhrS4Pu2hg==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:19 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 17/30] hw/riscv: clint: Avoid using hard-coded timebase
 frequency
Date: Thu, 10 Sep 2020 11:09:25 -0700
Message-Id: <20200910180938.584205-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910180938.584205-1-alistair.francis@wdc.com>
References: <20200910180938.584205-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=515d47f05=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 14:20:04
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
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
Message-Id: <1598924352-89526-16-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
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
index 9f5fb3d31d..a30be0f3d6 100644
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
index 0d1728a8cd..65daa73675 100644
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
@@ -350,7 +351,8 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
-void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void));
+void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(uint32_t),
+                             uint32_t arg);
 #endif
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 11ebdd1aa8..da6bd295ce 100644
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
index 15e13d5f7a..fa1ddf2ccd 100644
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
index cd7560d8ec..36ccfb2071 100644
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
index 404d5e6918..2bc3992989 100644
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
index 56f5fe73c7..b54a396107 100644
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
index 6fca513ec9..c67a910e48 100644
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
index 005880627e..f4c4111536 100644
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
index 200001de74..26ae347b4a 100644
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
2.28.0


