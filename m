Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD29C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E962086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VK+TbWaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E962086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLsKP-000681-1y
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 14:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLsJV-0005fd-Kw; Fri, 25 Sep 2020 14:19:22 -0400
Received: from mail-eopbgr140121.outbound.protection.outlook.com
 ([40.107.14.121]:54555 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLsJS-0005PA-70; Fri, 25 Sep 2020 14:19:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPR/MaIqiTbTPuxFlypLGPOgydnvoqhIRBoJT0l+ULOJF891zInIuFN+tO/t7hQtdSjfEaRWQefVNnZ1TpGgI+i2udVmkpjpmd7IwzpaAj1DzrT8SPkAqeorSAT/BtmEgsl3Giqg6N+ORF17zHN1m1L+IdhPJE5aOLs7ulKnNd1bVzk3alf/opEXUzcoV3uZVN7leSH96kgNdwCPku7ZVIH2Luou4bxEJBHnDmnJ+VgUwuIEsk+vFYwPrPkyvhss3lvdbcKtZLmQ1fG54fyghN7nr0BamPBjAciPkseZ08k6VxHZ263bNfzYLw0oG6irB+9uJeDOejLS09+jOVP5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH01X7XSSVE2kCebI1PgYmVajN9Po9iPciKxLv6hRxk=;
 b=jqIwW4bRSHTJi2kpFTjAKramvZSPQ/NnFuU6E0gdi53PZWBAUW81ja+VcnE35R5aQP7wuwhhxFMrPjpiMStqoHlRJFN8QpipddsxQVhO6pHH4WAbpUGuU5Hziz7YK0v0DAlEFlMjD0vgTAh26RmNekBPyoxv94EXghyPFA2yKZNbAtEWRNEwelUngIAzT1dg+Vc1EJ+Eofr1Yo4FxjUVuv509VkbtdpTvtrJ4Kug2T31RD0m5TzzpJxJacyv9kYqE3AZ7WlVSYD56Orbvq6x1O6FkgNcLxjQQ1oV3BdzRS/sucivYSAhIPr+lx0kQrFLA03ATytThfMTFpl05COTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH01X7XSSVE2kCebI1PgYmVajN9Po9iPciKxLv6hRxk=;
 b=VK+TbWaN70W2g9p2vSYv++UyHQn6rmEHh4nUu+9Ea5r18i1HWOEcbIiL0KD6gd9gN2qt9OyfVchaRypnhtxt8MrHIMOhB9iQ6eauNcYfUfS/IZ6dE724O1vJEzlRShKmv2TvArrCcbouDcP7GflUnNM9q7Da93+Pei7Yi8ZhJyU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4724.eurprd08.prod.outlook.com (2603:10a6:20b:cd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Fri, 25 Sep
 2020 18:19:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Fri, 25 Sep 2020
 18:19:12 +0000
Subject: Re: [PATCH v2 07/20] block/block-copy: add ratelimit to block-copy
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, den@openvz.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-8-vsementsov@virtuozzo.com>
 <dc4fa418-a054-a78a-6160-57109ab27669@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6ad1b0ab-82ae-0208-fbe9-cad54b63646c@virtuozzo.com>
Date: Fri, 25 Sep 2020 21:19:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <dc4fa418-a054-a78a-6160-57109ab27669@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0027.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::40) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM0PR07CA0027.eurprd07.prod.outlook.com (2603:10a6:208:ac::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.18 via Frontend Transport; Fri, 25 Sep 2020 18:19:11 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c50d0ca1-0675-4485-32d7-08d8617f809e
X-MS-TrafficTypeDiagnostic: AM6PR08MB4724:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4724A1F351A3A754B5CFCAF4C1360@AM6PR08MB4724.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Npk7khxrD8Xdpkm+fkSOegnZaCEyKtrgeBDR3AzHbAk9pPls9AuXm/Eq9AXh0sQW+gRy4nT4vd0G7jMmMeYcrT9Z5EQDnK1jj4LuPD+He2Mq5/4QRBsVd2H4uk8gEm9AhzYhWqf8ylntSxn2XdAlvAo427mdxYx2FB9UeJGg81XJ84xisgt42foO8kGyOR14M4cJgFrEez+fCYLsTG3fr1+C7bdR9wxHYX3R0tbnp0nBTzqebbz/mpcqNFyECL0WOt8cbmfNtGRE47a1eYOSwS2HYyygfCN0fCZVoMw3Fm7QusCVRUfOZU4c/oBjPa1ftCkK8ZXqx9sSiZqC0FBsZXexX7Qf/Keu+w9PRjUx0iTdTZOjkw36gl9Jasyj9c+q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39840400004)(396003)(136003)(8936002)(53546011)(16576012)(316002)(478600001)(16526019)(186003)(31696002)(6486002)(5660300002)(2906002)(86362001)(2616005)(83380400001)(8676002)(36756003)(4326008)(66946007)(26005)(66556008)(52116002)(31686004)(66476007)(956004)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: BDguYi48CQlGJQD7fsmdGeQKXfXe+nvp7zKKMf76/X1PZDUcETo1IVVeZNzNOlJ+7SEDwN9FCgwTNZHxeR6gX+yNAPmwoMhFTwHSvHtYPPK3fGgvDocJkc6i9Piico6tsRhN3bFSe/GBVQHGDF098R2ZlNKCqzLGRuLNuU3/TqAAQFuMMuFT+gowdPT93X37FfyQMHfGZq7MIS/45GW3ucCQ3VNBhUYPFrc1Zek1G3yLfxNCkE51d7Xhqsl8UotY213xh8QN0MwHNRP4/XB3OUIIuLK5bT7Sqytl5QchImUjXpAkyKBTozI5TRboARVH5tmFCkJXldWcIxGC7sNVJ/vweWBVdmR+w9g3QZbpXpnNGZoGuccN8nxEGKhVmyqBD9R56Eq8o8IwdD45n8728kRIDNSFEc2Vptf655YS/zPkmGAM5voVXSrFyrpsNPJBBvJcZOq+JFgRURyAvxKOFKLIlsArWX8/fp3M70jQPYe1a6+ouymaVLCa+KDIaIpPrBsCZJ7EuJhasNV4t65r0AnGAjmNSaOnZ+8dgHMnPpdYWar8P4w5HhPRpbCssNJISHopfvdHdyEQdlZa6XLcEotYYRgRPeTb9hho4/DlvCN/58O3EFt5TnBD0Ax6w0gVrvPHm4Oaz91bWd3XWr4HEg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50d0ca1-0675-4485-32d7-08d8617f809e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 18:19:12.1409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqg5hLztj29Y72BO+tIk0xW0xYdwIV2hkC/3sQsGENEjE6IAoxrnumUnD3vdR8wnafWOjpv/+UabER1D/9a/c/FQt/uOrrGv5QK6zwge77c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4724
Received-SPF: pass client-ip=40.107.14.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 14:19:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_LOW=-0.7,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

22.07.2020 14:05, Max Reitz wrote:
> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>> We are going to directly use one async block-copy operation for backup
>> job, so we need rate limitator.
> 
> %s/limitator/limiter/g, I think.
> 
>> We want to maintain current backup behavior: only background copying is
>> limited and copy-before-write operations only participate in limit
>> calculation. Therefore we need one rate limitator for block-copy state
>> and boolean flag for block-copy call state for actual limitation.
>>
>> Note, that we can't just calculate each chunk in limitator after
>> successful copying: it will not save us from starting a lot of async
>> sub-requests which will exceed limit too much. Instead let's use the
>> following scheme on sub-request creation:
>> 1. If at the moment limit is not exceeded, create the request and
>> account it immediately.
>> 2. If at the moment limit is already exceeded, drop create sub-request
>> and handle limit instead (by sleep).
>> With this approach we'll never exceed the limit more than by one
>> sub-request (which pretty much matches current backup behavior).
> 
> Sounds reasonable.
> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/block-copy.h |  8 +++++++
>>   block/block-copy.c         | 44 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 52 insertions(+)
>>
>> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
>> index 600984c733..d40e691123 100644
>> --- a/include/block/block-copy.h
>> +++ b/include/block/block-copy.h
>> @@ -59,6 +59,14 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
>>                                        int64_t max_chunk,
>>                                        BlockCopyAsyncCallbackFunc cb);
>>   
>> +/*
>> + * Set speed limit for block-copy instance. All block-copy operations related to
>> + * this BlockCopyState will participate in speed calculation, but only
>> + * block_copy_async calls with @ratelimit=true will be actually limited.
>> + */
>> +void block_copy_set_speed(BlockCopyState *s, BlockCopyCallState *call_state,
>> +                          uint64_t speed);
>> +
>>   BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
>>   void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
>>   
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 4114d1fd25..851d9c8aaf 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
>> @@ -26,6 +26,7 @@
>>   #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
>>   #define BLOCK_COPY_MAX_MEM (128 * MiB)
>>   #define BLOCK_COPY_MAX_WORKERS 64
>> +#define BLOCK_COPY_SLICE_TIME 100000000ULL /* ns */
>>   
>>   static coroutine_fn int block_copy_task_entry(AioTask *task);
>>   
>> @@ -36,11 +37,13 @@ typedef struct BlockCopyCallState {
>>       int64_t bytes;
>>       int max_workers;
>>       int64_t max_chunk;
>> +    bool ratelimit;
>>       BlockCopyAsyncCallbackFunc cb;
>>   
>>       /* State */
>>       bool failed;
>>       bool finished;
>> +    QemuCoSleepState *sleep_state;
>>   
>>       /* OUT parameters */
>>       bool error_is_read;
>> @@ -103,6 +106,9 @@ typedef struct BlockCopyState {
>>       void *progress_opaque;
>>   
>>       SharedResource *mem;
>> +
>> +    uint64_t speed;
>> +    RateLimit rate_limit;
>>   } BlockCopyState;
>>   
>>   static BlockCopyTask *find_conflicting_task(BlockCopyState *s,
>> @@ -611,6 +617,21 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
>>           }
>>           task->zeroes = ret & BDRV_BLOCK_ZERO;
>>   
>> +        if (s->speed) {
>> +            if (call_state->ratelimit) {
>> +                uint64_t ns = ratelimit_calculate_delay(&s->rate_limit, 0);
>> +                if (ns > 0) {
>> +                    block_copy_task_end(task, -EAGAIN);
>> +                    g_free(task);
>> +                    qemu_co_sleep_ns_wakeable(QEMU_CLOCK_REALTIME, ns,
>> +                                              &call_state->sleep_state);
>> +                    continue;
>> +                }
>> +            }
>> +
>> +            ratelimit_calculate_delay(&s->rate_limit, task->bytes);
>> +        }
>> +
> 
> Looks good.
> 
>>           trace_block_copy_process(s, task->offset);
>>   
>>           co_get_from_shres(s->mem, task->bytes);
>> @@ -649,6 +670,13 @@ out:
>>       return ret < 0 ? ret : found_dirty;
>>   }
>>   
>> +static void block_copy_kick(BlockCopyCallState *call_state)
>> +{
>> +    if (call_state->sleep_state) {
>> +        qemu_co_sleep_wake(call_state->sleep_state);
>> +    }
>> +}
>> +
>>   /*
>>    * block_copy_common
>>    *
>> @@ -729,6 +757,7 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
>>           .s = s,
>>           .offset = offset,
>>           .bytes = bytes,
>> +        .ratelimit = ratelimit,
> 
> Hm, same problem/question as in patch 6: Should the @ratelimit parameter
> really be added in patch 5 if it’s used only now?
> 
>>           .cb = cb,
>>           .max_workers = max_workers ?: BLOCK_COPY_MAX_WORKERS,
>>           .max_chunk = max_chunk,
>> @@ -752,3 +781,18 @@ void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip)
>>   {
>>       s->skip_unallocated = skip;
>>   }
>> +
>> +void block_copy_set_speed(BlockCopyState *s, BlockCopyCallState *call_state,
>> +                          uint64_t speed)
>> +{
>> +    uint64_t old_speed = s->speed;
>> +
>> +    s->speed = speed;
>> +    if (speed > 0) {
>> +        ratelimit_set_speed(&s->rate_limit, speed, BLOCK_COPY_SLICE_TIME);
>> +    }
>> +
>> +    if (call_state && old_speed && (speed > old_speed || speed == 0)) {
>> +        block_copy_kick(call_state);
>> +    }
>> +}
> 
> Hm.  I’m interested in seeing how this is going to be used, i.e. what
> callers will pass for @call_state.  I suppose it’s going to be the
> background operation for the whole device, but I wonder whether it
> actually makes sense to pass it.  I mean, the caller could just call
> block_copy_kick() itself (unconditionally, because it’ll never hurt, I
> think).
> 

Yes, that's weird. I think the correct approach is to have list of call-states in block-copy-state, and kick them all on speed update.


-- 
Best regards,
Vladimir

