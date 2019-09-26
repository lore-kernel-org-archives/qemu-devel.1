Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169A1C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD00421D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNXrZfs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD00421D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDXts-0000wj-SD
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgG-0004SM-BI
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgE-0002sh-IM
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgE-0002sH-BV; Thu, 26 Sep 2019 13:35:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so3705278wru.7;
 Thu, 26 Sep 2019 10:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kskdVuLQCPaH6Xp1rulbaOs6j5l5CnUBB+uNJbXgnDc=;
 b=mNXrZfs3/JC/MRVyZmuWrCxGg/bFOdrfX0dK7lwwH76fipZczdazhuh3df3WMOmxHg
 3QAEQKRnWoce0IfCYn8F6lG7Q3IIqvP1PT0Q/6SWWkAwsAh5fe2vtzMt9nQQHhkyxp1k
 J4eLhal+tTTmhSaW6ekaWhBmbBpd2sjLa1Ejz9L/zle2nCn7Kl8Tv6D3UUqXnwan1pO0
 ZDkuBZC6t1gRJMGxFHaDQu7CiTKfZnJ6XH71IzjH5tWwad7mbr5liv75oCc0NChOxNLQ
 B4upw2f49RGtrmv7SGMDVrT2rM2qyA/wvft3XfeM2FB8XgaOQpOsiMmutFKXkayxdlbq
 IZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kskdVuLQCPaH6Xp1rulbaOs6j5l5CnUBB+uNJbXgnDc=;
 b=GRFg5aJTnZth0YDbaRlqM2f9abKPcYOKxq8GgceDHuQvMddBn4IRuSQzYUyyb0Ap9R
 31r9Jgx1LSjpHKhml6HXeGzpspXv8AjCnv5lbwbViid+LukRfq+87Yd5tsPL2AR8oPzc
 tWQsA6eruEzOMi400fxXEMBYiI9b4/LUiflmCB4kkNamvV63hgwizqLNaWX4TjE75N1Z
 ey8ryCMD8h0kFfVpIkLZT10UkgCui0luxzHXX0Knk27IvZyyyPdxDPV2kqPSstpZk6W0
 hj2uI3fdA7lyI3UmRO4Eu9tAmPnmBWfeBF+yGgggO/mfAlVTLg8CMjp7zoRob3guLVFv
 wQ0Q==
X-Gm-Message-State: APjAAAVqOn4CPbKnRy71MLYuypCKKrrGsDzNsw0HDqsRkPhe0AnlzO7e
 XcPI0PujnWD/WhslTEyeKgIvkcYYNEY=
X-Google-Smtp-Source: APXvYqxZrtIOrMOXTDvgpV/Kv08LRzQeF0PP4oUJmV7WJkDQJhHv/e2VaE41bbW7xZ9ODnEKCnY2ZA==
X-Received: by 2002:adf:f406:: with SMTP id g6mr3722246wro.325.1569519289031; 
 Thu, 26 Sep 2019 10:34:49 -0700 (PDT)
Received: from x1w.redhat.com (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b186sm9918980wmd.16.2019.09.26.10.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 10:34:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/19] hw/misc/bcm2835_thermal: Add a dummy BCM2835 thermal
 sensor
Date: Thu, 26 Sep 2019 19:34:16 +0200
Message-Id: <20190926173428.10713-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926173428.10713-1-f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
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
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
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
checkpatch warning:
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
This is OK because the regex are:

  F: hw/*/bcm283*
  F: include/hw/*/bcm283*
---
 hw/misc/Makefile.objs             |   1 +
 hw/misc/bcm2835_thermal.c         | 109 ++++++++++++++++++++++++++++++
 include/hw/misc/bcm2835_thermal.h |  27 ++++++++
 3 files changed, 137 insertions(+)
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
index 0000000000..bac23f21ea
--- /dev/null
+++ b/hw/misc/bcm2835_thermal.c
@@ -0,0 +1,109 @@
+/*
+ * BCM2835 dummy thermal sensor
+ *
+ * Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/misc/bcm2835_thermal.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/registerfields.h"
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
+        val = FIELD_DP32(bcm2835_thermal_temp2adc(25), STAT, VALID, true);
+        break;
+    default:
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
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write 0x%" PRIx64
+                                       " to 0x%" HWADDR_PRIx "\n",
+                       __func__, value, addr);
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
+static void bcm2835_thermal_realize(DeviceState *dev, Error **errp)
+{
+    Bcm2835ThermalState *s = BCM2835_THERMAL(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &bcm2835_thermal_ops,
+                          s, TYPE_BCM2835_THERMAL, 8);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+}
+
+static void bcm2835_thermal_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2835_thermal_realize;
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
index 0000000000..f85cce7214
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
+#ifndef HW_MISC_BCM2835_THERMAL_H
+#define HW_MISC_BCM2835_THERMAL_H
+
+#include "hw/qdev-properties.h"
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
2.20.1


