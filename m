Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86200C3F2CD
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 17:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56CFA222C4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 17:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrrUNAFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CFA222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8S3w-0000lE-In
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 12:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j8S1S-0005sH-2s
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j8S1Q-0001j0-Hc
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:04:58 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39619)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j8S1N-0001fA-FX; Sun, 01 Mar 2020 12:04:53 -0500
Received: by mail-pf1-x443.google.com with SMTP id l7so4349871pff.6;
 Sun, 01 Mar 2020 09:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Z4+7AUJj5DR8ek0G/CYhlnGdnmdw4yeNw+orIpOPL7o=;
 b=MrrUNAFs9mPc3RsLAbzDqZiMJaE7bg5xrRD80AoCrcElI8lcdmHPeXScaVAFZL0M0I
 7xH+r97J4naDOFgjWEHD5vUunZ6D2qijPPjtMkayMVa9t5xii6QYgKInGmpBXNTALGjB
 JTFMZosV0jl/kghobXpfm3qP+he2zNcb65OY4dBnlYV7udliRnVQaj2EF+kypfhbQJTd
 0ipNQL2Ol5nfg6fetvPOoyDkVGbMaqftHzL2RBWF0WWcBcHPt3sZhFJmV2GyFypnS1mx
 80Gehhtl+IA3ahCJWM9rTMivTQdENV9R6PxYegS+i7UTOH/y9SzBiEYcieEOmRe4tCFT
 JqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Z4+7AUJj5DR8ek0G/CYhlnGdnmdw4yeNw+orIpOPL7o=;
 b=gWmVbdwoEZb3V5PNLflBdfkQyMdm4DQPTT4bGH/AK0kMY1LCRb851u4ZNCxBiV2WiR
 zfMWSUNaza2zf/IDAlTw0AfleTs0HW8p6tR3jQzA0qVqmjGYeFPDg3VHaYtWzDXtvCHN
 6w45YVJHCmD2ncubDYK/lQwo587WyKh35IAzNnKlHhQ/vwxvt1ic9B057BxCSaP9lBb9
 H6xjlji/ZG9Nub45Ug5E2w2X0aHj9GPLu8Nmo4OghIwTW3vOqSymI5VpejdRbJDMRj+W
 IAotY8OTysrM9W0KPEW81UxUwq0lQ4N/pkuUfI+nRKAPpLTbBluDDkAswO89AbbDTpHM
 Uw5Q==
X-Gm-Message-State: APjAAAU24C/v7qSl9Njb3NMyBYPclN6P7UJ9yzCqPg8TKmsZYV9XgGg9
 k/q4XLhtBZGbr353K2Vp+A8=
X-Google-Smtp-Source: APXvYqxto5rk+muFC92nFVTkeQRc+QL59XNNZi75jRFEL/zjESJn+9CHkTyeUaxmjW1alwLiAtUkOQ==
X-Received: by 2002:a62:e217:: with SMTP id a23mr14178565pfi.50.1583082292495; 
 Sun, 01 Mar 2020 09:04:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id w1sm17855652pgr.4.2020.03.01.09.04.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 01 Mar 2020 09:04:52 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/3] Add dummy i.MXS STMP register support
Date: Sun,  1 Mar 2020 09:04:41 -0800
Message-Id: <20200301170443.12904-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200301170443.12904-1-linux@roeck-us.net>
References: <20200301170443.12904-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

STMP registers are registers with a specific register layout.
When using this layout, a register is implemented as set of four:
- The register itself
- A register to set individual register bits
- A register to reset individual register bits
- A register to toggle individual register bits

This register layout is used in various i.MXS SoCs.

In some cases, bit 31 of a STMP register has special reset functionality.
Setting the reset bit resets the chip or block and then sets bit 30. This
functionality is common enough that the Linux kernel implements a library
function to support it.

This patch implements an STMP register as a special device called STMP
device. An STMP device can be instantiated on top of an unimplemented
device. Each instance implements a single register of this unimplemented
device. In some cases, this is necessary and sufficient to be able to load
a driver.

The term "STMP" originates from the Linux kernel. Its origin and meaning
is unknown to the author, but it seemed to make sense to use the same
terminology here.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/misc/Kconfig        |   3 +
 hw/misc/Makefile.objs  |   1 +
 hw/misc/stmp.c         | 121 +++++++++++++++++++++++++++++++++++++++++
 include/hw/misc/stmp.h |  47 ++++++++++++++++
 4 files changed, 172 insertions(+)
 create mode 100644 hw/misc/stmp.c
 create mode 100644 include/hw/misc/stmp.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index bdd77d8020..68af3f1e2a 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -123,6 +123,9 @@ config AUX
     bool
     select I2C
 
+config STMP
+    bool
+
 config UNIMP
     bool
 
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index da993f45b7..942653854c 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -9,6 +9,7 @@ common-obj-$(CONFIG_PCI_TESTDEV) += pci-testdev.o
 common-obj-$(CONFIG_EDU) += edu.o
 common-obj-$(CONFIG_PCA9552) += pca9552.o
 
+common-obj-$(CONFIG_STMP) += stmp.o
 common-obj-$(CONFIG_UNIMP) += unimp.o
 common-obj-$(CONFIG_FW_CFG_DMA) += vmcoreinfo.o
 
diff --git a/hw/misc/stmp.c b/hw/misc/stmp.c
new file mode 100644
index 0000000000..eb909fccfe
--- /dev/null
+++ b/hw/misc/stmp.c
@@ -0,0 +1,121 @@
+/*
+ * MXS "STMP" dummy device
+ *
+ * This is a dummy device which follows MXS "STMP" register layout.
+ * It's useful for stubbing out regions of an SoC or board
+ * map which correspond to devices that have not yet been
+ * implemented, yet require "STMP" device specific reset support.
+ * This is often sufficient to placate initial guest device
+ * driver probing such that the system will come up.
+ *
+ * Derived from "unimplemented" device code.
+ *      Copyright Linaro Limited, 2017
+ *      Written by Peter Maydell
+ *
+ * Written by Guenter Roeck
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/misc/stmp.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+
+#define REG_VAL                 0x0
+#define REG_SET                 0x4
+#define REG_CLR                 0x8
+#define REG_TOG                 0xc
+
+#define STMP_MODULE_CLKGATE     (1 << 30)
+#define STMP_MODULE_SFTRST      (1 << 31)
+
+static uint64_t stmp_read(void *opaque, hwaddr offset, unsigned size)
+{
+    StmpDeviceState *s = STMP_DEVICE(opaque);
+
+    switch (offset) {
+    case REG_VAL:
+        return s->regval;
+    default:
+        return 0;
+    }
+}
+
+static void stmp_write(void *opaque, hwaddr offset, uint64_t value,
+                       unsigned size)
+{
+    StmpDeviceState *s = STMP_DEVICE(opaque);
+
+    switch (offset) {
+    case REG_VAL:
+        s->regval = value;
+        break;
+    case REG_SET:
+        s->regval |= value;
+        if (s->have_reset && (value & STMP_MODULE_SFTRST)) {
+            s->regval |= STMP_MODULE_CLKGATE;
+        }
+        break;
+    case REG_CLR:
+        s->regval &= ~value;
+        break;
+    case REG_TOG:
+        s->regval ^= value;
+        break;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps stmp_ops = {
+    .read = stmp_read,
+    .write = stmp_write,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void stmp_realize(DeviceState *dev, Error **errp)
+{
+    StmpDeviceState *s = STMP_DEVICE(dev);
+
+    if (s->name == NULL) {
+        error_setg(errp, "property 'name' not specified");
+        return;
+    }
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &stmp_ops, s,
+                          s->name, 0x10);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+}
+
+static Property stmp_properties[] = {
+    DEFINE_PROP_STRING("name", StmpDeviceState, name),
+    DEFINE_PROP_BOOL("have-reset", StmpDeviceState, have_reset, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void stmp_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = stmp_realize;
+    device_class_set_props(dc, stmp_properties);
+}
+
+static const TypeInfo stmp_info = {
+    .name = TYPE_STMP_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(StmpDeviceState),
+    .class_init = stmp_class_init,
+};
+
+static void stmp_register_types(void)
+{
+    type_register_static(&stmp_info);
+}
+
+type_init(stmp_register_types)
diff --git a/include/hw/misc/stmp.h b/include/hw/misc/stmp.h
new file mode 100644
index 0000000000..941ceb25dd
--- /dev/null
+++ b/include/hw/misc/stmp.h
@@ -0,0 +1,47 @@
+/*
+ * "Stmp" device
+ *
+ * Written by Guenter Roeck
+ */
+
+#ifndef HW_MISC_STMP_H
+#define HW_MISC_STMP_H
+
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+
+#define TYPE_STMP_DEVICE "stmp-device"
+
+#define STMP_DEVICE(obj) \
+    OBJECT_CHECK(StmpDeviceState, (obj), TYPE_STMP_DEVICE)
+
+typedef struct {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+    char *name;
+    bool have_reset;
+    uint32_t regval;
+} StmpDeviceState;
+
+/**
+ * create_stmp_device: create and map a dummy device with STMP register layout
+ * @name: name of the device for debug logging
+ * @have_reset: True if the register has reset functionality
+ * @base: base address of the device's MMIO region
+ *
+ * This utility function creates and maps an instance of stmp-device,
+ * which is a dummy device which follows STMP register layout.
+ */
+static inline void create_stmp_device(const char *name, bool have_reset,
+                                      hwaddr base)
+{
+    DeviceState *dev = qdev_create(NULL, TYPE_STMP_DEVICE);
+
+    qdev_prop_set_string(dev, "name", name);
+    qdev_prop_set_bit(dev, "have-reset", have_reset);
+    qdev_init_nofail(dev);
+
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(dev), 0, base, 0);
+}
+
+#endif
-- 
2.17.1


