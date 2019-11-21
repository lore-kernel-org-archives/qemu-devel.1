Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338DAC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DA920674
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aM0HMY6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DA920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXoOW-0000Pi-ND
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 10:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar@xilinx.com>) id 1iXoNf-0008Fs-Q8
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar@xilinx.com>) id 1iXoNe-0001Np-N5
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:28:27 -0500
Received: from mail-eopbgr700055.outbound.protection.outlook.com
 ([40.107.70.55]:48833 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <edgar@xilinx.com>)
 id 1iXoNb-0001HI-Bv; Thu, 21 Nov 2019 10:28:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiRD5Mf2V5RNeEvwRMGxIQYXlcW0CxIuPMfwq/ymDJVW26Y+zcT68JdTKxLcLKPuLMhAHx/dSznYOmb/mz7HWrfZfLUo1FjKtq3wvu1zw6k6CI9AfIx4SRWgp9cyP65Q/MpW7LSG9RIrnI6+XLPNveDQmdUZQO0+PT3XYz9GktBd2crp6Gdtg4HlfGiAlmkorkJkU66htsliAdK+kaFSllBupfDT70pqDijkQHROgS55pIJTOCgKxRYeAh9B8z6jFkyZUhMKRnS9IpiHyqy2801ZWyAs+HGERmzQBHVMKa/6Gt/7cX24eWp61AdtMqBlRFV2oMlMwqCS0Bbvo6wJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBmFkQohG3mybFdlNBb6tlwPT3Vodjw8o+w1QR+Ej3U=;
 b=SUpPgOIMfPu5jE2yHFbDNkCRRCHIc1s3J+gghoTwKvja9umrYGHiKKj5ar8Un0LZ5AyctQpI2/xrEe8Skg9ehXo0GGtGpPP+38gVgihEKUZUTraRvgkTCOStvr1t3KL/jUZpSw8FgQyOY9UACb3RgzmwRry0YDhkQYbs5HPXYDT72FuPEW0qyR+q6bQDzmDnPU5w201fYRf2k//Ycg2EOmRdJEBbevM4zf/TTYI7v/u/h8e/9K2ETSryut4uEqdBxslJwfK2PZlBE1taP8Fj3K65Olu6B/GWXidWX3nLBiVtE0e+3FFMz/pjRGDCEUczM+i6aZWIbgp6JN1HAvu3ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBmFkQohG3mybFdlNBb6tlwPT3Vodjw8o+w1QR+Ej3U=;
 b=aM0HMY6BQ/3dgeNamNxcZttUpsIZGpIolSK/0p0dyLwibXgoDXVDhd+oJ1sQj0OmDYMm1/31UWgkskzeCO5hOXaCbyQB7F/+EyM6MmQFfxXd+9lkVTxGCukYC7QVm0RzMsV6MELslf2uYAg40ib8ZhxnX5uF21ClTQyKfM7K8GQ=
Received: from BN7PR02CA0015.namprd02.prod.outlook.com (2603:10b6:408:20::28)
 by CY4PR02MB3285.namprd02.prod.outlook.com (2603:10b6:910:7c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Thu, 21 Nov
 2019 15:28:20 +0000
Received: from SN1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BN7PR02CA0015.outlook.office365.com
 (2603:10b6:408:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Thu, 21 Nov 2019 15:28:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT010.mail.protection.outlook.com (10.152.72.86) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Thu, 21 Nov 2019 15:28:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1iXoNY-0001GT-0f; Thu, 21 Nov 2019 07:28:20 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1iXoNS-0002GP-O0; Thu, 21 Nov 2019 07:28:14 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xALFS4VV032597; 
 Thu, 21 Nov 2019 07:28:04 -0800
Received: from [10.71.117.67] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1iXoNH-0002FC-ND; Thu, 21 Nov 2019 07:28:03 -0800
Date: Thu, 21 Nov 2019 16:28:03 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: peter.maydell@linaro.org
Subject: Re: [PATCH v1 1/1] hw/arm: versal: Add the CRP as unimplemented
Message-ID: <20191121152803.GB31462@toto>
References: <20191115154734.26449-1-edgar.iglesias@gmail.com>
 <20191115154734.26449-2-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115154734.26449-2-edgar.iglesias@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(7916004)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(6246003)(76176011)(36386004)(336012)(2361001)(2351001)(33716001)(26005)(14444005)(57986006)(6916009)(76506006)(186003)(356004)(70586007)(70206006)(33656002)(9686003)(107886003)(316002)(305945005)(229853002)(16586007)(4326008)(58126008)(81156014)(8676002)(9786002)(50466002)(8936002)(106002)(81166006)(478600001)(2906002)(7416002)(23726003)(5660300002)(11346002)(426003)(446003)(1076003)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR02MB3285; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 302d44a7-4880-4107-d75d-08d76e9770a8
X-MS-TrafficTypeDiagnostic: CY4PR02MB3285:
X-Microsoft-Antispam-PRVS: <CY4PR02MB3285C5FC0A42F86EE8AB26B9C24E0@CY4PR02MB3285.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 0228DDDDD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnVPMAM3VIaeBRQ0ileVyxfvha7x/Xna+JLqzw5X0FpPKI/ABonlfqhFRQtbJIFGvm6KfHL0804XQ0pE19L4CTOmzVhcQ5tGkz3D45YsKp3HNpCRc5cn3tOGR7JlIVWpR98Z2xn3E4ENUdZHvkpG8zT8db+Q89jBsXeKH/ZNBNKQl6gw3tYi95CGsIV1XLatRx1nkOq7YbSQbjKtfS+hsNBI64p3SaJyZOQ5azYgcYgQkBTHTakExFPrAWDabYo6OvaNaz/SnUslKM+AWfdluKQCaAwJmKreJHA4S55T8aQS9jKhs00vuC0ZVACyMoET6T5r4PfgrcwJKdxq9Yuz/8M7e2u6EfFjUM8pcJEEWQDFMVZfq7yYXI/+VG6B2NCWpSDuAIzWV+2CSeh8pcqdiyMwSAF6vV2D5AjL4ZrbseWJTLA7LziSXW3HV8L+t185
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 15:28:20.4324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 302d44a7-4880-4107-d75d-08d76e9770a8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3285
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.55
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

Can we consider this patch for 4.2?

Thanks,
Edgar


On Fri, Nov 15, 2019 at 04:47:34PM +0100, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add the CRP as unimplemented thus avoiding bus errors when
> guests access these registers.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  hw/arm/xlnx-versal.c         | 2 ++
>  include/hw/arm/xlnx-versal.h | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 98163eb1aa..8b3d8d85b8 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -257,6 +257,8 @@ static void versal_unimp(Versal *s)
>                          MM_CRL, MM_CRL_SIZE);
>      versal_unimp_area(s, "crf", &s->mr_ps,
>                          MM_FPD_CRF, MM_FPD_CRF_SIZE);
> +    versal_unimp_area(s, "crp", &s->mr_ps,
> +                        MM_PMC_CRP, MM_PMC_CRP_SIZE);
>      versal_unimp_area(s, "iou-scntr", &s->mr_ps,
>                          MM_IOU_SCNTR, MM_IOU_SCNTR_SIZE);
>      versal_unimp_area(s, "iou-scntr-seucre", &s->mr_ps,
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 14405c1465..d844c4ffe4 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -119,4 +119,7 @@ typedef struct Versal {
>  #define MM_IOU_SCNTRS_SIZE          0x10000
>  #define MM_FPD_CRF                  0xfd1a0000U
>  #define MM_FPD_CRF_SIZE             0x140000
> +
> +#define MM_PMC_CRP                  0xf1260000U
> +#define MM_PMC_CRP_SIZE             0x10000
>  #endif
> -- 
> 2.20.1
> 

