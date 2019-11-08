Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2414C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2642245A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="C1+vn0pT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2642245A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT3Y8-0007aE-L2
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar@xilinx.com>) id 1iT3W7-0005Ek-M8
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar@xilinx.com>) id 1iT3W6-0005Fn-5Y
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:37:31 -0500
Received: from mail-eopbgr790051.outbound.protection.outlook.com
 ([40.107.79.51]:34544 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <edgar@xilinx.com>) id 1iT3W5-0005DL-O7
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:37:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4sziKGcd1Gw0IDfsq3txJvNXoJYByt1oBXDOGMuwOla5y40xstcYJdg6JzrYy24IRRbJyIRyeGClhXG7H2rz/OeqdLqtlr14iOyZWQp3dChbKvbvsex36egjef2Bdf1IVyFfkcC3a7tmbGWJr4P1t1pQ36myyQ9UH4O0207F4U6HN+sWwCqtBlBretgV9XpjHgyUtZ+xHp7TyYvqM7796lHES+GPoLc7xZGV20T3sOjC6CT7kkuLdnguz2AUOwE83D2piK0MbDkttBSE/Tj7afAdkzFqVuaRT72jjiZvi+erYPWKBWmjAZCunSDe0veP6TWd6uWTeHJA4JrgXGaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEpSQs8pJrn8MNGf+QjpI/9MYYCChfh2MXRFsIKzv40=;
 b=AWYWsYscoadWsPnf+aVgx4xB9zWM9D16EKeM2ZjjdSbfhEBQ3d0fGPqlr48ZyP/3XYh6NNXxQW1we6xls9IuYdZDRoHWo4i/7HrUAETs+7YJ/SDLLAWHS67fXiOyp/HmBYLodfokqvtUtIc/rQbG77sgxlm7I0vbcoqFAOUNYRn++3DYK2d3C6sRYw6TlY/xTZwToqr8e7i15sAnHOnEeT2LEtrOw8sEak5+BbS4+XmooxCgzCMN3Ee+biZZxtLIfELJGZBV767THCbiXWY8/KXh22WkJ77DbDyHs2AXGwZ/xK29x/OZUQEwuTHmfVNAT4vnUHlsjMpKuCsDztTBig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEpSQs8pJrn8MNGf+QjpI/9MYYCChfh2MXRFsIKzv40=;
 b=C1+vn0pTACWZc/icGbBqZo8fpEkNkVV3/BBcBEEiNawco4aR6L2/mNvLeP2FygC5IGl2bzmm4EfmxT4iKjt+6wc9HUEzCB5vphCQ0bPwE/JcGPj0txVl/HNxBJj46DkxFvd8iA/hA19hP2WeIBphBTamWkOeweiP52EYidwB8+I=
Received: from DM6PR02CA0126.namprd02.prod.outlook.com (2603:10b6:5:1b4::28)
 by BN6PR02MB2369.namprd02.prod.outlook.com (2603:10b6:404:2d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.24; Fri, 8 Nov
 2019 12:37:27 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by DM6PR02CA0126.outlook.office365.com
 (2603:10b6:5:1b4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24 via Frontend
 Transport; Fri, 8 Nov 2019 12:37:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Fri, 8 Nov 2019 12:37:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1iT3W2-0003iF-4L; Fri, 08 Nov 2019 04:37:26 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1iT3Vx-0003kI-1S; Fri, 08 Nov 2019 04:37:21 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xA8CbAIE025933; 
 Fri, 8 Nov 2019 04:37:10 -0800
Received: from [10.71.116.41] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1iT3Vl-0003jU-PM; Fri, 08 Nov 2019 04:37:09 -0800
Date: Fri, 8 Nov 2019 13:36:54 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 1/3] target/microblaze: Plug temp leaks for loads/stores
Message-ID: <20191108123654.GD2820@toto>
References: <20191106141424.27244-1-edgar.iglesias@gmail.com>
 <20191106141424.27244-2-edgar.iglesias@gmail.com>
 <3ee495ba-a88c-c81a-92e9-d5ad5d88022e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ee495ba-a88c-c81a-92e9-d5ad5d88022e@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(7916004)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(305945005)(107886003)(33656002)(106002)(6246003)(7416002)(356004)(9686003)(6666004)(126002)(476003)(11346002)(33716001)(486006)(229853002)(316002)(76506006)(9786002)(478600001)(16586007)(4744005)(426003)(5660300002)(186003)(70206006)(70586007)(36386004)(446003)(2906002)(1076003)(81156014)(81166006)(336012)(53546011)(8676002)(58126008)(50466002)(57986006)(4326008)(6916009)(26005)(76176011)(23726003)(8936002)(47776003)(42866002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR02MB2369; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbfa7153-4bf9-4af4-8cb5-08d764486989
X-MS-TrafficTypeDiagnostic: BN6PR02MB2369:
X-Microsoft-Antispam-PRVS: <BN6PR02MB23694C5BA535622A2FDFF112C27B0@BN6PR02MB2369.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0215D7173F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIQyiXbIC3sZSdTKtysMuXxUc7UlGGVWSeKsO8okfHVmiRoEPMLlcE8Uhi1iSzcYskPffZgmuRUmnVwlIM8wCoV8HEO9wTNotv+MaR+52RXBYn2PXaont6ktppDIWFLmDzzI3upDUXOMcJ/j+dzrPUqo7Gohw4p9Fu1f4k4WKRBglJDaBTGh7FdK8U34m8In6OGAcLBErmqe3WTq2KZHu8NPP6cZVRRGkHrEYxbNJkEU4l5wDEq1DpG95SmEq0Cbu661H/CWFnBsaKUeHWs91Br9/j/5YUKsQ8D/P5bagqU9jQzWPsYRwf1nmeAcoB0vcD/Misa6gi280KNuGKmeGeDRAbgEB8eLotGbxOeeMjpksw3naQFUHHflyAvz+U9gsWck2gHSGAIXMF6kD8xVD4ZBy78VSoKwoH6pUMiLgaSksHMWW6UgY5UadBX1hPA+
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2019 12:37:26.5920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfa7153-4bf9-4af4-8cb5-08d764486989
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.51
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
 qemu-devel@nongnu.org, frederic.konrad@adacore.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 03:19:20PM +0100, Richard Henderson wrote:
> On 11/6/19 3:14 PM, Edgar E. Iglesias wrote:
> > @@ -967,12 +967,14 @@ static void dec_load(DisasContext *dc)
> >                     10 -> 10
> >                     11 -> 00 */
> >                  TCGv low = tcg_temp_new();
> > +                TCGv t3 = tcg_const_tl(3);
> >  
> >                  tcg_gen_andi_tl(low, addr, 3);
> > -                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
> > +                tcg_gen_sub_tl(low, t3, low);
> >                  tcg_gen_andi_tl(addr, addr, ~3);
> >                  tcg_gen_or_tl(addr, addr, low);
> >                  tcg_temp_free(low);
> > +                tcg_temp_free(t3);
> >                  break;
> 
> While Luc correctly notes that tcg_gen_subfi_tl() may be used here, I will note
> (1) there's a typo in the comment (not 2->2, but 2->1), and (2) that this whole
> section can be done with
> 
> 	tcg_gen_xori_tl(addr, addr, 3);


Nice!

I'll send out a new version shortly.

Best regards,
Edgar


> 
> Similarly in dec_store.
> 
> The other changes in this patch around gen_helper_memalign are ok.
> 
> 
> r~

