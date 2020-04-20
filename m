Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7B6C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2845020782
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sWfj2cdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2845020782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQaKn-00055C-6t
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 13:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33324 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar@xilinx.com>) id 1jQaJo-0004by-7L
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:34:52 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar@xilinx.com>) id 1jQaJm-0006cb-0a
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:34:50 -0400
Received: from mail-dm6nam12on2052.outbound.protection.outlook.com
 ([40.107.243.52]:5217 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jQaJl-0006c4-Cp
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:34:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqDvs4ra9Vs4gDHnE7mPjifXqvBOOv/4SYLVfCo5xugp8/kKRbroGQBuEuE2hbhXKnUDos7c7NfEvzCMmHT10Ki7oNP2aZ0FSaM2BDGrENlDm9K65/+8ar5w51lRAT/6NFck3Zni4eygMaRN4gg9vtK78ylcIhIAIqKfz3bPVDaxS37drJjmbrLXKZqTvTSWPzmR3QdukpmtzSpe4NNyKGnmR2X33lCyPRdpBlK2YBIjmqfUkZ958TXt/MvWHpZpgKl2lj+jY7YtmmC9gEz2EscC7ulqIyq7BnfliZX9RqtrwHXpJkjCa/Dv04XzMSfY+VjPorjK+T8pmQUS2ZGSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1sfzLcLgn4TQcOyhrFLtPp/pbfuFqu7P2nDbk3/Srs=;
 b=A67VK8SeqqFIPt+/EHc5XWGjRP+BfBzD5KnN2xj/vC9QrqQTls4ioAcLmPkfjiDJ6By+6DkpAFx7+/49p0iE+wdpe9Fi7CR5Au3XVoJnP8wJUORFpAWUu5ofGNivgEDuzSF6pMdRDftyJhwKmTv7/pRU2nXZbGEpPSeeFvvN8c2oJf1GLkBzaI42nirfZhlbn+Fi8OKI4NLguMAn1eNoSPapr+XwhV1mnZf1WCwOVNPD2kZCrRqZWq9nY/nOZN6SZJInyyoJtMVCgpVmtPrHdGERW1AYC/Pd33jb4+tc06rImHCSJgxNcnbzuxCGx9iTwFSXskzPXe0aFKRHRyKZjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 149.199.60.83) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=xilinx.com; 
 dmarc=none action=none header.from=xilinx.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1sfzLcLgn4TQcOyhrFLtPp/pbfuFqu7P2nDbk3/Srs=;
 b=sWfj2cdzi3VrCh6OsyfSC4CcJ7nJdQrg0cZre4j9qeE3lNFFgtpB6fd9qw7ITT8JDHn4P+ilR6r5bYKqil6u37fAQnvjtrRiROxk+IfHXfQh5v+zRzGw3ktoUPhIjNG0mwEKL2ZplugNf/nA+5mZ38qSYdDF9hj8qN4f40sTEmI=
Received: from SN2PR01CA0065.prod.exchangelabs.com (2603:10b6:800::33) by
 BY5PR02MB6803.namprd02.prod.outlook.com (2603:10b6:a03:210::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Mon, 20 Apr
 2020 17:19:44 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:800:0:cafe::10) by SN2PR01CA0065.outlook.office365.com
 (2603:10b6:800::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend
 Transport; Mon, 20 Apr 2020 17:19:44 +0000
Authentication-Results: spf=temperror (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 17:19:42
 +0000
Received: from [149.199.38.66] (port=54102 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1jQa4B-00042F-GT; Mon, 20 Apr 2020 10:18:43 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1jQa58-0003VF-0q; Mon, 20 Apr 2020 10:19:42 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03KHJe4B016151; 
 Mon, 20 Apr 2020 10:19:40 -0700
Received: from [10.71.117.116] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1jQa56-0003Un-Du; Mon, 20 Apr 2020 10:19:40 -0700
Date: Mon, 20 Apr 2020 19:20:50 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Luc Michel <luc.michel@greensocs.com>
Subject: Re: [PATCH v1 3/6] target/microblaze: Add the div-zero-exception
 property
Message-ID: <20200420172050.GR4289@toto>
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
 <20200417191022.5247-4-edgar.iglesias@gmail.com>
 <ec41d1a0-10d1-0c37-9e71-32103f9d6b1e@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec41d1a0-10d1-0c37-9e71-32103f9d6b1e@greensocs.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(7916004)(396003)(39860400002)(136003)(346002)(376002)(46966005)(70586007)(5660300002)(70206006)(81166007)(6916009)(4326008)(7416002)(9786002)(81156014)(8936002)(8676002)(1076003)(356005)(33716001)(107886003)(316002)(33656002)(426003)(186003)(26005)(47076004)(9686003)(336012)(6666004)(82740400003)(53546011)(478600001)(4744005)(63350400001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2fd9fb9-e18a-42e6-4d41-08d7e54f03d5
X-MS-TrafficTypeDiagnostic: BY5PR02MB6803:
X-Microsoft-Antispam-PRVS: <BY5PR02MB68035F02443D57ACC98BB00AC2D40@BY5PR02MB6803.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03793408BA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 21YXz6o7ClvGMCJdHKkMpvvPKW/h1C/A84SXVHcPMYKmDEnX/wewci5cY5l+N8Vv/ZKufiH+NYbmZ8ZCLuFlHgeu/bIMitRZas8v91bE2wJnwPa+/v5+Y7/4epv7BBwzg8OFgDNEODXMwq2A+dTFVbuXTC38XkZbmv4SC2DDVw76U81/28R6cXSoybjt2FeEZrKjkRca5eqOCMGGp2yug6GmFQV44zx63Dxn44RnkH6mISwu1EdSspu/eN4ozXiT1MKalWoo7EIsCR9OPmJ3wP/3JFDWWPdf9bjH4xlDSlNMKsDaQ5I389WRuAL8s5jmuhBu6Mq0VVelkzNLiTf8jc/AqXDSVg0k//Ufwqqiq/I6pTIQRmGAt4ZtxNS74tahGB4scy4ZkfQLreVb+C/Pr6fR7ZCdzh5r3zvapfKB7rXF6Klc8HRf5ZqPPzwkG1hee2LWjOqO3/6/0nTir6IRWRWDxO110+oLexnpApjwOkC+hGYHdZ+NT2fq72v2H6pQuvJTS/1d9BEgAwIhekHpRQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 17:19:42.5532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fd9fb9-e18a-42e6-4d41-08d7e54f03d5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6803
Received-SPF: pass client-ip=40.107.243.52; envelope-from=edgar@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 13:34:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.243.52
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
 frederic.konrad@adacore.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 19, 2020 at 09:25:28PM +0200, Luc Michel wrote:
> Hi Edgar,
> 
> On 4/17/20 9:10 PM, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> > 
> > Add the div-zero-exception property to control if the core
> > traps divizions by zero.
> > 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---

...

> >          }
> > 
> 
> I don't know the Microblaze but don't you need to set pvr.regs[2] in
> mb_cpu_realizefn as you do in previous patches?
> 
> Something like:
> 
> env->pvr.regs[2] |=
>                     ...
>                     (cpu->cfg.div_zero_exception ?
>                          PVR2_DIV_ZERO_EXC_MASK : 0) |
>                     ...


Yes you're right Luc. I'll post a v2 shortly.

Thanks,
Edgar

