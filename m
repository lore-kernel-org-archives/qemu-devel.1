Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD74CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 06:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206D321D40
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 06:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RNDgy0dA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206D321D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGG8t-0002n0-6M
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 02:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kGG3b-0004wi-4N
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 02:27:43 -0400
Received: from mail-eopbgr700086.outbound.protection.outlook.com
 ([40.107.70.86]:11174 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kGG3X-0006CU-Bf
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 02:27:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nA8rtHoGdbPvhssLKfWOB7SqbGsnYcYy/iZdDbqm7BvlTanYttmbeQUKrbQZXr2/kjkdk61cTyBAICsH6/CsHIY0bGRDAX6C2reeqxTksf70MjkDFcuaesn6lCGl451KJZ1te63ehDeWdwWtIQwIDNLACyGkiJtNeQBpkLCjW+bQ1aIlB+w9oq/QGeASN54OR5iDTNDJOD5Mw2SmzE1PV6Vpncn4OTxV9IIQvtIOVQuYbhFMsqEMXlXu8ey/yvkoB8bprsYnyr/apfDmopm5As0ZMR5uM5tN6XlYO2gC5WJyrn9hWryE6xvR4WJyWID+BvL8rhBhFQ82+5PponPtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIrjYQb8dB1q9iXtIMtFoIgzqkdDeUZlzAvpa5uDI+s=;
 b=QL93ZFFiuHxfRjgx8JoBe4txJ7eRW84HCo4esJDwiNKBeRzvRtbQYWVga4juMKhYszbu0I/lKhmGnRraO3JgvqBFGZ8HqmYBLOl+oYTvZNU7wKbaw/Qvst4ENwhjSf5uMaN7V7lfuNTVztMQHlLkuCLv2RGxPvB7bTXnSFeR4q+GhbPIV2alrgQN5IQEW+tmXBicqYQz13ggtvHyopU/4i2C1/9uxQ+MfHk2HYTbDRle8tuil6eLxWx+hWX3tPQOMnWkeIVicKwV4CRK7A5ztwWXeBtjOgutreK8dWRECxm4OnudgMF9YDzxasbIjUDSm51uCqHaEcPDg5bw74RoVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIrjYQb8dB1q9iXtIMtFoIgzqkdDeUZlzAvpa5uDI+s=;
 b=RNDgy0dAZHJpUAw2PWovenjn3jHgOpgndJpoV9J7Wcq3uaFPBejyEJrg0Xv+HtLvxiRtTqphyWtWTzXnJ5kCNNhJTxJcMxwac4ob8DBJEPc+o9T0QDQDDAKLtLNZNHo/O539dqYbpMjCdl+ttz+gW+DdML1Ut9QSkGc5ZSVlp0I=
Received: from CY4PR2201CA0020.namprd22.prod.outlook.com
 (2603:10b6:910:5f::30) by BN8PR02MB5907.namprd02.prod.outlook.com
 (2603:10b6:408:bd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 10 Sep
 2020 06:27:36 +0000
Received: from CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:5f:cafe::1f) by CY4PR2201CA0020.outlook.office365.com
 (2603:10b6:910:5f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 06:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT056.mail.protection.outlook.com (10.152.74.160) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 06:27:35
 +0000
Received: from [149.199.38.66] (port=57260 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kGG3C-0000JJ-W4; Wed, 09 Sep 2020 23:27:18 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kGG3T-0001Vd-I4; Wed, 09 Sep 2020 23:27:35 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08A6RYcY029639; 
 Wed, 9 Sep 2020 23:27:34 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kGG3R-0001VK-UI; Wed, 09 Sep 2020 23:27:34 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 5856B13C0569; Thu, 10 Sep 2020 12:01:34 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: [PATCH v5 4/7] usb: hcd-xhci-sysbus: Attach xhci to sysbus device
Date: Thu, 10 Sep 2020 12:01:06 +0530
Message-Id: <1599719469-24062-5-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599719469-24062-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1599719469-24062-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d3adeeaf-6a00-488a-769e-08d855529ba8
X-MS-TrafficTypeDiagnostic: BN8PR02MB5907:
X-Microsoft-Antispam-PRVS: <BN8PR02MB5907C8F0DEB0545DF9F080ADCA270@BN8PR02MB5907.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6cBUAD+FK7ups0J4ttRpwJ2YmJ+7kZTheGtKO69e1+mvIejChxkw3kJ23YaAMkKIxUJok8jmAQ9JjNUBDJXVnL0nm2YKUIvX3oGrxRWYL37xusCAcV97cyTtB/1oTqpXF26kYM9a/z55aNICJmpD9pWQfn+/jO5jGC7XWJfpjBB52E1QmZ+5inWJ6IY86Mu8gYTzDVbA7mN4/JeReiI1HbUWnhJzjGSHhWrHA+DcvGaMSZVdU2SYjKFzblC5He5N1YQ5lBz+/yzuQYvWDg5/+DmOBIUixlRDHwTtvjndPZ4Fcz8OHGDNAjSXw997FSBKMh47aIY6NSTmBT+qj/NnT9VCfnMaAg3eWUiuh7/wG9g1cTOhTDw5rCdWOqP+3xokYBH/5iOgZ/U1d0VSj/W8A==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(346002)(396003)(376002)(39860400002)(136003)(46966005)(47076004)(26005)(54906003)(186003)(356005)(5660300002)(8936002)(36756003)(83380400001)(4326008)(81166007)(110136005)(2906002)(7416002)(70206006)(70586007)(316002)(42186006)(6666004)(82310400003)(478600001)(336012)(82740400003)(8676002)(107886003)(426003)(2616005)(6636002)(6266002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 06:27:35.9973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3adeeaf-6a00-488a-769e-08d855529ba8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5907
Received-SPF: pass client-ip=40.107.70.86; envelope-from=saipava@xilinx.com;
 helo=NAM04-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 02:27:38
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
index e4f36c6..ce452ed 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -190,6 +190,7 @@ typedef struct XHCIState {
 
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


