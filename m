Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235C4C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 01:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DBF206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 01:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC9ancqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DBF206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCZRJ-0004sj-VB
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 21:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jCZOi-0001Ho-Mo
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 21:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jCZOf-00060D-TS
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 21:46:00 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36025)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jCZOf-0005zJ-NG; Thu, 12 Mar 2020 21:45:57 -0400
Received: by mail-pg1-x544.google.com with SMTP id c7so4025825pgw.3;
 Thu, 12 Mar 2020 18:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XtJQxJTKaz+K6vh1vsw9EMxIYbglO+yfVrRXNqgLkQU=;
 b=SC9ancqQj10uhLcp2jb9juAWLjy18J8bUcZt83rVF+87yxhygIfXESBi7D+rgkA3nt
 YdRI1MxfK4qut2Vp4utXXzjsmVvlqrBjanaQVjGN5WCR3bhmGlUEjGCAaH5iB17XVX9E
 2FMsot+n7QHm2IWWqWc+BTS6J9IO84Xjlh3bLsc1AElrlcJ1ox5IuIoRc/YV9YTLJCRX
 oKIgFTKDUv/B1m3JxiKauwBULtv7Dg1BXLmfnPccTXCoTQTkSbClc3o040qaThxYdGGw
 PF+qs7u2GzkMudlr8v0mERdJNRYOcX0rPtg1tv8n5qzU9/XQb8EywtypZOxkL2nEzvZT
 eq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=XtJQxJTKaz+K6vh1vsw9EMxIYbglO+yfVrRXNqgLkQU=;
 b=pxAdeaGv401iXa0ETSEE/b+V+R3ANw7PRR5pdQ+An+CWYwIiYRKVdkaYREL5xiylmn
 fbGTXMjGdYSj740/DaRV5ZcKdsbdwcwfQIHPGK7MkpwDMw38Khkk7eZpotwKXCDejmRP
 O3++6/dBMC417XBd96KJN+WTsJnIZ6b7N4YE9YsS2eGcWO6qODlTaJsflemySnsPiWgz
 Cj5MvgUZ1tS7l+j07a7ly9y6YV2eiEq9Ba6mXY16jT8SR7/1QL63y9DFLtILmE0B3FH4
 vxevy/DtonQIG7PzZCx4KdvfagABzjuqyuJZauIhruEURxEL4KhQhD8gkR2SWePeO40c
 6DcA==
X-Gm-Message-State: ANhLgQ0v+07Xh2j/nOWuRba+zLhz6eOtour1fxd2gpIxGmsvHPVDYDSa
 gViVl3jQy3xwGqQpxDF4dzY=
X-Google-Smtp-Source: ADFU+vt5qR+dTRFpsFyd9tve2cMHxiU5FtCzSldpmjtaUQliZWhFDyBjLGEi6cMdv0oy8p4434YAXA==
X-Received: by 2002:a62:1847:: with SMTP id 68mr9115056pfy.288.1584063956659; 
 Thu, 12 Mar 2020 18:45:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 129sm49610183pgf.10.2020.03.12.18.45.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 12 Mar 2020 18:45:56 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 1/5] hw/usb: Add basic i.MX USB Phy support
Date: Thu, 12 Mar 2020 18:45:47 -0700
Message-Id: <20200313014551.12554-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313014551.12554-1-linux@roeck-us.net>
References: <20200313014551.12554-1-linux@roeck-us.net>
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
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add basic USB PHY support as implemented in i.MX23, i.MX28, i.MX6,
and i.MX7 SoCs.

The only support really needed - at least to boot Linux - is support
for soft reset, which needs to reset various registers to their initial
value. Otherwise, just record register values.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Added Reviewed-by:;
    dropped duplicate "the" in comments;
    added new files to MAINTAINERS
v2: New patch, replacing dummy STMP register support with basic USB PHY
    emulation.

 MAINTAINERS                  |   2 +
 hw/arm/Kconfig               |   1 +
 hw/usb/Kconfig               |   5 +
 hw/usb/Makefile.objs         |   2 +
 hw/usb/imx-usb-phy.c         | 225 +++++++++++++++++++++++++++++++++++
 include/hw/usb/imx-usb-phy.h |  53 +++++++++
 6 files changed, 288 insertions(+)
 create mode 100644 hw/usb/imx-usb-phy.c
 create mode 100644 include/hw/usb/imx-usb-phy.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d881ba7d9c..1cfdeeae32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -748,6 +748,8 @@ F: hw/arm/sabrelite.c
 F: hw/arm/fsl-imx6.c
 F: hw/misc/imx6_*.c
 F: hw/ssi/imx_spi.c
+F: hw/usb/imx-usb-phy.c
+F: include/hw/usb/imx-usb-phy.h
 F: include/hw/arm/fsl-imx6.h
 F: include/hw/misc/imx6_*.h
 F: include/hw/ssi/imx_spi.h
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index bc54fd61f9..21c627c3b7 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -361,6 +361,7 @@ config FSL_IMX6
     select IMX
     select IMX_FEC
     select IMX_I2C
+    select IMX_USBPHY
     select SDHCI
 
 config ASPEED_SOC
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 5e70ed5f7b..464348ba14 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -91,3 +91,8 @@ config USB_STORAGE_MTP
     bool
     default y
     depends on USB
+
+config IMX_USBPHY
+    bool
+    default y
+    depends on USB
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 2b10868937..66835e5bf7 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -61,3 +61,5 @@ common-obj-$(CONFIG_XEN) += xen-usb.o
 xen-usb.o-cflags := $(LIBUSB_CFLAGS)
 xen-usb.o-libs := $(LIBUSB_LIBS)
 endif
+
+common-obj-$(CONFIG_IMX_USBPHY) += imx-usb-phy.o
diff --git a/hw/usb/imx-usb-phy.c b/hw/usb/imx-usb-phy.c
new file mode 100644
index 0000000000..e705a03a1f
--- /dev/null
+++ b/hw/usb/imx-usb-phy.c
@@ -0,0 +1,225 @@
+/*
+ * i.MX USB PHY
+ *
+ * Copyright (c) 2020 Guenter Roeck <linux@roeck-us.net>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * We need to implement basic reset control in the PHY control register.
+ * For everything else, it is sufficient to set whatever is written.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/usb/imx-usb-phy.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+static const VMStateDescription vmstate_imx_usbphy = {
+    .name = TYPE_IMX_USBPHY,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(usbphy, IMXUSBPHYState, USBPHY_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx_usbphy_softreset(IMXUSBPHYState *s)
+{
+    s->usbphy[USBPHY_PWD] = 0x001e1c00;
+    s->usbphy[USBPHY_TX] = 0x10060607;
+    s->usbphy[USBPHY_RX] = 0x00000000;
+    s->usbphy[USBPHY_CTRL] = 0xc0200000;
+}
+
+static void imx_usbphy_reset(DeviceState *dev)
+{
+    IMXUSBPHYState *s = IMX_USBPHY(dev);
+
+    s->usbphy[USBPHY_STATUS] = 0x00000000;
+    s->usbphy[USBPHY_DEBUG] = 0x7f180000;
+    s->usbphy[USBPHY_DEBUG0_STATUS] = 0x00000000;
+    s->usbphy[USBPHY_DEBUG1] = 0x00001000;
+    s->usbphy[USBPHY_VERSION] = 0x04020000;
+
+    imx_usbphy_softreset(s);
+}
+
+static uint64_t imx_usbphy_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMXUSBPHYState *s = (IMXUSBPHYState *)opaque;
+    uint32_t index = offset >> 2;
+    uint32_t value;
+
+    switch (index) {
+    case USBPHY_PWD_SET:
+    case USBPHY_TX_SET:
+    case USBPHY_RX_SET:
+    case USBPHY_CTRL_SET:
+    case USBPHY_DEBUG_SET:
+    case USBPHY_DEBUG1_SET:
+        /*
+         * All REG_NAME_SET register access are in fact targeting the
+         * REG_NAME register.
+         */
+        value = s->usbphy[index - 1];
+        break;
+    case USBPHY_PWD_CLR:
+    case USBPHY_TX_CLR:
+    case USBPHY_RX_CLR:
+    case USBPHY_CTRL_CLR:
+    case USBPHY_DEBUG_CLR:
+    case USBPHY_DEBUG1_CLR:
+        /*
+         * All REG_NAME_CLR register access are in fact targeting the
+         * REG_NAME register.
+         */
+        value = s->usbphy[index - 2];
+        break;
+    case USBPHY_PWD_TOG:
+    case USBPHY_TX_TOG:
+    case USBPHY_RX_TOG:
+    case USBPHY_CTRL_TOG:
+    case USBPHY_DEBUG_TOG:
+    case USBPHY_DEBUG1_TOG:
+        /*
+         * All REG_NAME_TOG register access are in fact targeting the
+         * REG_NAME register.
+         */
+        value = s->usbphy[index - 3];
+        break;
+    default:
+        value = s->usbphy[index];
+        break;
+    }
+    return (uint64_t)value;
+}
+
+static void imx_usbphy_write(void *opaque, hwaddr offset, uint64_t value,
+                             unsigned size)
+{
+    IMXUSBPHYState *s = (IMXUSBPHYState *)opaque;
+    uint32_t index = offset >> 2;
+
+    switch (index) {
+    case USBPHY_CTRL:
+        s->usbphy[index] = value;
+        if (value & USBPHY_CTRL_SFTRST) {
+            imx_usbphy_softreset(s);
+        }
+        break;
+    case USBPHY_PWD:
+    case USBPHY_TX:
+    case USBPHY_RX:
+    case USBPHY_STATUS:
+    case USBPHY_DEBUG:
+    case USBPHY_DEBUG1:
+        s->usbphy[index] = value;
+        break;
+    case USBPHY_CTRL_SET:
+        s->usbphy[index - 1] |= value;
+        if (value & USBPHY_CTRL_SFTRST) {
+            imx_usbphy_softreset(s);
+        }
+        break;
+    case USBPHY_PWD_SET:
+    case USBPHY_TX_SET:
+    case USBPHY_RX_SET:
+    case USBPHY_DEBUG_SET:
+    case USBPHY_DEBUG1_SET:
+        /*
+         * All REG_NAME_SET register access are in fact targeting the
+         * REG_NAME register. So we change the value of the REG_NAME
+         * register, setting bits passed in the value.
+         */
+        s->usbphy[index - 1] |= value;
+        break;
+    case USBPHY_PWD_CLR:
+    case USBPHY_TX_CLR:
+    case USBPHY_RX_CLR:
+    case USBPHY_CTRL_CLR:
+    case USBPHY_DEBUG_CLR:
+    case USBPHY_DEBUG1_CLR:
+        /*
+         * All REG_NAME_CLR register access are in fact targeting the
+         * REG_NAME register. So we change the value of the REG_NAME
+         * register, unsetting bits passed in the value.
+         */
+        s->usbphy[index - 2] &= ~value;
+        break;
+    case USBPHY_CTRL_TOG:
+        s->usbphy[index - 3] ^= value;
+        if ((value & USBPHY_CTRL_SFTRST) &&
+            (s->usbphy[index - 3] & USBPHY_CTRL_SFTRST)) {
+            imx_usbphy_softreset(s);
+        }
+        break;
+    case USBPHY_PWD_TOG:
+    case USBPHY_TX_TOG:
+    case USBPHY_RX_TOG:
+    case USBPHY_DEBUG_TOG:
+    case USBPHY_DEBUG1_TOG:
+        /*
+         * All REG_NAME_TOG register access are in fact targeting the
+         * REG_NAME register. So we change the value of the REG_NAME
+         * register, toggling bits passed in the value.
+         */
+        s->usbphy[index - 3] ^= value;
+        break;
+    default:
+        /* Other registers are read-only */
+        break;
+    }
+}
+
+static const struct MemoryRegionOps imx_usbphy_ops = {
+    .read = imx_usbphy_read,
+    .write = imx_usbphy_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        /*
+         * Our device would not work correctly if the guest was doing
+         * unaligned access. This might not be a limitation on the real
+         * device but in practice there is no reason for a guest to access
+         * this device unaligned.
+         */
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void imx_usbphy_realize(DeviceState *dev, Error **errp)
+{
+    IMXUSBPHYState *s = IMX_USBPHY(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &imx_usbphy_ops, s,
+                          "imx-usbphy", 0x1000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+}
+
+static void imx_usbphy_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = imx_usbphy_reset;
+    dc->vmsd = &vmstate_imx_usbphy;
+    dc->desc = "i.MX USB PHY Module";
+    dc->realize = imx_usbphy_realize;
+}
+
+static const TypeInfo imx_usbphy_info = {
+    .name          = TYPE_IMX_USBPHY,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IMXUSBPHYState),
+    .class_init    = imx_usbphy_class_init,
+};
+
+static void imx_usbphy_register_types(void)
+{
+    type_register_static(&imx_usbphy_info);
+}
+
+type_init(imx_usbphy_register_types)
diff --git a/include/hw/usb/imx-usb-phy.h b/include/hw/usb/imx-usb-phy.h
new file mode 100644
index 0000000000..07f0235d10
--- /dev/null
+++ b/include/hw/usb/imx-usb-phy.h
@@ -0,0 +1,53 @@
+#ifndef IMX_USB_PHY_H
+#define IMX_USB_PHY_H
+
+#include "hw/sysbus.h"
+#include "qemu/bitops.h"
+
+enum IMXUsbPhyRegisters {
+    USBPHY_PWD,
+    USBPHY_PWD_SET,
+    USBPHY_PWD_CLR,
+    USBPHY_PWD_TOG,
+    USBPHY_TX,
+    USBPHY_TX_SET,
+    USBPHY_TX_CLR,
+    USBPHY_TX_TOG,
+    USBPHY_RX,
+    USBPHY_RX_SET,
+    USBPHY_RX_CLR,
+    USBPHY_RX_TOG,
+    USBPHY_CTRL,
+    USBPHY_CTRL_SET,
+    USBPHY_CTRL_CLR,
+    USBPHY_CTRL_TOG,
+    USBPHY_STATUS,
+    USBPHY_DEBUG = 0x14,
+    USBPHY_DEBUG_SET,
+    USBPHY_DEBUG_CLR,
+    USBPHY_DEBUG_TOG,
+    USBPHY_DEBUG0_STATUS,
+    USBPHY_DEBUG1 = 0x1c,
+    USBPHY_DEBUG1_SET,
+    USBPHY_DEBUG1_CLR,
+    USBPHY_DEBUG1_TOG,
+    USBPHY_VERSION,
+    USBPHY_MAX
+};
+
+#define USBPHY_CTRL_SFTRST BIT(31)
+
+#define TYPE_IMX_USBPHY "imx.usbphy"
+#define IMX_USBPHY(obj) OBJECT_CHECK(IMXUSBPHYState, (obj), TYPE_IMX_USBPHY)
+
+typedef struct IMXUSBPHYState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion iomem;
+
+    uint32_t usbphy[USBPHY_MAX];
+} IMXUSBPHYState;
+
+#endif /* IMX_USB_PHY_H */
-- 
2.17.1


