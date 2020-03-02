Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B089AC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 09:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CB42469C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 09:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LsLeVA9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CB42469C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8haC-0003Z0-Lm
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 04:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j8hZ1-00028e-BI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j8hYy-0006r9-FI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:40:39 -0500
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com
 ([40.107.92.82]:22497 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1j8hYy-0006qk-6c
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:40:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iqshps5nu9JWwQNjPPqePHD5+xUArXJcGymHZxX1dnootHpu6kWfxWwsrzXmR9nRGVoxpA2ei8iUb6JbPR7R/sPg53kUaV25Q8qftnYusD7wzelXFOxb9ElzuZ0kMS9rmaEsQ1cYDhNfB1I26FDfsysfAo95dveIuORE8xnHZy2N+IctR3Ih7dkuAQyl7CVgvPdkPs9aeanFFU8uZk86+3y1FOWlnbXUTkMyhtfep6l6q9pWISiYPcNNR6VOLYGQN+jhudInr3TTOBU7J3yK31SCb6c6HaYQnPHyF/T/0BgxZlQibP2+O0E/iefDfObdRO04suYvBMXIZ0akR9SimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkGTi7oMX7Ce41GtsQk9ZNS/yzfgMBi+k2OrSgzlogY=;
 b=UBHxxVdFnKb6iGRjW4kfKl1uH7bbkTdLKfRtZwZSaq63UGzU1f59MUmOLZTJqr6FZsC7RlogGG5xmVQ8QerhpPThwlEO9+6wx7Qqlsa/OHLaoZsVq/iRSUkiwJ/kmbQJf4gHuXHN//VTAeU1MnJgDy38m24RSGILr05nz1/d6adepRAKQ6cY4TcZ6kbmlW9BDx1BQgbOe7zcQ+XXtCklheuv+RaCRaLtF4gsNTMStQXntI0RetdlhKYLhViCYCus+R3kE5b6NR1P4VonDMkkMBi3PDHiA+/SU3Mrk12FsI72aC5BL6qfG5Em2qUhTvkuvgBLoMasYIF0fkbIxaYcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=weilnetz.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkGTi7oMX7Ce41GtsQk9ZNS/yzfgMBi+k2OrSgzlogY=;
 b=LsLeVA9Ui3rvnQKW21OewcBuxjxRzGR08tJi7nd8u3eoD+xWpI3kwx121A+c48+4uFszfrUKDG9iQqzIkd2a/ofEPd7F3CpW6lV1uiclDeihwOCG5oETZ3LNy1xHgYmsWtg9/akGEOjdt+4smtMeeDtbM3g1o1ynuuuuL6DJqQ0=
Received: from MN2PR19CA0040.namprd19.prod.outlook.com (2603:10b6:208:19b::17)
 by BY5PR02MB6097.namprd02.prod.outlook.com (2603:10b6:a03:1fe::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 09:40:33 +0000
Received: from BL2NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:19b:cafe::62) by MN2PR19CA0040.outlook.office365.com
 (2603:10b6:208:19b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Mon, 2 Mar 2020 09:40:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; weilnetz.de; dkim=none (message not signed)
 header.d=none;weilnetz.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT056.mail.protection.outlook.com (10.152.77.221) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2772.15
 via Frontend Transport; Mon, 2 Mar 2020 09:40:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j8hYr-0006QY-Qf; Mon, 02 Mar 2020 01:40:29 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j8hYm-0003G2-MO; Mon, 02 Mar 2020 01:40:24 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0229eJgs020912; 
 Mon, 2 Mar 2020 01:40:21 -0800
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1j8hYg-00036w-QK; Mon, 02 Mar 2020 01:40:19 -0800
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 1467013C0A0D; Mon,  2 Mar 2020 15:05:28 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yang Zhong <yang.zhong@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Gonglei <arei.gonglei@huawei.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Vikram Garhwal <fnu.vikram@xilinx.com>
Subject: [PATCH 3/3] usb/hcd-xhci: Split pci wrapper for xhci base model
Date: Mon,  2 Mar 2020 15:05:24 +0530
Message-Id: <1583141724-6229-4-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(136003)(189003)(199004)(478600001)(4326008)(8936002)(26005)(8676002)(81166006)(6266002)(336012)(356004)(6666004)(36756003)(81156014)(186003)(42186006)(316002)(426003)(110136005)(2616005)(70206006)(70586007)(2906002)(5660300002)(30864003)(7416002)(6636002)(2004002)(921003)(1121003)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR02MB6097; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84c4e76a-3b46-4076-e36a-08d7be8dbf9d
X-MS-TrafficTypeDiagnostic: BY5PR02MB6097:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6097082C3325CE86BEEDE218CAE70@BY5PR02MB6097.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ca1aacu1ipp6LsbQj1HyZKrg4fgHi54ShDiRR8lHX9gK+JWML5AACdYgAVjflOYQkXDLaxoy+MhDeBzLST4jimE/3/uRFi65OSYVLBreSVr62mDKG9muDFHiSbKBaoKqr6sV3GH+QVU7KIAQq3Bz1eSkro7ySvtqnQRQj/1PT5ohzY4e5Yg59SvU6A8P8zjEdLaStOCc1VWHQpi7ERo3RzRRHTWT9aD7BKfc7UOxswS13Jh7PT7+k7prpQ+bSeHntSao/khiUWCI2N7e2S+0b2COIhwGpSpBg5sYN9XIUxLyEf9zMa/iZQ55bLt8Rsf/mH9Xc0wj/Nh9RjE7Ei843NKHMMAJ4RgYCPPOwEoEV6Ye/1bJ5+bR1HGOzjdX4pFrM/LyDhdLn2s6vRlLqlO0V9ZxzokEbfJ5RRkxxHcZC+tJNYj9LN0JlCVbDjOzeBeD5DBnnJe8AcwzjCGFXEKo+FIzx3roMbx/1ouSWLCKGLeK66hZ6ITjOLQcLxjj9an/4a3pJlxFqQ1u/vA25Vj6IuBJ0XRmD/++rGxtZJxi/AmbrwL0IoXp94suUapvPqcUorZwvYTXb08rvHYRf4JjwLWCP+BtDkMtuJriXd2k7+6MepAzCP13BIAkcxf0NMEP1n/hgAxzC7mQV/YvFCuKkQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 09:40:30.7213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c4e76a-3b46-4076-e36a-08d7be8dbf9d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6097
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.82
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

This patch sets the base to use xhci as sysbus model, for which pci
specific hooks are moved to hcd-xhci-pci.c. As a part of this requirment
msi/msix interrupts handling is moved under XHCIPCIState. Made required
changes for qemu-xhci-nec.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/usb/Kconfig        |   6 ++
 hw/usb/Makefile.objs  |   1 +
 hw/usb/hcd-xhci-nec.c |   8 +--
 hw/usb/hcd-xhci-pci.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/usb/hcd-xhci-pci.h |  47 ++++++++++++
 hw/usb/hcd-xhci.c     | 167 +++++++------------------------------------
 hw/usb/hcd-xhci.h     |  12 ++--
 7 files changed, 275 insertions(+), 158 deletions(-)
 create mode 100644 hw/usb/hcd-xhci-pci.h

diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 5e70ed5..e93541e 100644
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
index 2b10868..ff150fe 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -11,6 +11,7 @@ common-obj-$(CONFIG_USB_EHCI_PCI) += hcd-ehci-pci.o
 common-obj-$(CONFIG_USB_EHCI_SYSBUS) += hcd-ehci-sysbus.o
 common-obj-$(CONFIG_USB_XHCI) += hcd-xhci.o
 common-obj-$(CONFIG_USB_XHCI_NEC) += hcd-xhci-nec.o
+common-obj-$(CONFIG_USB_XHCI_PCI) += hcd-xhci-pci.o
 common-obj-$(CONFIG_USB_MUSB) += hcd-musb.o
 
 common-obj-$(CONFIG_TUSB6010) += tusb6010.o
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index e6a5a22..e1a29bf 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -25,11 +25,11 @@
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
 
-#include "hcd-xhci.h"
+#include "hcd-xhci-pci.h"
 
 static Property nec_xhci_properties[] = {
-    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIState, msi, ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIState, msix, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BIT("superspeed-ports-first",
                     XHCIState, flags, XHCI_FLAG_SS_FIRST, true),
     DEFINE_PROP_BIT("force-pcie-endcap", XHCIState, flags,
@@ -52,7 +52,7 @@ static void nec_xhci_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo nec_xhci_info = {
     .name          = TYPE_NEC_XHCI,
-    .parent        = TYPE_XHCI,
+    .parent        = TYPE_XHCI_PCI,
     .class_init    = nec_xhci_class_init,
 };
 
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index 26af683..fb51ddf 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -23,12 +23,192 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "hcd-xhci.h"
+#include "hcd-xhci-pci.h"
 #include "trace.h"
 #include "qapi/error.h"
 
+#define OFF_MSIX_TABLE  0x3000
+#define OFF_MSIX_PBA    0x3800
+
+static void xhci_pci_intr_update(void *opaque, int n, bool enable)
+{
+    XHCIPciState *s = XHCI_PCI(opaque);
+    PCIDevice *pci_dev = PCI_DEVICE(opaque);
+
+    if (!msix_enabled(pci_dev)) {
+        return;
+    }
+    if (enable == !!s->msix_used[n]) {
+        return;
+    }
+    if (enable) {
+        trace_usb_xhci_irq_msix_use(n);
+        msix_vector_use(pci_dev, n);
+        s->msix_used[n] = 1;
+    } else {
+        trace_usb_xhci_irq_msix_unuse(n);
+        msix_vector_unuse(pci_dev, n);
+        s->msix_used[n] = 0;
+    }
+}
+
+static void xhci_pci_intr_raise(void *opaque, int n, bool level)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(opaque);
+
+    if (n == 0 &&
+        !(msix_enabled(pci_dev) ||
+         msi_enabled(pci_dev))) {
+        pci_set_irq(pci_dev, level);
+    }
+    if (msix_enabled(pci_dev)) {
+        msix_notify(pci_dev, n);
+        return;
+    }
+
+    if (msi_enabled(pci_dev)) {
+        msi_notify(pci_dev, n);
+        return;
+    }
+}
+
+static void xhci_pci_reset(DeviceState *dev)
+{
+    XHCIPciState *s = XHCI_PCI(dev);
+
+    device_legacy_reset(DEVICE(s->xhci));
+}
+
+static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
+{
+    int ret;
+    Error *err = NULL;
+    XHCIPciState *s = XHCI_PCI(dev);
+    DeviceState *xhci_dev = DEVICE(s->xhci);
+
+    dev->config[PCI_CLASS_PROG] = 0x30;    /* xHCI */
+    dev->config[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin 1 */
+    dev->config[PCI_CACHE_LINE_SIZE] = 0x10;
+    dev->config[0x60] = 0x30; /* release number */
+
+    qdev_prop_set_bit(xhci_dev, "streams", s->enable_streams);
+    qdev_prop_set_uint32(xhci_dev, "p2", s->numports_2);
+    qdev_prop_set_uint32(xhci_dev, "p3", s->numports_3);
+    object_property_set_link(OBJECT(xhci_dev), OBJECT(s), "host", NULL);
+    qdev_init_nofail(xhci_dev);
+    s->xhci = XHCI(xhci_dev);
+    s->xhci->intr_update = xhci_pci_intr_update;
+    s->xhci->intr_raise = xhci_pci_intr_raise;
+
+    if (s->msi != ON_OFF_AUTO_OFF) {
+        ret = msi_init(dev, 0x70, s->xhci->numintrs, true, false, &err);
+        /*
+         * Any error other than -ENOTSUP(board's MSI support is broken)
+         * is a programming error
+         */
+        assert(!ret || ret == -ENOTSUP);
+        if (ret && s->msi == ON_OFF_AUTO_ON) {
+            /* Can't satisfy user's explicit msi=on request, fail */
+            error_append_hint(&err, "You have to use msi=auto (default) or "
+                    "msi=off with this machine type.\n");
+            error_propagate(errp, err);
+            return;
+        }
+        assert(!err || s->msi == ON_OFF_AUTO_AUTO);
+        /* With msi=auto, we fall back to MSI off silently */
+        error_free(err);
+    }
+    pci_register_bar(dev, 0,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64,
+                     &s->xhci->mem);
+
+    if (pci_bus_is_express(pci_get_bus(dev)) ||
+        xhci_get_flag(s->xhci, XHCI_FLAG_FORCE_PCIE_ENDCAP)) {
+        ret = pcie_endpoint_cap_init(dev, 0xa0);
+        assert(ret > 0);
+    }
+
+    if (s->msix != ON_OFF_AUTO_OFF) {
+        /* TODO check for errors, and should fail when msix=on */
+        msix_init(dev, s->xhci->numintrs,
+                  &s->xhci->mem, 0, OFF_MSIX_TABLE,
+                  &s->xhci->mem, 0, OFF_MSIX_PBA,
+                  0x90, NULL);
+    }
+    s->xhci->as = pci_get_address_space(dev);
+}
+
+static void usb_xhci_pci_exit(PCIDevice *dev)
+{
+    XHCIPciState *s = XHCI_PCI(dev);
+    /* destroy msix memory region */
+    if (dev->msix_table && dev->msix_pba
+        && dev->msix_entry_used) {
+        msix_uninit(dev, &s->xhci->mem, &s->xhci->mem);
+    }
+}
+
+static Property xhci_pci_properties[] = {
+    DEFINE_PROP_BOOL("streams", XHCIPciState, enable_streams, true),
+    DEFINE_PROP_UINT32("p2",    XHCIPciState, numports_2, 4),
+    DEFINE_PROP_UINT32("p3",    XHCIPciState, numports_3, 4),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription vmstate_xhci_pci = {
+    .name = "xhci-pci",
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj, XHCIPciState),
+        VMSTATE_MSIX(parent_obj, XHCIPciState),
+        VMSTATE_UINT8_ARRAY(msix_used, XHCIPciState, MAXINTRS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void xhci_instance_init(Object *obj)
+{
+    XHCIPciState *s = XHCI_PCI(obj);
+    /*
+     * QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
+     * line, therefore, no need to wait to realize like other devices
+     */
+    PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
+    s->xhci = XHCI(object_new(TYPE_XHCI));
+}
+
+static void xhci_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, xhci_pci_properties);
+    dc->reset   = xhci_pci_reset;
+    dc->vmsd    = &vmstate_xhci_pci;
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+    k->realize      = usb_xhci_pci_realize;
+    k->exit         = usb_xhci_pci_exit;
+    k->class_id     = PCI_CLASS_SERIAL_USB;
+}
+
+static const TypeInfo xhci_pci_info = {
+    .name          = TYPE_XHCI_PCI,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(XHCIPciState),
+    .class_init    = xhci_class_init,
+    .instance_init = xhci_instance_init,
+    .abstract      = true,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    },
+};
+
 static void qemu_xhci_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -40,10 +220,11 @@ static void qemu_xhci_class_init(ObjectClass *klass, void *data)
 
 static void qemu_xhci_instance_init(Object *obj)
 {
-    XHCIState *xhci = XHCI(obj);
+    XHCIPciState *s = XHCI_PCI(obj);
+    XHCIState *xhci = s->xhci;
 
-    xhci->msi      = ON_OFF_AUTO_OFF;
-    xhci->msix     = ON_OFF_AUTO_AUTO;
+    s->msi      = ON_OFF_AUTO_OFF;
+    s->msix     = ON_OFF_AUTO_AUTO;
     xhci->numintrs = MAXINTRS;
     xhci->numslots = MAXSLOTS;
     xhci_set_flag(xhci, XHCI_FLAG_SS_FIRST);
@@ -51,13 +232,14 @@ static void qemu_xhci_instance_init(Object *obj)
 
 static const TypeInfo qemu_xhci_info = {
     .name          = TYPE_QEMU_XHCI,
-    .parent        = TYPE_XHCI,
+    .parent        = TYPE_XHCI_PCI,
     .class_init    = qemu_xhci_class_init,
     .instance_init = qemu_xhci_instance_init,
 };
 
 static void xhci_register_types(void)
 {
+    type_register_static(&xhci_pci_info);
     type_register_static(&qemu_xhci_info);
 }
 
diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
new file mode 100644
index 0000000..da452a7
--- /dev/null
+++ b/hw/usb/hcd-xhci-pci.h
@@ -0,0 +1,47 @@
+/*
+ * USB xHCI controller emulation
+ *
+ * Copyright (c) 2011 Securiforest
+ * Date: 2011-05-11 ;  Author: Hector Martin <hector@marcansoft.com>
+ * Based on usb-ohci.c, emulates Renesas NEC USB 3.0
+ * Date: 2020-01-1; Author: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
+ * PCI hooks are moved from XHCIState to XHCIPciState
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
+
+#ifndef HW_USB_HCD_XHCI_PCI_H
+#define HW_USB_HCD_XHCI_PCI_H
+
+#include "hw/usb.h"
+#include "hcd-xhci.h"
+
+#define TYPE_XHCI_PCI "pci-xhci"
+#define XHCI_PCI(obj) \
+    OBJECT_CHECK(XHCIPciState, (obj), TYPE_XHCI_PCI)
+
+
+typedef struct XHCIPciState {
+    /*< private >*/
+    PCIDevice parent_obj;
+    /*< public >*/
+    XHCIState *xhci;
+    OnOffAuto msi;
+    OnOffAuto msix;
+    uint8_t msix_used[MAXINTRS];
+    bool enable_streams;
+    uint32_t numports_2, numports_3;
+} XHCIPciState;
+
+#endif
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index ba07ca2..1daac96 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -25,10 +25,7 @@
 #include "qemu/queue.h"
 #include "hw/usb.h"
 #include "migration/vmstate.h"
-#include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
-#include "hw/pci/msi.h"
-#include "hw/pci/msix.h"
 #include "trace.h"
 #include "qapi/error.h"
 
@@ -57,8 +54,6 @@
 #define OFF_OPER        LEN_CAP
 #define OFF_RUNTIME     0x1000
 #define OFF_DOORBELL    0x2000
-#define OFF_MSIX_TABLE  0x3000
-#define OFF_MSIX_PBA    0x3800
 /* must be power of 2 */
 #define LEN_REGS        0x4000
 
@@ -548,54 +543,25 @@ static XHCIPort *xhci_lookup_port(XHCIState *xhci, struct USBPort *uport)
     return &xhci->ports[index];
 }
 
-static void xhci_intx_update(XHCIState *xhci)
+static void xhci_intr_update(XHCIState *xhci, int v)
 {
-    PCIDevice *pci_dev = PCI_DEVICE(xhci);
     int level = 0;
 
-    if (msix_enabled(pci_dev) ||
-        msi_enabled(pci_dev)) {
-        return;
-    }
-
-    if (xhci->intr[0].iman & IMAN_IP &&
-        xhci->intr[0].iman & IMAN_IE &&
-        xhci->usbcmd & USBCMD_INTE) {
-        level = 1;
-    }
-
-    trace_usb_xhci_irq_intx(level);
-    pci_set_irq(pci_dev, level);
-}
-
-static void xhci_msix_update(XHCIState *xhci, int v)
-{
-    PCIDevice *pci_dev = PCI_DEVICE(xhci);
-    bool enabled;
-
-    if (!msix_enabled(pci_dev)) {
-        return;
-    }
-
-    enabled = xhci->intr[v].iman & IMAN_IE;
-    if (enabled == xhci->intr[v].msix_used) {
-        return;
+    if (v == 0) {
+        if (xhci->intr[0].iman & IMAN_IP &&
+            xhci->intr[0].iman & IMAN_IE &&
+            xhci->usbcmd & USBCMD_INTE) {
+            level = 1;
+        }
+        xhci->intr_raise(xhci->hostOpaque, 0, level);
     }
 
-    if (enabled) {
-        trace_usb_xhci_irq_msix_use(v);
-        msix_vector_use(pci_dev, v);
-        xhci->intr[v].msix_used = true;
-    } else {
-        trace_usb_xhci_irq_msix_unuse(v);
-        msix_vector_unuse(pci_dev, v);
-        xhci->intr[v].msix_used = false;
-    }
+    xhci->intr_update(xhci->hostOpaque, v,
+                     xhci->intr[v].iman & IMAN_IE);
 }
 
 static void xhci_intr_raise(XHCIState *xhci, int v)
 {
-    PCIDevice *pci_dev = PCI_DEVICE(xhci);
     bool pending = (xhci->intr[v].erdp_low & ERDP_EHB);
 
     xhci->intr[v].erdp_low |= ERDP_EHB;
@@ -613,22 +579,7 @@ static void xhci_intr_raise(XHCIState *xhci, int v)
         return;
     }
 
-    if (msix_enabled(pci_dev)) {
-        trace_usb_xhci_irq_msix(v);
-        msix_notify(pci_dev, v);
-        return;
-    }
-
-    if (msi_enabled(pci_dev)) {
-        trace_usb_xhci_irq_msi(v);
-        msi_notify(pci_dev, v);
-        return;
-    }
-
-    if (v == 0) {
-        trace_usb_xhci_irq_intx(1);
-        pci_irq_assert(pci_dev);
-    }
+    xhci->intr_raise(xhci->hostOpaque, v, true);
 }
 
 static inline int xhci_running(XHCIState *xhci)
@@ -2715,7 +2666,6 @@ static void xhci_reset(DeviceState *dev)
         xhci->intr[i].erstba_high = 0;
         xhci->intr[i].erdp_low = 0;
         xhci->intr[i].erdp_high = 0;
-        xhci->intr[i].msix_used = 0;
 
         xhci->intr[i].er_ep_idx = 0;
         xhci->intr[i].er_pcs = 1;
@@ -2962,13 +2912,13 @@ static void xhci_oper_write(void *ptr, hwaddr reg,
         if (val & USBCMD_HCRST) {
             xhci_reset(d);
         }
-        xhci_intx_update(xhci);
+        xhci_intr_update(xhci, 0);
         break;
 
     case 0x04: /* USBSTS */
         /* these bits are write-1-to-clear */
         xhci->usbsts &= ~(val & (USBSTS_HSE|USBSTS_EINT|USBSTS_PCD|USBSTS_SRE));
-        xhci_intx_update(xhci);
+        xhci_intr_update(xhci, 0);
         break;
 
     case 0x14: /* DNCTRL */
@@ -3071,10 +3021,7 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
         }
         intr->iman &= ~IMAN_IE;
         intr->iman |= val & IMAN_IE;
-        if (v == 0) {
-            xhci_intx_update(xhci);
-        }
-        xhci_msix_update(xhci, v);
+        xhci_intr_update(xhci, v);
         break;
     case 0x04: /* IMOD */
         intr->imod = val;
@@ -3319,7 +3266,6 @@ static USBBusOps xhci_bus_ops = {
 
 static void usb_xhci_init(XHCIState *xhci)
 {
-    DeviceState *dev = DEVICE(xhci);
     XHCIPort *port;
     unsigned int i, usbports, speedmask;
 
@@ -3334,7 +3280,7 @@ static void usb_xhci_init(XHCIState *xhci)
     usbports = MAX(xhci->numports_2, xhci->numports_3);
     xhci->numports = xhci->numports_2 + xhci->numports_3;
 
-    usb_bus_new(&xhci->bus, sizeof(xhci->bus), &xhci_bus_ops, dev);
+    usb_bus_new(&xhci->bus, sizeof(xhci->bus), &xhci_bus_ops, xhci->hostOpaque);
 
     for (i = 0; i < usbports; i++) {
         speedmask = 0;
@@ -3374,18 +3320,12 @@ static void usb_xhci_init(XHCIState *xhci)
     }
 }
 
-static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
+static void usb_xhci_realize(DeviceState *dev, Error **errp)
 {
-    int i, ret;
-    Error *err = NULL;
+    int i;
 
     XHCIState *xhci = XHCI(dev);
 
-    dev->config[PCI_CLASS_PROG] = 0x30;    /* xHCI */
-    dev->config[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin 1 */
-    dev->config[PCI_CACHE_LINE_SIZE] = 0x10;
-    dev->config[0x60] = 0x30; /* release number */
-
     if (strcmp(object_get_typename(OBJECT(dev)), TYPE_NEC_XHCI) == 0) {
         xhci->nec_quirks = true;
     }
@@ -3410,23 +3350,6 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
         xhci->max_pstreams_mask = 0;
     }
 
-    if (xhci->msi != ON_OFF_AUTO_OFF) {
-        ret = msi_init(dev, 0x70, xhci->numintrs, true, false, &err);
-        /* Any error other than -ENOTSUP(board's MSI support is broken)
-         * is a programming error */
-        assert(!ret || ret == -ENOTSUP);
-        if (ret && xhci->msi == ON_OFF_AUTO_ON) {
-            /* Can't satisfy user's explicit msi=on request, fail */
-            error_append_hint(&err, "You have to use msi=auto (default) or "
-                    "msi=off with this machine type.\n");
-            error_propagate(errp, err);
-            return;
-        }
-        assert(!err || xhci->msi == ON_OFF_AUTO_AUTO);
-        /* With msi=auto, we fall back to MSI off silently */
-        error_free(err);
-    }
-
     usb_xhci_init(xhci);
     xhci->mfwrap_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, xhci_mfwrap_timer, xhci);
 
@@ -3453,27 +3376,9 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
                               port->name, 0x10);
         memory_region_add_subregion(&xhci->mem, offset, &port->mem);
     }
-
-    pci_register_bar(dev, 0,
-                     PCI_BASE_ADDRESS_SPACE_MEMORY|PCI_BASE_ADDRESS_MEM_TYPE_64,
-                     &xhci->mem);
-
-    if (pci_bus_is_express(pci_get_bus(dev)) ||
-        xhci_get_flag(xhci, XHCI_FLAG_FORCE_PCIE_ENDCAP)) {
-        ret = pcie_endpoint_cap_init(dev, 0xa0);
-        assert(ret > 0);
-    }
-
-    if (xhci->msix != ON_OFF_AUTO_OFF) {
-        /* TODO check for errors, and should fail when msix=on */
-        msix_init(dev, xhci->numintrs,
-                  &xhci->mem, 0, OFF_MSIX_TABLE,
-                  &xhci->mem, 0, OFF_MSIX_PBA,
-                  0x90, NULL);
-    }
 }
 
-static void usb_xhci_exit(PCIDevice *dev)
+static void usb_xhci_unrealize(DeviceState *dev, Error **errp)
 {
     int i;
     XHCIState *xhci = XHCI(dev);
@@ -3500,19 +3405,12 @@ static void usb_xhci_exit(PCIDevice *dev)
         memory_region_del_subregion(&xhci->mem, &port->mem);
     }
 
-    /* destroy msix memory region */
-    if (dev->msix_table && dev->msix_pba
-        && dev->msix_entry_used) {
-        msix_uninit(dev, &xhci->mem, &xhci->mem);
-    }
-
     usb_bus_release(&xhci->bus);
 }
 
 static int usb_xhci_post_load(void *opaque, int version_id)
 {
     XHCIState *xhci = opaque;
-    PCIDevice *pci_dev = PCI_DEVICE(xhci);
     XHCISlot *slot;
     XHCIEPContext *epctx;
     dma_addr_t dcbaap, pctx;
@@ -3558,11 +3456,7 @@ static int usb_xhci_post_load(void *opaque, int version_id)
     }
 
     for (intr = 0; intr < xhci->numintrs; intr++) {
-        if (xhci->intr[intr].msix_used) {
-            msix_vector_use(pci_dev, intr);
-        } else {
-            msix_vector_unuse(pci_dev, intr);
-        }
+        xhci_intr_update(xhci, intr);
     }
 
     return 0;
@@ -3631,7 +3525,6 @@ static const VMStateDescription vmstate_xhci_intr = {
         VMSTATE_UINT32(erdp_high,     XHCIInterrupter),
 
         /* state */
-        VMSTATE_BOOL(msix_used,       XHCIInterrupter),
         VMSTATE_BOOL(er_pcs,          XHCIInterrupter),
         VMSTATE_UINT64(er_start,      XHCIInterrupter),
         VMSTATE_UINT32(er_size,       XHCIInterrupter),
@@ -3654,9 +3547,6 @@ static const VMStateDescription vmstate_xhci = {
     .version_id = 1,
     .post_load = usb_xhci_post_load,
     .fields = (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(parent_obj, XHCIState),
-        VMSTATE_MSIX(parent_obj, XHCIState),
-
         VMSTATE_STRUCT_VARRAY_UINT32(ports, XHCIState, numports, 1,
                                      vmstate_xhci_port, XHCIPort),
         VMSTATE_STRUCT_VARRAY_UINT32(slots, XHCIState, numslots, 1,
@@ -3688,34 +3578,27 @@ static Property xhci_properties[] = {
                     XHCI_FLAG_ENABLE_STREAMS, true),
     DEFINE_PROP_UINT32("p2",    XHCIState, numports_2, 4),
     DEFINE_PROP_UINT32("p3",    XHCIState, numports_3, 4),
+    DEFINE_PROP_LINK("host",    XHCIState, hostOpaque, TYPE_DEVICE,
+                     DeviceState *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xhci_class_init(ObjectClass *klass, void *data)
 {
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->realize = usb_xhci_realize;
+    dc->unrealize = usb_xhci_unrealize;
+    dc->reset   = xhci_reset;
     dc->vmsd    = &vmstate_xhci;
     device_class_set_props(dc, xhci_properties);
-    dc->reset   = xhci_reset;
-    set_bit(DEVICE_CATEGORY_USB, dc->categories);
-    k->realize      = usb_xhci_realize;
-    k->exit         = usb_xhci_exit;
-    k->class_id     = PCI_CLASS_SERIAL_USB;
 }
 
 static const TypeInfo xhci_info = {
     .name          = TYPE_XHCI,
-    .parent        = TYPE_PCI_DEVICE,
+    .parent        = TYPE_DEVICE,
     .instance_size = sizeof(XHCIState),
     .class_init    = xhci_class_init,
-    .abstract      = true,
-    .interfaces = (InterfaceInfo[]) {
-        { INTERFACE_PCIE_DEVICE },
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { }
-    },
 };
 
 static void xhci_register_types(void)
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index ca03481..371100a 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -170,7 +170,7 @@ typedef struct XHCIInterrupter {
     uint32_t erdp_low;
     uint32_t erdp_high;
 
-    bool msix_used, er_pcs;
+    bool er_pcs;
 
     dma_addr_t er_start;
     uint32_t er_size;
@@ -185,10 +185,7 @@ typedef struct XHCIInterrupter {
 } XHCIInterrupter;
 
 struct XHCIState {
-    /*< private >*/
-    PCIDevice parent_obj;
-    /*< public >*/
-
+    DeviceState parent;
     USBBus bus;
     MemoryRegion mem;
     AddressSpace *as;
@@ -204,8 +201,9 @@ struct XHCIState {
     uint32_t numslots;
     uint32_t flags;
     uint32_t max_pstreams_mask;
-    OnOffAuto msi;
-    OnOffAuto msix;
+    void (*intr_update)(void *opaque, int n, bool enable);
+    void (*intr_raise)(void *opaque, int n, bool level);
+    DeviceState *hostOpaque;
 
     /* Operational Registers */
     uint32_t usbcmd;
-- 
2.7.4


