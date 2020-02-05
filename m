Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2294EC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D604B21741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ay7ygREB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D604B21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIzg-0004pR-11
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izIyo-0004D3-Fg
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:36:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izIym-0000NB-H1
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:36:26 -0500
Received: from mail-eopbgr80127.outbound.protection.outlook.com
 ([40.107.8.127]:28933 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izIyl-0008UD-HR; Wed, 05 Feb 2020 06:36:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeZR76D/6ERIuH+murHuvdyrWlAqIGc0RetNFVJ3nZDZBsTNR2u974tSsMM+IGGtfYOHdK9lXfDhzS73Eky7NNRhLSHN//c+GO4suinTPb72KKm3nH9/8D+KjcDYJBSsS4BH5/+hciGMq3fqPtjaj9ZiMGwne7f/wcuUVBBmyqQlOC7935LNXqBkgo62SK5QEUSseUnq4KEuULoMRquEMyAeGgMoGUWumqRGke4gvzYYcnUkRKvvH/2+L66B0b5/0RSVYMnWgC23UyNYYvVCT0joVAck8/8z57TA3T4k4MqexNpJ6AXJ46FYd9dMGsZM1AALsCSfc641q9AU4Qk53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZafg8sS5kseN39EMEmJH0bkmpgC9kxMHo2sDB3PZRs=;
 b=GoH/r754iQLjh5XsCb4z2Xz2hKMoy6b5CEKk108JffOfqIg8lEFUYN9sKr+2pC17ArSmJijKLrpbj0agUecDkSF7LWo3S1ST5+tDwG1sulXlrM2hbJr5/OzEnu6JM+LXJgmgIzd6g2v++wXNEPE3qCX4GTo8xIpvnYCdjvklcaS1Q29HDiDRibaQC973RIwvBmfN1DqZst5psNK64PEtcKs18xJpEHGkIMe/KqA70n2cQtjNJgT7VU34fwZUploYeZ7bJh7dDSIYLa3VsSTbxBqK6ueKbSmVAN2VzLr4U6jEW/Dgr0lCssxCJ/5n1S4nBE9lPPDAm5VZX5Ex7wqD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZafg8sS5kseN39EMEmJH0bkmpgC9kxMHo2sDB3PZRs=;
 b=ay7ygREBNEwDX8Dg9Hjxwexp+ew0+3UZyMvxQfUCTmZCbLUrOdJ+4QrM+eMhtvuIlV9vE9r3BTpFN0j5zbaX4xndUtg5tEWLrlwvnXmVFBz7C0ajzCKZ70nxfjeAGh95eGkIlQwsUutUkoNm4amI0cFICIMhANyk0H9+qsgbbx8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB4622.eurprd08.prod.outlook.com (20.178.15.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Wed, 5 Feb 2020 11:36:21 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0%2]) with mapi id 15.20.2686.034; Wed, 5 Feb 2020
 11:36:20 +0000
Subject: Re: [PATCH v2 4/7] block/block-copy: refactor interfaces to use bytes
 instead of end
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-5-vsementsov@virtuozzo.com>
 <519528a3-3614-fd05-f828-824ebc2dba1c@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200205143618638
Message-ID: <0d491201-1b4c-a24e-2150-0a49085bff2a@virtuozzo.com>
Date: Wed, 5 Feb 2020 14:36:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <519528a3-3614-fd05-f828-824ebc2dba1c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:7:67::34) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR07CA0024.eurprd07.prod.outlook.com (2603:10a6:7:67::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.10 via Frontend Transport; Wed, 5 Feb 2020 11:36:20 +0000
X-Tagtoolbar-Keys: D20200205143618638
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d06a4b5d-44a6-4770-3695-08d7aa2f9f3b
X-MS-TrafficTypeDiagnostic: VI1PR08MB4622:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB46220CBDA2C36B38CDAFFDADC1020@VI1PR08MB4622.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39850400004)(199004)(189003)(2906002)(86362001)(186003)(16526019)(2616005)(31696002)(956004)(66946007)(66476007)(66556008)(5660300002)(52116002)(6486002)(16576012)(54906003)(110136005)(316002)(53546011)(26005)(478600001)(81156014)(8676002)(8936002)(81166006)(4326008)(31686004)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4622;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMNJ3X8cstRaknavX3jIKNIGa2VV0Zpy3ERE30B/sH8AZIeStJhzHFB8OXMUWLaTgBjim+aO21K/1VieLZXT9AJFQxeP334G9uLShw5G6v+XAW1iVKvS7rkkzYe30jC0Ei0Sk2z85wol7ucM8nP8XSpVIcrQwkLpYoE2tdHpsDU35ups+/MCyl0hd0/MFzB3F6MRz37FCwtYnWL6/0YZZpVZXF18b6gqr4rOkmG49mZd2dIeyGS9J1DDqdwms55RoEfgqUA63mjSUOAkzZfAZenA5F3mnIfsa0yHYcVeRy7fQNBXevM32hOJs4SJ81yIk6qXayJZWileT8v2cGbQ8Vgxk9WN7BgopkVIqVyimQ8Oqw3UApcgXFt5mm7OQQbqjXqoH9o3AwRmHI/FcfiJM80WZLzpUdw5lCPy8g1wAyaaQtmVFyr2K+Li3uCX9Qn+
X-MS-Exchange-AntiSpam-MessageData: 1q5HNBXY/Qn1pvobhoVfa86qLON5jxbm7MxuwpJ+m5JSemkioTp4dgiI+KkQCXy6UF8L7lf3YdwcUxE3EpX9pznwDiPbVNpumsRJYG1UxNlO76B3BG/B8/kANaxoia4+/xrM17QpPj4JlR9LdZcMbg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06a4b5d-44a6-4770-3695-08d7aa2f9f3b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 11:36:20.9476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n78r37coMJne8iYclv7DXUHjyszZZbkVkKUSXM3njllwZm1WuY0JRicqfOGoJupawCg4pwZDE54r+gDa1J40ezqkx1dSK/M8qXGeM1z4Bhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4622
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.127
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

29.01.2020 20:12, Andrey Shinkevich wrote:
> 
> 
> On 27/11/2019 21:08, Vladimir Sementsov-Ogievskiy wrote:
>> We have a lot of "chunk_end - start" invocations, let's switch to
>> bytes/cur_bytes scheme instead.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>    include/block/block-copy.h |  4 +--
>>    block/block-copy.c         | 68 ++++++++++++++++++++------------------
>>    2 files changed, 37 insertions(+), 35 deletions(-)
>>
>> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
>> index 0a161724d7..7321b3d305 100644
>> --- a/include/block/block-copy.h
>> +++ b/include/block/block-copy.h
>> @@ -19,8 +19,8 @@
>>    #include "qemu/co-shared-resource.h"
>>    
>>    typedef struct BlockCopyInFlightReq {
>> -    int64_t start_byte;
>> -    int64_t end_byte;
>> +    int64_t start;
>> +    int64_t bytes;
>>        QLIST_ENTRY(BlockCopyInFlightReq) list;
>>        CoQueue wait_queue; /* coroutines blocked on this request */
>>    } BlockCopyInFlightReq;
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 94e7e855ef..cc273b6cb8 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
>> @@ -26,12 +26,12 @@
>>    
>>    static BlockCopyInFlightReq *block_copy_find_inflight_req(BlockCopyState *s,
>>                                                              int64_t start,
>> -                                                          int64_t end)
>> +                                                          int64_t bytes)
>>    {
>>        BlockCopyInFlightReq *req;
>>    
>>        QLIST_FOREACH(req, &s->inflight_reqs, list) {
>> -        if (end > req->start_byte && start < req->end_byte) {
>> +        if (start + bytes > req->start && start < req->start + req->bytes) {
>>                return req;
>>            }
>>        }
>> @@ -41,21 +41,21 @@ static BlockCopyInFlightReq *block_copy_find_inflight_req(BlockCopyState *s,
>>    
>>    static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s,
>>                                                           int64_t start,
>> -                                                       int64_t end)
>> +                                                       int64_t bytes)
>>    {
>>        BlockCopyInFlightReq *req;
>>    
>> -    while ((req = block_copy_find_inflight_req(s, start, end))) {
>> +    while ((req = block_copy_find_inflight_req(s, start, bytes))) {
>>            qemu_co_queue_wait(&req->wait_queue, NULL);
>>        }
>>    }
>>    
>>    static void block_copy_inflight_req_begin(BlockCopyState *s,
>>                                              BlockCopyInFlightReq *req,
>> -                                          int64_t start, int64_t end)
>> +                                          int64_t start, int64_t bytes)
>>    {
>> -    req->start_byte = start;
>> -    req->end_byte = end;
>> +    req->start = start;
>> +    req->bytes = bytes;
>>        qemu_co_queue_init(&req->wait_queue);
>>        QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
>>    }
>> @@ -150,24 +150,26 @@ void block_copy_set_callbacks(
>>    /*
>>     * block_copy_do_copy
>>     *
>> - * Do copy of cluser-aligned chunk. @end is allowed to exceed s->len only to
>> - * cover last cluster when s->len is not aligned to clusters.
>> + * Do copy of cluser-aligned chunk. Requested region is allowed to exceed s->len
> 
> cluster-...
> 
>> + * only to cover last cluster when s->len is not aligned to clusters.
>>     *
>>     * No sync here: nor bitmap neighter intersecting requests handling, only copy.
>>     *
>>     * Returns 0 on success.
>>     */
>>    static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
>> -                                           int64_t start, int64_t end,
>> +                                           int64_t start, int64_t bytes,
>>                                               bool zeroes, bool *error_is_read)
>>    {
>>        int ret;
>> -    int nbytes = MIN(end, s->len) - start;
>> +    int nbytes = MIN(start + bytes, s->len) - start;
>>        void *bounce_buffer = NULL;
>>    
>> +    assert(start >= 0 && bytes > 0 && INT64_MAX - start >= bytes);
>>        assert(QEMU_IS_ALIGNED(start, s->cluster_size));
>> -    assert(QEMU_IS_ALIGNED(end, s->cluster_size));
>> -    assert(end < s->len || end == QEMU_ALIGN_UP(s->len, s->cluster_size));
>> +    assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
>> +    assert(start + bytes <= s->len ||
> 
> The '<=' looks correct but I wonder how only '<' worked without
> assertion failure before.

No difference, if end == s->len, and end is aligned, then len is aligned too and "end == QEMU_ALIGN_UP(s->len, s->cluster_size)" is true. But "<=" looks more native for end and file len.

>Was the s->len never aligned to the cluster size?
> 
>> +           start + bytes == QEMU_ALIGN_UP(s->len, s->cluster_size));
>>    
>>        if (zeroes) {
>>            ret = bdrv_co_pwrite_zeroes(s->target, start, nbytes, s->write_flags &
>> @@ -347,7 +349,6 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>                                bool *error_is_read)
>>    {
>>        int ret = 0;
>> -    int64_t end = bytes + start; /* bytes */
>>        BlockCopyInFlightReq req;
>>    
>>        /*
>> @@ -358,58 +359,59 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>               bdrv_get_aio_context(s->target->bs));
>>    
>>        assert(QEMU_IS_ALIGNED(start, s->cluster_size));
>> -    assert(QEMU_IS_ALIGNED(end, s->cluster_size));
>> +    assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
>>    
>>        block_copy_wait_inflight_reqs(s, start, bytes);
>> -    block_copy_inflight_req_begin(s, &req, start, end);
>> +    block_copy_inflight_req_begin(s, &req, start, bytes);
>>    
>> -    while (start < end) {
>> -        int64_t next_zero, chunk_end, status_bytes;
>> +    while (bytes) {
>> +        int64_t next_zero, cur_bytes, status_bytes;
>>    
>>            if (!bdrv_dirty_bitmap_get(s->copy_bitmap, start)) {
>>                trace_block_copy_skip(s, start);
>>                start += s->cluster_size;
>> +            bytes -= s->cluster_size;
>>                continue; /* already copied */
>>            }
>>    
>> -        chunk_end = MIN(end, start + s->copy_size);
>> +        cur_bytes = MIN(bytes, s->copy_size);
>>    
>>            next_zero = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
>> -                                                chunk_end - start);
>> +                                                cur_bytes);
>>            if (next_zero >= 0) {
>>                assert(next_zero > start); /* start is dirty */
>> -            assert(next_zero < chunk_end); /* no need to do MIN() */
>> -            chunk_end = next_zero;
>> +            assert(next_zero < start + cur_bytes); /* no need to do MIN() */
>> +            cur_bytes = next_zero - start;
>>            }
>>    
>> -        ret = block_copy_block_status(s, start, chunk_end - start,
>> -                                      &status_bytes);
>> +        ret = block_copy_block_status(s, start, cur_bytes, &status_bytes);
>>            if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
>>                bdrv_reset_dirty_bitmap(s->copy_bitmap, start, status_bytes);
>>                s->progress_reset_callback(s->progress_opaque);
>>                trace_block_copy_skip_range(s, start, status_bytes);
>>                start += status_bytes;
>> +            bytes -= status_bytes;
>>                continue;
>>            }
>>    
>> -        chunk_end = MIN(chunk_end, start + status_bytes);
>> +        cur_bytes = MIN(cur_bytes, status_bytes);
>>    
>>            trace_block_copy_process(s, start);
>>    
>> -        bdrv_reset_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
>> +        bdrv_reset_dirty_bitmap(s->copy_bitmap, start, cur_bytes);
>>    
>> -        co_get_from_shres(s->mem, chunk_end - start);
>> -        ret = block_copy_do_copy(s, start, chunk_end, ret & BDRV_BLOCK_ZERO,
>> +        co_get_from_shres(s->mem, cur_bytes);
>> +        ret = block_copy_do_copy(s, start, cur_bytes, ret & BDRV_BLOCK_ZERO,
>>                                     error_is_read);
>> -        co_put_to_shres(s->mem, chunk_end - start);
>> +        co_put_to_shres(s->mem, cur_bytes);
>>            if (ret < 0) {
>> -            bdrv_set_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
>> +            bdrv_set_dirty_bitmap(s->copy_bitmap, start, cur_bytes);
>>                break;
>>            }
>>    
>> -        s->progress_bytes_callback(chunk_end - start, s->progress_opaque);
>> -        start = chunk_end;
>> -        ret = 0;
>> +        s->progress_bytes_callback(cur_bytes, s->progress_opaque);
>> +        start += cur_bytes;
>> +        bytes -= cur_bytes;
>>        }
>>    
>>        block_copy_inflight_req_end(&req);
>>
> 
> At the first glance, we would only benefit from the 'while' loop by that
> substitution to reduce the number of addition operations.
> 
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> 


-- 
Best regards,
Vladimir

