Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9593C48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 11:30:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9289D215EA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 11:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9289D215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58982 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfjeZ-0000PK-Lp
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 07:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53742)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jonathan.cameron@huawei.com>) id 1hfjdF-000745-AE
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 07:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jonathan.cameron@huawei.com>) id 1hfjdD-0004EA-Gu
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 07:29:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52882 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jonathan.cameron@huawei.com>)
 id 1hfjd7-0003xA-BG; Tue, 25 Jun 2019 07:28:55 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 3FD502AD529BF46919CB;
 Tue, 25 Jun 2019 19:28:48 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Jun 2019 19:28:41 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Tue, 25 Jun 2019 19:27:50 +0800
Message-ID: <20190625112752.83188-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625112752.83188-1-Jonathan.Cameron@huawei.com>
References: <20190625112752.83188-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: [Qemu-devel] [RFC PATCH 5/7] pci-bridge: CCIX capable PCIE/CCIX
 switch downstream port
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jcm@redhat.com,
 linuxarm@huawei.com, Auger Eric <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Note that this is simply emulation of the configuration space.

Has the same issue with cut and paste code as the upstream port
driver.  Solution likely to be the same.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci-bridge/Makefile.objs     |   2 +-
 hw/pci-bridge/ccix_downstream.c | 222 ++++++++++++++++++++++++++++++++
 2 files changed, 223 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
index e266e39fed..78a49fb90b 100644
--- a/hw/pci-bridge/Makefile.objs
+++ b/hw/pci-bridge/Makefile.objs
@@ -8,4 +8,4 @@ common-obj-$(CONFIG_I82801B11) +=3D i82801b11.o
 common-obj-$(CONFIG_DEC_PCI) +=3D dec.o
 # Sun4u
 common-obj-$(CONFIG_SIMBA) +=3D simba.o
-common-obj-$(CONFIG_CCIX_SWITCH) +=3D ccix_upstream.o
+common-obj-$(CONFIG_CCIX_SWITCH) +=3D ccix_upstream.o ccix_downstream.o
diff --git a/hw/pci-bridge/ccix_downstream.c b/hw/pci-bridge/ccix_downstr=
eam.c
new file mode 100644
index 0000000000..92c66431e2
--- /dev/null
+++ b/hw/pci-bridge/ccix_downstream.c
@@ -0,0 +1,222 @@
+/*
+ * ccix_downstream.c
+ * A PCIe downstream switch port with CCIX support.
+ *=20
+ * Copyright (c) 2019 Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ *                    Huawei
+ * Based on: xio3130_downstream.c
+ * Copyright (c) 2010 Isaku Yamahata <yamahata at valinux co jp>
+ *                    VA Linux Systems Japan K.K.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci_ids.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "qapi/error.h"
+#include "hw/misc/ccix.h"
+#include "qemu/module.h"
+
+/*
+ * No public spec is available for a CCIX downstream port so for
+ * now use the values from teh xio3130 pcie downstream port
+ */
+#define XIO3130_MSI_OFFSET              0x70
+#define XIO3130_MSI_SUPPORTED_FLAGS     PCI_MSI_FLAGS_64BIT
+#define XIO3130_MSI_NR_VECTOR           1
+#define XIO3130_SSVID_OFFSET            0x80
+#define XIO3130_SSVID_SVID              0
+#define XIO3130_SSVID_SSID              0
+#define XIO3130_EXP_OFFSET              0x90
+#define XIO3130_AER_OFFSET              0x100
+
+#define TYPE_CCIX_DOWN_PORT "ccix-downstream-port"
+
+#define CCIX_DOWN_DEV(obj) OBJECT_CHECK(CCIXDownPortState, (obj), TYPE_C=
CIX_DOWN_PORT)
+
+typedef struct CCIXDownPortState {
+    PCIESlot parent_obj;
+    struct CCIXState s;
+} CCIXDownPortState;
+
+static void ccix_downstream_write_config(PCIDevice *d, uint32_t address,
+                                  uint32_t val, int len)
+{
+    CCIXDownPortState *s =3D CCIX_DOWN_DEV(d);
+
+    pci_bridge_write_config(d, address, val, len);
+    pcie_cap_flr_write_config(d, address, val, len);
+    pcie_cap_slot_write_config(d, address, val, len);
+    pcie_aer_write_config(d, address, val, len);
+    ccix_write_config(d, &s->s, address, val, len);
+}
+
+static void ccix_downstream_reset(DeviceState *qdev)
+{
+    PCIDevice *d =3D PCI_DEVICE(qdev);
+
+    pcie_cap_deverr_reset(d);
+    pcie_cap_slot_reset(d);
+    pcie_cap_arifwd_reset(d);
+    pci_bridge_reset(qdev);
+}
+
+static void ccix_downstream_realize(PCIDevice *d, Error **errp)
+{
+    PCIEPort *p =3D PCIE_PORT(d);
+    PCIESlot *s =3D PCIE_SLOT(d);
+    CCIXDownPortState *cs =3D CCIX_DOWN_DEV(d);
+    /* Allow space for existing extended capabilities from xio3130 */
+    uint32_t offset =3D 0x180;
+    int rc;
+
+    pci_bridge_initfn(d, TYPE_PCIE_BUS);
+    pcie_port_init_reg(d);
+
+    rc =3D msi_init(d, XIO3130_MSI_OFFSET, XIO3130_MSI_NR_VECTOR,
+                  XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
+                  XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
+                  errp);
+    if (rc < 0) {
+        assert(rc =3D=3D -ENOTSUP);
+        goto err_bridge;
+    }
+
+    rc =3D pci_bridge_ssvid_init(d, XIO3130_SSVID_OFFSET,
+                               XIO3130_SSVID_SVID, XIO3130_SSVID_SSID,
+                               errp);
+    if (rc < 0) {
+        goto err_bridge;
+    }
+
+    rc =3D pcie_cap_init(d, XIO3130_EXP_OFFSET, PCI_EXP_TYPE_DOWNSTREAM,
+                       p->port, errp);
+    if (rc < 0) {
+        goto err_msi;
+    }
+    pcie_cap_flr_init(d);
+    pcie_cap_deverr_init(d);
+    pcie_cap_slot_init(d, s->slot);
+    pcie_cap_arifwd_init(d);
+
+    pcie_chassis_create(s->chassis);
+    rc =3D pcie_chassis_add_slot(s);
+    if (rc < 0) {
+        error_setg(errp, "Can't add chassis slot, error %d", rc);
+        goto err_pcie_cap;
+    }
+
+    rc =3D pcie_aer_init(d, PCI_ERR_VER, XIO3130_AER_OFFSET,
+                       PCI_ERR_SIZEOF, errp);
+    if (rc < 0) {
+        goto err;
+    }
+    initialize_ccixstate(&cs->s, d);
+    ccix_set_port(&cs->s);
+    offset =3D ccix_add_prldvsec(d, &cs->s, offset);
+    ccix_add_tdldvsec(d, offset);
+    ccix_register(&cs->s);
+
+    return;
+
+err:
+    pcie_chassis_del_slot(s);
+err_pcie_cap:
+    pcie_cap_exit(d);
+err_msi:
+    msi_uninit(d);
+err_bridge:
+    pci_bridge_exitfn(d);
+}
+
+static void ccix_downstream_exitfn(PCIDevice *d)
+{
+    PCIESlot *s =3D PCIE_SLOT(d);
+
+    pcie_aer_exit(d);
+    pcie_chassis_del_slot(s);
+    pcie_cap_exit(d);
+    msi_uninit(d);
+    pci_bridge_exitfn(d);
+}
+
+static Property ccix_props[] =3D {
+    DEFINE_PROP_STRING("ccix_device", CCIXDownPortState, s.ccix_dev_name=
),
+    DEFINE_PROP_BIT("primaryport", CCIXDownPortState, s.flags, PRIMARY_P=
ORT_BIT, false),
+    DEFINE_PROP_UINT8("port_id", CCIXDownPortState, s.port_id, 0),
+    DEFINE_PROP_UINT8("num_links", CCIXDownPortState, s.num_links, 1),
+    DEFINE_PROP_UINT8("psam_entries", CCIXDownPortState, s.psam_entries,=
 0),
+    DEFINE_PROP_UINT8("request_agents", CCIXDownPortState, s.num_ras, 0)=
,
+    DEFINE_PROP_UINT8("home_agents", CCIXDownPortState, s.num_has, 0),
+    DEFINE_PROP_UINT8("hsam_entries", CCIXDownPortState, s.hsam_entries,=
 0),
+    DEFINE_PROP_UINT8("rsam_entries", CCIXDownPortState, s.rsam_entries,=
 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription vmstate_ccix_downstream =3D {
+    .name =3D "ccix-downstream-port",
+    .priority =3D MIG_PRI_PCI_BUS,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .post_load =3D pcie_cap_slot_post_load,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
+        VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
+                       PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+
+static void ccix_downstream_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+
+    k->is_bridge =3D true;
+    k->config_write =3D ccix_downstream_write_config;
+    k->realize =3D ccix_downstream_realize;
+    k->exit =3D ccix_downstream_exitfn;
+    /* Temp values for the RFC */
+    k->vendor_id =3D PCI_VENDOR_ID_HUAWEI;
+    k->device_id =3D PCI_DEVICE_ID_HUAWEI_CCIX_DOWN;;
+    k->revision =3D 1;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->desc =3D "CCIX / PCIE switch downstream port";
+    dc->reset =3D ccix_downstream_reset;
+    dc->vmsd =3D &vmstate_ccix_downstream;
+    dc->props =3D ccix_props;
+}
+
+static const TypeInfo ccix_downstream_info =3D {
+    .name =3D TYPE_CCIX_DOWN_PORT,
+    .parent =3D TYPE_PCIE_SLOT,
+    .class_init =3D ccix_downstream_class_init,
+    .instance_size =3D sizeof(CCIXDownPortState),
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
+};
+
+static void ccix_downstream_register_types(void)
+{
+    type_register_static(&ccix_downstream_info);
+}
+
+type_init(ccix_downstream_register_types)
+   =20
--=20
2.20.1


