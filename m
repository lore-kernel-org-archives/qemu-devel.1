Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64149C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 04:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA442075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 04:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIXCyrDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA442075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39019 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLKbA-0007cd-5N
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 00:42:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hLKZo-0006lP-8N
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 00:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hLKZm-0002fV-6q
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 00:41:08 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joel.stan@gmail.com>)
	id 1hLKZg-0002dA-LB; Tue, 30 Apr 2019 00:41:00 -0400
Received: by mail-pg1-x541.google.com with SMTP id p6so6229905pgh.9;
	Mon, 29 Apr 2019 21:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Hg8GeLeh6ssTCo6sGWbRAYZzQgIQhW085DD28eXrhko=;
	b=kIXCyrDERyBvOBYtfVUZ9qMQODT4JaBGSN/45MaVu4m1PzVcHY4kfjgRcoFFdPVCJp
	/tEiiiWS07HyXS682LeT81nOqq5SxFehcxZ6KNG4ggHzLP4eMyVoG/iOkBeNbfm9omGC
	CCrPx0lhLAdfvXGnXPBgbQElqrssSCOmjDfCZSbQSRMoCMoqyRKtciG8O9ZvWmmZxwch
	ZmRMZraSVgXHkXQKMR+RS8POK3JeGCQiSZMCDN8JufG87nxUbxmlIZm3u3MzReMvAB8/
	qyGtAVrJRhkJGXxvoHUUQ1Lf2zcupVEGJ8h/Qy1lvYwEKtROPwy61RwTx3SuNQ++6t5s
	FgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=Hg8GeLeh6ssTCo6sGWbRAYZzQgIQhW085DD28eXrhko=;
	b=PdAmmzLE6+hUGbgKj9wri70U/BDZqYmQl165O5Rke9X+4c3fVtO+uJHCvnfJmdCAJf
	JCQMdmmun/7P0FuNF+LBdbEmb0ztrHdjLXYS4z+1wwEgB18h3CDFgHn1ORUXT+Rx2L79
	lWQl6qthXKKDXLhRmf7nN0VWQPjV+OPN1OT7byEuyIN6beIuDAKrmfzij3qZW2fgBFgP
	en23DOG73lJc6MBobebfd52locRxK7EgxBnvGA9oqa8dY/ds97I1rlT9tMGskw9YFAXT
	IKq4h6LqnwtK3rqagm0CbI51p1ic0NuarG6XKWxke1YOn8EtaLKcbhuDU2Ju4pJIpHOS
	3+MQ==
X-Gm-Message-State: APjAAAXcNTQlgs/mc0QanH23LK0fDVwbbMr3Lu6dA2MfgSTohly/yQgm
	LOre7heeuce0KGlvYFHzQNQ=
X-Google-Smtp-Source: APXvYqx3UIeT6VfOpUQGhCjnfJzRH/jvqBTALaWAKni+iD2RSjLVcMFMtuXObPMLS4gMUCAmO4KU6Q==
X-Received: by 2002:a65:4247:: with SMTP id d7mr19127757pgq.114.1556599258962; 
	Mon, 29 Apr 2019 21:40:58 -0700 (PDT)
Received: from voyager.jms.id.au ([45.124.203.18])
	by smtp.gmail.com with ESMTPSA id y3sm11699580pfe.9.2019.04.29.21.40.54
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 29 Apr 2019 21:40:58 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation);
	Tue, 30 Apr 2019 14:10:51 +0930
From: Joel Stanley <joel@jms.id.au>
To: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 30 Apr 2019 14:10:34 +0930
Message-Id: <20190430044036.1144-2-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430044036.1144-1-joel@jms.id.au>
References: <20190430044036.1144-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v3 1/2] hw: timer: Add ASPEED RTC device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430044034.QZkYbDV-PoEHIb1iMDtfYoNWuq2ngs-QN47dBz0bloc@z>

The RTC is modeled to provide time and date functionality. It is
initialised at zero to match the hardware.

There is no modelling of the alarm functionality, which includes the IRQ
line. As there is no guest code to exercise this function that is
acceptable for now.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3: Add commit message
v2:
 Use g_assert_not_reached
 Add vmstate
 Add reset callback
 Annotate fall through cases
---
 hw/timer/Makefile.objs        |   2 +-
 hw/timer/aspeed_rtc.c         | 180 ++++++++++++++++++++++++++++++++++
 hw/timer/trace-events         |   4 +
 include/hw/timer/aspeed_rtc.h |  31 ++++++
 4 files changed, 216 insertions(+), 1 deletion(-)
 create mode 100644 hw/timer/aspeed_rtc.c
 create mode 100644 include/hw/timer/aspeed_rtc.h

diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 0e9a4530f848..123d92c9692c 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -41,7 +41,7 @@ obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
 obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
 
 common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
-common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o
+common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o aspeed_rtc.o
 
 common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
 common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
diff --git a/hw/timer/aspeed_rtc.c b/hw/timer/aspeed_rtc.c
new file mode 100644
index 000000000000..19f061c846e8
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
index dcaf3d6da6c8..db02a9142cda 100644
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
diff --git a/include/hw/timer/aspeed_rtc.h b/include/hw/timer/aspeed_rtc.h
new file mode 100644
index 000000000000..1f1155a676c1
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
-- 
2.20.1


