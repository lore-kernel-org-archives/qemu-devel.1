Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565E0C2D0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FBD520740
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qzkwJxoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBD520740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYbM4-0003hE-BV
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 16:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>)
 id 1jYbKZ-0002DI-O6; Tue, 12 May 2020 16:16:47 -0400
Received: from mail-eopbgr690079.outbound.protection.outlook.com
 ([40.107.69.79]:59203 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>)
 id 1jYbKY-0003dd-N7; Tue, 12 May 2020 16:16:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmAOQaxcB5ttZdhaYL/8J2RHEqUrrZEz1dMxKfkYg5fp+sTKRc0DDkYKxx5kDJ0twCzzHMhkcbjD3aRv8XY1IyZagShpV3V/GMuR4eMx1VyKv6FlnWSCc6TWBBG9Ca6tNCzPKuF5OGhKBNgpP6XBLlsyoSMHhTAYAffCWP6DGXzi2KIY3+o48PcFjg4IsYV1maI+gDEluqJ81Hk9gVTONR2JtVmqaVjnSdyh08aS560sDIEk0eMHS12M1h4XRzn7x2Mmlk9nR8zFKVUR6FxCuXJ5NN9gRAQTXf6fb22pzyTpWDdc1DNokp3DW2gA32SEF6MUBhFo7DI6x1yok82sJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9Tu0V9P0pHPss3bB17tp7o6Al/TbupNusF/U0o0Slg=;
 b=mDtpzZH4M2oZtKjpvW2Kv8swpm7xPFKLG4Ra1RO8pS1gU7uhIAxB7WrMUbTPXMrGGoRNUe7k+OzJhkHl1YWsHOGiZfd6d2RbpNQSUQMT0IkU6lNtTgR13mO+vh01nuokMaI6IcsQZ9G1b60VmFvvnAE6x988L/4hMIblPEoVaC7tspItLVQmnZ9Ytu0kiAn4aNBknozJJSIciWuvzDxUWWP6xyGL9Q4IVN1ZMDu2QcvX3hrtmQF9AGo7W4G9+9LE+N0E96OCwMBvJ30FaNQHQldjDxyihROoW0FtX9AutYEKNeYO8l1INkW9IiesoVthMXQNxON66lCzWRrG4PDhgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9Tu0V9P0pHPss3bB17tp7o6Al/TbupNusF/U0o0Slg=;
 b=qzkwJxooNLkv3mgYBhqqo36dbYCf8Gqx/z6gDsCo0zcIEj1FuUyvi8kRcomVkIn922Xf5nmSaWKIwgavvYdFNr0fowIbcBbFSir3xcbbjde1sbnW9cH4Ks8C8gO08As+XoBL2ECVvqf6cNChXkk2EMVC8M+TJ4QJbTav+wIzk4U=
Received: from DM5PR16CA0039.namprd16.prod.outlook.com (2603:10b6:4:15::25) by
 SN6PR02MB4559.namprd02.prod.outlook.com (2603:10b6:805:a6::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26; Tue, 12 May 2020 20:16:43 +0000
Received: from CY1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::e7) by DM5PR16CA0039.outlook.office365.com
 (2603:10b6:4:15::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend
 Transport; Tue, 12 May 2020 20:16:43 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT032.mail.protection.outlook.com (10.152.75.184) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 20:16:42
 +0000
Received: from [149.199.38.66] (port=35266 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jYbKD-0000V1-Ow; Tue, 12 May 2020 13:16:25 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jYbKU-00068o-DW; Tue, 12 May 2020 13:16:42 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04CKGarS021590; 
 Tue, 12 May 2020 13:16:36 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jYbKO-0005zy-Kn; Tue, 12 May 2020 13:16:36 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/4] xlnx-zynqmp: Connect Xilinx ZynqMP CAN controllers
Date: Tue, 12 May 2020 13:15:50 -0700
Message-Id: <1589314552-1375-3-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589314552-1375-1-git-send-email-fnu.vikram@xilinx.com>
References: <1589314552-1375-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(396003)(376002)(136003)(346002)(46966005)(33430700001)(70206006)(70586007)(426003)(6916009)(9786002)(478600001)(36756003)(336012)(6666004)(2906002)(2616005)(8676002)(5660300002)(7696005)(26005)(4326008)(186003)(8936002)(81166007)(316002)(47076004)(54906003)(82740400003)(356005)(82310400002)(33440700001);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 470ffd1f-1446-46c6-ef56-08d7f6b16301
X-MS-TrafficTypeDiagnostic: SN6PR02MB4559:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4559CFBFE67C0E04EAFEF7C8BCBE0@SN6PR02MB4559.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:151;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmF8EEuufWP5fnV3CrMxBRIByhw+UT8hPW1v6swBCiMQ8aHn6Jgvzaiq+5iWVqcSVpo2NI5NkRipeqbVHui3udThN86uFpzCUalO7UdWhoxo3ZgcIZiTNVtwja0kAt1GSPWcmy5vZPDVdAUkWw76dbNBYc/h3/OiE68UboZEaD3EN6GtqWLNUuMgIscbFaeL2Qo61gp2jv16PLvdpyfWYxrAKH9PqCcnDd4VFJ94xSbIHOargMgaJVRGWvAiVzCTmgLNJlYXig0fJucZOolziyQVlNf/yl1S5gCovkmypzZa89xh/QVVDkwj6VTOhrdzjmNK80OcbGzDvQZyEvLyA+pDUShnulCO5XgNrrbshCo7KbvUtTwz5Q6Ozdz97471fQhKtd/WvhG8He/iqR+jY30042w0VpHX1U/8KRmYS93qJXkiEApuAcYmInmOYky5b79ln/0un8s7CohuhD4RrEv+Gs9z+zDhhIFQ4g1K0mkyhlHQ5dQ7fZ45CkotJV9iNvfxLpQVITe6R51GawXxTl3YA/wa6Xzz7jzK+xh2SsBLDuPNSzdTxPP2XYu2Zhu2/TFHzZaWhe/zymwX0R1MeA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 20:16:42.6840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 470ffd1f-1446-46c6-ef56-08d7f6b16301
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4559
Received-SPF: pass client-ip=40.107.69.79; envelope-from=fnuv@xilinx.com;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 16:16:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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
index 53076fa..5b32e98 100644
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
+    XlnxZynqMPCANState can[XLNX_ZYNQMP_NUM_CAN];
     SysbusAHCIState sata;
     SDHCIState sdhci[XLNX_ZYNQMP_NUM_SDHCI];
     XilinxSPIPS spi[XLNX_ZYNQMP_NUM_SPIS];
-- 
2.7.4


