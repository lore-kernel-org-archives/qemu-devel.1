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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AB7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 06:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901E32076C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 06:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="niBv/477"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901E32076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAotk-00043z-RO
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 02:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kAot0-0003Xp-Fz; Wed, 26 Aug 2020 02:26:18 -0400
Received: from mail-am6eur05on2117.outbound.protection.outlook.com
 ([40.107.22.117]:33912 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kAosx-0000qQ-DT; Wed, 26 Aug 2020 02:26:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXlKU1ZVCWUmFztFK4tKiANprxAy7BVAyNiW0LwRJEh30fj4h1IptYmOh7NpnY5zocG/Wk1T8ioaM8CdqW7LSvZ9Qhx8P7Mb1CuWRa0E4/PR8xlxTn4axZ7902WAEVF0nnz3Agq3nOMZ86hTURdC2GfSFfIPOlZynwl2z9oS3zIbeODrm5yxKtzlUryq+KYjhOam1KEybjPCrVUWIz9wydpXi2wPAyxG6eXuqQqvmgnoF6LHjXAmFfGRvZM1wgQhrah7jDe5K6MTEPHkLlCEIyE33RrhGQfECb/dQZrDI+AB7XRaKbhu10L0FKXes41gqT3a1Gv5FGUBW3gVzrZChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inwd/MqyL8Xku1DbGp2diRpriVP//mDs/+rzZ6lj0d8=;
 b=SRnfImMtmYoj79z5+QF70UHl4AOkmeCvJCDGWLQGKSvkUZCraRkvm3BwyAKQkde367Hw+C1OD3mIkWDiEvOHx8pskZork+7WuqGHF5trN7YB73acYVU6dbeBNiyD34Oj3xHauHTwYtInvygA0SVr8juRVo0sHbqgtWDF+CciMYtFnUJPJr447qBCadxgxAkW7llyGBSWtvVdanDO9WmkjaUyN6FBowsQZmgA4PdAfyQDexwpnZjqeAa1i72NcKukqvXGDoGFuCHUfXVdMq8QKx66426zjlLRQipbjBCcj5ss9hCX8ex2dt11DoERIk42l0bWM2CyB5P8Tr9f9TZFaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inwd/MqyL8Xku1DbGp2diRpriVP//mDs/+rzZ6lj0d8=;
 b=niBv/477mugq0z0wbLu8x9bXkwyD9/nyP36h3m4F39818TiXwQkcIQ+0M3Pm39jhXbgAWWrkAOAMpAvIoykflz7qh7kcQrsZxrAywCBP1peOSJ0K39y0wIIr7ozgaxpAgXsW/9jmHrR/JuLLlTBVbSzf7K7jZHGBPihbBpDfbBQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3223.eurprd08.prod.outlook.com (2603:10a6:209:4d::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 06:26:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%9]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 06:26:06 +0000
Subject: Re: [PATCH v5 06/10] block: introduce BDRV_REQ_NO_WAIT flag
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <20200821141123.28538-7-vsementsov@virtuozzo.com>
 <15cbc4e6-2a81-935f-ea26-5e98b80f40c2@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <dc2c501f-ef45-d6b7-6801-ca0d1a4ec9b6@virtuozzo.com>
Date: Wed, 26 Aug 2020 09:26:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <15cbc4e6-2a81-935f-ea26-5e98b80f40c2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 06:26:05 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb1e067b-f75c-4c79-d636-08d84988e9fb
X-MS-TrafficTypeDiagnostic: AM6PR08MB3223:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB322345B79F10121787E53DF8C1540@AM6PR08MB3223.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3fqbQbFWcX14B+SmvZvyTAbT6TaM9WBamqyEnWFPAc1ojmAUK83xYRxjhE0/5IUiN5FO5xeuW700Z3m4Hi6NMRHdKsVcQXSYv8SAkcEH0hu3dAWZWM2SOzxMxdFUsjB5Cut/FkqLTWsjwZXAlWEk9JWTWOGOadwCj+3L9DpVb4SR8h9mcpASz2WnQ9DPRIlL/VZhSX13bFMF3uBjwOiKAASOF45J0Ls3Ggk+Sbl5j6ltNGqE8chkg9UmlBx4E1LAcwUtHbNlMRPPCd+FDWjarkJLr7pZvajALDt6s1jvUmk9cK5kCjAxEPLRNZOwphcbfj9RPIFWJAFt1L9mfEnQ9csaWd0cFgFTGpfoVtXbvssdQJh+Y0xzaxt61vIsQmq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(39830400003)(396003)(346002)(31696002)(316002)(66556008)(66946007)(5660300002)(6486002)(478600001)(86362001)(16576012)(66476007)(186003)(2906002)(8676002)(26005)(83380400001)(36756003)(956004)(8936002)(2616005)(52116002)(53546011)(4326008)(16526019)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ZvuEd9relgtsTDXz+Ce5ZXu1Ar1aDU8pOxYGWyjtkYovvapVrYknJp06/rqvUP8jrSc2L7SoIaZDgAAOuVAklHjhIua36Dwde0ylUdl1ODTZhZWErtsvwrdUuw+PLDR+a15LFD49thY2lSH9a14SwGMUGv8bTAtmyW+f4dJGf+INlnpKxATwB7IbnIXDuRRIec3PvyuR4jRhSyXdGgdvzUJYnYRuLqMOJk5nDy78zOKjetWOCY37lgn+j9NoAJFnDEFOtfdRWUktMaO79QZXy4E1enJ2tS2vOel+t4WBE0UiSS3AfkMh8wEnd1meNEi5T0L4zlXZu8/XfN0DA4qn64N3x1uaPdudeqchP5eNqRpx4ot4+gIUjm6UWniAdEFRmAGKjguEg1hjAdeef3s/7+e3IlyPSq323yoQ0rlcrpygKKBXjA5nv5l4+G00ioJAKWKpG81BG8GjdJYgRIs+BJwfVtD0GhA/Xwf/ZRULylIzJnjghq9yX6lWHm9/yKBw8HHB7NIs0yxt9rsq2JAKgACa87WRUtQXn68wSHWQ/WoJGwErItjcsxxeGBs+wee9RLHqBT47BaSGkqlhoaKmi9GEcpNenLlIf+xnsUwhME+dDVfYFi505nqotxUk12xRkPos+wxyIjMDpXBwrMht5Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1e067b-f75c-4c79-d636-08d84988e9fb
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 06:26:06.4663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4vyVU4mB/EOo/LwaO5qQ/t90WvV57fbSSoEyaBuXnNxjumMj1JgLHrOouTn792IEc+fDBOUigHMux6ZYkQyoDVRtdpq1+uLKOxYJ/EIrCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3223
Received-SPF: pass client-ip=40.107.22.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 02:26:11
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

25.08.2020 16:10, Max Reitz wrote:
> On 21.08.20 16:11, Vladimir Sementsov-Ogievskiy wrote:
>> Add flag to make serialising request no wait: if there are conflicting
>> requests, just return error immediately. It's will be used in upcoming
>> preallocate filter.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/block.h |  9 ++++++++-
>>   block/io.c            | 11 ++++++++++-
>>   2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/block/block.h b/include/block/block.h
>> index b8f4e86e8d..877fda06a4 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -67,8 +67,15 @@ typedef enum {
>>        * written to qiov parameter which may be NULL.
>>        */
>>       BDRV_REQ_PREFETCH  = 0x200,
>> +
>> +    /*
>> +     * If we need to wait for other requests, just fail immediately. Used
>> +     * only together with BDRV_REQ_SERIALISING.
>> +     */
>> +    BDRV_REQ_NO_WAIT = 0x400,
>> +
>>       /* Mask of valid flags */
>> -    BDRV_REQ_MASK               = 0x3ff,
>> +    BDRV_REQ_MASK               = 0x7ff,
>>   } BdrvRequestFlags;
>>   
>>   typedef struct BlockSizes {
>> diff --git a/block/io.c b/block/io.c
>> index dd28befb08..c93b1e98a3 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1912,9 +1912,18 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
>>       assert(!(bs->open_flags & BDRV_O_INACTIVE));
>>       assert((bs->open_flags & BDRV_O_NO_IO) == 0);
>>       assert(!(flags & ~BDRV_REQ_MASK));
>> +    assert(!((flags & BDRV_REQ_NO_WAIT) && !(flags & BDRV_REQ_SERIALISING)));
>>   
>>       if (flags & BDRV_REQ_SERIALISING) {
>> -        bdrv_make_request_serialising(req, bdrv_get_cluster_size(bs));
>> +        QEMU_LOCK_GUARD(&bs->reqs_lock);
>> +
>> +        tracked_request_set_serialising(req, bdrv_get_cluster_size(bs));
>> +
>> +        if ((flags & BDRV_REQ_NO_WAIT) && bdrv_find_conflicting_request(req)) {
> 
> bdrv_find_conflicting_request() will return NULL even if there are
> conflicting requests, but those have a non-NULL waiting_for.  Is that
> something to consider?
> 
> (I would like to think that will never have a real impact because then
> we must find some other conflicting request; but isn’t is possible that
> we find an overlapping request that waits for another request with which
> it overlaps, but our request does not?)
> 

Actually check in bdrv_find_conflicting_request() is the same like in the following
bdrv_wait_serialising_requests_locked(), so, if bdrv_find_conflicting_request() returns
NULL, it means that in bdrv_wait_serialising_requests_locked() it will return NULL
again (as there are no yield points) and we will not wait, so all is OK.

And, why is it OK to ignore already waiting requests in
bdrv_wait_serialising_requests_locked(): just because if we proceed now with our request,
these waiting requests will have to wait for us, when they wake and go to the next iteration
of waiting loop.

> 
>> +            return -EBUSY;
>> +        }
>> +
>> +        bdrv_wait_serialising_requests_locked(req);
>>       } else {
>>           bdrv_wait_serialising_requests(req);
>>       }
>>
> 
> 


-- 
Best regards,
Vladimir

