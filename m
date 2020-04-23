Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04443C55186
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 01:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FE820776
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 01:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HyeqcuW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FE820776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRQFU-0002D9-Vi
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 21:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fnuv@xilinx.com>) id 1jRQAz-0006uO-7n
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 20:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <fnuv@xilinx.com>) id 1jRQAx-0002PL-1t
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 20:57:12 -0400
Received: from mail-dm6nam12on2069.outbound.protection.outlook.com
 ([40.107.243.69]:6085 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>)
 id 1jRQAd-0000a0-NF; Wed, 22 Apr 2020 20:56:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UatLatyX/YCenu18wOXGEwsW/oqWo9QG/lT1zgzbNOCejWSxrrOlwCF1RdoaUkVOUQRM408r/7VKqHSmRjxyRpxYx3Fj3SKjgwTTcw64dYgN4uNEd3Isao418yOtFelqIWIA5DgY4NfOvN93AAnOXrfLIO4/UpqmBI7ODKhlSS2NU4BqIu/CnOqLY0eSC7OVy8IylLVTFDxBlyDOsMg6zVtvOM6Yz/QTIqxQ+nnFZ1cvMKVRDAMRJExHmMj+IqdDMyIf8g+HyJDvlOAwnthqJZqDBTUX5nSSzUxfNLIVlUHXEGN5hUvjWFI3rQLQXLIr0P3wU8QVaukW5BohbXISxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG7IgnCg9nxH5mrMyGedUHEr1BMqvwjOwlyz+Txeo7M=;
 b=FgFoTRXPIxGao1e/1HalshdNdWueUbHk3antcUqR7BSROjyhLSlWHBbNAFcrMzF4dG5q5jM3auwtIruc/MzH9I+mEc/FaTr+Jn8nHR7oXUqzWtMViw7ZZibBMmirQCDJMBkWA64j+FCRUcvzIjSiWGGWc8A/aVjrgh7wqopHXp557Vp46flo+YKlYYUdHo2VuGfJtzOGHGVjY6Sz/TthCivfaKsxxz8FkH3Cnu/clR0Vire0PPnMDoRc+gRI0frTlk9lgzIwR4g8KLfFOGOJsiklTEv+KdNYODkze2qtiy6Zn14PvSpPHxEwjOZDpJtd3MRv3688v6l9kltYjW4CSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG7IgnCg9nxH5mrMyGedUHEr1BMqvwjOwlyz+Txeo7M=;
 b=HyeqcuW8uvD2EYtAh/dI9p4FvXqwHyE1kuCwCDysFZLF3qzVYTh0TOZdvuXoXDmk48Av9fPRcrjN1Sq5sjpK2bXKFrWhe6NiiwImv8yN9lksrhOQqENX6l5v+ov+/TkEWsRHoexZL2z7Bx58z6oC6oVz2yAPBgY/1J15rD7tCHg=
Received: from BL0PR1501CA0029.namprd15.prod.outlook.com
 (2603:10b6:207:17::42) by MN2PR02MB6830.namprd02.prod.outlook.com
 (2603:10b6:208:1d4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 00:56:48 +0000
Received: from BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:17:cafe::f3) by BL0PR1501CA0029.outlook.office365.com
 (2603:10b6:207:17::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 00:56:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT061.mail.protection.outlook.com (10.152.77.7) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Thu, 23 Apr 2020 00:56:47
 +0000
Received: from [149.199.38.66] (port=51906 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jRQ9V-0004JW-HR; Wed, 22 Apr 2020 17:55:41 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jRQAZ-0007tD-0F; Wed, 22 Apr 2020 17:56:47 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03N0ubnr013661; 
 Wed, 22 Apr 2020 17:56:38 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jRQAP-0007oW-P8; Wed, 22 Apr 2020 17:56:37 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] xlnx-zynqmp: Connect Xilinx ZynqMP CAN controller
Date: Wed, 22 Apr 2020 17:56:07 -0700
Message-Id: <1587603369-14644-3-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587603369-14644-1-git-send-email-fnu.vikram@xilinx.com>
References: <1587603369-14644-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966005)(54906003)(82740400003)(2616005)(6916009)(47076004)(316002)(81166007)(8936002)(9786002)(81156014)(8676002)(6666004)(356005)(5660300002)(478600001)(7696005)(26005)(70206006)(426003)(70586007)(336012)(4326008)(2906002)(186003)(36756003)(82310400002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c1fff35-1fff-4a9f-2e86-08d7e721334a
X-MS-TrafficTypeDiagnostic: MN2PR02MB6830:
X-Microsoft-Antispam-PRVS: <MN2PR02MB68304536519884D9C6CE58A8BCD30@MN2PR02MB6830.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:94;
X-Forefront-PRVS: 03827AF76E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sc+PQOE+g9WXoX7izPQLGbmARs4LEa8k/EN7gabTobiXeoM7hmdhTCEo3aZK+WHtx/COurcTuw8If3rmD1+jFKdPmWlledsEjNbSfW9Ifgq8Akg+FFRdKP1nAmG5evub+bEGHIjNiNjCUaUielYQ1ZvkSc+opGQb9tDNmsdM6qp66UMekkm37/ZsAspw4SYfz9Emn27jRVxlbWgXuj3F7jKzUIqgdPHM7gfY2BNjxeWBodzSMzjpzLJzrQ7PjAkj9gkfHOe5ZXN6u+6bYhIh0M6aqN6ZhAs1dpYgRimt+rBb9pfQ09O8fprDyjZwai+pGZ7E6RJuNp9OcrtITeMeMRFPpFYifqceyl2Hec8xY54+QznPFnlvYtY3W1X6Kuq8MdGGdJdZSBxEemYBt/xYs+bX+hJUkjXcPZBtCljqRzQaXD5rNPlN5MQJ3J0sqJLtM7JNiqtiKRgiN7maTSjxUpjnWJ0Q5xX3rU9FlqTv1img5FydPrsBGY1WMyZvf1raKhUC0OOtdeozC5woFKTSKg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 00:56:47.6571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1fff35-1fff-4a9f-2e86-08d7e721334a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6830
Received-SPF: pass client-ip=40.107.243.69; envelope-from=fnuv@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 20:56:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.243.69
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Vikram Garhwal <fnu.vikram@xilinx.com>,
 "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Connect CAN0 and CAN1 to ZCU102 board.

Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
---
 hw/arm/xlnx-zynqmp.c         | 26 ++++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index b84d153..e5f0d9f 100644
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
@@ -254,6 +262,11 @@ static void xlnx_zynqmp_init(Object *obj)
                               TYPE_CADENCE_UART);
     }
 
+    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
+        sysbus_init_child_obj(obj, "can[*]", &s->can[i], sizeof(s->can[i]),
+                              TYPE_XLNX_ZYNQMP_CAN);
+    }
+
     sysbus_init_child_obj(obj, "sata", &s->sata, sizeof(s->sata),
                           TYPE_SYSBUS_AHCI);
 
@@ -508,6 +521,19 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                            gic_spi[uart_intr[i]]);
     }
 
+    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
+        object_property_set_int(OBJECT(&s->can[i]), i, "ctrl-idx",
+                                &error_abort);
+        object_property_set_bool(OBJECT(&s->can[i]), true, "realized", &err);
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
     object_property_set_bool(OBJECT(&s->sata), true, "realized", &err);
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 53076fa..2be0ff9 100644
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
@@ -41,6 +42,7 @@
 #define XLNX_ZYNQMP_NUM_RPU_CPUS 2
 #define XLNX_ZYNQMP_NUM_GEMS 4
 #define XLNX_ZYNQMP_NUM_UARTS 2
+#define XLNX_ZYNQMP_NUM_CAN 2
 #define XLNX_ZYNQMP_NUM_SDHCI 2
 #define XLNX_ZYNQMP_NUM_SPIS 2
 #define XLNX_ZYNQMP_NUM_GDMA_CH 8
@@ -92,6 +94,7 @@ typedef struct XlnxZynqMPState {
 
     CadenceGEMState gem[XLNX_ZYNQMP_NUM_GEMS];
     CadenceUARTState uart[XLNX_ZYNQMP_NUM_UARTS];
+    XlnxZynqMPCANState    can[XLNX_ZYNQMP_NUM_CAN];
     SysbusAHCIState sata;
     SDHCIState sdhci[XLNX_ZYNQMP_NUM_SDHCI];
     XilinxSPIPS spi[XLNX_ZYNQMP_NUM_SPIS];
-- 
2.7.4


