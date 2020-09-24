Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24299C4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93BE022208
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jBXKXfRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BE022208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLS6H-00053T-LO
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kLS4L-0003lR-IF
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:17:59 -0400
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com
 ([40.107.236.82]:4064 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kLS49-0002Pi-7S
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:17:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqNVL6moFwecN5yNkYOAtfx5F7GhVmiYpaUCrervUdb+OTYP/CKHPJrlS+VZJOJ95wzJnLfSYtR1zsJLW0y0ZXtTlbsfrDChZfStKPQM2tQn1c5wdHIpvviKstMV47e3P0E9xd9JxPp6GlvJufjIo8r38hgyMBo9xKuslNMr1nbZ+x1gQ4tFJiTZIXSeDskn4W69fOlg+Co23lYj81swbNkkWQxOS/RaNhGN5DgMMxNXo/wkOjOKZV2AfNm0mLegvMs03WuogqdCg6x9SmuCC0bDQkXyc4mMg1yN6WxOsYEzlhFa+9udHbIKda5mdp36iwXd8mXQpYfTa4c4tjl4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXgZ3mcWf73DDObAbZgZUHIQrwaVdMKcbcGGINWGA78=;
 b=fCCbZk15gbCCBUROYU5XJt/qPS0lgpO7KGoHqE39Oz4yaLpc2CW+CZ70oMEOmTiRySplNa/KXK/GgZ+otcWbUtjvGMTwpVhvXxIkQ6EyK6Fr3M/bakymcPIQavANAaB3mAsLOvdXSdwcCl0AFw39XGitAh72AYyyS1Ddu/mtYmAUFfUTyZbcHAm2FLLOkITJDJ4om3SNRZDPZmaolu1zSdTgqLXoSSi/3yJHPj+koCzCA71mGMy8n3UoqRXUW1GOEg/+K0IGYqoklRtS0iIvzerYBOa7jDp9Sd348iNVu5jDrelUlXREU5uRbGX3gslwoo8ynRQ42i/D3rtAYb2gYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXgZ3mcWf73DDObAbZgZUHIQrwaVdMKcbcGGINWGA78=;
 b=jBXKXfRQAVlfT7jHq9XjZitXzftrxjg/V/S4fqPQxAmAMHvU6PqSubuqLCE04TbcUXoxAGFom5nOgc1qScF0jm2Nb00mTwXuUT4tSwgITgKuS+aftFHv+65HVjjofxCzVgy/pjYX0cfATHtVHLH/WwNhxRav0RV9ZBSzeTOaaXs=
Received: from BL0PR02CA0106.namprd02.prod.outlook.com (2603:10b6:208:51::47)
 by BL0PR02MB6499.namprd02.prod.outlook.com (2603:10b6:208:1c5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 14:17:42 +0000
Received: from BL2NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:51:cafe::11) by BL0PR02CA0106.outlook.office365.com
 (2603:10b6:208:51::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Thu, 24 Sep 2020 14:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT019.mail.protection.outlook.com (10.152.77.166) with Microsoft SMTP
 Server id 15.20.3412.21 via Frontend Transport; Thu, 24 Sep 2020 14:17:42
 +0000
Received: from [149.199.38.66] (port=46167 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kLS3p-0005Yn-8a; Thu, 24 Sep 2020 07:17:25 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kLS46-0007Tf-7b; Thu, 24 Sep 2020 07:17:42 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may
 be forged))
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08OEHfj4011645; 
 Thu, 24 Sep 2020 07:17:41 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kLS44-0007Sw-Kh; Thu, 24 Sep 2020 07:17:41 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 0016E13C06AA; Thu, 24 Sep 2020 19:51:00 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: [PATCH v10 7/7] Versal: Connect DWC3 controller with virt-versal
Date: Thu, 24 Sep 2020 19:50:56 +0530
Message-Id: <1600957256-6494-8-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600957256-6494-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1600957256-6494-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3e4334d9-c8e3-4078-b91a-08d8609499e4
X-MS-TrafficTypeDiagnostic: BL0PR02MB6499:
X-Microsoft-Antispam-PRVS: <BL0PR02MB64993E3A306DA21959E17839CA390@BL0PR02MB6499.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bE4fOtnN6TrqcGkPNoNBy83lD9HovEl0U97AyEjoo0ScU0fkXMtK5BLHAT+eb1Bsjr59lc1pnXcnCz1WXlBnxC+dDdX/nKanIq3d8p6HfdY9tPlk6Bo4/4eCpqgREwCAd3/cMKCI2yrDIvRK8K7Sf3/aaOSqUcDLknfhmKa9hiP7oBjj5CCi0WMQDXM91bP1402ujK7y2iYfGyJxuDlM1oVr6t+VH7fMaFNt9tDG5jZvON5z+IylAzqBL/VgwfHTv9uPXQoTcR0WUhoUep6PxQkCvPqY3njakQoUhslKb06tbmkwnfWCV5wkgvcMQsUUTpTB9XIDznKeob2VWLPJmZwCg4bziKC2l9LybD09G/dK9DiYw63i+UWZVlVPHWYN5ufJ0AyuyLgIR0b+2AcLipvrEqona+iwT1qz1zmH1UhkYst2RluqbdGw8Vq0W01yS+GX+xUQ5+PGKaQh8UI7zw==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(396003)(346002)(39860400002)(136003)(376002)(46966005)(81166007)(356005)(107886003)(26005)(426003)(6666004)(70206006)(8936002)(42186006)(316002)(336012)(2616005)(19627235002)(186003)(5660300002)(6636002)(54906003)(6266002)(47076004)(7416002)(2906002)(478600001)(82740400003)(82310400003)(4326008)(83380400001)(36756003)(70586007)(8676002)(110136005)(42866002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 14:17:42.6095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4334d9-c8e3-4078-b91a-08d8609499e4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6499
Received-SPF: pass client-ip=40.107.236.82; envelope-from=saipava@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 10:17:44
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
 qemu-devel@nongnu.org, Paul Zimmerman <pauldzim@gmail.com>,
 Sai Pavan Boddu <saipava@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Ying Fang <fangying1@huawei.com>,
 =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vikram Garhwal <fnu.vikram@xilinx.com>

Connect dwc3 controller and usb2-reg module to xlnx-versal SOC, its placed
in iou of lpd domain and configure it as dual port host controller. Add the
respective guest dts nodes for "xlnx-versal-virt" machine.

Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/arm/xlnx-versal-virt.c    | 58 ++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/xlnx-versal.c         | 34 ++++++++++++++++++++++++++
 include/hw/arm/xlnx-versal.h | 14 +++++++++++
 3 files changed, 106 insertions(+)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 03e2320..f0ac5ba 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -39,6 +39,8 @@ struct VersalVirt {
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
 
@@ -148,6 +152,59 @@ static void fdt_add_timer_nodes(VersalVirt *s)
                      compat, sizeof(compat));
 }
 
+static void fdt_add_usb_xhci_nodes(VersalVirt *s)
+{
+    const char clocknames[] = "bus_clk\0ref_clk";
+    char *name = g_strdup_printf("/usb@%" PRIx32, MM_USB2_CTRL_REGS);
+    const char compat[] = "xlnx,versal-dwc3";
+
+    qemu_fdt_add_subnode(s->fdt, name);
+    qemu_fdt_setprop(s->fdt, name, "compatible",
+                         compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
+                                 2, MM_USB2_CTRL_REGS,
+                                 2, MM_USB2_CTRL_REGS_SIZE);
+    qemu_fdt_setprop(s->fdt, name, "clock-names",
+                         clocknames, sizeof(clocknames));
+    qemu_fdt_setprop_cells(s->fdt, name, "clocks",
+                               s->phandle.clk_25Mhz, s->phandle.clk_125Mhz);
+    qemu_fdt_setprop(s->fdt, name, "ranges", NULL, 0);
+    qemu_fdt_setprop_cell(s->fdt, name, "#address-cells", 2);
+    qemu_fdt_setprop_cell(s->fdt, name, "#size-cells", 2);
+    qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.usb);
+    g_free(name);
+
+    {
+        const char irq_name[] = "dwc_usb3";
+        const char compat[] = "snps,dwc3";
+
+        name = g_strdup_printf("/usb@%" PRIx32 "/dwc3@%" PRIx32,
+                               MM_USB2_CTRL_REGS, MM_USB_XHCI_0);
+        qemu_fdt_add_subnode(s->fdt, name);
+        qemu_fdt_setprop(s->fdt, name, "compatible",
+                         compat, sizeof(compat));
+        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
+                                     2, MM_USB_XHCI_0, 2, MM_USB_XHCI_0_SIZE);
+        qemu_fdt_setprop(s->fdt, name, "interrupt-names",
+                         irq_name, sizeof(irq_name));
+        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
+                                   GIC_FDT_IRQ_TYPE_SPI, VERSAL_USB0_IRQ_0,
+                                   GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        qemu_fdt_setprop_cell(s->fdt, name,
+                              "snps,quirk-frame-length-adjustment", 0x20);
+        qemu_fdt_setprop_cells(s->fdt, name, "#stream-id-cells", 1);
+        qemu_fdt_setprop_string(s->fdt, name, "dr_mode", "host");
+        qemu_fdt_setprop_string(s->fdt, name, "phy-names", "usb3-phy");
+        qemu_fdt_setprop(s->fdt, name, "snps,dis_u2_susphy_quirk", NULL, 0);
+        qemu_fdt_setprop(s->fdt, name, "snps,dis_u3_susphy_quirk", NULL, 0);
+        qemu_fdt_setprop(s->fdt, name, "snps,refclk_fladj", NULL, 0);
+        qemu_fdt_setprop(s->fdt, name, "snps,mask_phy_reset", NULL, 0);
+        qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
+        qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
+        g_free(name);
+    }
+}
+
 static void fdt_add_uart_nodes(VersalVirt *s)
 {
     uint64_t addrs[] = { MM_UART1, MM_UART0 };
@@ -515,6 +572,7 @@ static void versal_virt_init(MachineState *machine)
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_zdma_nodes(s);
+    fdt_add_usb_xhci_nodes(s);
     fdt_add_sd_nodes(s);
     fdt_add_rtc_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 12ba6c4..64b0d0a 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -145,6 +145,39 @@ static void versal_create_uarts(Versal *s, qemu_irq *pic)
     }
 }
 
+static void versal_create_usbs(Versal *s, qemu_irq *pic)
+{
+    DeviceState *dev, *xhci_dev;
+    MemoryRegion *mr;
+
+    object_initialize_child(OBJECT(s), "dwc3-0", &s->lpd.iou.usb.dwc3,
+                            TYPE_USB_DWC3);
+    dev = DEVICE(&s->lpd.iou.usb.dwc3);
+    xhci_dev = DEVICE(&s->lpd.iou.usb.dwc3.sysbus_xhci);
+
+    object_property_set_link(OBJECT(xhci_dev), "dma", OBJECT(&s->mr_ps),
+                             &error_abort);
+    qdev_prop_set_uint32(xhci_dev, "intrs", 1);
+    qdev_prop_set_uint32(xhci_dev, "slots", 2);
+
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion(&s->mr_ps, MM_USB_XHCI_0_DWC3_GLOBAL, mr);
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(xhci_dev), 0);
+    memory_region_add_subregion(&s->mr_ps, MM_USB_XHCI_0, mr);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(xhci_dev), 0, pic[VERSAL_USB0_IRQ_0]);
+
+    object_initialize_child(OBJECT(s), "usb2reg-0", &s->lpd.iou.usb.Usb2Regs,
+                           TYPE_XILINX_VERSAL_USB2_CTRL_REGS);
+    dev = DEVICE(&s->lpd.iou.usb.Usb2Regs);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion(&s->mr_ps, MM_USB2_CTRL_REGS, mr);
+}
+
 static void versal_create_gems(Versal *s, qemu_irq *pic)
 {
     int i;
@@ -333,6 +366,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_apu_cpus(s);
     versal_create_apu_gic(s, pic);
     versal_create_uarts(s, pic);
+    versal_create_usbs(s, pic);
     versal_create_gems(s, pic);
     versal_create_admas(s, pic);
     versal_create_sds(s, pic);
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 8ce8e63..743e4f7 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -21,6 +21,8 @@
 #include "hw/net/cadence_gem.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
+#include "hw/usb/hcd-dwc3.h"
+#include "hw/misc/xlnx-versal-usb2-ctrl-regs.h"
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
 OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
@@ -59,6 +61,10 @@ struct Versal {
             PL011State uart[XLNX_VERSAL_NR_UARTS];
             CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
             XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
+            struct {
+                USBDWC3 dwc3;
+                VersalUsb2CtrlRegs Usb2Regs;
+            } usb;
         } iou;
     } lpd;
 
@@ -88,6 +94,7 @@ struct Versal {
 
 #define VERSAL_UART0_IRQ_0         18
 #define VERSAL_UART1_IRQ_0         19
+#define VERSAL_USB0_IRQ_0          22
 #define VERSAL_GEM0_IRQ_0          56
 #define VERSAL_GEM0_WAKE_IRQ_0     57
 #define VERSAL_GEM1_IRQ_0          58
@@ -125,6 +132,13 @@ struct Versal {
 #define MM_OCM                      0xfffc0000U
 #define MM_OCM_SIZE                 0x40000
 
+#define MM_USB2_CTRL_REGS           0xFF9D0000
+#define MM_USB2_CTRL_REGS_SIZE      0x10000
+
+#define MM_USB_XHCI_0               0xFE200000
+#define MM_USB_XHCI_0_SIZE          0x10000
+#define MM_USB_XHCI_0_DWC3_GLOBAL   (MM_USB_XHCI_0 + 0xC100)
+
 #define MM_TOP_DDR                  0x0
 #define MM_TOP_DDR_SIZE             0x80000000U
 #define MM_TOP_DDR_2                0x800000000ULL
-- 
2.7.4


