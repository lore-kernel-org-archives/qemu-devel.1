Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA92C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6D721741
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="k0Zuj156"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6D721741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLstF-0000ZF-0C
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 14:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kLssD-0008Tk-Ao
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:55:13 -0400
Received: from mail-dm6nam11on2082.outbound.protection.outlook.com
 ([40.107.223.82]:22785 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kLssA-0001Ib-J5
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:55:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPIjJTWLVwi0XGaXC11P46aCHXE5AZGyZGOvSQPuygT/cyv7fgYA9dJudZ9BRmlETHfNh5dKaEvf9axrq7cC06U+1dOemZ8WwdS4K4NhJ6no+vePbD0zKZgWrLie8qDQWef0LU2scG8c9YplBQdNlVvzvJ3bOpmy0LhLee7iDZLsj2MsKZuKIL6J0ct/c/zjZpN7jXgg+pGN0MTZ/uP2f2p+8/kxFJXBfLzoeTEoJ/uXLQ57Aabr21hx6X+MWPMpedYYRIG4xkzzK1LQivoD3QW0Iua6iRcO1jI9ixLOtCxVRbJp6Kbh/5nr5xJy8GAHCiwN4avUJctdFwxn2+0cgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxMA9V6Dcu5GoZlHLHOn5a9si/iRfDPpj4gwZrQT4/M=;
 b=hpt8iygL2T0DXpusPoyPljaJNNqU6f7sT/esqfVoTV4vvB3WrkO65PsEcgeIGwOkxF8rEJVK7Ao1Q2I8MX0w6rAFraoZ4gFwkViWR/ssM3DoNaqFtJalRU7TNmOUrPsoZFica57WVAfcesYj1RQMpTKoQ8B9XKKgySH5kSvvOhBJajOjjjaEAx1oPxBqdbWac5B0x+JSAzEo0MZNKOmJmrPxlWySJCEdSjv/lyShA9fUBQcbMapytRKqxXv/BPU4pEPdYbIRKUJksrNQh4Aod1NnGr9FwgOfFknSNNZjixJSo1cNBAMONeguS9e5kJxIE+vYV6JVnnZ2WczBUR7lhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxMA9V6Dcu5GoZlHLHOn5a9si/iRfDPpj4gwZrQT4/M=;
 b=k0Zuj156HnPnwJdOLb/00cKrcjfg0ydPlESzM/N++JpfcZx0d7VE5NRAT7VWWcfXFc1Lpa2TtOlkPH82YrA6YAa8r0HsvVhTd2782pTOd0efQTSK3TyrvVFYLEmBpdBM6gYExTmFwkera/4xIn7HiOPfnSQtV9LW9gN3FJj4dFU=
Received: from SN4PR0701CA0017.namprd07.prod.outlook.com
 (2603:10b6:803:28::27) by MN2PR02MB7054.namprd02.prod.outlook.com
 (2603:10b6:208:201::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Fri, 25 Sep
 2020 18:40:05 +0000
Received: from SN1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:28:cafe::a) by SN4PR0701CA0017.outlook.office365.com
 (2603:10b6:803:28::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend
 Transport; Fri, 25 Sep 2020 18:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT021.mail.protection.outlook.com (10.152.72.144) with Microsoft SMTP
 Server id 15.20.3412.21 via Frontend Transport; Fri, 25 Sep 2020 18:40:05
 +0000
Received: from [149.199.38.66] (port=42503 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kLsdG-00027T-9V; Fri, 25 Sep 2020 11:39:46 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kLsdZ-00052k-0H; Fri, 25 Sep 2020 11:40:05 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08PIdujd019026; 
 Fri, 25 Sep 2020 11:39:56 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kLsdP-0004r6-PD; Fri, 25 Sep 2020 11:39:56 -0700
Date: Fri, 25 Sep 2020 20:39:46 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v10 7/7] Versal: Connect DWC3 controller with virt-versal
Message-ID: <20200925183946.GP4142@toto>
References: <1600957256-6494-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1600957256-6494-8-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600957256-6494-8-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b40cd46e-5fc4-4c38-5db8-08d861826bae
X-MS-TrafficTypeDiagnostic: MN2PR02MB7054:
X-Microsoft-Antispam-PRVS: <MN2PR02MB7054A51945FD1166C42E18BCC2360@MN2PR02MB7054.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhWjpCmV2Hu5f/e5wYOQG5LULHJ1VpbG1YLVrUaq97qL0R91j3YOwiXH1zu9tPanVPHXcPwbAQLJrB0DiKIzyOloot//KoXCoMrgUe99cRV4QT5/U3QL36AGkjkcvEq7C688WDv7SRshJ4C1WX1XGU2+twXjSsEzBZacPvdfDDYCpPEK9jezefzUFsmxplFBwGr8NUr9PDrgs0TUMyGS8Yh94CUOtpbeZoo8Si+ZzZXHbR+hWJvvCMLjPBlTSsF4E0bg8t8at7c2F9amFbParerCvLXyq7w9JY04uO3JOsfzP/g+1wBq+jc5xfLJ0h4n68dEbLoqbx3/v7i6pDMBmpsp7SSYDHvYTFc4R3eqhMUcyfmrsenm+ZUQ+9TdpYG72/JDYNa9tZu2uygk0q8kBw==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(136003)(376002)(396003)(346002)(39860400002)(46966005)(70586007)(54906003)(356005)(186003)(33716001)(26005)(6666004)(5660300002)(82740400003)(19627235002)(1076003)(2906002)(316002)(81166007)(336012)(33656002)(8936002)(83380400001)(82310400003)(70206006)(6862004)(47076004)(6636002)(8676002)(9786002)(107886003)(9686003)(7416002)(478600001)(426003)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 18:40:05.3017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b40cd46e-5fc4-4c38-5db8-08d861826bae
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7054
Received-SPF: pass client-ip=40.107.223.82; envelope-from=edgar@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 14:55:08
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

On Thu, Sep 24, 2020 at 07:50:56PM +0530, Sai Pavan Boddu wrote:
> From: Vikram Garhwal <fnu.vikram@xilinx.com>
> 
> Connect dwc3 controller and usb2-reg module to xlnx-versal SOC, its placed
> in iou of lpd domain and configure it as dual port host controller. Add the
> respective guest dts nodes for "xlnx-versal-virt" machine.

Hi Sai,

One minor comment inline.

And a question, could you please post an example command-line for this?


> 
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/arm/xlnx-versal-virt.c    | 58 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/xlnx-versal.c         | 34 ++++++++++++++++++++++++++
>  include/hw/arm/xlnx-versal.h | 14 +++++++++++
>  3 files changed, 106 insertions(+)
> 
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 03e2320..f0ac5ba 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -39,6 +39,8 @@ struct VersalVirt {
>          uint32_t ethernet_phy[2];
>          uint32_t clk_125Mhz;
>          uint32_t clk_25Mhz;
> +        uint32_t usb;
> +        uint32_t dwc;
>      } phandle;
>      struct arm_boot_info binfo;
>  
> @@ -66,6 +68,8 @@ static void fdt_create(VersalVirt *s)
>      s->phandle.clk_25Mhz = qemu_fdt_alloc_phandle(s->fdt);
>      s->phandle.clk_125Mhz = qemu_fdt_alloc_phandle(s->fdt);
>  
> +    s->phandle.usb = qemu_fdt_alloc_phandle(s->fdt);
> +    s->phandle.dwc = qemu_fdt_alloc_phandle(s->fdt);
>      /* Create /chosen node for load_dtb.  */
>      qemu_fdt_add_subnode(s->fdt, "/chosen");
>  
> @@ -148,6 +152,59 @@ static void fdt_add_timer_nodes(VersalVirt *s)
>                       compat, sizeof(compat));
>  }
>  
> +static void fdt_add_usb_xhci_nodes(VersalVirt *s)
> +{
> +    const char clocknames[] = "bus_clk\0ref_clk";
> +    char *name = g_strdup_printf("/usb@%" PRIx32, MM_USB2_CTRL_REGS);
> +    const char compat[] = "xlnx,versal-dwc3";
> +
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
> +
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
> +
>  static void fdt_add_uart_nodes(VersalVirt *s)
>  {
>      uint64_t addrs[] = { MM_UART1, MM_UART0 };
> @@ -515,6 +572,7 @@ static void versal_virt_init(MachineState *machine)
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
>      fdt_add_zdma_nodes(s);
> +    fdt_add_usb_xhci_nodes(s);
>      fdt_add_sd_nodes(s);
>      fdt_add_rtc_node(s);
>      fdt_add_cpu_nodes(s, psci_conduit);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 12ba6c4..64b0d0a 100644
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
> +    object_initialize_child(OBJECT(s), "dwc3-0", &s->lpd.iou.usb.dwc3,
> +                            TYPE_USB_DWC3);
> +    dev = DEVICE(&s->lpd.iou.usb.dwc3);
> +    xhci_dev = DEVICE(&s->lpd.iou.usb.dwc3.sysbus_xhci);
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
> +    object_initialize_child(OBJECT(s), "usb2reg-0", &s->lpd.iou.usb.Usb2Regs,
> +                           TYPE_XILINX_VERSAL_USB2_CTRL_REGS);
> +    dev = DEVICE(&s->lpd.iou.usb.Usb2Regs);
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
> index 8ce8e63..743e4f7 100644
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
>  OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
> @@ -59,6 +61,10 @@ struct Versal {
>              PL011State uart[XLNX_VERSAL_NR_UARTS];
>              CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
>              XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
> +            struct {
> +                USBDWC3 dwc3;
> +                VersalUsb2CtrlRegs Usb2Regs;

I'd prefer this to be any of the following:

                   VersalUsb2CtrlRegs ctrl;
                   VersalUsb2CtrlRegs regs;
                   VersalUsb2CtrlRegs ctrl_regs;


