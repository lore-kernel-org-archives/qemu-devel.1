Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8BCC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABD422265
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="avUKiYSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABD422265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNks-0005kj-6h
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNQB-0002CM-HP
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:47 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:39970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNQ6-0004rT-0G
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id h5so1523530wrv.7
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VVwuc2GnV1vqEmf8sfgrwuoJQnthysa2qHe6XcOjWPc=;
 b=avUKiYSeVEG/gFXqZaC0aAIACQ6uyyvpRxtFZpPyfmrBlbGX1btNPQD4XnOjDV/saZ
 QJUZSBmO9EJFy57nL//kl61Ch1MtuZHecxYub3n4cjUlck3J6YnoG+0MotFuKn2MsmJM
 baCjK1377B+CH2d63MkWsVETkjKXimU5IJKb+YvNbJWBITrTVoXbJ9kbrLcyqdA3SdOd
 LLSAnqUOsAOediRZzz4mBVCR7GPK9jZBX6shgBDkBY9EKMWAr2pvUMj9909bwmUHSWR9
 kSPHCrNAPa6MP3Aquzp9D88joskCw5yGRUE0LBDLsLAah/PvEF4Fh4MxkzO01xUykrb6
 DEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VVwuc2GnV1vqEmf8sfgrwuoJQnthysa2qHe6XcOjWPc=;
 b=S5QmkrVFH4eSo7encYdjjhninsL8/0y2rm7aWNnN8EwwfI8eG0SwHe4/vpYlcJi+xS
 Ajv4XJFezjQLts6y+Smq0tbnj94N3NudBWkbU/B6I8nHW65+1wnq67tepGNpNAxhTBEY
 XuPgdT4zVYWVcuiZA4y2pRQKpZOy4NBM0lSXPhxNy25snUkrlDSbRzTOPvvG7hIJ0GOI
 DGuSoqDI4O+PK2rVOce6emkoEUAO2fFFEW1P4EGivFMbCGLfdc9lMzH4/sW9TLWRufZL
 g7/H3N5T2yVt4MyAdapUMXZYXKOaJy0EDwHGbM0fNNkZZy0gquzysv4dyMk51s3V5Hne
 6FUg==
X-Gm-Message-State: AOAM533kky17LKKFEWXS4F2vpMUx/gaZW7579+mYRFexHr8OgjOkd5SA
 KOTtN3GP7X2XSRPlsftpz5k0dl4gSKyVLQ==
X-Google-Smtp-Source: ABdhPJxaATap9DEm2QWt6bzWkxc94YbaaSsu4cqay+sEBYji6jskgtUFPxO+DpEQKBCkW8X5TJP9AA==
X-Received: by 2002:a05:6000:1109:: with SMTP id
 z9mr2203571wrw.388.1603799137862; 
 Tue, 27 Oct 2020 04:45:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/48] hw/watchdog: Implement SBSA watchdog device
Date: Tue, 27 Oct 2020 11:44:35 +0000
Message-Id: <20201027114438.17662-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shashi Mallela <shashi.mallela@linaro.org>

Generic watchdog device model implementation as per ARM SBSA v6.0

Signed-off-by: Shashi Mallela <shashi.mallela@linaro.org>
Message-id: 20201027015927.29495-2-shashi.mallela@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/watchdog/sbsa_gwdt.h |  79 +++++++++
 hw/watchdog/sbsa_gwdt.c         | 293 ++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                  |   1 +
 hw/watchdog/Kconfig             |   3 +
 hw/watchdog/meson.build         |   1 +
 5 files changed, 377 insertions(+)
 create mode 100644 include/hw/watchdog/sbsa_gwdt.h
 create mode 100644 hw/watchdog/sbsa_gwdt.c

diff --git a/include/hw/watchdog/sbsa_gwdt.h b/include/hw/watchdog/sbsa_gwdt.h
new file mode 100644
index 00000000000..70b137de301
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
diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
new file mode 100644
index 00000000000..d0998f8489c
--- /dev/null
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -0,0 +1,293 @@
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
+        s->wcs &= ~(SBSA_GWDT_WCS_WS0 | SBSA_GWDT_WCS_WS1);
+
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
+
+    switch (offset) {
+    case SBSA_GWDT_WCS:
+        s->wcs = data & SBSA_GWDT_WCS_EN;
+        qemu_set_irq(s->irq, 0);
+        sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
+        break;
+
+    case SBSA_GWDT_WOR:
+        s->worl = data;
+        s->wcs &= ~(SBSA_GWDT_WCS_WS0 | SBSA_GWDT_WCS_WS1);
+        qemu_set_irq(s->irq, 0);
+        sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
+        break;
+
+    case SBSA_GWDT_WORU:
+        s->woru = data & SBSA_GWDT_WOR_MASK;
+        s->wcs &= ~(SBSA_GWDT_WCS_WS0 | SBSA_GWDT_WCS_WS1);
+        qemu_set_irq(s->irq, 0);
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
+    s->wcs  = 0;
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
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7d040827af4..0ef9e3c1d5f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -211,6 +211,7 @@ config SBSA_REF
     select PL031 # RTC
     select PL061 # GPIO
     select USB_EHCI_SYSBUS
+    select WDT_SBSA
 
 config SABRELITE
     bool
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index 293209b291d..66e1d029e32 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -17,3 +17,6 @@ config WDT_DIAG288
 
 config WDT_IMX2
     bool
+
+config WDT_SBSA
+    bool
diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
index 9b8725e6428..054c403dea7 100644
--- a/hw/watchdog/meson.build
+++ b/hw/watchdog/meson.build
@@ -5,3 +5,4 @@ softmmu_ss.add(when: 'CONFIG_WDT_IB700', if_true: files('wdt_ib700.c'))
 softmmu_ss.add(when: 'CONFIG_WDT_DIAG288', if_true: files('wdt_diag288.c'))
 softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('wdt_aspeed.c'))
 softmmu_ss.add(when: 'CONFIG_WDT_IMX2', if_true: files('wdt_imx2.c'))
+softmmu_ss.add(when: 'CONFIG_WDT_SBSA', if_true: files('sbsa_gwdt.c'))
-- 
2.20.1


