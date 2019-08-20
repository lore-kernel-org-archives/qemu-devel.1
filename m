Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B85C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4285022CE3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PYuucx7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4285022CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i03kB-0008J2-EA
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 09:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar@xilinx.com>) id 1i03jL-0007jM-TG
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar@xilinx.com>) id 1i03jK-0006GC-Bq
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:59:19 -0400
Received: from mail-eopbgr800072.outbound.protection.outlook.com
 ([40.107.80.72]:48784 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <edgar@xilinx.com>)
 id 1i03jK-0006Fd-28; Tue, 20 Aug 2019 08:59:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgJ2p1lYEZDXmh6/VHdQY6YioO2E2HNMDK+FdmiLtZ5ywvvzrBE9JYSi/TBMZGA5e5xaPpW4mM3erEN5r4yNWA2ALEGjeNWxwiP7ZuXSrYMKrxlnZV56v52V8SduAZkobRyHxgfIacU8Hnzp7x0gzBk4sQsyIyjGmPCqrrmADp3qXz4KId2cyN2JQvVCx05EPu1RB0HRVfbPYiSpiI3CURvjFZqhq82Kv/N6x90lM+iOyML65gnbmKfCsuUslhfvJHbRGldgbpheUZxu+6N8RjEFBpCYW6oHH6XJdLcTD6WdwBrDHQNOazXFsc6Old2Qf8ZLp/AwXKaHlVmjANc6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LLSbik/3FYSuyvcX5Y2DH3baCFtWhk+gmn5FveY+vk=;
 b=ByOlirNw65w2Fzk61bZ6ayzL6FHWUD4RFGOcQG9W5k//r6pCxNHfR3g3DXtvjlnONDh882nPrJmsAGGZEw5lA17UvSYcCG2NLJBOqdB5z1vbVqb1uRGemzzchNcuii3b6AM2bz9GgG5pErImh/L+sd8WPtRn/R7y/5OVuPrCNgKmaPTCIVuG05on2Dnbll/TknEBZfkp40Y6OW2aRl+STH1yJJWZDPyYiD9wdOviAVbguHODLraeU28EGRPRu9Fy48reKhGgDeCFaj/RVPTenbMUPA/0tdG0oCBkil7s12dPqxJQKsEAEAIoOFwskV4UcWEOjuV0eY05eQVQK4zMCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=citrix.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LLSbik/3FYSuyvcX5Y2DH3baCFtWhk+gmn5FveY+vk=;
 b=PYuucx7z0nb8gKUnI74rRMJ1ulsHd5GRFVCE9v820IT+W2WFfCk3g49zdltSAro9Nfqa1g8MdjTdEIlIe0s0XgVIjj0LPG7FgTNZg6ouBXC2gSj5GHdLiCOmiXDskMUjgQf9kidKKm49i3hlOoRr+eso+ScE02WtQ02qjxca8Y8=
Received: from BN6PR02CA0034.namprd02.prod.outlook.com (2603:10b6:404:5f::20)
 by BN7PR02MB5299.namprd02.prod.outlook.com (2603:10b6:408:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.18; Tue, 20 Aug
 2019 12:59:16 +0000
Received: from CY1NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BN6PR02CA0034.outlook.office365.com
 (2603:10b6:404:5f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2178.16 via Frontend
 Transport; Tue, 20 Aug 2019 12:59:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; citrix.com; dkim=none (message not signed)
 header.d=none;citrix.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT058.mail.protection.outlook.com (10.152.74.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2178.16
 via Frontend Transport; Tue, 20 Aug 2019 12:59:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1i03jG-0004MO-Rw; Tue, 20 Aug 2019 05:59:14 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1i03jB-0004US-OF; Tue, 20 Aug 2019 05:59:09 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x7KCx9Hl032457; 
 Tue, 20 Aug 2019 05:59:09 -0700
Received: from [10.71.117.108] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1i03jA-0004UP-RH; Tue, 20 Aug 2019 05:59:09 -0700
Date: Tue, 20 Aug 2019 14:59:08 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190820125908.GQ17732@toto>
References: <20190816125802.25877-1-peter.maydell@linaro.org>
 <CAFEAcA-7Lr0nUD3g=C7S1Obgaa0E0p794XLhuBZRW_+fC5YjcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-7Lr0nUD3g=C7S1Obgaa0E0p794XLhuBZRW_+fC5YjcQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(7916004)(4636009)(376002)(346002)(136003)(396003)(39860400002)(2980300002)(199004)(189003)(9786002)(106002)(70206006)(76506006)(33656002)(76176011)(70586007)(478600001)(1076003)(9686003)(5660300002)(6246003)(54906003)(26005)(47776003)(50466002)(58126008)(8676002)(81166006)(486006)(305945005)(23726003)(336012)(6916009)(81156014)(316002)(33716001)(126002)(356004)(4326008)(16586007)(476003)(11346002)(57986006)(186003)(63266004)(14444005)(8936002)(446003)(2906002)(229853002)(426003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR02MB5299; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ea83ea3-4fef-427b-21d2-08d7256e34b2
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);
 SRVR:BN7PR02MB5299; 
X-MS-TrafficTypeDiagnostic: BN7PR02MB5299:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5299AF3CDC21C42A2B18FB6BC2AB0@BN7PR02MB5299.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 013568035E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: g26IG7ZZAqDSE61MYrWw8p+BEv5PhCLmENePJ75MoHOoH1JJUwORGb/fWQMTMiVuKiZ3LuUJkQ1G9PiuljC5+IY86ggusHsIQz6wCMh8JC/ZeAhwOh3SdW5xVuhbcKLUUCYX1iNQbhIocHmFPmveht0pCkGaIJ3sXz60vdOQWJRKjn79Zwq1zVdVSIpBAlIRbntvvR2RI3aZ2esx513HMNiDaXXkZxWEnaeQCqsviwW8Yje3OpZiKI2SLJxyP0tjeNHOhUap+ySM7pI15e0rkIoVGJWqCGj18aCZRKOhPQQVOdCSrae6LrEi4levJCOORUr2arxZSOI+QodpMO7YbgiVW0HhrJXhqXnU8nmbHYg1i4fWkVEIPwZ3RW/11Uvj0GzDqN500bkyHHWaDGKp99xSHQcOYdk9UH5w3mM2h+c=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2019 12:59:15.4051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea83ea3-4fef-427b-21d2-08d7256e34b2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5299
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.72
Subject: Re: [Qemu-devel] [PATCH 0/2] target/arm: Take exceptions on ATS
 instructions
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
Cc: Anthony PERARD <anthony.perard@citrix.com>, qemu-arm <qemu-arm@nongnu.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 19, 2019 at 01:44:37PM +0100, Peter Maydell wrote:
> On Fri, 16 Aug 2019 at 13:58, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > The translation table walk for an ATS instruction can result in
> > various faults.  In general these are just reported back via the
> > PAR_EL1 fault status fields, but in some cases the architecture
> > requires that the fault is turned into an exception:
> >  * synchronous stage 2 faults of any kind during AT S1E0* and
> >    AT S1E1* instructions executed from NS EL1 fault to EL2 or EL3
> >  * synchronous external aborts are taken as Data Abort exceptions
> >
> > (This is documented in the v8A Arm ARM DDI0487A.e D5.2.11 and G5.13.4.)
> >
> > I noticed this by code inspection back last year sometime when
> > I was investigating a guest boot failure that turned out to be
> > due to an entirely different cause. I got about halfway through
> > trying to code up a fix before I realised it was irrelevant to
> > that bug. This patchset is just tidying up and completing that
> > work so it doesn't get lost.
> >
> > Use of ATS insns in the cases where they might actually fault
> > is quite rare (obviously nobody sets up page tables where there's
> > no memory and they'll take external aborts, and even for the
> > "take a hyp trap for a stage 2 fault" case you need a setup
> > with a hypervisor and a guest that uses ATS insns, and Linux as
> > a guest doesn't use ATS at all. So my testing of this patchset
> > has been more "check it doesn't break things" rather than
> > actively finding and testing a use of the throw-an-exception path...
> 
> I'm told that Xen for Arm makes more active use of ATS
> instructions, so I've cc'd a few Xen people -- do any
> of you have handy testing setups to try running Xen in
> emulation under QEMU? Configs where the guest (EL1) actually
> uses ATS instructions are the particularly interesting point
> for this patchset.
> 
> (if there's a good set of instructions for creating a test
> image I could probably add it to the ad-hoc set of things
> I sometimes test with.)


Hi,

All tests passed.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Cheers,
Edgar



