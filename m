Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A155C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 17:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26063204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 17:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PAmKjDGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26063204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55817 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzlYY-0006dP-7m
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 13:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar@xilinx.com>) id 1hzlXL-0005bi-1o
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 13:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar@xilinx.com>) id 1hzlXJ-0003ub-SD
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 13:33:42 -0400
Received: from mail-eopbgr820070.outbound.protection.outlook.com
 ([40.107.82.70]:57856 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <edgar@xilinx.com>)
 id 1hzlXG-0003rE-2B; Mon, 19 Aug 2019 13:33:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xj7QU2pmFbv52gFFmmRt4B7hMzSZZig8lfrPATJj9vBrQUGRDk/2ZgDrsJyP+ARn7BVuZ6FVJCZYieRUlUk5KgxI1C4rT1E3c5Ft1tGTAi00kCwGcdBS7Q4LnjjLi0BGW1C7VjbhnFpA/ge5P7a5Du5N2cz6BCSXFFjseOeOobCDFfmMoJ8fZA25mn+voHydUIJvBxED3TFdoUg+2k49oKfHiSX66+RrQY0nRs/xxu2S3cUjkQBEcf7dvpRV4AeXrsdYCAPTlzo/eGekmsKKuUXBv6XMdOJ3I8R7vVModypboIk3Aua1za9o2PdEdexE1VtDvcOz3guMokpJBYdRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCzxFDdkIKiM4RYY93olJ3kjkwrTWERtRGgi+oEYdMQ=;
 b=kuzQl+EitpDiepEtVqGr80p7Uqo97gBtmHGhFayrIlaOSsU1WNiDFa+O7XA9KdFPtX+4xg8WNbuA84UNfWG/KvFPj78Dc4z6CirMtzGxOKk9Mvy1KmHftd1zWcdoGvg6JN3G/zk+D+FWifcNfd4jBs1TaeXA8YwWyStvykrF/isJgFtfBjy3O8tMQC4HGSRjx5Lw76s5IfoYRXx20b1bQtsalnvXxnHD8beEW3CdekCj/hUsGYA3HsEC8mdcKcYCfwylTtN26OMehNksrzmvep8dzUraRLYsxzo19L74TmWM+bfuTWKPd2plR8Ort2WDeb0NCLzfW4xbnASXgmGm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCzxFDdkIKiM4RYY93olJ3kjkwrTWERtRGgi+oEYdMQ=;
 b=PAmKjDGLe4wk+uq9eZRJInK2Bx/BC9wxiIPGiMBaGWC+Rv8/Mu2F4m4+e+yvLhE/XM46tc11EgGjq4n2YWP1C5luXUW2LmAviI068xtBnfxoG4DxP60egAV/u0P0sl8+Zcyg2RjSBlK6HozJByn4Lj5+mWe3PSC1/YPPEnWAnqc=
Received: from MWHPR02CA0018.namprd02.prod.outlook.com (2603:10b6:300:4b::28)
 by DM6PR02MB5306.namprd02.prod.outlook.com (2603:10b6:5:48::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Mon, 19 Aug
 2019 17:33:31 +0000
Received: from SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by MWHPR02CA0018.outlook.office365.com
 (2603:10b6:300:4b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2178.16 via Frontend
 Transport; Mon, 19 Aug 2019 17:33:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT016.mail.protection.outlook.com (10.152.72.113) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2178.16
 via Frontend Transport; Mon, 19 Aug 2019 17:33:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53576
 helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1hzlX7-0002i7-DZ; Mon, 19 Aug 2019 10:33:29 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1hzlX2-0005F2-A3; Mon, 19 Aug 2019 10:33:24 -0700
Received: from [10.71.117.108] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1hzlX1-0005Ez-SC; Mon, 19 Aug 2019 10:33:24 -0700
Date: Mon, 19 Aug 2019 19:33:23 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190819173323.GP17732@toto>
References: <20190816125802.25877-1-peter.maydell@linaro.org>
 <CAFEAcA-7Lr0nUD3g=C7S1Obgaa0E0p794XLhuBZRW_+fC5YjcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-7Lr0nUD3g=C7S1Obgaa0E0p794XLhuBZRW_+fC5YjcQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(7916004)(4636009)(39860400002)(396003)(346002)(136003)(376002)(2980300002)(189003)(199004)(9786002)(356004)(16586007)(2906002)(58126008)(23726003)(76506006)(1076003)(47776003)(70586007)(106002)(70206006)(8936002)(33716001)(9686003)(5660300002)(6916009)(316002)(54906003)(81156014)(8676002)(229853002)(81166006)(336012)(486006)(33656002)(478600001)(4326008)(11346002)(426003)(446003)(126002)(476003)(57986006)(63266004)(50466002)(76176011)(305945005)(186003)(6246003)(14444005)(26005)(5001870100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR02MB5306; H:xsj-pvapsmtpgw02; FPR:;
 SPF:Pass; LANG:en; PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com; MX:1; A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c973529a-1a5d-4288-df03-08d724cb5a5d
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);
 SRVR:DM6PR02MB5306; 
X-MS-TrafficTypeDiagnostic: DM6PR02MB5306:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5306BFA8CA2484E624E39C29C2A80@DM6PR02MB5306.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0134AD334F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: yCH3j/2ZouuK6oMJzvUNdwwymdlMDsPyOWuCUbUdSgJTYe5HJUmnbKOoWY+FosAXKsa9Q0zvX5uhcRSMc7DeZcUsAoPO0BEQkqK5WEc5sFtWhP3INPQCo+gxSWXdhll6JkTpOPw2hvcr4azXfSOnpj6Kx/EMtq/LcICzjxBU1GH8QzpydIiosbTcAbZteK+uCFUaSM6JMl+V4EpcgMNYmjJMfBdMIPa2nyc440Xr0wLEK8KalMqeG2q3saY4mNX/bdpqKU7mP3lPRBeXrQMDaA4tzgKHuQ+2RJ+2j75LVIMfbAi1v+p1bRYD5HQdZtDBcO02yxJwrDEfgsU5fYjV872Yi0xquAj6t/lt8nzJhRi4mX6uhk+OgBfZRkBr2/oUIxWwkNt1eIksc79rymc5sCj6Tp7U9eF90ZPpU0lP+Bo=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2019 17:33:30.6194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c973529a-1a5d-4288-df03-08d724cb5a5d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.100];
 Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5306
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.70
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
> 

Yes, I'm not very up to date with the Xen code but it used to
be the case that Xen used ATS a fair bit. We have some other
tests that use it but they don't rely on exceptions IIRC.

I'll take your patches and test them with our internal testsuites, including Xen images.

I may also be able to find a Xen image I can share that works with upstream QEMU.
Stefano may have something in his pocket already?

Cheers,
Edgar



