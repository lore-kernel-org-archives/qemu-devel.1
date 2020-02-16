Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EE4C3404C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 01:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D195624656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 01:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KvHLPfF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D195624656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Dvo-0004yU-0F
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 20:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar@xilinx.com>) id 1j4Duj-00046L-4S
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 20:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar@xilinx.com>) id 1j4Duh-0001hi-Rd
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 20:12:32 -0500
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com
 ([40.107.223.67]:6062 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <edgar@xilinx.com>) id 1j4Duh-0001hA-IC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 20:12:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUlOSbuKlW7jrVzR4bmQKO+O6AecH0hy5hHpxp4jHJHEHAA5Wx6ZZSPi8vyldmACjgZyN8Nel2Il4KfUYyfmdQYyTAR5JYSto2plMewckjIOtlIYs4Uo7HG9X50FQJlNzOnWagTcx53RjgRizL69v0m+fkP2LtuENu/b4tzflXVZyqUHIvy3xhECVW34tNU0IqEPm5xVcwgPLi/IvcZQIgBgePEgOUIIMjXWDpmzC4TbSeBJ5f59xuMy9BVzQvMO1SF/X0xvi4Q0akAtk802/VRhY/41YSBgVfUwJgEiQmLUt21iF8KIz77G3ozFUH5u5CgYuJa9DRnY+fOAOnFnPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV/X8nRcH7T+OYkCnKgAqAvTrQuBkHttgT7hz1O+xRE=;
 b=G0R2fn9nhX9tDHRDsTRKQ2ROWc5IgZSAvAd/Ek5Gh+CHBghkqXQx2lSzoKsCyFzKJ9DPDZe8Sc/RV0rlbdChMywWBmRCijT4Gztd4l/pkPeG370Wvn0Q1DkZ696qmn/rPS7OCBSOd713V9pG/N4p1nRmb+7DdIND2ST/2pfvLnNUPB14Sk3L2Wbi6Ladx3Ti67lRVWO+a0WlJDd5mzCqZ6cl/eAL1HKN47eDaCsn/GsfUS31LLL9tDQi+9HqNJizyt8XAeBznIk7WSfSDMyMn9jBM5Io44v88uh5BBAUuuC4YSxe0+uir4xX9boUAHqpLs+9mXl5UqHbPv6CcneBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV/X8nRcH7T+OYkCnKgAqAvTrQuBkHttgT7hz1O+xRE=;
 b=KvHLPfF+U5bwNGF27WiKlqhcNkg4veNrtMvCAunaiDBnVyP4SkEegH0f0Oi7D0SIeZD/TNq05ikSXGUlptW1tDNmFRcQ+JZ9xGqRBAt8kkRlBH70yyr28o7/2srlGM4hA2LFLNaX4Ppv7H6ubRX1VdoUP4r7z+qmBJIplTDX0eg=
Received: from CH2PR02CA0020.namprd02.prod.outlook.com (2603:10b6:610:4e::30)
 by DM6PR02MB5164.namprd02.prod.outlook.com (2603:10b6:5:50::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25; Wed, 19 Feb
 2020 01:12:28 +0000
Received: from SN1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by CH2PR02CA0020.outlook.office365.com
 (2603:10b6:610:4e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend
 Transport; Wed, 19 Feb 2020 01:12:28 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT047.mail.protection.outlook.com (10.152.72.201) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Wed, 19 Feb 2020 01:12:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1j4Dud-0000Rp-Pc; Tue, 18 Feb 2020 17:12:27 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1j4DuY-0003Kd-Md; Tue, 18 Feb 2020 17:12:22 -0800
Received: from [10.23.117.67] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1j4DuV-0003KS-MS; Tue, 18 Feb 2020 17:12:19 -0800
Date: Sun, 16 Feb 2020 17:04:13 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Subject: Re: [PATCH] xilinx_spips: Correct the number of dummy cycles for the
 FAST_READ_4 cmd
Message-ID: <20200216160413.GF22292@toto>
References: <20200218113350.6090-1-frasse.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200218113350.6090-1-frasse.iglesias@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(7916004)(4636009)(189003)(199004)(33716001)(33656002)(70206006)(9686003)(186003)(70586007)(26005)(9786002)(8676002)(4326008)(356004)(1076003)(2906002)(8936002)(5660300002)(6666004)(81166006)(81156014)(498600001)(6916009)(66574012)(336012)(426003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR02MB5164; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02a66fe3-d411-47e1-e2a3-08d7b4d8c981
X-MS-TrafficTypeDiagnostic: DM6PR02MB5164:
X-Microsoft-Antispam-PRVS: <DM6PR02MB516471C9487D29247435D467C2100@DM6PR02MB5164.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0318501FAE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIUX6X7M9TgUXfG27vmTeA/wBwkYCQhsTWt7f9FVjbU/aNEjyFx+TCCVp+DoTcb35NvSRLEtuX7A4112i8xPOmum/PoH6LXygen0iJduUyoRwy2quPh3joq7xXpyum/HpcPe4/35CNX+ePlGoNiv/m3jMYPF15qI6ZOFHrnyZdPiwk1Gwn5qcRZYrXkkW8hA1ECBYDurPrn8elxZvyU1IPvfpaFVY7wttAIxJKrhliwdYrqQXjDYtZ9auTNcKhVuH9VJL5+R6TWV0YuUoDwRqPIXqYsEwshcN5GZKPFs7j0ktk2hjxeMeTTkPQhByhOhGwtH18Ks257xE5B5z6PPIUFix5/2TY6fhXjEtmjTouDzGwAZCdESQ8UYEqlF+hJac0V8p1YZSX9T21H+NfnUxQWdjjXyQKgJYrZ2Og9LCvX0CO0SqrkiT1rh/SsqJGwM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 01:12:28.1761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a66fe3-d411-47e1-e2a3-08d7b4d8c981
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5164
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.223.67
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
Cc: peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com,
 alistair@alistair23.me, qemu-devel@nongnu.org, edgari@xilinx.com, clg@kaod.org,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 12:33:50PM +0100, Francisco Iglesias wrote:
> From: Francisco Iglesias <francisco.iglesias@xilinx.com>
>=20
> Correct the number of dummy cycles required by the FAST_READ_4 command (t=
o
> be eight, one dummy byte).
>=20
> Fixes: ef06ca3946 ("xilinx_spips: Add support for RX discard and RX drain=
")
> Suggested-by: C=E9dric Le Goater <clg@kaod.org>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> ---
>  hw/ssi/xilinx_spips.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 6c9ef59779..c57850a505 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -576,11 +576,11 @@ static int xilinx_spips_num_dummies(XilinxQSPIPS *q=
s, uint8_t command)
>      case FAST_READ:
>      case DOR:
>      case QOR:
> +    case FAST_READ_4:
>      case DOR_4:
>      case QOR_4:
>          return 1;
>      case DIOR:
> -    case FAST_READ_4:
>      case DIOR_4:
>          return 2;
>      case QIOR:
> --=20
> 2.11.0
>=20

