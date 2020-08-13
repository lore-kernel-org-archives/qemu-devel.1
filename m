Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164A2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 00:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58B920771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 00:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dqJC/F8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58B920771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k61B4-0003xH-2x
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 20:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>)
 id 1k619j-0002RQ-Rz; Wed, 12 Aug 2020 20:31:44 -0400
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com
 ([40.107.237.55]:28092 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>)
 id 1k619f-0000cx-G9; Wed, 12 Aug 2020 20:31:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxbaga5CTDaFHw6oCUXYcDSLtpfZVlE1mvGWx42kDGLgsDMIpOPXdSUArAZvGyvzDXUA+BmlkCh2jvuyRE5AExuHgoMBs5OYNjLmUwoJqWRYX5Ne8zo+VOoD9567Zvg6UCzFdDq3HB4nXUwikUQqxG9BdmpGhJFVaJi+4MkfN8n+50M8mjHYD8kyAGZ1iWcmfI9HC5ndp4qWvoxL2qHi/SLu5lBVxPgIidV5WyEB9ocRy3nCSfKB1B+hjCIE8i8mXBK086rRdMTB262LeKBsujE2GRAmRmL0mOQuSIfDg8n5ZQq36K8bn0okWEL4BMWDxVGpG9b8oYlNjtmESVD4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CP7QStMptx6r6vsUdYEvkIVVIzvVzLEUr7Hqe15LI4=;
 b=Wf129M+f+coaXk4mcueiB/AYrhfRSh7dL9jxsRaZGjGtpLIrZvTnQkRRED7K/o6SP5IgZCb/wpa8p/TAAXxQ/xJ2u8VtkSDWI06Z6KDPfuJh+/mVnRtZI7HCB35tO7ZL7gcZ2AMXluTJ9mTvzr4r3nDGCmwPc+0t9Li1UPz8BRdZ8g3pcJUuBu1nOtVste+gOmzimZa+xbTNL+E9ilS8GgBmprBSote2SOaoEZR8TDI8HUyU9DVyomH5JlHu/2G3Fx0/IS7WDjvngP8BrTsgYSXZRsRQtOn3yEsSyXa8O759CyaSpivMVDz4eflZPu89modLMJHqQrlvwGHVIM+zww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CP7QStMptx6r6vsUdYEvkIVVIzvVzLEUr7Hqe15LI4=;
 b=dqJC/F8xLYVESoggiW+6b+2WZRJAOMR0QbAl6XQepnaoK0RumfM2NtZbSNbYUyQqvOtPxTq/f6tOcx9PO8SOp45FCAHdMz9td7Bs0OE3c6GYYq+i2Pm0P2JhoQPDmqqFCMjs1tl8ELbH2VPFM/e02k59dw0UcLDswP00aLgPPSo=
Received: from DM5PR2201CA0003.namprd22.prod.outlook.com (2603:10b6:4:14::13)
 by MW2PR02MB3787.namprd02.prod.outlook.com (2603:10b6:907:3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Thu, 13 Aug
 2020 00:31:27 +0000
Received: from DM3NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::bc) by DM5PR2201CA0003.outlook.office365.com
 (2603:10b6:4:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Thu, 13 Aug 2020 00:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 DM3NAM02FT055.mail.protection.outlook.com (10.13.5.136) with Microsoft SMTP
 Server id 15.20.3283.16 via Frontend Transport; Thu, 13 Aug 2020 00:31:27
 +0000
Received: from [149.199.38.66] (port=57218 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1k619J-0006yf-HA; Wed, 12 Aug 2020 17:31:17 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1k619S-00080l-PU; Wed, 12 Aug 2020 17:31:26 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07D0VJ4g029526; 
 Wed, 12 Aug 2020 17:31:19 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1k619L-0007xR-No; Wed, 12 Aug 2020 17:31:19 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 2/4] xlnx-zynqmp: Connect Xilinx ZynqMP CAN controllers
Date: Wed, 12 Aug 2020 17:31:06 -0700
Message-Id: <1597278668-339715-3-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597278668-339715-1-git-send-email-fnu.vikram@xilinx.com>
References: <1597278668-339715-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f143b63c-f6e0-4a8c-29da-08d83f203736
X-MS-TrafficTypeDiagnostic: MW2PR02MB3787:
X-Microsoft-Antispam-PRVS: <MW2PR02MB378781CE30873B017B1AF191BC430@MW2PR02MB3787.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:114;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVVGQDKA78u19bAhi5CfzFDtw9YgAA7gjJgnfMsCjjP2cgAiBs76R/UtTr6Nir+heYskVL4QEvB5+FvvW8T7Wdz3y5hBCv6gBUeahJCRMCmWF8ocwQaLt723ttNohtBy23BydvUVBzS1Sk65ZXdU97t7xKKSDSGLGKva6QYAN5p7Phw3iH4MS5qrR5vtYWIemHSK/p3810NGJCbeNcGbki4c5Lf612yvjHbtlzfBB23p87kWH3EEk0pbIkAa5MBP635ot5kQFEnfM1TURZRuOH2Rh+Gya/mwqHcjK3Iyr069Tezp2SIRsW/J9zgTFbF/aPg70hsuEEhIugSkVojPeMZD72TfjtuWn8kxcPvuX3PE7MBbFk4lszKpgEv0YOHyJO5QYaoj8MvkPDVJJXmGLA==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(396003)(346002)(376002)(136003)(46966005)(5660300002)(70586007)(70206006)(2616005)(316002)(36756003)(2906002)(54906003)(26005)(47076004)(8936002)(6666004)(336012)(356005)(4326008)(478600001)(186003)(7696005)(82310400002)(81166007)(82740400003)(9786002)(8676002)(426003)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 00:31:27.0685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f143b63c-f6e0-4a8c-29da-08d83f203736
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3787
Received-SPF: pass client-ip=40.107.237.55; envelope-from=fnuv@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 20:31:37
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
 hw/arm/xlnx-zcu102.c         | 20 ++++++++++++++++++++
 hw/arm/xlnx-zynqmp.c         | 34 ++++++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h |  8 ++++++++
 3 files changed, 62 insertions(+)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 5997262..c3e3420 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -24,6 +24,7 @@
 #include "qemu/log.h"
 #include "sysemu/qtest.h"
 #include "sysemu/device_tree.h"
+#include "net/can_emu.h"
 
 typedef struct XlnxZCU102 {
     MachineState parent_obj;
@@ -33,6 +34,8 @@ typedef struct XlnxZCU102 {
     bool secure;
     bool virt;
 
+    CanBusState *canbus[XLNX_ZYNQMP_NUM_CAN];
+
     struct arm_boot_info binfo;
 } XlnxZCU102;
 
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
@@ -220,6 +231,15 @@ static void xlnx_zcu102_machine_instance_init(Object *obj)
                                     "Set on/off to enable/disable emulating a "
                                     "guest CPU which implements the ARM "
                                     "Virtualization Extensions");
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
index c435b9d..adad3e7 100644
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
@@ -480,6 +493,23 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
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
@@ -617,6 +647,10 @@ static Property xlnx_zynqmp_props[] = {
     DEFINE_PROP_BOOL("has_rpu", XlnxZynqMPState, has_rpu, false),
     DEFINE_PROP_LINK("ddr-ram", XlnxZynqMPState, ddr_ram, TYPE_MEMORY_REGION,
                      MemoryRegion *),
+    DEFINE_PROP_LINK("canbus0", XlnxZynqMPState, canbus[0], TYPE_CAN_BUS,
+                     CanBusState *),
+    DEFINE_PROP_LINK("canbus1", XlnxZynqMPState, canbus[1], TYPE_CAN_BUS,
+                     CanBusState *),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 53076fa..8cada69 100644
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
@@ -32,6 +33,7 @@
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "hw/cpu/cluster.h"
 #include "target/arm/cpu.h"
+#include "net/can_emu.h"
 
 #define TYPE_XLNX_ZYNQMP "xlnx,zynqmp"
 #define XLNX_ZYNQMP(obj) OBJECT_CHECK(XlnxZynqMPState, (obj), \
@@ -41,6 +43,8 @@
 #define XLNX_ZYNQMP_NUM_RPU_CPUS 2
 #define XLNX_ZYNQMP_NUM_GEMS 4
 #define XLNX_ZYNQMP_NUM_UARTS 2
+#define XLNX_ZYNQMP_NUM_CAN 2
+#define XLNX_ZYNQMP_CAN_REF_CLK (24 * 1000 * 1000)
 #define XLNX_ZYNQMP_NUM_SDHCI 2
 #define XLNX_ZYNQMP_NUM_SPIS 2
 #define XLNX_ZYNQMP_NUM_GDMA_CH 8
@@ -92,6 +96,7 @@ typedef struct XlnxZynqMPState {
 
     CadenceGEMState gem[XLNX_ZYNQMP_NUM_GEMS];
     CadenceUARTState uart[XLNX_ZYNQMP_NUM_UARTS];
+    XlnxZynqMPCANState can[XLNX_ZYNQMP_NUM_CAN];
     SysbusAHCIState sata;
     SDHCIState sdhci[XLNX_ZYNQMP_NUM_SDHCI];
     XilinxSPIPS spi[XLNX_ZYNQMP_NUM_SPIS];
@@ -112,6 +117,9 @@ typedef struct XlnxZynqMPState {
     bool virt;
     /* Has the RPU subsystem?  */
     bool has_rpu;
+
+    /* CAN bus. */
+    CanBusState *canbus[XLNX_ZYNQMP_NUM_CAN];
 }  XlnxZynqMPState;
 
 #endif
-- 
2.7.4


