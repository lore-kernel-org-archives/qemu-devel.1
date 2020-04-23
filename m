Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C8FC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1EB20736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DTv7Cbte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1EB20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRaH1-0007Pa-9y
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 07:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar@xilinx.com>) id 1jRaGD-0006Lh-EJ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar@xilinx.com>) id 1jRaGD-0000Uh-10
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:43:17 -0400
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com
 ([40.107.94.52]:5217 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1jRaG9-0000Cn-Vh; Thu, 23 Apr 2020 07:43:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL4ln9YypwnrcOi36qyI6lvoGMkIDwhH9PEdKC78HywoIgiAq8kQ1qFaOll1ZoGpOgJJja9p0olT+xENVJ7ukjkbxvKkJMn+oST/ZCIeEzqvN6VC7T3gXPIJwzJamGYp3Jaj/LfZ/E6hr1irFdT2cYveUZb+U7yZImEDmD3itniaEgEShIwbU644QwHxHgfgJmCGzJt9iPG4G7mJty9pAquQCmjmiHNFDOOtBYAuF2gqCFd80wLBI2uonp3Geu9qWWv18L1Ti0FoeH+H+PjMGZsn69Nr75VLGBe1k6TJ9SreAbu5O6tCC8UytIcekD7GzEsKv0wpAoQ3yXV8kJxx5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KO/uCdQAIfBv+8SWu71qNq98o8cy4veFaxHqWBQi6Wg=;
 b=EqZ+tE4k5mwv/3SIVSqpedzPD3Gm7x5VTpW/4Os69khoYY0y3RoPkbr1uhSbOJXzqW+BU2iQE6oNe7e7ImXDbCt3kW9XrsqJJtVMePcvk5zxnxdmhtA/3R0iSUEeZDelgFyE0y6gJcQUUrefxd12UUNoWc9TE5hPeLIujKhhbtB4pd53ROKJ6fL8XPnUSoyHWREAFMpGTWfh3bklD6bgTHG6T08T/NPS3fH9SxhkzJBLerSQUuv9sUHoR0hnPVaDUndNeUpvLppS6CAVhn8FrQf2r38GHWEfG4mp2SCl3LT/51n+aBYje7H0+aTyaFqfOWP4djmchKaIASJow0MlQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KO/uCdQAIfBv+8SWu71qNq98o8cy4veFaxHqWBQi6Wg=;
 b=DTv7Cbte9f1lzu3/ZeTHpNxog9izf2GeIXy5GmVO7o6054W6+FxZBicve0uc/EdjS/bM5+/+/6xsH4vTl+lcim+Yt40G5ZSNFSsS7c+00a6IbSIho3AkhJCUJda3DMAq1YzhgpbXDIzLDZnKxAY8BcKQkEjJwtYsgI3mKg+pJ6Y=
Received: from DM6PR13CA0005.namprd13.prod.outlook.com (2603:10b6:5:bc::18) by
 BYAPR02MB5528.namprd02.prod.outlook.com (2603:10b6:a03:9b::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Thu, 23 Apr 2020 11:43:08 +0000
Received: from SN1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::fd) by DM6PR13CA0005.outlook.office365.com
 (2603:10b6:5:bc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend
 Transport; Thu, 23 Apr 2020 11:43:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT012.mail.protection.outlook.com (10.152.72.95) with Microsoft SMTP
 Server id 15.20.2937.19 via Frontend Transport; Thu, 23 Apr 2020 11:43:07
 +0000
Received: from [149.199.38.66] (port=43683 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1jRaEy-00061i-1V; Thu, 23 Apr 2020 04:42:00 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1jRaG2-0006cI-Qn; Thu, 23 Apr 2020 04:43:06 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03NBgvR7031369; 
 Thu, 23 Apr 2020 04:42:57 -0700
Received: from [10.23.121.82] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1jRaFt-0006ak-AP; Thu, 23 Apr 2020 04:42:57 -0700
Date: Thu, 23 Apr 2020 13:44:07 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 3/3] hw/arm: xlnx-zcu102: Disable unsupported FDT
 firmware nodes
Message-ID: <20200423114407.GE4289@toto>
References: <20200419162727.19148-1-edgar.iglesias@gmail.com>
 <20200419162727.19148-4-edgar.iglesias@gmail.com>
 <CAFEAcA8D2HSPg8-ZvFBocmz+QRXTzhJcjDG21PCk7+_N7+2o1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8D2HSPg8-ZvFBocmz+QRXTzhJcjDG21PCk7+_N7+2o1g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(10009020)(7916004)(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966005)(9686003)(6666004)(5660300002)(316002)(70206006)(26005)(186003)(336012)(47076004)(426003)(70586007)(356005)(82740400003)(478600001)(82310400002)(4326008)(81166007)(9786002)(1076003)(6916009)(33656002)(8676002)(81156014)(33716001)(7416002)(8936002)(107886003)(2906002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2c2b43e-8661-4bc9-f755-08d7e77b7dec
X-MS-TrafficTypeDiagnostic: BYAPR02MB5528:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5528577BBFCF665A24ED95B9C2D30@BYAPR02MB5528.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 03827AF76E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1MamG894CFxdkleNcwGUqXHb09wXYqTWj7ArsHDmhVW1bKDEakR4qzcD+8OexL925I76CHq6G5L0VhE4vKhlQBVbvteomumQ+e0oZaA1n2KbMh9R4VV/3w1MHhuh20QiGLsrZBhE/QJbA/wX1Gxz004jJV4n5l2O0dFqFscEAgZzICMTq4MlR2EY8sFK++uc4txbhFcpP9e8QLLJOr9NQbyUNGAmCnkeVPDg/H6dEU5hPuTBNBzq5M9bqd+UlahiDvEp11FGWDU3q0shejDzCFxQsTzgTmTLSfqP5l0DqSOKj3uB4UNzytK86/vuRXGGFIJxqPjGrHJ/n2nYrf5rGxvbAclRBjIM6f+R5qfkWjaVWIO6DFxz2iyiq8xrA4biyJJ3Z+y2Mk2D7Y0lqouNd7NmEh4EigbcCRvabvpKpEx+Lnk9YhY4rRzebaTXL5AoX2wt0Gm5JcOiwo40Le4cCVlJhS6vBOrMzWRqBH9qqTKjsO/Ml+lwyUm168ypSog4DHtfXmr8cXfKaIhUU59Mg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 11:43:07.5705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c2b43e-8661-4bc9-f755-08d7e77b7dec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5528
Received-SPF: pass client-ip=40.107.94.52; envelope-from=edgar@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 07:43:10
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.94.52
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
Cc: figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 12:21:11PM +0100, Peter Maydell wrote:
> On Sun, 19 Apr 2020 at 17:27, Edgar E. Iglesias
> <edgar.iglesias@gmail.com> wrote:
> >
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> >
> > Disable unsupported FDT firmware nodes if a user passes us
> > a DTB with nodes enabled that the machine cannot support
> > due to lack of EL3 or EL2 support.
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---
> >  hw/arm/xlnx-zcu102.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > +static void zcu102_modify_dtb(const struct arm_boot_info *binfo, void *fdt)
> > +{
> > +    XlnxZCU102 *s = container_of(binfo, XlnxZCU102, binfo);
> > +    bool method_is_hvc;
> > +    char **node_path;
> > +    const char *r;
> > +    int prop_len;
> > +    int i;
> > +
> > +    /* If EL3 is enabled, we keep all firmware nodes active.  */
> > +    if (!s->secure) {
> > +        node_path = qemu_fdt_node_path(fdt, NULL,
> > +                                       (char *)"xlnx,zynqmp-firmware",
> > +                                       &error_fatal);
> 
> Why do we need the 'char *' cast ?


Without it, I see the following warning but compat in
qemu_fdt_node_path should probably be changed to const char *.
I can make that change in a v2 if you prefer.


  CC      aarch64-softmmu/hw/arm/xlnx-zcu102.o
/home/edgar/src/c/qemu/qemu/hw/arm/xlnx-zcu102.c: In function ‘zcu102_modify_dtb’:
/home/edgar/src/c/qemu/qemu/hw/arm/xlnx-zcu102.c:84:40: error: passing argument 3 of ‘qemu_fdt_node_path’ discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   84 |                                        "xlnx,zynqmp-firmware",
      |                                        ^~~~~~~~~~~~~~~~~~~~~~
In file included from /home/edgar/src/c/qemu/qemu/hw/arm/xlnx-zcu102.c:26:
/home/edgar/src/c/qemu/qemu/include/sysemu/device_tree.h:46:8: note: expected ‘char *’ but argument is of type ‘const char *’
   46 | char **qemu_fdt_node_path(void *fdt, const char *name, char *compat,
      |        ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[1]: *** [/home/edgar/src/c/qemu/qemu/rules.mak:69: hw/arm/xlnx-zcu102.o] Error 1
make: *** [Makefile:527: aarch64-softmmu/all] Error 2

Cheers,
Edgar

