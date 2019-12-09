Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5EDC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 06:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED7FA206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 06:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EMlHPcYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7FA206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieClq-0001St-6U
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 01:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <michals@xilinx.com>) id 1ieCl8-00011h-Bf
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 01:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <michals@xilinx.com>) id 1ieCl7-0001iR-3A
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 01:43:06 -0500
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com
 ([40.107.94.76]:7872 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <michals@xilinx.com>) id 1ieCl6-0001et-Nf
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 01:43:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5FCFC7uXNGc3qZa8N+qoclEOOjtuYDX63pX8Zbvudql8dgbbGU55heuPQOStT7icyi1mcoNFumpqK5QsFwCo+i0oIxvgn771gSq04vhVduvvX3biJV+3xyHISxxj6wZ/WXHkjn8OQKYs5XWul/FDEFSaGosQwbK5VVMhXKExCl7paL3p57G4WL9bZNcFBpgdgccHqMmKPDlJt3+/OGvyBZlUD0690A8nQWHJ/3jAqH10A98YYkJ2/L6eZ/W7en9LgYMKLzy+G2YguxVb+gHDPfzBhcNz37mpfLt37boJsdl087bUSyK7gOK7XBiWoFTh7lm4DZKmQqBypTPrZI97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apPILfMRueEB1z7Fh68u4wPtwBgtf5coUL8hAfR6K1Q=;
 b=Z4qYmkBK8NXZRi6kYTz+VvA06Jzjzh8CF0ff1GkN57mx5taU6C+q8r9ePaONwHQCRwZ7vyIgWo37On+uRZj2CaBfLIc3NUeWD788spDlX8cQNQD94mu4MnZAZ10diDEJ2H/6P6XQtHmshKI3vcf2YXQSfst8qjjvwasioglNbrE1o5dnv3kqQ6Dh8Hdm848fH9SBJdjVvLY/uwFkBho4bPZZFJrU0WeHm0iHVim5sVtaBSQ3nQx2qkGZe+4MMTOH6dcwYIOJeK2tRhKhN4VtrIGKul7WNZnRglHodGwiC2+tfiJyDCT79wcKd+XZ9VHotzSB0Ycr7lw+zuaA4ePx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apPILfMRueEB1z7Fh68u4wPtwBgtf5coUL8hAfR6K1Q=;
 b=EMlHPcYKCST1uBo8AUxoNUTPbFbAwmOI8IGQtRnZcHVP0Qzd9RhP3UqpMgFaOKA+/mL9F8iTSMXctWBivqi0bAM/5gMOkQ4SzcZaSnVPlEXljBhlr5eo6OPSxxPGgE03bKimMYTg+//2x6nUZD8xoO6H4NUGMFmWf7gQb+CX//g=
Received: from BL0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:207:3c::24)
 by DM6PR02MB5372.namprd02.prod.outlook.com (2603:10b6:5:44::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.18; Mon, 9 Dec
 2019 06:43:01 +0000
Received: from SN1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BL0PR02CA0011.outlook.office365.com
 (2603:10b6:207:3c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Mon, 9 Dec 2019 06:43:01 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT015.mail.protection.outlook.com (10.152.72.109) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2495.26
 via Frontend Transport; Mon, 9 Dec 2019 06:43:01 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1ieCl2-0004cG-Ky; Sun, 08 Dec 2019 22:43:00 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1ieCkx-0004TM-I0; Sun, 08 Dec 2019 22:42:55 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB96gk0x010978; 
 Sun, 8 Dec 2019 22:42:46 -0800
Received: from [172.30.17.107] by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <michals@xilinx.com>)
 id 1ieCko-0004ME-Hm; Sun, 08 Dec 2019 22:42:46 -0800
Subject: Re: [PATCH 1/5] arm64: zynqmp: Add firmware DT node
To: Guenter Roeck <linux@roeck-us.net>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Edgar Iglesias <edgari@xilinx.com>
References: <20191018160735.15658-1-m.tretter@pengutronix.de>
 <20191018160735.15658-2-m.tretter@pengutronix.de>
 <20191208223814.GA21260@roeck-us.net>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <dbba2a25-cbf7-60f4-99f7-056512e28d00@xilinx.com>
Date: Mon, 9 Dec 2019 07:42:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191208223814.GA21260@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(4744005)(65956001)(8676002)(4326008)(229853002)(336012)(5660300002)(426003)(31696002)(305945005)(81156014)(81166006)(36756003)(186003)(9786002)(2616005)(230700001)(44832011)(70206006)(316002)(2906002)(50466002)(76176011)(478600001)(70586007)(966005)(6636002)(26005)(36386004)(31686004)(54906003)(8936002)(58126008)(110136005)(356004)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR02MB5372; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f65465d-ab4a-46cd-bac2-08d77c730915
X-MS-TrafficTypeDiagnostic: DM6PR02MB5372:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5372358791F62B42F7A6C2DFC6580@DM6PR02MB5372.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02462830BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTKNCu+9lnes7fCcSi6pVbG5fDCD0nI15fm05Reb8ifJx7PEPitf1TNBQpyrVxQt/2D87AStNrUH/B7wNJbJdDYZ2jlRk8H7DwkLWA7MS9VVH6Tl4jnWJBL4Scfe+DAs6NRJL5wWwjCC1a3vi7i7OZ70ZF9JSd8noVFUzhCDbh+fx40GBfhQEqCNPdC2QwA+ih9GZibA36XnSn6nYQxwJMmipBelmPqo5gRhzdKcLsmzyjKxBNY3LqhMw/cM0cQuhBvwCdPYmtuucx2iJXZ4ErN9zxUYl0iWo5VZN/Ajd9eLN28JrNvxBD4a1nHF2JPEC1x9PlpzK8qftFNL1qArtYTfXUfjBCoA2R326/KfH0SF9bTeo99XBIdz+tzY2AErpCOtagLnsXoWxdo4uyHXkLgI4t9fK85XWbG98KwKb1oqLf5bC0Fhf8pn8v4pdHjSFJOlUZ5Cq5u7UILmHeuxSTzRunsQ6im8t+rhIalnmWs=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 06:43:01.0595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f65465d-ab4a-46cd-bac2-08d77c730915
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5372
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.76
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
 Rajan Vaja <rajan.vaja@xilinx.com>, michal.simek@xilinx.com,
 qemu-devel@nongnu.org, Rajan Vaja <rajanv@xilinx.com>, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, +Edgar


On 08. 12. 19 23:38, Guenter Roeck wrote:
> On Fri, Oct 18, 2019 at 06:07:31PM +0200, Michael Tretter wrote:
>> From: Rajan Vaja <rajan.vaja@xilinx.com>
>>
>> Add firmware DT node in ZynqMP device tree. This node
>> uses bindings as per new firmware interface driver.
>>
>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> 
> With this patch applied in the mainline kernel, the qemu xlnx-zcu102
> emulation crashes (see below). Any idea what it might take to get
> qemu back to working ?

Driver talks through ATF to PMU unit(microblaze). I don't think A53+MB
concept is working with mainline qemu. But crash is too hard. It should
be no response from PMU and then this panic.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/xilinx/zynqmp.c?h=v5.5-rc1#n728

Edgar: can you please comment this?

Thanks,
Michal

