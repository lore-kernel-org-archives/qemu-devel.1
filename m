Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CA6C1975A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 17:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262E020782
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 17:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkVN8bmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262E020782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDAaX-00019c-7G
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 13:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jDAZc-0007qI-T4
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 13:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jDAZb-0005QJ-3e
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 13:27:44 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41733)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jDAZa-0005LU-TG; Sat, 14 Mar 2020 13:27:43 -0400
Received: by mail-pg1-x544.google.com with SMTP id b1so6915381pgm.8;
 Sat, 14 Mar 2020 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AjHZ7Orhg2us4PqU0ungCcpMTvWnWDW+BzE4hfc2SsE=;
 b=YkVN8bmC59flSpmuiD87VDk/4mLg+86kMqZtenkePOdwn7ECAE4Znb0dLMW4p8apm1
 FNCmSky8ZsqRBX6ekpEFTDfHKT//Co2f4ZaY71nX/AQW6lDjkA93ooCmBDTzhpwyyG+s
 8Q3RU9T/gzimpwvZyyaBuAbHK2qI0R6ckqqSUYdn0JDzVOG+2L3QdZ4nUa1/nFhq09Nr
 /HN4t//tSvxvFRLELxdY0xgwCPH80M0eglf/0rdRLidE+MSDysGyG8GXh8SCdjTe0+kT
 v5QMRJAnTBiNGvu++51k1MIqhfll3HZxMoSIUBUJ6/UhyPmgaCLzZZh3TwaTcypAJKUy
 Gfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=AjHZ7Orhg2us4PqU0ungCcpMTvWnWDW+BzE4hfc2SsE=;
 b=JC5opA6Sw/MRF98/1DslK+qLWxKrk0QkYN+rdAt/zcz+OjZ3vUOY8Nt53GKsZpR8dF
 43A6fXfxRyVjOj9MkttCdW+V3H/h3rlejLQvnozed+f7mVpSZurAIW2a7gGkjpfbLxhT
 rwew7SZYepP35+Yq6njoiqeAB/RMZL6DNFsnkYY7WybeOK6b7Kusv6QVPntpe3kMXvXZ
 SLxl5SFdkNgMt0kixi9aSdfbRAz3VOr10uv50WdcDOBizlo9AUyyVoAVEFm0Rb1xMyLu
 zDmukOQ0B/CRRYZ0fjLandZkWv/lsBc6qXSo81hPYCVfe5ZxUBG2G22kYTKFxnWyE6Zh
 hiEg==
X-Gm-Message-State: ANhLgQ3dHyxYn4AArYWkkAfRIsZ8vVc89ug19zfN6O2eDKZUscXqtNfm
 zrEwWmanYUS0Ic1H01at+zc=
X-Google-Smtp-Source: ADFU+vvMv3dmoqZ6zs+pWB43dms9gWE4jvd05RxLfWZGN/B81txTc0/GVo6Sbg7UqIiBOhn0JC4dMw==
X-Received: by 2002:a63:a504:: with SMTP id n4mr18519904pgf.373.1584206861925; 
 Sat, 14 Mar 2020 10:27:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id w124sm11770758pfd.71.2020.03.14.10.27.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 14 Mar 2020 10:27:41 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/8] hw/watchdog: Implement full i.MX watchdog support
Date: Sat, 14 Mar 2020 10:27:30 -0700
Message-Id: <20200314172736.24528-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314172736.24528-1-linux@roeck-us.net>
References: <20200314172736.24528-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement full support for the watchdog in i.MX systems.
Pretimeout support is optional because the watchdog hardware on i.MX31
does not support pretimeouts.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/watchdog/Makefile.objs      |   2 +-
 hw/watchdog/wdt_imx2.c         | 196 +++++++++++++++++++++++++++++++--
 include/hw/watchdog/wdt_imx2.h |  49 ++++++++-
 3 files changed, 232 insertions(+), 15 deletions(-)

diff --git a/hw/watchdog/Makefile.objs b/hw/watchdog/Makefile.objs
index dd9b37f642..631b711d86 100644
--- a/hw/watchdog/Makefile.objs
+++ b/hw/watchdog/Makefile.objs
@@ -4,4 +4,4 @@ common-obj-$(CONFIG_WDT_IB6300ESB) += wdt_i6300esb.o
 common-obj-$(CONFIG_WDT_IB700) += wdt_ib700.o
 common-obj-$(CONFIG_WDT_DIAG288) += wdt_diag288.o
 common-obj-$(CONFIG_ASPEED_SOC) += wdt_aspeed.o
-common-obj-$(CONFIG_WDT_IMX) += wdt_imx2.o
+common-obj-$(CONFIG_WDT_IMX2) += wdt_imx2.o
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index ad1ef02e9e..f5339f3590 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -13,24 +13,157 @@
 #include "qemu/bitops.h"
 #include "qemu/module.h"
 #include "sysemu/watchdog.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
 
 #include "hw/watchdog/wdt_imx2.h"
 
-#define IMX2_WDT_WCR_WDA    BIT(5)      /* -> External Reset WDOG_B */
-#define IMX2_WDT_WCR_SRS    BIT(4)      /* -> Software Reset Signal */
+static void imx2_wdt_interrupt(void *opaque)
+{
+    IMX2WdtState *s = IMX2_WDT(opaque);
+
+    s->wicr |= IMX2_WDT_WICR_WTIS;
+    qemu_set_irq(s->irq, 1);
+}
 
-static uint64_t imx2_wdt_read(void *opaque, hwaddr addr,
-                              unsigned int size)
+static void imx2_wdt_expired(void *opaque)
 {
+    IMX2WdtState *s = IMX2_WDT(opaque);
+
+    s->wrsr = IMX2_WDT_WRSR_TOUT;
+
+    /* Perform watchdog action if watchdog is enabled */
+    if (s->wcr & IMX2_WDT_WCR_WDE) {
+        watchdog_perform_action();
+    }
+}
+
+static void imx2_wdt_reset(DeviceState *dev)
+{
+    IMX2WdtState *s = IMX2_WDT(dev);
+
+    s->wcr = IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS;
+    s->wsr = 0;
+    s->wrsr &= ~(IMX2_WDT_WRSR_TOUT | IMX2_WDT_WRSR_SFTW);
+    s->wicr = 4;
+    s->wmcr = IMX2_WDT_WMCR_PDE;
+}
+
+static uint64_t imx2_wdt_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    IMX2WdtState *s = IMX2_WDT(opaque);
+
+    switch (addr) {
+    case IMX2_WDT_WCR:
+        return s->wcr;
+    case IMX2_WDT_WSR:
+        return s->wsr;
+    case IMX2_WDT_WRSR:
+        return s->wrsr;
+    case IMX2_WDT_WICR:
+        return s->wicr;
+    case IMX2_WDT_WMCR:
+        return s->wmcr;
+    }
     return 0;
 }
 
+static void imx_wdt2_update_itimer(IMX2WdtState *s, bool start)
+{
+    bool running = (s->wcr & IMX2_WDT_WCR_WDE) && (s->wcr & IMX2_WDT_WCR_WT);
+    bool enabled = s->wicr & IMX2_WDT_WICR_WIE;
+
+    ptimer_transaction_begin(s->itimer);
+    if (start || !enabled) {
+        ptimer_stop(s->itimer);
+    }
+    if (running && enabled) {
+        int count = ptimer_get_count(s->timer);
+        int pretimeout = s->wicr & IMX2_WDT_WICR_WICT;
+
+        /*
+         * Only (re-)start pretimeout timer if its counter value is larger
+         * than 0. Otherwise it will fire right away and we'll get an
+         * interrupt loop.
+         */
+        if (count > pretimeout) {
+            ptimer_set_count(s->itimer, count - pretimeout);
+            if (start) {
+                ptimer_run(s->itimer, 1);
+            }
+        }
+    }
+    ptimer_transaction_commit(s->itimer);
+}
+
+static void imx_wdt2_update_timer(IMX2WdtState *s, bool start)
+{
+    ptimer_transaction_begin(s->timer);
+    if (start) {
+        ptimer_stop(s->timer);
+    }
+    if ((s->wcr & IMX2_WDT_WCR_WDE) && (s->wcr & IMX2_WDT_WCR_WT)) {
+        int count = (s->wcr & IMX2_WDT_WCR_WT) >> 8;
+
+        ptimer_set_count(s->timer, count);
+        if (start) {
+            ptimer_run(s->timer, 1);
+        }
+    }
+    ptimer_transaction_commit(s->timer);
+    if (s->pretimeout_support) {
+        imx_wdt2_update_itimer(s, start);
+    }
+}
+
 static void imx2_wdt_write(void *opaque, hwaddr addr,
                            uint64_t value, unsigned int size)
 {
-    if (addr == IMX2_WDT_WCR &&
-        (~value & (IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS))) {
-        watchdog_perform_action();
+    IMX2WdtState *s = IMX2_WDT(opaque);
+
+    switch (addr) {
+    case IMX2_WDT_WCR:
+        s->wcr = value;
+        if (!(value & IMX2_WDT_WCR_SRS)) {
+            s->wrsr = IMX2_WDT_WRSR_SFTW;
+        }
+        if (!(value & (IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS)) ||
+            (!(value & IMX2_WDT_WCR_WT) && (value & IMX2_WDT_WCR_WDE))) {
+            watchdog_perform_action();
+        }
+        s->wcr |= IMX2_WDT_WCR_SRS;
+        imx_wdt2_update_timer(s, true);
+        break;
+    case IMX2_WDT_WSR:
+        if (s->wsr == IMX2_WDT_SEQ1 && value == IMX2_WDT_SEQ2) {
+            imx_wdt2_update_timer(s, false);
+        }
+        s->wsr = value;
+        break;
+    case IMX2_WDT_WRSR:
+        break;
+    case IMX2_WDT_WICR:
+        if (!s->pretimeout_support) {
+            return;
+        }
+        /* The pretimeout value is write-once */
+        if (s->pretimeout_locked) {
+            value &= ~IMX2_WDT_WICR_WICT;
+            s->wicr &= (IMX2_WDT_WICR_WTIS | IMX2_WDT_WICR_WICT);
+        } else {
+            s->wicr &= IMX2_WDT_WICR_WTIS;
+        }
+        s->wicr |= value & (IMX2_WDT_WICR_WIE | IMX2_WDT_WICR_WICT);
+        if (value & IMX2_WDT_WICR_WTIS) {
+            s->wicr &= ~IMX2_WDT_WICR_WTIS;
+            qemu_set_irq(s->irq, 0);
+        }
+        imx_wdt2_update_itimer(s, true);
+        s->pretimeout_locked = true;
+        break;
+    case IMX2_WDT_WMCR:
+        s->wmcr = value & IMX2_WDT_WMCR_PDE;
+        break;
     }
 }
 
@@ -45,28 +178,67 @@ static const MemoryRegionOps imx2_wdt_ops = {
          * real device but in practice there is no reason for a guest
          * to access this device unaligned.
          */
-        .min_access_size = 4,
-        .max_access_size = 4,
+        .min_access_size = 2,
+        .max_access_size = 2,
         .unaligned = false,
     },
 };
 
+static const VMStateDescription vmstate_imx2_wdt = {
+    .name = "imx2.wdt",
+    .fields = (VMStateField[]) {
+        VMSTATE_PTIMER(timer, IMX2WdtState),
+        VMSTATE_PTIMER(itimer, IMX2WdtState),
+        VMSTATE_BOOL(pretimeout_locked, IMX2WdtState),
+        VMSTATE_UINT16(wcr, IMX2WdtState),
+        VMSTATE_UINT16(wsr, IMX2WdtState),
+        VMSTATE_UINT16(wrsr, IMX2WdtState),
+        VMSTATE_UINT16(wmcr, IMX2WdtState),
+        VMSTATE_UINT16(wicr, IMX2WdtState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void imx2_wdt_realize(DeviceState *dev, Error **errp)
 {
     IMX2WdtState *s = IMX2_WDT(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     memory_region_init_io(&s->mmio, OBJECT(dev),
                           &imx2_wdt_ops, s,
-                          TYPE_IMX2_WDT".mmio",
-                          IMX2_WDT_REG_NUM * sizeof(uint16_t));
-    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+                          TYPE_IMX2_WDT,
+                          IMX2_WDT_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+    sysbus_init_irq(sbd, &s->irq);
+
+    s->timer = ptimer_init(imx2_wdt_expired, s, PTIMER_POLICY_DEFAULT);
+    ptimer_transaction_begin(s->timer);
+    ptimer_set_freq(s->timer, 2);
+    ptimer_set_limit(s->timer, 0xff, 1);
+    ptimer_transaction_commit(s->timer);
+    if (s->pretimeout_support) {
+        s->itimer = ptimer_init(imx2_wdt_interrupt, s, PTIMER_POLICY_DEFAULT);
+        ptimer_transaction_begin(s->itimer);
+        ptimer_set_freq(s->itimer, 2);
+        ptimer_set_limit(s->itimer, 0xff, 1);
+        ptimer_transaction_commit(s->itimer);
+    }
 }
 
+static Property imx2_wdt_properties[] = {
+    DEFINE_PROP_BOOL("pretimeout-support", IMX2WdtState, pretimeout_support,
+                     false),
+};
+
 static void imx2_wdt_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    device_class_set_props(dc, imx2_wdt_properties);
     dc->realize = imx2_wdt_realize;
+    dc->reset = imx2_wdt_reset;
+    dc->vmsd = &vmstate_imx2_wdt;
+    dc->desc = "i.MX watchdog timer";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
index b91b002528..bed7aa6835 100644
--- a/include/hw/watchdog/wdt_imx2.h
+++ b/include/hw/watchdog/wdt_imx2.h
@@ -12,22 +12,67 @@
 #ifndef IMX2_WDT_H
 #define IMX2_WDT_H
 
+#include "qemu/bitops.h"
 #include "hw/sysbus.h"
+#include "hw/irq.h"
+#include "hw/ptimer.h"
 
 #define TYPE_IMX2_WDT "imx2.wdt"
 #define IMX2_WDT(obj) OBJECT_CHECK(IMX2WdtState, (obj), TYPE_IMX2_WDT)
 
 enum IMX2WdtRegisters {
-    IMX2_WDT_WCR     = 0x0000,
-    IMX2_WDT_REG_NUM = 0x0008 / sizeof(uint16_t) + 1,
+    IMX2_WDT_WCR  = 0x0000, /* Control Register */
+    IMX2_WDT_WSR  = 0x0002, /* Service Register */
+    IMX2_WDT_WRSR = 0x0004, /* Reset Status Register */
+    IMX2_WDT_WICR = 0x0006, /* Interrupt Control Register */
+    IMX2_WDT_WMCR = 0x0008, /* Misc Register */
 };
 
+#define IMX2_WDT_MMIO_SIZE 0x000a
+
+/* Control Register definitions */
+#define IMX2_WDT_WCR_WT         (0xFF << 8) /* Watchdog Timeout Field */
+#define IMX2_WDT_WCR_WDA        BIT(5)      /* WDOG Assertion */
+#define IMX2_WDT_WCR_SRS        BIT(4)      /* Software Reset Signal */
+#define IMX2_WDT_WCR_WDT        BIT(3)      /* WDOG Timeout Assertion */
+#define IMX2_WDT_WCR_WDE        BIT(2)      /* Watchdog Enable */
+#define IMX2_WDT_WCR_WDZST      BIT(0)      /* Watchdog Timer Suspend */
+
+/* Service Register definitions */
+#define IMX2_WDT_SEQ1           0x5555      /* service sequence 1 */
+#define IMX2_WDT_SEQ2           0xAAAA      /* service sequence 2 */
+
+/* Reset Status Register definitions */
+#define IMX2_WDT_WRSR_TOUT      BIT(1)      /* Reset due to Timeout */
+#define IMX2_WDT_WRSR_SFTW      BIT(0)      /* Reset due to Timeout */
+
+/* Interrupt Control Register definitions */
+#define IMX2_WDT_WICR_WIE       BIT(15)     /* Interrupt Enable */
+#define IMX2_WDT_WICR_WTIS      BIT(14)     /* Interrupt Status */
+#define IMX2_WDT_WICR_WICT      0xff        /* Interrupt Timeout */
+
+/* Misc Control Register definitions */
+#define IMX2_WDT_WMCR_PDE       BIT(0)      /* Power-Down Enable */
 
 typedef struct IMX2WdtState {
     /* <private> */
     SysBusDevice parent_obj;
 
+    /*< public >*/
     MemoryRegion mmio;
+    qemu_irq irq;
+
+    struct ptimer_state *timer;
+    struct ptimer_state *itimer;
+
+    bool pretimeout_support;
+    bool pretimeout_locked;
+
+    uint16_t wcr;
+    uint16_t wsr;
+    uint16_t wrsr;
+    uint16_t wicr;
+    uint16_t wmcr;
 } IMX2WdtState;
 
 #endif /* IMX2_WDT_H */
-- 
2.17.1


