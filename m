Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E858C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2813F20881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xhqioRQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2813F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7Ue-00086G-Cz
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51719)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi49X-00055u-Ao
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi49U-0007t3-SJ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:47:59 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:32854)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi49U-0007i4-DQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:47:56 -0400
Received: by mail-wr1-f49.google.com with SMTP id n9so15454694wru.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=CYfx37JxnssAjr/tG+kyQQOiehR3Iv+2f3PQj31KL1k=;
 b=xhqioRQGf568ofeu8XUsiPc5H6X+8w7tPd/JWgRWPF2jmOGsjlJZJaSJOn1khDEUmW
 FKsIosXhewecqkYCjwiETXkI5D12ElqX2vRrddlYk5Pa9IXQ9pl6O+gYLb/kKDH0gvpt
 uU/Pmy3hdqEnxQGvZitM6KqkSj1vCgIMa+wkxpuVy7BYqHSwIKZVdYF3hCagY/cCWrpk
 1BPcR/b1D9okWKM5OINFtIH3z6qaWuLYos7xvPLQXASCq2ac2+BduDZioNgHrl8601Q3
 hNBZojTFKVeAWa1hfIRx8SennqeNX9Ni5OJm/dxCR5IHqv8tfBCzsvQ53cYeZ1R2wv4f
 F3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CYfx37JxnssAjr/tG+kyQQOiehR3Iv+2f3PQj31KL1k=;
 b=rCf9d7lwlv4DmysHqN+CwU5j49dasQGUPhFB6eOzwyH3ZLvey2HId0ee6k87ozA83n
 VlMiAuxS1d1p0Yfvn7IKsPkh4ied/fQ0CAp8GstfTcgY2J/PeFc0leYfpWFTnh1sbusy
 HlNPPkUBEDElM+skNk9To1f/CjTk1U99K7RQtPskvn3gLxgld13DVYLA3YZLC1NVRrIw
 GdIAHyJLdPJdOINqkUyE2bPD7do6F4gQHQtByhz33z7N7JT1qGnU5V51koxIJsW+ByU6
 jinXTafTQS9SjcqIm5KHEqAcp6AjXf4m2fcrkuorBJCUX5lJjm+2l3X0eehRTascgkaC
 IdqA==
X-Gm-Message-State: APjAAAXXSKRuhCQ18VM4alVwVNglnyXP69VVbZsthR2sTX2gcttp4u50
 GW3w9d0IDonqeqsbisnr3w/rofQ/HoYWuA==
X-Google-Smtp-Source: APXvYqzEIY0+ruDueHoQm9lAIXvoBFoTGZDQ2j7XzszLVSpqtsSzJ6jYgJyVIf8Aug9VIqOl1NuJiQ==
X-Received: by 2002:adf:900e:: with SMTP id h14mr5757364wrh.58.1561999196156; 
 Mon, 01 Jul 2019 09:39:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.39.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:39:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:08 +0100
Message-Id: <20190701163943.22313-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.49
Subject: [Qemu-devel] [PULL 11/46] hw: timer: Add ASPEED RTC device
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

From: Joel Stanley <joel@jms.id.au>

The RTC is modeled to provide time and date functionality. It is
initialised at zero to match the hardware.

There is no modelling of the alarm functionality, which includes the IRQ
line. As there is no guest code to exercise this function that is
acceptable for now.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190618165311.27066-4-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/Makefile.objs        |   2 +-
 include/hw/timer/aspeed_rtc.h |  31 ++++++
 hw/timer/aspeed_rtc.c         | 180 ++++++++++++++++++++++++++++++++++
 hw/timer/trace-events         |   4 +
 4 files changed, 216 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/timer/aspeed_rtc.h
 create mode 100644 hw/timer/aspeed_rtc.c

diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 0e9a4530f84..123d92c9692 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -41,7 +41,7 @@ obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
 obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
 
 common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
-common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o
+common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o aspeed_rtc.o
 
 common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
 common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
diff --git a/include/hw/timer/aspeed_rtc.h b/include/hw/timer/aspeed_rtc.h
new file mode 100644
index 00000000000..1f1155a676c
--- /dev/null
+++ b/include/hw/timer/aspeed_rtc.h
@@ -0,0 +1,31 @@
+/*
+ * ASPEED Real Time Clock
+ * Joel Stanley <joel@jms.id.au>
+ *
+ * Copyright 2019 IBM Corp
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef ASPEED_RTC_H
+#define ASPEED_RTC_H
+
+#include <stdint.h>
+
+#include "hw/hw.h"
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+
+typedef struct AspeedRtcState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    uint32_t reg[0x18];
+    int offset;
+
+} AspeedRtcState;
+
+#define TYPE_ASPEED_RTC "aspeed.rtc"
+#define ASPEED_RTC(obj) OBJECT_CHECK(AspeedRtcState, (obj), TYPE_ASPEED_RTC)
+
+#endif /* ASPEED_RTC_H */
diff --git a/hw/timer/aspeed_rtc.c b/hw/timer/aspeed_rtc.c
new file mode 100644
index 00000000000..19f061c846e
--- /dev/null
+++ b/hw/timer/aspeed_rtc.c
@@ -0,0 +1,180 @@
+/*
+ * ASPEED Real Time Clock
+ * Joel Stanley <joel@jms.id.au>
+ *
+ * Copyright 2019 IBM Corp
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "hw/timer/aspeed_rtc.h"
+#include "qemu/log.h"
+#include "qemu/timer.h"
+
+#include "trace.h"
+
+#define COUNTER1        (0x00 / 4)
+#define COUNTER2        (0x04 / 4)
+#define ALARM           (0x08 / 4)
+#define CONTROL         (0x10 / 4)
+#define ALARM_STATUS    (0x14 / 4)
+
+#define RTC_UNLOCKED    BIT(1)
+#define RTC_ENABLED     BIT(0)
+
+static void aspeed_rtc_calc_offset(AspeedRtcState *rtc)
+{
+    struct tm tm;
+    uint32_t year, cent;
+    uint32_t reg1 = rtc->reg[COUNTER1];
+    uint32_t reg2 = rtc->reg[COUNTER2];
+
+    tm.tm_mday = (reg1 >> 24) & 0x1f;
+    tm.tm_hour = (reg1 >> 16) & 0x1f;
+    tm.tm_min = (reg1 >> 8) & 0x3f;
+    tm.tm_sec = (reg1 >> 0) & 0x3f;
+
+    cent = (reg2 >> 16) & 0x1f;
+    year = (reg2 >> 8) & 0x7f;
+    tm.tm_mon = ((reg2 >>  0) & 0x0f) - 1;
+    tm.tm_year = year + (cent * 100) - 1900;
+
+    rtc->offset = qemu_timedate_diff(&tm);
+}
+
+static uint32_t aspeed_rtc_get_counter(AspeedRtcState *rtc, int r)
+{
+    uint32_t year, cent;
+    struct tm now;
+
+    qemu_get_timedate(&now, rtc->offset);
+
+    switch (r) {
+    case COUNTER1:
+        return (now.tm_mday << 24) | (now.tm_hour << 16) |
+            (now.tm_min << 8) | now.tm_sec;
+    case COUNTER2:
+        cent = (now.tm_year + 1900) / 100;
+        year = now.tm_year % 100;
+        return ((cent & 0x1f) << 16) | ((year & 0x7f) << 8) |
+            ((now.tm_mon + 1) & 0xf);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint64_t aspeed_rtc_read(void *opaque, hwaddr addr,
+                                unsigned size)
+{
+    AspeedRtcState *rtc = opaque;
+    uint64_t val;
+    uint32_t r = addr >> 2;
+
+    switch (r) {
+    case COUNTER1:
+    case COUNTER2:
+        if (rtc->reg[CONTROL] & RTC_ENABLED) {
+            rtc->reg[r] = aspeed_rtc_get_counter(rtc, r);
+        }
+        /* fall through */
+    case CONTROL:
+        val = rtc->reg[r];
+        break;
+    case ALARM:
+    case ALARM_STATUS:
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx "\n", __func__, addr);
+        return 0;
+    }
+
+    trace_aspeed_rtc_read(addr, val);
+
+    return val;
+}
+
+static void aspeed_rtc_write(void *opaque, hwaddr addr,
+                             uint64_t val, unsigned size)
+{
+    AspeedRtcState *rtc = opaque;
+    uint32_t r = addr >> 2;
+
+    switch (r) {
+    case COUNTER1:
+    case COUNTER2:
+        if (!(rtc->reg[CONTROL] & RTC_UNLOCKED)) {
+            break;
+        }
+        /* fall through */
+    case CONTROL:
+        rtc->reg[r] = val;
+        aspeed_rtc_calc_offset(rtc);
+        break;
+    case ALARM:
+    case ALARM_STATUS:
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx "\n", __func__, addr);
+        break;
+    }
+    trace_aspeed_rtc_write(addr, val);
+}
+
+static void aspeed_rtc_reset(DeviceState *d)
+{
+    AspeedRtcState *rtc = ASPEED_RTC(d);
+
+    rtc->offset = 0;
+    memset(rtc->reg, 0, sizeof(rtc->reg));
+}
+
+static const MemoryRegionOps aspeed_rtc_ops = {
+    .read = aspeed_rtc_read,
+    .write = aspeed_rtc_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static const VMStateDescription vmstate_aspeed_rtc = {
+    .name = TYPE_ASPEED_RTC,
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(reg, AspeedRtcState, 0x18),
+        VMSTATE_INT32(offset, AspeedRtcState),
+        VMSTATE_INT32(offset, AspeedRtcState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void aspeed_rtc_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedRtcState *s = ASPEED_RTC(dev);
+
+    sysbus_init_irq(sbd, &s->irq);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_rtc_ops, s,
+                          "aspeed-rtc", 0x18ULL);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void aspeed_rtc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = aspeed_rtc_realize;
+    dc->vmsd = &vmstate_aspeed_rtc;
+    dc->reset = aspeed_rtc_reset;
+}
+
+static const TypeInfo aspeed_rtc_info = {
+    .name          = TYPE_ASPEED_RTC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AspeedRtcState),
+    .class_init    = aspeed_rtc_class_init,
+};
+
+static void aspeed_rtc_register_types(void)
+{
+    type_register_static(&aspeed_rtc_info);
+}
+
+type_init(aspeed_rtc_register_types)
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index dcaf3d6da6c..db02a9142cd 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -66,6 +66,10 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK A
 cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
 
+# hw/timer/aspeed-rtc.c
+aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
+aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
+
 # sun4v-rtc.c
 sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 " value 0x%" PRIx64
 sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 " value 0x%" PRIx64
-- 
2.20.1


