Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B532C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D7A206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Pht3lVqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D7A206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDiuT-0001LT-Rv
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 02:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kDitQ-0000dg-97
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:38:44 -0400
Received: from mail-dm6nam10on2077.outbound.protection.outlook.com
 ([40.107.93.77]:51968 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kDitK-0004Vi-7X
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:38:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYSNJsVFXtqlTbKfcgG7+LUbpCPx4CuQFdvmxVEG6+Zf/L8YDVwXatP8Z3GhfVanQwMaueTLHiTFloJxaglYei9qivVJ2aITxHuUkO77UIJxBWZOFfJ3tYIAi1ZUjUgfRxg5jPULapqyBjDWeDokMIBLphQgxQF/BfvCzYqJDHqPun+Wvqv2USBlEqYDMwdEUvKnrWFVBZDne1AHijcbzqMn27cGWVZeyWpLwo+4us86ooX9KE53Wo/nGnrhlixRSmSc+kYZXZ0UzVhhXImYqrM1rQfwQNJbMvcEWfBKVaxpKKh/a1aE6OdHnDkI0TRFIuZ3JyDmCbwhdT2SmZI+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1eP3A3sAOL3Bfq2YAOn0ZQU0uEsMVMrcsthF44s4/8=;
 b=klTQ+7fCIEn6eiJv1o32ZVmj7rPDeC3a+mxzOLNYh+2mdM2ZxQT/UYJb+t5TgKIUa7jBcjXdbq0xPUxAUFDBbF3e+nCEsguB0k/gCxj2qapHczavh+d3E/O+4PLIdejsDsee8sxJu49ZTkbDg1NhRwTvQNDpSNvc8HreNV27N7Hc/0lSPVwkld56lkweUlNFk/UwiRPYfQfSvoXJd4EZnKp/OlfdU66MbNZvm/sjjRZ4LfAvo0deI+e3BX5MCtpx2PUmBF2pKfZ2rN68vOD0/sIPKB+oIeCD6XeyTss3oBH4qkLWMnl5fO/K0vmWFmTbZgrGiO8augjCb8zBMQ8bFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=cmp.felk.cvut.cz smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1eP3A3sAOL3Bfq2YAOn0ZQU0uEsMVMrcsthF44s4/8=;
 b=Pht3lVqaaU26rYRfu+VgqtJK0XtpHnPsW9ZZWRZW4ubVkqXS15AzzRhzY5Y0pIAInA24SMQhP0qLDwlIvkagx/xtddgH3IvYUGHI9AH0cY0fu8VRJGxhdxoCvytFJAlqJfOW/zdmWWcCkIkDMcZ3V9KzvEKpAjxqu4lrXAzLKto=
Received: from MN2PR16CA0029.namprd16.prod.outlook.com (2603:10b6:208:134::42)
 by CH2PR02MB6373.namprd02.prod.outlook.com (2603:10b6:610:7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 06:38:34 +0000
Received: from BL2NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:134:cafe::a5) by MN2PR16CA0029.outlook.office365.com
 (2603:10b6:208:134::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 3 Sep 2020 06:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; cmp.felk.cvut.cz; dkim=none (message not signed)
 header.d=none;cmp.felk.cvut.cz; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT024.mail.protection.outlook.com (10.152.77.62) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Thu, 3 Sep 2020 06:38:33
 +0000
Received: from [149.199.38.66] (port=37227 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kDit9-0007WK-Sw; Wed, 02 Sep 2020 23:38:27 -0700
Received: from [127.0.0.1] (helo=xsj-pvapsmtp01)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kDitF-0005wN-9W; Wed, 02 Sep 2020 23:38:33 -0700
Received: from [172.19.2.115] (helo=xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kDitE-0005wI-Ul; Wed, 02 Sep 2020 23:38:32 -0700
Date: Wed, 2 Sep 2020 23:38:32 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: [PATCH v1 3/6] net/can: Add can_dlc2len and can_len2dlc for CAN
 FD.
Message-ID: <20200903063832.GA173424@xilinx.com>
References: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
 <30758547c49f254b3965fc12500735bea8265c97.1594725647.git.pisa@cmp.felk.cvut.cz>
 <20200903054329.GA405867@xilinx.com>
 <202009030812.42855.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202009030812.42855.pisa@cmp.felk.cvut.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46c6e040-3c01-45e4-9561-08d84fd3fac2
X-MS-TrafficTypeDiagnostic: CH2PR02MB6373:
X-Microsoft-Antispam-PRVS: <CH2PR02MB63736B746FF5B2A3396D937ABC2C0@CH2PR02MB6373.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ty8QzvGLd13DuyCl3jL7fIEI7my/4eKYDxBbU2g4l5WKCiag3pgGWxbj8XE2NKJCGEkw6tCNCT/n5SNQwXydxARtsF8+EBXbWT9skwbHESAovDxR6lFxY8yd2BuQrz2HgyIJXQGkyF4YYVW0goxxlZHyiV6MMEWabbMai3MMRTEXUO0G8mpoUJv5JLjQZw06GpwY+tmRAbYpQrt1dtB48Hl9lGPSkr5e345PnRHgOWHMgHWgGc79HM8ueNShxl3j1OO5tmZzfvW/P+9RQIIwgeKElfG68ReyrW1GAHI/aLUlp1GgIbQ06IQ3gcWSDZa6Gpkd7V4/P9M/IAjD1FaKOHrleEYC0302cKl4IELRbMD/j70VzOVWyAcXN6EiR/h4R5VADeR3O6s4GSbtqOTi23mViFwAvuCzYjiLurv5v/gpj7RUjW/js2LuNX9r9N3gQ1kfo2TvgZUy8T8Qdg0mKUZ/uo7J6m+unoq0AyCixhcYV4avMR/EH7eirahubTBN
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(396003)(136003)(376002)(346002)(39850400004)(46966005)(2616005)(70586007)(70206006)(26005)(186003)(336012)(356005)(6916009)(47076004)(1076003)(8676002)(82310400003)(4326008)(426003)(81166007)(82740400003)(9786002)(316002)(966005)(36756003)(7696005)(5660300002)(33656002)(7416002)(54906003)(8936002)(478600001)(2906002)(27376004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 06:38:33.6385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c6e040-3c01-45e4-9561-08d84fd3fac2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6373
Received-SPF: pass client-ip=40.107.93.77; envelope-from=fnuv@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 02:38:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Marek Vasut <marex@denx.de>, Jiri Novak <jnovak@fel.cvut.cz>,
 Oliver Hartkopp <socketcan@hartkopp.net>, Deniz Eren <deniz.eren@icloud.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jan Charvat <charvj10@fel.cvut.cz>,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ondrej Ille <ondrej.ille@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 08:12:42AM +0200, Pavel Pisa wrote:
Hey Pavel,
Thanks for clarifying this and sharing the relevant links.

Regards,
Vikram
> Hello Vikram,
>
> On Thursday 03 of September 2020 07:43:34 Vikram Garhwal wrote:
> > On Tue, Jul 14, 2020 at 02:20:16PM +0200, pisa@cmp.felk.cvut.cz wrote:
> > Hi Pavel,
> >
> > > From: Jan Charvat <charvj10@fel.cvut.cz>
> > >
> > > Signed-off-by: Jan Charvat <charvj10@fel.cvut.cz>
> > > Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Reviewed-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> > > ---
> > >  include/net/can_emu.h |  4 ++++
> > >  net/can/can_core.c    | 36 ++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 40 insertions(+)
> > >
> > > diff --git a/include/net/can_emu.h b/include/net/can_emu.h
> > > index c6164dcfb4..7d395fbb9b 100644
> > > --- a/include/net/can_emu.h
> > > +++ b/include/net/can_emu.h
> > > @@ -127,4 +127,8 @@ int can_bus_client_set_filters(CanBusClientState *,
> > >                                 const struct qemu_can_filter *filters,
> > >                                 size_t filters_cnt);
> > >
> > > +uint8_t can_dlc2len(uint8_t can_dlc);
> > > +
> > > +uint8_t can_len2dlc(uint8_t len);
> > > +
> >
> > These function are aimed for canfd. Perhaps rename these to canfd_dlc2len
> > and canfd_len2dlc for better distinction?
> > Rest of the patch looks good to me.
>
> I do not insits on name. But function correspond 1:1 to the Linux
> kernel ones
>
> https://elixir.bootlin.com/linux/latest/source/drivers/net/can/dev.c#L34
>
> These functions/tables are very short, but may it be, we should add comment
> about their origin. This part of original file is Oliver Hartkopp
> contribution
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/can/dev.c?h=v5.9-rc3&id=1e0625facab2e871472472b7df87d8fbe6caf75a
>
> some other helpers are from Wolfgang Grandegger and me.
>
> Best wishes,
>
> Pavel

