Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D74CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC0020820
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNkiDQlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC0020820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLyTB-0001mj-T2
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 19:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRP-0008SY-2z
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRN-0005Th-Hx
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41605)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRN-0005TC-B8; Sat, 19 Oct 2019 19:47:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id p4so9863026wrm.8;
 Sat, 19 Oct 2019 16:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nOKNgWomZ9lXuw/D4odL98GxIJfJYjVtBJTZV5RcceI=;
 b=VNkiDQlKDwkYqAIQOJN1QERDdWHXI9l2RRngztlUPvL+ZknRouJ6JBWN7eO/wTYdRH
 gtUjVJ3ln+StsqnrTIPv1rvxkNGmyc6SaqWE91Y2Vi96cklbjlU0ndSu2mBWJ5kP8LTn
 hrJCfnYpEozuDt6CPVatfgBmLOSJGofLREqMsDl0Qilz50on0VL6uwgvuOJTT6V4yUa/
 xhdqVP9HKYRl/NEpVH4jXzZ+o7D6hWkHQw+T2NsHuS42oAfEUI+ctlubJtg2C0S0D5I4
 FDuUg95EsTkL6GRLlCcR130y8vC8tIEh9hTRydZweUkZ3WSERnJgu8W4CwgZ623/JI+D
 JX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nOKNgWomZ9lXuw/D4odL98GxIJfJYjVtBJTZV5RcceI=;
 b=TN3t5KDtP7nSAXuNwhxYDFktkL6Lq6evBa+Wr0Qq7TbIw1BXS5xLEuG0dH0+MBUyrj
 JCX51s9Bd9YusbpB4g0VPOcdYBg7urtHnS8QeIZctk9gurkhbqEKJ2G3A4iV4igg82Kw
 ZRJTgPYRUeCTwTPnL9dery7lf+v1nVgHl/Rd21IHgHuj0bPeGV7vM35s/TYcegvoH5nU
 fSeqa5fOt9nl3nsCuUGrqhE/3i8FaCKZvWdZvceakSflacdo3Sryem9hxiP2T3s1v9+4
 dnjSrstZ/pjA3kMVaTgjDZKqNeqr3Z8dp0vqpW3WUy6wunjgIcHllYDFwq7V5ex8asuw
 y5RA==
X-Gm-Message-State: APjAAAVAKvRXaKA5nj8q7UrDorE+cjwXa4WVwWAU35+ud4tyFt+fvxgj
 hgZ1K1mWqGqlOIgd+VIXjQosniFL
X-Google-Smtp-Source: APXvYqw9VXMpT/HVWXxv9tl6LUTuXascJP8p/cMJH+JCdo9jXLStX3cNDs9QL3SbshbtjVuOKCetzQ==
X-Received: by 2002:adf:a4ce:: with SMTP id h14mr1411068wrb.263.1571528840035; 
 Sat, 19 Oct 2019 16:47:20 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id u1sm10433763wrp.56.2019.10.19.16.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 16:47:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/16] hw/misc/bcm2835_thermal: Add a dummy BCM2835 thermal
 sensor
Date: Sun, 20 Oct 2019 01:47:00 +0200
Message-Id: <20191019234715.25750-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019234715.25750-1-f4bug@amsat.org>
References: <20191019234715.25750-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
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


