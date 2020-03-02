Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F96AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 09:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7022469C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 09:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NW78oHT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7022469C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8hbY-0005Go-Dc
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 04:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j8hZ1-00028t-KK
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j8hZ0-0006rt-2G
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:40:39 -0500
Received: from mail-eopbgr750041.outbound.protection.outlook.com
 ([40.107.75.41]:9026 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1j8hYz-0006qj-Qv
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:40:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atRQMDbI6aII/auppwe39IIwWWZE8YCjr+71qsqEQriOk3TSUW4ezx5MPF69ymGXnlGWoKMATn2BVvSAFH+fS8dqw4xz/5isy0++5PtSeamYwz7CVJ+69rVliz0REkNx/h2o7qQ7uKu+vIQBCXmUdeHpChRa+MvfndGfALHMOxOyuBkibFJXSlq4ud4vRm32tXrd0p5mP/9lV4Kl1XPCXBjHAN0gzbdxW4vSIdu3SA7MJixl9ij5r9DRHU/U2QW7HLeMnDqCip7qHWozeP01NlEdVof6FwJf0S/fOAE+NMzuDmHNxWHNGdhOw6QcjZaiqQUtGRg5rq6WEUP4TMnmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mMVYEEb3PD36GPTXfPy0X4/PCJVwrRbWfMTG7jDNkc=;
 b=VKJR9XXrGN5y2MZGwh1ONvPSuVBpX25Ql65gXtxLYbZnXdNm5qfYsVqjZE1jxB5gr4ZqAXzpfDUN509fFajloSdqWl6yMtvzqmHRmGt34JjYhFr+yBvq2F9mqLDued1u6j4GynXzg4yNKGIVbkqwiD9SXVUE3W6Q13KNy0jLTZbtDOUm05+fRinuM9DPrwomX9Xhu8xMOyH891BwOJxTKUC6lKL++yykJ77gDvXOl/pnWBSXuOXGmErLpT0O0unxqNeId5HG6yAxWw/PX7RC+1nOoMq37l6bhZbmSjZThAT/qNWLWP5en1dZMG6zGs2sIdA61C3ryz+srthoMhrcIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=weilnetz.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mMVYEEb3PD36GPTXfPy0X4/PCJVwrRbWfMTG7jDNkc=;
 b=NW78oHT3R3IHRdrY8GQvcscgOFnETNvKSkO4md/yV+BBYzXYO/u//7EJIdTkwy3MDDqfsvxhf0HMw0orJUIGMDdDgKaVrlpZOLonu04GdpcM/JaeWBXMZ+RI4lhCzliGmfVzHLX8dQxrksFySwGhksbzFT/kIaas8HvqD2YKGsc=
Received: from BL0PR0102CA0010.prod.exchangelabs.com (2603:10b6:207:18::23) by
 BYAPR02MB5128.namprd02.prod.outlook.com (2603:10b6:a03:70::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Mon, 2 Mar 2020 09:40:31 +0000
Received: from BL2NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:18:cafe::47) by BL0PR0102CA0010.outlook.office365.com
 (2603:10b6:207:18::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Mon, 2 Mar 2020 09:40:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; weilnetz.de; dkim=none (message not signed)
 header.d=none;weilnetz.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT034.mail.protection.outlook.com (10.152.77.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2772.15
 via Frontend Transport; Mon, 2 Mar 2020 09:40:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j8hYs-0006QZ-38; Mon, 02 Mar 2020 01:40:30 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j8hYm-0003GO-Ud; Mon, 02 Mar 2020 01:40:24 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0229eJ3s020904; 
 Mon, 2 Mar 2020 01:40:19 -0800
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1j8hYg-00036u-PZ; Mon, 02 Mar 2020 01:40:19 -0800
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 0CF1B13C01F2; Mon,  2 Mar 2020 15:05:28 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yang Zhong <yang.zhong@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Gonglei <arei.gonglei@huawei.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Vikram Garhwal <fnu.vikram@xilinx.com>
Subject: [PATCH 2/3] usb/hcd-xhci: Move qemu-xhci device to hcd-xhci-pci.c
Date: Mon,  2 Mar 2020 15:05:23 +0530
Message-Id: <1583141724-6229-3-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583141724-6229-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1583141724-6229-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(189003)(199004)(2906002)(7416002)(6636002)(36756003)(336012)(26005)(478600001)(81166006)(8676002)(81156014)(426003)(2616005)(356004)(6666004)(8936002)(42186006)(316002)(70586007)(110136005)(5660300002)(70206006)(6266002)(186003)(4326008)(921003)(2004002)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR02MB5128; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d34cf96-3665-4ec1-3c43-08d7be8dbf8c
X-MS-TrafficTypeDiagnostic: BYAPR02MB5128:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5128811F1455D95B7C5FD24DCAE70@BYAPR02MB5128.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggZdbu4S4NSnEV3rSYPNH5pC/KQG71AJHtsJzF9P42jmcu+yQYfbqiUQ2KdQlcE0FarHmPfCIGI8iMnj4xKKtOW3GoVUBh3tdQc8J15Jiwfm4EMtz6uCyPeBB/RNpQ/RfMpGfUaHYArBSr0j+GwmuFF3ptNIpXSt321kKjLVQT5H/68Fi5rHBVFHQR33/PTkZDhnhFNzEzactLQPHb3BgsCyZTTWev6SWCCTu5FSChA+clma+C2TZ27XJGT7vn7ETB8cMaaNer5YLLAcOX3dZfytzOsjRZO358gyx584HhkVH3pTQZZf1x2yKkhLxYrBlRHLo4hoMQTm0U9aZ+AGcgJElfv4vGQMC/9GmUd3EnGT6G+odDOI+rSD4psTsbleCzHew6af+CCaeeXl2ApiwF6nBpeWPSkL9XBBjnloa6DdwyU/nAbNDeGlGqxdWIPnkjhVyPLj83tcjRb0br+lrDtyG6Hl5154YHeSCkaXPHZRHPcwN2fjhceOmO/AmskRRvC1qRDbvZ0OKKh5sqGy0CbC6kRDxDkZC3tsMIh5abVAaDRoGkfedqFLlJaCLdnNyL/4JGaN5i4SQ1zBcatw4DB01R+zO6bxPTnfTtX1aV0=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 09:40:30.7117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d34cf96-3665-4ec1-3c43-08d7be8dbf8c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5128
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.41
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move pci specific devices to new file. This set the environment to move all
pci specific hooks in hcd-xhci.c to hcd-xhci-pci.c.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/usb/hcd-xhci-pci.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci.c     | 40 ++------------------------------
 hw/usb/hcd-xhci.h     |  2 ++
 3 files changed, 68 insertions(+), 38 deletions(-)
 create mode 100644 hw/usb/hcd-xhci-pci.c

diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
new file mode 100644
index 0000000..26af683
--- /dev/null
+++ b/hw/usb/hcd-xhci-pci.c
@@ -0,0 +1,64 @@
+/*
+ * USB xHCI controller with PCI system bus emulation
+ *
+ * Copyright (c) 2011 Securiforest
+ * Date: 2011-05-11 ;  Author: Hector Martin <hector@marcansoft.com>
+ * Based on usb-ohci.c, emulates Renesas NEC USB 3.0
+ * Date: 2020-03-01; Author: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
+ * Moved the pci specific content for hcd-xhci.c to hcd-xhci-pci.c
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
index 6e88670..ba07ca2 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -429,12 +429,12 @@ static const char *ep_state_name(uint32_t state)
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
@@ -3691,13 +3691,6 @@ static Property xhci_properties[] = {
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
@@ -3717,7 +3710,6 @@ static const TypeInfo xhci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(XHCIState),
     .class_init    = xhci_class_init,
-    .instance_init = xhci_instance_init,
     .abstract      = true,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
@@ -3726,37 +3718,9 @@ static const TypeInfo xhci_info = {
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
index 18bed7e..ca03481 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -232,4 +232,6 @@ struct XHCIState {
     bool nec_quirks;
 };
 
+bool xhci_get_flag(XHCIState *xhci, enum xhci_flags bit);
+void xhci_set_flag(XHCIState *xhci, enum xhci_flags bit);
 #endif
-- 
2.7.4


