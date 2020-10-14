Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C29CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 05:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD41621582
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 05:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Yvu71Fm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD41621582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSZeA-0008Rp-Mw
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 01:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kSZci-0007xe-4j
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 01:46:52 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com
 ([40.107.243.40]:61301 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kSZcf-0002jB-4s
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 01:46:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Czjx1Z5uUdB1VU8TH6o//Bdb4aclAuMRQgM5PWX+OfwIo5CR9DEM27Hwn1wMnKAeCt1r3mv8geb19RzOK3WjRBNi3lGLAK0GHALAolSh2ZnMDFD3tumQpDY5uJIwBp6TnfKAbu6KubMtAPMO+Dx5qdbXHcb9cWK4rcMbC+yvXS2TLoiP+hnl//YZK+dpGlu89AusQbRwjIWrDcpEt7QFqq7RibUkfw1DbDMP6vXloGceYFsEbF28KbCLyUTgDln1o8xGp4ab8orwZuwdXS4Sdi5XGVkMZPBRrGNB7nz/OVx4D61rU9m0rACOLZXbD7NP+1RHFBvC3yUD2q6wZWjqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlEP77TEb8SF9MAjy5QJ6aGzR5r/P/0aoihL9r+yD6E=;
 b=MZcqpsLac3HLC0yySooK3iQfWeupfPyk86NSssjDd4lMzYR4hkxFDlp1rlD/4hbh/Qsl/j2FDGnVul+WokB7U1knpsuIKelzDi6ZNK91t0Vz9eHH0WT+/dZVlOgSeCGgzNw5BFPwYFWhc/k458nytSklXNZMKmaMmDWkxRvN9g4v9doMQOnILjNLYStbM/SDtpDnCk0jvYzL7/p0SnZN3qPPsEhOvfdlsu+Wjb92T3uOb/EUK5wvWkzY0d6W3p/007cRzkvrWpXrrvUjZbai8I75HGa6vURNxFM5dok9zQ6fV1UvFIrH0Z8dGqG5r1uXYMVI28yNg0A2mTf2zk06qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlEP77TEb8SF9MAjy5QJ6aGzR5r/P/0aoihL9r+yD6E=;
 b=Yvu71Fm6TdP1Txw0irc0zGqgnPxQLTudIzcmxSe7J91BiZlX7UyC32YGPGSrHRtmEkYJtcSCg77LR6M1Hp5qcFrJhKZVO21pItLMdXvV1fGNpA+yH4Qfoa7kA9rgXBsNgR2+ogLQE9LtNNEhDkXX8/UANFsOLsUSDn4WgIyEYvQ=
Received: from BL0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:91::19)
 by BN6PR02MB2594.namprd02.prod.outlook.com (2603:10b6:404:56::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 14 Oct
 2020 05:46:42 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:91:cafe::84) by BL0PR05CA0009.outlook.office365.com
 (2603:10b6:208:91::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend
 Transport; Wed, 14 Oct 2020 05:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server id 15.20.3455.25 via Frontend Transport; Wed, 14 Oct 2020 05:46:41
 +0000
Received: from [149.199.38.66] (port=54699 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1kSZbn-0001aa-75
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 22:45:55 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1kSZcX-0001oH-7m
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 22:46:41 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may
 be forged))
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 09E5kb8q003871; 
 Tue, 13 Oct 2020 22:46:37 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kSZcT-0001nf-5m; Tue, 13 Oct 2020 22:46:37 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 2/4] xlnx-zynqmp: Connect Xilinx ZynqMP CAN controllers
Date: Tue, 13 Oct 2020 22:46:35 -0700
Message-Id: <1602654397-35162-3-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602654397-35162-1-git-send-email-fnu.vikram@xilinx.com>
References: <1602654397-35162-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 52acccfe-3b12-428a-8e93-08d8700486bf
X-MS-TrafficTypeDiagnostic: BN6PR02MB2594:
X-Microsoft-Antispam-PRVS: <BN6PR02MB25943E209963352E9BD2FD23BC050@BN6PR02MB2594.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:114;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92fA99CDq4URCDpfcmZBE4ZlHSGjbJni51Diy2fkLk0EXoJ4lbAAseRjMEEF7b9viM7VHYRpYp/kuP2tna5sCVRNr8y4FZgnS53iCEK4jmv3FhJrx/tfNxGxzK2IXJuem9Jyqus/v6YmY+frBO/+z5bOeaVReQhqNlNBiOVJojk97rpT/0XoNj1YSk8rF3bLmRefudCkof//yz2i0G+hKwN5AhQ4m60pkq0R4i7WTz3IZYZFhC9nApWp9ZqqQjANMCx4Jep/dTms1SvVWrm23MFKmpF/pIAnXTaJSUYouRPJhkHq0nTC4O40aEt3LQexpvBe7myhXhEhNkNXdbL87qEkUmrsMOim6KN+n6wS/UsKLsgpsM+BHb0/wQneNKzXEVFjU20xrtnuOofo8iWhI2FfIRo5/8IwBxLz5Xy4xyo=
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(39850400004)(396003)(376002)(136003)(346002)(46966005)(5660300002)(356005)(426003)(336012)(107886003)(478600001)(70586007)(70206006)(7696005)(8676002)(82310400003)(2616005)(81166007)(9786002)(8936002)(83380400001)(82740400003)(6916009)(186003)(26005)(316002)(47076004)(4326008)(2906002)(36756003)(42866002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 05:46:41.5776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52acccfe-3b12-428a-8e93-08d8700486bf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2594
Received-SPF: pass client-ip=40.107.243.40; envelope-from=fnuv@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:46:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Connect CAN0 and CAN1 on the ZynqMP.

Reviewed-by: Francisco Iglesias <francisco.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
---
 include/hw/arm/xlnx-zynqmp.h |  8 ++++++++
 hw/arm/xlnx-zcu102.c         | 20 ++++++++++++++++++++
 hw/arm/xlnx-zynqmp.c         | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 567d0db..6f45387 100644
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
@@ -33,6 +34,7 @@
 #include "hw/cpu/cluster.h"
 #include "target/arm/cpu.h"
 #include "qom/object.h"
+#include "net/can_emu.h"
 
 #define TYPE_XLNX_ZYNQMP "xlnx,zynqmp"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)
@@ -41,6 +43,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)
 #define XLNX_ZYNQMP_NUM_RPU_CPUS 2
 #define XLNX_ZYNQMP_NUM_GEMS 4
 #define XLNX_ZYNQMP_NUM_UARTS 2
+#define XLNX_ZYNQMP_NUM_CAN 2
+#define XLNX_ZYNQMP_CAN_REF_CLK (24 * 1000 * 1000)
 #define XLNX_ZYNQMP_NUM_SDHCI 2
 #define XLNX_ZYNQMP_NUM_SPIS 2
 #define XLNX_ZYNQMP_NUM_GDMA_CH 8
@@ -92,6 +96,7 @@ struct XlnxZynqMPState {
 
     CadenceGEMState gem[XLNX_ZYNQMP_NUM_GEMS];
     CadenceUARTState uart[XLNX_ZYNQMP_NUM_UARTS];
+    XlnxZynqMPCANState can[XLNX_ZYNQMP_NUM_CAN];
     SysbusAHCIState sata;
     SDHCIState sdhci[XLNX_ZYNQMP_NUM_SDHCI];
     XilinxSPIPS spi[XLNX_ZYNQMP_NUM_SPIS];
@@ -112,6 +117,9 @@ struct XlnxZynqMPState {
     bool virt;
     /* Has the RPU subsystem?  */
     bool has_rpu;
+
+    /* CAN bus. */
+    CanBusState *canbus[XLNX_ZYNQMP_NUM_CAN];
 };
 
 #endif
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index ad7fff9..4ef0c51 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -25,6 +25,7 @@
 #include "sysemu/qtest.h"
 #include "sysemu/device_tree.h"
 #include "qom/object.h"
+#include "net/can_emu.h"
 
 struct XlnxZCU102 {
     MachineState parent_obj;
@@ -34,6 +35,8 @@ struct XlnxZCU102 {
     bool secure;
     bool virt;
 
+    CanBusState *canbus[XLNX_ZYNQMP_NUM_CAN];
+
     struct arm_boot_info binfo;
 };
 
@@ -125,6 +128,14 @@ static void xlnx_zcu102_init(MachineState *machine)
     object_property_set_bool(OBJECT(&s->soc), "virtualization", s->virt,
                              &error_fatal);
 
+    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
+        gchar *bus_name = g_strdup_printf("canbus%d", i);
+
+        object_property_set_link(OBJECT(&s->soc), bus_name,
+                                 OBJECT(s->canbus[i]), &error_fatal);
+        g_free(bus_name);
+    }
+
     qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
 
     /* Create and plug in the SD cards */
@@ -208,6 +219,15 @@ static void xlnx_zcu102_machine_instance_init(Object *obj)
     s->secure = false;
     /* Default to virt (EL2) being disabled */
     s->virt = false;
+    object_property_add_link(obj, "xlnx-zcu102.canbus0", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[0],
+                             object_property_allow_set_link,
+                             0);
+
+    object_property_add_link(obj, "xlnx-zcu102.canbus1", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[1],
+                             object_property_allow_set_link,
+                             0);
 }
 
 static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 7885bb1..8818472 100644
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
@@ -243,6 +251,11 @@ static void xlnx_zynqmp_init(Object *obj)
                                 TYPE_CADENCE_UART);
     }
 
+    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
+        object_initialize_child(obj, "can[*]", &s->can[i],
+                                TYPE_XLNX_ZYNQMP_CAN);
+    }
+
     object_initialize_child(obj, "sata", &s->sata, TYPE_SYSBUS_AHCI);
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
@@ -482,6 +495,23 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                            gic_spi[uart_intr[i]]);
     }
 
+    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
+        object_property_set_int(OBJECT(&s->can[i]), "ext_clk_freq",
+                                XLNX_ZYNQMP_CAN_REF_CLK, &error_abort);
+
+        object_property_set_link(OBJECT(&s->can[i]), "canbus",
+                                 OBJECT(s->canbus[i]), &error_fatal);
+
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
     object_property_set_int(OBJECT(&s->sata), "num-ports", SATA_NUM_PORTS,
                             &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sata), errp)) {
@@ -619,6 +649,10 @@ static Property xlnx_zynqmp_props[] = {
     DEFINE_PROP_BOOL("has_rpu", XlnxZynqMPState, has_rpu, false),
     DEFINE_PROP_LINK("ddr-ram", XlnxZynqMPState, ddr_ram, TYPE_MEMORY_REGION,
                      MemoryRegion *),
+    DEFINE_PROP_LINK("canbus0", XlnxZynqMPState, canbus[0], TYPE_CAN_BUS,
+                     CanBusState *),
+    DEFINE_PROP_LINK("canbus1", XlnxZynqMPState, canbus[1], TYPE_CAN_BUS,
+                     CanBusState *),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.7.4


