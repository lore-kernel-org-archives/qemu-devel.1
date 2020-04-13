Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5EDC2BB86
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0B820678
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="guW9d0ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0B820678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNwrv-0004Yp-1K
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 07:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jNwrD-0003qR-WB
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jNwrD-0000wV-2B
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:02:27 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com
 ([40.107.8.131]:65185 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jNwr9-0000uj-2Z; Mon, 13 Apr 2020 07:02:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE4S/JhBdRLQDlW22gbvgQuF0w08PwTq/wonA7933B/gnnqeDgzjjozonxoeuEgS6qBvTH7QnAP2eTzlXOrUNyKbE5t/8z+BG6DHWKgYFKkHmhmrI2DS6BEgJ8W+pTVyh5DBKnsWM9BqA+SIQU3JjjuTTS2zp5HveLUOHZWUPWhJqldBMdGuIHuuNzJ5fR5k3Usqus6TplyXFbKeo2RcRiK6tr91n7eRIsRxAdwhIVW+ugSV4awuPgAZIeg2rvFbNVFVg8fNGPABrYt67+076M4E9yu9tnW99fQwY0shht9qLTbz42TgS+bRQzDVm1eDK8Rweq42Gg98wRXuxHCLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0tattTLOncM8SuGTLm5b/2PCsetlu9mOHtxiaFrPUs=;
 b=NDzkVw/ly2TtSvQ6dG8ScDs3HmxgIBqF/Ee26ZJoUPQ4GL0Ps0M7lXJB6fLAtN+0nw14bzoPJm07sMzTdMokvIrtJI9aDm1GUGUa90Vk7IR0j1/ZIYxFmWxzwz91iHrSH003X4X0u7VJuNG026nSM0fN/oJb0OomGe/SWmYWTcPlWaATfLwWVYieMLdzLLc39S/GJqaiPsduiHITJHefwew2w8wURtSYCzM9mDG9bFzA0Bzu7LqXPjRBVe4pVzxWsZvCmPr8ZY4yDE+mNwbUj/psObT8boxHESMyJHM7QADPxBLd2CYur4V1nS8+Qpu7dX3z1bdbTOv2EGh3yx7V5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0tattTLOncM8SuGTLm5b/2PCsetlu9mOHtxiaFrPUs=;
 b=guW9d0dsHjNI/ZsKddyLe/Je8NXhg0ALk6CMjBESwqz4aBB9kHbDSrssKOVmdUe4FvzR4Pnd8GUFZYX2Bs6asLEAjztepVimPpeFdkWVmntma8TsrIskgKuNxcueFX2xW3v+kgHhmSlpdbaiofBAG51U7PH6qk/VyIPktFnEoes=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5527.eurprd08.prod.outlook.com (2603:10a6:20b:de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Mon, 13 Apr
 2020 11:02:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 11:02:20 +0000
Subject: Re: [PATCH v4 10/30] qcow2: Add offset_to_sc_index()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <daf4559e162269c1be195d954d4cf38e9b2231f1.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200413140218454
Message-ID: <dd085ece-f638-765f-77bd-bfe5cddc4534@virtuozzo.com>
Date: Mon, 13 Apr 2020 14:02:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <daf4559e162269c1be195d954d4cf38e9b2231f1.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0113.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.133) by
 AM0PR01CA0113.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Mon, 13 Apr 2020 11:02:19 +0000
X-Tagtoolbar-Keys: D20200413140218454
X-Originating-IP: [185.215.60.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bcea1ba-de51-4e18-623d-08d7df9a22cc
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5527D3D95478F3F63CE2F1D1C1DD0@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(346002)(396003)(376002)(366004)(39840400004)(956004)(4744005)(2616005)(16526019)(66476007)(66556008)(316002)(26005)(16576012)(54906003)(186003)(31686004)(5660300002)(66946007)(52116002)(81156014)(8676002)(8936002)(2906002)(6486002)(36756003)(478600001)(107886003)(4326008)(86362001)(31696002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ryrjjh0osG0Hqh0aZS20tzLoIQSmdpR4pLk7btdBIRYORfPryN0bqh3CnwxU5zKfQwsLr7mbBNUoGCWWkINokZXDvJEC9wCIKp1bYg08WamREVi+yp8wr/w+CDwoPMSQYW3674mpYFLHG/k0lRZpSSd9h/Dp1Anroc95W9ZSmv3Wb9TzaQtKcuu5opU322hDXWWiKU9p5GGVVHwDrJfXX7CnHFh6dcHEopsOvk+szLDauNw/iOLBulEU1K+UrBHGCBzhFjjt9eKQY+UfXE3m0ewAyqALOZjitPTttnampv5jTvZOFni1ylBYMKo13iNjuwcdHpcXuLoF4Cf5hhsfdmqN5FUKhhdwIGl8B3da50m+5P6fA/XFaH9TRm4ouBiNKZR+sYIUT3z1lK6ebh4pBWGv7mEfHuoUEoBm7I33HdLv6kOgIeXsCFoJBeMincLA
X-MS-Exchange-AntiSpam-MessageData: NcVZXoZry48nEYQwBFpWe13l+sSL9EaQDS2TZqWMUIB1hn5iwsigsLD4VnvHrVZ0D6hI8qQyaiOZYmMONHjhMdMzvylplEWugSsTJVWkWqtVktlnEMFiJDyySlzTl6mad11DAgSD8hVha+oivs7/ow==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcea1ba-de51-4e18-623d-08d7df9a22cc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 11:02:20.0006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lpTwUgXYVeHKnpBLmKOQqdcjUmFs73oLJZaohERG1NxJk0r8kd5Xl+hRht3KG41l8iucqucISdt/LElMAQ4//yDvrfiat1+OAwHzeTNyo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.131
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
> For a given offset, return the subcluster number within its cluster
> (i.e. with 32 subclusters per cluster it returns a number between 0
> and 31).
> 
> Signed-off-by: Alberto Garcia<berto@igalia.com>
> Reviewed-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

