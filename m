Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6163CCA9EB3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3144D21D7A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Maeg2k61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3144D21D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLEk3-00025z-V0
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 18:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEif-0000GO-PW
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEie-0002I9-8S
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:58:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEie-0002HM-1x; Thu, 17 Oct 2019 18:58:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id i16so4174637wmd.3;
 Thu, 17 Oct 2019 15:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nOKNgWomZ9lXuw/D4odL98GxIJfJYjVtBJTZV5RcceI=;
 b=Maeg2k61piCHIXluhyO9gUNYNExzByQFk2wqlb1mahUZz8dU9FrqMb9QrtBHLxnSkP
 JDwLhtgio/87nmfb6fhzrRbEhlQkRTs3RfWTlSU6zp50NqbAXEGHnoKeBh6JRhQN2hk/
 Ozj+jVKaVFjE3i69X0H2vTSIL148HQpcZywb0RnyzKZyUTxCCH5qSsdyniASIaCGXBs0
 7O/cEEgz1xocWda1a+nxWGJdtfNGQonw8UwAVBN7kIdUjs+PsnvgAGRwyruHspZyaLKw
 bHvD1tiPegvkTdGUaztQ4E6i+wH3Y+V5Fjn+grixGSdK9izRNz/wT6iZ+MAFrSqzGGDq
 FfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nOKNgWomZ9lXuw/D4odL98GxIJfJYjVtBJTZV5RcceI=;
 b=VtkIqTvMdrlNybkfq8iTE5scB2auZZ9SD6dAh+EDYbwxQUgTT4eoqNkv0DXcHJo+Ok
 kI1xbr8sJ3SlpBrI7wlQtpdT7zxcnvWLEZZ07S1B2/87l/0nX67uqMpIhTYTUv3KAaPk
 qWKx1wS4sNvTGLzAO8LCJRhOQTPFkwarLpvjMpEvgeu4P2iCBpRauJdhwlKHSB3RRS0y
 oM7DO0BvO6OwyoKerOrep0iMMWB1scNcoEr+x5iA6vhpfDCsTBB172sSqOwj91gStl4b
 eZG7FDC9JGfRsXjtqsEORUlzszyOG8tz9aWoWmAyCCmjyuteWRZRbrCW/Ywe1QakHoBk
 I7tw==
X-Gm-Message-State: APjAAAX7F5UcqtMvoUrbKZztQoL/YUyFr6i3TG801mtE3U2AAfjqlGdp
 4JchaoH69COsrtDs2ISNbPdgtFd2
X-Google-Smtp-Source: APXvYqzavyHeErn4Mr/TYhYSbRkUgbu95g4EvOf8OcPaMoJ9Go990ddsSowBB4yGf3Cs/mZzg0EVGw==
X-Received: by 2002:a05:600c:21da:: with SMTP id
 x26mr4833814wmj.152.1571353086254; 
 Thu, 17 Oct 2019 15:58:06 -0700 (PDT)
Received: from localhost.localdomain (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id m18sm3993873wrg.97.2019.10.17.15.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 15:58:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/10] hw/misc/bcm2835_thermal: Add a dummy BCM2835 thermal
 sensor
Date: Fri, 18 Oct 2019 00:57:51 +0200
Message-Id: <20191017225800.6946-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017225800.6946-1-f4bug@amsat.org>
References: <20191017225800.6946-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Pekka Enberg <penberg@iki.fi>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Pete Batard <pete@akeo.ie>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Clement Deschamps <clement.deschamps@antfield.fr>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will soon implement the SYS_timer. This timer is used by Linux
in the thermal subsystem, so once available, the subsystem will be
enabled and poll the temperature sensors. We need to provide the
minimum required to keep Linux booting.

Add a dummy thermal sensor returning ~25°C based on:
https://github.com/raspberrypi/linux/blob/rpi-5.3.y/drivers/thermal/broadcom/bcm2835_thermal.c

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2:
- Explicit g_assert_not_reached() with comment (Alex)
- Add vmstate and reset handler (Peter)

checkpatch warning:
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
This is OK because the regex are:

  F: hw/*/bcm283*
  F: include/hw/*/bcm283*
---
 hw/misc/Makefile.objs             |   1 +
 hw/misc/bcm2835_thermal.c         | 135 ++++++++++++++++++++++++++++++
 include/hw/misc/bcm2835_thermal.h |  27 ++++++
 3 files changed, 163 insertions(+)
 create mode 100644 hw/misc/bcm2835_thermal.c
 create mode 100644 include/hw/misc/bcm2835_thermal.h

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index a150680966..c89f3816a5 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -53,6 +53,7 @@ common-obj-$(CONFIG_OMAP) += omap_tap.o
 common-obj-$(CONFIG_RASPI) += bcm2835_mbox.o
 common-obj-$(CONFIG_RASPI) += bcm2835_property.o
 common-obj-$(CONFIG_RASPI) += bcm2835_rng.o
+common-obj-$(CONFIG_RASPI) += bcm2835_thermal.o
 common-obj-$(CONFIG_SLAVIO) += slavio_misc.o
 common-obj-$(CONFIG_ZYNQ) += zynq_slcr.o
 common-obj-$(CONFIG_ZYNQ) += zynq-xadc.o
diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
new file mode 100644
index 0000000000..c6f3b1ad60
--- /dev/null
+++ b/hw/misc/bcm2835_thermal.c
@@ -0,0 +1,135 @@
+/*
+ * BCM2835 dummy thermal sensor
+ *
+ * Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/misc/bcm2835_thermal.h"
+#include "hw/registerfields.h"
+#include "migration/vmstate.h"
+
+REG32(CTL, 0)
+FIELD(CTL, POWER_DOWN, 0, 1)
+FIELD(CTL, RESET, 1, 1)
+FIELD(CTL, BANDGAP_CTRL, 2, 3)
+FIELD(CTL, INTERRUPT_ENABLE, 5, 1)
+FIELD(CTL, DIRECT, 6, 1)
+FIELD(CTL, INTERRUPT_CLEAR, 7, 1)
+FIELD(CTL, HOLD, 8, 10)
+FIELD(CTL, RESET_DELAY, 18, 8)
+FIELD(CTL, REGULATOR_ENABLE, 26, 1)
+
+REG32(STAT, 4)
+FIELD(STAT, DATA, 0, 10)
+FIELD(STAT, VALID, 10, 1)
+FIELD(STAT, INTERRUPT, 11, 1)
+
+#define THERMAL_OFFSET_C 412
+#define THERMAL_COEFF  (-0.538f)
+
+static uint16_t bcm2835_thermal_temp2adc(int temp_C)
+{
+    return (temp_C - THERMAL_OFFSET_C) / THERMAL_COEFF;
+}
+
+static uint64_t bcm2835_thermal_read(void *opaque, hwaddr addr, unsigned size)
+{
+    Bcm2835ThermalState *s = BCM2835_THERMAL(opaque);
+    uint32_t val = 0;
+
+    switch (addr) {
+    case A_CTL:
+        val = s->ctl;
+        break;
+    case A_STAT:
+        /* Temperature is constantly 25°C. */
+        val = FIELD_DP32(bcm2835_thermal_temp2adc(25), STAT, VALID, true);
+        break;
+    default:
+        /* MemoryRegionOps are aligned, so this can not happen. */
+        g_assert_not_reached();
+    }
+    return val;
+}
+
+static void bcm2835_thermal_write(void *opaque, hwaddr addr,
+                                  uint64_t value, unsigned size)
+{
+    Bcm2835ThermalState *s = BCM2835_THERMAL(opaque);
+
+    switch (addr) {
+    case A_CTL:
+        s->ctl = value;
+        break;
+    case A_STAT:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write 0x%" PRIx64
+                                       " to 0x%" HWADDR_PRIx "\n",
+                       __func__, value, addr);
+        break;
+    default:
+        /* MemoryRegionOps are aligned, so this can not happen. */
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps bcm2835_thermal_ops = {
+    .read = bcm2835_thermal_read,
+    .write = bcm2835_thermal_write,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void bcm2835_thermal_reset(DeviceState *dev)
+{
+    Bcm2835ThermalState *s = BCM2835_THERMAL(dev);
+
+    s->ctl = 0;
+}
+
+static void bcm2835_thermal_realize(DeviceState *dev, Error **errp)
+{
+    Bcm2835ThermalState *s = BCM2835_THERMAL(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &bcm2835_thermal_ops,
+                          s, TYPE_BCM2835_THERMAL, 8);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+}
+
+static const VMStateDescription bcm2835_thermal_vmstate = {
+    .name = "bcm2835_thermal",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(ctl, Bcm2835ThermalState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2835_thermal_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2835_thermal_realize;
+    dc->reset = bcm2835_thermal_reset;
+    dc->vmsd = &bcm2835_thermal_vmstate;
+}
+
+static const TypeInfo bcm2835_thermal_info = {
+    .name = TYPE_BCM2835_THERMAL,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Bcm2835ThermalState),
+    .class_init = bcm2835_thermal_class_init,
+};
+
+static void bcm2835_thermal_register_types(void)
+{
+    type_register_static(&bcm2835_thermal_info);
+}
+
+type_init(bcm2835_thermal_register_types)
diff --git a/include/hw/misc/bcm2835_thermal.h b/include/hw/misc/bcm2835_thermal.h
new file mode 100644
index 0000000000..c3651b27ec
--- /dev/null
+++ b/include/hw/misc/bcm2835_thermal.h
@@ -0,0 +1,27 @@
+/*
+ * BCM2835 dummy thermal sensor
+ *
+ * Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_BCM2835_THERMAL_H
+#define HW_MISC_BCM2835_THERMAL_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_BCM2835_THERMAL "bcm2835-thermal"
+
+#define BCM2835_THERMAL(obj) \
+    OBJECT_CHECK(Bcm2835ThermalState, (obj), TYPE_BCM2835_THERMAL)
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+    MemoryRegion iomem;
+    uint32_t ctl;
+} Bcm2835ThermalState;
+
+#endif
-- 
2.21.0


