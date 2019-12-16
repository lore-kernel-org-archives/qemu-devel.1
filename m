Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6548C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 06:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F48720725
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 06:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Qs2ETkPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F48720725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igjsi-0003oC-K8
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 01:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <michals@xilinx.com>) id 1igjs2-0003PW-GB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 01:28:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <michals@xilinx.com>) id 1igjs1-0007oQ-3M
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 01:28:42 -0500
Received: from mail-eopbgr690042.outbound.protection.outlook.com
 ([40.107.69.42]:65409 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <michals@xilinx.com>) id 1igjs0-0007hn-Ns
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 01:28:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/hq5v8TuADHAaDlbPJfJlwtXtosZhVuVbGfELbpK15klH9im/oOluLX86lsArAlHUxaGZcyKDAaKw8FaiFtZ8CRCrrz72JOcQu6WzlxoY2q6dCaXl/LwexbNh5KSX/MvcT5F+sXLMGwiXE/h4MCIuE8EQKDUb0Vd55ONyW4/whBNg+CUq/pdjimlwLk1UAOKfPH217E2F32Yj5CVqZCHJsvkmQ/tO5d1YTDqWyKqTwO14xZRZ3KIQy93WIId12jNmi1BJe4MFfV8g9sJWE0N97aYBYaEtFYhje72Vb2qcjoKBMgvjWmyvZTuAVQJQwdJ+Is2b0kqXwoLmTTbVdN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya+21yvykUVqTrYy5Im2aNZwhEU3y6nDuWKOSYVQ0wk=;
 b=Ih/l4A/iUcusJaNu8wiWtlreg/MYxAsOZBWfDPBWBrGhkCWpgPR/DdtWffPRDlJfhEeltLIfVW76sHIJXUgfeGLgPQfFqh5VgYeDinSYqhbAnEH1cz2UvMpffY0u3EaPYPo4dDXZ/Mf9553YrIuns211d0ii3sdfdPF8DV5DTJ0XNfE0AQXwHAlT28FM68o05oF1G6jDQ/oD4VbguqPORW9j+P558bTJBOAGQaP1gA45aj5t2iU1TxqU7fSXpfiTj5M6R35CeSZpsuYfusguBa25+dYwiCLrX4dmpWeLWUpaO+NfBGhaEXXKMS2dKwbu4bjTUKZ97t9+7JctfBHN0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya+21yvykUVqTrYy5Im2aNZwhEU3y6nDuWKOSYVQ0wk=;
 b=Qs2ETkPJkiFmgoRlatwaJBvAdNnJwF4vwXdBtHEX1OCZpIb5Wa6P2+6cGJfgjHvLBXQ6QfXj5WO3IgDlJxpybGV+bKfU61AC4SJSQEUeyrZQhT4naqSJSMJcl0xr22AHLW81Uc0gIoqbOKkmAODvNjdu9cOVPA3SIswsLaooysg=
Received: from SN6PR16CA0069.namprd16.prod.outlook.com (2603:10b6:805:ca::46)
 by SN6PR02MB5213.namprd02.prod.outlook.com (2603:10b6:805:70::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Mon, 16 Dec
 2019 06:28:37 +0000
Received: from SN1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::9a) by SN6PR16CA0069.outlook.office365.com
 (2603:10b6:805:ca::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18 via Frontend
 Transport; Mon, 16 Dec 2019 06:28:36 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT014.mail.protection.outlook.com (10.152.72.106) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Mon, 16 Dec 2019 06:28:36 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1igjrv-0007Mq-Oz; Sun, 15 Dec 2019 22:28:35 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1igjrq-0000pi-Ka; Sun, 15 Dec 2019 22:28:30 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xBG6SRhI015266; 
 Sun, 15 Dec 2019 22:28:27 -0800
Received: from [172.30.17.107] by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <michals@xilinx.com>)
 id 1igjrn-0000oE-7b; Sun, 15 Dec 2019 22:28:27 -0800
Subject: Re: [PATCH 1/5] arm64: zynqmp: Add firmware DT node
To: Guenter Roeck <linux@roeck-us.net>, Michal Simek <michal.simek@xilinx.com>,
 "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
References: <20191018160735.15658-1-m.tretter@pengutronix.de>
 <20191018160735.15658-2-m.tretter@pengutronix.de>
 <20191208223814.GA21260@roeck-us.net>
 <dbba2a25-cbf7-60f4-99f7-056512e28d00@xilinx.com>
 <4821742f-2d60-b722-b954-263de975bf2e@roeck-us.net>
 <20191209074840.GP32392@toto>
 <d2e63acb-c076-7bfb-c492-0355ec106cbf@roeck-us.net>
 <fa36a9e9-9e44-d1ff-cfdc-22d0484318ff@xilinx.com>
 <573f0472-9779-c5df-f199-4e0958753fd8@roeck-us.net>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <ba5e00b3-2208-6398-1df4-337978db128b@xilinx.com>
Date: Mon, 16 Dec 2019 07:28:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <573f0472-9779-c5df-f199-4e0958753fd8@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(199004)(189003)(8676002)(81156014)(36756003)(9786002)(31686004)(54906003)(81166006)(8936002)(26005)(31696002)(426003)(70586007)(70206006)(356004)(6666004)(44832011)(4326008)(186003)(53546011)(478600001)(2616005)(2906002)(110136005)(336012)(6636002)(5660300002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR02MB5213; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91cd6f35-74b7-4228-295a-08d781f12e77
X-MS-TrafficTypeDiagnostic: SN6PR02MB5213:
X-Microsoft-Antispam-PRVS: <SN6PR02MB52133F83B8D25BAD66F7AA4DC6510@SN6PR02MB5213.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02530BD3AA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRDdeDgAawJX2om2/hChdy6+UhbaMNciEYSQGKjlYiffhjJiINjBhPJ9lN9Oa7CbiCbtM4E9VKiVVaKNM7eaIFwVQbP7mzBR30Kqhaorbhz/5Ubiau28PLvbPvR1qkysYAADuqQJ+zUgobk1mUTUkmePNCuF6J4BwtxwAJXtR9DjEI325ZyP/RglVmh8pKuotijgU+mhOGSxIM7m6IguWY3NHRXC2p5Q6kAZsfiBw4pK4eke2z5Z2Jwx8Ktjqi9hfD9aFX8odCwyaiup5JKfYiKxrvg9Y6qzyF9A5KH1Hut6dct+eKWOo7RLeTDnwsEvqPXOZntVs7z2tfpPBNbP8JOyKmNfbX1EvOZd/qzcZ9PAa2+Iy5thpk/vY1Bpn7refe9UXZbOmBuXDsclELz/VjKsnw/P1vgmtRJcPvUssubRunG5dlQIjw40A0ZJOJQ/
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2019 06:28:36.1756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cd6f35-74b7-4228-295a-08d781f12e77
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5213
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.42
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
 Rajan Vaja <rajan.vaja@xilinx.com>, Michael Tretter <m.tretter@pengutronix.de>,
 qemu-devel@nongnu.org, Edgar Iglesias <edgari@xilinx.com>, robh+dt@kernel.org,
 Rajan Vaja <rajanv@xilinx.com>, linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15. 12. 19 6:28, Guenter Roeck wrote:
> On 12/9/19 7:02 AM, Michal Simek wrote:
>> On 09. 12. 19 15:32, Guenter Roeck wrote:
>>> On 12/8/19 11:48 PM, Edgar E. Iglesias wrote:
>>>> On Sun, Dec 08, 2019 at 11:19:33PM -0800, Guenter Roeck wrote:
>>>>> On 12/8/19 10:42 PM, Michal Simek wrote:
>>>>>> Hi, +Edgar
>>>>>>
>>>>>>
>>>>>> On 08. 12. 19 23:38, Guenter Roeck wrote:
>>>>>>> On Fri, Oct 18, 2019 at 06:07:31PM +0200, Michael Tretter wrote:
>>>>>>>> From: Rajan Vaja <rajan.vaja@xilinx.com>
>>>>>>>>
>>>>>>>> Add firmware DT node in ZynqMP device tree. This node
>>>>>>>> uses bindings as per new firmware interface driver.
>>>>>>>>
>>>>>>>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>>>>>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>>>>>> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
>>>>>>>
>>>>>>> With this patch applied in the mainline kernel, the qemu xlnx-zcu102
>>>>>>> emulation crashes (see below). Any idea what it might take to get
>>>>>>> qemu back to working ?
>>>>>>
>>>>>> Driver talks through ATF to PMU unit(microblaze). I don't think
>>>>>> A53+MB
>>>>>> concept is working with mainline qemu. But crash is too hard. It
>>>>>> should
>>>>
>>>> Yes, QEMU doesn't support the Cortex-A53s along with the PMU
>>>> MicroBlaze.
>>>>
>>>> My workaround when using upstream QEMU is a modified DT without the
>>>> PMU firmware
>>>> and with fixed-clock nodes.
>>>>
>>>
>>> I can't do that for my boot tests. Normally I would just disable
>>> ZYNQMP_FIRMWARE,
>>> but that is hard enabled with ARCH_ZYNQMP. I'll have to drop those
>>> tests,
>>> unfortunately, if the firmware driver is considered mandatory.
>>
>> We can make it optional.
>> Rajan: please send a patch for it.
>>
> 
> I'll disable the related boot tests for now. If/when this is fixed, let
> me know,
> and I'll re-enable it.

ok. Sure.

Thanks,
Michal


