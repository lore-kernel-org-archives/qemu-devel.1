Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E777C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535DD2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="p6j3/dtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535DD2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kArG4-0004qd-Jr
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kArFD-0004Ds-LR; Wed, 26 Aug 2020 04:57:23 -0400
Received: from mail-eopbgr80115.outbound.protection.outlook.com
 ([40.107.8.115]:50564 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kArF9-0002qc-P5; Wed, 26 Aug 2020 04:57:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Udtfynl8Fcm1r9zVO/VeCL7Vi7IArsGdVTHDDPimzREzeNoV5bAUqzyImFnI7+rfrxliKl5q+YmNOZWc36TVyN11Nyink5VPdbqAoFWyU/PpDlMj29Q4zmilLM6MVWz5YWoPgeR3mL0UDse2A5/Wx4klt1KiBAwOPwGZ0/arA/DMWJVjvdR14E/83fGZeo+4vjw3Tl4NpGO7LKsfSr38Q/Gy8e0rn4FDlx5Ryf9rOyIWFRpd1jebG3q4QQsx2sU8/pNIw7EZQaGWTmLI+vFiUxvdmBtknt00wHk1zwx5ON/OdK+KyVBcssNrIAVvj1FVajTOmh9oObV+JRCtzl5diA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxXB/vVsikMJzFAuyh4ygKXjbJJTDkJq9CSiSTHjisI=;
 b=Hsz6yhzQ7Ot6JQ9vy+pKwXOamFEztmVmm/NXsNHkG426ESAEiZi1ESesuWK5wIKEAqnAkt5/vcbkuf5F5fQ+fbffSkFLK8vRW7uMb7AS90K3FRcIC+sbLSY+vk4V4E/ZojROeRGhj3h9GQrAqEwp2DalF49Bqv4CkmPU04m+u8NvgfVb6yxah1dVElNV1IxyIoAP/QN1KzRY0mKXWBrH96n9RCqBPhgzSXouVtRs+YZ5si7GFxXz8PAF5XBu4awpzsq1/4azDg+bs6U5mbwIMhHEvd8/+KFe5PBJbGJJqvge2NxMhSpuXJFzv6a940DZ2zZTsrD1DT9S3XnBIS6S2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxXB/vVsikMJzFAuyh4ygKXjbJJTDkJq9CSiSTHjisI=;
 b=p6j3/dtKqBBWOb8zgch/nbE4PthyATvIPImRHyI3c7VQcVX9ptPXgfAe4FZlc5Uhjkbzfvf3/DRb8k18T03hNcWTXsgE92D8wdgMU+TbhlezwouU97vivGvvQ47GHTBISCQQKf01+IoCEJf+xVbsgZ17jxM18C21RIgjy+YKz1Y=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4690.eurprd08.prod.outlook.com (2603:10a6:20b:cd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 26 Aug
 2020 08:57:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%9]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 08:57:12 +0000
Subject: Re: [PATCH v5 06/10] block: introduce BDRV_REQ_NO_WAIT flag
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <20200821141123.28538-7-vsementsov@virtuozzo.com>
 <15cbc4e6-2a81-935f-ea26-5e98b80f40c2@redhat.com>
 <dc2c501f-ef45-d6b7-6801-ca0d1a4ec9b6@virtuozzo.com>
 <7e2240d1-03f8-ae64-5b4b-9f87a3d967fd@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7bdb632e-7fdb-cc96-896d-d3c2d3f96710@virtuozzo.com>
Date: Wed, 26 Aug 2020 11:57:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <7e2240d1-03f8-ae64-5b4b-9f87a3d967fd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM4P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Wed, 26 Aug 2020 08:57:11 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe8c959f-6dfc-4673-30d6-08d8499e0581
X-MS-TrafficTypeDiagnostic: AM6PR08MB4690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB46901C77B9B03F5C291E2759C1540@AM6PR08MB4690.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLf9a6Xb3swGiKP4mqvM5oPhIUENtmnH8fAEQN1RJANl0FzHHa24ifHYaEgRO2LL8nIZcLHIJXNEpdKvsPimGvXvowwqGsXaEsQQ2fa6dQPJ+U316kqj+use55QAv0HkQNYYmLi7LF8ZFD2mB11ofMzhJd0pv9veAK8hbHwknJK5kHhJlrBHXRuo5FLH+/dYELPYyRGEMJ0xlwvsW8hamU4LpykDlk3zX9IzHMJdIgWS9sMPjJYQt8yq43oeSa5h3qV/CGRUmf5DgvXjqXjK3FYnvqQHL7UxBQNgq4CN60J0mTSX/t3llXDG4R5WpztJRzwwl0CQTx1VbK6U+6VyuCiFaSFq6j7nfEqGpPRDgJxGnL9QwT7C2fS7RJAxq/fX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(396003)(376002)(346002)(136003)(478600001)(31686004)(31696002)(86362001)(4326008)(8936002)(8676002)(83380400001)(5660300002)(2616005)(186003)(16526019)(2906002)(52116002)(26005)(16576012)(316002)(956004)(36756003)(53546011)(66556008)(66476007)(66946007)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ilkR/m5gAUw/Lw7z+N5wUy0rbwZXGXVRtjMewJV0RSw0/H+DEJ2i64tz0dVo8IQkTG2KHg5TATcelWs1Rjd3Vnw3npVnvDMI84uvIeRx37zGqPsmAVisoD4VUttvkJj5OnPkkJFbAHugaFDtFdpAzcrDrnRZQeceCUChBLb+YwGaaSsWDuN4xGHjbGbynFfiXVqv2FdVT/jYNYxDLWEAw1NUopF6Qjq/VGwbYc65raPR2XzyV/HXniDgxyksrREBIOgDQK45VEmGEs3maSHAfu8Yqg0qKjCLsqy+aUwnqdkF5Y5TJtrSfaGKPNeFWVVhqqfZ1ZrSH3mZ13BOtynKk8caRse/o45S/20unqdYHBcWJ1FqFf9oiD4qn2PGOv4vQmj2qTAefKySs7zfy75+koVspzR8aew2eiv1IG29e4uj321VKsfyiz/UvGALZ/wCR8ybU8gXFHWrTRibGYdxFEra+XSkTkcPealJfbKAvkKOkEjDCYwr4KRJ8OvJoeQRwMDGWTHALnK1wAeB2MdOnykMzEoAsFkwrbmb5WVLu0PznlxAC7ekAu73oyU63ZIS5D1RrGjXx/0qqLncs1nG5wQSBAKB7tkvO4uzWEMFmcDuGmmfYpGLnXvZIW5Ps8kcd7iMWvSbtLVltmnm4hNe6g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8c959f-6dfc-4673-30d6-08d8499e0581
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 08:57:12.0292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pvAk4hO7b4SBmN5lsS/oJJSQvwBTV9YJmcksrfAwXzRXYBBJ2tHul90z3EpWhOxWfR1m0TY0MEla8HWUp3u5zm3oEgVq8Ck/P/rVnztGi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4690
Received-SPF: pass client-ip=40.107.8.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 04:57:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

26.08.2020 11:36, Max Reitz wrote:
> On 26.08.20 08:26, Vladimir Sementsov-Ogievskiy wrote:
>> 25.08.2020 16:10, Max Reitz wrote:
>>> On 21.08.20 16:11, Vladimir Sementsov-Ogievskiy wrote:
>>>> Add flag to make serialising request no wait: if there are conflicting
>>>> requests, just return error immediately. It's will be used in upcoming
>>>> preallocate filter.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    include/block/block.h |  9 ++++++++-
>>>>    block/io.c            | 11 ++++++++++-
>>>>    2 files changed, 18 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/block/block.h b/include/block/block.h
>>>> index b8f4e86e8d..877fda06a4 100644
>>>> --- a/include/block/block.h
>>>> +++ b/include/block/block.h
>>>> @@ -67,8 +67,15 @@ typedef enum {
>>>>         * written to qiov parameter which may be NULL.
>>>>         */
>>>>        BDRV_REQ_PREFETCH  = 0x200,
>>>> +
>>>> +    /*
>>>> +     * If we need to wait for other requests, just fail immediately.
>>>> Used
>>>> +     * only together with BDRV_REQ_SERIALISING.
>>>> +     */
>>>> +    BDRV_REQ_NO_WAIT = 0x400,
>>>> +
>>>>        /* Mask of valid flags */
>>>> -    BDRV_REQ_MASK               = 0x3ff,
>>>> +    BDRV_REQ_MASK               = 0x7ff,
>>>>    } BdrvRequestFlags;
>>>>      typedef struct BlockSizes {
>>>> diff --git a/block/io.c b/block/io.c
>>>> index dd28befb08..c93b1e98a3 100644
>>>> --- a/block/io.c
>>>> +++ b/block/io.c
>>>> @@ -1912,9 +1912,18 @@ bdrv_co_write_req_prepare(BdrvChild *child,
>>>> int64_t offset, uint64_t bytes,
>>>>        assert(!(bs->open_flags & BDRV_O_INACTIVE));
>>>>        assert((bs->open_flags & BDRV_O_NO_IO) == 0);
>>>>        assert(!(flags & ~BDRV_REQ_MASK));
>>>> +    assert(!((flags & BDRV_REQ_NO_WAIT) && !(flags &
>>>> BDRV_REQ_SERIALISING)));
>>>>          if (flags & BDRV_REQ_SERIALISING) {
>>>> -        bdrv_make_request_serialising(req, bdrv_get_cluster_size(bs));
>>>> +        QEMU_LOCK_GUARD(&bs->reqs_lock);
>>>> +
>>>> +        tracked_request_set_serialising(req,
>>>> bdrv_get_cluster_size(bs));
>>>> +
>>>> +        if ((flags & BDRV_REQ_NO_WAIT) &&
>>>> bdrv_find_conflicting_request(req)) {
>>>
>>> bdrv_find_conflicting_request() will return NULL even if there are
>>> conflicting requests, but those have a non-NULL waiting_for.  Is that
>>> something to consider?
>>>
>>> (I would like to think that will never have a real impact because then
>>> we must find some other conflicting request; but isn’t is possible that
>>> we find an overlapping request that waits for another request with which
>>> it overlaps, but our request does not?)
>>>
>>
>> Actually check in bdrv_find_conflicting_request() is the same like in
>> the following
>> bdrv_wait_serialising_requests_locked(), so, if
>> bdrv_find_conflicting_request() returns
>> NULL, it means that in bdrv_wait_serialising_requests_locked() it will
>> return NULL
>> again (as there are no yield points) and we will not wait, so all is OK.
> 
> OK.  I thought that maybe we would want to avoid that other requests
> might have to wait for the preallocation write.  (Of course, we can’t
> avoid that altogether, but if we already know of such requests at the
> beginning of the request...)
> 

Hmm, I see your point now. Hmm actually, what we want:

1. make preallocation on write
2. serialize the request
3. if there are conflicting requests do nothing, as (most probably) the
conflicting request will do preallocation itself

So, what we can say about intersecting requests, which are waiting for something (and therefore are not "conflicting")?
Aha, for sure, they don't preallocate (otherwise they don't wait). So [3] is still satisfied..

There was not original aim to not make the other parallel request wait for preallocation. So, it may be done later.. Intuitively, I don't expect the benefit: if there is no concurrent preallocate request, who are these intersecting requests? For example, EOF-crossing READS, waiting for some serialized not preallocating (so fit into file-size) WRITE. But this shouldn't happen often :)

> Well, if the only thing to look out for is that preallocation writes
> themselves do not wait:

So, let's assume that yes, we care that they don't wait themselves (mostly to avoid concurrent preallocation requests) and don't care about other intersecting requests.

> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Thanks!

> 
>> And, why is it OK to ignore already waiting requests in
>> bdrv_wait_serialising_requests_locked(): just because if we proceed now
>> with our request,
>> these waiting requests will have to wait for us, when they wake and go
>> to the next iteration
>> of waiting loop.
> 
> Sure.
> 


-- 
Best regards,
Vladimir

