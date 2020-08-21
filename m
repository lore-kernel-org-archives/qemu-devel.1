Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F9BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CFA220720
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dcUeGf1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFA220720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94A6-0006ST-Cc
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1k949R-0005re-JN; Fri, 21 Aug 2020 06:20:01 -0400
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com
 ([40.107.243.43]:10208 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1k949N-0000xz-E6; Fri, 21 Aug 2020 06:20:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxUFhT/YXRm/vSdp2+tYwyJ9D+JwO6tBgy3DxzTvWiS9Lv4ZEEp+pLgp+JhoSuQR8NNaq/0wiOQsWA4be/eV5O6IMwbV2dlQYlHpdZnmwmhLEQyelGT9E6so052sf8HxLVW+waFux+a+TIearSzQ04sSZJ/twbVBQigg4O3TFknqcKJE1d6SkE9/v7lkQF4Zk/ljn9ECmjH7FFTUJ9TVQfhVONTivV06TgENgkxyXSH+6mXMFumbRnaPBk9CkTfYK6wEDyHM9NQJt2UZDSdbYc7bTftQ87fB7OZWCvJZzAwAx/PiGJKar7YeNyAIJTlMzqmQDlWaZ8bB/3PqzAARCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv53hRZskM+LTY/tEzvQ1PuyGyUbJx74V82Ao2CRLG8=;
 b=b9tk5kc/rUVLTxK6XTsPWqOCbx2hzsQgam55vG3B5HMzPucx6kaTB62Ab4vgcx5tpzD5tmMEfQ02Q+rWtcYH9kXwf7jUI/Gp9Y48qqZ5Lkw16SSBjo6GJ9GQuYAyvBEDM/R5rMcBvJIlFIHLfjzH4V9TujKhlMoBpOLer94udkem4kU++imsTO6sRI3mlF2zkVGuVbGO/xafVF8Ye+HVJhazvD8kgLRNeINOYQR++/LIas2ycQWvL9wYhZ1tCMQGpqNcvvOEGY+uT8lsEfP2O+iIOcbkCUmuS3ce9q3kfS5PUBQBDSbFpXyO1jfrO1IZ6uUVCbT63tE/L53Qn3QyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=amsat.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv53hRZskM+LTY/tEzvQ1PuyGyUbJx74V82Ao2CRLG8=;
 b=dcUeGf1/wlyeyQBf4viVpVBzkUuMAvx6BD9CqBjmCBa+S2C+TPtOQmUPokcs8esBfXSmvfhqXA4+zfC9WuDWsOXbptnmxB+qlSW4dpQwCka+P94inDc+nRsX50P6ijR1PjRXJP74ZUOcAE3cv0RbrNN+8XAcq+QijsB1pw8akH4=
Received: from CY4PR01CA0007.prod.exchangelabs.com (2603:10b6:903:1f::17) by
 BL0PR02MB4673.namprd02.prod.outlook.com (2603:10b6:208:55::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Fri, 21 Aug 2020 10:04:53 +0000
Received: from CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:1f:cafe::f7) by CY4PR01CA0007.outlook.office365.com
 (2603:10b6:903:1f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Fri, 21 Aug 2020 10:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT027.mail.protection.outlook.com (10.152.75.159) with Microsoft SMTP
 Server id 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 10:04:52
 +0000
Received: from [149.199.38.66] (port=35298 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1k93uQ-0005BZ-3v; Fri, 21 Aug 2020 03:04:30 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1k93um-0006Qf-HB; Fri, 21 Aug 2020 03:04:52 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1k93ug-0006QU-9R; Fri, 21 Aug 2020 03:04:46 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id A3AEB13C0585; Fri, 21 Aug 2020 15:39:40 +0530 (IST)
Date: Fri, 21 Aug 2020 15:39:40 +0530
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 07/18] hw/sd: sd: Fix incorrect populated function switch
 status data structure
Message-ID: <20200821100940.GA30457@xhdsaipava40.xilinx.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-8-git-send-email-bmeng.cn@gmail.com>
 <565d9936-3eda-db2f-b390-05f675cf6644@amsat.org>
 <BY5PR02MB67720168B25F53370840545BCA5C0@BY5PR02MB6772.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BY5PR02MB67720168B25F53370840545BCA5C0@BY5PR02MB6772.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Content-Transfer-Encoding: quoted-printable
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0a7ff01-52d0-4a57-379c-08d845b9a5e8
X-MS-TrafficTypeDiagnostic: BL0PR02MB4673:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4673848ED1975806E2E28F04CA5B0@BL0PR02MB4673.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+WGIC/Zc3l7++URT74o5rq2DRznjQaqGY9Eg+p9TQdrPPQnaxOZHL1ah3CED+9F1b0loWJ8i+U8pM6PEh+CEzzArCgzglCPNlZpz9bXM7l4v9ryruQaLUFxSZigeGWiI3nOU4tOoLEmBlR9KEjComh+C+sWcmB+MV4gmKoKqN1epsSVfHdUz44cOcyoI1OGBM1h77o/JDS7+mNXBBpCi9WbHumBNZBcH2xjLY1DsQ3DHdgFeJiSgwPjxuW/9KaFsU8V+w/BZOOVXXNiUKqn4MYHwnTDRi37FFcy57pYPmwOJSybRmwN4EIUTpFBEJu95qUkThaHvj/+Si4y78LGV6yal/zCQ1DH38RetZTbWFF0UT7zuUn00AeImcx0JDq6Z0RxHxV+A6A3r+B4xpR2cA==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(39860400002)(136003)(346002)(376002)(396003)(46966005)(6266002)(70586007)(5660300002)(8936002)(6916009)(426003)(53546011)(70206006)(1076003)(33656002)(107886003)(336012)(186003)(47076004)(316002)(54906003)(356005)(4326008)(26005)(8676002)(82740400003)(478600001)(7416002)(81166007)(42186006)(2906002)(82310400002)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 10:04:52.7520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a7ff01-52d0-4a57-379c-08d845b9a5e8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4673
Received-SPF: pass client-ip=40.107.243.43; envelope-from=saipava@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 06:19:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, saipava@xilinx.com,
 Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

First two patch of SD look good. Tested them over zynqmp and versal
platforms.

Thanks,
Sai Pavan
On Tue, Aug 18, 2020 at 04:30:15PM +0000, Sai Pavan Boddu wrote:
> Thanks Philippe,
>=20
> I would test this and get back.
>=20
> Regards,
> Sai Pavan
>=20
> > -----Original Message-----
> > From: Philippe Mathieu-Daud=C3=A9 <philippe.mathieu.daude@gmail.com> =
On
> > Behalf Of Philippe Mathieu-Daud=C3=A9
> > Sent: Saturday, August 15, 2020 1:29 PM
> > To: Bin Meng <bmeng.cn@gmail.com>; Alistair Francis
> > <Alistair.Francis@wdc.com>; Bastian Koppelmann <kbastian@mail.uni-
> > paderborn.de>; Palmer Dabbelt <palmerdabbelt@google.com>; Sagar
> > Karandikar <sagark@eecs.berkeley.edu>; qemu-devel@nongnu.org; qemu-
> > riscv@nongnu.org; Sai Pavan Boddu <saipava@xilinx.com>
> > Cc: Bin Meng <bin.meng@windriver.com>; qemu-block@nongnu.org
> > Subject: Re: [PATCH 07/18] hw/sd: sd: Fix incorrect populated functio=
n switch
> > status data structure
> >=20
> > +Sai Pavan
> >=20
> > On 8/14/20 6:40 PM, Bin Meng wrote:
> > > From: Bin Meng <bin.meng@windriver.com>
> > >
> > > At present the function switch status data structure bit [399:376] =
are
> > > wrongly pupulated. These 3 bytes encode function switch status for =
the
> > > 6 function groups, with 4 bits per group, starting from function gr=
oup
> > > 6 at bit 399, then followed by function group 5 at bit 395, and so =
on.
> > >
> > > However the codes mistakenly fills in the function group 1 status a=
t
> > > bit 399. This fixes the code logic.
> > >
> >=20
> > Fixes: a1bb27b1e9 ("SD card emulation (initial implementation)")
> >=20
> > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > > ---
> > >
> > >  hw/sd/sd.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > > index fad9cf1..51f5900 100644
> > > --- a/hw/sd/sd.c
> > > +++ b/hw/sd/sd.c
> > > @@ -806,11 +806,15 @@ static void sd_function_switch(SDState *sd,
> > uint32_t arg)
> > >      sd->data[11] =3D 0x43;
> > >      sd->data[12] =3D 0x80;	/* Supported group 1 functions */
> > >      sd->data[13] =3D 0x03;
> > > +
> > > +    sd->data[14] =3D 0;
> > > +    sd->data[15] =3D 0;
> > > +    sd->data[16] =3D 0;
> >=20
> > Pointless zero initialization.
> >=20
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >=20
> > I'll wait until next week in case Sai Pavan wants to test this patch =
(I don't have
> > access to the Xilinx images anymore) then I'll queue this via my sd-n=
ext tree.
> >=20
> > Regards,
> >=20
> > Phil.
> >=20
> > >      for (i =3D 0; i < 6; i ++) {
> > >          new_func =3D (arg >> (i * 4)) & 0x0f;
> > >          if (mode && new_func !=3D 0x0f)
> > >              sd->function_group[i] =3D new_func;
> > > -        sd->data[14 + (i >> 1)] =3D new_func << ((i * 4) & 4);
> > > +        sd->data[16 - (i >> 1)] |=3D new_func << ((i % 2) * 4);
> > >      }
> > >      memset(&sd->data[17], 0, 47);
> > >      stw_be_p(sd->data + 64, sd_crc16(sd->data, 64));
> > >
>=20

