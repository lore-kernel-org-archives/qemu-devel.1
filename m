Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC9FC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2983E2068E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XR4UYR3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2983E2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKtj-0001ss-8v
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <michals@xilinx.com>) id 1ieKZB-0004vw-T8
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <michals@xilinx.com>) id 1ieKZ6-00035b-P8
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:03:17 -0500
Received: from mail-co1nam11on2077.outbound.protection.outlook.com
 ([40.107.220.77]:33544 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <michals@xilinx.com>) id 1ieKZ6-0002zh-Bi
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:03:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFB3hcVaAGIUbxUMObw/Loe7Or7jx+zzHXu2MnzS4JwEVDWxVKyWhteEd81A1X7Xq0gY7P5KHiG8dBDr5RAdxsMtZH6oypAWF7giJffiz3oVk+8owUR/sOqgJw8qDQqJuJOd3dUlJtNH4969oJwjmgXY3foivP2YEBhq+wYINCaJJz4AgwNsvlYkGZpEWRmCOyo30vWo4B61rwKatxGfyvn5SOgfvlvDhsfh+gL7/6U/41c3kwcMoz71HzHcSufQrD0BIWmddsbfq7cfR3NPLbWaxXQ15luRFyAHf0/TxpOlTaFYS4sNVHy4kJMWGxet8nh/bwaNdRiCt4tpeHeonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DktADPHNdKbivPRd1Ij5JPxIOd5MKDhmodedl4y8O+g=;
 b=YQvIVoSSfBKgO5t8AVrdl0f5RIWbVlimTBeOX1OYjRCUBXjCiS4FhGlZU9CmRUrB5rGkPh/ckwEVPt6o5buy3G79lBEs73OhAz0JaPp/u4MH9RZCKZuBVSzEEm3HhcfUqEk/mLGTTHehsPARpZ/3Q0Ugm2aQmT/IXpQU+h9jGTSng+aBpE8o1LO6kPkefZLPG6J9J84nq4A/UWHzbhlvk8riN/x8I467h6qhxkXdaFk/rWQ7Q1kTG8HFjzJSSD/zARFB/2t2Di/AAsuLgh8WCOXnCy4dGStrgaQwLYIAsdPecaWOxtWeYgSMBFmm/fMUy0Lfe34gLdK8z08SEN4sFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DktADPHNdKbivPRd1Ij5JPxIOd5MKDhmodedl4y8O+g=;
 b=XR4UYR3WY9/IoxDC4Cb1fMfRkLz4uoj1/psue1891JwA8GwKxQEp+Cm1MjqP+RoCi5SIizj8JeIdqmois89GkvwDEFfRxhajpTNrG+taC/shbpFe4OgVIy9NUZmwzbhKG55MFpX/HJRnLxseqPqL9lsMacUc7BDRnaXwiScRqjA=
Received: from CY4PR02CA0009.namprd02.prod.outlook.com (2603:10b6:903:18::19)
 by BN7PR02MB5233.namprd02.prod.outlook.com (2603:10b6:408:25::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13; Mon, 9 Dec
 2019 15:03:09 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by CY4PR02CA0009.outlook.office365.com
 (2603:10b6:903:18::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Mon, 9 Dec 2019 15:03:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2495.26
 via Frontend Transport; Mon, 9 Dec 2019 15:03:08 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1ieKZ1-0007xe-Q8; Mon, 09 Dec 2019 07:03:07 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1ieKYw-0006Ik-MU; Mon, 09 Dec 2019 07:03:02 -0800
Received: from [172.30.17.107] by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <michals@xilinx.com>)
 id 1ieKYv-0006Hp-8i; Mon, 09 Dec 2019 07:03:01 -0800
Subject: Re: [PATCH 1/5] arm64: zynqmp: Add firmware DT node
To: Guenter Roeck <linux@roeck-us.net>,
 "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
References: <20191018160735.15658-1-m.tretter@pengutronix.de>
 <20191018160735.15658-2-m.tretter@pengutronix.de>
 <20191208223814.GA21260@roeck-us.net>
 <dbba2a25-cbf7-60f4-99f7-056512e28d00@xilinx.com>
 <4821742f-2d60-b722-b954-263de975bf2e@roeck-us.net>
 <20191209074840.GP32392@toto>
 <d2e63acb-c076-7bfb-c492-0355ec106cbf@roeck-us.net>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <fa36a9e9-9e44-d1ff-cfdc-22d0484318ff@xilinx.com>
Date: Mon, 9 Dec 2019 16:02:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <d2e63acb-c076-7bfb-c492-0355ec106cbf@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(189003)(199004)(70206006)(2616005)(9786002)(81156014)(31696002)(4326008)(36756003)(70586007)(44832011)(5660300002)(229853002)(6636002)(31686004)(230700001)(53546011)(478600001)(8936002)(305945005)(336012)(26005)(356004)(8676002)(6666004)(54906003)(110136005)(316002)(186003)(81166006)(426003)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR02MB5233; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76127af6-71f5-4b80-a4a5-08d77cb8e6df
X-MS-TrafficTypeDiagnostic: BN7PR02MB5233:
X-Microsoft-Antispam-PRVS: <BN7PR02MB523349D866F89A8EEF87D36BC6580@BN7PR02MB5233.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02462830BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jC1l0FuAK6gV7mZiVHHeEiP4D50WWmiRH7MViIAOVB8fiqDBtrkNJIL3CZQh8XGS8ve8l7yiKNf4/Xf580pVgowz+Nsx7udYnz161a3FJIUROwThm9jo1+HNwf9Wyt0ROV4dDLNmEiLxIt3R5g5t55Dqb3wbP+v/BtO7qTAKG3rr2A7hCi0qTjhAYgPd2zR5Gc/pk7xj+56UAlS8wvrrVoM/fbB+yUlKImrQxC8aMOk9HveSToE1VO1JXV825rsr19owB8ZWdrIGV3921DQ3dlLYmpMv1GVyTA96uBvhiCwncs+WgUhB7RCM36nyPJXIVPZ+430iQFTVwk7OZd8ZCq7OAT1DMZTVDM8Yipm/oSWfnclNmiH5p/JcrqSJF0JSXolUnbL4lSYBzmWIVMEB+hGkfhXgBN5TCx7/LuNCwf60qbKPsTjCmsgb2SVM0Mu
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 15:03:08.3716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76127af6-71f5-4b80-a4a5-08d77cb8e6df
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5233
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.220.77
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

On 09. 12. 19 15:32, Guenter Roeck wrote:
> On 12/8/19 11:48 PM, Edgar E. Iglesias wrote:
>> On Sun, Dec 08, 2019 at 11:19:33PM -0800, Guenter Roeck wrote:
>>> On 12/8/19 10:42 PM, Michal Simek wrote:
>>>> Hi, +Edgar
>>>>
>>>>
>>>> On 08. 12. 19 23:38, Guenter Roeck wrote:
>>>>> On Fri, Oct 18, 2019 at 06:07:31PM +0200, Michael Tretter wrote:
>>>>>> From: Rajan Vaja <rajan.vaja@xilinx.com>
>>>>>>
>>>>>> Add firmware DT node in ZynqMP device tree. This node
>>>>>> uses bindings as per new firmware interface driver.
>>>>>>
>>>>>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>>>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>>>> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
>>>>>
>>>>> With this patch applied in the mainline kernel, the qemu xlnx-zcu102
>>>>> emulation crashes (see below). Any idea what it might take to get
>>>>> qemu back to working ?
>>>>
>>>> Driver talks through ATF to PMU unit(microblaze). I don't think A53+MB
>>>> concept is working with mainline qemu. But crash is too hard. It should
>>
>> Yes, QEMU doesn't support the Cortex-A53s along with the PMU MicroBlaze.
>>
>> My workaround when using upstream QEMU is a modified DT without the
>> PMU firmware
>> and with fixed-clock nodes.
>>
> 
> I can't do that for my boot tests. Normally I would just disable
> ZYNQMP_FIRMWARE,
> but that is hard enabled with ARCH_ZYNQMP. I'll have to drop those tests,
> unfortunately, if the firmware driver is considered mandatory.

We can make it optional.
Rajan: please send a patch for it.

M


