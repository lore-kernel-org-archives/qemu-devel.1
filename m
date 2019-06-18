Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F141C31E5E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:15:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D95E214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D95E214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60378 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHi2-0005lm-JR
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 13:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60263)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hdHMp-0007sd-3J
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hdHMn-0003nE-3p
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:53:54 -0400
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:39571)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hdHMl-0003iD-7b
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:53:53 -0400
Received: from player157.ha.ovh.net (unknown [10.108.42.168])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 2FE1D132554
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 18:53:48 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id A8ED56EB510B;
 Tue, 18 Jun 2019 16:53:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 18:52:53 +0200
Message-Id: <20190618165311.27066-4-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190618165311.27066-1-clg@kaod.org>
References: <20190618165311.27066-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 1664924489653652241
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrtddtgdejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.79.203
Subject: [Qemu-devel] [PATCH v2 03/21] hw: timer: Add ASPEED RTC device
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
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
---
 include/hw/timer/aspeed_rtc.h |  31 ++++++
 hw/timer/aspeed_rtc.c         | 180 ++++++++++++++++++++++++++++++++++
 hw/timer/Makefile.objs        |   2 +-
 hw/timer/trace-events         |   4 +
 4 files changed, 216 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/timer/aspeed_rtc.h
 create mode 100644 hw/timer/aspeed_rtc.c

diff --git a/include/hw/timer/aspeed_rtc.h b/include/hw/timer/aspeed_rtc.=
h
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
+#define ASPEED_RTC(obj) OBJECT_CHECK(AspeedRtcState, (obj), TYPE_ASPEED_=
RTC)
+
+#endif /* ASPEED_RTC_H */
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
+    uint32_t reg1 =3D rtc->reg[COUNTER1];
+    uint32_t reg2 =3D rtc->reg[COUNTER2];
+
+    tm.tm_mday =3D (reg1 >> 24) & 0x1f;
+    tm.tm_hour =3D (reg1 >> 16) & 0x1f;
+    tm.tm_min =3D (reg1 >> 8) & 0x3f;
+    tm.tm_sec =3D (reg1 >> 0) & 0x3f;
+
+    cent =3D (reg2 >> 16) & 0x1f;
+    year =3D (reg2 >> 8) & 0x7f;
+    tm.tm_mon =3D ((reg2 >>  0) & 0x0f) - 1;
+    tm.tm_year =3D year + (cent * 100) - 1900;
+
+    rtc->offset =3D qemu_timedate_diff(&tm);
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
+        cent =3D (now.tm_year + 1900) / 100;
+        year =3D now.tm_year % 100;
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
+    AspeedRtcState *rtc =3D opaque;
+    uint64_t val;
+    uint32_t r =3D addr >> 2;
+
+    switch (r) {
+    case COUNTER1:
+    case COUNTER2:
+        if (rtc->reg[CONTROL] & RTC_ENABLED) {
+            rtc->reg[r] =3D aspeed_rtc_get_counter(rtc, r);
+        }
+        /* fall through */
+    case CONTROL:
+        val =3D rtc->reg[r];
+        break;
+    case ALARM:
+    case ALARM_STATUS:
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx "\n", __func__, a=
ddr);
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
+    AspeedRtcState *rtc =3D opaque;
+    uint32_t r =3D addr >> 2;
+
+    switch (r) {
+    case COUNTER1:
+    case COUNTER2:
+        if (!(rtc->reg[CONTROL] & RTC_UNLOCKED)) {
+            break;
+        }
+        /* fall through */
+    case CONTROL:
+        rtc->reg[r] =3D val;
+        aspeed_rtc_calc_offset(rtc);
+        break;
+    case ALARM:
+    case ALARM_STATUS:
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx "\n", __func__, a=
ddr);
+        break;
+    }
+    trace_aspeed_rtc_write(addr, val);
+}
+
+static void aspeed_rtc_reset(DeviceState *d)
+{
+    AspeedRtcState *rtc =3D ASPEED_RTC(d);
+
+    rtc->offset =3D 0;
+    memset(rtc->reg, 0, sizeof(rtc->reg));
+}
+
+static const MemoryRegionOps aspeed_rtc_ops =3D {
+    .read =3D aspeed_rtc_read,
+    .write =3D aspeed_rtc_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+};
+
+static const VMStateDescription vmstate_aspeed_rtc =3D {
+    .name =3D TYPE_ASPEED_RTC,
+    .version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(reg, AspeedRtcState, 0x18),
+        VMSTATE_INT32(offset, AspeedRtcState),
+        VMSTATE_INT32(offset, AspeedRtcState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void aspeed_rtc_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
+    AspeedRtcState *s =3D ASPEED_RTC(dev);
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
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D aspeed_rtc_realize;
+    dc->vmsd =3D &vmstate_aspeed_rtc;
+    dc->reset =3D aspeed_rtc_reset;
+}
+
+static const TypeInfo aspeed_rtc_info =3D {
+    .name          =3D TYPE_ASPEED_RTC,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(AspeedRtcState),
+    .class_init    =3D aspeed_rtc_class_init,
+};
+
+static void aspeed_rtc_register_types(void)
+{
+    type_register_static(&aspeed_rtc_info);
+}
+
+type_init(aspeed_rtc_register_types)
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 0e9a4530f848..123d92c9692c 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -41,7 +41,7 @@ obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
 obj-$(CONFIG_ALLWINNER_A10_PIT) +=3D allwinner-a10-pit.o
=20
 common-obj-$(CONFIG_STM32F2XX_TIMER) +=3D stm32f2xx_timer.o
-common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o
+common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o aspeed_rtc.o
=20
 common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
 common-obj-$(CONFIG_CMSDK_APB_TIMER) +=3D cmsdk-apb-timer.o
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index dcaf3d6da6c8..db02a9142cda 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -66,6 +66,10 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t dat=
a, unsigned size) "CMSDK A
 cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned size)=
 "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size=
 %u"
 cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
=20
+# hw/timer/aspeed-rtc.c
+aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " val=
ue 0x%08" PRIx64
+aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " va=
lue 0x%08" PRIx64
+
 # sun4v-rtc.c
 sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 " =
value 0x%" PRIx64
 sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 =
" value 0x%" PRIx64
--=20
2.21.0


