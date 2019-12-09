Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95F7C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 08:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940AC206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 08:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hWJm3iN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940AC206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieEV0-0005ys-QX
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 03:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <michals@xilinx.com>) id 1ieEUL-0005RH-8z
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 03:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <michals@xilinx.com>) id 1ieEUJ-0007WX-JW
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 03:33:52 -0500
Received: from mail-eopbgr700075.outbound.protection.outlook.com
 ([40.107.70.75]:41408 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <michals@xilinx.com>) id 1ieEUJ-0007W7-9f
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 03:33:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lw56ADF2OagahoWIm4V2+MkID+OEs1khluR1789TyWmEJc9DHa8sTUu+nLG6OSjluBtGc4DLx7rMzJe0mtfcxJva64Y7XSN5RPnXBDpKWiLy6uiVOrN1RiBXT+FmNzigykL64PkvXs7fLDynyOZnVyp2SH5t/EO2z3Aq+5UW1g1vPqIY/UzFe0pha2y65kmxCGZg/zXbFZxaWraK4ZWmiDESdZ1psEAzfnS0amUfhO0RDBIa/pjLPxpH06P3JY3/9JPQL5IUV5HmZ5JeYLgclkhq/hKmm1Li2VuQcWqLjwwYbvIRg9fmdVSfAjm1IUnbL6lSZOUMfItJzyqvJGLkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I86StYEjr6zuNW3Goe8nOXDlCOuFt8CDvVA0zgAUYM=;
 b=M7Bd9/BLDGXq5zHn8RFD5wTyom0QUwDR5Cn0NgkBxiA4Gl+fT2mplmygPtPdrsrLJ5eagGMtIP/zD7AVvH3qryKaIdBS1boxqulfGdnfAojKMw3ansHlOvQU2UkM4Pkx0r2HnH4Sa427fi1wOtaoTaISOiraz3TErnOV5ZiU9GNR/lEcAQGOOGJ7tUGeSEStWw/kIHAkN+ZH1fKOj1NEMoUeP980ZI78HMCt/LsnNF3zPOC8OOXLbSCuXn4o7Q4uHi4RfnzCpcVfXOgUQsthSzHDI0UhU3ZNQ5je9WVhbRCvIklXpPWF4kCYOOBPUm/5/e243HtiBWewVMhx9IZ2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I86StYEjr6zuNW3Goe8nOXDlCOuFt8CDvVA0zgAUYM=;
 b=hWJm3iN1EPq0E3jwLFVRZGMBifzdej273IBylAnoENweisrFncSh4Cc+Pt6g2xHaPgA28eJk8rpFvgr4JVeN2sJC1vPP7xpnQhBJsvs1+J1JQo1rxuG8Bp0elKVPPQqbxoR6NLCv6wUZyM8+edKfRZMZ1LW1vu8O0rG5h8NFiaM=
Received: from SN4PR0201CA0051.namprd02.prod.outlook.com
 (2603:10b6:803:20::13) by MN2PR02MB7022.namprd02.prod.outlook.com
 (2603:10b6:208:1f4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12; Mon, 9 Dec
 2019 08:33:46 +0000
Received: from SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by SN4PR0201CA0051.outlook.office365.com
 (2603:10b6:803:20::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Mon, 9 Dec 2019 08:33:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT018.mail.protection.outlook.com (10.152.72.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2495.26
 via Frontend Transport; Mon, 9 Dec 2019 08:33:46 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1ieEUD-0005Gc-MQ; Mon, 09 Dec 2019 00:33:45 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1ieEU8-0002oE-JB; Mon, 09 Dec 2019 00:33:40 -0800
Received: from [172.30.17.107] by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <michals@xilinx.com>)
 id 1ieEU4-0002nD-4V; Mon, 09 Dec 2019 00:33:36 -0800
Subject: Re: [PATCH 1/5] arm64: zynqmp: Add firmware DT node
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Guenter Roeck <linux@roeck-us.net>
References: <20191018160735.15658-1-m.tretter@pengutronix.de>
 <20191018160735.15658-2-m.tretter@pengutronix.de>
 <20191208223814.GA21260@roeck-us.net>
 <dbba2a25-cbf7-60f4-99f7-056512e28d00@xilinx.com>
 <4821742f-2d60-b722-b954-263de975bf2e@roeck-us.net>
 <20191209074840.GP32392@toto>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <8052c6d7-f447-0977-6e2a-4e2f6ec9ded8@xilinx.com>
Date: Mon, 9 Dec 2019 09:33:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209074840.GP32392@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(396003)(136003)(346002)(189003)(199004)(36756003)(2616005)(31686004)(229853002)(54906003)(110136005)(305945005)(966005)(70586007)(336012)(70206006)(31696002)(478600001)(58126008)(5660300002)(316002)(53546011)(36386004)(8936002)(65956001)(76176011)(186003)(44832011)(426003)(4326008)(230700001)(26005)(8676002)(9786002)(356004)(6666004)(50466002)(2906002)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR02MB7022; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 664e8391-e3fd-44f9-7aa3-08d77c8281d4
X-MS-TrafficTypeDiagnostic: MN2PR02MB7022:
X-Microsoft-Antispam-PRVS: <MN2PR02MB7022D54DE7C520DA218E98C0C6580@MN2PR02MB7022.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02462830BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jKajiT+D028EolmSF2l3s0ueIaqLlqu220yKyfo7vnxxq/XvAdAGcU06ZoZRIwTchM1Xsaw4MAs1N/ZHKyDRogK5j1Z00KA0EqX4TY8iSf+rzRjTw1S0jdzwkS2NGbTwHm4kie+xQ2jLLziMBS+4kpX3/mo/Q+fXci3hW2XigvOZaWwOFqi9wGGEvh50MdeSFvyyLHZ1r5cdlXMWXTM29mRuiRRqBwBwqLUJmSSlpOMvSCcTgbNHxMHDNFsZAeFNgUhhQUhHcbeA1dn8mdcuEDaa5SGiwL7h1n0/fg1PyabMTZ6lMgKcAfSsZGvk+Ibc2cjIuUJgFqHgGHAKh++CT8CUeM+qDhYbuW+jH8BOvVhGv0akad1bcTh/ND7oVrqvkyVY9GB6TianJXMq/Fvt58ngvE6jYq+iv09o+yx/sR6DwFFbW615k09ChY6uAcR2oAozXWt2ZqW0C4b3vV96ntMnE/ywuW3ezBHBcPetT0=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 08:33:46.0862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 664e8391-e3fd-44f9-7aa3-08d77c8281d4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7022
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.75
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Rajan Vaja <rajan.vaja@xilinx.com>, qemu-devel@nongnu.org,
 Michal Simek <michal.simek@xilinx.com>,
 Michael Tretter <m.tretter@pengutronix.de>, Edgar Iglesias <edgari@xilinx.com>,
 robh+dt@kernel.org, Rajan Vaja <rajanv@xilinx.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09. 12. 19 8:48, Edgar E. Iglesias wrote:
> On Sun, Dec 08, 2019 at 11:19:33PM -0800, Guenter Roeck wrote:
>> On 12/8/19 10:42 PM, Michal Simek wrote:
>>> Hi, +Edgar
>>>
>>>
>>> On 08. 12. 19 23:38, Guenter Roeck wrote:
>>>> On Fri, Oct 18, 2019 at 06:07:31PM +0200, Michael Tretter wrote:
>>>>> From: Rajan Vaja <rajan.vaja@xilinx.com>
>>>>>
>>>>> Add firmware DT node in ZynqMP device tree. This node
>>>>> uses bindings as per new firmware interface driver.
>>>>>
>>>>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>>> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
>>>>
>>>> With this patch applied in the mainline kernel, the qemu xlnx-zcu102
>>>> emulation crashes (see below). Any idea what it might take to get
>>>> qemu back to working ?
>>>
>>> Driver talks through ATF to PMU unit(microblaze). I don't think A53+MB
>>> concept is working with mainline qemu. But crash is too hard. It should
> 
> Yes, QEMU doesn't support the Cortex-A53s along with the PMU MicroBlaze.
> 
> My workaround when using upstream QEMU is a modified DT without the PMU firmware
> and with fixed-clock nodes.

IIRC you said that there is still discussion how to upstream this.
Fixed clock should work for u-boot too. But SPL reads that registers
directly. Are you implementing them with any default values?

> 
> 
>>> be no response from PMU and then this panic.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/xilinx/zynqmp.c?h=v5.5-rc1#n728
>>>
>>
>> Isn't that a bit harsh too ? Normally one would print an error message
>> and abort driver instantiation.
> 
> I agree, it would be nice if ATF & kernel drivers would somehow handle
> this more gracefully.

Rajan: can you please take a look at it?

Thanks,
Michal

