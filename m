Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6465C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14745206C9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Lz3g7SEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14745206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKiE7-0004WX-TA
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 09:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kKiBB-00025w-QG
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:17:58 -0400
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com
 ([40.107.237.54]:6817 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kKiB7-0006lv-Jg
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:17:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZAahH/iQxVS5pq0CbpmAipV6HguYhVO3qSx4AnFqNWMoAE+K3tLFHOcyK0bFXWggQKCyrCBNhJHAGDI3zsCl0T0InheqouyV6dynfS2GlDzZn5TDxD47mvNg1MQPpPqwMYC0RZTYxwigfcaEj6x9/ip+dL4YFJDsR+4+59bg6LwAXAggVjuV9Xgk85x2iSBvPlWYHHJM5X/NnnSTpylEM+DaAkgpQx0XiKxTv8lS4WFsbRmPGpphSSjwWYF2uSsnosgMPEtVaD7TSy22Nz9chRRrZV/pyDigDttHBCcbwuzUr4d6u88HdRjcvAn9IL5aSPULa+H1b2NkRrjPixAlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaj3YJcYViR8UKMJ80luHY/YzNh5RbY1qPbySREXViw=;
 b=ch+XaDoa0VG0VEnboQlIc0Ew2hZK0m+BhH25aptt24C7Tt/jDjE3ouA2KrnQMa/vy7TcSYahxT85v4tn+cVgCsV4Ib7nSh0sWEf7nLmNPP05paDYJ8KmlGPVOPndOiUDHPcMdg9zKMWNHByntGYq5cZkh+zrCRW4T9Nt1Q2XUiQgAoCZjDUupIzmJumIor1ZVtBjRX4/0xVEZ0lt8+PC1OJdulDUujlHTHmW/wJva8DKIRYJj3ao5EDvvhSETdFM2I4svoqi9Ty5XkRnA0ZjRnEdrpfQcXxn49I/yuYGXMxubvcB/p0G6J/LmYZN5GacFhr8+m3G41os4a7sNcXr3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaj3YJcYViR8UKMJ80luHY/YzNh5RbY1qPbySREXViw=;
 b=Lz3g7SEw9KvteQ8aI4vXDUpcBiAVfwBa8nLnb+zl3YPh8nEAH8+TejG3Du9fBoccNi8vFN9fZu6KjBeKLx2ZJL2VsXmCSXBoEgQ05xo79oL9zdPAiNPPqh2LAX1bz5xwdlbBpgPoXbswDTKwIgVZ8xwU1m/BDbFeq2ah4tV0Oj0=
Received: from DM5PR07CA0033.namprd07.prod.outlook.com (2603:10b6:3:16::19) by
 BN6PR02MB2483.namprd02.prod.outlook.com (2603:10b6:404:5e::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Tue, 22 Sep 2020 13:17:51 +0000
Received: from CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::bd) by DM5PR07CA0033.outlook.office365.com
 (2603:10b6:3:16::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Tue, 22 Sep 2020 13:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT030.mail.protection.outlook.com (10.152.75.163) with Microsoft SMTP
 Server id 15.20.3391.15 via Frontend Transport; Tue, 22 Sep 2020 13:17:50
 +0000
Received: from [149.199.38.66] (port=37379 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kKiAq-0000P0-Ad; Tue, 22 Sep 2020 06:17:36 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kKiB4-0008B9-Hh; Tue, 22 Sep 2020 06:17:50 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08MDHnKO020882; 
 Tue, 22 Sep 2020 06:17:49 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kKiB2-00089n-V3; Tue, 22 Sep 2020 06:17:49 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 0204013C03E9; Tue, 22 Sep 2020 18:51:15 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: [PATCH v8 2/7] usb/hcd-xhci: Move qemu-xhci device to hcd-xhci-pci.c
Date: Tue, 22 Sep 2020 18:50:32 +0530
Message-Id: <1600780837-8231-3-git-send-email-sai.pavan.boddu@xilinx.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8083010c-95a3-479e-acb4-08d85ef9e843
X-MS-TrafficTypeDiagnostic: BN6PR02MB2483:
X-Microsoft-Antispam-PRVS: <BN6PR02MB24835DE091FC4FC27DF99416CA3B0@BN6PR02MB2483.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JzFukMjQkHp5lIT5LAwWpKLxyQkKTj8VF1gPI725Aq2hPivDJ+Hk/uv9OqqxJ6ToNvGJcNKmxWRE15w+6lYYmZ0bm7hDT4aOJsNCadxKNy4ytXwsHWk8zEJrXSmacuW0zlsMMcIMt9JsIhmVTP290wO8WxZec+J1jL8C8uSLgvaL1j78vUs/mFP2C5INVVDcOJ6cQdy3xUCO5zmniGVvmjgh6U0gtHUwU9c6AZTf+payZB+T8Glh8hBh5zjgYOZr9NlfJ1dP3oqfIv8wb8UOT7EVeN5TM/SX0ZggYWcARDEBUEmUeglju21T6i+ShMrwQpjSCUhMJpzNnVGYPa4cbNhE7oZRCsPEW4OQvVAwCFoc7rjCgDgF9NtuLcVowJEoo2Z89jTTytWWCPZ0iNSd0+c9QKlJb5CIHYw0zygammNFhCMkkQUrAUKBB3TtDiTLZxKLKf00siQ5GtPUbaVtBEshtxXsfJ+OpGBK62UayXYaR8dvjQ0AeKkbvcamNuqr
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(396003)(136003)(39860400002)(346002)(376002)(46966005)(54906003)(4326008)(6636002)(81166007)(186003)(478600001)(110136005)(36756003)(82740400003)(26005)(82310400003)(356005)(47076004)(83380400001)(70586007)(107886003)(7416002)(70206006)(336012)(6266002)(8676002)(42186006)(8936002)(426003)(2906002)(5660300002)(316002)(2616005)(6666004)(2004002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 13:17:50.9412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8083010c-95a3-479e-acb4-08d85ef9e843
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2483
Received-SPF: pass client-ip=40.107.237.54; envelope-from=saipava@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 09:17:52
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

Move pci specific devices to new file. This set the environment to move all
pci specific hooks in hcd-xhci.c to hcd-xhci-pci.c.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/usb/Kconfig        |  6 +++++
 hw/usb/hcd-xhci-pci.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci.c     | 33 ++------------------------
 hw/usb/hcd-xhci.h     |  4 ++++
 hw/usb/meson.build    |  1 +
 5 files changed, 79 insertions(+), 31 deletions(-)
 create mode 100644 hw/usb/hcd-xhci-pci.c

diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 3fc8fbe..bab582f 100644
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
index 254cf1e..f927567 100644
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
@@ -3730,37 +3729,9 @@ static const TypeInfo xhci_info = {
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
index c8a8ae4..effd46c 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -23,6 +23,8 @@
 #define HW_USB_HCD_XHCI_H
 #include "qom/object.h"
 
+#include "hw/usb.h"
+
 #define TYPE_XHCI "base-xhci"
 #define TYPE_NEC_XHCI "nec-usb-xhci"
 #define TYPE_QEMU_XHCI "qemu-xhci"
@@ -229,4 +231,6 @@ struct XHCIState {
     bool nec_quirks;
 };
 
+bool xhci_get_flag(XHCIState *xhci, enum xhci_flags bit);
+void xhci_set_flag(XHCIState *xhci, enum xhci_flags bit);
 #endif
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index b7c7ff2..90dc54f 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -21,6 +21,7 @@ softmmu_ss.add(when: 'CONFIG_USB_EHCI', if_true: files('hcd-ehci.c'))
 softmmu_ss.add(when: 'CONFIG_USB_EHCI_PCI', if_true: files('hcd-ehci-pci.c'))
 softmmu_ss.add(when: 'CONFIG_USB_EHCI_SYSBUS', if_true: files('hcd-ehci.c', 'hcd-ehci-sysbus.c'))
 softmmu_ss.add(when: 'CONFIG_USB_XHCI', if_true: files('hcd-xhci.c'))
+softmmu_ss.add(when: 'CONFIG_USB_XHCI_PCI', if_true: files('hcd-xhci-pci.c'))
 softmmu_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true: files('hcd-xhci-nec.c'))
 softmmu_ss.add(when: 'CONFIG_USB_MUSB', if_true: files('hcd-musb.c'))
 softmmu_ss.add(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2.c'))
-- 
2.7.4


