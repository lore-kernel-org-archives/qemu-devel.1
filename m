Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44CAC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:02:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1BB2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m8o2F1Rv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1BB2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeDG-00005h-Od
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9s-0003UM-2x
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9o-0002vu-RK
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381938; x=1629917938;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zJT5Kucnv/Guov9o1PhFcaThMA2/aj+Emt1JD78kZkk=;
 b=m8o2F1RvvmiD8u3Jvhly45EDGjJ3wkoP9JYyh17IG40gQzagCA5+SxtI
 kH4JAweuOhg4aXz74V5JVt7TmY4gFYTRkqJyoqda6XYtNCy/tc/e3muvB
 el1+FYlc/Vr42u6PYPIqdatMF0+eHUosK1D0cU2/JfCBNNa9IcA5Whow3
 xZDLxgy/5fHRpEXVobQG1F5s3WCJuDdnNsobj3+98hVj2BQX1ZM5W5mMH
 B7kKsQzMB16ZUS0TVadn/iN3BTJHvK81SPG+dDI8eGRwEg9z09Tohyy1/
 dIMM0deZsQwWrztMbdJgCoYysHtQ/LASwPRyzIGdNKs1C5o9rMy+NOIPk g==;
IronPort-SDR: XhFOmYJh2idDoV9g2i+2JRAGJD4D6hkjkRQPhnkZIEmTNIUokuVWSotVbcdRDXml08ursVyl7g
 FixCKcbKfW8ISrPR6TeVD0ye+pmV0yOqzNlag/xngg9xRkTOSsH2EWlEONyaGWIvFmDcX7umMn
 FyLGcxDQ+KTAZiqRH7bsxNOq4et99OCHfbxL/1uzTvuwBxcS9TRmgGqSLtM4WE8b4rw5CDfoVP
 xoXTgruZ7iBc0WyvRv7GTUgrVOsayPoFwfGKdoApZWUxg1517xBgGBvFwHe+rzEQCBaVZtFyLc
 NqY=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145283"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:55 +0800
IronPort-SDR: x4i9EAnShpL+6YV622A9tLsIelBRoFYFmq6oswZ5gLTRZO0GK7mfKaKoEWTSbqpq3RqM5mVcyd
 rPCS/x0YQTAA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:29 -0700
IronPort-SDR: ot0JO+7Tsxlz7xJ2WfgAowTPaFG4qEbNPaBUMR/+mExt3ofS+J66QbbmTtzzbMCd+fZtdBhLQn
 VrEn3jX1K3SA==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:53 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/18] hw/riscv: Allow creating multiple instances of CLINT
Date: Tue, 25 Aug 2020 11:48:19 -0700
Message-Id: <20200825184836.1282371-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825184836.1282371-1-alistair.francis@wdc.com>
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=49978a6e9=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 14:58:53
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
Cc: Palmer Dabbelt <palmerdabbelt@google.com>, alistair23@gmail.com,
 Anup Patel <anup.patel@wdc.com>, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anup Patel <anup.patel@wdc.com>

We extend CLINT emulation to allow multiple instances of CLINT in
a QEMU RISC-V machine. To achieve this, we remove first HART id
zero assumption from CLINT emulation.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Message-Id: <20200616032229.766089-2-anup.patel@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/sifive_clint.h |  7 ++++---
 hw/riscv/sifive_clint.c         | 20 ++++++++++++--------
 hw/riscv/sifive_e.c             |  2 +-
 hw/riscv/sifive_u.c             |  2 +-
 hw/riscv/spike.c                |  2 +-
 hw/riscv/virt.c                 |  2 +-
 6 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/riscv/sifive_clint.h
index 4a720bfece..9f5fb3d31d 100644
--- a/include/hw/riscv/sifive_clint.h
+++ b/include/hw/riscv/sifive_clint.h
@@ -33,6 +33,7 @@ typedef struct SiFiveCLINTState {
 
     /*< public >*/
     MemoryRegion mmio;
+    uint32_t hartid_base;
     uint32_t num_harts;
     uint32_t sip_base;
     uint32_t timecmp_base;
@@ -40,9 +41,9 @@ typedef struct SiFiveCLINTState {
     uint32_t aperture_size;
 } SiFiveCLINTState;
 
-DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
-    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base,
-    bool provide_rdtime);
+DeviceState *sifive_clint_create(hwaddr addr, hwaddr size,
+    uint32_t hartid_base, uint32_t num_harts, uint32_t sip_base,
+    uint32_t timecmp_base, uint32_t time_base, bool provide_rdtime);
 
 enum {
     SIFIVE_SIP_BASE     = 0x0,
diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index 669c21adc2..15e13d5f7a 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -79,7 +79,7 @@ static uint64_t sifive_clint_read(void *opaque, hwaddr addr, unsigned size)
     SiFiveCLINTState *clint = opaque;
     if (addr >= clint->sip_base &&
         addr < clint->sip_base + (clint->num_harts << 2)) {
-        size_t hartid = (addr - clint->sip_base) >> 2;
+        size_t hartid = clint->hartid_base + ((addr - clint->sip_base) >> 2);
         CPUState *cpu = qemu_get_cpu(hartid);
         CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
         if (!env) {
@@ -92,7 +92,8 @@ static uint64_t sifive_clint_read(void *opaque, hwaddr addr, unsigned size)
         }
     } else if (addr >= clint->timecmp_base &&
         addr < clint->timecmp_base + (clint->num_harts << 3)) {
-        size_t hartid = (addr - clint->timecmp_base) >> 3;
+        size_t hartid = clint->hartid_base +
+            ((addr - clint->timecmp_base) >> 3);
         CPUState *cpu = qemu_get_cpu(hartid);
         CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
         if (!env) {
@@ -129,7 +130,7 @@ static void sifive_clint_write(void *opaque, hwaddr addr, uint64_t value,
 
     if (addr >= clint->sip_base &&
         addr < clint->sip_base + (clint->num_harts << 2)) {
-        size_t hartid = (addr - clint->sip_base) >> 2;
+        size_t hartid = clint->hartid_base + ((addr - clint->sip_base) >> 2);
         CPUState *cpu = qemu_get_cpu(hartid);
         CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
         if (!env) {
@@ -142,7 +143,8 @@ static void sifive_clint_write(void *opaque, hwaddr addr, uint64_t value,
         return;
     } else if (addr >= clint->timecmp_base &&
         addr < clint->timecmp_base + (clint->num_harts << 3)) {
-        size_t hartid = (addr - clint->timecmp_base) >> 3;
+        size_t hartid = clint->hartid_base +
+            ((addr - clint->timecmp_base) >> 3);
         CPUState *cpu = qemu_get_cpu(hartid);
         CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
         if (!env) {
@@ -186,6 +188,7 @@ static const MemoryRegionOps sifive_clint_ops = {
 };
 
 static Property sifive_clint_properties[] = {
+    DEFINE_PROP_UINT32("hartid-base", SiFiveCLINTState, hartid_base, 0),
     DEFINE_PROP_UINT32("num-harts", SiFiveCLINTState, num_harts, 0),
     DEFINE_PROP_UINT32("sip-base", SiFiveCLINTState, sip_base, 0),
     DEFINE_PROP_UINT32("timecmp-base", SiFiveCLINTState, timecmp_base, 0),
@@ -227,13 +230,13 @@ type_init(sifive_clint_register_types)
 /*
  * Create CLINT device.
  */
-DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
-    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base,
-    bool provide_rdtime)
+DeviceState *sifive_clint_create(hwaddr addr, hwaddr size,
+    uint32_t hartid_base, uint32_t num_harts, uint32_t sip_base,
+    uint32_t timecmp_base, uint32_t time_base, bool provide_rdtime)
 {
     int i;
     for (i = 0; i < num_harts; i++) {
-        CPUState *cpu = qemu_get_cpu(i);
+        CPUState *cpu = qemu_get_cpu(hartid_base + i);
         CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
         if (!env) {
             continue;
@@ -247,6 +250,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
     }
 
     DeviceState *dev = qdev_new(TYPE_SIFIVE_CLINT);
+    qdev_prop_set_uint32(dev, "hartid-base", hartid_base);
     qdev_prop_set_uint32(dev, "num-harts", num_harts);
     qdev_prop_set_uint32(dev, "sip-base", sip_base);
     qdev_prop_set_uint32(dev, "timecmp-base", timecmp_base);
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index c8b060486a..01f661d00c 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -211,7 +211,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
         SIFIVE_E_PLIC_CONTEXT_STRIDE,
         memmap[SIFIVE_E_PLIC].size);
     sifive_clint_create(memmap[SIFIVE_E_CLINT].base,
-        memmap[SIFIVE_E_CLINT].size, ms->smp.cpus,
+        memmap[SIFIVE_E_CLINT].size, 0, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
     create_unimplemented_device("riscv.sifive.e.aon",
         memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 18301e6fa5..8d2ee9d026 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -703,7 +703,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
         serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
-        memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
+        memmap[SIFIVE_U_CLINT].size, 0, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->prci), errp)) {
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 13958bdbeb..5d422b4944 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -234,7 +234,7 @@ static void spike_board_init(MachineState *machine)
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
+        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
         false);
 }
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 6e91cf129e..69cfca8501 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -571,7 +571,7 @@ static void virt_machine_init(MachineState *machine)
         VIRT_PLIC_CONTEXT_STRIDE,
         memmap[VIRT_PLIC].size);
     sifive_clint_create(memmap[VIRT_CLINT].base,
-        memmap[VIRT_CLINT].size, smp_cpus,
+        memmap[VIRT_CLINT].size, 0, smp_cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, true);
     sifive_test_create(memmap[VIRT_TEST].base);
 
-- 
2.28.0


