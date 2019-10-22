Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262B9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE46C207FC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE46C207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMsTF-0001TX-31
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 07:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMsBc-0004qp-1T
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMsBZ-0007xI-Fl
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:18:47 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42825)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iMsBJ-0007mW-FI; Tue, 22 Oct 2019 07:18:29 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MekvT-1hmhwb3iSb-00amol; Tue, 22 Oct 2019 13:18:01 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v14 5/9] hw/m68k: add Nubus support
Date: Tue, 22 Oct 2019 13:17:34 +0200
Message-Id: <20191022111738.20803-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022111738.20803-1-laurent@vivier.eu>
References: <20191022111738.20803-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:E6XlJKDV7gsZ8jwk7+re9YeOm7YcbH212lEfoqTkFBgYz7A2PdA
 bI9OJz2Km63U/d0QbC5qnasXa/yFTsSS7IFy7nAy5hf+fhPExkedOuR01EzZXD9xvPXDhmw
 IHSofKIJoJtj0l15Ak1FKtCT5Wpn+07I46ZfpaTfo+Lo3Ii//eunQQPiHtx+4F1qs9c+uKv
 iv4W76LH3FxnSbAQ3Mw7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ou83i2i1mW8=:FFQCLLBOMo5kp9DG5MMSex
 C/Fovxa4B5/4mahvaOY5cRvjxt+a2Z+SpKe9aYsVO3fmXYgZ5MC69Ix7LDpVLkREH3b3GH+3G
 nHNi2JX/y9hBrwZVpLkFofYNBI76ER/MZtroi2FVHCVpYt1dmaIYmR3dj7A934NDy0C58RRpw
 SrkA4Qk1P8al/7YL+yUF/5EXRe9+1ABXVvkEJCZuHTJpvWjqd8tFCJweJcdi+K58EuABtsi/N
 ABwQL0xb9epEGkghL65bowR1cYi7WUA+KT6r6fvm7EwzbBZGqUbqcbqFbzAFxnZK2cyTQKgE6
 3DGXf2BP7RXfYvc6L3+OhWsU9cJ7QzaDrMkTCO31ZX+worDK/PHhiGrnF2eHMRtPpe6NnJt8F
 udH4c8/YnCxRSJVbyG5gW5fPMzqC0TafdPdKQ9HCr27dUaIXGfui4UPhWhNN9BqRZxKnY+vUX
 o2oknAjdisdu44QiVrQPha74nkK1pyn3v3gU1x481gLvzAVyXU2dOIJwyPlDfwlCyrdj52Hcm
 vVo8+JG0cnZD4zOHNz25plycjFrhvvsivrfcllYL0LPKyU0nr8GTgUOh0fYxgy9FInJVm5JG6
 cwi0bz5iRB5ncaEi/PJHXm82xEDUmv5ziv+0HCkIpIeIWo5saUV8fwUAPVjVDxG0XDrLfpRgw
 fubEprY51ZOSJv2h9udDbG0x/Shi0/mTS7z4ncQROoZjWLuNFKwp1TzQ9SQZcsT/Z++63oEI7
 qCqxwEFYQ+fCaS10+ZXKD2e9iSyBAN/vGzC1upo4alyNFUAXV7XDJIXQCgKjZ31sdA6bcmnHr
 dlm6gF3Z22yFBisYvxpKR4hNs4w6Ol2U7V3eCxLt7OpGZsZfjcE1LrTlW7VVQz3iV7K3hAMfq
 JNPj7YAgKnzCi6VfgKHw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.24
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds basic support for the NuBus bus. This is used by 680x0
Macintosh.

Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 include/hw/nubus/mac-nubus-bridge.h |  24 ++++
 include/hw/nubus/nubus.h            |  69 +++++++++
 hw/nubus/mac-nubus-bridge.c         |  45 ++++++
 hw/nubus/nubus-bridge.c             |  34 +++++
 hw/nubus/nubus-bus.c                | 111 ++++++++++++++
 hw/nubus/nubus-device.c             | 215 ++++++++++++++++++++++++++++
 MAINTAINERS                         |   2 +
 hw/Kconfig                          |   1 +
 hw/Makefile.objs                    |   1 +
 hw/m68k/Kconfig                     |   1 +
 hw/nubus/Kconfig                    |   2 +
 hw/nubus/Makefile.objs              |   4 +
 12 files changed, 509 insertions(+)
 create mode 100644 include/hw/nubus/mac-nubus-bridge.h
 create mode 100644 include/hw/nubus/nubus.h
 create mode 100644 hw/nubus/mac-nubus-bridge.c
 create mode 100644 hw/nubus/nubus-bridge.c
 create mode 100644 hw/nubus/nubus-bus.c
 create mode 100644 hw/nubus/nubus-device.c
 create mode 100644 hw/nubus/Kconfig
 create mode 100644 hw/nubus/Makefile.objs

diff --git a/include/hw/nubus/mac-nubus-bridge.h b/include/hw/nubus/mac-nubus-bridge.h
new file mode 100644
index 0000000000..ce9c789d99
--- /dev/null
+++ b/include/hw/nubus/mac-nubus-bridge.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) 2013-2018 Laurent Vivier <laurent@vivier.eu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef HW_NUBUS_MAC_H
+#define HW_NUBUS_MAC_H
+
+#include "hw/nubus/nubus.h"
+
+#define TYPE_MAC_NUBUS_BRIDGE "mac-nubus-bridge"
+#define MAC_NUBUS_BRIDGE(obj) OBJECT_CHECK(MacNubusState, (obj), \
+                                           TYPE_MAC_NUBUS_BRIDGE)
+
+typedef struct MacNubusState {
+    SysBusDevice sysbus_dev;
+
+    NubusBus *bus;
+} MacNubusState;
+
+#endif
diff --git a/include/hw/nubus/nubus.h b/include/hw/nubus/nubus.h
new file mode 100644
index 0000000000..a8634e54c5
--- /dev/null
+++ b/include/hw/nubus/nubus.h
@@ -0,0 +1,69 @@
+/*
+ * Copyright (c) 2013-2018 Laurent Vivier <laurent@vivier.eu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef HW_NUBUS_NUBUS_H
+#define HW_NUBUS_NUBUS_H
+
+#include "hw/qdev-properties.h"
+#include "exec/address-spaces.h"
+
+#define NUBUS_SUPER_SLOT_SIZE 0x10000000U
+#define NUBUS_SUPER_SLOT_NB   0x9
+
+#define NUBUS_SLOT_SIZE       0x01000000
+#define NUBUS_SLOT_NB         0xF
+
+#define NUBUS_FIRST_SLOT      0x9
+#define NUBUS_LAST_SLOT       0xF
+
+#define TYPE_NUBUS_DEVICE "nubus-device"
+#define NUBUS_DEVICE(obj) \
+     OBJECT_CHECK(NubusDevice, (obj), TYPE_NUBUS_DEVICE)
+
+#define TYPE_NUBUS_BUS "nubus-bus"
+#define NUBUS_BUS(obj) OBJECT_CHECK(NubusBus, (obj), TYPE_NUBUS_BUS)
+
+#define TYPE_NUBUS_BRIDGE "nubus-bridge"
+#define NUBUS_BRIDGE(obj) OBJECT_CHECK(NubusBridge, (obj), TYPE_NUBUS_BRIDGE)
+
+typedef struct NubusBus {
+    BusState qbus;
+
+    MemoryRegion super_slot_io;
+    MemoryRegion slot_io;
+
+    int current_slot;
+} NubusBus;
+
+typedef struct NubusDevice {
+    DeviceState qdev;
+
+    int slot_nb;
+    MemoryRegion slot_mem;
+
+    /* Format Block */
+
+    MemoryRegion fblock_io;
+
+    uint32_t rom_length;
+    uint32_t rom_crc;
+    uint8_t rom_rev;
+    uint8_t rom_format;
+    uint8_t byte_lanes;
+    int32_t directory_offset;
+
+    /* ROM */
+
+    MemoryRegion rom_io;
+    const uint8_t *rom;
+} NubusDevice;
+
+void nubus_register_rom(NubusDevice *dev, const uint8_t *rom, uint32_t size,
+                        int revision, int format, uint8_t byte_lanes);
+
+#endif
diff --git a/hw/nubus/mac-nubus-bridge.c b/hw/nubus/mac-nubus-bridge.c
new file mode 100644
index 0000000000..7c329300b8
--- /dev/null
+++ b/hw/nubus/mac-nubus-bridge.c
@@ -0,0 +1,45 @@
+/*
+ *  Copyright (c) 2013-2018 Laurent Vivier <laurent@vivier.eu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/nubus/mac-nubus-bridge.h"
+
+
+static void mac_nubus_bridge_init(Object *obj)
+{
+    MacNubusState *s = MAC_NUBUS_BRIDGE(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    s->bus = NUBUS_BUS(qbus_create(TYPE_NUBUS_BUS, DEVICE(s), NULL));
+
+    sysbus_init_mmio(sbd, &s->bus->super_slot_io);
+    sysbus_init_mmio(sbd, &s->bus->slot_io);
+}
+
+static void mac_nubus_bridge_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "Nubus bridge";
+}
+
+static const TypeInfo mac_nubus_bridge_info = {
+    .name          = TYPE_MAC_NUBUS_BRIDGE,
+    .parent        = TYPE_NUBUS_BRIDGE,
+    .instance_init = mac_nubus_bridge_init,
+    .instance_size = sizeof(MacNubusState),
+    .class_init    = mac_nubus_bridge_class_init,
+};
+
+static void mac_nubus_bridge_register_types(void)
+{
+    type_register_static(&mac_nubus_bridge_info);
+}
+
+type_init(mac_nubus_bridge_register_types)
diff --git a/hw/nubus/nubus-bridge.c b/hw/nubus/nubus-bridge.c
new file mode 100644
index 0000000000..cd8c6a91eb
--- /dev/null
+++ b/hw/nubus/nubus-bridge.c
@@ -0,0 +1,34 @@
+/*
+ * QEMU Macintosh Nubus
+ *
+ * Copyright (c) 2013-2018 Laurent Vivier <laurent@vivier.eu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/nubus/nubus.h"
+
+static void nubus_bridge_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->fw_name = "nubus";
+}
+
+static const TypeInfo nubus_bridge_info = {
+    .name          = TYPE_NUBUS_BRIDGE,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SysBusDevice),
+    .class_init    = nubus_bridge_class_init,
+};
+
+static void nubus_register_types(void)
+{
+    type_register_static(&nubus_bridge_info);
+}
+
+type_init(nubus_register_types)
diff --git a/hw/nubus/nubus-bus.c b/hw/nubus/nubus-bus.c
new file mode 100644
index 0000000000..942a6d5342
--- /dev/null
+++ b/hw/nubus/nubus-bus.c
@@ -0,0 +1,111 @@
+/*
+ * QEMU Macintosh Nubus
+ *
+ * Copyright (c) 2013-2018 Laurent Vivier <laurent@vivier.eu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/nubus/nubus.h"
+#include "hw/sysbus.h"
+#include "qapi/error.h"
+
+
+static NubusBus *nubus_find(void)
+{
+    /* Returns NULL unless there is exactly one nubus device */
+    return NUBUS_BUS(object_resolve_path_type("", TYPE_NUBUS_BUS, NULL));
+}
+
+static void nubus_slot_write(void *opaque, hwaddr addr, uint64_t val,
+                             unsigned int size)
+{
+    /* read only */
+}
+
+
+static uint64_t nubus_slot_read(void *opaque, hwaddr addr,
+                                unsigned int size)
+{
+    return 0;
+}
+
+static const MemoryRegionOps nubus_slot_ops = {
+    .read  = nubus_slot_read,
+    .write = nubus_slot_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static void nubus_super_slot_write(void *opaque, hwaddr addr, uint64_t val,
+                                   unsigned int size)
+{
+    /* read only */
+}
+
+static uint64_t nubus_super_slot_read(void *opaque, hwaddr addr,
+                                      unsigned int size)
+{
+    return 0;
+}
+
+static const MemoryRegionOps nubus_super_slot_ops = {
+    .read  = nubus_super_slot_read,
+    .write = nubus_super_slot_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static void nubus_realize(BusState *bus, Error **errp)
+{
+    if (!nubus_find()) {
+        error_setg(errp, "at most one %s device is permitted", TYPE_NUBUS_BUS);
+        return;
+    }
+}
+
+static void nubus_init(Object *obj)
+{
+    NubusBus *nubus = NUBUS_BUS(obj);
+
+    memory_region_init_io(&nubus->super_slot_io, obj, &nubus_super_slot_ops,
+                          nubus, "nubus-super-slots",
+                          NUBUS_SUPER_SLOT_NB * NUBUS_SUPER_SLOT_SIZE);
+
+    memory_region_init_io(&nubus->slot_io, obj, &nubus_slot_ops,
+                          nubus, "nubus-slots",
+                          NUBUS_SLOT_NB * NUBUS_SLOT_SIZE);
+
+    nubus->current_slot = NUBUS_FIRST_SLOT;
+}
+
+static void nubus_class_init(ObjectClass *oc, void *data)
+{
+    BusClass *bc = BUS_CLASS(oc);
+
+    bc->realize = nubus_realize;
+}
+
+static const TypeInfo nubus_bus_info = {
+    .name = TYPE_NUBUS_BUS,
+    .parent = TYPE_BUS,
+    .instance_size = sizeof(NubusBus),
+    .instance_init = nubus_init,
+    .class_init = nubus_class_init,
+};
+
+static void nubus_register_types(void)
+{
+    type_register_static(&nubus_bus_info);
+}
+
+type_init(nubus_register_types)
diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
new file mode 100644
index 0000000000..01ccad9e8e
--- /dev/null
+++ b/hw/nubus/nubus-device.c
@@ -0,0 +1,215 @@
+/*
+ * QEMU Macintosh Nubus
+ *
+ * Copyright (c) 2013-2018 Laurent Vivier <laurent@vivier.eu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/nubus/nubus.h"
+#include "qapi/error.h"
+
+
+/* The Format Block Structure */
+
+#define FBLOCK_DIRECTORY_OFFSET 0
+#define FBLOCK_LENGTH           4
+#define FBLOCK_CRC              8
+#define FBLOCK_REVISION_LEVEL   12
+#define FBLOCK_FORMAT           13
+#define FBLOCK_TEST_PATTERN     14
+#define FBLOCK_RESERVED         18
+#define FBLOCK_BYTE_LANES       19
+
+#define FBLOCK_SIZE             20
+#define FBLOCK_PATTERN_VAL      0x5a932bc7
+
+static uint64_t nubus_fblock_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    NubusDevice *dev = opaque;
+    uint64_t val;
+
+#define BYTE(v, b) (((v) >> (24 - 8 * (b))) & 0xff)
+    switch (addr) {
+    case FBLOCK_BYTE_LANES:
+        val = dev->byte_lanes;
+        val |= (val ^ 0xf) << 4;
+        break;
+    case FBLOCK_RESERVED:
+        val = 0x00;
+        break;
+    case FBLOCK_TEST_PATTERN...FBLOCK_TEST_PATTERN + 3:
+        val = BYTE(FBLOCK_PATTERN_VAL, addr - FBLOCK_TEST_PATTERN);
+        break;
+    case FBLOCK_FORMAT:
+        val = dev->rom_format;
+        break;
+    case FBLOCK_REVISION_LEVEL:
+        val = dev->rom_rev;
+        break;
+    case FBLOCK_CRC...FBLOCK_CRC + 3:
+        val = BYTE(dev->rom_crc, addr - FBLOCK_CRC);
+        break;
+    case FBLOCK_LENGTH...FBLOCK_LENGTH + 3:
+        val = BYTE(dev->rom_length, addr - FBLOCK_LENGTH);
+        break;
+    case FBLOCK_DIRECTORY_OFFSET...FBLOCK_DIRECTORY_OFFSET + 3:
+        val = BYTE(dev->directory_offset, addr - FBLOCK_DIRECTORY_OFFSET);
+        break;
+    default:
+        val = 0;
+        break;
+    }
+    return val;
+}
+
+static void nubus_fblock_write(void *opaque, hwaddr addr, uint64_t val,
+                               unsigned int size)
+{
+    /* read only */
+}
+
+static const MemoryRegionOps nubus_format_block_ops = {
+    .read = nubus_fblock_read,
+    .write = nubus_fblock_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    }
+};
+
+static void nubus_register_format_block(NubusDevice *dev)
+{
+    char *fblock_name;
+
+    fblock_name = g_strdup_printf("nubus-slot-%d-format-block",
+                                  dev->slot_nb);
+
+    hwaddr fblock_offset = memory_region_size(&dev->slot_mem) - FBLOCK_SIZE;
+    memory_region_init_io(&dev->fblock_io, NULL, &nubus_format_block_ops,
+                          dev, fblock_name, FBLOCK_SIZE);
+    memory_region_add_subregion(&dev->slot_mem, fblock_offset,
+                                &dev->fblock_io);
+
+    g_free(fblock_name);
+}
+
+static void mac_nubus_rom_write(void *opaque, hwaddr addr, uint64_t val,
+                                       unsigned int size)
+{
+    /* read only */
+}
+
+static uint64_t mac_nubus_rom_read(void *opaque, hwaddr addr,
+                                    unsigned int size)
+{
+    NubusDevice *dev = opaque;
+
+    return dev->rom[addr];
+}
+
+static const MemoryRegionOps mac_nubus_rom_ops = {
+    .read  = mac_nubus_rom_read,
+    .write = mac_nubus_rom_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+
+void nubus_register_rom(NubusDevice *dev, const uint8_t *rom, uint32_t size,
+                        int revision, int format, uint8_t byte_lanes)
+{
+    hwaddr rom_offset;
+    char *rom_name;
+
+    /* FIXME : really compute CRC */
+    dev->rom_length = 0;
+    dev->rom_crc = 0;
+
+    dev->rom_rev = revision;
+    dev->rom_format = format;
+
+    dev->byte_lanes = byte_lanes;
+    dev->directory_offset = -size;
+
+    /* ROM */
+
+    dev->rom = rom;
+    rom_name = g_strdup_printf("nubus-slot-%d-rom", dev->slot_nb);
+    memory_region_init_io(&dev->rom_io, NULL, &mac_nubus_rom_ops,
+                          dev, rom_name, size);
+    memory_region_set_readonly(&dev->rom_io, true);
+
+    rom_offset = memory_region_size(&dev->slot_mem) - FBLOCK_SIZE +
+                 dev->directory_offset;
+    memory_region_add_subregion(&dev->slot_mem, rom_offset, &dev->rom_io);
+
+    g_free(rom_name);
+}
+
+static void nubus_device_realize(DeviceState *dev, Error **errp)
+{
+    NubusBus *nubus = NUBUS_BUS(qdev_get_parent_bus(DEVICE(dev)));
+    NubusDevice *nd = NUBUS_DEVICE(dev);
+    char *name;
+    hwaddr slot_offset;
+
+    if (nubus->current_slot < NUBUS_FIRST_SLOT ||
+            nubus->current_slot > NUBUS_LAST_SLOT) {
+        error_setg(errp, "Cannot register nubus card, not enough slots");
+        return;
+    }
+
+    nd->slot_nb = nubus->current_slot++;
+    name = g_strdup_printf("nubus-slot-%d", nd->slot_nb);
+
+    if (nd->slot_nb < NUBUS_FIRST_SLOT) {
+        /* Super */
+        slot_offset = (nd->slot_nb - 6) * NUBUS_SUPER_SLOT_SIZE;
+
+        memory_region_init(&nd->slot_mem, OBJECT(dev), name,
+                           NUBUS_SUPER_SLOT_SIZE);
+        memory_region_add_subregion(&nubus->super_slot_io, slot_offset,
+                                    &nd->slot_mem);
+    } else {
+        /* Normal */
+        slot_offset = nd->slot_nb * NUBUS_SLOT_SIZE;
+
+        memory_region_init(&nd->slot_mem, OBJECT(dev), name, NUBUS_SLOT_SIZE);
+        memory_region_add_subregion(&nubus->slot_io, slot_offset,
+                                    &nd->slot_mem);
+    }
+
+    g_free(name);
+    nubus_register_format_block(nd);
+}
+
+static void nubus_device_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = nubus_device_realize;
+    dc->bus_type = TYPE_NUBUS_BUS;
+}
+
+static const TypeInfo nubus_device_type_info = {
+    .name = TYPE_NUBUS_DEVICE,
+    .parent = TYPE_DEVICE,
+    .abstract = true,
+    .instance_size = sizeof(NubusDevice),
+    .class_init = nubus_device_class_init,
+};
+
+static void nubus_register_types(void)
+{
+    type_register_static(&nubus_device_type_info);
+}
+
+type_init(nubus_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 0583a752a2..e9066ab51d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -921,7 +921,9 @@ q800
 M: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
 F: hw/misc/mac_via.c
+F: hw/nubus/*
 F: include/hw/misc/mac_via.h
+F: include/hw/nubus/*
 
 MicroBlaze Machines
 -------------------
diff --git a/hw/Kconfig b/hw/Kconfig
index b45db3c813..0501a55315 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -21,6 +21,7 @@ source isa/Kconfig
 source mem/Kconfig
 source misc/Kconfig
 source net/Kconfig
+source nubus/Kconfig
 source nvram/Kconfig
 source pci-bridge/Kconfig
 source pci-host/Kconfig
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index ece6cc3755..457b95e28d 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -37,6 +37,7 @@ devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
 devices-dirs-y += xen/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
+devices-dirs-$(CONFIG_NUBUS) += nubus/
 devices-dirs-y += semihosting/
 devices-dirs-y += smbios/
 endif
diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index 22a357609c..947cd42c01 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -16,3 +16,4 @@ config NEXTCUBE
 config Q800
     bool
     select MAC_VIA
+    select NUBUS
diff --git a/hw/nubus/Kconfig b/hw/nubus/Kconfig
new file mode 100644
index 0000000000..8fb8b22189
--- /dev/null
+++ b/hw/nubus/Kconfig
@@ -0,0 +1,2 @@
+config NUBUS
+    bool
diff --git a/hw/nubus/Makefile.objs b/hw/nubus/Makefile.objs
new file mode 100644
index 0000000000..135ba7878d
--- /dev/null
+++ b/hw/nubus/Makefile.objs
@@ -0,0 +1,4 @@
+common-obj-y += nubus-device.o
+common-obj-y += nubus-bus.o
+common-obj-y += nubus-bridge.o
+common-obj-$(CONFIG_Q800) += mac-nubus-bridge.o
-- 
2.21.0


