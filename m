Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92680C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3E6206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="k1/8rM5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3E6206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsr8u-0003P1-IA
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 13:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jsqsW-0004QI-D0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:55:32 -0400
Received: from mail-dm6nam11on2073.outbound.protection.outlook.com
 ([40.107.223.73]:59008 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jsqsQ-0007CB-2A
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:55:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8lBAKOU4JmkimpULEvFFwHO2rpVY8AZCk9D9X2L4C13OqBxZUY0Q8wDrmzHJthEZVzapL5je6hn6ocnw3wLP0vGw9gUth7+FmtkcBtB011xRCFTzOJOvOHK5UByTwwRAktwJ5OU9VEKtIh+67Ntof3I0RtqeJhdwZ5KszdyV38zfHZ/B2/gcoNbofYpR2soqw9hEuQ7tiQmpCPiSeG8wyPtKvpTrr3pHp3dlF9G6wfZu7vcIPo3SX10aiKZCIyvYW+sMcZLipYdgub1R77VizG8/GNdogTeZYEbhuEx8MmL89I3JuEHGzaQL8owKwAOl0Z/oYWCAFCZF5MxH212IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cjt9EbqZl8h/te347O1Na0uYflpzWN9ZYZrP/vrcpXA=;
 b=dImeHGdFHX/bQ7dfglCrhf7pnghsgyiGOJWj61bHqhhD1hlH3FuzgKnsBwHG32b7SFbfIJr5Kj4qXd2NAK/QYlrgvPA093oqg+d575yrOQytmXyQB9kYB6uwEvwKYH8DzeVaQvToDqX1Jm4NjrjXzkmnITz/VwPTCBsKVvRFONRF2IEmYOsKXKQakM/K8G7jPtIcatp+IskJLsWOI20+8q7bs8sKk9NcNAUTNAVZFwvMiGgOcPr1wcBks0eKTuVL1UwNm72LxqKbv8pQ/ePWcUJiNu/vM5ZNmgiwoSw92iTeZohcUEfMeVC/l/WOlhRe5aiozG1wMKEw0AdsRjHIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cjt9EbqZl8h/te347O1Na0uYflpzWN9ZYZrP/vrcpXA=;
 b=k1/8rM5QbGfeVhN0McP1xq1dE9+ktl9MA7SYHA2htCgwAjj+yTZ3B/+HN0tvgMxvD60qhQuupTJh4FSsn/Ov72pvyxLLTa6Ap5hQFtlVIQTZVa7kbwxHGofuOHvXwmoAgQdhmsC6a9p0Z3lYjqwlXikxAWe6DLlhBvhekFq+Nl0=
Received: from CY4PR1101CA0023.namprd11.prod.outlook.com
 (2603:10b6:910:15::33) by BYAPR02MB5797.namprd02.prod.outlook.com
 (2603:10b6:a03:11c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Tue, 7 Jul
 2020 16:55:23 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:15:cafe::f3) by CY4PR1101CA0023.outlook.office365.com
 (2603:10b6:910:15::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Tue, 7 Jul 2020 16:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server id 15.20.3153.24 via Frontend Transport; Tue, 7 Jul 2020 16:55:23
 +0000
Received: from [149.199.38.66] (port=59980 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jsqqs-0003gx-Vl; Tue, 07 Jul 2020 09:53:50 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jsqsM-0001fR-U6; Tue, 07 Jul 2020 09:55:22 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 067GtIrZ015049; 
 Tue, 7 Jul 2020 09:55:18 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jsqsI-0001ee-8a; Tue, 07 Jul 2020 09:55:18 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id E8F3F13C0366; Tue,  7 Jul 2020 22:14:39 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 2/3] usb/hcd-xhci: Move qemu-xhci device to hcd-xhci-pci.c
Date: Tue,  7 Jul 2020 22:14:30 +0530
Message-Id: <1594140271-16462-3-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594140271-16462-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1594140271-16462-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(46966005)(8676002)(70586007)(70206006)(5660300002)(186003)(2616005)(4326008)(54906003)(498600001)(36756003)(26005)(8936002)(107886003)(6666004)(81166007)(7416002)(47076004)(83380400001)(426003)(110136005)(42186006)(356005)(82310400002)(2906002)(336012)(6266002)(2004002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 904ead4d-a57b-4197-be19-08d822968a3c
X-MS-TrafficTypeDiagnostic: BYAPR02MB5797:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5797B1A0025146EA007469D6CA660@BYAPR02MB5797.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFyCsxQLZtT5hlahPb7dhFCCY+jZpDm1vgjoXqwIbFyITyJ7X6tJ8HQ1hZE3+lXOr2ZIFAUcbER3wVNxXVwlGY9m6cWTHSQnjI8OOcpo9CpdNzEkdq8j5cksUJg8uxYOCiT2yifqqTcLZ91x0UbSlruN571HKbW4ifOPnhffP85xgWp03wajxmikyz5+LppTjQBLgHfQ2knuJ9VlMI/Ke75eb2rVGCyaaZvtzE3YHqeLVNAXBY+U7k0vIdHq6WiCZebJSsZyAA1vzi+12BAbs0yGOEoDLWyseTKcr0oow8d8PlTcfyZVXlEShBSe63h260lc9wsXfkXirI16IthBMPGNOluw2Q2e7gk1swVdw/N30m+5WTGYql5d6F0Yh37nUlTIjH3WXbcOyrkhglJwKaFArS3KQbr6GtpIbzeZgVQQH2XXasjhD11CIXFGNmSBYCZEa+NrHbfWka0shiyUmgOJV4CQFXPs9VkMz/gfgxy89sHQ36+VlW2mXQlPOAqc
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 16:55:23.2410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 904ead4d-a57b-4197-be19-08d822968a3c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5797
Received-SPF: pass client-ip=40.107.223.73; envelope-from=saipava@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 12:55:24
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Vikram Garhwal <fnuv@xilinx.com>, sai.pavan.boddu@xilinx.com,
 qemu-devel@nongnu.org, Paul Zimmerman <pauldzim@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=27?= <philmd@redhat.com>
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
index fa6ce98..052e26e 100644
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
@@ -3692,13 +3692,6 @@ static Property xhci_properties[] = {
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
@@ -3718,7 +3711,6 @@ static const TypeInfo xhci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(XHCIState),
     .class_init    = xhci_class_init,
-    .instance_init = xhci_instance_init,
     .abstract      = true,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
@@ -3727,37 +3719,9 @@ static const TypeInfo xhci_info = {
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
index edbd926..34bdb22 100644
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


