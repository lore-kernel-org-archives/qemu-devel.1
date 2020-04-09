Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EE7C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7D420757
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FYvSxWFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7D420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMcGZ-0003Mp-1u
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMcFX-0002L0-Gg
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMcFW-0001Ee-J0
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:50:03 -0400
Received: from mail-db8eur05on2070f.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::70f]:28609
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jMcFW-0001Dh-Cb; Thu, 09 Apr 2020 14:50:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW0e6lhONdwfDlhsD6T1mBfYBWkxMQ2TSs6E0vB1ztjPy9l3V3/04eIx0694DX3Z95gJDtg3rYGFgdEkwPStvSDL8n2nzeDEgbxiX/xIz6bQUWZspwI+OcaRusVFNITFvnX6ia653Pp00PbEdAnQ7qOXEVqXI+2hki2urkTkvKmSmVh+9RyzcHDnF76hbSeNFkoyRe6LxES3tPGDjguvOkfvwsjx9bS0ILz1baPCQZ8zDjuBLTZCsoobi2sZBeEnWjFVYOhKV02JrAnJohfGFzVlgXfOORk/AK8lArvumya7oWiV7vneYL88xcH9CPXPBzpyovMV41TtLXIdkhGtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vracaPBgp620C1qVagg4vz1DXpDxOaxn5hn6Bv1NPGo=;
 b=IF2/d27GLXNKVbGcKCf+Go1umxOd/9nI8Jrchvyqgub77HLB3/cNHu85jbi3hfECsZIJG5s45/GDoq0B/2+LXDeiITDs5xi2dADV/Gh9dbSHTKBQwqkKP3sd/gur/0t+DK234rzUpAlv5gmEkC2JVpfXkT4dWE5PwXMZ0Kk5gO+GA8libqHeCBc+tTL1wQv0acJTF8dU89mlFwo8f5Pykcz5HNR6K6Xrgzx/46cF5VjOeQ9/klqQGtauGJ18NQeJQsEuOVgJjQxOyqOsO+VAjxYc0Q3HafjXqfX2xwj2JQyXuUHZkWIoLoP4Cxms24PFlmewU5Wu0FAMpExLXrNodg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vracaPBgp620C1qVagg4vz1DXpDxOaxn5hn6Bv1NPGo=;
 b=FYvSxWFqtqrEH3h3aMAIGCf4cKJRfmff/841QdcilEGLHbuN2PPR8D/nygEDgfRSLXDtGFYd/Bjm5+cTmJPiZTjXM2JEsD80Hpzd0xhIiSRSioOvvJHQ9DCE60E2qYcf347Qc869+6n8Ik/PjHtM1/k3io9UrNFANkiNRKUbmeQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5445.eurprd08.prod.outlook.com (2603:10a6:20b:10d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 18:50:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 18:50:00 +0000
Subject: Re: [PATCH for-5.0? 0/9] block/io: safer inc/dec in_flight sections
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
 <20200409170034.GD319181@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200409214950929
Message-ID: <e13c2bbf-6d8d-440f-78f1-761380dc6e49@virtuozzo.com>
Date: Thu, 9 Apr 2020 21:49:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200409170034.GD319181@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0088.eurprd05.prod.outlook.com
 (2603:10a6:208:136::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM0PR05CA0088.eurprd05.prod.outlook.com (2603:10a6:208:136::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Thu, 9 Apr 2020 18:49:59 +0000
X-Tagtoolbar-Keys: D20200409214950929
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47f1849b-1b22-40ad-b899-08d7dcb6ce7b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5445763EB6443708642FF252C1C10@AM7PR08MB5445.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(39840400004)(136003)(376002)(346002)(366004)(66946007)(956004)(478600001)(4744005)(4326008)(316002)(2906002)(6916009)(52116002)(107886003)(16576012)(36756003)(6486002)(86362001)(2616005)(31696002)(5660300002)(66556008)(8936002)(66476007)(31686004)(16526019)(8676002)(186003)(81156014)(81166007)(6666004)(26005);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c3J1o7J6VwjkZULiO0w6G7xQ90qriiDKHHQt8AD+OjU+tWNGEpJOYjG0ihpw6Sj7GGq639PijYLyggytEO6Mg+tEq4qum46taDTL79T1i2ZZXha4RqIiyS+mRKREVma4e215b/gW+IFq3khROJZcjLx6CVHeEsJk+0Zo5bVRCkQzhh8xCQqZSEKLuQ3wbphKh9DEtA+zXE/nVbjfB7ymRMeEjBKJYP37/dM2Mu6GSH+sGfsp4vevt7lG/CxcUF6codAshMKg5ELj34MFY0INSvMjIeeXycUCtRt0cZ+eYPCJk8oel3ICeM4PzzM/W/L61RoMVhqkGm4gLrcCFMwAPfszSaxgLkYyeeRR14Kvm2keGKhBse9Xk9bGN9k4KiGjdzlP+9Fe0lMYakA8jPvvOVVG1MOEzMR0R5CYJDho/sP3xglR2j3sb4A9jXvombz6
X-MS-Exchange-AntiSpam-MessageData: cC7UX/wueoHgNz+ZRYoKGxwhIv31Tm5dL1sj3hwpCffPM5Ob21noYVvfRsf0oO2Jv5Y1EIoBasPodcFNoVX4axriZBpi2TW7vtx0eo8FmUNQH/ln9uLL/eDydRcSqnhr7yNNsilk9UtOWmua02RyPg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f1849b-1b22-40ad-b899-08d7dcb6ce7b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 18:50:00.4987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9cB5mYCWRnNklXjbvbnh0W9zcrOBKQmWie40mrUjCFHxONuAw86UtXffYH0zUan99b6wnjtw4TvqgZ7IIb7SsjcIq4HBer75zvqFtM/7xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5445
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:7e1a::70f
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.04.2020 20:00, Stefan Hajnoczi wrote:
> On Wed, Apr 08, 2020 at 12:30:42PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> This is inspired by Kevin's
>> "block: Fix blk->in_flight during blk_wait_while_drained()" series.
>>
>> So, like it's now done for block-backends, let's expand
>> in_flight-protected sections for bdrv_ interfaces, including
>> coroutine_enter and BDRV_POLL_WHILE loop into these sections.
> 
> This looks like a code improvement but let's leave it for the next
> release since QEMU 5.0 is in freeze and this patch series does not fix a
> specific user-visible bug.
> 
> I will review this in depth next week.  Thanks!
> 

Hmm, it possibly fixes some bugs, but at least I didn't see them :) Anyway, it shouldn't be a degradation.

-- 
Best regards,
Vladimir

