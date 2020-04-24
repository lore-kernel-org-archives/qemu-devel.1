Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F08C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 18:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38139206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 18:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tYxzY8MA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38139206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS2rs-00006c-7z
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 14:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jS2r3-0007oC-H8
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jS2r3-00020G-2l
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:15:13 -0400
Received: from mail-eopbgr40098.outbound.protection.outlook.com
 ([40.107.4.98]:26630 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jS2r0-0001nv-Ef; Fri, 24 Apr 2020 14:15:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3SSJXorTWCbOLlK9QfxnR4CO0Fo389tDQSAWWzuenetKqRJdUC7VpBvLx3SDWKz+EDYzQlSDXGKXtVmud8ulHzfg8iiZFZLN4DsqhVQFLW4311aVznThwZrnS4EUVhqWlMTgIwMwApUvf19l+jqc6kSOQ+N5JqxdQH1j7wngiJw/eJeRtMvtTU6E9j0gET0RUjwyOaIZOZKL+eSHUsdnbO7MNK+bFfExEo2WcQEiArkh1avmNOJeMItzM8tAJQx0jddgaPk968R307Z13XJG/rEJCni5wu95HJhcXycLi1G72z3GlohoyUSIlEnHNjfNp3IL2U9B49R687Uv9hYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7G3JCH4ZWjlxFUU9MCgYk5iO5GMzpL7qwz2BFlGxpk=;
 b=iv4RupChgclzRQXPl/zbsIzHJEUGFqS3UWTBrku94ILX3TJQYyGjFEKclbduZNlxj+ylqCvl5lz7KXsfJPULHfhSPUq98sHfsQv2BhKoPuSY48xxAowiNT+sDOpNq6XhVweyZT41f4lwwxEOh5MjsvPIXYYDyQl1eIP3b9fHWEvVrwMaUWYF576BppqWLIjqzx651iuarsjeqWSbUC1mlmB6uaygLWDCj8bu9HyFCOtSiQ4jG8z8E9sfLBTWvgy7C5/iaGL1gb+REli2l9lcUm9yTlns8wrfWZ0dUWR7S1kAJ8uRjXTToaePAXgoIaTcqpG0Bz0rJcQ3XwKhDfXLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7G3JCH4ZWjlxFUU9MCgYk5iO5GMzpL7qwz2BFlGxpk=;
 b=tYxzY8MAgkcIj7qIVPDX28ZviLAIdqRyK45xcMKg0snalwBC/lKwimW3HRHzK5mXco3JCs7F4z2O+K5ZjmJs7MybSuOrDVj5RgKzpirj/qCzqa6GUqNuBecVUoYQDpc7WZqLDR46n2DwExWQW0S6Owu7snU9ezAs+JMNyZ3/V9Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5304.eurprd08.prod.outlook.com (2603:10a6:20b:10e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 18:15:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 18:15:05 +0000
Subject: Re: [PATCH v4 24/30] qcow2: Clear the L2 bitmap when allocating a
 compressed cluster
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <6d596d82ed62615a8565b661691a06bfaf32237e.1584468723.git.berto@igalia.com>
 <w51r1wcn7eu.fsf@maestria.local.igalia.com>
 <1606ecb5-98ea-fefb-bb98-2ecda1d65f5c@redhat.com>
 <w51o8rgn6j6.fsf@maestria.local.igalia.com>
 <57ac1a2f-1632-1a00-b18d-1fc2169175b6@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200424211504395
Message-ID: <971a6e4b-ba44-4280-89fa-d454cddf12e1@virtuozzo.com>
Date: Fri, 24 Apr 2020 21:15:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <57ac1a2f-1632-1a00-b18d-1fc2169175b6@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0202CA0017.eurprd02.prod.outlook.com
 (2603:10a6:200:89::27) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.181) by
 AM4PR0202CA0017.eurprd02.prod.outlook.com (2603:10a6:200:89::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 18:15:05 +0000
X-Tagtoolbar-Keys: D20200424211504395
X-Originating-IP: [185.215.60.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79a941fa-f743-4666-f9f0-08d7e87b6a3a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB530429FDC56C293C7827B3A3C1D00@AM7PR08MB5304.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39840400004)(8676002)(36756003)(86362001)(81156014)(19627235002)(8936002)(2906002)(316002)(478600001)(5660300002)(54906003)(16576012)(110136005)(16526019)(6486002)(107886003)(4326008)(186003)(31686004)(66946007)(66556008)(31696002)(52116002)(53546011)(2616005)(26005)(66476007)(956004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fsu1wVYA9DA6yMTTEOKFxo2mE6nlz2zwCVW4ybv0ax+BFhHxCYmovi3R3qhKyN0M97pf4mcdrSqsnKXRmcigHSlb+VWuUFLEOC22+TSKmq8qMBWdXeEiTcu4GgfIoTtCheFxDO+/lww2cZWa7zs1XJqfzNx1qwCSkWT5LB1WQCKWPib5RASK4j4pYDCiTWlHtE7Vpp4Nn/8GXJC7FHnd4xCxXfA0XZ3gZP81mrHvm74lU6Xki2rwV68x+F+HRX+gY8R7RhpJQm12za1Q5YAZuJqSj02nUCmwYN8p11FVJNSvmkD7/ZvvAZzUDXJu6mBHjFqClHXPDi6Wp9VgbVEkYR0LMYptKleS+isbGXCacejEtuXJVMvSEodyEuOqrDfdz0yse0WtU2N7ZI9r3RaUGBIE+JQOU2fRDF1jNUfJWaIMZTgqd4z3vOSUpP03pINc
X-MS-Exchange-AntiSpam-MessageData: DN5OqtgN9jjzNyKJDJAYDREnoBcwGIm5mkEvL7qI/1UaIADiZagaIRbxuRo8smAAjTJIEe3x8YXN/3sn6G6wgcEDBCW/+Dlfkh0y9DIf+IXSTC55LfqX2MBLIy+OPCljliuRmb4/rJUeaD0Mm+gvMg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a941fa-f743-4666-f9f0-08d7e87b6a3a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 18:15:05.8748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzgPZtyo3mr4RM3sL73sEkvHUFlwr+rwaF3pMGsuGDPfOTQie9rRuH+JrvVEbPWmlO/gaz5LYRKJYLP9iJsFSCwrWtxDLKNvs98cHMmg90I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5304
Received-SPF: pass client-ip=40.107.4.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 14:15:07
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.4.98
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.04.2020 20:44, Eric Blake wrote:
> On 4/24/20 12:21 PM, Alberto Garcia wrote:
>> On Fri 24 Apr 2020 07:11:08 PM CEST, Eric Blake <eblake@redhat.com> wrote:
>>>> 'write -c 0 64k' followed by 'write -z 16k 16k' would not need to do any
>>>> copy on write. The compressed data would remain untouched on disk but
>>>> some of the subclusters would have the 'all zeroes' bit set, exactly
>>>> like what happens with normal clusters.
>>>
>>> It's a special case that avoids COW for write zeroes, but not for
>>> anything else. The moment you write any data (whether to the
>>> zero-above-compressed or the regular compressed portion), the entire
>>> cluster has to be rewritten.
>>
>> That's right but you can still write zeroes without having to rewrite
>> anything, and read back the zeroes without having to decompress the
>> data.
>>
>>> at the same time, I can see where you're coming from in stating that
>>> if it makes management of extended L2 easier to allow zero subclusters
>>> on top of a compressed cluster, then there's no reason to forbid it.
>>
>> I'm not sure if it makes it easier. Some operations are definitely going
>> to be easier but maybe we have to add and handle _ZERO_COMPRESSED in
>> addition to _ZERO_PLAIN and _ZERO_ALLOC (the same for unallocated
>> subclusters). Or maybe replace QCow2SubclusterType with something
>> else. I need to evaluate that.
> 
> Reading the entire cluster will be interesting - you'll have to decompress the entire memory, then overwrite the zeroed portions.  The savings in reading occur only when your read is limited to just the subclusters that are zeroed.
> 
> But then again, even on a regular cluster, read has to pay attention to which subclusters are zeroed, so you already have the workhorse in read for detecting whether a normal read is sufficient or if you have to follow up with piecing together zeroed sections.
> 

AFAIK, now compressed clusters can't be used in scenarios with guest, as qcow2 driver doesn't support rewriting them. Or am I wrong? And we normally don't combine normal and compressed clusters together in one image. So, currently, the usual use-case of compressed clusters is a fully compressed image, written once.

It means, that with current specification, subclusters adds nothing to this case, and no reason to create compressed image with subclusters. And even if we allow zero/unallocated subclusters, seems it adds nothing to this use-case.

So, I don't see real benefits of it for now, but neither any problems with it, so agree that it's mostly about which way is simpler..

-- 
Best regards,
Vladimir

