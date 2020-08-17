Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85A1C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7368720657
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ajr+bD4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7368720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7imv-00054a-Kp
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 13:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1k7im3-0004Nd-OI; Mon, 17 Aug 2020 13:18:19 -0400
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com
 ([40.107.237.78]:29088 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1k7im1-0004M5-6h; Mon, 17 Aug 2020 13:18:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T10Xal+luVOfXw7khq2KHpSM8e5KGe9ZhoiIL3rFvmI4cStNa1JJGw/sV8eDbYbD3SvdrBe6pSDl532YT96xSoE4jYecz7ln9f6qwx6BdaUcLWFrkG4CydGW11reAECh//hLcVPggfIheX/ks2rWAMYkvL3nPcD0dPwQ4OXUCgIw5qqdvWBZWj26Nm0GDl4RKZ90ZYW4OomMxddvotMqr4LtIyFJDRf2EAuUl5vKUQx84cVhNn/rrLsteZ4NSvJXN0cjbrhZirBYor/15/l2zjTJIas21CxjgEqZjJ5++NFrva9x/ipGFAljomcn/9tOicBWN9Ucx4qeAwHXOCaFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Km3rqhV6wdH54r9l0XGV2Kumg7Z3ahFFUmy/tGIOEEw=;
 b=cIguqsK7NvfBATUnAy2G5YIH7/XtpQCSDYyGKx8YophT4n2fBAmbfdDdQMtzlZ8WHbV1x3nyYC8vlZqFx9DeotB9HEv3bdTxoZsiPwKXKlHu76L5/zzaCeF0GtChpxZ4EiBUSNmiTYNRX1m9IvS8XEF8tfhhl+qNcOgzvep4qRLkfQkfoRkkFaKdFDxv7zikLKCGDi4PlF87UwI4TTJvz57SmEutKmOOKB9gHlIHn2AXgZt/OrRpl90+j7Hr69H5WwBAkFKu5zqA9dYRHhgmVk/axZ7sMnzx39FCFs0OfIkNAHEJcEWbiUecJHMgj4UdA7Krk0yu50kgVuedG4zTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Km3rqhV6wdH54r9l0XGV2Kumg7Z3ahFFUmy/tGIOEEw=;
 b=ajr+bD4Rd3EzVudXGJ/wBw1LU/9v2IhBn3iwTRNW6RHK3GEiIWW3odoMQLwCmA6srS7wRL92Z5TI4tSgWZQ/aQwE8p6heq0gXMUzqqNWgXdwf95t/mC9HcLAa/h7zyEfW++4uYD85ovb/MSLv1ojKal+M4A0BIq+J/hVbiBZ7b8=
Received: from SN4PR0501CA0023.namprd05.prod.outlook.com
 (2603:10b6:803:40::36) by MN2PR02MB6637.namprd02.prod.outlook.com
 (2603:10b6:208:19a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Mon, 17 Aug
 2020 17:03:04 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:40:cafe::17) by SN4PR0501CA0023.outlook.office365.com
 (2603:10b6:803:40::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.13 via Frontend
 Transport; Mon, 17 Aug 2020 17:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 17:03:03 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 17 Aug 2020 18:03:02 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 17 Aug 2020 18:03:02 +0100
Received: from [10.71.119.128] (port=52277 helo=localhost)
 by smtp.xilinx.com with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1k7iXF-0004BD-Qt; Mon, 17 Aug 2020 18:03:02 +0100
Date: Mon, 17 Aug 2020 19:03:01 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 3/5] target/microblaze: mbar: Add support for
 data-access barriers
Message-ID: <20200817170301.GM31713@toto>
References: <20200817140144.373403-1-edgar.iglesias@gmail.com>
 <20200817140144.373403-4-edgar.iglesias@gmail.com>
 <d4c0d54b-2575-147e-36aa-268628def55a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d4c0d54b-2575-147e-36aa-268628def55a@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bee5bcf2-9b9b-4265-cf37-08d842cf67c6
X-MS-TrafficTypeDiagnostic: MN2PR02MB6637:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6637D7F81B62F6DBBD623AD2C25F0@MN2PR02MB6637.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYf4pihEy8opSKQp8IDXVvPa8R79vz/bWA9V/IyqKQW3y9BaH6w7eGVzkeTU5xAeIwphWMYNoAYuUozR4Zz1yvMscirm+VAVhElYXlH3siWl5V92CEudEUa/k5t6wW01ILVAO1yHUNBMYct3d9qZCwLgi8Zvl+zuY2/PA0UPyGdxq74VObHoaxAewbYH2YXAS8uiduKYDzuUzW5sQbM+j4oX870AHWMyySVZpupf8sQXQGr06T635Uygaebbvvemg2vGqLog6fG44D0zv7gyo4W60KQsx9bHaSc5zWYGza2ZIQl0vgTj/lUHweofV7COFEqR4YCDWb76EHuqFHdA1XXCA4PfPRMvOgNMRMJt/MaKqEGcaiBrTZOQ/mR9gRcuwL7iG7zxtqeygw0RcAx20Q==
X-Forefront-Antispam-Report: CIP:149.199.80.198; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xir-pvapexch02.xlnx.xilinx.com;
 PTR:unknown-80-198.xilinx.com; CAT:NONE;
 SFS:(7916004)(346002)(396003)(136003)(376002)(39860400002)(46966005)(2906002)(356005)(9786002)(426003)(33716001)(1076003)(82310400002)(7636003)(7416002)(54906003)(36906005)(6916009)(5660300002)(33656002)(9686003)(82740400003)(107886003)(53546011)(4326008)(47076004)(316002)(8676002)(83380400001)(8936002)(26005)(186003)(478600001)(70206006)(70586007)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 17:03:03.6962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bee5bcf2-9b9b-4265-cf37-08d842cf67c6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.80.198];
 Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6637
Received-SPF: pass client-ip=40.107.237.78; envelope-from=edgar@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 13:18:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me,
 qemu-devel@nongnu.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 17, 2020 at 08:42:04AM -0700, Richard Henderson wrote:
> On 8/17/20 7:01 AM, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> > 
> > Add support for data-access barriers.
> > 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---
> >  target/microblaze/translate.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> > index c1be76d4c8..c58f334a0f 100644
> > --- a/target/microblaze/translate.c
> > +++ b/target/microblaze/translate.c
> > @@ -1233,6 +1233,11 @@ static void dec_br(DisasContext *dc)
> >  
> >          LOG_DIS("mbar %d\n", mbar_imm);
> >  
> > +        /* Data access memory barrier.  */
> > +        if ((mbar_imm & 2) == 0) {
> > +            tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
> > +        }
> > +
> >          /* mbar IMM & 16 decodes to sleep.  */
> >          if (mbar_imm & 16) {
> >              TCGv_i32 tmp_hlt = tcg_const_i32(EXCP_HLT);
> > 
> 
> The patch as written is fine, so
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> However, a couple of other notes for mbar:
> 
> (1) mbar_imm & 1 is insn memory barrier.  For ARM, we do:
> 
>     /*
>      * We need to break the TB after this insn to execute
>      * self-modifying code correctly and also to take
>      * any pending interrupts immediately.
>      */
>     gen_goto_tb(s, 0, s->base.pc_next);

Actually, we're already breaking the TB at the end of all mbars.
I thought of perhaps not breaking it for data-only barriers but IIRC,
we have some SW that depends on the current behavior (taking interrupts
after raised due to previous load/stores) so I left it as is.

> 
> (2) mbar_imm & 16 (sleep) should check for user-mode and generate
>     an illegal instruction.

Yes, I'll fix that in a follow-up patch!

Thanks,
Edgar

