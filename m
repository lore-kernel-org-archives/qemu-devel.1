Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0675EC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6023C206C9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JUbnTUqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6023C206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKiH4-0007c5-78
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 09:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kKiBE-00026M-FO
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:18:01 -0400
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com
 ([40.107.93.81]:18496 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kKiBC-0006mG-8t
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:18:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2ahR7qzxjNz0KL61Tl1AvzeWB5F7LkOs+s1Tf/1iKZvmI/5hcWZ5ONupQyqu4XcYnSVc24xBqriUGLno7m2pyIkjO3/CRo1nIhggeu4iI867sdtF9kJmwlHIP3W3AHrCGcl1KtZCBOjRe92AAGGu6uaHXnff7/4U06Ji+moqOu4XMlrQIMNBCI7H0VInW3OaApuUQSxWNYcqEg2FzF6JplTP5sv7i4ePbhGXybk5UTIAg1MQw7FI+46IX3y7To7p/WmjUmpMBdxIxDsOYdd9sTTMoxfzDxuXD7g5ePFIwnNfgMmqVVCXKUySze1aqU857Af5KFTDfZYbBJ8lLM0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22rM46NOxGUZd6o4Kb6N2yE743DKwqHw50BHZckJXAY=;
 b=OPxSSto2c9UFKD0JgmE5W4fZ1yYRFW9aRE1t4R1YACPFpr9xsorOVKt/TBgUUWFKFy1rlLqvssxlrcvcQyM+OgxpVVhr0+i90w2jGUqpyn+6rovM07HhuC5WF3e37AuA8Szerof08QasfETycJEMu7vg/xNLNJ9HNvrm6QYILIwwqPgpXru9npB/F0PEhihhP4yuMHIc273uIqt7boMjA0GHeXhdiXfDMC3kpfSYR2FrG7Z5Ba8wlcW7g97uqqZD9n/aV5DbNk5R4hu9cthQ4pc1g7lgwxU7dLU4eTAUyRS51MpjlzrL5CLu1Xb80KaaZuX+deXDEMbB4y6fy6W5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22rM46NOxGUZd6o4Kb6N2yE743DKwqHw50BHZckJXAY=;
 b=JUbnTUqyGqSn2vDxApFkWxNV3WClV25iqZTq79gueeb+F/rnvtWiTlj9pJm3M8hzvudwkUjJ5qfN9lFMo6Z1gJgLrY904iasc9d67xzGlxaAfHEUc4aYdoa3ABYV2Pf2XupJT6xNoUE+qbNdjmag70ijuufz8rBszZYMxQLHfFs=
Received: from MN2PR01CA0020.prod.exchangelabs.com (2603:10b6:208:10c::33) by
 DM6PR02MB5995.namprd02.prod.outlook.com (2603:10b6:5:157::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.15; Tue, 22 Sep 2020 13:17:55 +0000
Received: from BL2NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:10c:cafe::3f) by MN2PR01CA0020.outlook.office365.com
 (2603:10b6:208:10c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Tue, 22 Sep 2020 13:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT010.mail.protection.outlook.com (10.152.77.53) with Microsoft SMTP
 Server id 15.20.3391.15 via Frontend Transport; Tue, 22 Sep 2020 13:17:54
 +0000
Received: from [149.199.38.66] (port=37444 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kKiAu-0000P9-5A; Tue, 22 Sep 2020 06:17:40 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kKiB8-0008Bt-Co; Tue, 22 Sep 2020 06:17:54 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08MDHrSs020905; 
 Tue, 22 Sep 2020 06:17:53 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kKiB6-0008BS-P1; Tue, 22 Sep 2020 06:17:53 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id C6EF413C03E9; Tue, 22 Sep 2020 18:51:19 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: [PATCH v8 4/7] usb: hcd-xhci-sysbus: Attach xhci to sysbus device
Date: Tue, 22 Sep 2020 18:50:34 +0530
Message-Id: <1600780837-8231-5-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600780837-8231-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1600780837-8231-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 87cc9073-1d46-4814-c0a1-08d85ef9ea9d
X-MS-TrafficTypeDiagnostic: DM6PR02MB5995:
X-Microsoft-Antispam-PRVS: <DM6PR02MB59957576467CF2478D1D7E04CA3B0@DM6PR02MB5995.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YkzvhkJ6zxwHGn0X+QEifAynzeftDeXVR9zbOgVlsFkQlxBz3FPWeSgdhjBXTFrXE5BzP/3UEs6eM9EWBNCTJZMOc3mcczDuYHkWaX68ehbQK88CsgzSjcHwMb9/dVDadzTKqTRCr4/QD8oJRsZTMf4IAa2CEPCR0xT7+u9ANZx3YhymqTC2x7o4Lb734Lr3ge+4WUk5gdn9yotZnr88PyCcVn75Mh5Hhux6bzNYiMancunciXTIha/VuLik+O2sTqKsEd2UlK4bHBPxzovvodjcoYmacISSClylBQmLZ0oybKGzDPwQ33tO9K+/Z1THMyKneErkq37uXS86AZoOH6inHkKi0qTYLfBahQVg/V+BwhM0yP6wZzesoaAEK0krdCo4jQB3Lv8XTGGmBS/THg==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(396003)(39860400002)(376002)(346002)(136003)(46966005)(336012)(36756003)(4326008)(8936002)(7416002)(42186006)(110136005)(316002)(2906002)(426003)(6266002)(54906003)(6636002)(82310400003)(186003)(478600001)(8676002)(47076004)(107886003)(83380400001)(5660300002)(82740400003)(70206006)(70586007)(356005)(81166007)(2616005)(6666004)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 13:17:54.8849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cc9073-1d46-4814-c0a1-08d85ef9ea9d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5995
Received-SPF: pass client-ip=40.107.93.81; envelope-from=saipava@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 09:17:57
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
 qemu-devel@nongnu.org, Paul Zimmerman <pauldzim@gmail.com>,
 Sai Pavan Boddu <saipava@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Ying Fang <fangying1@huawei.com>,
 =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use XHCI as sysbus device, add memory region property to get the
address space instance for dma read/write.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/usb/Kconfig           |   5 +++
 hw/usb/hcd-xhci-sysbus.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci-sysbus.h |  32 ++++++++++++++
 hw/usb/hcd-xhci.h        |   1 +
 hw/usb/meson.build       |   1 +
 5 files changed, 148 insertions(+)
 create mode 100644 hw/usb/hcd-xhci-sysbus.c
 create mode 100644 hw/usb/hcd-xhci-sysbus.h

diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index bab582f..4dd2ba9 100644
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
diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
new file mode 100644
index 0000000..852ca51
--- /dev/null
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -0,0 +1,109 @@
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
+static const VMStateDescription vmstate_xhci_sysbus = {
+    .name = "xhci-sysbus",
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(xhci, XHCISysbusState, 1, vmstate_xhci, XHCIState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void xhci_sysbus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = xhci_sysbus_reset;
+    dc->realize = xhci_sysbus_realize;
+    dc->vmsd = &vmstate_xhci_sysbus;
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
index 0040c27..f859a17 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -189,6 +189,7 @@ typedef struct XHCIState {
 
     USBBus bus;
     MemoryRegion mem;
+    MemoryRegion *dma_mr;
     AddressSpace *as;
     MemoryRegion mem_cap;
     MemoryRegion mem_oper;
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 90dc54f..934e4fa 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -22,6 +22,7 @@ softmmu_ss.add(when: 'CONFIG_USB_EHCI_PCI', if_true: files('hcd-ehci-pci.c'))
 softmmu_ss.add(when: 'CONFIG_USB_EHCI_SYSBUS', if_true: files('hcd-ehci.c', 'hcd-ehci-sysbus.c'))
 softmmu_ss.add(when: 'CONFIG_USB_XHCI', if_true: files('hcd-xhci.c'))
 softmmu_ss.add(when: 'CONFIG_USB_XHCI_PCI', if_true: files('hcd-xhci-pci.c'))
+softmmu_ss.add(when: 'CONFIG_USB_XHCI_SYSBUS', if_true: files('hcd-xhci-sysbus.c'))
 softmmu_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true: files('hcd-xhci-nec.c'))
 softmmu_ss.add(when: 'CONFIG_USB_MUSB', if_true: files('hcd-musb.c'))
 softmmu_ss.add(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2.c'))
-- 
2.7.4


