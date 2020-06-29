Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E1AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849B423CD4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="S6BV6dBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849B423CD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptGA-0004KR-Qj
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 08:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <figlesia@xilinx.com>)
 id 1jptEq-0003VR-6D; Mon, 29 Jun 2020 08:50:20 -0400
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com
 ([40.107.244.74]:6132 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <figlesia@xilinx.com>)
 id 1jptEj-0000j9-9y; Mon, 29 Jun 2020 08:50:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEY47C1rMnGqCN4z2zMJgCTGRPuEQrz9/3U8oCzf1WV00Do5pE4KrRGrENwAh1AwtLfryT+vh7fj6Rj6DEDa+bx8j1gTDlApvhJg3D/xffMFUb6yNb4xQ7Bjm7h6tirb+dsWkDziM2vfsO+jy4dP00gSqKeDsP27p6EM/ZoVTXJ7PgTNpgmfM3KtwJNjZAj0t9g5zUz81aRh9o2nmQKfoUKqMkmMYTquzQ2968VpZWPaATYqO96fDN/pgoYZmD8JHA99tOX7uR4ZTu+ZB2tGhRf8B9GrNq1e9oOzDXuRXdB2kE+wwm44xslDSuUNtbb+A6WVCN3lBgbI8J5t92RJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuuOnrXe2Ol13EKBQonTMB+y8UVB7RBL558rtFVOvM8=;
 b=NEe90IhbsXvjN8fSoyM7G+PYp8jSopKh1/J6PMHijfZEGAy8zcexv3mAVt8a3URqo7VXvqLiY2fg38HHfNlhwSQGaR5smEcfGET3BXeAnVZQBGgS2NuiWP604hWI4S11xUNul2Y71CGjYI2lsh91bRNYb7+bZ84EEf5wCHP3ca/tE7IgQUUfvArsYZWN22QFiouQPYDIcmNPuI+U65V6qpMgkOgbCtCnwcESukljhJQwyh0oTgBTRDL9if5toS4LFetLLX34u5vvcdLv2lv8yiwjdRffhSF456iWcm4r4jwyP9pOxfVhZVKHksUTSTZEF77Zw4hOvbX+MQBJCEZEmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuuOnrXe2Ol13EKBQonTMB+y8UVB7RBL558rtFVOvM8=;
 b=S6BV6dBXitzjsCCzx75RsIKLwleUIrOTfSb3dpB65DQSHx7zHjFnItDXXwOIs+K7qynRpLVuqHqWVkBj+JtkbKs/Uo7r7FCniWfATXk1JTOHYI7nwlknjoWpBc1P27U4FCrYZnNryOe4VY8uf2WoS05zBaoCmOjhyh8Wr7WNdQ0=
Received: from SN6PR04CA0085.namprd04.prod.outlook.com (2603:10b6:805:f2::26)
 by CY4PR02MB2326.namprd02.prod.outlook.com (2603:10b6:903:b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Mon, 29 Jun
 2020 12:50:07 +0000
Received: from SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:f2:cafe::a1) by SN6PR04CA0085.outlook.office365.com
 (2603:10b6:805:f2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24 via Frontend
 Transport; Mon, 29 Jun 2020 12:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT011.mail.protection.outlook.com (10.152.72.82) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Mon, 29 Jun 2020 12:50:07
 +0000
Received: from [149.199.38.66] (port=59598 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <francisco.iglesias@xilinx.com>)
 id 1jptDK-0002Vy-4o; Mon, 29 Jun 2020 05:48:46 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <francisco.iglesias@xilinx.com>)
 id 1jptEc-0002sG-UC; Mon, 29 Jun 2020 05:50:06 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05TCo0WB030568; 
 Mon, 29 Jun 2020 05:50:00 -0700
Received: from [10.23.120.126] (helo=debian)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <francisco.iglesias@xilinx.com>)
 id 1jptEW-0002aj-FT; Mon, 29 Jun 2020 05:50:00 -0700
Date: Mon, 29 Jun 2020 13:49:58 +0100
From: Francisco Iglesias <francisco.iglesias@xilinx.com>
To: Vikram Garhwal <fnu.vikram@xilinx.com>
Subject: Re: [PATCH v7 2/4] xlnx-zynqmp: Connect Xilinx ZynqMP CAN controllers
Message-ID: <20200629124956.ykebklynrx5vdyha@debian>
References: <1593113607-321118-1-git-send-email-fnu.vikram@xilinx.com>
 <1593113607-321118-3-git-send-email-fnu.vikram@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1593113607-321118-3-git-send-email-fnu.vikram@xilinx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(346002)(376002)(396003)(136003)(46966005)(44832011)(9576002)(336012)(426003)(9686003)(33716001)(54906003)(5660300002)(47076004)(356005)(8936002)(478600001)(8676002)(82740400003)(81166007)(9786002)(82310400002)(26005)(1076003)(6636002)(316002)(70206006)(6862004)(70586007)(2906002)(4326008)(186003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3893ba4-b053-4de5-c1f3-08d81c2af381
X-MS-TrafficTypeDiagnostic: CY4PR02MB2326:
X-Microsoft-Antispam-PRVS: <CY4PR02MB23267B45E60C99D8CEF408E6AD6E0@CY4PR02MB2326.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:219;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +voBL7RMe2OaCswx0K+FLh/0yPDSzAW2hLoRWFK12aKruHVsRZrsTmJb906hDRVM9Aq8wnAmeGscWl2WNKuCTQwvMMEpu12yvm6CuVPfV+I2cGP92co77B6lJRH5B4b6uWIdliEhkT4jBm24htAQMampw/Cyvoml8czbGYfuosdzdXLmz3z9r/EwRc9UsMtDVjHTXeyA2GSqBQ5bpu7wAq5n52H59hNFaQ9bjQyg6TcclwJTjk8DH3KEUZR7+V2kVEhdFNRxO3CSxMVZ9m3IVJwszS6SHYUJiTcYAQGqxKsk7I/vXcKeSBSckb2wgEGG3mbhZbJDXNPN7W/FdXqn+WAcEiVoid+koL3hrOgbvW5ryYyHD2eutzcLphcGO4QqlmHPLAWgr2vdnQLN2DDZhQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 12:50:07.2426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3893ba4-b053-4de5-c1f3-08d81c2af381
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2326
Received-SPF: pass client-ip=40.107.244.74; envelope-from=figlesia@xilinx.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 08:50:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Vikram,

On Thu, Jun 25, 2020 at 12:33:25PM -0700, Vikram Garhwal wrote:
> Connect CAN0 and CAN1 on the ZynqMP.
> 
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> ---
>  hw/arm/xlnx-zynqmp.c         | 28 ++++++++++++++++++++++++++++
>  include/hw/arm/xlnx-zynqmp.h |  4 ++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 1de9d4a..3f93524 100644
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
> @@ -247,6 +255,11 @@ static void xlnx_zynqmp_init(Object *obj)
>                                  TYPE_CADENCE_UART);
>      }
>  
> +    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
> +        object_initialize_child(obj, "can[*]", &s->can[i],
> +                              TYPE_XLNX_ZYNQMP_CAN);

Above line needs a minor indentation fix (a couple of extra whitespaces),
after adding those:

Reviewed-by: Francisco Iglesias <francisco.iglesias@xilinx.com>

Best regards,
Francisco Iglesias

> +    }
> +
>      object_initialize_child(obj, "sata", &s->sata, TYPE_SYSBUS_AHCI);
>  
>      for (i = 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
> @@ -492,6 +505,21 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>                             gic_spi[uart_intr[i]]);
>      }
>  
> +    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
> +        object_property_set_int(OBJECT(&s->can[i]), i, "ctrl-idx",
> +                                &error_abort);
> +        object_property_set_int(OBJECT(&s->can[i]), XLNX_ZYNQMP_CAN_REF_CLK,
> +                                "ext_clk_freq", &error_abort);
> +        sysbus_realize(SYS_BUS_DEVICE(&s->can[i]), &err);
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
>      sysbus_realize(SYS_BUS_DEVICE(&s->sata), &err);
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index 53076fa..dcb88e0 100644
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
> @@ -41,6 +42,8 @@
>  #define XLNX_ZYNQMP_NUM_RPU_CPUS 2
>  #define XLNX_ZYNQMP_NUM_GEMS 4
>  #define XLNX_ZYNQMP_NUM_UARTS 2
> +#define XLNX_ZYNQMP_NUM_CAN 2
> +#define XLNX_ZYNQMP_CAN_REF_CLK (24 * 1000 * 1000)
>  #define XLNX_ZYNQMP_NUM_SDHCI 2
>  #define XLNX_ZYNQMP_NUM_SPIS 2
>  #define XLNX_ZYNQMP_NUM_GDMA_CH 8
> @@ -92,6 +95,7 @@ typedef struct XlnxZynqMPState {
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

