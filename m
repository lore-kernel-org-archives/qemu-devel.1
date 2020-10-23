Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94362C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1AE20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6KAuzsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1AE20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0Kn-0004OP-OK
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kVzV6-0007C0-UE
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:01:09 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:34412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kVzUz-0005wK-SL
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:01:08 -0400
Received: by mail-qv1-xf44.google.com with SMTP id g13so927906qvu.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+r+GOfLms2WLPkHGMsCvlnUXGoGlTyAMI6qGSX5YZEI=;
 b=R6KAuzsu5duk9hV4EtSsVOd9K0PPKHkfcFrTmnCM6QAQkTV6JmxP9yzK6JgB1YaZcV
 tx1ktgrdvqQ2W1qzNijZtCFCRmVSamE3YFxoObg/T1cAoDsB8Zw5TlarVIvoQ8fJXT62
 ThHemGDrgYtoGESMLd92XyQ1L3O6mO8eeZSXQ+XdvspwECZL62ehebiOTZa6mSczkBbu
 4JRp0Mu84OeSSeauGWcYXt/FiTdzYTdxNhj+EfRys1jt9iuPea96Z3nhgaOAHhLESexp
 NIQtEduP1AnQtM/AQWwUeRw5zhb1wfWiMCxZn23Otd1eoTCdWKdeaENFeY6foBPHQCcj
 GjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+r+GOfLms2WLPkHGMsCvlnUXGoGlTyAMI6qGSX5YZEI=;
 b=NtlfDK5Z2AKlrWjuLjCuXLUMBIt9o/YbJAvAYQsg2i/bAnVQ6NHJ+g8+neJgFZZJHM
 YfkkUILf7w0UYJoscA6pOOB70ZVJetGNWfnOHWqP46cSNgIgO7/2tk2Tjy0qHfDpaDTV
 y9iUZ9dWpLk3tus2AyarhQR/5XazRS8ossPizbpdqyhgDrinNWVGC2H2/EHvh9P+3BG6
 2Tcu4UyjydgTmpaFE++7HubvIgoQyqjTLgnIrYio3vuULry36qp1XlLtRdn4n2bhfJn8
 1BKTi8uzU1Cy4C2tAflAvyphw9tw5Ix/8+gYbtiFEHKT+BT6WS6znT6faTqAby+kkuEL
 rMOg==
X-Gm-Message-State: AOAM530mVuvJDA0OMs19kVpHn9dqJEwMjYsrIYWR5Ayhn+uWBd2NIaAU
 +mHjZP7KYZSvQOinPgh7iLNlgw==
X-Google-Smtp-Source: ABdhPJyCD+9NVTdwPX/A/IV+OwKqEnemo1hv9ef5qai63guas/6OCu1gqPBkKiLuNWwgxfXedDKBaw==
X-Received: by 2002:a0c:f284:: with SMTP id k4mr2853826qvl.27.1603468860443;
 Fri, 23 Oct 2020 09:01:00 -0700 (PDT)
Received: from localhost.localdomain
 (stsvon1503w-lp130-06-174-91-97-36.dsl.bell.ca. [174.91.97.36])
 by smtp.googlemail.com with ESMTPSA id k16sm1144957qtu.45.2020.10.23.09.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 09:01:00 -0700 (PDT)
From: Shashi Mallela <shashi.mallela@linaro.org>
To: peter.maydell@linaro.org,
	leif@nuviainc.com,
	rad@semihalf.com
Subject: [PATCH v7 1/2] hw/watchdog: Implement SBSA watchdog device
Date: Fri, 23 Oct 2020 12:00:56 -0400
Message-Id: <20201023160057.21543-2-shashi.mallela@linaro.org>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201023160057.21543-1-shashi.mallela@linaro.org>
References: <20201023160057.21543-1-shashi.mallela@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f44;
 envelope-from=shashi.mallela@linaro.org; helo=mail-qv1-xf44.google.com
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Generic watchdog device model implementation as per ARM SBSA v6.0

Signed-off-by: Shashi Mallela <shashi.mallela@linaro.org>
---
 hw/arm/Kconfig                  |   1 +
 hw/watchdog/Kconfig             |   3 +
 hw/watchdog/meson.build         |   1 +
 hw/watchdog/sbsa_gwdt.c         | 304 ++++++++++++++++++++++++++++++++
 include/hw/watchdog/sbsa_gwdt.h |  79 +++++++++
 5 files changed, 388 insertions(+)
 create mode 100644 hw/watchdog/sbsa_gwdt.c
 create mode 100644 include/hw/watchdog/sbsa_gwdt.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f303c6bead25..6b0742916f91 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -210,6 +210,7 @@ config SBSA_REF
     select PL031 # RTC
     select PL061 # GPIO
     select USB_EHCI_SYSBUS
+    select WDT_SBSA
 
 config SABRELITE
     bool
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index 293209b291d6..66e1d029e32e 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -17,3 +17,6 @@ config WDT_DIAG288
 
 config WDT_IMX2
     bool
+
+config WDT_SBSA
+    bool
diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
index 9b8725e64288..054c403dea7c 100644
--- a/hw/watchdog/meson.build
+++ b/hw/watchdog/meson.build
@@ -5,3 +5,4 @@ softmmu_ss.add(when: 'CONFIG_WDT_IB700', if_true: files('wdt_ib700.c'))
 softmmu_ss.add(when: 'CONFIG_WDT_DIAG288', if_true: files('wdt_diag288.c'))
 softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('wdt_aspeed.c'))
 softmmu_ss.add(when: 'CONFIG_WDT_IMX2', if_true: files('wdt_imx2.c'))
+softmmu_ss.add(when: 'CONFIG_WDT_SBSA', if_true: files('sbsa_gwdt.c'))
diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
new file mode 100644
index 000000000000..13bfbc922b34
--- /dev/null
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -0,0 +1,304 @@
+/*
+ * Generic watchdog device model for SBSA
+ *
+ * The watchdog device has been implemented as revision 1 variant of
+ * the ARM SBSA specification v6.0
+ * (https://developer.arm.com/documentation/den0029/d?lang=en)
+ *
+ * Copyright Linaro.org 2020
+ *
+ * Authors:
+ *  Shashi Mallela <shashi.mallela@linaro.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at your
+ * option) any later version.  See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/reset.h"
+#include "sysemu/watchdog.h"
+#include "hw/watchdog/sbsa_gwdt.h"
+#include "qemu/timer.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+static WatchdogTimerModel model = {
+    .wdt_name = TYPE_WDT_SBSA,
+    .wdt_description = "SBSA-compliant generic watchdog device",
+};
+
+static const VMStateDescription vmstate_sbsa_gwdt = {
+    .name = "sbsa-gwdt",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_TIMER_PTR(timer, SBSA_GWDTState),
+        VMSTATE_UINT32(wcs, SBSA_GWDTState),
+        VMSTATE_UINT32(worl, SBSA_GWDTState),
+        VMSTATE_UINT32(woru, SBSA_GWDTState),
+        VMSTATE_UINT32(wcvl, SBSA_GWDTState),
+        VMSTATE_UINT32(wcvu, SBSA_GWDTState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+typedef enum WdtRefreshType {
+    EXPLICIT_REFRESH = 0,
+    TIMEOUT_REFRESH = 1,
+} WdtRefreshType;
+
+static uint64_t sbsa_gwdt_rread(void *opaque, hwaddr addr, unsigned int size)
+{
+    SBSA_GWDTState *s = SBSA_GWDT(opaque);
+    uint32_t ret = 0;
+
+    switch (addr) {
+    case SBSA_GWDT_WRR:
+        /* watch refresh read has no effect and returns 0 */
+        ret = 0;
+        break;
+    case SBSA_GWDT_W_IIDR:
+        ret = s->id;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "bad address in refresh frame read :"
+                        " 0x%x\n", (int)addr);
+    }
+    return ret;
+}
+
+static uint64_t sbsa_gwdt_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    SBSA_GWDTState *s = SBSA_GWDT(opaque);
+    uint32_t ret = 0;
+
+    switch (addr) {
+    case SBSA_GWDT_WCS:
+        ret = s->wcs;
+        break;
+    case SBSA_GWDT_WOR:
+        ret = s->worl;
+        break;
+    case SBSA_GWDT_WORU:
+         ret = s->woru;
+         break;
+    case SBSA_GWDT_WCV:
+        ret = s->wcvl;
+        break;
+    case SBSA_GWDT_WCVU:
+        ret = s->wcvu;
+        break;
+    case SBSA_GWDT_W_IIDR:
+        ret = s->id;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "bad address in control frame read :"
+                        " 0x%x\n", (int)addr);
+    }
+    return ret;
+}
+
+static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
+{
+    uint64_t timeout = 0;
+
+    timer_del(s->timer);
+
+    if (s->wcs & SBSA_GWDT_WCS_EN) {
+        /*
+         * Extract the upper 16 bits from woru & 32 bits from worl
+         * registers to construct the 48 bit offset value
+         */
+        timeout = s->woru;
+        timeout <<= 32;
+        timeout |= s->worl;
+        timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, SBSA_TIMER_FREQ);
+        timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+        if ((rtype == EXPLICIT_REFRESH) || ((rtype == TIMEOUT_REFRESH) &&
+                (!(s->wcs & SBSA_GWDT_WCS_WS0)))) {
+            /* store the current timeout value into compare registers */
+            s->wcvu = timeout >> 32;
+            s->wcvl = timeout;
+        }
+        timer_mod(s->timer, timeout);
+    }
+}
+
+static void sbsa_gwdt_rwrite(void *opaque, hwaddr offset, uint64_t data,
+                             unsigned size) {
+    SBSA_GWDTState *s = SBSA_GWDT(opaque);
+
+    if (offset == SBSA_GWDT_WRR) {
+        s->wcs &= ~SBSA_GWDT_WCS_WS0;
+        s->wcs &= ~SBSA_GWDT_WCS_WS1;
+        sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "bad address in refresh frame write :"
+                        " 0x%x\n", (int)offset);
+    }
+}
+
+static void sbsa_gwdt_write(void *opaque, hwaddr offset, uint64_t data,
+                             unsigned size) {
+    SBSA_GWDTState *s = SBSA_GWDT(opaque);
+    bool enable;
+
+    switch (offset) {
+    case SBSA_GWDT_WCS:
+        enable = data & SBSA_GWDT_WCS_EN;
+        if (enable) {
+            s->wcs |= SBSA_GWDT_WCS_EN;
+        } else {
+            s->wcs &= ~SBSA_GWDT_WCS_EN;
+        }
+        s->wcs &= ~SBSA_GWDT_WCS_WS0;
+        s->wcs &= ~SBSA_GWDT_WCS_WS1;
+        sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
+        break;
+
+    case SBSA_GWDT_WOR:
+        /*
+         * store the lower 32 bits of WOR for now.
+         * explicit refresh to be triggered on upper 16 bits
+         * being written to WORU register (that follows this write)
+         */
+        s->worl = data;
+        break;
+
+    case SBSA_GWDT_WORU:
+        s->woru = data & SBSA_GWDT_WOR_MASK;
+        s->wcs &= ~SBSA_GWDT_WCS_WS0;
+        s->wcs &= ~SBSA_GWDT_WCS_WS1;
+        sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
+        break;
+
+    case SBSA_GWDT_WCV:
+        s->wcvl = data;
+        break;
+
+    case SBSA_GWDT_WCVU:
+        s->wcvu = data;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "bad address in control frame write :"
+                " 0x%x\n", (int)offset);
+    }
+    return;
+}
+
+static void wdt_sbsa_gwdt_reset(DeviceState *dev)
+{
+    SBSA_GWDTState *s = SBSA_GWDT(dev);
+
+    timer_del(s->timer);
+
+    s->wcs &= ~SBSA_GWDT_WCS_EN;
+    s->wcs &= ~SBSA_GWDT_WCS_WS0;
+    s->wcs &= ~SBSA_GWDT_WCS_WS1;
+    s->wcvl = 0;
+    s->wcvu = 0;
+    s->worl = 0;
+    s->woru = 0;
+    s->id = SBSA_GWDT_ID;
+}
+
+static void sbsa_gwdt_timer_sysinterrupt(void *opaque)
+{
+    SBSA_GWDTState *s = SBSA_GWDT(opaque);
+
+    if (!(s->wcs & SBSA_GWDT_WCS_WS0)) {
+        s->wcs |= SBSA_GWDT_WCS_WS0;
+        sbsa_gwdt_update_timer(s, TIMEOUT_REFRESH);
+        qemu_set_irq(s->irq, 1);
+    } else {
+        s->wcs |= SBSA_GWDT_WCS_WS1;
+        qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
+        /*
+         * Reset the watchdog only if the guest gets notified about
+         * expiry. watchdog_perform_action() may temporarily relinquish
+         * the BQL; reset before triggering the action to avoid races with
+         * sbsa_gwdt instructions.
+         */
+        switch (get_watchdog_action()) {
+        case WATCHDOG_ACTION_DEBUG:
+        case WATCHDOG_ACTION_NONE:
+        case WATCHDOG_ACTION_PAUSE:
+            break;
+        default:
+            wdt_sbsa_gwdt_reset(DEVICE(s));
+        }
+        watchdog_perform_action();
+    }
+}
+
+static const MemoryRegionOps sbsa_gwdt_rops = {
+    .read = sbsa_gwdt_rread,
+    .write = sbsa_gwdt_rwrite,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .valid.unaligned = false,
+};
+
+static const MemoryRegionOps sbsa_gwdt_ops = {
+    .read = sbsa_gwdt_read,
+    .write = sbsa_gwdt_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .valid.unaligned = false,
+};
+
+static void wdt_sbsa_gwdt_realize(DeviceState *dev, Error **errp)
+{
+    SBSA_GWDTState *s = SBSA_GWDT(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->rmmio, OBJECT(dev),
+                          &sbsa_gwdt_rops, s,
+                          "sbsa_gwdt.refresh",
+                          SBSA_GWDT_RMMIO_SIZE);
+
+    memory_region_init_io(&s->cmmio, OBJECT(dev),
+                          &sbsa_gwdt_ops, s,
+                          "sbsa_gwdt.control",
+                          SBSA_GWDT_CMMIO_SIZE);
+
+    sysbus_init_mmio(sbd, &s->rmmio);
+    sysbus_init_mmio(sbd, &s->cmmio);
+
+    sysbus_init_irq(sbd, &s->irq);
+
+    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sbsa_gwdt_timer_sysinterrupt,
+                dev);
+}
+
+static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = wdt_sbsa_gwdt_realize;
+    dc->reset = wdt_sbsa_gwdt_reset;
+    dc->hotpluggable = false;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->vmsd = &vmstate_sbsa_gwdt;
+}
+
+static const TypeInfo wdt_sbsa_gwdt_info = {
+    .class_init = wdt_sbsa_gwdt_class_init,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .name  = TYPE_WDT_SBSA,
+    .instance_size  = sizeof(SBSA_GWDTState),
+};
+
+static void wdt_sbsa_gwdt_register_types(void)
+{
+    watchdog_add_model(&model);
+    type_register_static(&wdt_sbsa_gwdt_info);
+}
+
+type_init(wdt_sbsa_gwdt_register_types)
diff --git a/include/hw/watchdog/sbsa_gwdt.h b/include/hw/watchdog/sbsa_gwdt.h
new file mode 100644
index 000000000000..70b137de3016
--- /dev/null
+++ b/include/hw/watchdog/sbsa_gwdt.h
@@ -0,0 +1,79 @@
+/*
+ * Copyright (c) 2020 Linaro Limited
+ *
+ * Authors:
+ *  Shashi Mallela <shashi.mallela@linaro.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at your
+ * option) any later version.  See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef WDT_SBSA_GWDT_H
+#define WDT_SBSA_GWDT_H
+
+#include "qemu/bitops.h"
+#include "hw/sysbus.h"
+#include "hw/irq.h"
+
+#define TYPE_WDT_SBSA "sbsa_gwdt"
+#define SBSA_GWDT(obj) \
+    OBJECT_CHECK(SBSA_GWDTState, (obj), TYPE_WDT_SBSA)
+#define SBSA_GWDT_CLASS(klass) \
+    OBJECT_CLASS_CHECK(SBSA_GWDTClass, (klass), TYPE_WDT_SBSA)
+#define SBSA_GWDT_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(SBSA_GWDTClass, (obj), TYPE_WDT_SBSA)
+
+/* SBSA Generic Watchdog register definitions */
+/* refresh frame */
+#define SBSA_GWDT_WRR       0x000
+
+/* control frame */
+#define SBSA_GWDT_WCS       0x000
+#define SBSA_GWDT_WOR       0x008
+#define SBSA_GWDT_WORU      0x00C
+#define SBSA_GWDT_WCV       0x010
+#define SBSA_GWDT_WCVU      0x014
+
+/* Watchdog Interface Identification Register */
+#define SBSA_GWDT_W_IIDR    0xFCC
+
+/* Watchdog Control and Status Register Bits */
+#define SBSA_GWDT_WCS_EN    BIT(0)
+#define SBSA_GWDT_WCS_WS0   BIT(1)
+#define SBSA_GWDT_WCS_WS1   BIT(2)
+
+#define SBSA_GWDT_WOR_MASK  0x0000FFFF
+
+/*
+ * Watchdog Interface Identification Register definition
+ * considering JEP106 code for ARM in Bits [11:0]
+ */
+#define SBSA_GWDT_ID        0x1043B
+
+/* 2 Separate memory regions for each of refresh & control register frames */
+#define SBSA_GWDT_RMMIO_SIZE 0x1000
+#define SBSA_GWDT_CMMIO_SIZE 0x1000
+
+#define SBSA_TIMER_FREQ      62500000 /* Hz */
+
+typedef struct SBSA_GWDTState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion rmmio;
+    MemoryRegion cmmio;
+    qemu_irq irq;
+
+    QEMUTimer *timer;
+
+    uint32_t id;
+    uint32_t wcs;
+    uint32_t worl;
+    uint32_t woru;
+    uint32_t wcvl;
+    uint32_t wcvu;
+} SBSA_GWDTState;
+
+#endif /* WDT_SBSA_GWDT_H */
-- 
2.18.4


