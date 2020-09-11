Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D76FC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A43221E3
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lbGUI9ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A43221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGe34-0005tu-50
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 04:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kGe1z-00051X-Gg
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:03:39 -0400
Received: from mail-eopbgr750073.outbound.protection.outlook.com
 ([40.107.75.73]:49902 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kGe1x-0006GC-0t
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:03:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih8Sf4AllGfiLC8f4ud4EJcu2IlPqdq/Ivt0XK3vqLfGK6MWBrlaOrLuzhfBOkHfptBQgF30kSD3PZejGhA+rrwoC1wu/lyoJ/suixTL8miei5cK5gkVPG19WE5eT3HbB8AeBVmytNywY1puUJlA6ZkG39v2XtQY5zlvppOhcQ3ZXomJA3mi+31wlyH4QNH0FxlelZhBGx6PVNAYV+PpI6m3ssUhvDulsyQrAyVVtCtWXDI/egV8xBjC+yJTVW0xoWk3nnFb0G5+SywBjrzZ+/BkZ/PfnktkniPqh36+1KrKaqlU2rGCVzV7YxblW4bNkMhDYibuK4FmclYLlgFNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb00ELtRFpQJt2mmJoEJIewRl7B8cD6Br2nrSulXfaE=;
 b=YUJ7yImpuQT51Dl3+/Km1M7nonS1lGUOLYdnx1AUCuP9h+lCLFshI2V1rZwbVYyOHtlvcqDUTaFZctXg07FcNFQNMq+h6+wesf7tkTkHlnMpEB1QO2bj9aBPrjQ74y/r2nMm4JlxFebcW5FzoSBiDS/Xy7Dbjtog1wLOaOxdvv1KU/LFDrLDeWgxicLO/n3T8bzpwlkw+s9sBQlN1ahm1g9W781kipAyJXMuxBAg2p52Ud3Zv9b8Bkx6dWsiUy5/crMwnHAlkOtFTJOgeA52WeAf7cRtjfTnpwxjyRxRSAN7cMhjMY3WnmcIK8eKpIwfsgbo5LUqAav/G3bOLpFuMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb00ELtRFpQJt2mmJoEJIewRl7B8cD6Br2nrSulXfaE=;
 b=lbGUI9jiufAzZsEZvwKiGxzLMfI8gx4Dmb2to6sxysF9kF7Ag4dLgI9tOslKsdfIstL2q1KhwTfmLGfDmxr+FT0DHQ7BHUv7pG66ZAte8s8YWpTy9xbBGfFZqcz/gMYC9hagVpK68L+urYn2IZOILtO7vN8KzLnYGr8AehtFL3U=
Received: from SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19)
 by BN6PR02MB3380.namprd02.prod.outlook.com (2603:10b6:405:62::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 11 Sep
 2020 08:03:34 +0000
Received: from SN1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:20:cafe::11) by SN1PR12CA0048.outlook.office365.com
 (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 11 Sep 2020 08:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT013.mail.protection.outlook.com (10.152.72.98) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 08:03:34
 +0000
Received: from [149.199.38.66] (port=35781 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kGe1t-0008Eo-HI; Fri, 11 Sep 2020 01:03:33 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kGe1t-0004tH-T3; Fri, 11 Sep 2020 01:03:33 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kGe1k-0004rz-Am; Fri, 11 Sep 2020 01:03:24 -0700
Date: Fri, 11 Sep 2020 10:03:18 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v5 7/7] Versal: Connect DWC3 controller with virt-versal
Message-ID: <20200911080318.GQ14249@toto>
References: <1599719469-24062-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1599719469-24062-8-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599719469-24062-8-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e203f721-2d39-460d-48ee-08d856292e42
X-MS-TrafficTypeDiagnostic: BN6PR02MB3380:
X-Microsoft-Antispam-PRVS: <BN6PR02MB338048C9F9E24A05D7D30ED8C2240@BN6PR02MB3380.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:224;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Tcg5N9CFIstNZATm0/9NMIOvHHwqY+XZIJy1FCtHuIrRgX91x89nbGmFxb0utJk7hX2bFA8VdoW3qx3rbQj/lkV9psARuK6EANcq3pxfmR4H5i5qJpLn3+z4s6ROa+e09vwEykPjHxlPWaZeabnqXdiZQLvPOlt8JuO5LqGmFG0lWCTvmrhEJWL/Dr4Rtn6kVGvizNHyHrOCKW4gblICtbouZq8Xoi12vyntzLSsb0jSZs52wErKvfPNfRqZqkWODE9aUP/rROVBgbcBUzseYQnydyFDurlg96McLOdvkxW0jw1k9B8S0eot/y9zQHtP7RGFRxB6vhJ+AtNdcaX8FYUwfkPL8Adc2l+P4ukja5uyFgjRXVzwe5r40SIY0FQoD69qUczLBtQ23vwKtrbww==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(39860400002)(136003)(376002)(346002)(396003)(46966005)(82740400003)(33656002)(47076004)(81166007)(5660300002)(356005)(9686003)(70586007)(70206006)(33716001)(82310400003)(6862004)(4326008)(1076003)(2906002)(83380400001)(9786002)(6666004)(26005)(8936002)(54906003)(7416002)(186003)(8676002)(336012)(426003)(478600001)(316002)(6636002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 08:03:34.2529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e203f721-2d39-460d-48ee-08d856292e42
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3380
Received-SPF: pass client-ip=40.107.75.73; envelope-from=edgar@xilinx.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 04:03:35
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
 Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?'Marc-Andr=E9?= Lureau' <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 'Philippe =?iso-8859-1?Q?Mathieu-Daud=E9'?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 12:01:09PM +0530, Sai Pavan Boddu wrote:
> From: Vikram Garhwal <fnu.vikram@xilinx.com>
> 
> Connect dwc3 controller and usb2-reg module to virt-versal.
> Configure it as dual port host controller.
> 
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/arm/xlnx-versal-virt.c    | 59 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/xlnx-versal.c         | 38 ++++++++++++++++++++++++++++
>  include/hw/arm/xlnx-versal.h | 14 +++++++++++
>  3 files changed, 111 insertions(+)
> 
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 4b3152e..398693d 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -39,6 +39,8 @@ typedef struct VersalVirt {
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
> @@ -148,6 +152,60 @@ static void fdt_add_timer_nodes(VersalVirt *s)
>                       compat, sizeof(compat));
>  }
>  
> +static void fdt_add_usb_xhci_nodes(VersalVirt *s)
> +{
> +    const char clocknames[] = "bus_clk\0ref_clk";
> +    char *usb2name = g_strdup_printf("/usb@ff9d0000");

This string should be generated using the MM_USB2_REGS macro.

> +    const char dwcCompat[] = "xlnx,versal-dwc3";

You can use compat[] as we do in other places here.


> +    qemu_fdt_add_subnode(s->fdt, usb2name);
> +    qemu_fdt_setprop(s->fdt, usb2name, "compatible",
> +                         dwcCompat, sizeof(dwcCompat));
> +    qemu_fdt_setprop_sized_cells(s->fdt, usb2name, "reg",
> +                                     2, MM_USB2_REGS, 2, 0x100);

0x100 as size looks small, you've added a macro for it, why not use it?


> +    qemu_fdt_setprop(s->fdt, usb2name, "clock-names",
> +                         clocknames, sizeof(clocknames));
> +    qemu_fdt_setprop_cells(s->fdt, usb2name, "clocks",
> +                               s->phandle.clk_25Mhz, s->phandle.clk_125Mhz);
> +    qemu_fdt_setprop(s->fdt, usb2name, "ranges", NULL, 0);
> +    qemu_fdt_setprop_cell(s->fdt, usb2name, "#address-cells", 2);
> +    qemu_fdt_setprop_cell(s->fdt, usb2name, "#size-cells", 2);
> +    qemu_fdt_setprop_cell(s->fdt, usb2name, "phandle", s->phandle.usb);
> +    g_free(usb2name);
> +
> +    {
> +        uint64_t addr = MM_USB_XHCI_0;
> +        unsigned int irq = VERSAL_USB0_IRQ_0;

You're only using irq once? why not just use VERSAL_USB0_IRQ_0 directly?

> +        const char compat[] = "snps,dwc3";
> +        const char intName[] = "dwc_usb3";

I'd prefer interrupt_names[] or irq_names[].


> +        uint32_t frameLen = 0x20;

Can't you just directly use 0x20 when setting the prop?

> +
> +        char *name = g_strdup_printf("/usb@ff9d0000/dwc3@%" PRIx64, addr);

We shouldn't hard-code ff9d0000 here.
It also looks weird/wrong to have dwc3 as a subnode of usb like that.


> +        qemu_fdt_add_subnode(s->fdt, name);
> +        qemu_fdt_setprop(s->fdt, name, "compatible",
> +                         compat, sizeof(compat));
> +        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> +                                     2, addr, 2, MM_USB_XHCI_SIZE_0);
> +        qemu_fdt_setprop(s->fdt, name, "interrupt-names",
> +                         intName, sizeof(intName));
> +        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> +                                   GIC_FDT_IRQ_TYPE_SPI, irq,
> +                                   GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +        qemu_fdt_setprop_cell(s->fdt, name,
> +                              "snps,quirk-frame-length-adjustment",
> +                               frameLen);
> +        qemu_fdt_setprop_cells(s->fdt, name, "#stream-id-cells", 1);
> +        qemu_fdt_setprop_string(s->fdt, name, "dr_mode", "host");
> +        qemu_fdt_setprop_string(s->fdt, name, "phy-names", "usb3-phy");
> +        qemu_fdt_setprop(s->fdt, name, "snps,dis_u2_susphy_quirk", NULL, 0);
> +        qemu_fdt_setprop(s->fdt, name, "snps,dis_u3_susphy_quirk", NULL, 0);
> +        qemu_fdt_setprop(s->fdt, name, "snps,refclk_fladj", NULL, 0);
> +        qemu_fdt_setprop(s->fdt, name, "snps,mask_phy_reset", NULL, 0);
> +        qemu_fdt_setprop(s->fdt, name, "snps,usb3_lpm_capable", NULL, 0);
> +        qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
> +        qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
> +        g_free(name);
> +    }
> +}
>  static void fdt_add_uart_nodes(VersalVirt *s)
>  {
>      uint64_t addrs[] = { MM_UART1, MM_UART0 };
> @@ -515,6 +573,7 @@ static void versal_virt_init(MachineState *machine)
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
>      fdt_add_zdma_nodes(s);
> +    fdt_add_usb_xhci_nodes(s);
>      fdt_add_sd_nodes(s);
>      fdt_add_rtc_node(s);
>      fdt_add_cpu_nodes(s, psci_conduit);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index e3aa4bd..9b241de 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -145,6 +145,43 @@ static void versal_create_uarts(Versal *s, qemu_irq *pic)
>      }
>  }
>  
> +static void versal_create_usbs(Versal *s, qemu_irq *pic)
> +{
> +    char *name = g_strdup_printf("dwc3-0");

There's no need to allocate and format a constant string...


> +    DeviceState *dev, *xhci_dev;
> +    MemoryRegion *mr;
> +
> +    object_initialize_child(OBJECT(s), name, &s->fpd.iou.dwc3,
> +                            TYPE_USB_DWC3);
> +    dev = DEVICE(&s->fpd.iou.dwc3);
> +    xhci_dev = DEVICE(&s->fpd.iou.dwc3.sysbus_xhci);
> +
> +    object_property_set_link(OBJECT(xhci_dev), "dma", OBJECT(&s->mr_ps),
> +                             &error_abort);
> +    qdev_prop_set_uint32(xhci_dev, "intrs", 1);
> +    qdev_prop_set_uint32(xhci_dev, "slots", 2);
> +
> +    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_add_subregion(&s->mr_ps, MM_USB_XHCI_0 + 0xC100 , mr);
> +    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(xhci_dev), 0);
> +    memory_region_add_subregion(&s->mr_ps, MM_USB_XHCI_0, mr);
> +
> +    sysbus_connect_irq(SYS_BUS_DEVICE(xhci_dev), 0, pic[VERSAL_USB0_IRQ_0]);
> +    g_free(name);
> +
> +    name = g_strdup_printf("usb2reg-0");

This one too.

> +    object_initialize_child(OBJECT(s), name, &s->fpd.iou.Usb2Regs,
> +                           "xlnx.usb2_regs");
> +    dev = DEVICE(&s->fpd.iou.Usb2Regs);
> +    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_add_subregion(&s->mr_ps, MM_USB2_REGS, mr);
> +    g_free(name);
> +}
> +
>  static void versal_create_gems(Versal *s, qemu_irq *pic)
>  {
>      int i;
> @@ -332,6 +369,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      versal_create_apu_cpus(s);
>      versal_create_apu_gic(s, pic);
>      versal_create_uarts(s, pic);
> +    versal_create_usbs(s, pic);
>      versal_create_gems(s, pic);
>      versal_create_admas(s, pic);
>      versal_create_sds(s, pic);
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 9c9f47b..e19cfd5 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -20,6 +20,8 @@
>  #include "hw/dma/xlnx-zdma.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
> +#include "hw/usb/hcd-dwc3.h"
> +#include "hw/misc/xlnx-versal-usb2-regs.h"
>  
>  #define TYPE_XLNX_VERSAL "xlnx-versal"
>  #define XLNX_VERSAL(obj) OBJECT_CHECK(Versal, (obj), TYPE_XLNX_VERSAL)
> @@ -42,6 +44,11 @@ typedef struct Versal {
>              ARMCPU cpu[XLNX_VERSAL_NR_ACPUS];
>              GICv3State gic;
>          } apu;
> +
> +        struct {
> +            USBDWC3 dwc3;
> +            XlnxUsb2Regs Usb2Regs;
> +        } iou;
>      } fpd;
>  
>      MemoryRegion mr_ps;
> @@ -87,6 +94,7 @@ typedef struct Versal {
>  
>  #define VERSAL_UART0_IRQ_0         18
>  #define VERSAL_UART1_IRQ_0         19
> +#define VERSAL_USB0_IRQ_0          22
>  #define VERSAL_GEM0_IRQ_0          56
>  #define VERSAL_GEM0_WAKE_IRQ_0     57
>  #define VERSAL_GEM1_IRQ_0          58
> @@ -124,6 +132,12 @@ typedef struct Versal {
>  #define MM_OCM                      0xfffc0000U
>  #define MM_OCM_SIZE                 0x40000
>  
> +#define MM_USB2_REGS                0xFF9D0000
> +#define MM_USB2_SIZE                0x10000
> +
> +#define MM_USB_XHCI_0               0xFE200000
> +#define MM_USB_XHCI_SIZE_0          0x10000
> +
>  #define MM_TOP_DDR                  0x0
>  #define MM_TOP_DDR_SIZE             0x80000000U
>  #define MM_TOP_DDR_2                0x800000000ULL
> -- 
> 2.7.4
> 

