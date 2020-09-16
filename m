Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C270EC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFF3206DC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NyVz9O84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFF3206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYOa-0003rw-VJ
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIYHp-0002WV-BP
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:19:54 -0400
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com
 ([40.107.93.66]:26976 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIYHm-0003j9-2F
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:19:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asc9MmPb/g1bLO6/DmjGlTEzcU+8+xAo7nBPGCLqQ910pi6fcJowPThX5+A/B3c/uyxhQyBvr2J5hGnGM6ECgxkxODCASUH40meL9XpIGxeO6F4U2TSCer4rFFzSa7NO/Jm662iSRes6uWUnTRyQTdpCAwtQ8CoLEa9v11Z+HxolHyIyFRmirz0B7NIx3z9N6xdaRPbRz0goNc4b1mWih24Udv1CB9f9fsJ19FzBy5wv+ib5kpq5UacD4UqAwviLgnd36TKpTJWc5OnRiFHBA0X6ok2yGHd15SsW7xHttFRfyLe1BDPMJuUNwWQBfstzUuwIQ74q7gTzNT4gTh06Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqR/3x7/h/vE0Iove5QMCJbn2MqiD96QXWHQCbAlVRE=;
 b=Suy2/NUo44X+h1KOcJT97M1FUbl5/ZAz7UNeBsw08tDvjYLSJpukoWEDYuJt0OwgLMRP1hJhg94ZMw+utg39ac1lB9aKBprNnaE9szC5d0WbUZogjtaqt+uIZZXlTnC4Cowf6kLVg2QYRL3jBQr8uTyVutgXcFDyItCR0W9mbLgYASDttu/+wsbP4ufv6EmZ+Dqdi9e7PjABPFRwPUrYGVrUFcj8MgyGdBV62q3p2HlhQmgPAl/Z1D3o0SoZb7/yrPY+ewl+qNu4Ou1ElygY2T3QCWqS/O9hO0iXffLWGJMlmSNbqXW5iiOG6M+xc+oyjy5rRbesCbTuGRnMvtWuEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqR/3x7/h/vE0Iove5QMCJbn2MqiD96QXWHQCbAlVRE=;
 b=NyVz9O84c0SHMut7J4m/VSEbo7hB0A/v9kOHOyLt4aUJz5vbKqHJF7q7kIC+xr6FMjxQ4ONABxS9C5mzih8cThXVw+udLPUNveXxe8XnxznH1AkhD9WxJcIrWaIWmT34C1MmQGloyVzPnwY/WtMG0VO2GSOozxu1BKxXgYr8bhE=
Received: from MN2PR19CA0007.namprd19.prod.outlook.com (2603:10b6:208:178::20)
 by DM5PR0201MB3431.namprd02.prod.outlook.com (2603:10b6:4:76::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.19; Wed, 16 Sep
 2020 14:19:45 +0000
Received: from BL2NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:178:cafe::57) by MN2PR19CA0007.outlook.office365.com
 (2603:10b6:208:178::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 14:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT045.mail.protection.outlook.com (10.152.77.16) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 14:19:44
 +0000
Received: from [149.199.38.66] (port=43161 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kIYHZ-0004AB-A2; Wed, 16 Sep 2020 07:19:37 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kIYHg-0004qI-4A; Wed, 16 Sep 2020 07:19:44 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08GEJh5h010165; 
 Wed, 16 Sep 2020 07:19:43 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kIYHe-0004pp-GY; Wed, 16 Sep 2020 07:19:42 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 9EDCA13C029D; Wed, 16 Sep 2020 19:53:25 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: [PATCH v7 4/7] usb: hcd-xhci-sysbus: Attach xhci to sysbus device
Date: Wed, 16 Sep 2020 19:52:17 +0530
Message-Id: <1600266140-20763-5-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600266140-20763-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1600266140-20763-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 09270677-6087-4dd9-b3f9-08d85a4b8f41
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3431:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3431256EE5DA49AF148EC4C2CA210@DM5PR0201MB3431.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xnq0LnthNlHxavRYV0endIVr6bMi3KBEAr2gpuyVT15lZpbi2i+GOqHJPvvbBXXU40SeJKTEGU7z7pt8Ai9q1r0cngK8JoV6ORi908Qcv02PaBvlHE9i/JukXY9bGAheYwo6px6VOLY5a+PEFoDLg+hPUGfYoSg6uap1jsgtDoMCogHbA6AolgdPuE9yHbyAq4VpXeYFc/yja0snBwtVJbI5fcgQIBGHizx0KlclhJoMNqt+5Y9SOkcakuScfDNqUZItVxH6fAtaY6XP+YXOS1A9kLEpBcH+mHJSp5yvILc7DnZzIAnLAP1vdadM+8a8M4vEoxGKcmyXpotEGiQbTl5kc17HgN6pBHrGJDTryYQ1yudpjGSkyoz95gJR3dn15cyMuMvAGt5lvoSZBGLmSA==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(346002)(396003)(39860400002)(376002)(136003)(46966005)(81166007)(356005)(47076004)(82310400003)(70586007)(36756003)(110136005)(70206006)(83380400001)(7416002)(478600001)(316002)(42186006)(82740400003)(8936002)(6636002)(336012)(426003)(2906002)(6666004)(8676002)(6266002)(107886003)(2616005)(186003)(26005)(5660300002)(4326008)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 14:19:44.5270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09270677-6087-4dd9-b3f9-08d85a4b8f41
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3431
Received-SPF: pass client-ip=40.107.93.66; envelope-from=saipava@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 10:19:46
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
 hw/usb/Kconfig           |  5 +++
 hw/usb/hcd-xhci-sysbus.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci-sysbus.h | 32 ++++++++++++++++
 hw/usb/hcd-xhci.h        |  1 +
 hw/usb/meson.build       |  1 +
 5 files changed, 138 insertions(+)
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
index 525291b..4108a65 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -191,6 +191,7 @@ typedef struct XHCIState {
 
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


