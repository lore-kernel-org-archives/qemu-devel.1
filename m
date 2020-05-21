Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E10C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CAD207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vF74EXgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CAD207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqoW-0003L8-Cg
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgC-0002Qb-0R
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:32 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:53479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgA-0000RS-Ee
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:31 -0400
Received: by mail-wm1-x32e.google.com with SMTP id u1so6517184wmn.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+r4uX4unNchR0Uk4YkJ3GsBkZc2Xb0u6je+WQD2TN+0=;
 b=vF74EXgbIOzfw1MXSrAKMMANkO8a7nGSUhUqlrvrhtmg0IditACVm0n9QfuHWb7aA5
 43qsOJ5EpU29By/8L3VWNdkFH+44v2tm0LPTIV/4TdjHZTrJcZWwVjuKPlmEfh6WqU/3
 NZMz6zGxMl0+FuFxj8xhzF9dt/ZHBzpL88CSvmn0oS7fWreFonFGIdHr9rkrJsY3sogL
 PY2KPmq2tWOVUzxAATlrAifQ7X7l8Aj07YF355qPe1CmPfz+l59XT9leYk1eockSk2HU
 9gfJ0S+p/dvMzqD3qW0D9rZR4PIeGBhl2Mp4nxy59a/INR1XOw6szEMfRWiUEkcmJmeu
 b0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+r4uX4unNchR0Uk4YkJ3GsBkZc2Xb0u6je+WQD2TN+0=;
 b=AUFMB8d1uoKspBWpE9up49aPsYjd2u+u0Fya/Gr4dqovfob3IPm44CbFnpNvfUcAjM
 AcSQs+oF3QS8ACq1ptdHk96f97fH0wAF4FscexKUv/ew7syk32sdSWqhNZJF1EoblCGr
 /vVT3QAXhONSgrfmjvKZPw9Q3JsgAfMopvf10Jhf+V6cfZne7+BxXULRrlknlaVZGoNq
 /i3xXoZe/WCGgkzhG84bQoTRT3eUYYQQjeqXaKLw8SVdp7goSn+dyYMeYIzGLvRPo1ED
 EwPhFjuaFK4RAXgeiOkU8IOnxRT6miz0FDqqgUlW1au8cz2rA0pPF7yKkoliQw2X9BJg
 v47Q==
X-Gm-Message-State: AOAM530DVhit4OsZS5bs88uehQWGE16zcgMbAxdZqdoLLeBE63OVS4hV
 mEwkhhyWnwTwQ3UOOJg3AJALQwc2MFbkaQ==
X-Google-Smtp-Source: ABdhPJwoMerD20F4omm/nXHGr37P1ECs/YW/ZGkLyCkOQAsPsJmFgI6Yrb23j3wzJ+mOWAfMsQFIFw==
X-Received: by 2002:a1c:1b44:: with SMTP id b65mr10592231wmb.181.1590088588513; 
 Thu, 21 May 2020 12:16:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/29] hw/watchdog: Implement full i.MX watchdog support
Date: Thu, 21 May 2020 20:15:54 +0100
Message-Id: <20200521191610.10941-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

From: Guenter Roeck <linux@roeck-us.net>

Implement full support for the watchdog in i.MX systems.
Pretimeout support is optional because the watchdog hardware
on i.MX31 does not support pretimeouts.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200517162135.110364-3-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/watchdog/wdt_imx2.h |  61 ++++++++-
 hw/watchdog/wdt_imx2.c         | 239 +++++++++++++++++++++++++++++++--
 2 files changed, 285 insertions(+), 15 deletions(-)

diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
index b91b002528f..f9af6be4b69 100644
--- a/include/hw/watchdog/wdt_imx2.h
+++ b/include/hw/watchdog/wdt_imx2.h
@@ -12,22 +12,79 @@
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
+#define IMX2_WDT_WCR_WDW        BIT(7)      /* WDOG Disable for Wait */
+#define IMX2_WDT_WCR_WDA        BIT(5)      /* WDOG Assertion */
+#define IMX2_WDT_WCR_SRS        BIT(4)      /* Software Reset Signal */
+#define IMX2_WDT_WCR_WDT        BIT(3)      /* WDOG Timeout Assertion */
+#define IMX2_WDT_WCR_WDE        BIT(2)      /* Watchdog Enable */
+#define IMX2_WDT_WCR_WDBG       BIT(1)      /* Watchdog Debug Enable */
+#define IMX2_WDT_WCR_WDZST      BIT(0)      /* Watchdog Timer Suspend */
+
+#define IMX2_WDT_WCR_LOCK_MASK  (IMX2_WDT_WCR_WDZST | IMX2_WDT_WCR_WDBG \
+                                 | IMX2_WDT_WCR_WDW)
+
+/* Service Register definitions */
+#define IMX2_WDT_SEQ1           0x5555      /* service sequence 1 */
+#define IMX2_WDT_SEQ2           0xAAAA      /* service sequence 2 */
+
+/* Reset Status Register definitions */
+#define IMX2_WDT_WRSR_TOUT      BIT(1)      /* Reset due to Timeout */
+#define IMX2_WDT_WRSR_SFTW      BIT(0)      /* Reset due to software reset */
+
+/* Interrupt Control Register definitions */
+#define IMX2_WDT_WICR_WIE       BIT(15)     /* Interrupt Enable */
+#define IMX2_WDT_WICR_WTIS      BIT(14)     /* Interrupt Status */
+#define IMX2_WDT_WICR_WICT      0xff        /* Interrupt Timeout */
+#define IMX2_WDT_WICR_WICT_DEF  0x04        /* Default interrupt timeout (2s) */
+
+#define IMX2_WDT_WICR_LOCK_MASK (IMX2_WDT_WICR_WIE | IMX2_WDT_WICR_WICT)
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
+    bool wicr_locked;
+
+    uint16_t wcr;
+    uint16_t wsr;
+    uint16_t wrsr;
+    uint16_t wicr;
+    uint16_t wmcr;
+
+    bool wcr_locked;            /* affects WDZST, WDBG, and WDW */
+    bool wcr_wde_locked;        /* affects WDE */
+    bool wcr_wdt_locked;        /* affects WDT (never cleared) */
 } IMX2WdtState;
 
 #endif /* IMX2_WDT_H */
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index ad1ef02e9e7..855b51768a8 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -13,24 +13,189 @@
 #include "qemu/bitops.h"
 #include "qemu/module.h"
 #include "sysemu/watchdog.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
 
 #include "hw/watchdog/wdt_imx2.h"
 
-#define IMX2_WDT_WCR_WDA    BIT(5)      /* -> External Reset WDOG_B */
-#define IMX2_WDT_WCR_SRS    BIT(4)      /* -> Software Reset Signal */
-
-static uint64_t imx2_wdt_read(void *opaque, hwaddr addr,
-                              unsigned int size)
+static void imx2_wdt_interrupt(void *opaque)
 {
+    IMX2WdtState *s = IMX2_WDT(opaque);
+
+    s->wicr |= IMX2_WDT_WICR_WTIS;
+    qemu_set_irq(s->irq, 1);
+}
+
+static void imx2_wdt_expired(void *opaque)
+{
+    IMX2WdtState *s = IMX2_WDT(opaque);
+
+    s->wrsr = IMX2_WDT_WRSR_TOUT;
+
+    /* Perform watchdog action if watchdog is enabled */
+    if (s->wcr & IMX2_WDT_WCR_WDE) {
+        s->wrsr = IMX2_WDT_WRSR_TOUT;
+        watchdog_perform_action();
+    }
+}
+
+static void imx2_wdt_reset(DeviceState *dev)
+{
+    IMX2WdtState *s = IMX2_WDT(dev);
+
+    ptimer_transaction_begin(s->timer);
+    ptimer_stop(s->timer);
+    ptimer_transaction_commit(s->timer);
+
+    if (s->pretimeout_support) {
+        ptimer_transaction_begin(s->itimer);
+        ptimer_stop(s->itimer);
+        ptimer_transaction_commit(s->itimer);
+    }
+
+    s->wicr_locked = false;
+    s->wcr_locked = false;
+    s->wcr_wde_locked = false;
+
+    s->wcr = IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS;
+    s->wsr = 0;
+    s->wrsr &= ~(IMX2_WDT_WRSR_TOUT | IMX2_WDT_WRSR_SFTW);
+    s->wicr = IMX2_WDT_WICR_WICT_DEF;
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
+        /* A value of 0 reflects one period (0.5s). */
+        ptimer_set_count(s->timer, count + 1);
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
+        if (s->wcr_locked) {
+            value &= ~IMX2_WDT_WCR_LOCK_MASK;
+            value |= (s->wicr & IMX2_WDT_WCR_LOCK_MASK);
+        }
+        s->wcr_locked = true;
+        if (s->wcr_wde_locked) {
+            value &= ~IMX2_WDT_WCR_WDE;
+            value |= (s->wicr & ~IMX2_WDT_WCR_WDE);
+        } else if (value & IMX2_WDT_WCR_WDE) {
+            s->wcr_wde_locked = true;
+        }
+        if (s->wcr_wdt_locked) {
+            value &= ~IMX2_WDT_WCR_WDT;
+            value |= (s->wicr & ~IMX2_WDT_WCR_WDT);
+        } else if (value & IMX2_WDT_WCR_WDT) {
+            s->wcr_wdt_locked = true;
+        }
+
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
+        value &= IMX2_WDT_WICR_LOCK_MASK | IMX2_WDT_WICR_WTIS;
+        if (s->wicr_locked) {
+            value &= IMX2_WDT_WICR_WTIS;
+            value |= (s->wicr & IMX2_WDT_WICR_LOCK_MASK);
+        }
+        s->wicr = value | (s->wicr & IMX2_WDT_WICR_WTIS);
+        if (value & IMX2_WDT_WICR_WTIS) {
+            s->wicr &= ~IMX2_WDT_WICR_WTIS;
+            qemu_set_irq(s->irq, 0);
+        }
+        imx_wdt2_update_itimer(s, true);
+        s->wicr_locked = true;
+        break;
+    case IMX2_WDT_WMCR:
+        s->wmcr = value & IMX2_WDT_WMCR_PDE;
+        break;
     }
 }
 
@@ -45,28 +210,76 @@ static const MemoryRegionOps imx2_wdt_ops = {
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
+        VMSTATE_BOOL(wicr_locked, IMX2WdtState),
+        VMSTATE_BOOL(wcr_locked, IMX2WdtState),
+        VMSTATE_BOOL(wcr_wde_locked, IMX2WdtState),
+        VMSTATE_BOOL(wcr_wdt_locked, IMX2WdtState),
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
+    s->timer = ptimer_init(imx2_wdt_expired, s,
+                           PTIMER_POLICY_NO_IMMEDIATE_TRIGGER |
+                           PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
+                           PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+    ptimer_transaction_begin(s->timer);
+    ptimer_set_freq(s->timer, 2);
+    ptimer_set_limit(s->timer, 0xff, 1);
+    ptimer_transaction_commit(s->timer);
+    if (s->pretimeout_support) {
+        s->itimer = ptimer_init(imx2_wdt_interrupt, s,
+                                PTIMER_POLICY_NO_IMMEDIATE_TRIGGER |
+                                PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
+                                PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
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
 
-- 
2.20.1


