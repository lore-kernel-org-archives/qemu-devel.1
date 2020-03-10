Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF910C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A67E215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uThO5bP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A67E215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBm6A-0003KP-Mm
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 17:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jBm3R-0008Rl-J3
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jBm3P-0000eD-PS
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:04:45 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jBm3M-0000Ow-1b; Tue, 10 Mar 2020 17:04:40 -0400
Received: by mail-pf1-x443.google.com with SMTP id p14so43649pfn.4;
 Tue, 10 Mar 2020 14:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1UsI33O+woq+Tif/DOTfvtLcohZeEu3JCXqlDYfdyIg=;
 b=uThO5bP1h09b01P+wyNa531xOjigF1Xw7atzvmnbBfmnKv0G07ieSMqeDw8FQJdDdq
 N+vaS/WU/MAnTHUx7Iq12uH6waSC5VOpejEkaPEybTTLwdAr0dcmMOST9pfNfz4iYTP+
 DiZPmgCPciiCzIEUbzGkH05t6N2iM+L8d1YFaZBz4iq/L2NYfUgI9LhkwRyflncFwZOK
 OkWHSS1FEg+7M4x2ucgIFavGpbWWSHCh6EodJ0Z6Lc2YRtoKNQ8aAfk223KFNWXBnomK
 Lqpbz/3FULfr5ibNonw6482C49eGiTrh7Z5j2zqboov7D9VpH7On6Y6Xt0WrFyCbPmr6
 ntXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=1UsI33O+woq+Tif/DOTfvtLcohZeEu3JCXqlDYfdyIg=;
 b=jpNmDu/iz5J1JGt1SSZNGWSTxpTAC+T9MXzjygl3QyzD/l/FrpYHw29GSL+HDGxXcj
 Lat4XuFnAlz0xp5c+pZA6mchvvA9SeRga+fBeRTTAXe6m0xOdP4Yi9PMbg6kBxn/+cl8
 bqWXTEZnF5Ap610j/Nrq2i8/0yleW0Xjb5HEciij+EQ06fzDKXNrxXLXsKJ/9Pn/jDWK
 mnJDOifqKbjrkYgn5Q2B73eAC+3RQzGwxHdfxaux0pDjJ9jt3GFPF+OlgVDo4nftEjfe
 8UL/s4Vif40QR3pgSky+J52l3fcxIkEzEHbp6udegXuB7B+K6Jloqb3+RV1pLmVmEQkc
 K7kw==
X-Gm-Message-State: ANhLgQ0RoSvzwYfPzbXunECZVoZM/B2oUNyJ9LPowUfhTjh/SmvxJckB
 IDpw1o41qKjvd1vfE/Go3lk=
X-Google-Smtp-Source: ADFU+vvDOZJfdgiO1OFtVw3ksNdUnFDlzN8cqZ/ERxXtitqMEMCA6Z7JrcEyVOrVpndiFWjhuRowiw==
X-Received: by 2002:a62:1889:: with SMTP id 131mr23089875pfy.250.1583874278830; 
 Tue, 10 Mar 2020 14:04:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id p14sm45897412pgm.49.2020.03.10.14.04.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 10 Mar 2020 14:04:38 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/3] hw/usb: Add basic i.MX USB Phy support
Date: Tue, 10 Mar 2020 14:04:32 -0700
Message-Id: <20200310210434.31544-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310210434.31544-1-linux@roeck-us.net>
References: <20200310210434.31544-1-linux@roeck-us.net>
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

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: New patch, replacing dummy STMP register support with basic USB PHY
    emulation.

 hw/arm/Kconfig               |   1 +
 hw/usb/Kconfig               |   5 +
 hw/usb/Makefile.objs         |   2 +
 hw/usb/imx-usb-phy.c         | 225 +++++++++++++++++++++++++++++++++++
 include/hw/usb/imx-usb-phy.h |  53 +++++++++
 5 files changed, 286 insertions(+)
 create mode 100644 hw/usb/imx-usb-phy.c
 create mode 100644 include/hw/usb/imx-usb-phy.h

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
index 0000000000..ce74a128b0
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
+         * the REG_NAME register.
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
+         * the REG_NAME register.
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
+         * the REG_NAME register.
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
+         * the REG_NAME register. So we change the value of the
+         * REG_NAME register, setting bits passed in the value.
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
+         * the REG_NAME register. So we change the value of the
+         * REG_NAME register, unsetting bits passed in the value.
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
+         * the REG_NAME register. So we change the value of the
+         * REG_NAME register, toggling bits passed in the value.
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


