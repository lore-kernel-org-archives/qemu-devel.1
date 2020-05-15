Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44705C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061F1206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jnYbX/qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061F1206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZdIV-0003nh-6R
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 12:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <figlesia@xilinx.com>)
 id 1jZbcA-0007Dw-VW; Fri, 15 May 2020 10:47:07 -0400
Received: from mail-dm6nam11on2052.outbound.protection.outlook.com
 ([40.107.223.52]:19009 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <figlesia@xilinx.com>)
 id 1jZbc9-0001VS-RC; Fri, 15 May 2020 10:47:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZ1/ypWSRwDt/O+9WLDiW8XetwqzOU2RUh+NXXiCzIJ0Vkk2dT8ju9x6MvGe52k1wg0aILGO3SMThD/WaOIXQOQqvZZ7tGIQxpFyGkHfqQduasKa2Zl15tmom9co1K6v6ulEEwolqKBHeige/srw/HvetqyZJeRBSGbihGJSjwWEXdr5IM87DvYu0gA36iNodLLyEs6elRiQZU50SwVE5pCehJcOf4BiLX9WdQSjOx1AzqwQKY1BDuMxRfgwnQn+oXsVVeP7P61stufL7RqOgu+NSlNBQXAd+hgcBs5Vwax8ABJ74ZNKKBTGHsDmTHzE4rmWl3d3tb9P8tTxbGL26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaF4aErxZOLhHIZA99bNHgk3H840c/v7sjBrBE+7Dh8=;
 b=Hs9G6U9L4HPWu7QS173IRU9nTzXqwcz2pZXNA/xuLKsStbFJ0J3xZUIKbXBTzKyyFMHbstT4DW8sLWwzvUrlRBqVgOiKMbnhtTxpBjdlIFS/qvbgZvA83mOdP2Jv12UY+JJr0rs4jW7HeGbhZ3kw0T7q44lCrnofFaStQUlFl3majfjI7MgpBYoikpJu1ad1HQeTZpXiC/D3iG2XaVy6DF5kDDFNBPKV6tJdxlB6v5iD/dQcm+DkzeQS74tIt6xBbcjhxoPYkaAdyCQ9VwL2Ag7mgBSBIW+F7UBjhyr52uTtqsFuYBCoqob71bMQlCnPQr2V8UbPlND9pyBOYM5KOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaF4aErxZOLhHIZA99bNHgk3H840c/v7sjBrBE+7Dh8=;
 b=jnYbX/qgu6E1aEfZ4T71VRW0GSykOzwhpFwauL1Q3mYfawDoCK28xoUhMnRiHMfE/CxEgl4fZ7NbVE+DUg7PVgKquIryv5HPWv2hkgDe3tmy22M7DePbflPA8JL0q+P+1bM0fihyv+OXHwqaLWEJjPaAuMPkBBJMN/2GthPWu2w=
Received: from CY4PR1201CA0004.namprd12.prod.outlook.com
 (2603:10b6:910:16::14) by SN4PR0201MB3455.namprd02.prod.outlook.com
 (2603:10b6:803:48::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 14:47:02 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:16:cafe::c5) by CY4PR1201CA0004.outlook.office365.com
 (2603:10b6:910:16::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend
 Transport; Fri, 15 May 2020 14:47:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server id 15.20.3000.19 via Frontend Transport; Fri, 15 May 2020 14:47:01
 +0000
Received: from [149.199.38.66] (port=52798 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <francisco.iglesias@xilinx.com>)
 id 1jZbbl-0005As-7S; Fri, 15 May 2020 07:46:41 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <francisco.iglesias@xilinx.com>)
 id 1jZbc5-0007ox-IM; Fri, 15 May 2020 07:47:01 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04FEkxk6029795; 
 Fri, 15 May 2020 07:46:59 -0700
Received: from [10.23.123.155] (helo=debian)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <francisco.iglesias@xilinx.com>)
 id 1jZbc3-0007oX-E0; Fri, 15 May 2020 07:46:59 -0700
Date: Fri, 15 May 2020 15:46:46 +0100
From: Francisco Iglesias <francisco.iglesias@xilinx.com>
To: Vikram Garhwal <fnu.vikram@xilinx.com>
Subject: Re: [PATCH v4 2/4] xlnx-zynqmp: Connect Xilinx ZynqMP CAN controllers
Message-ID: <20200515144645.whqbaho6cr734l25@debian>
References: <1589314552-1375-1-git-send-email-fnu.vikram@xilinx.com>
 <1589314552-1375-3-git-send-email-fnu.vikram@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589314552-1375-3-git-send-email-fnu.vikram@xilinx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(376002)(39860400002)(346002)(396003)(136003)(46966005)(33716001)(26005)(4326008)(6862004)(47076004)(44832011)(6636002)(9686003)(336012)(478600001)(82740400003)(426003)(6666004)(70586007)(54906003)(9786002)(70206006)(316002)(356005)(82310400002)(81166007)(1076003)(5660300002)(186003)(8936002)(9576002)(2906002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 680e04e0-034d-4872-8468-08d7f8ded3f0
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3455:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3455CA7682BB88D48663DB48ADBD0@SN4PR0201MB3455.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:204;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Um+LhaigIeFeD8ZX6fHkzAevrkUZOoSoOE/mLVe7LRKfNeD4AWAjmysJay+0zGdj8ejlH6K7VZi9BpitEKgZNVcMEjEiknXjYs7jGRnT73VlUrefDPSzejfIBHNw7gkZMwya8v9bEjIhICyF2Nzh98cMoAbAVLxqLFJUywDysI9qjRXjrkLjRs5tjF4iyuIw4Jw+ZjeKsU4djaHsi0w82RTcCJmQkdDfMmuPPnZIzLztY91SHMVHBsK5+RVHXIytfXKYIV2SLp5eYrVCOa+vS9XetBAYWw9rZqwZM0hIIXQxk7or7dfR9i1y/eDtcYO7nDHUcJlDkm/7/Ak6D+ayyeBu/j7xx8Abhea7rK9SNhyohu3fxCkG4bv/0UcisUoy3fFgXC9gQLjZoXSAoDgwle/C25AAK4bm2TbGiRb1BQwJgyJ8m0qSZYBE0f++dF/HiF4E1fx+B6+YoeyOi7vgHquwa0rl29tvYQba15FGmgkGXdvsAf+QbgROoeApOV8MPlfn7M5uH/2wS+jxqbypA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 14:47:01.8317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 680e04e0-034d-4872-8468-08d7f8ded3f0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3455
Received-SPF: pass client-ip=40.107.223.52; envelope-from=figlesia@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 10:47:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 15 May 2020 12:32:36 -0400
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 12, 2020 at 01:15:50PM -0700, Vikram Garhwal wrote:
> Connect CAN0 and CAN1 on the ZynqMP.
> 
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@xilinx.com>

> ---
>  hw/arm/xlnx-zynqmp.c         | 26 ++++++++++++++++++++++++++
>  include/hw/arm/xlnx-zynqmp.h |  3 +++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index b84d153..e5f0d9f 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -81,6 +81,14 @@ static const int uart_intr[XLNX_ZYNQMP_NUM_UARTS] = {
>      21, 22,
>  };
>  
> +static const uint64_t can_addr[XLNX_ZYNQMP_NUM_CAN] = {
> +    0xFF060000, 0xFF070000,
> +};
> +
> +static const int can_intr[XLNX_ZYNQMP_NUM_CAN] = {
> +    23, 24,
> +};
> +
>  static const uint64_t sdhci_addr[XLNX_ZYNQMP_NUM_SDHCI] = {
>      0xFF160000, 0xFF170000,
>  };
> @@ -254,6 +262,11 @@ static void xlnx_zynqmp_init(Object *obj)
>                                TYPE_CADENCE_UART);
>      }
>  
> +    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
> +        sysbus_init_child_obj(obj, "can[*]", &s->can[i], sizeof(s->can[i]),
> +                              TYPE_XLNX_ZYNQMP_CAN);
> +    }
> +
>      sysbus_init_child_obj(obj, "sata", &s->sata, sizeof(s->sata),
>                            TYPE_SYSBUS_AHCI);
>  
> @@ -508,6 +521,19 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>                             gic_spi[uart_intr[i]]);
>      }
>  
> +    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
> +        object_property_set_int(OBJECT(&s->can[i]), i, "ctrl-idx",
> +                                &error_abort);
> +        object_property_set_bool(OBJECT(&s->can[i]), true, "realized", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->can[i]), 0, can_addr[i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->can[i]), 0,
> +                           gic_spi[can_intr[i]]);
> +    }
> +
>      object_property_set_int(OBJECT(&s->sata), SATA_NUM_PORTS, "num-ports",
>                              &error_abort);
>      object_property_set_bool(OBJECT(&s->sata), true, "realized", &err);
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index 53076fa..5b32e98 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -22,6 +22,7 @@
>  #include "hw/intc/arm_gic.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/char/cadence_uart.h"
> +#include "hw/net/xlnx-zynqmp-can.h"
>  #include "hw/ide/ahci.h"
>  #include "hw/sd/sdhci.h"
>  #include "hw/ssi/xilinx_spips.h"
> @@ -41,6 +42,7 @@
>  #define XLNX_ZYNQMP_NUM_RPU_CPUS 2
>  #define XLNX_ZYNQMP_NUM_GEMS 4
>  #define XLNX_ZYNQMP_NUM_UARTS 2
> +#define XLNX_ZYNQMP_NUM_CAN 2
>  #define XLNX_ZYNQMP_NUM_SDHCI 2
>  #define XLNX_ZYNQMP_NUM_SPIS 2
>  #define XLNX_ZYNQMP_NUM_GDMA_CH 8
> @@ -92,6 +94,7 @@ typedef struct XlnxZynqMPState {
>  
>      CadenceGEMState gem[XLNX_ZYNQMP_NUM_GEMS];
>      CadenceUARTState uart[XLNX_ZYNQMP_NUM_UARTS];
> +    XlnxZynqMPCANState can[XLNX_ZYNQMP_NUM_CAN];
>      SysbusAHCIState sata;
>      SDHCIState sdhci[XLNX_ZYNQMP_NUM_SDHCI];
>      XilinxSPIPS spi[XLNX_ZYNQMP_NUM_SPIS];
> -- 
> 2.7.4
> 

