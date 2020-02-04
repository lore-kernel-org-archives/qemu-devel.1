Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B7AC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802A620674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aF4ipcng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802A620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iywUa-000731-Nb
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 06:35:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQH-0008KV-MG
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQB-00009F-GC
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:17 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47571)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQA-0008VO-U5
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:11 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204113109euoutp016936a7db4a5bc2d21a477dad0f72171c~wL6hgO4Gr1812218122euoutp01j
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 11:31:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204113109euoutp016936a7db4a5bc2d21a477dad0f72171c~wL6hgO4Gr1812218122euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580815869;
 bh=8krbNE+KSXi0wI3VPtXD9yxn+/jNrWuebMdcGarMJl8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aF4ipcngtPg1/lrXY88LlRA3FU4ruEik91qjCwEJoT0y+aro9j6ftQi5eXMsmswhH
 g5unuan2vHLOMzM6QSco8bWdCNTTWO9ht2VEx57QrpV+bZy03MrUpJtA+yixocvy8z
 Glxc01LC9S6HqBcclh/qfuzfwave6eHnjwTkyRHA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200204113109eucas1p206aae13a98a7c93fbefc9e02f6031c50~wL6hQvjxk0478504785eucas1p2Q;
 Tue,  4 Feb 2020 11:31:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id E6.3C.60679.DF5593E5; Tue,  4
 Feb 2020 11:31:09 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204113108eucas1p2526a9481bf8a4420d359c45f1183fe95~wL6g94hv12920129201eucas1p2p;
 Tue,  4 Feb 2020 11:31:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200204113108eusmtrp15ff8dc3372f0f9c4d90b3ff21b631956~wL6g9ZYjl2102721027eusmtrp17;
 Tue,  4 Feb 2020 11:31:08 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-e0-5e3955fd4e44
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 98.AC.08375.CF5593E5; Tue,  4
 Feb 2020 11:31:08 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204113108eusmtip2a9301871dc3fa53b01e7e438c424dc53~wL6gqt1px1661216612eusmtip2V;
 Tue,  4 Feb 2020 11:31:08 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC 6/9] hw/misc/memexpose: Add memexpose pci device
Date: Tue,  4 Feb 2020 12:30:48 +0100
Message-Id: <1580815851-28887-7-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWy7djPc7p/Qy3jDK6dYbbYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwRHHZpKTmZJalFunbJXBlfNvx
 jr3gpXVFV7tcA+NRvS5GTg4JAROJY1s3sIHYQgIrGCW+rBWHsL8wSiw/z97FyAVkf2aUONFy
 iA2m4WjHTFaIxHJGiWfdy9kgHKCOd1N3sYJUsQmoSew88pkRxBYRkJT43XWaGcRmFsiQeD6r
 G8wWFrCT+LHgGzuIzSKgKnHt4T0WEJtXIEDiwqcfzBDb5CRunusEszkFAiXe75nEBBG/zCZx
 tdUHwnaRmND6Eeo6YYlXx7ewQ9gyEqcn97BA2PUSLXd2MIEcKiHQwSjRt3I6VIO1xJcNS4GK
 OICO05RYv0sfIuwoMWdCCxNIWEKAT+LGW0GI8/kkJm2bzgwR5pXoaBOCqNaT6H5ykwlm67LG
 R1BbPSTeTZ/BAgmeJYwSN75uYZnAKD8LYdkCRsZVjOKppcW56anFRnmp5XrFibnFpXnpesn5
 uZsYgZF/+t/xLzsYd/1JOsQowMGoxMN78qxFnBBrYllxZe4hRgkOZiUR3vP6lnFCvCmJlVWp
 RfnxRaU5qcWHGKU5WJTEeY0XvYwVEkhPLEnNTk0tSC2CyTJxcEo1MParCMq+/Lk+fCMnN6f0
 +1cqSYVL7C7ueb7h8Jxa1V8fnvMJTi/aPbVTZarPu4/72y4K5Jby/QhgbXPYZzzt9BaV3MmM
 ekHVzje3T/np+/Nd0To907QEbV+Bh8sPWSS8iM8KXqZQxqYRtlJoV4VLb0NKiMO1nQmK+8yE
 rk3p2l1yQkVfIqLuixJLcUaioRZzUXEiAP5ZBFj4AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t/xe7p/Qi3jDJ7uNLTYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwROnZFOWXlqQqZOQXl9gqRRta
 GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlfNvxjr3gpXVFV7tcA+NRvS5GTg4J
 AROJox0zWbsYuTiEBJYyShxavoMJIiEj8eP0GjYIW1jiz7UuNoiiT4wSc68eZQdJsAmoSew8
 8pkRxBYRkJT43XWaGcRmFsiS2Dn7PtggYQE7iR8LvoHVswioSlx7eI8FxOYVCJC48OkHM8QC
 OYmb5zrBbE6BQIn3eyaB9QqB1OyaxT6BkW8BI8MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2M
 wGDcduzn5h2MlzYGH2IU4GBU4uG9YGcRJ8SaWFZcmXuIUYKDWUmE97y+ZZwQb0piZVVqUX58
 UWlOavEhRlOgoyYyS4km5wMjJa8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoR
 TB8TB6dUA6P/8Ucmv/cZC2yX6dx3p/+7T3jnXfswnQmhWjm9sS9cZl1cvTd5zg1ennmm3y/Z
 tTAUfM493BF9sMB08cSaqvPu2q9cjh5fcWfmNPOg1Se4hISYYpsT+Nt1zhzaaN49taWT61LK
 dKEt1tUPOSNmbjrS4vU3wszCR0e544zzxx/ler+CF7VsPqLEUpyRaKjFXFScCADpbVaxXAIA
 AA==
X-CMS-MailID: 20200204113108eucas1p2526a9481bf8a4420d359c45f1183fe95
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204113108eucas1p2526a9481bf8a4420d359c45f1183fe95
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204113108eucas1p2526a9481bf8a4420d359c45f1183fe95
References: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200204113108eucas1p2526a9481bf8a4420d359c45f1183fe95@eucas1p2.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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
Cc: peter.maydell@linaro.org,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>

Signed-off-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
---
 MAINTAINERS                       |   1 +
 hw/misc/memexpose/Makefile.objs   |   1 +
 hw/misc/memexpose/memexpose-pci.c | 218 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)
 create mode 100644 hw/misc/memexpose/memexpose-pci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d6146c0..50628e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1646,6 +1646,7 @@ F: hw/misc/memexpose/memexpose-core.h
 F: hw/misc/memexpose/memexpose-core.c
 F: hw/misc/memexpose/memexpose-msg.h
 F: hw/misc/memexpose/memexpose-msg.c
+F: hw/misc/memexpose/memexpose-pci.c
 
 nvme
 M: Keith Busch <keith.busch@intel.com>
diff --git a/hw/misc/memexpose/Makefile.objs b/hw/misc/memexpose/Makefile.objs
index f405fe7..05a2395 100644
--- a/hw/misc/memexpose/Makefile.objs
+++ b/hw/misc/memexpose/Makefile.objs
@@ -1,2 +1,3 @@
 common-obj-y += memexpose-msg.o
 common-obj-y += memexpose-core.o
+common-obj-$(CONFIG_PCI) += memexpose-pci.o
diff --git a/hw/misc/memexpose/memexpose-pci.c b/hw/misc/memexpose/memexpose-pci.c
new file mode 100644
index 0000000..7372651
--- /dev/null
+++ b/hw/misc/memexpose/memexpose-pci.c
@@ -0,0 +1,218 @@
+/*
+ *  Memexpose PCI device
+ *
+ *  Copyright (C) 2020 Samsung Electronics Co Ltd.
+ *    Igor Kotrasinski, <i.kotrasinsk@partner.samsung.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "qemu/cutils.h"
+#include "hw/hw.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
+#include "hw/qdev-properties.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "memexpose-core.h"
+
+#define PCI_VENDOR_ID_MEMEXPOSE            PCI_VENDOR_ID_REDHAT_QUMRANET
+#define TYPE_MEMEXPOSE_PCI "memexpose-pci"
+#define PCI_DEVICE_ID_MEMEXPOSE     0x1111
+#define MEMEXPOSE_PCI(obj) \
+    OBJECT_CHECK(MemexposePCIState, (obj), TYPE_MEMEXPOSE_PCI)
+
+typedef struct MemexposePCIState {
+    PCIDevice parent_obj;
+
+    CharBackend intr_chr;
+    CharBackend mem_chr;
+
+    MemexposeIntr intr;
+    uint32_t intr_status;
+    MemexposeMem mem;
+} MemexposePCIState;
+
+static void raise_irq(MemexposePCIState *s)
+{
+    s->intr_status |= 1;
+    if (msi_enabled(&s->parent_obj)) {
+        msi_notify(&s->parent_obj, 0);
+    } else {
+        pci_set_irq(&s->parent_obj, 1);
+    }
+}
+
+static void lower_irq(MemexposePCIState *s)
+{
+    s->intr_status &= (~1);
+    if (!s->intr_status && !msi_enabled(&s->parent_obj)) {
+        pci_set_irq(&s->parent_obj, 0);
+    }
+}
+
+static void handle_irq(void *opaque, int dir)
+{
+    MemexposePCIState *s = opaque;
+    if (dir) {
+        raise_irq(s);
+    } else {
+        lower_irq(s);
+    }
+}
+
+static int memexpose_enable(void *opaque)
+{
+    int ret;
+    MemexposePCIState *s = opaque;
+
+    ret = memexpose_intr_enable(&s->intr);
+    if (ret) {
+        return ret;
+    }
+
+    ret = memexpose_mem_enable(&s->mem);
+    if (ret) {
+        memexpose_intr_disable(&s->intr);
+        return ret;
+    }
+
+    return 0;
+}
+
+static void memexpose_disable(void *opaque)
+{
+    MemexposePCIState *s = opaque;
+
+    memexpose_intr_disable(&s->intr);
+    memexpose_mem_disable(&s->mem);
+}
+
+static void memexpose_pci_intr_init(PCIDevice *dev, Error **errp)
+{
+    MemexposePCIState *s = MEMEXPOSE_PCI(dev);
+    struct memexpose_intr_ops ops;
+    ops.intr = handle_irq;
+    ops.enable = memexpose_enable;
+    ops.disable = memexpose_disable;
+    ops.parent = s;
+
+    memexpose_intr_init(&s->intr, &ops, OBJECT(dev), &s->intr_chr, errp);
+    if (*errp) {
+        return;
+    }
+
+    s->intr_status = 0;
+    uint8_t *pci_conf;
+    pci_conf = dev->config;
+    pci_conf[PCI_COMMAND] = PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
+    pci_config_set_interrupt_pin(pci_conf, 1);
+    if (msi_init(dev, 0, 1, true, false, errp)) {
+        error_setg(errp, "Failed to initialize memexpose PCI interrupts");
+        memexpose_intr_destroy(&s->intr);
+        return;
+    }
+
+    /* region for registers*/
+    pci_register_bar(dev, 0,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY,
+                     &s->intr.shmem);
+    MEMEXPOSE_DPRINTF("Initialized bar.\n");
+}
+
+static void memexpose_pci_intr_exit(PCIDevice *dev)
+{
+    MemexposePCIState *s = MEMEXPOSE_PCI(dev);
+    msi_uninit(dev);
+    memexpose_intr_destroy(&s->intr);
+}
+
+static void memexpose_pci_realize(PCIDevice *dev, Error **errp)
+{
+    MemexposePCIState *s = MEMEXPOSE_PCI(dev);
+    memexpose_pci_intr_init(dev, errp);
+    if (*errp) {
+        return;
+    }
+
+    Chardev *chrd = qemu_chr_fe_get_driver(&s->mem_chr);
+    assert(chrd);
+    MEMEXPOSE_DPRINTF("Memexpose endpoint at %s!\n",
+                      chrd->filename);
+    memexpose_mem_init(&s->mem, OBJECT(dev),
+                       get_system_memory(),
+                       &s->mem_chr, 0, errp);
+    if (*errp) {
+        memexpose_pci_intr_exit(dev);
+        return;
+    }
+
+    pci_register_bar(dev, 1,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64,
+                     &s->mem.shmem);
+    MEMEXPOSE_DPRINTF("Initialized second bar.\n");
+}
+
+static void memexpose_pci_exit(PCIDevice *dev)
+{
+    MemexposePCIState *s = MEMEXPOSE_PCI(dev);
+    memexpose_mem_destroy(&s->mem);
+    memexpose_pci_intr_exit(dev);
+}
+
+static Property memexpose_pci_properties[] = {
+    DEFINE_PROP_CHR("mem_chardev", MemexposePCIState, mem_chr),
+    DEFINE_PROP_CHR("intr_chardev", MemexposePCIState, intr_chr),
+    DEFINE_PROP_UINT64("shm_size", MemexposePCIState, mem.shmem_size, 4096),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void memexpose_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = memexpose_pci_realize;
+    k->exit = memexpose_pci_exit;
+    k->vendor_id = PCI_VENDOR_ID_MEMEXPOSE;
+    k->device_id = PCI_DEVICE_ID_MEMEXPOSE;
+    k->class_id = PCI_CLASS_MEMORY_RAM;
+    k->revision = 1;
+    device_class_set_props(dc, memexpose_pci_properties);
+}
+
+static const TypeInfo memexpose_pci_info = {
+    .name          = TYPE_MEMEXPOSE_PCI,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(MemexposePCIState),
+    .class_init    = memexpose_pci_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+
+static void memexpose_pci_register_types(void)
+{
+    type_register_static(&memexpose_pci_info);
+}
+
+type_init(memexpose_pci_register_types)
-- 
2.7.4


