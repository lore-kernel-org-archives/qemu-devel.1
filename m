Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F289C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484BB21924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlIuVFu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484BB21924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4cX-0008LH-92
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iB49t-0001g4-QV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iB49h-0006GL-Vs
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:10 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46633)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iB49h-0006Ck-Iy
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:01 -0400
Received: by mail-oi1-x244.google.com with SMTP id k25so3980360oiw.13
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZeJscWWKCUqiou1c6ENFoRKdom+VlVVzvF6Ij/ADxY8=;
 b=LlIuVFu7iox26nwKXtbnS5S+yTa30ZO7hy++XNwNRDS1LdFU6vXAquZVcm+pY2M+hL
 zjIXst0ODSEGNUX2t6X3osUEblt6nZgwLkHjMJivLdhaiXAeThohJ0ffj1XP9O2c6xJf
 SqPOlKgkn297XMFwtlTNrmlwoMsyHJwO+6q+JHVi1BPzsc5Mwkc46rCZWrn+9f/e6+e3
 Fv/r4sSh9pIwTmjkLLZ3ZalMgnBZOJGG7qptMkg5xiNZwLjuJQhfMtb5y5doUTVBwaY7
 GebK4DGF57u7RQtlhXaCB/cdSNhQ1ggYX1nEmUKIiA6nxFB3L0f6KzyY0hmBtXA/xcfK
 jvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=ZeJscWWKCUqiou1c6ENFoRKdom+VlVVzvF6Ij/ADxY8=;
 b=YWID6/liIgbkPsJXiU88Ns3Q6HfKKlBsLQGZWrBep5b7REwiEtvbHJQWU3qUlsLagd
 Nm2qf+HvSDNsSR5DEfEqOxqJ1iyuxtABd+1yXCfaoFhxBt6kuRSD/78y41Yt8swzD2L6
 3yzAABppkwKolExmApxV/+3WNohCu9gC5PXoSH0oe4+rFRJsskAVZbcv98ElrqmRzL9L
 2hbfPJ0XSwQ/6GmmQf2GFN2fP+ijk2lV1ucsEHs/QTxhw3lOH0tzlYsN4/QMkYF6eMYP
 1QqSOkV4Zwp7J5z6nT0ATnUPmZuzQQibZRAUvVoAc4rYHQvc2+hbfsvrO+SrKlkf1a94
 D+jw==
X-Gm-Message-State: APjAAAX0pNY7VWuD0u06LLwfCF0sEgQJfdYQqVyC91IATLzRxE2JqRj2
 MLJhKJdT7vv9VfFv4FSOdA==
X-Google-Smtp-Source: APXvYqzf9CzQ5a6EGZ4mrTk1/AzSLiZYNEhChc+eoim7fdSaJwaxUICqY7YTn/9JbrKz/nDvdD5Mqg==
X-Received: by 2002:aca:701:: with SMTP id 1mr27606oih.85.1568929187394;
 Thu, 19 Sep 2019 14:39:47 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id t10sm32498oib.49.2019.09.19.14.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:39:40 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPA id 2950E1800D2;
 Thu, 19 Sep 2019 21:39:37 +0000 (UTC)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 11/15] ipmi: Add PCI IPMI interfaces
Date: Thu, 19 Sep 2019 16:39:20 -0500
Message-Id: <20190919213924.31852-12-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
References: <20190919213924.31852-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

Pretty straightforward, just hook the current KCS and BT code into
the PCI system with the proper configuration.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 default-configs/i386-softmmu.mak |   2 +
 hw/i386/Kconfig                  |   2 +
 hw/ipmi/Kconfig                  |  10 +++
 hw/ipmi/Makefile.objs            |   2 +
 hw/ipmi/pci_ipmi_bt.c            | 146 +++++++++++++++++++++++++++++++
 hw/ipmi/pci_ipmi_kcs.c           | 146 +++++++++++++++++++++++++++++++
 include/hw/pci/pci.h             |   1 +
 7 files changed, 309 insertions(+)
 create mode 100644 hw/ipmi/pci_ipmi_bt.c
 create mode 100644 hw/ipmi/pci_ipmi_kcs.c

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index ba3fb3ff50..2294c0be5a 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -10,6 +10,8 @@
 #CONFIG_ISA_DEBUG=n
 #CONFIG_ISA_IPMI_BT=n
 #CONFIG_ISA_IPMI_KCS=n
+#CONFIG_PCI_IPMI_KCS=n
+#CONFIG_PCI_IPMI_BT=n
 #CONFIG_PCI_DEVICES=n
 #CONFIG_PVPANIC=n
 #CONFIG_QXL=n
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index c7a9d6315c..d10f4e3e8b 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -8,6 +8,8 @@ config PC
     imply HYPERV
     imply ISA_IPMI_KCS
     imply ISA_IPMI_BT
+    imply PCI_IPMI_KCS
+    imply PCI_IPMI_BT
     imply ISA_DEBUG
     imply PARALLEL
     imply PCI_DEVICES
diff --git a/hw/ipmi/Kconfig b/hw/ipmi/Kconfig
index b944fae100..12db4e81ad 100644
--- a/hw/ipmi/Kconfig
+++ b/hw/ipmi/Kconfig
@@ -20,3 +20,13 @@ config ISA_IPMI_BT
     bool
     depends on ISA_BUS
     select IPMI
+
+config PCI_IPMI_KCS
+    bool
+    depends on PCI
+    select IPMI
+
+config PCI_IPMI_BT
+    bool
+    depends on PCI
+    select IPMI
diff --git a/hw/ipmi/Makefile.objs b/hw/ipmi/Makefile.objs
index 4ffa45a66c..2d7f080a86 100644
--- a/hw/ipmi/Makefile.objs
+++ b/hw/ipmi/Makefile.objs
@@ -2,4 +2,6 @@ common-obj-$(CONFIG_IPMI) += ipmi.o ipmi_kcs.o ipmi_bt.o
 common-obj-$(CONFIG_IPMI_LOCAL) += ipmi_bmc_sim.o
 common-obj-$(CONFIG_IPMI_EXTERN) += ipmi_bmc_extern.o
 common-obj-$(CONFIG_ISA_IPMI_KCS) += isa_ipmi_kcs.o
+common-obj-$(CONFIG_PCI_IPMI_KCS) += pci_ipmi_kcs.o
 common-obj-$(CONFIG_ISA_IPMI_BT) += isa_ipmi_bt.o
+common-obj-$(CONFIG_PCI_IPMI_BT) += pci_ipmi_bt.o
diff --git a/hw/ipmi/pci_ipmi_bt.c b/hw/ipmi/pci_ipmi_bt.c
new file mode 100644
index 0000000000..6ed925a665
--- /dev/null
+++ b/hw/ipmi/pci_ipmi_bt.c
@@ -0,0 +1,146 @@
+/*
+ * QEMU PCI IPMI BT emulation
+ *
+ * Copyright (c) 2017 Corey Minyard, MontaVista Software, LLC
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "hw/ipmi/ipmi_bt.h"
+#include "hw/pci/pci.h"
+
+#define TYPE_PCI_IPMI_BT "pci-ipmi-bt"
+#define PCI_IPMI_BT(obj) OBJECT_CHECK(PCIIPMIBTDevice, (obj), \
+                                       TYPE_PCI_IPMI_BT)
+
+typedef struct PCIIPMIBTDevice {
+    PCIDevice dev;
+    IPMIBT bt;
+    bool irq_enabled;
+    uint32_t uuid;
+} PCIIPMIBTDevice;
+
+static void pci_ipmi_raise_irq(IPMIBT *ik)
+{
+    PCIIPMIBTDevice *pik = ik->opaque;
+
+    pci_set_irq(&pik->dev, true);
+}
+
+static void pci_ipmi_lower_irq(IPMIBT *ik)
+{
+    PCIIPMIBTDevice *pik = ik->opaque;
+
+    pci_set_irq(&pik->dev, false);
+}
+
+static void pci_ipmi_bt_realize(PCIDevice *pd, Error **errp)
+{
+    PCIIPMIBTDevice *pik = PCI_IPMI_BT(pd);
+    IPMIInterface *ii = IPMI_INTERFACE(pd);
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+
+    if (!pik->bt.bmc) {
+        error_setg(errp, "IPMI device requires a bmc attribute to be set");
+        return;
+    }
+
+    pik->uuid = ipmi_next_uuid();
+
+    pik->bt.bmc->intf = ii;
+    pik->bt.opaque = pik;
+
+    pci_config_set_prog_interface(pd->config, 0x02); /* BT */
+    pci_config_set_interrupt_pin(pd->config, 0x01);
+    pik->bt.use_irq = 1;
+    pik->bt.raise_irq = pci_ipmi_raise_irq;
+    pik->bt.lower_irq = pci_ipmi_lower_irq;
+
+    iic->init(ii, 8, errp);
+    if (*errp) {
+        return;
+    }
+    pci_register_bar(pd, 0, PCI_BASE_ADDRESS_SPACE_IO, &pik->bt.io);
+}
+
+const VMStateDescription vmstate_PCIIPMIBTDevice = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "pci-bt",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, PCIIPMIBTDevice),
+        VMSTATE_STRUCT(bt, PCIIPMIBTDevice, 1, vmstate_IPMIBT, IPMIBT),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void pci_ipmi_bt_instance_init(Object *obj)
+{
+    PCIIPMIBTDevice *pik = PCI_IPMI_BT(obj);
+
+    ipmi_bmc_find_and_link(obj, (Object **) &pik->bt.bmc);
+}
+
+static void *pci_ipmi_bt_get_backend_data(IPMIInterface *ii)
+{
+    PCIIPMIBTDevice *pik = PCI_IPMI_BT(ii);
+
+    return &pik->bt;
+}
+
+static void pci_ipmi_bt_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(oc);
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_CLASS(oc);
+
+    pdc->vendor_id = PCI_VENDOR_ID_QEMU;
+    pdc->device_id = PCI_DEVICE_ID_QEMU_IPMI;
+    pdc->revision = 1;
+    pdc->class_id = PCI_CLASS_SERIAL_IPMI;
+
+    dc->vmsd = &vmstate_PCIIPMIBTDevice;
+    dc->desc = "PCI IPMI BT";
+    pdc->realize = pci_ipmi_bt_realize;
+
+    iic->get_backend_data = pci_ipmi_bt_get_backend_data;
+    ipmi_bt_class_init(iic);
+}
+
+static const TypeInfo pci_ipmi_bt_info = {
+    .name          = TYPE_PCI_IPMI_BT,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PCIIPMIBTDevice),
+    .instance_init = pci_ipmi_bt_instance_init,
+    .class_init    = pci_ipmi_bt_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_IPMI_INTERFACE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    }
+};
+
+static void pci_ipmi_bt_register_types(void)
+{
+    type_register_static(&pci_ipmi_bt_info);
+}
+
+type_init(pci_ipmi_bt_register_types)
diff --git a/hw/ipmi/pci_ipmi_kcs.c b/hw/ipmi/pci_ipmi_kcs.c
new file mode 100644
index 0000000000..eeba63baa4
--- /dev/null
+++ b/hw/ipmi/pci_ipmi_kcs.c
@@ -0,0 +1,146 @@
+/*
+ * QEMU PCI IPMI KCS emulation
+ *
+ * Copyright (c) 2017 Corey Minyard, MontaVista Software, LLC
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "hw/ipmi/ipmi_kcs.h"
+#include "hw/pci/pci.h"
+
+#define TYPE_PCI_IPMI_KCS "pci-ipmi-kcs"
+#define PCI_IPMI_KCS(obj) OBJECT_CHECK(PCIIPMIKCSDevice, (obj), \
+                                       TYPE_PCI_IPMI_KCS)
+
+typedef struct PCIIPMIKCSDevice {
+    PCIDevice dev;
+    IPMIKCS kcs;
+    bool irq_enabled;
+    uint32_t uuid;
+} PCIIPMIKCSDevice;
+
+static void pci_ipmi_raise_irq(IPMIKCS *ik)
+{
+    PCIIPMIKCSDevice *pik = ik->opaque;
+
+    pci_set_irq(&pik->dev, true);
+}
+
+static void pci_ipmi_lower_irq(IPMIKCS *ik)
+{
+    PCIIPMIKCSDevice *pik = ik->opaque;
+
+    pci_set_irq(&pik->dev, false);
+}
+
+static void pci_ipmi_kcs_realize(PCIDevice *pd, Error **errp)
+{
+    PCIIPMIKCSDevice *pik = PCI_IPMI_KCS(pd);
+    IPMIInterface *ii = IPMI_INTERFACE(pd);
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+
+    if (!pik->kcs.bmc) {
+        error_setg(errp, "IPMI device requires a bmc attribute to be set");
+        return;
+    }
+
+    pik->uuid = ipmi_next_uuid();
+
+    pik->kcs.bmc->intf = ii;
+    pik->kcs.opaque = pik;
+
+    pci_config_set_prog_interface(pd->config, 0x01); /* KCS */
+    pci_config_set_interrupt_pin(pd->config, 0x01);
+    pik->kcs.use_irq = 1;
+    pik->kcs.raise_irq = pci_ipmi_raise_irq;
+    pik->kcs.lower_irq = pci_ipmi_lower_irq;
+
+    iic->init(ii, 8, errp);
+    if (*errp) {
+        return;
+    }
+    pci_register_bar(pd, 0, PCI_BASE_ADDRESS_SPACE_IO, &pik->kcs.io);
+}
+
+const VMStateDescription vmstate_PCIIPMIKCSDevice = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "pci-kcs",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, PCIIPMIKCSDevice),
+        VMSTATE_STRUCT(kcs, PCIIPMIKCSDevice, 1, vmstate_IPMIKCS, IPMIKCS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void pci_ipmi_kcs_instance_init(Object *obj)
+{
+    PCIIPMIKCSDevice *pik = PCI_IPMI_KCS(obj);
+
+    ipmi_bmc_find_and_link(obj, (Object **) &pik->kcs.bmc);
+}
+
+static void *pci_ipmi_kcs_get_backend_data(IPMIInterface *ii)
+{
+    PCIIPMIKCSDevice *pik = PCI_IPMI_KCS(ii);
+
+    return &pik->kcs;
+}
+
+static void pci_ipmi_kcs_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(oc);
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_CLASS(oc);
+
+    pdc->vendor_id = PCI_VENDOR_ID_QEMU;
+    pdc->device_id = PCI_DEVICE_ID_QEMU_IPMI;
+    pdc->revision = 1;
+    pdc->class_id = PCI_CLASS_SERIAL_IPMI;
+
+    dc->vmsd = &vmstate_PCIIPMIKCSDevice;
+    dc->desc = "PCI IPMI KCS";
+    pdc->realize = pci_ipmi_kcs_realize;
+
+    iic->get_backend_data = pci_ipmi_kcs_get_backend_data;
+    ipmi_kcs_class_init(iic);
+}
+
+static const TypeInfo pci_ipmi_kcs_info = {
+    .name          = TYPE_PCI_IPMI_KCS,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PCIIPMIKCSDevice),
+    .instance_init = pci_ipmi_kcs_instance_init,
+    .class_init    = pci_ipmi_kcs_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_IPMI_INTERFACE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    }
+};
+
+static void pci_ipmi_kcs_register_types(void)
+{
+    type_register_static(&pci_ipmi_kcs_info);
+}
+
+type_init(pci_ipmi_kcs_register_types)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 1b840e61a2..f3f0ffd5fb 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -55,6 +55,7 @@ extern bool pci_available;
 /* QEMU/Bochs VGA (0x1234) */
 #define PCI_VENDOR_ID_QEMU               0x1234
 #define PCI_DEVICE_ID_QEMU_VGA           0x1111
+#define PCI_DEVICE_ID_QEMU_IPMI          0x1112
 
 /* VMWare (0x15ad) */
 #define PCI_VENDOR_ID_VMWARE             0x15ad
-- 
2.17.1


