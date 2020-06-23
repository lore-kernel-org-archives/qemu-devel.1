Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F11C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E2D208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RH5TdeOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E2D208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnsIN-0008NW-Fv
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 19:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>)
 id 1jnsH9-0006ha-HE; Tue, 23 Jun 2020 19:24:23 -0400
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com
 ([40.107.94.84]:13313 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>)
 id 1jnsH6-0004bX-Ja; Tue, 23 Jun 2020 19:24:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeg6RNaR64Fdjyt7RY5okinMXbsm3/ZigKQYQVF9C0yHsIl2CO/cOf+CLrH5v1cKM56W3qVBluo5bYykPv+kDDboF3b5OhG+W7jzkkB++y5mpGB/DkL4l2bPvs9mTfNxkPhD+/8iHBsOv+VtGerMmOqBQY/lZ5DCl6lj0msPdaSazO0+Rka0dfcIvJ/YbfYfUhtztmCPozPR57isaMU9ofrPRMFsHSnQ/iHHsghATf+bDcSoVHRbckusROBT0QliL9ENOJzh/CCR7L3VrvC4Se32cR6V0r5AjWLA3/LBjB6y2Klg9JEcLkrBgW1PnpjTM46LjIXXFBZtSfTunGKvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tyy2fzdpbnxKkaObTSj+ipq5w1hr60XubfVisBskKNg=;
 b=D1rVq6/9pqZNEoapPceJARqxjm6Goph2pL8+bU3E2cTwA9fO4ItibYZHkJdq9lWtJG96IarIDWBZ8fEj/Sthb9PoSwKctOpJnwqMzv0kiouV38+gVOPVKJu1I2OouGYADFDZ8a+pxTY1v5/+m23cQm7fTdZhvM5asVLtG5bWBj2scoVZGiiv4Q9qTe0qmgNpGWO02pMBDsOgiifjMl8t0qEgPsIyHRfV+1h9GreVLZaE81R1wqXFH9b1/G4bYFKnBFE6j6ZpYbwY/so5uy+CdiHOtkpLBUY4JwMNB44YGqh6qK1pX7cH47l7cGl7NGz8j6t4FxB2zeTJSKkXD6XVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tyy2fzdpbnxKkaObTSj+ipq5w1hr60XubfVisBskKNg=;
 b=RH5TdeOH4cFdSAru9KgOUiFqRA/2ZAMLPjh0SZe0hCo7GharW5lFS+QK9QE05Qi5hNM+w8CIoq8W4sjSzY6ofzUGC/QjUp5+Vpq2JhJyUOfFIuqFIQjuazQLt0B2aOzVXOK/qGS+HCXfqT8xWOfE896BY5OY6DKCf6Wm+ZEd2ss=
Received: from MN2PR08CA0016.namprd08.prod.outlook.com (2603:10b6:208:239::21)
 by DM6PR02MB5291.namprd02.prod.outlook.com (2603:10b6:5:45::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 23:24:17 +0000
Received: from BL2NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:239:cafe::a8) by MN2PR08CA0016.outlook.office365.com
 (2603:10b6:208:239::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Tue, 23 Jun 2020 23:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT063.mail.protection.outlook.com (10.152.77.121) with Microsoft SMTP
 Server id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 23:24:17
 +0000
Received: from [149.199.38.66] (port=36394 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jnsFr-00009w-Nx; Tue, 23 Jun 2020 16:23:03 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jnsH2-0008DN-R7; Tue, 23 Jun 2020 16:24:16 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05NNO8oQ019169; 
 Tue, 23 Jun 2020 16:24:08 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jnsGu-00084e-Ke; Tue, 23 Jun 2020 16:24:08 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 2/4] xlnx-zynqmp: Connect Xilinx ZynqMP CAN controllers
Date: Tue, 23 Jun 2020 16:23:34 -0700
Message-Id: <1592954616-65393-3-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592954616-65393-1-git-send-email-fnu.vikram@xilinx.com>
References: <1592954616-65393-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(136003)(346002)(376002)(39850400004)(396003)(46966005)(2616005)(6916009)(81166007)(26005)(5660300002)(47076004)(336012)(82310400002)(8936002)(6666004)(2906002)(9786002)(7696005)(426003)(478600001)(70586007)(54906003)(8676002)(316002)(70206006)(82740400003)(4326008)(186003)(36756003)(356005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8b342d4a-f2b5-49e4-ddc7-08d817cc8c91
X-MS-TrafficTypeDiagnostic: DM6PR02MB5291:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5291B9A5164C4077C8966C58BC940@DM6PR02MB5291.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:151;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFCrIytvUtPbogysqqP4oddxkEVe6Jz6IhLH25uSQbXdijjXAp6nvQGABdNAyRMgZ0hdsbzwIII3YOyALOQktSfacLgluDfO5yUsGhW3r+AjCM2GCi4QWWrRN0iZ0aYmQ3f0atR9NnLg3fFfk3Ssx5TUektFBVi34cFi7vI9diJgK14GvyfX/1jfOtgJPM5BZz91QeI3ZnI/IN+izPjzgdTr91wGZPcrQEXKT7+JeVRer3dNIlUZHvkGppx/ZkJqxmsrjnJM0vSx1+KXQZbNixBVhdLuXpNaEoA+PeyP0/q6EzuxTZdHgTrrETTZb+Z8VZGSVfcEg9bA8ErWYUE3wRdxfKTwkfuse3234XiCjFCfOH4+TKGIkag4WneSzUMwtR/yuaFYB/MLBVZbDKB08w==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 23:24:17.1992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b342d4a-f2b5-49e4-ddc7-08d817cc8c91
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5291
Received-SPF: pass client-ip=40.107.94.84; envelope-from=fnuv@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 19:24:18
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


