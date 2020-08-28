Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2CDC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6972D2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="grdkURC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6972D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBk64-00025w-J1
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 15:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kBk4t-0000kZ-Ks
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 15:30:23 -0400
Received: from mail-eopbgr760070.outbound.protection.outlook.com
 ([40.107.76.70]:22663 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kBk4r-0004rI-3q
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 15:30:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI86sVmAjkqMEzrMmxz5zCxhrQE6zUR+lIdevfdK16F86STA2ULQqfVldm6n850gWJYtCylX7aZg54SfXTPkj3Iy5k2GFz95x6kjYIcL9SAbxt97lWvxqLw2Dg4DB6YbR9eEgyouU12Q2Uk7GAq2sXT0CFauFJcECETjhZrPKOAh4MfA6cDCkEhcN4sDs6akSJSfTwAcpy15ll8+ZKGwqFadMONrajbNSsog2Ioq4S1a00kHfOXDIpxaWEEMDRdE0Kzy6M0s9X/TD4xkrtHPV+I8FTJmt9WZeXJTJiqE/8BcGETyjRfM0/TOtLpsPVs/WydY9IstAD0rgmxOwjUgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7z8upTjih8QRn90U4ObcaqkK4OEgP5O4s6UkJjvPHQ=;
 b=E3HGaDeUH1vsfIL9vekt/6J+pkXJ53jnNvcVRHARuKxSqZ1TG1LqqnGDWPntiplIqdlT1vm+tUeDXMC/a9mzRB33LW603LUmIpoznhkZv0rG0t7V51wdYz6HnpPz2yeRBf83Meb6rYkLnehMBXqkhyVhtd8sMTufaDykt9sU0qoItNqEdN8q6MzUSm8kNGFewiHJLruZwy5LVdO6U3Ys4oMykxwkB/rCNpJfjOM3m+qmAKMZljd4ZPDDaiJhn3R87XCkMymC/hx0q2dZl6ZmWRDNIrsHQ5zSbK39WhRVCOjHhoSJJFn8gbg7acmUQ+sHQYUqEdJmIimXJuLvYgcEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7z8upTjih8QRn90U4ObcaqkK4OEgP5O4s6UkJjvPHQ=;
 b=grdkURC2eJkigZzSnoNDXnq8+9s+tflsRkKsSa2fbPdZwZcuQmXzUmzgZLy06nDNo2MHunTxxSf6w6CuHjfnZfNMMPEiVwt106jOidLtVK63m5Joo1Ik9ry0oQ9W0utsLp4pCz9B/suyjgB0yrU/vowHblOrod0QKpr7A/FT+pw=
Received: from MN2PR06CA0028.namprd06.prod.outlook.com (2603:10b6:208:23d::33)
 by CH2PR02MB6229.namprd02.prod.outlook.com (2603:10b6:610:1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 28 Aug
 2020 19:15:15 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23d:cafe::2e) by MN2PR06CA0028.outlook.office365.com
 (2603:10b6:208:23d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 28 Aug 2020 19:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 19:15:15
 +0000
Received: from [149.199.38.66] (port=48174 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kBjpg-0007Jb-LI; Fri, 28 Aug 2020 12:14:40 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kBjqE-0002CW-TV; Fri, 28 Aug 2020 12:15:14 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07SJFDcd012956; 
 Fri, 28 Aug 2020 12:15:13 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kBjqD-0002BY-84; Fri, 28 Aug 2020 12:15:13 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 8FBCB13C05CF; Sat, 29 Aug 2020 00:49:47 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Francisco Iglesias <francisco.iglesias@xilinx.com>
Subject: [PATCH v4 4/7] usb: hcd-xhci-sysbus: Attach xhci to sysbus device
Date: Sat, 29 Aug 2020 00:49:37 +0530
Message-Id: <1598642380-27817-5-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bd98a9c6-c88d-46c9-792c-08d84b86b1d8
X-MS-TrafficTypeDiagnostic: CH2PR02MB6229:
X-Microsoft-Antispam-PRVS: <CH2PR02MB62293EC772D3E8CCB0EDC0BACA520@CH2PR02MB6229.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DX1dDA7ll7yfWz1SveOLJ2FGXxXVInZdwESlLC4UDXpMB7ya4gHBRaLXJIp/gauHO4g+LilVimfn9LQk06XGC48ZgaC0CEqAkPCS2Etg56uC4Enw5CEoNtfv2HGkjsW2xpfbPR5umxq3iYl2G9Yb6GhT4YI6x/pNZQbHBgf/A0jFhBYa/D2jwxsYIlRKt+O++ihgAoVNaCr+HuZ5KdRZ490HyFW7zmzg2j5LA9oaMtUe/K5JgPJoMajaeAEWDZfjBdTTePs1SdmFVFbDwFx0XhG83PikXW7cLvczmdeYvIGBaz6llZEZZK5Jcc7209Vc0m9dqm0AJQYaYpgQ9mxPePWBY4So7zZOmHULpwJ5x6VISfZpwuD4ZzSDUxQWv1fU14q3G2jmo2U6xWUnNdhwA==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(376002)(346002)(136003)(39860400002)(396003)(46966005)(6636002)(5660300002)(7416002)(70586007)(54906003)(82740400003)(70206006)(8936002)(316002)(110136005)(26005)(47076004)(42186006)(83380400001)(8676002)(4326008)(356005)(36756003)(2906002)(186003)(426003)(81166007)(82310400002)(6666004)(2616005)(6266002)(336012)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 19:15:15.4230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd98a9c6-c88d-46c9-792c-08d84b86b1d8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6229
Received-SPF: pass client-ip=40.107.76.70; envelope-from=saipava@xilinx.com;
 helo=NAM02-CY1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 15:30:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 sai.pavan.boddu@xilinx.com, qemu-devel@nongnu.org,
 Paul Zimmerman <pauldzim@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Ying Fang <fangying1@huawei.com>,
 =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use XHCI as sysbus device, add memory region property to get the
address space instance for dma read/write.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/usb/Kconfig           |  5 +++
 hw/usb/Makefile.objs     |  1 +
 hw/usb/hcd-xhci-sysbus.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci-sysbus.h | 32 ++++++++++++++++
 hw/usb/hcd-xhci.h        |  1 +
 5 files changed, 138 insertions(+)
 create mode 100644 hw/usb/hcd-xhci-sysbus.c
 create mode 100644 hw/usb/hcd-xhci-sysbus.h

diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index d9965c1..a251501 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -48,6 +48,11 @@ config USB_XHCI_NEC
     depends on PCI
     select USB_XHCI
 
+config USB_XHCI_SYSBUS
+    bool
+    default y if USB_XHCI
+    select USB
+
 config USB_MUSB
     bool
     select USB
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 029b040..f16a3c3 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -12,6 +12,7 @@ common-obj-$(CONFIG_USB_EHCI_SYSBUS) += hcd-ehci-sysbus.o
 common-obj-$(CONFIG_USB_XHCI) += hcd-xhci.o
 common-obj-$(CONFIG_USB_XHCI_NEC) += hcd-xhci-nec.o
 common-obj-$(CONFIG_USB_XHCI_PCI) += hcd-xhci-pci.o
+common-obj-$(CONFIG_USB_XHCI_SYSBUS) += hcd-xhci-sysbus.o
 common-obj-$(CONFIG_USB_MUSB) += hcd-musb.o
 common-obj-$(CONFIG_USB_DWC2) += hcd-dwc2.o
 
diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
new file mode 100644
index 0000000..d5b4656
--- /dev/null
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -0,0 +1,99 @@
+/*
+ * USB xHCI controller for system-bus interface
+ * Based on hcd-echi-sysbus.c
+
+ * SPDX-FileCopyrightText: 2020 Xilinx
+ * SPDX-FileContributor: Author: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "hcd-xhci-sysbus.h"
+#include "hw/irq.h"
+
+static void xhci_sysbus_intr_raise(XHCIState *xhci, int n, bool level)
+{
+    XHCISysbusState *s = container_of(xhci, XHCISysbusState, xhci);
+
+    qemu_set_irq(s->irq[n], level);
+}
+
+void xhci_sysbus_reset(DeviceState *dev)
+{
+    XHCISysbusState *s = XHCI_SYSBUS(dev);
+
+    device_legacy_reset(DEVICE(&s->xhci));
+}
+
+static void xhci_sysbus_realize(DeviceState *dev, Error **errp)
+{
+    XHCISysbusState *s = XHCI_SYSBUS(dev);
+    Error *err = NULL;
+
+    object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);
+    object_property_set_bool(OBJECT(&s->xhci), "realized", true, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    s->irq = g_new0(qemu_irq, s->xhci.numintrs);
+    qdev_init_gpio_out_named(dev, s->irq, SYSBUS_DEVICE_GPIO_IRQ,
+                             s->xhci.numintrs);
+    if (s->xhci.dma_mr) {
+        s->xhci.as =  g_malloc0(sizeof(AddressSpace));
+        address_space_init(s->xhci.as, s->xhci.dma_mr, NULL);
+    } else {
+        s->xhci.as = &address_space_memory;
+    }
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->xhci.mem);
+}
+
+static void xhci_sysbus_instance_init(Object *obj)
+{
+    XHCISysbusState *s = XHCI_SYSBUS(obj);
+
+    object_initialize_child(obj, "xhci-core", &s->xhci, TYPE_XHCI);
+    qdev_alias_all_properties(DEVICE(&s->xhci), obj);
+
+    object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
+                             (Object **)&s->xhci.dma_mr,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
+    s->xhci.intr_update = NULL;
+    s->xhci.intr_raise = xhci_sysbus_intr_raise;
+}
+
+static Property xhci_sysbus_props[] = {
+    DEFINE_PROP_UINT32("intrs", XHCISysbusState, xhci.numintrs, MAXINTRS),
+    DEFINE_PROP_UINT32("slots", XHCISysbusState, xhci.numslots, MAXSLOTS),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void xhci_sysbus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = xhci_sysbus_reset;
+    dc->realize = xhci_sysbus_realize;
+    device_class_set_props(dc, xhci_sysbus_props);
+}
+
+static const TypeInfo xhci_sysbus_info = {
+    .name          = TYPE_XHCI_SYSBUS,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(XHCISysbusState),
+    .class_init    = xhci_sysbus_class_init,
+    .instance_init = xhci_sysbus_instance_init
+};
+
+static void xhci_sysbus_register_types(void)
+{
+    type_register_static(&xhci_sysbus_info);
+}
+
+type_init(xhci_sysbus_register_types);
diff --git a/hw/usb/hcd-xhci-sysbus.h b/hw/usb/hcd-xhci-sysbus.h
new file mode 100644
index 0000000..a308753
--- /dev/null
+++ b/hw/usb/hcd-xhci-sysbus.h
@@ -0,0 +1,32 @@
+/*
+ * USB xHCI controller for system-bus interface
+ *
+ * SPDX-FileCopyrightText: 2020 Xilinx
+ * SPDX-FileContributor: Author: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
+ * SPDX-sourceInfo: Based on hcd-echi-sysbus
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_USB_HCD_XHCI_SYSBUS_H
+#define HW_USB_HCD_XHCI_SYSBUS_H
+
+#include "hw/usb.h"
+#include "hcd-xhci.h"
+#include "hw/sysbus.h"
+
+#define TYPE_XHCI_SYSBUS "sysbus-xhci"
+#define XHCI_SYSBUS(obj) \
+    OBJECT_CHECK(XHCISysbusState, (obj), TYPE_XHCI_SYSBUS)
+
+
+typedef struct XHCISysbusState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+    XHCIState xhci;
+    qemu_irq *irq;
+} XHCISysbusState;
+
+void xhci_sysbus_reset(DeviceState *dev);
+#endif
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index fea1761..b951df4 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -190,6 +190,7 @@ typedef struct XHCIState {
 
     USBBus bus;
     MemoryRegion mem;
+    MemoryRegion *dma_mr;
     AddressSpace *as;
     MemoryRegion mem_cap;
     MemoryRegion mem_oper;
-- 
2.7.4


