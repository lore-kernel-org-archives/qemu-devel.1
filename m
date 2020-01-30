Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF01AC35240
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C66F20707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JdXsNyA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C66F20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixAAL-0002OL-Ho
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 08:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixA94-0001HJ-EK
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixA92-0002UK-EH
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:46:10 -0500
Received: from mail-vi1eur05on2106.outbound.protection.outlook.com
 ([40.107.21.106]:51649 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ixA91-0002GE-I0; Thu, 30 Jan 2020 08:46:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwkF8vD3bXu0OhuuBTITYsSgBdimQpqGsH2tzM+o3FMr1B0hLHMa2LzXJUWkCixb5KBJDb13edSaHS67JzgyPDVIQvU7V1A6bjOSUvEIpmbEmbvmq3tHs2Bh8Nc72KWEvolDwzVtshjJuX32WA2Z8g9aXNHXgYboa2ArrOkARbftuuHy3Bn8pBxDZGDMOHO4rBrSBtdrdiDJy629TmOHFm71gZ4hzxQ7AJlIHZY5cCN74s1JWZO+/NA4HLcTvNGzZ5yg5Wr/d42Rw7NVNiRFKim30CQ0RxAl5LeH7eacKj210wHldzQG8hK63jGTIiGhwzgm1XNs2nzPowl8CuLa6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaDlc1HOyHmePbzUU0V9hTcwfcC8jz9fJ+XGXNPFxMM=;
 b=lxIEg8PlsrHSMb9MdbgXDR282ZgmT3V353PsdG1NItMJ+dpVr4s3fCpy9EsJQGT/V3uGJ+B3eal9AkMqlhJQbfjefBNtKSgfMWObN11iB0yiesvs5aKqkv5dW8wb3bP3rB8pV/Q7rKDb4lkW0CsG4flQL+t5WSeIJkyesDpQx1izvfr+XkpBE3pKdeTJrd+CI0QjeKNRgnpWQ4i5ua9AelG0BBy/uVrS82MzB1MVdyboi4fLdsoNDxNGqiDRix1812/QxUphCu4kpZwx81XNsdTHVaRlART4YqmZM7f6ReqKx+r+hMgz5M09l1GY2h4F6SudZ0kEiKcaYmto0JtoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaDlc1HOyHmePbzUU0V9hTcwfcC8jz9fJ+XGXNPFxMM=;
 b=JdXsNyA2dqxF/rRby1VG5gHSMqwovw3TsxegASt9X5VaqTGAux5LnmatBc4llbSiE5Efrpb+Jgm71Au7l999uzk7us8Xj/KNQqlLTlkvFARBIWBsTFFTY1WK2CaSQYspyrhGcvkS6gEQfLx3V+a09hUzowH3yqSNcYDI7vQtf70=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3463.eurprd08.prod.outlook.com (20.177.112.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Thu, 30 Jan 2020 13:46:02 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 13:46:02 +0000
Subject: Re: [PATCH v2 6/7] block/block-copy: reduce intersecting request lock
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-7-vsementsov@virtuozzo.com>
 <632dfc93-5d42-2a9a-64f3-d6b0fca9e8dc@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200130164559932
Message-ID: <61f94246-4f74-c9ba-05a5-0da1c88be541@virtuozzo.com>
Date: Thu, 30 Jan 2020 16:45:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <632dfc93-5d42-2a9a-64f3-d6b0fca9e8dc@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0701CA0054.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::22) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0701CA0054.eurprd07.prod.outlook.com (2603:10a6:3:9e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.14 via Frontend Transport; Thu, 30 Jan 2020 13:46:01 +0000
X-Tagtoolbar-Keys: D20200130164559932
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44dce304-d50d-435b-5983-08d7a58abec5
X-MS-TrafficTypeDiagnostic: AM6PR08MB3463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3463EE92156DF088701557A9C1040@AM6PR08MB3463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(2616005)(956004)(36756003)(4326008)(31696002)(86362001)(26005)(16526019)(186003)(81166006)(81156014)(8676002)(8936002)(6486002)(66946007)(66476007)(2906002)(66556008)(31686004)(54906003)(52116002)(478600001)(53546011)(16576012)(110136005)(5660300002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3463;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qh3VN7T7N+NVB4bK98djNRoEURlLSUCB9kaFd7Fc2VkOorUY6PtqJVlIHPL+wb2pvxs8b0xee8uHa1z+m8E5W5ktMRbuh1LmT3kFHAgTFhDppx3cWABnkAMV7e5b445mcY+QrL85HK2qm+nJZ26EKrJPDvJ0IeQESiPEzM0rEs+Tv0davyzhC6k/jmArpuV28cZmCd0aN27GgTMOyvb+WGRw7KSl6y1s2csWmslsldGt4MGOPpPzTyxOkW+u6tQ3KkNE9Fp7CZaeyUVdTokm10HIiVt9V08S7lI6427M1XSOFEX/P/xGp6dke4a+JNZjhXiv9nNYmadTSCutKelwkjKrd4ZZSDTOdurWZ8kJyjCK8psB2TekYdnYqhSYspzsXDUIs/Jl3z3ldsRXz6bR+0vBFt92qa0FhtjSKSN+OWWNxWhE+BSIekXi/tJoX4oS
X-MS-Exchange-AntiSpam-MessageData: IHbf4Rw8H5Gm5btw0DwD9XOU3P1Te8cCQOPV8G9R0SzUF/cJKM4WpBa1IqvLOLglFVlPvDleDfbhUgChn/sMbXSzE8p1uEJK+lZXapFavx1fjKFy1htRLnJwrNk+TjHZ2brD0YG5TW5CeZGwAzvW/w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44dce304-d50d-435b-5983-08d7a58abec5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 13:46:02.1988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBoWsMAyribz/D8QYoZZ7Pqq8CtX8oUD5Xcm1FKGqPGTrEshjjWc3r7LeFYzZJAPSWledVtIbApsm6v67ayl407irIJHnHBfKkr5b9y7mvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3463
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.21.106
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.01.2020 23:05, Andrey Shinkevich wrote:
> 
> 
> On 27/11/2019 21:08, Vladimir Sementsov-Ogievskiy wrote:
>> Currently, block_copy operation lock the whole requested region. But
>> there is no reason to lock clusters, which are already copied, it will
>> disturb other parallel block_copy requests for no reason.
>>
>> Let's instead do the following:
>>
>> Lock only sub-region, which we are going to operate on. Then, after
>> copying all dirty sub-regions, we should wait for intersecting
>> requests block-copy, if they failed, we should retry these new dirty
>> clusters.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>    block/block-copy.c | 116 +++++++++++++++++++++++++++++++++++++--------
>>    1 file changed, 95 insertions(+), 21 deletions(-)
>>
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 20068cd699..aca44b13fb 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
>> @@ -39,29 +39,62 @@ static BlockCopyInFlightReq *block_copy_find_inflight_req(BlockCopyState *s,
>>        return NULL;
>>    }
>>    
>> -static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s,
>> -                                                       int64_t offset,
>> -                                                       int64_t bytes)
>> +/*
>> + * If there are no intersecting requests return false. Otherwise, wait for the
>> + * first found intersecting request to finish and return true.
>> + */
>> +static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t start,
>> +                                             int64_t end)
>>    {
>> -    BlockCopyInFlightReq *req;
>> +    BlockCopyInFlightReq *req = block_copy_find_inflight_req(s, start, end);
>>    
>> -    while ((req = block_copy_find_inflight_req(s, offset, bytes))) {
>> -        qemu_co_queue_wait(&req->wait_queue, NULL);
>> +    if (!req) {
>> +        return false;
>>        }
>> +
>> +    qemu_co_queue_wait(&req->wait_queue, NULL);
>> +
>> +    return true;
>>    }
>>    
>> +/* Called only on full-dirty region */
>>    static void block_copy_inflight_req_begin(BlockCopyState *s,
>>                                              BlockCopyInFlightReq *req,
>>                                              int64_t offset, int64_t bytes)
>>    {
>> +    assert(!block_copy_find_inflight_req(s, offset, bytes));
>> +
>> +    bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
>> +
>>        req->offset = offset;
>>        req->bytes = bytes;
>>        qemu_co_queue_init(&req->wait_queue);
>>        QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
>>    }
>>    
>> -static void coroutine_fn block_copy_inflight_req_end(BlockCopyInFlightReq *req)
>> +static void coroutine_fn block_copy_inflight_req_shrink(BlockCopyState *s,
>> +        BlockCopyInFlightReq *req, int64_t new_bytes)
>>    {
>> +    if (new_bytes == req->bytes) {
>> +        return;
>> +    }
>> +
>> +    assert(new_bytes > 0 && new_bytes < req->bytes);
>> +
>> +    bdrv_set_dirty_bitmap(s->copy_bitmap,
>> +                          req->offset + new_bytes, req->bytes - new_bytes);
>> +
>> +    req->bytes = new_bytes;
>> +    qemu_co_queue_restart_all(&req->wait_queue);
> 
> Won't we get the performance degradation with that function frequent call?

Why do you think so? In IO most of performance depends on disk speed and how
we organize requests sequence. The whole original series shows performance improvement.

This patch reduces lock around request, locking only the part we are working on now,
this is for better interactivity. After calling block-status, the request is shrinked
to possibly unlock some other requests, waiting on the tail of our request.. Do you
have a better suggestion on this synchronization?

> 
>> +}
>> +
>> +static void coroutine_fn block_copy_inflight_req_end(BlockCopyState *s,
>> +                                                     BlockCopyInFlightReq *req,
>> +                                                     int ret)
>> +{
>> +    if (ret < 0) {
>> +        bdrv_set_dirty_bitmap(s->copy_bitmap, req->offset, req->bytes);
>> +    }
>>        QLIST_REMOVE(req, list);
>>        qemu_co_queue_restart_all(&req->wait_queue);
>>    }
>> @@ -344,12 +377,19 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
>>        return ret;
>>    }
>>    
>> -int coroutine_fn block_copy(BlockCopyState *s,
>> -                            int64_t offset, uint64_t bytes,
>> -                            bool *error_is_read)
>> +/*
>> + * block_copy_dirty_clusters
>> + *
>> + * Copy dirty clusters in @start/@bytes range.
> 
> %s/start/offset/ ?
> 
>> + * Returns 1 if dirty clusters found and successfully copied, 0 if no dirty
>> + * clusters found and -errno on failure.
>> + */
>> +static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
>> +                                                  int64_t offset, int64_t bytes,
>> +                                                  bool *error_is_read)
>>    {
>>        int ret = 0;
>> -    BlockCopyInFlightReq req;
>> +    bool found_dirty = false;
>>    
>>        /*
>>         * block_copy() user is responsible for keeping source and target in same
>> @@ -361,10 +401,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>        assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>>        assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
>>    
>> -    block_copy_wait_inflight_reqs(s, offset, bytes);
>> -    block_copy_inflight_req_begin(s, &req, offset, bytes);
>> -
>>        while (bytes) {
>> +        BlockCopyInFlightReq req;
>>            int64_t next_zero, cur_bytes, status_bytes;
>>    
>>            if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
>> @@ -374,6 +412,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>                continue; /* already copied */
>>            }
>>    
>> +        found_dirty = true;
>> +
>>            cur_bytes = MIN(bytes, s->copy_size);
>>    
>>            next_zero = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset,
>> @@ -383,10 +423,12 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>                assert(next_zero < offset + cur_bytes); /* no need to do MIN() */
>>                cur_bytes = next_zero - offset;
>>            }
>> +        block_copy_inflight_req_begin(s, &req, offset, cur_bytes);
>>    
>>            ret = block_copy_block_status(s, offset, cur_bytes, &status_bytes);
>> +        block_copy_inflight_req_shrink(s, &req, status_bytes);
>>            if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
>> -            bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, status_bytes);
>> +            block_copy_inflight_req_end(s, &req, 0);
>>                s->progress_reset_callback(s->progress_opaque);
>>                trace_block_copy_skip_range(s, offset, status_bytes);
>>                offset += status_bytes;
>> @@ -398,15 +440,13 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>    
>>            trace_block_copy_process(s, offset);
>>    
>> -        bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
>> -
>>            co_get_from_shres(s->mem, cur_bytes);
>>            ret = block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_ZERO,
>>                                     error_is_read);
>>            co_put_to_shres(s->mem, cur_bytes);
>> +        block_copy_inflight_req_end(s, &req, ret);
>>            if (ret < 0) {
>> -            bdrv_set_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
>> -            break;
>> +            return ret;
>>            }
>>    
>>            s->progress_bytes_callback(cur_bytes, s->progress_opaque);
>> @@ -414,7 +454,41 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>            bytes -= cur_bytes;
>>        }
>>    
>> -    block_copy_inflight_req_end(&req);
>> +    return found_dirty;
>> +}
>>    
>> -    return ret;
>> +int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t bytes,
>> +                            bool *error_is_read)
>> +{
>> +    while (true) {
>> +        int ret = block_copy_dirty_clusters(s, start, bytes, error_is_read);
>> +
>> +        if (ret < 0) {
>> +            /*
>> +             * IO operation failed, which means the whole block_copy request
>> +             * failed.
>> +             */
>> +            return ret;
>> +        }
>> +        if (ret) {
>> +            /*
>> +             * Something was copied, which means that there were yield points
>> +             * and some new dirty bits may appered (due to failed parallel
>> +             * block-copy requests).
>> +             */
>> +            continue;
>> +        }
>> +
>> +        /*
>> +         * Here ret == 0, which means that there is no dirty clusters in
> 
> there is no dirty cluster in
> 
>> +         * requested region.
>> +         */
>> +
>> +        if (!block_copy_wait_one(s, start, bytes)) {
>> +            /* No dirty bits and nothing to wait: the whole request is done */
>> +            break;
>> +        }
>> +    }
>> +
>> +    return 0;
>>    }
>>
> 


-- 
Best regards,
Vladimir

