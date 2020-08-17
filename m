Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E6FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A4A2086A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njsTThuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A4A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hu8-0000Je-Av
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqp-0002AT-3p
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqj-00053p-TA
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:07 -0400
Received: by mail-wr1-x443.google.com with SMTP id a14so15590994wra.5
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 09:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nze7jC5IQ7XtWKm+MoCag4YtUZHhhwLInYZxRLq04cU=;
 b=njsTThucngzHh2Tk7Ax39O7kyKvHY1wSwos0lAUWHjgIhISdzUYsSqsyLD/k43KwCZ
 UqFkvSARUi+tcp5VvIfEmEG0A0ItdYB7oMg+jjq/9zy1/j+M+hyFwZYp1gInWxUNYPn9
 FUg+iIF1VvRWt8trjUIK1TrJNRH7DG7y7WpLNIdfzT7E2u60X2JjsTebHbMfOalJzu2q
 UN+QGsnqa+RgSk7jGAW0w1Q87+Zbguu8GY7Yt/6tS90hQ6hfJWsJGzjhHOs4+9nSVVsu
 fKjbzzN319knRW+8GcNPVRWC/PdeVJAix9NGzR+sV35kGB1VbfLBvjNtirPtdQPhhgRM
 Ldog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nze7jC5IQ7XtWKm+MoCag4YtUZHhhwLInYZxRLq04cU=;
 b=tMhycbcN66il40mMJJ5CkbYJmxZwqYk2SYVNUtTcQS8WOkixZhSudZroaEKIN23HlD
 bMc+POSwxwVcPwR/yzCwwgPzOIlvySUQoPR/4Cz1l2yRlnDqXD3EY2HzdeYsyrL7A4nw
 Qk+Qm+30gAonDIHwlKVUtzYvX63e8svclQ6Kuy8kK/ONH/DsGgShrqLyJZpG5msM58NU
 xZViyrG5t5O6kMy1yj4EVIvv6bXAMhMkQ6HLjtX97BGw6B2N3Zoj+pctPPg6DW/j8Abs
 JLAJbfeflXAJKuF8mRABmjag6zWow/VzVrPqyZEk6PECFj39H48cqPwhtxMmnLqyw8aD
 bQwA==
X-Gm-Message-State: AOAM531Z3RrnkA/9v1JeZNzUXD5U48SphmpYnoGlJ5nK23mezq/9JaR2
 w0G3LxMX6LSN+i84WIkyd60IGjaCO1E=
X-Google-Smtp-Source: ABdhPJzBfWzVkTijcjrSAnSjtyrnoRhC3aWNnHw8VMDLaSSSXAtNIY9fQddXC9jVAs1pK4ziN79eOw==
X-Received: by 2002:adf:f8d0:: with SMTP id f16mr17220377wrq.66.1597681144195; 
 Mon, 17 Aug 2020 09:19:04 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id r3sm29535472wro.1.2020.08.17.09.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 09:19:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 5/9] hw/misc: Add MMIO test device
Date: Mon, 17 Aug 2020 18:18:49 +0200
Message-Id: <20200817161853.593247-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817161853.593247-1-f4bug@amsat.org>
References: <20200817161853.593247-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a MMIO test device handy to test QEMU internal devices via MMIO
accesses.

This device is meant to be run by the 'none' machine, thus no CPU
is required.

So far it is only useful to test the interleaver device.
A SRAM region is split into 256B subregions, and these subregions
are mapped at different addresses in an interleaved setup.
All the following (INPUT x OUTPUT) configurations can be tested:
16x8, 32x8, 32x16, 64x8, 64x16 and 64x32.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/testdev.h |  15 ++++
 hw/misc/mmio-testdev.c    | 146 ++++++++++++++++++++++++++++++++++++++
 MAINTAINERS               |   2 +
 hw/misc/Kconfig           |   5 ++
 hw/misc/Makefile.objs     |   1 +
 5 files changed, 169 insertions(+)
 create mode 100644 include/hw/misc/testdev.h
 create mode 100644 hw/misc/mmio-testdev.c

diff --git a/include/hw/misc/testdev.h b/include/hw/misc/testdev.h
new file mode 100644
index 0000000000..2ff47d2766
--- /dev/null
+++ b/include/hw/misc/testdev.h
@@ -0,0 +1,15 @@
+/*
+ * QEMU MMIO test device
+ *
+ * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_TESTDEV_H
+#define HW_MISC_TESTDEV_H
+
+#define TYPE_MMIO_TESTDEV "mmio-testdev"
+
+#endif
+
diff --git a/hw/misc/mmio-testdev.c b/hw/misc/mmio-testdev.c
new file mode 100644
index 0000000000..3b7a8057b2
--- /dev/null
+++ b/hw/misc/mmio-testdev.c
@@ -0,0 +1,146 @@
+/*
+ * QEMU MMIO test device
+ *
+ * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/*
+ * This device is mostly used to test QEMU internal MMIO devices.
+ * Accesses using CPU core are not allowed.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "exec/address-spaces.h"
+#include "hw/misc/testdev.h"
+#include "hw/misc/interleaver.h"
+
+/*
+ * Device Memory Map:
+ *
+ *   offset       size         description
+ * ----------  ----------  --------------------
+ * 0x00000000  [   2 KiB]  SRAM (8 banks of 256B)
+ * 0x10000000  [ 128 MiB]  interleaved-container
+ * 0x11608000  [   4 KiB]  interleaved-16x8  (each device interleaves the sram)
+ * 0x13208000  [   8 KiB]  interleaved-32x8   "
+ * 0x13216000  [   4 KiB]  interleaved-32x16  "
+ * 0x16408000  [  16 KiB]  interleaved-64x8   "
+ * 0x16416000  [   8 KiB]  interleaved-64x16  "
+ * 0x16432000  [   4 KiB]  interleaved-64x32  "
+ * 0x20000000  [ 256 MiB]  container
+ *
+ * All gap regions are reserved.
+ */
+
+typedef struct MmioTestDevice {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion container;
+    MemoryRegion sram;
+    MemoryRegion sram_alias[8];
+    MemoryRegion interleaver_container;
+    MemoryRegion iomem;
+
+    uint64_t base;
+} MmioTestDevice;
+
+#define TESTDEV(obj) \
+     OBJECT_CHECK(MmioTestDevice, (obj), TYPE_MMIO_TESTDEV)
+
+static void mmio_testdev_realize(DeviceState *dev, Error **errp)
+{
+    static const unsigned bhexs[] = {
+        [8] = 0x8, [16] = 0x16, [32] = 0x32, [64] = 0x64,
+    };
+    static const struct {
+        unsigned in, out;
+        const char *typename;
+    } cfg[] = {
+        {16, 8,  TYPE_INTERLEAVER_16X8_DEVICE},
+        {32, 8,  TYPE_INTERLEAVER_32X8_DEVICE},
+        {32, 16, TYPE_INTERLEAVER_32X16_DEVICE},
+        {64, 8,  TYPE_INTERLEAVER_64X8_DEVICE},
+        {64, 16, TYPE_INTERLEAVER_64X16_DEVICE},
+        {64, 32, TYPE_INTERLEAVER_64X32_DEVICE},
+    };
+    MmioTestDevice *s = TESTDEV(dev);
+    DeviceState *interleaver;
+
+    if (s->base == UINT64_MAX) {
+        error_setg(errp, "property 'address' not specified or zero");
+        return;
+    }
+
+    memory_region_init(&s->container, OBJECT(s), "testdev", 0x20000000);
+
+    memory_region_init_ram(&s->sram, OBJECT(s), "testdev-sram",
+                           0x800, &error_fatal);
+    memory_region_add_subregion(&s->container, 0x000000, &s->sram);
+
+    /* interleaved memory */
+    memory_region_init(&s->interleaver_container, OBJECT(s),
+                       "interleaver-container", 0x8000000);
+    memory_region_add_subregion(&s->container, 0x10000000,
+                                &s->interleaver_container);
+    for (unsigned i = 0; i < 8; i++) {
+        g_autofree char *name = g_strdup_printf("sram-p%u", i);
+        /* Each alias access a 256B region of the SRAM */
+        memory_region_init_alias(&s->sram_alias[i], OBJECT(s), name,
+                                 &s->sram, i * 0x100, 0x100);
+    }
+    for (size_t i = 0; i < ARRAY_SIZE(cfg); i++) {
+        unsigned count = cfg[i].in / cfg[i].out;
+
+        interleaver = qdev_new(cfg[i].typename);
+        qdev_prop_set_uint64(interleaver, "size", count * 0x100);
+        /* Map 256B SRAM regions on interleaver banks */
+        for (unsigned c = 0; c < count; c++) {
+            g_autofree char *prop_name = g_strdup_printf("mr%u", c);
+            object_property_set_link(OBJECT(interleaver), prop_name,
+                                     OBJECT(&s->sram_alias[c]), &error_abort);
+        }
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(interleaver), &error_fatal);
+        memory_region_add_subregion(&s->interleaver_container,
+                (bhexs[cfg[i].in] << 20) | (bhexs[cfg[i].out] << 12),
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(interleaver), 0));
+    }
+
+    memory_region_add_subregion(get_system_memory(), s->base, &s->container);
+}
+
+static Property mmio_testdev_properties[] = {
+    DEFINE_PROP_UINT64("address", MmioTestDevice, base, UINT64_MAX),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void mmio_testdev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = mmio_testdev_realize;
+    dc->user_creatable = true;
+    device_class_set_props(dc, mmio_testdev_properties);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo mmio_testdev_info = {
+    .name           = TYPE_MMIO_TESTDEV,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(MmioTestDevice),
+    .class_init     = mmio_testdev_class_init,
+};
+
+static void mmio_testdev_register_types(void)
+{
+    type_register_static(&mmio_testdev_info);
+}
+
+type_init(mmio_testdev_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 1efce3dd27..f75b8c984a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1966,6 +1966,8 @@ M: Philippe Mathieu-Daudé <f4bug@amsat.org>
 S: Maintained
 F: include/hw/misc/interleaver.h
 F: hw/misc/interleaver.c
+F: hw/misc/mmio-testdev.c
+F: include/hw/misc/testdev.h
 
 Standard VGA
 M: Gerd Hoffmann <kraxel@redhat.com>
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 7ed0f4ccc7..5b101abeea 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -30,6 +30,11 @@ config ISA_TESTDEV
     default y if TEST_DEVICES
     depends on ISA_BUS
 
+config MMIO_TESTDEV
+    bool
+    default y if TEST_DEVICES
+    depends on INTERLEAVER
+
 config PCI_TESTDEV
     bool
     default y if TEST_DEVICES
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index aa753a847f..b3e7da7177 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -5,6 +5,7 @@ common-obj-$(CONFIG_TMP421) += tmp421.o
 common-obj-$(CONFIG_ISA_DEBUG) += debugexit.o
 common-obj-$(CONFIG_SGA) += sga.o
 common-obj-$(CONFIG_ISA_TESTDEV) += pc-testdev.o
+common-obj-$(CONFIG_MMIO_TESTDEV) += mmio-testdev.o
 common-obj-$(CONFIG_PCI_TESTDEV) += pci-testdev.o
 common-obj-$(CONFIG_EDU) += edu.o
 common-obj-$(CONFIG_PCA9552) += pca9552.o
-- 
2.26.2


