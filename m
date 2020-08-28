Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BA0C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:33:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8AC2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KPcDjnNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8AC2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBk7q-0004Wj-SU
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 15:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kBk4u-0000ls-3p
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 15:30:24 -0400
Received: from mail-eopbgr760070.outbound.protection.outlook.com
 ([40.107.76.70]:3598 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kBk4r-0004qQ-9h
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 15:30:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlUv/BLD/+2P35cKyxvzBIxKBjonwZyD5tOEwE+MWB41XD12wccbzebemmcbonog6byLtHNtL15rOS820P20+33MBq3QGW8WzAHGL69YcCXPwlHpR6opBPRbdIEoY63RZBcxGB4xHHPfOrQvL+Wr/QiMWVdzjoo1ZDWK9y92f5b1bjSqod+5+kuLGvadshJl3Y1vIOF6tfDPtU3cLqdZmkXqgzsSxO98m0vFkg220sv9G/oyYnAVDFLR28LpZV3Dv2HN+SB2NVJerZHzTi47tSbDtN4mghl+6SzS5MXi3WMgFq6Iz8MJ7ivtV8TEgtYf5AsvHc8HC6xuhjtFw4thLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu+tLdD6tricKGpZy/xEAAUIZkI/8bMbl0Z9NnFs8gM=;
 b=J4MxkhltpfYqyH+6pc33DAGZKUlNQe4IcK5VhBuSAHimYoGE+9rc6Xuz8/0mmQm2R8FS+tk00bISmfLic4+DB9lAvseOFikk9nKlvsQFVGLbEfaWnVFMJas+anDge78Ixv5CznandAUL7PcCPwWnVdcUKvxtCAPt8fbgtK/foBsaaA0TBmeClrN0LZBvVTXxDQhTj/jhDXpWJHi+m3EtxZrA1iUcUo+FqyT11Ek18RD/3eUB6JN6+1rlhpsy40n3ngbZgpTvrclW6McSZAs5cOZvk8uHxpEAda6Q0nZFYmr3M/veOkbSHRecGnn7aOD3Ek1zfin81gRH/vQ4xXdMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu+tLdD6tricKGpZy/xEAAUIZkI/8bMbl0Z9NnFs8gM=;
 b=KPcDjnNe0x9isxRhHJ58x8fwwQQ92T3uEv0K4nCjA6SjG4HIY+as5yio9erPYxM+erTBkJbYOJ0gY8Q9LYtOW+uAamvO2rlvRmvueQ+OU3ctjFyOz/XuFarPvAI+RgtvVmjRzKoADQpa+8AR0BTN7BU8LqkYLMmpbB+S7iH/KUU=
Received: from BL1PR13CA0015.namprd13.prod.outlook.com (2603:10b6:208:256::20)
 by DM6PR02MB5033.namprd02.prod.outlook.com (2603:10b6:5:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Fri, 28 Aug
 2020 19:15:15 +0000
Received: from BL2NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:256:cafe::72) by BL1PR13CA0015.outlook.office365.com
 (2603:10b6:208:256::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend
 Transport; Fri, 28 Aug 2020 19:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT014.mail.protection.outlook.com (10.152.76.154) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 19:15:15
 +0000
Received: from [149.199.38.66] (port=48171 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kBjpg-0007JY-Hn; Fri, 28 Aug 2020 12:14:40 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kBjqE-0002CU-Sj; Fri, 28 Aug 2020 12:15:14 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07SJFDNO013655; 
 Fri, 28 Aug 2020 12:15:13 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kBjqD-0002BW-69; Fri, 28 Aug 2020 12:15:13 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 82DCD13C0582; Sat, 29 Aug 2020 00:49:47 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Francisco Iglesias <francisco.iglesias@xilinx.com>
Subject: [PATCH v4 2/7] usb/hcd-xhci: Move qemu-xhci device to hcd-xhci-pci.c
Date: Sat, 29 Aug 2020 00:49:35 +0530
Message-Id: <1598642380-27817-3-git-send-email-sai.pavan.boddu@xilinx.com>
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
X-MS-Office365-Filtering-Correlation-Id: 52aebbb5-13dc-4e90-e7ee-08d84b86b1c9
X-MS-TrafficTypeDiagnostic: DM6PR02MB5033:
X-Microsoft-Antispam-PRVS: <DM6PR02MB50334094FD0725F1689BDA26CA520@DM6PR02MB5033.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FuKE7QGIBo7QeUVNccl0YgnZOhazd0AOQThom/o95yXXrlXo/z67+uKzcXlWB+GBjViLjpgg/JdlErmSmc6qi8lz15WJXRQKC18JhdrgNXygVy6RI+2keeygLMQGwEGgrUHHzVhkoiqPpalEc4BHGdmVNeMYBMacVxUcMZrZUrDSOUvPJgp8PUpZIS8lpZM49xZNkeRnB2DIRwn5h+sStFLPtvzMhcL/QDN3t+a+KFJDio458rQ2/U3X8fc0pEwgro6NIoiyXfjSUOxdStmG84jdyNPwp6vom849OHm5oE/zKXcHIRiLWvBVExffqwOhWQHEr7zlo16IyUVBj9tz2bAP9wT5IsFVSlq/yPyfhNNfZi5p6MX5qLuwJN6QO3YT6Rib/ivB5sattShxZHPTPe+aUq6EtQBvjcUGA3naPqmqe9PxTZo4n9D46qz5nrgYVqI2OrFNA2CzKSWD7aa+3Oi9EUsVf6e2beB/gJtkFGrpbskbpUtlfwAlzw2ij2Aa
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(136003)(346002)(376002)(39860400002)(396003)(46966005)(42186006)(186003)(83380400001)(316002)(4326008)(54906003)(36756003)(478600001)(2616005)(426003)(5660300002)(336012)(26005)(6636002)(82310400002)(356005)(8936002)(82740400003)(6266002)(70586007)(70206006)(81166007)(8676002)(6666004)(47076004)(7416002)(110136005)(2906002)(2004002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 19:15:15.3245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52aebbb5-13dc-4e90-e7ee-08d84b86b1c9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5033
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

Move pci specific devices to new file. This set the environment to move all
pci specific hooks in hcd-xhci.c to hcd-xhci-pci.c.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/usb/Kconfig        |  6 +++++
 hw/usb/Makefile.objs  |  1 +
 hw/usb/hcd-xhci-pci.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci.c     | 41 ++------------------------------
 hw/usb/hcd-xhci.h     |  3 +++
 5 files changed, 78 insertions(+), 39 deletions(-)
 create mode 100644 hw/usb/hcd-xhci-pci.c

diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index d4d8c37..d9965c1 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -36,6 +36,12 @@ config USB_XHCI
     depends on PCI
     select USB
 
+config USB_XHCI_PCI
+    bool
+    default y if PCI_DEVICES
+    depends on PCI
+    select USB_XHCI
+
 config USB_XHCI_NEC
     bool
     default y if PCI_DEVICES
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index e342ff5..029b040 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -11,6 +11,7 @@ common-obj-$(CONFIG_USB_EHCI_PCI) += hcd-ehci-pci.o
 common-obj-$(CONFIG_USB_EHCI_SYSBUS) += hcd-ehci-sysbus.o
 common-obj-$(CONFIG_USB_XHCI) += hcd-xhci.o
 common-obj-$(CONFIG_USB_XHCI_NEC) += hcd-xhci-nec.o
+common-obj-$(CONFIG_USB_XHCI_PCI) += hcd-xhci-pci.o
 common-obj-$(CONFIG_USB_MUSB) += hcd-musb.o
 common-obj-$(CONFIG_USB_DWC2) += hcd-dwc2.o
 
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
new file mode 100644
index 0000000..1562757
--- /dev/null
+++ b/hw/usb/hcd-xhci-pci.c
@@ -0,0 +1,66 @@
+/*
+ * USB xHCI controller with PCI bus emulation
+ *
+ * SPDX-FileCopyrightText: 2011 Securiforest
+ * SPDX-FileContributor: Hector Martin <hector@marcansoft.com>
+ * SPDX-sourceInfo: Based on usb-ohci.c, emulates Renesas NEC USB 3.0
+ * SPDX-FileCopyrightText: 2020 Xilinx
+ * SPDX-FileContributor: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
+ * SPDX-sourceInfo: Moved the pci specific content for hcd-xhci.c to
+ *                  hcd-xhci-pci.c
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
+#include "hcd-xhci.h"
+#include "trace.h"
+#include "qapi/error.h"
+
+static void qemu_xhci_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->vendor_id    = PCI_VENDOR_ID_REDHAT;
+    k->device_id    = PCI_DEVICE_ID_REDHAT_XHCI;
+    k->revision     = 0x01;
+}
+
+static void qemu_xhci_instance_init(Object *obj)
+{
+    XHCIState *xhci = XHCI(obj);
+
+    xhci->msi      = ON_OFF_AUTO_OFF;
+    xhci->msix     = ON_OFF_AUTO_AUTO;
+    xhci->numintrs = MAXINTRS;
+    xhci->numslots = MAXSLOTS;
+    xhci_set_flag(xhci, XHCI_FLAG_SS_FIRST);
+}
+
+static const TypeInfo qemu_xhci_info = {
+    .name          = TYPE_QEMU_XHCI,
+    .parent        = TYPE_XHCI,
+    .class_init    = qemu_xhci_class_init,
+    .instance_init = qemu_xhci_instance_init,
+};
+
+static void xhci_register_types(void)
+{
+    type_register_static(&qemu_xhci_info);
+}
+
+type_init(xhci_register_types)
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 2590f7a..b15c53b 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -23,7 +23,6 @@
 #include "qemu/timer.h"
 #include "qemu/module.h"
 #include "qemu/queue.h"
-#include "hw/usb.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
@@ -429,12 +428,12 @@ static const char *ep_state_name(uint32_t state)
                        ARRAY_SIZE(ep_state_names));
 }
 
-static bool xhci_get_flag(XHCIState *xhci, enum xhci_flags bit)
+bool xhci_get_flag(XHCIState *xhci, enum xhci_flags bit)
 {
     return xhci->flags & (1 << bit);
 }
 
-static void xhci_set_flag(XHCIState *xhci, enum xhci_flags bit)
+void xhci_set_flag(XHCIState *xhci, enum xhci_flags bit)
 {
     xhci->flags |= (1 << bit);
 }
@@ -3692,13 +3691,6 @@ static Property xhci_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static void xhci_instance_init(Object *obj)
-{
-    /* QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
-     * line, therefore, no need to wait to realize like other devices */
-    PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
-}
-
 static void xhci_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -3718,7 +3710,6 @@ static const TypeInfo xhci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(XHCIState),
     .class_init    = xhci_class_init,
-    .instance_init = xhci_instance_init,
     .abstract      = true,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
@@ -3727,37 +3718,9 @@ static const TypeInfo xhci_info = {
     },
 };
 
-static void qemu_xhci_class_init(ObjectClass *klass, void *data)
-{
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-
-    k->vendor_id    = PCI_VENDOR_ID_REDHAT;
-    k->device_id    = PCI_DEVICE_ID_REDHAT_XHCI;
-    k->revision     = 0x01;
-}
-
-static void qemu_xhci_instance_init(Object *obj)
-{
-    XHCIState *xhci = XHCI(obj);
-
-    xhci->msi      = ON_OFF_AUTO_OFF;
-    xhci->msix     = ON_OFF_AUTO_AUTO;
-    xhci->numintrs = MAXINTRS;
-    xhci->numslots = MAXSLOTS;
-    xhci_set_flag(xhci, XHCI_FLAG_SS_FIRST);
-}
-
-static const TypeInfo qemu_xhci_info = {
-    .name          = TYPE_QEMU_XHCI,
-    .parent        = TYPE_XHCI,
-    .class_init    = qemu_xhci_class_init,
-    .instance_init = qemu_xhci_instance_init,
-};
-
 static void xhci_register_types(void)
 {
     type_register_static(&xhci_info);
-    type_register_static(&qemu_xhci_info);
 }
 
 type_init(xhci_register_types)
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index edbd926..dd5fcd4 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -23,6 +23,7 @@
 #define HW_USB_HCD_XHCI_H
 
 #include "sysemu/dma.h"
+#include "hw/usb.h"
 
 #define TYPE_XHCI "base-xhci"
 #define TYPE_NEC_XHCI "nec-usb-xhci"
@@ -232,4 +233,6 @@ struct XHCIState {
     bool nec_quirks;
 };
 
+bool xhci_get_flag(XHCIState *xhci, enum xhci_flags bit);
+void xhci_set_flag(XHCIState *xhci, enum xhci_flags bit);
 #endif
-- 
2.7.4


