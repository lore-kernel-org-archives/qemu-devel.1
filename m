Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CC9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C542076E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dzQxNu2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C542076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joXfZ-0003Sj-5v
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 15:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>)
 id 1joXdk-0001e0-RX; Thu, 25 Jun 2020 15:34:28 -0400
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com
 ([40.107.237.85]:44224 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>)
 id 1joXdj-0001hz-2v; Thu, 25 Jun 2020 15:34:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPe0QlILDDz+TAUNQoxR7f/3VIX52iR8j27/YULeSN66SAg1oxXagBRsLvWlo2aXrB0BfdcZZoefocfDe5RU+k7EZwGAx+zBYtEU/dhqDW3OI88yfy4CcdRG82BdWuWooJqxoCoKJZS0f3K4ltfVE+IqDl/B+s3ojd0XBhbKEC4kbk/wJNbWEzv7EMj21vrBOEMt9ai6ZJwlYrGEKdTLP00VelOL9tEeTraTwFtITVoOMV8FJkNIwOYyYrD7pIoOSIcsdG1gAdueS6cxTt+VTaY6PCFK1xDSQSrlk9nfuCsBCahf1olDeR2VLYYnVoB+bEFtYuj06gb2GqG9fhUT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvig51a4LYz3oMwFOpZ4woMkOY7nfJcxGmpdVWKtl8o=;
 b=XcJLpsqF0LWcmlw/GXNR8rSgfK3AlGEn7RdKOzdS39Kc9aO5XJK1UQdabd2SA3Zz2o4OJS9hbWSW5aVR2yBYLWyA7HxPOhKahqvpE/5i+F50QrFacvvc1CIJVPEY4NsPpkY9gvowidPB3REMXkOQSwhOaca216X6HpgAXb21G7j2c9jYJ0mN3YIeVqeyqqDC6khhrHA7VY+a9C74hVIkpGJeis3yP0QvSEqVGUH2ZZsMSuQtCfwku69uMjbSPxzxkFw1VloxG8tRJ7C3ZToJEQmy7ESCa75xLGt8WvgQi33rOXH58NgxG2P2KvwekE4V/0BZ+PkSh0QMIhihlJZURQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvig51a4LYz3oMwFOpZ4woMkOY7nfJcxGmpdVWKtl8o=;
 b=dzQxNu2CJsEWd5itoWElQqVpotyRSOLYPg066R37Own8j8nfnDJYcy5iy+zMgnmlT8gsasS5iMZvvJOUMaYiKEyG2Lm7TUIadexUaCPlAA9muLbTE90Lt2l9VdJ3L2/EzEzpeX4+hNSU7tAYwdwkCm+DzwBhGUPBDW89zjxk2VI=
Received: from CY4PR19CA0030.namprd19.prod.outlook.com (2603:10b6:903:103::16)
 by CH2PR02MB6490.namprd02.prod.outlook.com (2603:10b6:610:34::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 25 Jun
 2020 19:34:24 +0000
Received: from CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:103:cafe::ed) by CY4PR19CA0030.outlook.office365.com
 (2603:10b6:903:103::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Thu, 25 Jun 2020 19:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT020.mail.protection.outlook.com (10.152.75.191) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Thu, 25 Jun 2020 19:34:24
 +0000
Received: from [149.199.38.66] (port=51144 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1joXcS-00081M-97; Thu, 25 Jun 2020 12:33:08 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1joXdf-000331-Th; Thu, 25 Jun 2020 12:34:23 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05PJYILa005066; 
 Thu, 25 Jun 2020 12:34:18 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1joXda-0002vc-Ct; Thu, 25 Jun 2020 12:34:18 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 2/4] xlnx-zynqmp: Connect Xilinx ZynqMP CAN controllers
Date: Thu, 25 Jun 2020 12:33:25 -0700
Message-Id: <1593113607-321118-3-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593113607-321118-1-git-send-email-fnu.vikram@xilinx.com>
References: <1593113607-321118-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(39860400002)(136003)(376002)(346002)(46966005)(478600001)(47076004)(4326008)(82740400003)(7696005)(6666004)(70206006)(316002)(70586007)(2906002)(81166007)(336012)(54906003)(5660300002)(2616005)(426003)(186003)(9786002)(36756003)(8676002)(8936002)(356005)(6916009)(82310400002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5d5e8a6c-2f78-4194-1347-08d8193ec41a
X-MS-TrafficTypeDiagnostic: CH2PR02MB6490:
X-Microsoft-Antispam-PRVS: <CH2PR02MB649037D3B2CEA7CE1922A374BC920@CH2PR02MB6490.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:151;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERerFaUafjOyLev5JTrIHt+fMQUwo+3wGapbLbRnm478+x/uWv7DsEMFfkZb+MtpIO9dGwqrn7Ke3yTNBU4KrlVLjmXR+Iys1g8qaz+RpLb8uQFVwG1KuMnEchQRwqXsodiAziWJ90h8UFc2lSX2PZIbdtdMxOZ2W3gNOtKUooR31V5MnwJD0l4CH1nyuPkI6kdDoliUHq8e9BWudATwE2NqoOnAWwFwqF5LYEPV9wBCRj843Lxpuo3VWNwRjA3a9R9K92mfZ4WjGr1rRr8rs65+mtKYHcYS09XIrrVbfLPH58s7ivVptctnsxQpYsyJ2YCmNKs6kmqZuZ9/DmCX6PR421aEyR3qZWLO3GrjG2SlhmRaXuhmO/b4kCmnBmXArNvCkRFJ+TO94+VaXemxJw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 19:34:24.1555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5e8a6c-2f78-4194-1347-08d8193ec41a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6490
Received-SPF: pass client-ip=40.107.237.85; envelope-from=fnuv@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 15:34:25
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vikram Garhwal <fnu.vikram@xilinx.com>,
 Alistair Francis <alistair@alistair23.me>, francisco.iglesias@xilinx.com,
 "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Connect CAN0 and CAN1 on the ZynqMP.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
---
 hw/arm/xlnx-zynqmp.c         | 28 ++++++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 1de9d4a..3f93524 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -81,6 +81,14 @@ static const int uart_intr[XLNX_ZYNQMP_NUM_UARTS] = {
     21, 22,
 };
 
+static const uint64_t can_addr[XLNX_ZYNQMP_NUM_CAN] = {
+    0xFF060000, 0xFF070000,
+};
+
+static const int can_intr[XLNX_ZYNQMP_NUM_CAN] = {
+    23, 24,
+};
+
 static const uint64_t sdhci_addr[XLNX_ZYNQMP_NUM_SDHCI] = {
     0xFF160000, 0xFF170000,
 };
@@ -247,6 +255,11 @@ static void xlnx_zynqmp_init(Object *obj)
                                 TYPE_CADENCE_UART);
     }
 
+    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
+        object_initialize_child(obj, "can[*]", &s->can[i],
+                              TYPE_XLNX_ZYNQMP_CAN);
+    }
+
     object_initialize_child(obj, "sata", &s->sata, TYPE_SYSBUS_AHCI);
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
@@ -492,6 +505,21 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                            gic_spi[uart_intr[i]]);
     }
 
+    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
+        object_property_set_int(OBJECT(&s->can[i]), i, "ctrl-idx",
+                                &error_abort);
+        object_property_set_int(OBJECT(&s->can[i]), XLNX_ZYNQMP_CAN_REF_CLK,
+                                "ext_clk_freq", &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->can[i]), &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->can[i]), 0, can_addr[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->can[i]), 0,
+                           gic_spi[can_intr[i]]);
+    }
+
     object_property_set_int(OBJECT(&s->sata), SATA_NUM_PORTS, "num-ports",
                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->sata), &err);
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 53076fa..dcb88e0 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -22,6 +22,7 @@
 #include "hw/intc/arm_gic.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/char/cadence_uart.h"
+#include "hw/net/xlnx-zynqmp-can.h"
 #include "hw/ide/ahci.h"
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/xilinx_spips.h"
@@ -41,6 +42,8 @@
 #define XLNX_ZYNQMP_NUM_RPU_CPUS 2
 #define XLNX_ZYNQMP_NUM_GEMS 4
 #define XLNX_ZYNQMP_NUM_UARTS 2
+#define XLNX_ZYNQMP_NUM_CAN 2
+#define XLNX_ZYNQMP_CAN_REF_CLK (24 * 1000 * 1000)
 #define XLNX_ZYNQMP_NUM_SDHCI 2
 #define XLNX_ZYNQMP_NUM_SPIS 2
 #define XLNX_ZYNQMP_NUM_GDMA_CH 8
@@ -92,6 +95,7 @@ typedef struct XlnxZynqMPState {
 
     CadenceGEMState gem[XLNX_ZYNQMP_NUM_GEMS];
     CadenceUARTState uart[XLNX_ZYNQMP_NUM_UARTS];
+    XlnxZynqMPCANState can[XLNX_ZYNQMP_NUM_CAN];
     SysbusAHCIState sata;
     SDHCIState sdhci[XLNX_ZYNQMP_NUM_SDHCI];
     XilinxSPIPS spi[XLNX_ZYNQMP_NUM_SPIS];
-- 
2.7.4


