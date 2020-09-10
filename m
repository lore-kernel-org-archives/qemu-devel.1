Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C302FC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 06:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F791207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 06:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jGCi+JEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F791207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGG5O-0006iq-32
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 02:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kGG3c-0004yu-VD
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 02:27:44 -0400
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com
 ([40.107.237.54]:8897 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kGG3a-0006Co-Bg
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 02:27:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRX1z0hsAwuvRtmgwEidWAqyQHCfw3v/5eMfOy9oyp5BPNoDxKlIFmwh4u+KW2ybMB33WryoEY/cs75ilFwutJ3XdvYkFStNdFOWtlUB1YSZAc0eYmofH9/Ns0Rn/ZkiwVgFRvPgDJNG2tAMeV2Q03d9lREDuEGFo31RdX1Y4drn0EFFkRlT8Ip2cPJooDpuj1OisGcgbG4pzgPzdP0tGFe3akzjuKavFEuYwCiuNiNTAicS2PKdW/aWGpEQIfxC+XxM7BNW/bDNNdJ45NhE9aEqFFsUQi8mDMtaQSRab0T0vBg/TDojmW54mTCJGQgpFb/QLF2GjJyw0yN6AmABbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/woqrK1+d6f0PL3HGloQA63gmSzifmNBgC1FCjWlPc=;
 b=k1Vq/ZSGZwYayaRBJKcWAeEzQa48KotZxp5/Lq1GqdaIVTENKD1tvezz/wnWY5JQLh9dhL82q5JH4D4Y3H9H80q09oR77vgZWBIp0X24F8tmhD/I79GDXVyhazCJGVGi4sKAM0OdMhZTYQXK0dCca8LN8UldQeOM9IBplSi4dK0rRsYp6EIkaUB8c66KxXiJSBgsI7rq5QwxAq1U6UAFdbLjuMowrXEqy8N5aGH3WbBKYrdeke+XqwV7eNs2Ik8NWAwNBZ20cb2i7xIf+2Lzr2ostWn0/LDtMo5JBiR3roz+nwS+HUUcQA2R9w0QiWs8SasDgZ8/f7oszLzMibhWNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/woqrK1+d6f0PL3HGloQA63gmSzifmNBgC1FCjWlPc=;
 b=jGCi+JEvoPgxslBLkv1XU/WSV7gNmk5saNkKDaMk+t3CnklqwDF9AkqYWBa7Y10pEPYW9EFcL0t0HB19Y/VDhtCNy8KIr33KGZzIhROp6Ta4UT6WEJick3F8yaEsqQ9KszV2zuEEhs6Y4ul+2PjQHGg0c5fqTqNhFufHJdmjM0o=
Received: from SN4PR0501CA0019.namprd05.prod.outlook.com
 (2603:10b6:803:40::32) by MWHPR02MB3245.namprd02.prod.outlook.com
 (2603:10b6:301:6b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 10 Sep
 2020 06:27:39 +0000
Received: from SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:40:cafe::c9) by SN4PR0501CA0019.outlook.office365.com
 (2603:10b6:803:40::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend
 Transport; Thu, 10 Sep 2020 06:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT048.mail.protection.outlook.com (10.152.72.202) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 06:27:39
 +0000
Received: from [149.199.38.66] (port=57317 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kGG3G-0000JV-Fe; Wed, 09 Sep 2020 23:27:22 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kGG3X-0001WK-4B; Wed, 09 Sep 2020 23:27:39 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08A6RbS5029651; 
 Wed, 9 Sep 2020 23:27:38 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kGG3V-0001Vs-EM; Wed, 09 Sep 2020 23:27:37 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id D559513C0565; Thu, 10 Sep 2020 12:01:37 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: [PATCH v5 7/7] Versal: Connect DWC3 controller with virt-versal
Date: Thu, 10 Sep 2020 12:01:09 +0530
Message-Id: <1599719469-24062-8-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599719469-24062-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1599719469-24062-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 624178ff-6c46-4faf-25f9-08d855529dcd
X-MS-TrafficTypeDiagnostic: MWHPR02MB3245:
X-Microsoft-Antispam-PRVS: <MWHPR02MB32451E0D8D1C3EF99838C4A1CA270@MWHPR02MB3245.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gnmI2ft0/qstITHGrfHNA+ddd7QUYVnV7+oODD7aw81p6kM/rHP6I4X9Iy8udtUPy2dEUYvLHlViJdXXJLg0pWBwtBKVbnmu+/mVUS32zYA3B5APtY97z3d/Jpnst9gMrLzZi7zIqYPbt6ocf685QmdsaBq7eygRJKED9qdgQh197/ZuwWg9bW6WQ7tYzb7s7NXsYfXRB0e2opLlCt4FXND+iEox+Ez5UemBlSUv/5vajLLtMYZe232UFFN2zCJeAiFnyT0r4Z1uCH1He8PZ9o8pC7oWiIKqUpVkZq2wDfEB/1avZ+qKoYHy6XaCz8TVEPFSEDvanS7DhxEVVoeJM0/U0/bjK7ABylzTW6LCfjnnttnUZym+JTzBqqJurzGCCAKMQdqlAyO0YaFTxjqBkw==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(136003)(376002)(396003)(39860400002)(346002)(46966005)(2616005)(4326008)(47076004)(6636002)(478600001)(36756003)(107886003)(83380400001)(8936002)(7416002)(82740400003)(336012)(8676002)(426003)(356005)(186003)(82310400003)(81166007)(6266002)(26005)(42186006)(2906002)(70586007)(6666004)(70206006)(316002)(110136005)(5660300002)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 06:27:39.5931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 624178ff-6c46-4faf-25f9-08d855529dcd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3245
Received-SPF: pass client-ip=40.107.237.54; envelope-from=saipava@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 02:27:41
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 sai.pavan.boddu@xilinx.com, qemu-devel@nongnu.org,
 Paul Zimmerman <pauldzim@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Ying Fang <fangying1@huawei.com>,
 =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vikram Garhwal <fnu.vikram@xilinx.com>

Connect dwc3 controller and usb2-reg module to virt-versal.
Configure it as dual port host controller.

Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/arm/xlnx-versal-virt.c    | 59 ++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/xlnx-versal.c         | 38 ++++++++++++++++++++++++++++
 include/hw/arm/xlnx-versal.h | 14 +++++++++++
 3 files changed, 111 insertions(+)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 4b3152e..398693d 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -39,6 +39,8 @@ typedef struct VersalVirt {
         uint32_t ethernet_phy[2];
         uint32_t clk_125Mhz;
         uint32_t clk_25Mhz;
+        uint32_t usb;
+        uint32_t dwc;
     } phandle;
     struct arm_boot_info binfo;
 
@@ -66,6 +68,8 @@ static void fdt_create(VersalVirt *s)
     s->phandle.clk_25Mhz = qemu_fdt_alloc_phandle(s->fdt);
     s->phandle.clk_125Mhz = qemu_fdt_alloc_phandle(s->fdt);
 
+    s->phandle.usb = qemu_fdt_alloc_phandle(s->fdt);
+    s->phandle.dwc = qemu_fdt_alloc_phandle(s->fdt);
     /* Create /chosen node for load_dtb.  */
     qemu_fdt_add_subnode(s->fdt, "/chosen");
 
@@ -148,6 +152,60 @@ static void fdt_add_timer_nodes(VersalVirt *s)
                      compat, sizeof(compat));
 }
 
+static void fdt_add_usb_xhci_nodes(VersalVirt *s)
+{
+    const char clocknames[] = "bus_clk\0ref_clk";
+    char *usb2name = g_strdup_printf("/usb@ff9d0000");
+    const char dwcCompat[] = "xlnx,versal-dwc3";
+    qemu_fdt_add_subnode(s->fdt, usb2name);
+    qemu_fdt_setprop(s->fdt, usb2name, "compatible",
+                         dwcCompat, sizeof(dwcCompat));
+    qemu_fdt_setprop_sized_cells(s->fdt, usb2name, "reg",
+                                     2, MM_USB2_REGS, 2, 0x100);
+    qemu_fdt_setprop(s->fdt, usb2name, "clock-names",
+                         clocknames, sizeof(clocknames));
+    qemu_fdt_setprop_cells(s->fdt, usb2name, "clocks",
+                               s->phandle.clk_25Mhz, s->phandle.clk_125Mhz);
+    qemu_fdt_setprop(s->fdt, usb2name, "ranges", NULL, 0);
+    qemu_fdt_setprop_cell(s->fdt, usb2name, "#address-cells", 2);
+    qemu_fdt_setprop_cell(s->fdt, usb2name, "#size-cells", 2);
+    qemu_fdt_setprop_cell(s->fdt, usb2name, "phandle", s->phandle.usb);
+    g_free(usb2name);
+
+    {
+        uint64_t addr = MM_USB_XHCI_0;
+        unsigned int irq = VERSAL_USB0_IRQ_0;
+        const char compat[] = "snps,dwc3";
+        const char intName[] = "dwc_usb3";
+        uint32_t frameLen = 0x20;
+
+        char *name = g_strdup_printf("/usb@ff9d0000/dwc3@%" PRIx64, addr);
+        qemu_fdt_add_subnode(s->fdt, name);
+        qemu_fdt_setprop(s->fdt, name, "compatible",
+                         compat, sizeof(compat));
+        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
+                                     2, addr, 2, MM_USB_XHCI_SIZE_0);
+        qemu_fdt_setprop(s->fdt, name, "interrupt-names",
+                         intName, sizeof(intName));
+        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
+                                   GIC_FDT_IRQ_TYPE_SPI, irq,
+                                   GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        qemu_fdt_setprop_cell(s->fdt, name,
+                              "snps,quirk-frame-length-adjustment",
+                               frameLen);
+        qemu_fdt_setprop_cells(s->fdt, name, "#stream-id-cells", 1);
+        qemu_fdt_setprop_string(s->fdt, name, "dr_mode", "host");
+        qemu_fdt_setprop_string(s->fdt, name, "phy-names", "usb3-phy");
+        qemu_fdt_setprop(s->fdt, name, "snps,dis_u2_susphy_quirk", NULL, 0);
+        qemu_fdt_setprop(s->fdt, name, "snps,dis_u3_susphy_quirk", NULL, 0);
+        qemu_fdt_setprop(s->fdt, name, "snps,refclk_fladj", NULL, 0);
+        qemu_fdt_setprop(s->fdt, name, "snps,mask_phy_reset", NULL, 0);
+        qemu_fdt_setprop(s->fdt, name, "snps,usb3_lpm_capable", NULL, 0);
+        qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
+        qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
+        g_free(name);
+    }
+}
 static void fdt_add_uart_nodes(VersalVirt *s)
 {
     uint64_t addrs[] = { MM_UART1, MM_UART0 };
@@ -515,6 +573,7 @@ static void versal_virt_init(MachineState *machine)
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_zdma_nodes(s);
+    fdt_add_usb_xhci_nodes(s);
     fdt_add_sd_nodes(s);
     fdt_add_rtc_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index e3aa4bd..9b241de 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -145,6 +145,43 @@ static void versal_create_uarts(Versal *s, qemu_irq *pic)
     }
 }
 
+static void versal_create_usbs(Versal *s, qemu_irq *pic)
+{
+    char *name = g_strdup_printf("dwc3-0");
+    DeviceState *dev, *xhci_dev;
+    MemoryRegion *mr;
+
+    object_initialize_child(OBJECT(s), name, &s->fpd.iou.dwc3,
+                            TYPE_USB_DWC3);
+    dev = DEVICE(&s->fpd.iou.dwc3);
+    xhci_dev = DEVICE(&s->fpd.iou.dwc3.sysbus_xhci);
+
+    object_property_set_link(OBJECT(xhci_dev), "dma", OBJECT(&s->mr_ps),
+                             &error_abort);
+    qdev_prop_set_uint32(xhci_dev, "intrs", 1);
+    qdev_prop_set_uint32(xhci_dev, "slots", 2);
+
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion(&s->mr_ps, MM_USB_XHCI_0 + 0xC100 , mr);
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(xhci_dev), 0);
+    memory_region_add_subregion(&s->mr_ps, MM_USB_XHCI_0, mr);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(xhci_dev), 0, pic[VERSAL_USB0_IRQ_0]);
+    g_free(name);
+
+    name = g_strdup_printf("usb2reg-0");
+    object_initialize_child(OBJECT(s), name, &s->fpd.iou.Usb2Regs,
+                           "xlnx.usb2_regs");
+    dev = DEVICE(&s->fpd.iou.Usb2Regs);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion(&s->mr_ps, MM_USB2_REGS, mr);
+    g_free(name);
+}
+
 static void versal_create_gems(Versal *s, qemu_irq *pic)
 {
     int i;
@@ -332,6 +369,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_apu_cpus(s);
     versal_create_apu_gic(s, pic);
     versal_create_uarts(s, pic);
+    versal_create_usbs(s, pic);
     versal_create_gems(s, pic);
     versal_create_admas(s, pic);
     versal_create_sds(s, pic);
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 9c9f47b..e19cfd5 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -20,6 +20,8 @@
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
+#include "hw/usb/hcd-dwc3.h"
+#include "hw/misc/xlnx-versal-usb2-regs.h"
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
 #define XLNX_VERSAL(obj) OBJECT_CHECK(Versal, (obj), TYPE_XLNX_VERSAL)
@@ -42,6 +44,11 @@ typedef struct Versal {
             ARMCPU cpu[XLNX_VERSAL_NR_ACPUS];
             GICv3State gic;
         } apu;
+
+        struct {
+            USBDWC3 dwc3;
+            XlnxUsb2Regs Usb2Regs;
+        } iou;
     } fpd;
 
     MemoryRegion mr_ps;
@@ -87,6 +94,7 @@ typedef struct Versal {
 
 #define VERSAL_UART0_IRQ_0         18
 #define VERSAL_UART1_IRQ_0         19
+#define VERSAL_USB0_IRQ_0          22
 #define VERSAL_GEM0_IRQ_0          56
 #define VERSAL_GEM0_WAKE_IRQ_0     57
 #define VERSAL_GEM1_IRQ_0          58
@@ -124,6 +132,12 @@ typedef struct Versal {
 #define MM_OCM                      0xfffc0000U
 #define MM_OCM_SIZE                 0x40000
 
+#define MM_USB2_REGS                0xFF9D0000
+#define MM_USB2_SIZE                0x10000
+
+#define MM_USB_XHCI_0               0xFE200000
+#define MM_USB_XHCI_SIZE_0          0x10000
+
 #define MM_TOP_DDR                  0x0
 #define MM_TOP_DDR_SIZE             0x80000000U
 #define MM_TOP_DDR_2                0x800000000ULL
-- 
2.7.4


