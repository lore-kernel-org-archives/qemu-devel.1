Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011D5C43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF6B25215
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF6B25215
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSMbU-0006ms-IH
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kSMaO-0005Th-Sa
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:51:37 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:34567)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kSMaL-00066U-1T
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:51:36 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MDeAZ-1kaMwX1EnP-00Aqzf; Tue, 13 Oct 2020 17:51:30 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] intc: add goldfish-pic
Date: Tue, 13 Oct 2020 17:51:23 +0200
Message-Id: <20201013155124.451774-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013155124.451774-1-laurent@vivier.eu>
References: <20201013155124.451774-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TNpq4OYL5T0fL34Y1kFxdwpB5MSPMF91htzttue//BVFYeW6FAh
 NAWAXsJ5CmdZhxRGNWodM9FS+6BDURvpPOXQP9CoG2jmsCJoSoAs8ORrUexX3O5b2Lydfxy
 Fv5KJUArVTOa32oQ+fQn+creHTZQnFJnWI2AfKUhWhzHgD+AxWOTzbHZDcCIOV0fkZ5+FIk
 nV77dcJk0yr8wYzzv6WYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0hfcT30WvFI=:vhEhXJGEeYdEm1sr6xezWe
 2w5a2ztVAUQ1GebKjyHaVeTTctsSBeN2EXvb/ng4auPJa3L8W2ygFHK5B0x6/SjJ9dSk+9ZOG
 ilryjcfdE2zJ6ODirwjJk11Jd+rEKgPL2EPiPGBiHUA7/6XU/0S+BCqVqjQSqoJvnGJBnY0BT
 4zDrEi2+7WKwmOXLrwHSWZ3z30MVU6xc+WG6+mhKEss8FIgLZUF+ABYxdOiAYBHO3K4h+uxKU
 slbQZKK9zB+v0kLQo78LqElPB0l/L/eyzPzZp/+G9MBw1iSZNuNRb64TNrIOIF3L2Th7R8ZVu
 sVOe1YnIJ98WQyBHgzk8sNPhBvAKjYYu2K983FsbudMlSXND7MDqUIZ4GT32YuHgG24bZU78z
 5Oo0qI24+skOqAg5/mAPshfTNz5056XT1sHZxXCuIWwtBMED2/H7Ex/Pz2MucfxD8EBKF431/
 JQotcJl7UtA7GsY8DSAvQgtGJjSsh1Siqv8EamdA3lgXGA8V0fDLZZbdrSvaETI6MvfqRaKpp
 d7dQnWhlXtl6yxwASWGh2GI9mKkcyDM9H9X77J88iohUAKKmcnWVhkRW4bpxCm3qu9SSK73IO
 iLbgTNB3R9XD46wEE8DE8x1cR/rfjFocHNXHCgVKwEvUjs4W/OZ48rzoJFY1ixWgsx/wOmi1Y
 bTpAEMk2U/CzlknEhmFMQpK6j4ql50m9RkUx4GWEgZH4cUBru33nFTlta+/sThNJEzUUKOxUk
 f6QG7UZ7ylF3fg4hJoiPaRLe9QrMpIXPjlbvK87i75PZbNvXkhycGhnot3vEpfWgxp2vbs14w
 mAkr8ROlzLEtziwTxyMXUPqVMvfdSzy91Z4P6+jxRIAaR6rV5vzExLv0q2HzouWzJSPEj+M
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 11:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/intc/goldfish_pic.h |  28 ++++++
 hw/intc/goldfish_pic.c         | 178 +++++++++++++++++++++++++++++++++
 hw/intc/Kconfig                |   3 +
 hw/intc/meson.build            |   1 +
 hw/intc/trace-events           |   8 ++
 5 files changed, 218 insertions(+)
 create mode 100644 include/hw/intc/goldfish_pic.h
 create mode 100644 hw/intc/goldfish_pic.c

diff --git a/include/hw/intc/goldfish_pic.h b/include/hw/intc/goldfish_pic.h
new file mode 100644
index 000000000000..7886caf9df66
--- /dev/null
+++ b/include/hw/intc/goldfish_pic.h
@@ -0,0 +1,28 @@
+/*
+ * SPDX-License-Identifer: GPL-2.0-or-later
+ *
+ * Goldfish PIC
+ *
+ * (c) 2020 Laurent Vivier <laurent@vivier.eu>
+ *
+ */
+
+#ifndef HW_INTC_GOLDFISH_PIC_H
+#define HW_INTC_GOLDFISH_PIC_H
+
+#define TYPE_GOLDFISH_PIC "goldfish_pic"
+OBJECT_DECLARE_SIMPLE_TYPE(GoldfishPICState, GOLDFISH_PIC)
+
+#define GOLDFISH_PIC_IRQ_NB 32
+
+struct GoldfishPICState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    uint32_t pending;
+    uint32_t enabled;
+};
+
+#endif
diff --git a/hw/intc/goldfish_pic.c b/hw/intc/goldfish_pic.c
new file mode 100644
index 000000000000..9007928e0aca
--- /dev/null
+++ b/hw/intc/goldfish_pic.c
@@ -0,0 +1,178 @@
+/*
+ * SPDX-License-Identifer: GPL-2.0-or-later
+ *
+ * Goldfish PIC
+ *
+ * (c) 2020 Laurent Vivier <laurent@vivier.eu>
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "hw/intc/goldfish_pic.h"
+
+/* registers */
+
+enum {
+    REG_STATUS          = 0x00,
+    REG_IRQ_PENDING     = 0x04,
+    REG_IRQ_DISABLE_ALL = 0x08,
+    REG_DISABLE         = 0x0c,
+    REG_ENABLE          = 0x10,
+};
+
+static void goldfish_pic_update(GoldfishPICState *s)
+{
+    if (s->pending & s->enabled) {
+        qemu_irq_raise(s->irq);
+    } else {
+        qemu_irq_lower(s->irq);
+    }
+}
+
+static void goldfish_irq_request(void *opaque, int irq, int level)
+{
+    GoldfishPICState *s = opaque;
+
+    trace_goldfish_irq_request(s, irq, level);
+
+    if (level) {
+        s->pending |= 1 << irq;
+    } else {
+        s->pending &= ~(1 << irq);
+    }
+    goldfish_pic_update(s);
+}
+
+static uint64_t goldfish_pic_read(void *opaque, hwaddr addr,
+                                  unsigned size)
+{
+    GoldfishPICState *s = opaque;
+    uint64_t value = 0;
+
+    switch (addr) {
+    case REG_STATUS:
+        /* The number of pending interrupts (0 to 32) */
+        value = ctpop32(s->pending & s->enabled);
+        break;
+    case REG_IRQ_PENDING:
+        /* The pending interrupt mask */
+        value = s->pending & s->enabled;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented register read 0x%02"HWADDR_PRIx"\n",
+                      __func__, addr);
+        break;
+    }
+
+    trace_goldfish_pic_read(s, addr, size, value);
+
+    return value;
+}
+
+static void goldfish_pic_write(void *opaque, hwaddr addr,
+                               uint64_t value, unsigned size)
+{
+    GoldfishPICState *s = opaque;
+
+    trace_goldfish_pic_write(s, addr, size, value);
+
+    switch (addr) {
+    case REG_IRQ_DISABLE_ALL:
+        s->enabled = 0;
+        s->pending = 0;
+        break;
+    case REG_DISABLE:
+        s->enabled &= ~value;
+        break;
+    case REG_ENABLE:
+        s->enabled |= value;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented register write 0x%02"HWADDR_PRIx"\n",
+                      __func__, addr);
+        break;
+    }
+    goldfish_pic_update(s);
+}
+
+static const MemoryRegionOps goldfish_pic_ops = {
+    .read = goldfish_pic_read,
+    .write = goldfish_pic_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.max_access_size = 4,
+    .impl.max_access_size = 4,
+};
+
+static void goldfish_pic_reset(DeviceState *dev)
+{
+    GoldfishPICState *s = GOLDFISH_PIC(dev);
+
+    trace_goldfish_pic_reset(s);
+    s->pending = 0;
+    s->enabled = 0;
+}
+
+static void goldfish_pic_realize(DeviceState *dev, Error **errp)
+{
+    GoldfishPICState *s = GOLDFISH_PIC(dev);
+
+    trace_goldfish_pic_realize(s);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &goldfish_pic_ops, s,
+                          "goldfish_pic", 0x24);
+}
+
+static const VMStateDescription vmstate_goldfish_pic = {
+    .name = "goldfish_pic",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(pending, GoldfishPICState),
+        VMSTATE_UINT32(enabled, GoldfishPICState),
+    }
+};
+
+static void goldfish_pic_instance_init(Object *obj)
+{
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+    GoldfishPICState *s = GOLDFISH_PIC(obj);
+
+    trace_goldfish_pic_instance_init(s);
+
+    sysbus_init_mmio(dev, &s->iomem);
+    sysbus_init_irq(dev, &s->irq);
+
+    qdev_init_gpio_in(DEVICE(obj), goldfish_irq_request, GOLDFISH_PIC_IRQ_NB);
+}
+
+static void goldfish_pic_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->reset = goldfish_pic_reset;
+    dc->realize = goldfish_pic_realize;
+    dc->vmsd = &vmstate_goldfish_pic;
+}
+
+static const TypeInfo goldfish_pic_info = {
+    .name = TYPE_GOLDFISH_PIC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .class_init = goldfish_pic_class_init,
+    .instance_init = goldfish_pic_instance_init,
+    .instance_size = sizeof(GoldfishPICState),
+};
+
+static void goldfish_pic_register_types(void)
+{
+    type_register_static(&goldfish_pic_info);
+}
+
+type_init(goldfish_pic_register_types)
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index d07954086a59..7ed79e7ac29f 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -73,3 +73,6 @@ config SIFIVE_CLINT
 
 config SIFIVE_PLIC
     bool
+
+config GOLDFISH_PIC
+    bool
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 3f82cc230ad7..395bc2f64036 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -55,3 +55,4 @@ specific_ss.add(when: 'CONFIG_XICS_SPAPR', if_true: files('xics_spapr.c'))
 specific_ss.add(when: 'CONFIG_XIVE', if_true: files('xive.c'))
 specific_ss.add(when: 'CONFIG_XIVE_KVM', if_true: files('spapr_xive_kvm.c'))
 specific_ss.add(when: 'CONFIG_XIVE_SPAPR', if_true: files('spapr_xive.c'))
+specific_ss.add(when: 'CONFIG_GOLDFISH_PIC', if_true: files('goldfish_pic.c'))
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 527c3f76caed..4b4c679c8b41 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -199,3 +199,11 @@ nvic_sysreg_write(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg wri
 heathrow_write(uint64_t addr, unsigned int n, uint64_t value) "0x%"PRIx64" %u: 0x%"PRIx64
 heathrow_read(uint64_t addr, unsigned int n, uint64_t value) "0x%"PRIx64" %u: 0x%"PRIx64
 heathrow_set_irq(int num, int level) "set_irq: num=0x%02x level=%d"
+
+# # goldfish_pic.c
+goldfish_irq_request(void *dev, int irq, int level) "pic: %p irq: %d level: %d"
+goldfish_pic_read(void *dev, unsigned int addr, unsigned int size, uint64_t value) "pic: %p reg: 0x%02x size: %d value: 0x%"PRIx64
+goldfish_pic_write(void *dev, unsigned int addr, unsigned int size, uint64_t value) "pic: %p reg: 0x%02x size: %d value: 0x%"PRIx64
+goldfish_pic_reset(void *dev) "pic: %p"
+goldfish_pic_realize(void *dev) "pic: %p"
+goldfish_pic_instance_init(void *dev) "pic: %p"
-- 
2.26.2


