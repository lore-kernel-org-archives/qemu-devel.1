Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90478C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 07:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC392075F
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 07:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ZRutmSW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC392075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaDgh-0003F4-Jo
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 03:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>)
 id 1jaDfS-0001k4-P7; Sun, 17 May 2020 03:25:02 -0400
Received: from mail-eopbgr770071.outbound.protection.outlook.com
 ([40.107.77.71]:18692 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>)
 id 1jaDfR-0007ep-8N; Sun, 17 May 2020 03:25:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPD+BvmDm9lvISr1ZciQxUpPW0IxSt634yjVru+CuBGj9RTXpu1zEGof2sAX6oDpUbOdX3HcnoRY+nlMCKZE/48GoT0kwTX/6D8HZhum0bof+AbVZcky9r3aZzNmn80I6wheIHovRo0s5rMP370uwFynNABNPD9b1stlFM64B22XeH4Dr8RGzzbwxL/Z+mVZzCzuoWEBCObJs+e9B23NrrPBUHRU1dfjYyXTP2Rz5BPlqf/wcH+9VRDnfF6UNwsVLnRkycB4s1zCBQl8vIecCDTFTA5UWSzTmDp3apo0ftAkxSQV1uUAOmt5w5aPsAtW6ORZCIDDAnMpQDTtbyltEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flvK093IJ5gQ+oSihoM7Nifc6xLtegm2wQhO+BfUHyU=;
 b=HEuMkbKcHgWVQaX099ydolQ1r0DclA07jT0IjI3wSgO539YE0mttqFHbqtv7SZwYA0oDL3xwjoEkn9jkSPu3BWoxhIrmriBtIY3ohJGw0DRNHLQRUnMNYAgLtIFpQwgJf/X1NY57WumfZHdMllt7iMuYYTS2O3Uzu2GSq0W4vWuICChMgaJy+/CviVNO1oP8mEb6PqU1tLavA6BJ5ZjuHZ7x+CHunhNXmUliiDTWRrI63IndBjTENQoPn79LMKrcgf+pJjUqDJamQvWDIdflhRRoMFvImOnpDDvMEVoX0f75Cjfu8Ch0K4Z3WdVtaXip/GR5liRZ2XbeUkXWL/uQkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flvK093IJ5gQ+oSihoM7Nifc6xLtegm2wQhO+BfUHyU=;
 b=ZRutmSW+Zy5+9Qcsj3Hdf3V1KcsHUZVDxgLfcuYw5j9bsyNZ7rNGPFfrtAO+KoMdZIegb2OSZc1LQm/PCOnXMolH0gV/UHJ4ETQMHU18CFItF9XvVyS9fxV32CHHo1e6LdAxBN4soeHL41qdKrT/BOpnsuWLBkxZ1KH1gboACtA=
Received: from DM5PR16CA0019.namprd16.prod.outlook.com (2603:10b6:3:c0::29) by
 CY4PR02MB2759.namprd02.prod.outlook.com (2603:10b6:903:11a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Sun, 17 May
 2020 07:24:57 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::22) by DM5PR16CA0019.outlook.office365.com
 (2603:10b6:3:c0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend
 Transport; Sun, 17 May 2020 07:24:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server id 15.20.3000.19 via Frontend Transport; Sun, 17 May 2020 07:24:56
 +0000
Received: from [149.199.38.66] (port=37143 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jaDez-0002F1-Ac; Sun, 17 May 2020 00:24:33 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jaDfL-0002e7-U9; Sun, 17 May 2020 00:24:55 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04H7OkpF020458; 
 Sun, 17 May 2020 00:24:47 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jaDfC-0002ct-Qi; Sun, 17 May 2020 00:24:46 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/4] xlnx-zynqmp: Connect Xilinx ZynqMP CAN controllers
Date: Sun, 17 May 2020 00:24:02 -0700
Message-Id: <1589700245-142782-3-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589700245-142782-1-git-send-email-fnu.vikram@xilinx.com>
References: <1589700245-142782-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(39850400004)(396003)(376002)(136003)(346002)(46966005)(2616005)(82740400003)(7696005)(81166007)(70206006)(6916009)(70586007)(426003)(6666004)(186003)(2906002)(356005)(478600001)(336012)(82310400002)(36756003)(5660300002)(9786002)(47076004)(54906003)(316002)(8936002)(8676002)(4326008)(26005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f9275eae-9054-4a28-8a89-08d7fa33664a
X-MS-TrafficTypeDiagnostic: CY4PR02MB2759:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2759AC68CFEE9013DDD36FC9BCBB0@CY4PR02MB2759.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:151;
X-Forefront-PRVS: 040655413E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9WXIO9QzP8Ktsu2QFut+5W8BwihZq7F431xgLB47HEMQVw/HEMLr0/q2DFHCoOlcqjiJ8e3acLChs9Gs7MYCZX0RAgmz02CojSNrX5WjeDlNJXJEVSQp2eLKNoG3Gy4pML7E5EFWfAfLgHjuLZa2aSC5682V0CGsQXh+GToEYHsv9M8fWZDUBZAz0tUEvTASMUdyMfV/5YY+hdIO8+Oed4mZKOXI4BRvOWE+ADUNGKhq6uZr5IRDFhwidNmOafkquReMV2hVymyZQMjpOE3TQhV1oG8Qwa+sQ9t/Vr3GiqC8x2Joa8zw1Ktns/9LkmdigM2HEkB3Xas3VBR2bgT1dLHfeUfgGOBkdvKpUJI2z9gPxiTeMVUUN6zWuRMoylmrxXxF5M+v9baRNhK15EnbZHvBeJjvrcU5hcpr6EzSMTQeJxHVdvxRZXQM0k56l/XIXiXzHJCRjRVW0mzzMIA6PFZGwP0SNtuQVKgtuvXqoQvjlk1LDNUezX+guJwofEdReLtAJbxP863RQmQggjlCA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2020 07:24:56.2571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9275eae-9054-4a28-8a89-08d7fa33664a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2759
Received-SPF: pass client-ip=40.107.77.71; envelope-from=fnuv@xilinx.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 03:24:59
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

Reviewed-by: Francisco Iglesias <francisco.iglesias@xilinx.com>
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


