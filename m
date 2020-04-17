Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38182C3815B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8672220A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qc82EyI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8672220A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPVp8-0005Qw-74
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 14:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fnuv@xilinx.com>) id 1jPVkz-0001Nb-4T
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fnuv@xilinx.com>) id 1jPVkx-0002LC-OW
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:30:29 -0400
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com
 ([40.107.236.71]:14706 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fnuv@xilinx.com>)
 id 1jPVkx-0002JK-Hh; Fri, 17 Apr 2020 14:30:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUlBLG2bQsVlHecWRZRmtlAxRi986eUgIxP+LRJ/qqLlapeyliKQ2zsydHTVj5U823waQu23HdYQFCc5OYv8nLraGYo+qF4fy2ahgEI9NXqusAxvyCE2SRA3XbR5PtP/qJAf8H+3ahJpLl8+p7AyBGBNKBD10yShAZDlFt73vAPvIggRLt7tB6zVZYG2vs1zJN569oiKU5dx6cCpKGz4zE4Qoisn6DPGQcE7OAOoVcJW3VsscFCBFqtZu687W7paBWIVqrWlRPw2peOrEep3VEJApgLXlf+tVWrTNzYjqeE5fajqxvtM6dVLmI1XK4QBztZy7h44pr6r0iIpTYbIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG7IgnCg9nxH5mrMyGedUHEr1BMqvwjOwlyz+Txeo7M=;
 b=BR/iB5EGFuaFwprr4oZyQVQPIjwXfZXCP7rCUASNH5ZKDYqLKPG7wlNe5xS1mAFMBCR4ipgGMRc7Nv3dRSZLdpBANx+rLUKkus9Mmb4PtOm/y1cGHH/0H3oKYTjgymwcCLCw+vnVofddVbNWRsxGLnKIcjssHTp1Wqwinmsirn0FZswAllxTHKb1HdR35FX5WYm3e7RSxJ2HTN7zRXs6y3yT4BGjvjpgOkovH8xewfWHdG3/wxYC1PGNo1PgX/HSuGNOrNZ6EVqXV+mzezzM4I+jLBTkvKx2NZVn/PByeB/q2bQhMNP6cUeMqIm5c7jxER2H/UyMfJlZwC7pkPfRfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG7IgnCg9nxH5mrMyGedUHEr1BMqvwjOwlyz+Txeo7M=;
 b=qc82EyI8LDnwih984EuBCAlYIDk0lXqNkLTL3dSDJIR9HR7ZpUBp51CbLdkcYNnLCn+Ew3Z09pFEbMS9zBtK5S0CH+IYjZXcjRR+o44lEUXx+7HmA+zmjiav8pnQHDqmA0acmCZ/XRdvWmhfsLqRErPzV5lgU2GiBlho72TBkP4=
Received: from SN4PR0701CA0034.namprd07.prod.outlook.com
 (2603:10b6:803:2d::15) by BYAPR02MB4774.namprd02.prod.outlook.com
 (2603:10b6:a03:4d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Fri, 17 Apr
 2020 18:30:25 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2d:cafe::88) by SN4PR0701CA0034.outlook.office365.com
 (2603:10b6:803:2d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend
 Transport; Fri, 17 Apr 2020 18:30:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 18:30:24
 +0000
Received: from [149.199.38.66] (port=36434 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jPVk6-0007KG-HV; Fri, 17 Apr 2020 11:29:34 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jPVku-0006MZ-A1; Fri, 17 Apr 2020 11:30:24 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jPVks-00055H-Qy; Fri, 17 Apr 2020 11:30:22 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [[PATCH v2 3/4] hw/net/can: Connect Xlnx ZynqMP CAN controller to
 ZCU102 machine
Date: Fri, 17 Apr 2020 11:29:28 -0700
Message-Id: <1587148169-173268-4-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587148169-173268-1-git-send-email-fnu.vikram@xilinx.com>
References: <1587148169-173268-1-git-send-email-fnu.vikram@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966005)(2906002)(82740400003)(70586007)(7696005)(2616005)(26005)(70206006)(47076004)(36756003)(478600001)(356005)(8936002)(81156014)(5660300002)(186003)(54906003)(426003)(6916009)(4326008)(316002)(81166007)(336012)(9786002)(8676002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faba8f8e-f8b9-4202-7481-08d7e2fd650d
X-MS-TrafficTypeDiagnostic: BYAPR02MB4774:
X-Microsoft-Antispam-PRVS: <BYAPR02MB47748CE39F6DA2872A9AFD7BBCD90@BYAPR02MB4774.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:94;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qw+Wm+RpMQlM66+XFftPRmLWlFztnNmsLbxRtzagUF1TtaI+dEj2IDw3KU7m505a8qV+jOi4uZX6Cdb3uaNJzWtJMZP4PDU90ZXmzbSKs6FPkehKfkNyvQJeTfmYrmSg8lGQYX/hmQdY8IKOh5hV0hiPVRO2BRE+FCi64rnki+tlpxAdGXKmW1usKaGpXszZ8Khw2HjNzKYU/tMbn9uItRjLWxv1cGKzNbzUNICWh1Xu/xQv/iYX3M3zKg2oGfhtak3q1/4Xw40+vL1qoLsWQ71b62RDnHB7imhRcL2J+MBwkxp9TB9CGBuPemg7j22A7rRiNmhMeMRE7e3QHAh69LHA7K9pqhx5i9mYxuWemq2kqn2LjiZlvbTpWlE/+5sqGMYhu4mzsr3zzbKaKc5jO950mmPcXLuev04ci6zsFYLrNBSdS5jWyDYg/68lrt21P8UqwdXuEU/vL/Gl9dK8FgayXW/LFG3bPaK6Z2Yb555JE5w+DEdkrOL3weO1Ds+ePXrLBRYocCxfMmRaHZaLGQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 18:30:24.6108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faba8f8e-f8b9-4202-7481-08d7e2fd650d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4774
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.236.71
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
 Vikram Garhwal <fnu.vikram@xilinx.com>, jasowang@redhat.com,
 Alistair Francis <alistair@alistair23.me>, francisco.iglesias@xilinx.com,
 "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
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


