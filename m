Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C81C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBCD12071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jeG3iUm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCD12071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDhuj-0006am-24
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 01:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kDhu0-0005xE-OZ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:35:18 -0400
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com
 ([40.107.94.49]:29984 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kDhty-0005UI-0C
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:35:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFWgSkgNLPih6hCosWt5UGv8LySZ2Szh0ivMV5zGXwJAQ5ftQVKK+MyyrnbPP31rPSPeIAfxqVvhHnSB4SZi9pQmRmXjukqKPK8hEqi4+hbfvrifS5p7ZPF03m/3k1JH1TCf1jrCjvmF0OMYe7NqSO0l1QNR0dv4G2vAgpyYuqheqlNk1u6jgzGYKMSPVac8QWfGY8jpYk3fJkY8n/oNISsNuLli/fXAmnCgIH0CjsWtCEiU0P2lx/ifilKUJWfF+HlsyGPuLmyOJJOQyxDgx46cPMwVtQNMyyT1Ct6ZzU6ojTKKazcISTaTvwupw/XddbNRF9qZzNH1S5/KTOrQfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9cIB+7JVV6b0aEGVBHeKpU2x4yRXJjldSPnlc0qt94=;
 b=HZ5bTNBj1FphM35Jzrscgm8F+bhyXQTonmkrDyjeip1Q+Gn4GNhdymL/anR0VK+p3t6L8VOl7tm4HG/5ebnPrchJaRSXV5ePzw2wJq4gRYh/hRAOk5KsQUhSF9E5F44QxynkJ+79A72JZbEgV6g2qjjST5nJ3GlPo++p6eI3CBL1vFXxKaKi/1XTMIsXnrqHWyqWcBciE5oKjFRYyhzjEjmbHtCvfK7LSpTKFt2SJd+CgDr940V7guQUPxaEIBS5f+bAUvAVfcIf70syB+7kknACqGhwy1lDy27m+bSUIE50T4BdA5m+9OxNs+fg1ydjL8pZfxrD/oU+221A3W5Pnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=cmp.felk.cvut.cz smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9cIB+7JVV6b0aEGVBHeKpU2x4yRXJjldSPnlc0qt94=;
 b=jeG3iUm4U/sp5kRu3w+A0GrQnHYlsuSCo3tRB2s2Okn0+HjM6LRDL9cj4UyxbA9omxKyn4eHUQy2qJkoo+p8VJ81lRCOPVFkuoqnvX3LHYcPraM4q6zibAe0oaWwVAKxupd7y8BO/9CE0OQB4ATLFbHgnpUMkPXOea8JwQSGA3E=
Received: from MN2PR16CA0013.namprd16.prod.outlook.com (2603:10b6:208:134::26)
 by CY4PR0201MB3489.namprd02.prod.outlook.com (2603:10b6:910:93::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 05:20:05 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:134:cafe::e3) by MN2PR16CA0013.outlook.office365.com
 (2603:10b6:208:134::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 3 Sep 2020 05:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; cmp.felk.cvut.cz; dkim=none (message not signed)
 header.d=none;cmp.felk.cvut.cz; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Thu, 3 Sep 2020 05:20:03
 +0000
Received: from [149.199.38.66] (port=50113 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kDhfB-0005OD-Nx; Wed, 02 Sep 2020 22:19:57 -0700
Received: from [127.0.0.1] (helo=xsj-pvapsmtp01)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kDhfG-0004Dr-JU; Wed, 02 Sep 2020 22:20:02 -0700
Received: from [172.19.2.115] (helo=xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kDhfF-0004BN-0O; Wed, 02 Sep 2020 22:20:01 -0700
Date: Wed, 2 Sep 2020 22:20:01 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: [PATCH v1 1/6] net/can: Initial host SocketCan support for CAN FD.
Message-ID: <20200903051958.GA249987@xilinx.com>
References: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
 <b401e976ac9c73cf1582bca95442a255676ce940.1594725647.git.pisa@cmp.felk.cvut.cz>
 <20200901200119.GA152258@xilinx.com>
 <202009020951.44751.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202009020951.44751.pisa@cmp.felk.cvut.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca5ce21a-d375-4232-040a-08d84fc90347
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3489:
X-Microsoft-Antispam-PRVS: <CY4PR0201MB3489993C74851EB49D96B5B3BC2C0@CY4PR0201MB3489.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwJhirSsV6b+G0UY6ht/8sgkfcJgcmfR+ZzffitIJMnyBTAeLURYkEjY/A4S0fp0+wlbjniQWoGXw9du6cuunSNzjeoUsKb13gBHlwTkqoo+kn3Ew4M0C/24fMB4qZi5Jk0H1mSskpAd9WULeB9fia/TTho4qG32ILqExcMKPO/Kx7sfd5KZCWna+YJyMGnMWMzncZRTfeQPuKNscEaDrfU2WU61Z+Bfw++RdPh8xfiDJp3gnj19XRlf8U5GrKUbdZwr9JgOBKCDLMUaqgaWNaH40fmX2HBSWhBRqdxPRcLnPskFELCy9pbxU5TPuR6/v1xQGlK5WMr3vM09DWM7qrV/+IVKyqHozIeCegt6Fq7xJKbIxGXyhIQtICnI1feG3jw276Al6QNMlaFoXTTyXbvEmPSk4fdeairXbCUUUUA31NDFqR2R4xD8RzUbY69R5etZ7BwsrGqKFtbTWpL59RzOmFnvaER4+XKhoSVqMpMVgApd/KLop5QGeVOiX+9f
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(376002)(136003)(39850400004)(346002)(396003)(46966005)(36756003)(966005)(7416002)(8676002)(478600001)(2906002)(9786002)(8936002)(47076004)(82310400003)(81166007)(82740400003)(70206006)(356005)(70586007)(26005)(1076003)(186003)(6916009)(7696005)(4326008)(426003)(2616005)(336012)(33656002)(5660300002)(316002)(54906003)(27376004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 05:20:03.4631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5ce21a-d375-4232-040a-08d84fc90347
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3489
Received-SPF: pass client-ip=40.107.94.49; envelope-from=fnuv@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:35:11
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

On Wed, Sep 02, 2020 at 09:51:44AM +0200, Pavel Pisa wrote:
Hi Pavel,
> Hello Vikram,
>
> thanks much for the patches review.
>
> On Tuesday 01 of September 2020 22:01:26 Vikram Garhwal wrote:
> > Hi Jan,
> > A couple of comments on this patch.
> >
> > On Tue, Jul 14, 2020 at 02:20:14PM +0200, pisa@cmp.felk.cvut.cz wrote:
> > > From: Jan Charvat <charvj10@fel.cvut.cz>
> > > @@ -185,13 +204,34 @@ static void can_host_socketcan_connect(CanHostState
> > > *ch, Error **errp) addr.can_family = AF_CAN;
> > >      memset(&ifr.ifr_name, 0, sizeof(ifr.ifr_name));
> > >      strcpy(ifr.ifr_name, c->ifname);
> > > +    /* check if the frame fits into the CAN netdevice */
> > >      if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
> > >          error_setg_errno(errp, errno,
> > > -                         "SocketCAN host interface %s not available",
> > > c->ifname); +                         "SocketCAN host interface %s not
> > > available", +                         c->ifname);
> >
> > May be this formatting change in a different patch? As this is not related
> > to CANFD.
> > > @@ -232,7 +272,8 @@ static char *can_host_socketcan_get_if(Object *obj,
> > > Error **errp) return g_strdup(c->ifname);
> > >  }
> > >
> > > -static void can_host_socketcan_set_if(Object *obj, const char *value,
> > > Error **errp) +static void can_host_socketcan_set_if(Object *obj, const
> > > char *value,
> > > +                                      Error **errp)
> >
> > This one also not relevant change for CANFD. Rest of the patch looks good.
>
>
> I am responsible for mentioned lines change in net/can/can_socketcan.c.
> When I have reviewed patches after Jan Charvat theses submittion,
> I have done another bunch of rounds to check that the patches as well
> as the whole net/can and hw/net/can are checkpatch clean. I am not sure
> if the incorrect formatting sneaked in in my 2018 submission or patcheck
> became more strict last years.
>
> I can separate these changes changes into separate patch if required.
May be we can keep them in same patch. I was just referring to "Don't include irrelevant changes" section on this page about patches: https://wiki.qemu.org/Contribute/SubmitAPatch.
>
> By the way, if you or other of your colleagues is willing to participate
> in net/can and or  hw/net/can patches reviews, I would be happy if you
> join my attempt and we can record that we are available to take care
> abut these in MAINTAINERS file.
Given that I spent good amount of time working with net/can, I am willing to review the patches. Thanks!
>
> Best wishes,
>
> Pavel
>
>

