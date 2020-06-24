Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88281C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 420D92072E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WXeAwI1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420D92072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6O9-0005qL-I0
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jo6MD-0002vL-Gx
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:26:33 -0400
Received: from mail-eopbgr700067.outbound.protection.outlook.com
 ([40.107.70.67]:2400 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jo6M9-0003U6-Pm
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:26:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWlXEWq2vFmiHLbglk1fnVe4SNFTTTxD3a+FYW5lSk5Nr3nsMbql3BL1ga+xTZAtanVFBjz4UFHo8QUZZeT4GvxLJEXp6ChYpBCa6727ZM5R5FnESmAhQ6DiBPjrWYxfxdbU7bGn3GOX0IZABjfm9jiNHbhe3AGIMKM/UMlJtni5CuoH6AhCT9nHUhZ+5U7e50iUWmKSOx4bE2OlqgubO1O+sPxehBi5aE/BDO1aBhWGTVFA4Scv9Sx+SMlyGrDAPVDmqRI0MI2DqoTmHbNBpECWGB27OgyytxfsRa+T31u7wmfZFZkajSk/AHqbFvegdVpljzR2t/nKTW3xTElfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjCdMS5S+kNLZQAh65ZnT/pCnxofd1Ob4w4Gg10zJcE=;
 b=NiKKjw6FQ+nLBPJDJ5lC5mQR1yfI/OOIPOas/ycmy20mtJCltRkqfvamkq3MnKpQw/aFP3lR8AsYv+MbwkJqbPRmANR9TT8GthgHAgMrBZAbJT4idpqpxqvQljqOaPHC68w+cYkHUrwfzrNRDtZujUNgvTACNUHiIPqASVoY3BHq8yoYGxmBobku7fMzxmIegIz2WmKTEe4Ken41HR9gN4ch9K5c8sQowfkIMhzoBfN6/pVk6JsC9UKkeGAkmZhZzlQhkJH8XEqgK5t3VI6J5WTLGeA5hxynk89KtxX218NgTjnxSoy5pAy1PtmiGtB7ir1Er252akl/xDmjaxDBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjCdMS5S+kNLZQAh65ZnT/pCnxofd1Ob4w4Gg10zJcE=;
 b=WXeAwI1WphS1sFu+qAnuVMRqVqLcIkY5h10sgTmEsAwah22JcztGNLtS7Fb4sYHcEoeEbvFV2j1SVYAWl6o+1ZHQM9RH5sbIBLq/+8PGw7j1gG9vUNyeyWTFujL4Tuthr0tqxHVoMcZ2JyiR7Bacr2YKP9E5osJQmegWICMV57s=
Received: from DM5PR21CA0056.namprd21.prod.outlook.com (2603:10b6:3:129::18)
 by BYAPR02MB5413.namprd02.prod.outlook.com (2603:10b6:a03:99::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.25; Wed, 24 Jun
 2020 14:26:26 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::f9) by DM5PR21CA0056.outlook.office365.com
 (2603:10b6:3:129::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.2 via Frontend
 Transport; Wed, 24 Jun 2020 14:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 14:26:26
 +0000
Received: from [149.199.38.66] (port=43414 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jo6Kt-0001Yu-Qx; Wed, 24 Jun 2020 07:25:11 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jo6M5-0000KO-PB; Wed, 24 Jun 2020 07:26:25 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05OEQOVo017902; 
 Wed, 24 Jun 2020 07:26:24 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jo6M4-0000KG-Hu; Wed, 24 Jun 2020 07:26:24 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 5C5CF13C6069; Wed, 24 Jun 2020 19:46:22 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/3] usb/hcd-xhci: Move qemu-xhci device to hcd-xhci-pci.c
Date: Wed, 24 Jun 2020 19:46:15 +0530
Message-Id: <1593008176-9629-3-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(346002)(136003)(396003)(376002)(46966005)(7416002)(316002)(6266002)(70206006)(36756003)(2906002)(70586007)(26005)(42186006)(47076004)(5660300002)(426003)(82740400003)(356005)(4326008)(82310400002)(110136005)(54906003)(8936002)(6666004)(186003)(81166007)(8676002)(336012)(478600001)(2616005)(83380400001)(2004002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f27302bc-facd-4010-5e88-08d8184a93e0
X-MS-TrafficTypeDiagnostic: BYAPR02MB5413:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5413D17AF87884C8656489D8CA950@BYAPR02MB5413.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQNb9uP6ePd0+jy6EIQ7t+2tt4UtHmw0Lxfn04i0mrGGTH1xPJr8mxl6dsE7rAXXcp+dPTnD/EJ9nriwg7VclUwTCls738SUwQ7sWbpLqN5z0qFnCRx6RZLEASNg4hJPD0FXykQCzT0wY8O0509JEsxR7rYmhj4pVQ68yVN/bVx2n9sE38ra+jo5p5X+N0X8Pv/hQOdvu4teSftWYjHRPxQaDO5hbBkYvd2mmzTEIa914pctDI7o0TxTeBj8HfEQD0hslM2JvpIXzwr54FIpoGLEsOwooJzsj4tTge4AyaxAk72M75g311iD+2xr0hsdjd8i2OejaXGF95HAEJsRXqEyRJ7Dc2/9Fetkeg+qbRdVMog711x+WMvnAAqQydotZIjjiWtNkxd3tTPYvlxQs5Ji/5p3BBYBb9ZEUxch0qgrgX+dG52KVv3lkI2Qr71DJgDLSUaf8RHsgzjWwptNc/XR0Eyvv86YHdxzwO1uBVKeKsIS7XixpDVttrSYNs7b
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 14:26:26.0366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f27302bc-facd-4010-5e88-08d8184a93e0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5413
Received-SPF: pass client-ip=40.107.70.67; envelope-from=saipava@xilinx.com;
 helo=NAM04-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 10:26:28
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move pci specific devices to new file. This set the environment to move all
pci specific hooks in hcd-xhci.c to hcd-xhci-pci.c.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/usb/hcd-xhci-pci.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci.c     | 32 ++------------------------
 hw/usb/hcd-xhci.h     |  2 ++
 3 files changed, 68 insertions(+), 30 deletions(-)
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
index fa6ce98..d340518 100644
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
@@ -3727,37 +3727,9 @@ static const TypeInfo xhci_info = {
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


