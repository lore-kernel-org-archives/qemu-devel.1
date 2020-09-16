Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A959DC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4FD20672
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="thhHlqzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4FD20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWqC-00026w-Vd
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kIWp7-0001FN-7t
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:46:09 -0400
Received: from mail-dm6nam11on2074.outbound.protection.outlook.com
 ([40.107.223.74]:50688 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kIWp3-0007sc-8N
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:46:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU86F84Ml/bhrIQk8zH6ExW2rVv8KF6nEgLCisRO2CB/tuMbxHDBVr1GW5yEvQ7kfJhgKflyr5fRxc3KBp5kVPhJriOhPyBPRYQRtG4ReqJWpgDK2oCdpYRBNLbbqEYlcOtvEUfHtNrDQsPZtw6igjI4SA2+WAMZZCHU8VWey3Wbr0igkjBwruPLiQkpK4KonRw0ZZkopT9k1N7c9OxdDXPHWz4/poYBjU70//F0TVhSNsXFxyQEl3Uo0IfxCiag79VTj3jlJiJvUaQcuDUryaGe/C3F2i63mFy3NdTooRSNeHBY4MzQOgGWGs1on1jnClyIMd6BC8cazX3UXG2hgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qpl+8ddC+IyS2DwJswpoLwdGdrQu9+sPwMbwKOBZGY=;
 b=lvyZ/PR1iTTUaiNHcDSiiOnE+S1tsSHsV5Rrdc+J6YvX4Ya4RzWlsT7U9i2uCqOAziXI23LWw80LHRnIEG5k7cePRPsYSh8IK+kT54PgpWdSlucxk4p4nfrEp6fxDoHOWnqmcyWa5575ir+mY3K1KR00IDObmMX+kXQ0ybsZXAhelweJCz9dSxS22a6qmDM37hhj3ODTQ2sLbGvSgO5JdfvU7JjIjiwpCRw4sPqLj2DXpAhfVgVyII2jpgBZ6tyfpDpb9HQhF6WfX/0LmSQ0Mafn3kJIFK7BGzEzSeR3jUwId3CztwUD50RyqBv+Y/VtW1mPUr91PamGslu+MVpVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qpl+8ddC+IyS2DwJswpoLwdGdrQu9+sPwMbwKOBZGY=;
 b=thhHlqzsCh/aiPzGHyx7Mo7fbGeejpKyD8NJ4UW1Jz7g9yiG3Y8QTArDj+rUSB/kWScCsWrYP7qtj+/UI2lsYYO7En47ZrpyMR3lbEK2YaquCA0l1+b6HUvwm3Ta6oNzMk5hb90d5/faXnnGRAZT8zvwoXKQpjVEZTGNO9dswS8=
Received: from DM5PR10CA0002.namprd10.prod.outlook.com (2603:10b6:4:2::12) by
 CY4PR02MB2517.namprd02.prod.outlook.com (2603:10b6:903:72::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 16 Sep 2020 12:30:59 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::f7) by DM5PR10CA0002.outlook.office365.com
 (2603:10b6:4:2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 12:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 12:30:59
 +0000
Received: from [149.199.38.66] (port=49546 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kIWaK-0002T4-Ft; Wed, 16 Sep 2020 05:30:52 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kIWaR-0002Go-7R; Wed, 16 Sep 2020 05:30:59 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08GCUutF012018; 
 Wed, 16 Sep 2020 05:30:56 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kIWaN-0002G2-NY; Wed, 16 Sep 2020 05:30:56 -0700
Date: Wed, 16 Sep 2020 14:30:48 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v6 7/7] Versal: Connect DWC3 controller with virt-versal
Message-ID: <20200916123048.GE4142@toto>
References: <1600256469-13130-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1600256469-13130-9-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600256469-13130-9-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb376a05-f805-4aa5-cc88-08d85a3c5e0c
X-MS-TrafficTypeDiagnostic: CY4PR02MB2517:
X-Microsoft-Antispam-PRVS: <CY4PR02MB251780491189B8B4320A6D4AC2210@CY4PR02MB2517.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rk8FPURO0Er8vfpayKuXWLpSmV3BbrYopYIDkPqntvRvpPxfZzivpjy26TU+SZthd1uG7qvu/abIKBH0YMX4S6fAkR325xq5oU4UdN7jec4lWarjZyx8nP8dENZpOtWgk23FxHUNWlDRr6AKesy7RCrqh/g7g7yWNmy372+X8mVfTWm0TTq5/We7gWmIco3H/w/w4LnbcQJVaIvYidebRiwvnZVEJZk2gKPJLf4u/ftp0iV2yeO0vtZeWWfcUmN8ISk9QG/I7LEKYVvsdzx4o9VxLTQ4RJEGiUBn8reKLw5rlBTlcb5CKWajATZ26v36b+94/RA3Jctv8h2vH2y5qfjNeiZ+FIZlZxVu3q25DyMFAdtPd5HmotSO85a0Jf8aPxRUuY5ptDZ8mQksyg2DKj+kYoO7kCAUrdZkNvzeOYIgs3FeDOou6I0HI/TAhRN+
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(396003)(376002)(39860400002)(346002)(136003)(46966005)(6862004)(83380400001)(9786002)(426003)(336012)(8676002)(82310400003)(19627235002)(6636002)(6666004)(47076004)(82740400003)(54906003)(7416002)(1076003)(9686003)(8936002)(70206006)(5660300002)(186003)(107886003)(356005)(2906002)(81166007)(33716001)(316002)(33656002)(4326008)(70586007)(478600001)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 12:30:59.5070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb376a05-f805-4aa5-cc88-08d85a3c5e0c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2517
Received-SPF: pass client-ip=40.107.223.74; envelope-from=edgar@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 08:46:03
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?'Marc-Andr=E9?= Lureau' <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 'Philippe =?iso-8859-1?Q?Mathieu-Daud=E9'?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 16, 2020 at 05:11:09PM +0530, Sai Pavan Boddu wrote:
> From: Vikram Garhwal <fnu.vikram@xilinx.com>
> 
> Connect dwc3 controller and usb2-reg module to xlnx-versal SOC, its placed
> in iou of lpd domain and configure it as dual port host controller. Add the
> respective guest dts nodes for "xlnx-versal-virt" machine.
> 
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/arm/xlnx-versal-virt.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/xlnx-versal.c         | 34 +++++++++++++++++++++++++++
>  include/hw/arm/xlnx-versal.h | 12 ++++++++++
>  3 files changed, 101 insertions(+)
> 
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 1f9409e..2b4564b 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -41,6 +41,8 @@ struct VersalVirt {
>          uint32_t ethernet_phy[2];
>          uint32_t clk_125Mhz;
>          uint32_t clk_25Mhz;
> +        uint32_t usb;
> +        uint32_t dwc;
>      } phandle;
>      struct arm_boot_info binfo;
>  
> @@ -68,6 +70,8 @@ static void fdt_create(VersalVirt *s)
>      s->phandle.clk_25Mhz = qemu_fdt_alloc_phandle(s->fdt);
>      s->phandle.clk_125Mhz = qemu_fdt_alloc_phandle(s->fdt);
>  
> +    s->phandle.usb = qemu_fdt_alloc_phandle(s->fdt);
> +    s->phandle.dwc = qemu_fdt_alloc_phandle(s->fdt);
>      /* Create /chosen node for load_dtb.  */
>      qemu_fdt_add_subnode(s->fdt, "/chosen");
>  
> @@ -150,6 +154,56 @@ static void fdt_add_timer_nodes(VersalVirt *s)
>                       compat, sizeof(compat));
>  }
>  
> +static void fdt_add_usb_xhci_nodes(VersalVirt *s)
> +{
> +    const char clocknames[] = "bus_clk\0ref_clk";
> +    char *name = g_strdup_printf("/usb@%" PRIx32, MM_USB2_CTRL_REGS);
> +    const char compat[] = "xlnx,versal-dwc3";

Need a blank line here.

> +    qemu_fdt_add_subnode(s->fdt, name);
> +    qemu_fdt_setprop(s->fdt, name, "compatible",
> +                         compat, sizeof(compat));
> +    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> +                                 2, MM_USB2_CTRL_REGS,
> +                                 2, MM_USB2_CTRL_REGS_SIZE);
> +    qemu_fdt_setprop(s->fdt, name, "clock-names",
> +                         clocknames, sizeof(clocknames));
> +    qemu_fdt_setprop_cells(s->fdt, name, "clocks",
> +                               s->phandle.clk_25Mhz, s->phandle.clk_125Mhz);
> +    qemu_fdt_setprop(s->fdt, name, "ranges", NULL, 0);
> +    qemu_fdt_setprop_cell(s->fdt, name, "#address-cells", 2);
> +    qemu_fdt_setprop_cell(s->fdt, name, "#size-cells", 2);
> +    qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.usb);
> +    g_free(name);
> +
> +    {
> +        const char irq_name[] = "dwc_usb3";
> +        const char compat[] = "snps,dwc3";

Here too.


> +        name = g_strdup_printf("/usb@%" PRIx32 "/dwc3@%" PRIx32,
> +                               MM_USB2_CTRL_REGS, MM_USB_XHCI_0);
> +        qemu_fdt_add_subnode(s->fdt, name);
> +        qemu_fdt_setprop(s->fdt, name, "compatible",
> +                         compat, sizeof(compat));
> +        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> +                                     2, MM_USB_XHCI_0, 2, MM_USB_XHCI_0_SIZE);
> +        qemu_fdt_setprop(s->fdt, name, "interrupt-names",
> +                         irq_name, sizeof(irq_name));
> +        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> +                                   GIC_FDT_IRQ_TYPE_SPI, VERSAL_USB0_IRQ_0,
> +                                   GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +        qemu_fdt_setprop_cell(s->fdt, name,
> +                              "snps,quirk-frame-length-adjustment", 0x20);
> +        qemu_fdt_setprop_cells(s->fdt, name, "#stream-id-cells", 1);
> +        qemu_fdt_setprop_string(s->fdt, name, "dr_mode", "host");
> +        qemu_fdt_setprop_string(s->fdt, name, "phy-names", "usb3-phy");
> +        qemu_fdt_setprop(s->fdt, name, "snps,dis_u2_susphy_quirk", NULL, 0);
> +        qemu_fdt_setprop(s->fdt, name, "snps,dis_u3_susphy_quirk", NULL, 0);
> +        qemu_fdt_setprop(s->fdt, name, "snps,refclk_fladj", NULL, 0);
> +        qemu_fdt_setprop(s->fdt, name, "snps,mask_phy_reset", NULL, 0);
> +        qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
> +        qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
> +        g_free(name);
> +    }
> +}
>  static void fdt_add_uart_nodes(VersalVirt *s)
>  {
>      uint64_t addrs[] = { MM_UART1, MM_UART0 };
> @@ -517,6 +571,7 @@ static void versal_virt_init(MachineState *machine)
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
>      fdt_add_zdma_nodes(s);
> +    fdt_add_usb_xhci_nodes(s);
>      fdt_add_sd_nodes(s);
>      fdt_add_rtc_node(s);
>      fdt_add_cpu_nodes(s, psci_conduit);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 12ba6c4..88f7dc8 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -145,6 +145,39 @@ static void versal_create_uarts(Versal *s, qemu_irq *pic)
>      }
>  }
>  
> +static void versal_create_usbs(Versal *s, qemu_irq *pic)
> +{
> +    DeviceState *dev, *xhci_dev;
> +    MemoryRegion *mr;
> +
> +    object_initialize_child(OBJECT(s), "dwc3-0", &s->lpd.iou.dwc3,
> +                            TYPE_USB_DWC3);
> +    dev = DEVICE(&s->lpd.iou.dwc3);
> +    xhci_dev = DEVICE(&s->lpd.iou.dwc3.sysbus_xhci);
> +
> +    object_property_set_link(OBJECT(xhci_dev), "dma", OBJECT(&s->mr_ps),
> +                             &error_abort);
> +    qdev_prop_set_uint32(xhci_dev, "intrs", 1);
> +    qdev_prop_set_uint32(xhci_dev, "slots", 2);
> +
> +    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_add_subregion(&s->mr_ps, MM_USB_XHCI_0_DWC3_GLOBAL, mr);
> +    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(xhci_dev), 0);
> +    memory_region_add_subregion(&s->mr_ps, MM_USB_XHCI_0, mr);
> +
> +    sysbus_connect_irq(SYS_BUS_DEVICE(xhci_dev), 0, pic[VERSAL_USB0_IRQ_0]);
> +
> +    object_initialize_child(OBJECT(s), "usb2reg-0", &s->lpd.iou.Usb2Regs,
> +                           TYPE_XILINX_VERSAL_USB2_CTRL_REGS);
> +    dev = DEVICE(&s->lpd.iou.Usb2Regs);
> +    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_add_subregion(&s->mr_ps, MM_USB2_CTRL_REGS, mr);
> +}
> +
>  static void versal_create_gems(Versal *s, qemu_irq *pic)
>  {
>      int i;
> @@ -333,6 +366,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      versal_create_apu_cpus(s);
>      versal_create_apu_gic(s, pic);
>      versal_create_uarts(s, pic);
> +    versal_create_usbs(s, pic);
>      versal_create_gems(s, pic);
>      versal_create_admas(s, pic);
>      versal_create_sds(s, pic);
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index eaa9023..a428933 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -21,6 +21,8 @@
>  #include "hw/net/cadence_gem.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "qom/object.h"
> +#include "hw/usb/hcd-dwc3.h"
> +#include "hw/misc/xlnx-versal-usb2-ctrl-regs.h"
>  
>  #define TYPE_XLNX_VERSAL "xlnx-versal"
>  typedef struct Versal Versal;
> @@ -61,6 +63,8 @@ struct Versal {
>              PL011State uart[XLNX_VERSAL_NR_UARTS];
>              CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
>              XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
> +            USBDWC3 dwc3;
> +            VersalUsb2CtrlRegs Usb2Regs;

Can you please add a sub-struct for the usb stuff?
e.g:
struct {
    USBDWC3 dwc3;
    VersalUsb2CtrlRegs regs;
} usb;

>          } iou;
>      } lpd;
>  
> @@ -90,6 +94,7 @@ struct Versal {
>  
>  #define VERSAL_UART0_IRQ_0         18
>  #define VERSAL_UART1_IRQ_0         19
> +#define VERSAL_USB0_IRQ_0          22
>  #define VERSAL_GEM0_IRQ_0          56
>  #define VERSAL_GEM0_WAKE_IRQ_0     57
>  #define VERSAL_GEM1_IRQ_0          58
> @@ -127,6 +132,13 @@ struct Versal {
>  #define MM_OCM                      0xfffc0000U
>  #define MM_OCM_SIZE                 0x40000
>  
> +#define MM_USB2_CTRL_REGS           0xFF9D0000
> +#define MM_USB2_CTRL_REGS_SIZE      0x10000
> +
> +#define MM_USB_XHCI_0               0xFE200000
> +#define MM_USB_XHCI_0_SIZE          0x10000
> +#define MM_USB_XHCI_0_DWC3_GLOBAL   (MM_USB_XHCI_0 + 0xC100)
> +
>  #define MM_TOP_DDR                  0x0
>  #define MM_TOP_DDR_SIZE             0x80000000U
>  #define MM_TOP_DDR_2                0x800000000ULL
> -- 
> 2.7.4
> 

