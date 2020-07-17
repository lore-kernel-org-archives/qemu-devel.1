Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E42FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D93352067D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="py3MQv9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93352067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwSFQ-0000X1-2M
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 11:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jwSEE-0007qA-DK; Fri, 17 Jul 2020 11:24:50 -0400
Received: from mail-db8eur05on2138.outbound.protection.outlook.com
 ([40.107.20.138]:1729 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jwSEB-0005kt-MM; Fri, 17 Jul 2020 11:24:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Im5epDcedFJP+jz+tOEwQbAH8Nb6dP4sHvMeSPJC+oQziL+xyo/u++4UGkfL0PgPNls47DnWHLZRw3+D7MkPe1xpaJvErzhvZK2ISgU25HwdXBzM6SApdcLqznQVYNq13bVEs0MZri0+x+DBw11D8eLIhAmHzkg0AJx7HtfJIkE50o1yv6zt7wiBatbw06R7Ooby9s8qqo3gmVbmx3EwdiqdcRYhc7E7PBE6lDvsqIYLT1plf4RRQfFlGMuYIQuK4b0Sva70sNdNrh1p68jcVhpSsY1r6A9ytpbtX+/F+ZoWN3hlkbOY+sN7YIJK3RsK2nYyn2j1JefT1QY9qNQa+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSTuq+OtAy4UOBJ7zx7sq4fUen4DuH4bQVKTh8Vxs0s=;
 b=IGhqx+CUBjiIFsMgbIHScwK1MrlJjJHsXtgSRWkp3Jpn1MET2XpKBkw+0ancfJXnkbgmVhOOaquCiuGEAH826QO0ujd+mWVojawI1QoGMjvtNiBYZtonCofxLkaqAczYENRME0mMNC1birzkjHvGr0v3uDcUIM/jmpp8XXJP4iHgPJu2s6CYBqWtXTbdH6sH5GBeH5/xKV6qLpKWRYVHY1rSglttEkBp31LuHfZ+LrmPkXP+WNWEltkVf/0U+XoCNC1fPOyQ79YtySYxEx9d2zQdqqEgRRa91pzStCB4gxtHMzU/xhtSqJXIBM0OQVTlTa1DwesPfXMhBqCvAjO+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSTuq+OtAy4UOBJ7zx7sq4fUen4DuH4bQVKTh8Vxs0s=;
 b=py3MQv9C0xiyKw6xpXPzxo0gxgqSORaxDqeSPwFfE0vKQIijUzs8OqInwjW6yxTU8zCdxLcgE0BuMY00rQqreHi68HFPGcaUFbyYlFlmD6FViLXswp19+zKwzyaCCPsCCfhgUdM3TRBbsiGXp5vSHKmGlnsLw6Y9ETNmj8FIpK8=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3894.eurprd08.prod.outlook.com (2603:10a6:20b:90::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 17 Jul
 2020 15:24:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.022; Fri, 17 Jul 2020
 15:24:44 +0000
Subject: Re: [PATCH v2 05/20] block/block-copy: implement block_copy_async
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-6-vsementsov@virtuozzo.com>
 <90825bab-19d1-466f-4fd4-adf76f1010b1@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <39f90110-105b-2399-17c9-901da7078106@virtuozzo.com>
Date: Fri, 17 Jul 2020 18:24:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <90825bab-19d1-466f-4fd4-adf76f1010b1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0120.eurprd04.prod.outlook.com
 (2603:10a6:208:55::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM0PR04CA0120.eurprd04.prod.outlook.com (2603:10a6:208:55::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 15:24:44 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4058183-005f-4a5e-3688-08d82a6588aa
X-MS-TrafficTypeDiagnostic: AM6PR08MB3894:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3894FA10B46053F0B7B3E7DCC17C0@AM6PR08MB3894.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5TjhpvWgHdKSSSRxJcRPut0ypFVpjd4VZeqWUtriT5qD3FaoJK8TJHDLPKSy3sYOmhwI8ijN9AfUWPlpmpoI8geulyWfokBPg96OqjFwan7J2M61jQ66G2IBh4mPPwfc/io80o6fd2HxoDp5odA2BEbT+7UzXGGb2Sri9CSl4Uojs+bRpt8H8uRA9U42BZ5s4wlm7e2nk2wJMnJ35xvHAqf1zIrT3gIHNFe5yd17GNIjkWNlL6+XkoZRRqFOxEqC0Cn8EXJMKcpTm5DCRz2uB3Cu2LgTX4phXXmj2Ri2Z6FBGTTdmedHF/TdGInRbI+b1ooIYZQAWz4ZV/bF4qV8Psctq9QkaFMQksVnstj3J46zGkSkpvTA08mFhTpeQS/s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39840400004)(26005)(2616005)(52116002)(53546011)(186003)(8936002)(83380400001)(8676002)(16526019)(6486002)(31686004)(5660300002)(36756003)(956004)(31696002)(86362001)(478600001)(4326008)(66476007)(16576012)(66556008)(2906002)(66946007)(107886003)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TDXbU4AfQBfN6VkC8dKBOxpOG7mDZyJR0PauvbFaeicb7iuQKmdqQFcznVRiOnrdK8f3GqL56kv2ZgPYn2fMDZwT7LU9xxSv/anjByKKUz63gBKNLkgeLhwFEPtaGgGusMB/Jhsrw2FJlCNPrmiXr1LXkHIkfsoC3xLelaqUVulgAr9bCfk+KrQ0A08l5VAgpwWsxHCCF3ONmm+ou+qeiRwf8IOv/sT0RU1/bwtey8d9zrsbRobsAY9mH8LPEea8k+S0Cpq2T3KaHObXEf1n1VePYL2QralhyhEE2PmKps0F9bl1yZL26rv/HsI/9+Yb888B1fJ+2jHjPqhCHhC0Qow6VxVNiYAYk04mXurJyHMWGoe2/Yf/TbFxS3wP84w1H5DQjowkeGshbrlHuLMZaQTDmbZgfDh3Yu0dKaxciEJghZrYfYkmHv59x6um1oSgRCo/RlBHv2eW+S3ZnPUow+wemEY8dgSOuPwywNN7GzJ2jK0LP/udrRAYz4h/n1KP
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4058183-005f-4a5e-3688-08d82a6588aa
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 15:24:44.6910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUqQH+OrHFcSt5eYgIXJaM5/CYidlZ6ZBG5ZEuPcDaJW4peIqskIhucvMQJr2TYGNs4FZiUpag1Uy+oQWY2fiStdCMLZt01WcPFEdzHOT00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3894
Received-SPF: pass client-ip=40.107.20.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 11:24:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.07.2020 17:00, Max Reitz wrote:
> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>> We'll need async block-copy invocation to use in backup directly.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/block-copy.h | 13 +++++++++++++
>>   block/block-copy.c         | 40 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 53 insertions(+)
>>
>> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
>> index 6397505f30..ada0d99566 100644
>> --- a/include/block/block-copy.h
>> +++ b/include/block/block-copy.h
>> @@ -19,7 +19,10 @@
>>   #include "qemu/co-shared-resource.h"
>>   
>>   typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
>> +typedef void (*BlockCopyAsyncCallbackFunc)(int ret, bool error_is_read,
>> +                                           void *opaque);
>>   typedef struct BlockCopyState BlockCopyState;
>> +typedef struct BlockCopyCallState BlockCopyCallState;
>>   
>>   BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>>                                        int64_t cluster_size, bool use_copy_range,
>> @@ -41,6 +44,16 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
>>   int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
>>                               bool *error_is_read);
>>   
>> +/*
>> + * Run block-copy in a coroutine, return state pointer. If finished early
>> + * returns NULL (@cb is called anyway).
> 
> Any special reason for doing so?  Seems like the code would be a tad
> simpler if we just returned it either way.  (And off the top of my head
> I’d guess it’d be easier for the caller if the returned value was always
> non-NULL, too.)

Sounds reasonable, will check

> 
>> + */
>> +BlockCopyCallState *block_copy_async(BlockCopyState *s,
>> +                                     int64_t offset, int64_t bytes,
>> +                                     bool ratelimit, int max_workers,
>> +                                     int64_t max_chunk,
>> +                                     BlockCopyAsyncCallbackFunc cb);
>> +
>>   BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
>>   void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
>>   
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 75882a094c..a0477d90f3 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
>> @@ -34,9 +34,11 @@ typedef struct BlockCopyCallState {
>>       BlockCopyState *s;
>>       int64_t offset;
>>       int64_t bytes;
>> +    BlockCopyAsyncCallbackFunc cb;
>>   
>>       /* State */
>>       bool failed;
>> +    bool finished;
>>   
>>       /* OUT parameters */
>>       bool error_is_read;
>> @@ -676,6 +678,13 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
>>            */
>>       } while (ret > 0);
>>   
>> +    if (call_state->cb) {
>> +        call_state->cb(ret, call_state->error_is_read,
>> +                       call_state->s->progress_opaque);
> 
> I find it weird to pass progress_opaque here.  Shouldn’t we just have a
> dedicated opaque object for this CB?

I remember, it should be refactored later. But seems strange here, better to change.

> 
>> +    }
>> +
>> +    call_state->finished = true;
>> +
>>       return ret;
>>   }
>>   
>> @@ -697,6 +706,37 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t bytes,
>>       return ret;
>>   }
>>   
>> +static void coroutine_fn block_copy_async_co_entry(void *opaque)
>> +{
>> +    block_copy_common(opaque);
>> +}
>> +
>> +BlockCopyCallState *block_copy_async(BlockCopyState *s,
>> +                                     int64_t offset, int64_t bytes,
>> +                                     bool ratelimit, int max_workers,
>> +                                     int64_t max_chunk,
>> +                                     BlockCopyAsyncCallbackFunc cb)
>> +{
>> +    BlockCopyCallState *call_state = g_new(BlockCopyCallState, 1);
>> +    Coroutine *co = qemu_coroutine_create(block_copy_async_co_entry,
>> +                                          call_state);
>> +
>> +    *call_state = (BlockCopyCallState) {
>> +        .s = s,
>> +        .offset = offset,
>> +        .bytes = bytes,
>> +        .cb = cb,
>> +    };
>> +
>> +    qemu_coroutine_enter(co);
> 
> Do we need/want any already-in-coroutine shenanigans here?
> 

No: the aim of the function is to start a new coroutine in parallel, independently of are we already in some other coroutine or not.

> 
>> +
>> +    if (call_state->finished) {
>> +        g_free(call_state);
>> +        return NULL;
>> +    }
>> +
>> +    return call_state;
>> +}
>>   BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s)
>>   {
>>       return s->copy_bitmap;
>>
> 
> 


-- 
Best regards,
Vladimir

