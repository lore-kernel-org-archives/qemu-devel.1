Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3463C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 12:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D7A207DA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 12:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="L//8R8eH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D7A207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6CL4-000335-VK
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 08:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1k6CJU-0001Wd-OM; Thu, 13 Aug 2020 08:26:33 -0400
Received: from mail-co1nam11on2041.outbound.protection.outlook.com
 ([40.107.220.41]:7744 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1k6CJS-0003FK-1W; Thu, 13 Aug 2020 08:26:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koOm8S2/TNiKq0ScS9+3kMSUmDkwPOZWEsRJGWVvtBQ87YBI//rq9O0+HKT34rVVZ/WyAN1xYDJtgJGFHwphzFLdhLZ6hyWZUKzEfmc5sDfRAciQ45aQVxfhRg0TMbfL1R8JUhy3yjpLmpq53ISJYjPdqLIXIdsDxt5M/CYw9KotbzElhe2Y4QZ0ZQcVWScrSc53k5TCivY7SOQXAQUzBZKIwW8A02jtL+bXPlsWdJb7WanX5FFmKMe+yvRa1hb6P9AudBpPo+/WLEIirUDammlD1SOM1uCSMcpl/84xqdeOhY3FHrsuUksl47koJ0Q2KZ8q3yp3uHsyYN18HYdNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KxQmAVENLcL9efUf5d27Gs12muivbwo/rAejyu1Wac=;
 b=UhC2MKxPFVG2+wM1wv3xasarsJJi9b3J0FVyoCFwrQ4wNr+uOS6PkEv2nMSbx2R5okrku7ZmXYaDoGNbsIeUPzFOpR1WHlbWxOMeqmcviv9+lkaotsrRAbvN8y7IwHWAXfxEHjA+lrqELS9cLieYsg5hYTH585v8QNOpJkyXGFGGgf2nE4XkjYSydh1ubz1F6k1EJ6ylXpRf8BNE3xTGkjiBevTNSruYWQfIJkAeJbkRY13lSiPP/GkIZUwvxUPdSzQ7aOMNmGPikwunf5SBTECQR+iZ6OlCHxXNVQ+VQNz4cpzdh1QhAMCmKYhT+O5nvyRbQM3is59o131FAVzjkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=amsat.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KxQmAVENLcL9efUf5d27Gs12muivbwo/rAejyu1Wac=;
 b=L//8R8eHKlK9QIHW/ua3taGoEsB5u4iQogmu+qzn/lzqlEjMS41G53w5lbmCA98JFLsccDJaXkYcNADpGu4ev85X/Taq6mw2xR/1SbqhCeBs2djAkWjhvof+fjQMxqBu8Sf46teWm4OjOmLB6Fh+Vd+J8E28XNbIx2Wd5GVoHp8=
Received: from SA0PR11CA0074.namprd11.prod.outlook.com (2603:10b6:806:d2::19)
 by BN7PR02MB5170.namprd02.prod.outlook.com (2603:10b6:408:23::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 13 Aug
 2020 12:26:15 +0000
Received: from SN1NAM02FT0052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d2:cafe::24) by SA0PR11CA0074.outlook.office365.com
 (2603:10b6:806:d2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Thu, 13 Aug 2020 12:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT0052.mail.protection.outlook.com (10.97.5.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3283.16 via Frontend Transport; Thu, 13 Aug 2020 12:26:14 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 13 Aug 2020 13:26:13 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 13 Aug 2020 13:26:13 +0100
Received: from [10.71.119.128] (port=53525 helo=localhost)
 by smtp.xilinx.com with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1k6CJA-0001wM-Hh; Thu, 13 Aug 2020 13:26:13 +0100
Date: Thu, 13 Aug 2020 14:26:12 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH] target/arm: Clarify HCR_EL2 ARMCPRegInfo type
Message-ID: <20200813122612.GJ31713@toto>
References: <20200812111223.7787-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200812111223.7787-1-f4bug@amsat.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46fef602-7ba5-4644-5d6d-08d83f841271
X-MS-TrafficTypeDiagnostic: BN7PR02MB5170:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5170B4B9B3FC878970C898BBC2430@BN7PR02MB5170.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:149.199.80.198; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xir-pvapexch01.xlnx.xilinx.com;
 PTR:unknown-80-198.xilinx.com; CAT:NONE;
 SFS:(7916004)(136003)(396003)(376002)(39860400002)(346002)(46966005)(316002)(356005)(7636003)(54906003)(26005)(1076003)(4326008)(36906005)(70586007)(336012)(82740400003)(8936002)(33656002)(5660300002)(186003)(70206006)(82310400002)(47076004)(9686003)(2906002)(8676002)(33716001)(478600001)(6916009)(9786002)(83380400001)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 12:26:14.7878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fef602-7ba5-4644-5d6d-08d83f841271
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.80.198];
 Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5170
Received-SPF: pass client-ip=40.107.220.41; envelope-from=edgar@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 08:26:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 12, 2020 at 01:12:23PM +0200, Philippe Mathieu-Daudé wrote:
> In commit ce4afed839 ("target/arm: Implement AArch32 HCR and HCR2")
> the HCR_EL2 register has been changed from type NO_RAW (no underlying
> state and does not support raw access for state saving/loading) to
> type CONST (TCG can assume the value to be constant), removing the
> read/write accessors.
> We forgot to remove the previous type ARM_CP_NO_RAW. This is not
> really a problem since the field is overwritten. However it makes
> code review confuse, so remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  target/arm/helper.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 455c92b891..9aeb8ebfa9 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5105,7 +5105,6 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
>        .access = PL2_RW,
>        .readfn = arm_cp_read_zero, .writefn = arm_cp_write_ignore },
>      { .name = "HCR_EL2", .state = ARM_CP_STATE_BOTH,
> -      .type = ARM_CP_NO_RAW,
>        .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
>        .access = PL2_RW,
>        .type = ARM_CP_CONST, .resetvalue = 0 },
> -- 
> 2.21.3
> 

