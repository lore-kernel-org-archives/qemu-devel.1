Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AE5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71E2206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QZs8E31Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71E2206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtCMx-0001zV-4b
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 11:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtCM3-0001Cn-5w; Wed, 08 Jul 2020 11:51:27 -0400
Received: from mail-eopbgr150098.outbound.protection.outlook.com
 ([40.107.15.98]:65302 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtCLz-00086i-Nj; Wed, 08 Jul 2020 11:51:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3M7bl3Bhk0lmLhb3QPr+w5cXrujGeuKcYFchorzKLm91vpGliRwYNxbfDmfClfK68vq7g5bA1bAR36VDu0LuTynBg7ppE8mhiPRAIzFVG98ZyrUoaWv/fh8Mw+qPjxFZLDmXjE70QoRMUHUi1qOLagDsiSST+SsENe2KtS5Y1lvvGGnltUdAclvf69Jjq8GVDL1rLs0R7ayOGU76hu1Bp7RpBJA/bbLsiN7rhwRWvNYPGsEpJbywieioYNTBw9fP3mYekkKG6+hVB/Z8bfTROrADTMSfQXs+j9kI1zPDD3WmuRZYX1KP123wK4CsmYdiIigXx1SUR5VAOV6GhhOHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAH7RSnyKVxHwMNgfjZpQyZulnN96nvo/4/eHmbYQI0=;
 b=UO54ivSuEenPrk6a8siNGXZcaDcKqGgf8+fRLgmJfS98jzXutklffPDkB08daVvYoUYkscsnsrLzuOkVgOkUqt4t/ktOZH0YwwsyGMrW4GnOO0nG2wdkeS63fI4Tz91ioBt4VX17VJryCSy35pqYGWL2RrEbvBbnGU9lusSxMnb2PAJLPCbfttEQNPTYkAbG6fDBe344vsorF15k7y4FkXn01hWQdBvClstJ+QOstPFabSxVgrdUsq/uAbfjAjWGEl3j/YXFKXOUHc4m+30AWKaK9TKjOtBu+r9zgWY/Ots2LodeZ3AWcuK6WNsHx9h8dEuTFLp4syIvxksKW2xtPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAH7RSnyKVxHwMNgfjZpQyZulnN96nvo/4/eHmbYQI0=;
 b=QZs8E31QPbVWo9Ef0Et7Zy8WL6nHGxVpO+zP9BoVvGnJAWhx6ULhkFlnUhEV9ccRncu1UI+RzseVaj/b3qKVuzoIzMwiQmIElhRpHGUgaxzT/AqYT7g1gh+NeJoTh2pkI470f14wY9ldQKGfssvqmB9/xxucKx/zZ0AwnxK1nOg=
Authentication-Results: acronis.com; dkim=none (message not signed)
 header.d=none;acronis.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2981.eurprd08.prod.outlook.com (2603:10a6:209:44::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 15:51:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 15:51:20 +0000
Subject: Re: [PATCH 1/5] block/io: introduce bdrv_try_mark_request_serialising
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200620143649.225852-1-vsementsov@virtuozzo.com>
 <20200620143649.225852-2-vsementsov@virtuozzo.com>
 <20200707155640.GA459887@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6faa2ec5-9857-daf0-bf84-e42eb07897ff@virtuozzo.com>
Date: Wed, 8 Jul 2020 18:51:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200707155640.GA459887@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0030.eurprd04.prod.outlook.com
 (2603:10a6:208:122::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.17) by
 AM0PR04CA0030.eurprd04.prod.outlook.com (2603:10a6:208:122::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Wed, 8 Jul 2020 15:51:19 +0000
X-Originating-IP: [185.215.60.17]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3f8df99-1d21-4f60-4c33-08d82356c1d3
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB29813287AF241A6D0EBA3F3CC1670@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hOKv9FWhI9gBDdctKam7Pm/qUf8LYHPThBNDazsUgloiuptWEx9I56GmVUWJI8lS+w/Ms8YveQvwbiR27tEAQ9NBC/8DCD3BVGRwTOh4U6PBwVyLCNjF8hqPjJ4YoHY0Xb5A9IjgpCdplzifk+74rrDF1NepVtdgtFNP8pj8Ls8ksm6/X0xVuKKsmpwokZ/ljVW7N+BVwZJFeFJu+fSQRjHXSKriVVIcsMLE+6uGUq9LzF7N80ZeX8NEpzdVJ11ZrcM73fDhPtE9wG/FUvdVY8wzgsNFjdqUZFhe3Tj0ShEyBRvLzfrEew227qVgDe/gmxuIaiqjxsvrPJ0cIthCWpkuxXAljWQkMAmaCry3kPCCbBv42EOftDuCpidMFrcb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(16526019)(6916009)(52116002)(956004)(2616005)(36756003)(4326008)(5660300002)(83380400001)(66556008)(26005)(2906002)(66476007)(498600001)(66946007)(186003)(16576012)(86362001)(6486002)(31696002)(8676002)(31686004)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /T5o9GqMIq02YTMZC7fJ3fHnevVT5S6JcF5BvNayDfws8NMDdjPq4hAZ44BdflaQqahM5Zgihz0bl4hOzfOTxZ0z//SaV7/1wHLO6JV9sWn1eAOsNtBtUjOtemAUtvnyZ3OguDpYDDpPi0BjZv69fScJVckI41ywNQeqAMPButWR/ukwbDodl5vDbaVRq6mJrQ0dRbCBWre1L7dP8LDVzqg94zq4Mh3nKLfnbaD1G+Ci64ccdgtmdiRbOmFY7PIhUZ41aW0/27OkfqeT0C5rjpgj5q12RRUN4GaEWDBnWwZvK5yZCludsQnBn/X+KlhpxX641E1JHxS2zJ2/a1WkVuMYbdgSnSKVFYcqtK89b67NPN8p1rDYgBE+Jzi1Oj0x/cray7g9004wMIFnob3Ck6+FMX4jFzzoF2OHWzAB9C0CMsCC5on9n1xfuA1rPqtEFLjRXQVXgtG/tyxo6SDap9rfkdQKDkSfnucpdbPQFT4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f8df99-1d21-4f60-4c33-08d82356c1d3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 15:51:20.0776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaHImr8PuMxSo2hByRrTChbyKaR7N1MwnivAXeITzpjZER7fzZmYZLaXwtN7hD5ddfLY+yZmyNCe8lVBUFkc/vez+b3ZBe2wQO+KNgK6vL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2981
Received-SPF: pass client-ip=40.107.15.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 11:51:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 Anton.Nefedov@acronis.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.07.2020 18:56, Stefan Hajnoczi wrote:
> On Sat, Jun 20, 2020 at 05:36:45PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Introduce a function to mark the request serialising only if there are
>> no conflicting request to wait for.
>>
>> The function is static, so mark it unused. The attribute is to be
>> dropped in the next commit.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/io.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 51 insertions(+), 7 deletions(-)
> 
> I found this patch difficult to understand because there are multiple
> levels of functions passing flags to ultimiately do different things in
> a common function.
> 
> Here are some ideas if you have time to rework this patch:
> 
> 1. Introduce a bdrv_find_overlapping_request() function that does most
>     of bdrv_wait_serialising_requests_locked() but does not wait. Then
>     bdrv_wait_serialising_requests_locked() can call that function in a
>     loop and wait if an overlapping request is found.

I thought about it, but splitting bdrv_find_overlapping_request is not so clear:
it should include most of the logic inside "if (tracked_request_overlaps(..":
an assertion, and checking !req->waiting_for. So the semantics of new functions
becomes unclear, and it lead to splitting "->waiting_for" logic.. So, I decided
to keep the whole function as is, not splitted. I just can't imagine reasonable
split.

> 
> 2. Pass overlap_offset/overlap_bytes arguments to
>     bdrv_find_overlapping_request() instead of changing and restoring the
>     value in bdrv_do_mark_request_serialising().

I'm not sure that it would be safe to not add a request to the list during the
search.

> 
> 3. Use consistent names for flags: wait/blocking, found/success
> 
> I'm not sure if all these ideas will work, but I get the feeling this
> code can be refactored to make it easier to understand. Since I don't
> have a concrete suggestion and the code looks correct:

Hmm. Unfortunately I didn't record the problems I faced on the way to resulting
design, so I just don't remember now the details. So, I'll try to apply your
suggestions, and remember the problems (or we'll get better patch :)

> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 

Thanks!

-- 
Best regards,
Vladimir

