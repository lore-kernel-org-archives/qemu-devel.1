Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08CFC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 19:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED6A20759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 19:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ezrnK4qT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED6A20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO4PQ-0002RC-VN
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 15:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kO4OD-0001x5-Ee
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 15:37:17 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:45562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kO4OA-00046e-W1
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 15:37:17 -0400
Received: by mail-lj1-x241.google.com with SMTP id c2so5631880ljj.12
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=GmmUD0Sn+qQi/NhtdKmjr33dcXy4hdjy4T79nkspUT4=;
 b=ezrnK4qTue9wxixp6NT6ZLuhnfE2NkeiA+tMtXG3oK+0BL6NCqMj5MRY6uGVR3kZx9
 rTUDeuUQcql5cLtBojt7+ZOXr55POVPrpgSMjBNUT72UQ15FVSJ22lbwFj5f320KacE5
 BQdr90ESoURIVVTyhVs+pL1GPWvrK86vVHlJWMgSpcbt4E2sRx6gDGtThScH3RJxgeq3
 TvIh4wUjykb6D0LN2c2TBQpbK0Qmc26c2neaiWxWUNDxB9A3wrCeFyCjPCvxg0G6vyXf
 Anx+8Vny11ZH/OywV5zLV5RlLNpwdYoZ3QT/iv8/4HI00rtAS2DWZ3Q4aoSmjYwoizct
 Jmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=GmmUD0Sn+qQi/NhtdKmjr33dcXy4hdjy4T79nkspUT4=;
 b=FpyWHBC6ZWB/WCl42H2RdBma5TT4TY7b5dqrKN0LNW445kzZtJIcrXgpxYCNfe0NdI
 ZJoWdtZuE69DGuAxggUQlxnvhGmLbX2IMCdO1/LwZE3mTTw8Yub71Q4qsJaN/U5MqcsB
 B+Yoq3WIl9GddKaghaDSATYl+NDlw+bd7DnMt82ycLwC+r6M42QvyKmEQFZfalw0m0ZT
 E/l5znehtL7ypz1f1EBmk229kaBpvFF/Tu5mvfDxS0TXQJyrFj5hgkV00Y1HuIUn2Dkv
 ppf8pKAhEpDiuuQg/W07+s5eMKYplaowXMTssnlreI2flRZs4i6lFl0UvvC5mD3POMrE
 EPbg==
X-Gm-Message-State: AOAM532ko7cUeFiXXsjOI7jo67vbdhcXRg/MLWhkPAw4cqAMSciD2SCS
 Gs8h6eTideQo55w7XMpg7gOawA==
X-Google-Smtp-Source: ABdhPJzqaCDqk8egAMGcEAo+AZDrE6ejvRqLSOdBvEzPYksdYyWDGGMuWTiUZC//9c4Y+gCNeAHX/Q==
X-Received: by 2002:a2e:5049:: with SMTP id v9mr2645614ljd.396.1601581028885; 
 Thu, 01 Oct 2020 12:37:08 -0700 (PDT)
Received: from localhost.localdomain (128-68-29-119.broadband.corbina.ru.
 [128.68.29.119])
 by smtp.gmail.com with ESMTPSA id x12sm531139ljd.130.2020.10.01.12.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 12:37:08 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH] hw: wdt: implement sbsa watchdog
Date: Thu,  1 Oct 2020 22:36:59 +0300
Message-Id: <20201001193659.21685-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=maxim.uvarov@linaro.org; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Initial virtual driver matching linux kernel sbsa_gwdt
driver. Driver implements basic functionality and makes
watchdog works on virtual machine and allows to reboot
secure OS. I.e. atf->optee->efi/uboot->kernel. More
information about that device can be found under:
ARM DEN0029B - Server Base System Architecture (SBSA)

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 hw/arm/virt.c                  |  28 ++++
 hw/watchdog/Kconfig            |   5 +
 hw/watchdog/meson.build        |   1 +
 hw/watchdog/sbsa_wdt.c         | 293 +++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h          |   2 +
 include/hw/watchdog/sbsa-wdt.h |  40 +++++
 6 files changed, 369 insertions(+)
 create mode 100644 hw/watchdog/sbsa_wdt.c
 create mode 100644 include/hw/watchdog/sbsa-wdt.h

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index acf9bfbece..516110a4d7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -77,6 +77,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
+#include "hw/watchdog/sbsa-wdt.h"
 #include "qemu/guest-random.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
@@ -745,6 +746,31 @@ static void create_gic(VirtMachineState *vms)
     }
 }
 
+static void create_sbsa_watchdog(VirtMachineState *vms)
+{
+    char *nodename;
+    const char compat[] = "arm,sbsa-gwdt";
+
+    object_initialize_child(OBJECT(vms), "arm,sbsa-gwdt", &vms->watchdog,
+            TYPE_SBSA_WATCHDOG);
+    sysbus_realize(SYS_BUS_DEVICE(&vms->watchdog), &error_fatal);
+    /* contol */
+    sysbus_mmio_map(SYS_BUS_DEVICE(&vms->watchdog), 0, 0x2a440000UL);
+    /* refresh */
+    sysbus_mmio_map(SYS_BUS_DEVICE(&vms->watchdog), 1, 0x2a450000UL);
+    /* dtb */
+    nodename = g_strdup_printf("/watchdog@%" PRIx64, 0x2a440000UL);
+    qemu_fdt_add_subnode(vms->fdt, nodename);
+
+    qemu_fdt_setprop(vms->fdt, nodename, "compatible",
+                     compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+                                 2, 0x2a440000UL, 2, 0x1000,
+                                 2, 0x2a450000UL, 2, 0x1000);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "timeout-sec", 30);
+    g_free(nodename);
+}
+
 static void create_uart(const VirtMachineState *vms, int uart,
                         MemoryRegion *mem, Chardev *chr)
 {
@@ -1913,6 +1939,8 @@ static void machvirt_init(MachineState *machine)
 
     create_gic(vms);
 
+    create_sbsa_watchdog(vms);
+
     fdt_add_pmu_nodes(vms);
 
     create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index 293209b291..8f14fd6a7c 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -17,3 +17,8 @@ config WDT_DIAG288
 
 config WDT_IMX2
     bool
+
+config WDT_SBSA
+   bool
+   default y
+   select PTIMER
diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
index 9b8725e642..0f9dbdc535 100644
--- a/hw/watchdog/meson.build
+++ b/hw/watchdog/meson.build
@@ -5,3 +5,4 @@ softmmu_ss.add(when: 'CONFIG_WDT_IB700', if_true: files('wdt_ib700.c'))
 softmmu_ss.add(when: 'CONFIG_WDT_DIAG288', if_true: files('wdt_diag288.c'))
 softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('wdt_aspeed.c'))
 softmmu_ss.add(when: 'CONFIG_WDT_IMX2', if_true: files('wdt_imx2.c'))
+softmmu_ss.add(when: 'CONFIG_WDT_SBSA', if_true: files('sbsa_wdt.c'))
diff --git a/hw/watchdog/sbsa_wdt.c b/hw/watchdog/sbsa_wdt.c
new file mode 100644
index 0000000000..5eec1a1cbb
--- /dev/null
+++ b/hw/watchdog/sbsa_wdt.c
@@ -0,0 +1,293 @@
+/*
+ * ARM SBSA watchdog emulation
+ *
+ * Copyright (c) 2020 Linaro Limited
+ * Written by Maxim Uvarov
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "sysemu/watchdog.h"
+#include "hw/sysbus.h"
+#include "hw/qdev-properties.h"
+#include "hw/registerfields.h"
+#include "hw/watchdog/sbsa-wdt.h"
+#include "migration/vmstate.h"
+
+#define DEFAULT_TIMEOUT  10 /* seconds */
+#define TIMERFREQ  62500000 /*arch_timer_get_cntfrq()*/
+
+/* SBSA Generic Watchdog register definitions */
+/* refresh frame */
+REG32(SBSA_GWDT_WRR, 0x000)
+
+    /* control frame */
+REG32(SBSA_GWDT_WCS, 0x000)
+    FIELD(SBSA_GWDT_WCS, EN,  0, 1)
+    FIELD(SBSA_GWDT_WCS, WS0, 1, 1)
+    FIELD(SBSA_GWDT_WCS, WS1, 2, 1)
+
+REG32(SBSA_GWDT_WOR, 0x008)
+REG32(SBSA_GWDT_WCV, 0x010)
+
+static inline void log_watchdog(const char *name, uint64_t offset,
+                                uint64_t data, unsigned size)
+{
+    if (0) {
+        struct timeval _now;
+
+        gettimeofday(&_now, NULL);
+        qemu_log("%d@%zu.%06zu:%s: offset 0x%" PRIx64 " "
+                 "data 0x%" PRIx64 " size %u" "\n",
+                qemu_get_thread_id(),
+                (size_t)_now.tv_sec, (size_t)_now.tv_usec,
+                name,
+                offset, data, size);
+    }
+}
+
+static uint64_t sbsa_watchdog_control_read(void *opaque, hwaddr offset,
+        unsigned size)
+{
+    SBSAWatchdog *s = SBSA_WATCHDOG(opaque);
+    uint64_t r;
+
+    switch (offset) {
+    case A_SBSA_GWDT_WCS:
+        r = R_SBSA_GWDT_WCS_WS1_MASK;
+        break;
+    case A_SBSA_GWDT_WOR:
+        r = ptimer_get_count(s->timer) * TIMERFREQ * 2; /* time left */
+        break;
+    case A_SBSA_GWDT_WCV:
+        r = 0; /* TBD */
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "SBSA watchdog control read: bad offset %x\n", (int)offset);
+        r = 0;
+        break;
+    }
+    log_watchdog(__func__, offset, r, size);
+    return r;
+}
+
+static void sbsa_watchdog_control_write(void *opaque, hwaddr offset,
+        uint64_t value, unsigned size)
+{
+    SBSAWatchdog *s = SBSA_WATCHDOG(opaque);
+    int timeout;
+
+    log_watchdog(__func__, offset, value, size);
+    switch (offset) {
+    case A_SBSA_GWDT_WCS:
+        if (value & R_SBSA_GWDT_WCS_EN_MASK) {
+            /* enable watchdog */
+            ptimer_transaction_begin(s->timer);
+            s->cur_tick = ptimer_get_limit(s->timer);
+            ptimer_set_count(s->timer, 0);
+            ptimer_run(s->timer, 0);
+            ptimer_transaction_commit(s->timer);
+            s->enable = 1;
+        } else {
+            /*
+             * never stop to be able to reboot machin,
+             * just lower timeout for faster reboot
+             */
+            ptimer_transaction_begin(s->timer);
+            ptimer_set_limit(s->timer, 2, 1);
+            s->cur_tick = ptimer_get_limit(s->timer);
+            ptimer_set_count(s->timer, 0);
+            ptimer_run(s->timer, 0);
+            ptimer_transaction_commit(s->timer);
+        }
+
+        if (value & R_SBSA_GWDT_WCS_WS0_MASK) {
+            /* ignore, write is not used in linux driver */
+        }
+        if (value & R_SBSA_GWDT_WCS_WS1_MASK) {
+            /* ignore, write is not used in linux driver */
+        }
+        break;
+    case A_SBSA_GWDT_WOR:
+        timeout = value / TIMERFREQ * 2;
+        ptimer_transaction_begin(s->timer);
+        ptimer_set_limit(s->timer, value, timeout);
+        ptimer_transaction_commit(s->timer);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "SBSA watchdog write: bad offset 0x%x\n",
+                (int)offset);
+        break;
+    }
+}
+
+static uint64_t sbsa_watchdog_refresh_read(void *opaque, hwaddr offset,
+        unsigned size)
+{
+    uint64_t r;
+
+    switch (offset) {
+    /* No reads from refresh registeres */
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "SBSA watchdog refresh read: bad offset %x\n", (int)offset);
+        r = 0;
+        break;
+    }
+    log_watchdog(__func__, offset, r, size);
+    return r;
+}
+
+static void sbsa_watchdog_refresh_write(void *opaque, hwaddr offset,
+        uint64_t value, unsigned size)
+{
+    SBSAWatchdog *s = SBSA_WATCHDOG(opaque);
+
+    log_watchdog(__func__, offset, value, size);
+    switch (offset) {
+    case A_SBSA_GWDT_WRR:
+        /*
+         * Writing WRR for an explicit watchdog refresh.
+         * You can write anyting (like 0).
+         */
+        if (s->enable) {
+            ptimer_transaction_begin(s->timer);
+            ptimer_set_count(s->timer, 0);
+            s->cur_tick = ptimer_get_limit(s->timer);
+            ptimer_transaction_commit(s->timer);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "SBSA watchdog refresh write: bad offset 0x%x\n",
+                (int)offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps sbsa_watchdog_control_ops = {
+    .read = sbsa_watchdog_control_read,
+    .write = sbsa_watchdog_control_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    /* byte/halfword accesses are just zero-padded on reads and writes */
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+static const MemoryRegionOps sbsa_watchdog_refresh_ops = {
+    .read = sbsa_watchdog_refresh_read,
+    .write = sbsa_watchdog_refresh_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    /* byte/halfword accesses are just zero-padded on reads and writes */
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+static void sbsa_watchdog_tick(void *opaque)
+{
+    SBSAWatchdog *s = SBSA_WATCHDOG(opaque);
+
+    if (!s->enable) {
+        return;
+    }
+
+    s->cur_tick--;
+
+    if (!s->cur_tick) {
+        watchdog_perform_action();
+    }
+}
+
+static void sbsa_watchdog_reset(DeviceState *dev)
+{
+    SBSAWatchdog *s = SBSA_WATCHDOG(dev);
+
+    s->enable = 0;
+    /* Set the limit and the count */
+    ptimer_transaction_begin(s->timer);
+    ptimer_set_limit(s->timer, DEFAULT_TIMEOUT, 1);
+    s->cur_tick = ptimer_get_limit(s->timer);
+    ptimer_run(s->timer, 0);
+    ptimer_transaction_commit(s->timer);
+}
+
+static void sbsa_watchdog_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    SBSAWatchdog *s = SBSA_WATCHDOG(obj);
+
+    memory_region_init_io(&s->iomem_control, obj, &sbsa_watchdog_control_ops,
+            s, "sbsa-wdt-control", 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem_control);
+    memory_region_init_io(&s->iomem_refresh, obj, &sbsa_watchdog_refresh_ops,
+            s, "sbsa-wdt-refresh", 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem_refresh);
+}
+
+static void sbsa_watchdog_realize(DeviceState *dev, Error **errp)
+{
+    SBSAWatchdog *s = SBSA_WATCHDOG(dev);
+
+    s->timer = ptimer_init(sbsa_watchdog_tick, s,
+                           PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD |
+                           PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT |
+                           PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
+                           PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+
+    ptimer_transaction_begin(s->timer);
+    ptimer_set_freq(s->timer, 1); /* one second */
+    ptimer_transaction_commit(s->timer);
+}
+
+static const VMStateDescription sbsa_watchdog_vmstate = {
+    .name = "sbsa-watchdog",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PTIMER(timer, SBSAWatchdog),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property sbsa_watchdog_properties[] = {
+    DEFINE_PROP_UINT32("arm,sbsa-gwdt", SBSAWatchdog, timeout_sec, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void sbsa_watchdog_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = sbsa_watchdog_realize;
+    dc->vmsd = &sbsa_watchdog_vmstate;
+    dc->reset = sbsa_watchdog_reset;
+    device_class_set_props(dc, sbsa_watchdog_properties);
+}
+
+static const TypeInfo sbsa_watchdog_info = {
+    .name = TYPE_SBSA_WATCHDOG,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SBSAWatchdog),
+    .instance_init = sbsa_watchdog_init,
+    .class_init = sbsa_watchdog_class_init,
+};
+
+static void sbsa_watchdog_register_types(void)
+{
+    type_register_static(&sbsa_watchdog_info);
+}
+
+type_init(sbsa_watchdog_register_types);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index d018a4f297..c0fdd46303 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -37,6 +37,7 @@
 #include "hw/block/flash.h"
 #include "sysemu/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/watchdog/sbsa-wdt.h"
 #include "qom/object.h"
 
 #define NUM_GICV2M_SPIS       64
@@ -163,6 +164,7 @@ struct VirtMachineState {
     DeviceState *gic;
     DeviceState *acpi_dev;
     Notifier powerdown_notifier;
+    SBSAWatchdog watchdog;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/include/hw/watchdog/sbsa-wdt.h b/include/hw/watchdog/sbsa-wdt.h
new file mode 100644
index 0000000000..62d03abae9
--- /dev/null
+++ b/include/hw/watchdog/sbsa-wdt.h
@@ -0,0 +1,40 @@
+/*
+ * ARM SBSA watchdog emulation
+ *
+ * Copyright (c) 2020 Linaro Limited
+ * Written by Maxim Uvarov
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+#ifndef SBSA_WATCHDOG_H
+#define SBSA_WATCHDOG_H
+
+#include "hw/sysbus.h"
+#include "hw/ptimer.h"
+#include "qom/object.h"
+
+#define TYPE_SBSA_WATCHDOG "sbsa-watchdog"
+OBJECT_DECLARE_SIMPLE_TYPE(SBSAWatchdog, SBSA_WATCHDOG)
+
+#define TYPE_LUMINARY_WATCHDOG "sbsa-watchdog"
+
+struct SBSAWatchdog {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem_control;
+    MemoryRegion iomem_refresh;
+    qemu_irq wdogint;
+    uint32_t timeout_sec;
+    bool is_two_stages; /* tbd */
+    struct ptimer_state *timer;
+
+    bool enable;
+    uint64_t cur_tick;
+};
+
+#endif
-- 
2.17.1


