Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2C7C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 09:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D294206F7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 09:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SgzqI6yD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D294206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMpj8-0006qX-Jw
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 05:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMphu-0005Vu-3I
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 05:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMpht-0006r4-42
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 05:12:14 -0400
Received: from mail-db8eur05on2130.outbound.protection.outlook.com
 ([40.107.20.130]:4480 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jMphh-0006ng-JP; Fri, 10 Apr 2020 05:12:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mO/sTG3rwLfAXrnGD/QwGUXDvOYYLkmn0pdu/Imm1vf5/U+7c+eDZC6YmOO0LsM9Dm4wTDoxAd/1BOPv6ZvJ6AR2MGYY1XIGVLA4VaF2ILVODWLBvTk1yJlxAr94h6l0I+uTBFjHrkmgvhjjcBZ0Zxl8gcshAscjS7/zPIsWqDTRwuPE6cNSd6yRK37pP5DeaquI7FX9gfnCBSSm4MrQbkdNu1eleUdDigDsMTc/IlWWiQcLbThArTgzyjTjYJZ7kmpzI7/RsxK5Hr2GCfgeTgLfgHOzRksoDAd5Lx3wbHHJEBrjkWJuFDdkrg2eVLDFX8DyA5ljfb4X2TdHjaVm/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC/IscOwcu4DsXK4S9INyVtSTi4PEz4+SOsS8/bRvRU=;
 b=GIPAt7mAWIDVlAus19WQQZ9BjbUxFq2/E6ztVgorctsJ8dmRXLAYdiC6ZpFHlua4e9VJmuglCbqP/lubmUVHYS6JyIj+AACvvcIu9zuIpHUKrOzY9oi3K237JyAo3NCdnV6cOdftE5vGJ5qIZsATUVBaQ/KpOSDu9tXLjCWWh1NODtdFso9A5oklI/PyYwblefjtPIV2M2kEMsoJz4pCiX124dGl3g/a6WJGXGlvJpfeM3LAAkh0nT8dbHJEyhsY5VrFQ0gzfQKZlccihEqdyD1gPN7rXwRBrfCQ0lFVsGmL/oH7M2ZUy30enIFz1ucNBp9aXGPMBwAO3ieN5I8WOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC/IscOwcu4DsXK4S9INyVtSTi4PEz4+SOsS8/bRvRU=;
 b=SgzqI6yDAkfvykDt6t03YdrRnHHLIyUuNQLSRCKCIL/tAVm+rrR2sChktXi9WZXh5RRd9UciQpr8X6xRXMbvCwSBKlUNuXx/v1nsBrzsI2xvOhjAOtON0PDdVVi8UtbGnCtUr3A+iBCKDBYPyNlAheY+rGxgPiNVKhTyqAyLDlA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5510.eurprd08.prod.outlook.com (2603:10a6:20b:109::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Fri, 10 Apr
 2020 09:11:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 09:11:59 +0000
Subject: Re: [PATCH v4 08/30] qcow2: Add dummy has_subclusters() function
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <0e88d0a02693bc48e1cf5a411ae32af973a6c3c2.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200410121157367
Message-ID: <87373df4-9399-7d84-c07e-1e1b10f28c16@virtuozzo.com>
Date: Fri, 10 Apr 2020 12:11:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <0e88d0a02693bc48e1cf5a411ae32af973a6c3c2.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.134) by
 ZR0P278CA0047.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Fri, 10 Apr 2020 09:11:58 +0000
X-Tagtoolbar-Keys: D20200410121157367
X-Originating-IP: [185.215.60.134]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aededbc-8203-434f-fb61-08d7dd2f3960
X-MS-TrafficTypeDiagnostic: AM7PR08MB5510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5510A2ABEEA89D54388BC480C1DE0@AM7PR08MB5510.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(136003)(376002)(396003)(366004)(39840400004)(8936002)(81156014)(5660300002)(31696002)(66476007)(478600001)(86362001)(4326008)(66946007)(6486002)(31686004)(4744005)(66556008)(107886003)(52116002)(8676002)(54906003)(26005)(16526019)(186003)(2906002)(316002)(956004)(16576012)(36756003)(2616005);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JR3vTw8ofbnKAJzHCTzFH0KE8cOjfWO52aASZsOYg/QwExNxp9bpcuf28HoUo6puAI97QU6ppcpxqYqAQIZ8FR+IXk/gnL6HQ+q0DQpIKBsFFKrdeI5AyZvfFoabWOYzPF8FvaxcwaSrVziypDgyeL0S0k4yqBRxFhCXQ84LI6OTa2vZVhioN9mk7cqxt9WgbhaCEe72M31Dxrmux5sPPk11IyMf6kwAJfhKTejDr493ll4H7zzkXFTU7ZUN+WdRcT244MDCyATXGAvghUPfQris9TVPRNdFX8D6lson181UL8AhqBCm1GxYj/1/8kobOAq7WPBdwaYxrj0fomYhlilkHmQT65bm1aQqd20gY4ab7OB0N2tqIuFCXmqrYJU8MHrFGqce6TQiQvrAR5qV2Q07LCzR3FPkRdMIGqe/3ltwFPbByb8st4wJSXAluPDm
X-MS-Exchange-AntiSpam-MessageData: DbnOvGpq/s0ZyiT6QXNX9CitMUshMsF2o0pwydBJzAvUYPxAAuQ+DZ2F3EQmmHlncMZiUwYZEDm5kIKrYfBW2S5nDPpfGTCAOhhHwSVfD2PtZYdHGJtBuEwrGMZ/HJ2PAa0CBknvQReAC4vbaCQI1Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aededbc-8203-434f-fb61-08d7dd2f3960
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 09:11:59.5687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81bemNOzmTqP2wz79M+YY6IkigIoSODoPfC6VS8YO/pG92TNtmJPVn85cw4M/P+t0tR6fT/xHfVGr6q40WAiktME8miK9JR8XZofUUppeAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5510
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.130
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.03.2020 21:16, Alberto Garcia wrote:
> This function will be used by the qcow2 code to check if an image has
> subclusters or not.
> 
> At the moment this simply returns false. Once all patches needed for
> subcluster support are ready then QEMU will be able to create and
> read images with subclusters and this function will return the actual
> value.
> 
> Signed-off-by: Alberto Garcia<berto@igalia.com>
> Reviewed-by: Eric Blake<eblake@redhat.com>
> Reviewed-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

