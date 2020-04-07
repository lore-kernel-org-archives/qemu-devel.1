Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3D3C2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B41206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uKkVCq1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B41206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkLx-00059j-Ui
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLkKx-0004Ee-5x
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLkKu-0002zf-Qv
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:16:01 -0400
Received: from mail-am6eur05on2124.outbound.protection.outlook.com
 ([40.107.22.124]:46065 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLkKu-0002yb-Jx; Tue, 07 Apr 2020 05:16:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxunCLoG9SKVCfR/n+0By2tiaIsqGRutYzNd+r5Hhppfp4p8gii2C2XvpqpvIMNrqQAEKQLhzmn5+4yThOyiXdZlFqjZHp+YmUpReRNLQCc8ji/SCjMoS09K6VW2qEq5Rz4uf/NxN6QpoE9SXpdylT5fzeaVKYb23hD2qjDZ1mD7Sw5Y74+s1/FwVRK0VPb9rDB7sBpEklC72hIK+PeWrmBThQp9+xt9Kphg4nDVUlqPObXAcSKN917tdfIRa7BaY7zAy3Crp30KR/JUNR6JJHGPcrosHsF97K4e+dbKVqBqBlzWcx6+ACMt8bnsuAsN1m0i5IUj5liQgbFzzhLtNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50M4jiNl6fsDCvPJaOEms8cwvqCIKfbYnO8zuoTuDu4=;
 b=l5TGY0tDhkHiuJmIvhlfvMWl0eRnqg2SSeAPcFRnIHP1rNWCdgikQSpKFTOAjvy2Zbvh2CiYSnvv5eD1Wl16Z9sDbzfDlcJ6+cETt52gAIJXHG/TLZVCpDlYFGQqsrpRyJZP03DrqNHu6hw+M70w5P2zR1efbnzOa8/420BBXfybiQUEQDMG1OyQpVXN39CJxhiktcLyqhwSprRj5h661V8YHk7PrkjjnAwZDcpvSWQpP016jbyOsTiG4ZcA+p3rLZUigJlazCl8YVfXE26BvovY7AaI2kbdhPoiNpkyqa76GOam7ojqFAGWjmbOtxbxr+lMSJae7Rlb7cGmmZNzFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50M4jiNl6fsDCvPJaOEms8cwvqCIKfbYnO8zuoTuDu4=;
 b=uKkVCq1Duq2fiAgngWKYnCq1Exa+Ry8rbbjYx5FVLDytNWQCfJL1iHFBguJc6gm68P5zZcMouSpy3xJ997Wdsc/XWKpG7b1eDTPXJKsYc86ObYiu9ylUysMMoNKlyjMMtKlGFJ4tOiQ7HCfrzDCAyXzY4aFo142R5KN5wjpxRHY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5432.eurprd08.prod.outlook.com (10.141.173.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Tue, 7 Apr 2020 09:15:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 09:15:58 +0000
Subject: Re: [PATCH for-5.0 v2 3/3] block: Fix blk->in_flight during
 blk_wait_while_drained()
To: Kevin Wolf <kwolf@redhat.com>
References: <20200406171403.6761-1-kwolf@redhat.com>
 <20200406171403.6761-4-kwolf@redhat.com>
 <3c8fd1b8-5138-b6eb-1e9d-55e03ad078c7@virtuozzo.com>
 <20200407085915.GB7695@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200407121557415
Message-ID: <e7338574-99a7-9911-73f8-f29436569c6d@virtuozzo.com>
Date: Tue, 7 Apr 2020 12:15:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200407085915.GB7695@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0062.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::39) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM6PR04CA0062.eurprd04.prod.outlook.com (2603:10a6:20b:f0::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16 via Frontend Transport; Tue, 7 Apr 2020 09:15:58 +0000
X-Tagtoolbar-Keys: D20200407121557415
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05f67d02-7ffc-42a0-7d73-08d7dad448ed
X-MS-TrafficTypeDiagnostic: AM7PR08MB5432:
X-Microsoft-Antispam-PRVS: <AM7PR08MB543236A132BFA27947923833C1C30@AM7PR08MB5432.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(136003)(396003)(39840400004)(346002)(366004)(186003)(6486002)(478600001)(86362001)(52116002)(16576012)(26005)(31696002)(956004)(5660300002)(2616005)(316002)(66476007)(8676002)(36756003)(2906002)(16526019)(81166006)(31686004)(8936002)(4326008)(6916009)(66946007)(66556008)(81156014);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LI2ylLy/cfKWIgCVOUmBhLKpuwxnK8u4QYx4yu+85xYcy9PIYXSwIaBB0nxzw6c3b4mvLLArySI9e99e/VzcXdD8DtX75QEiYkGEsQ3jqa+dIAgX92ERJOZk9AtqUF0luGXGNHHqjCUPOOKIH3rNqa1f2M8LmH2yIF7iSmFFkj1exRDQR3XnEn52tI79hPYzW/oWL9W//7QhxLbbl4iWtTV1iciTF94UQsgt3boR0t7PiKVw7E4StsX4+o64ZdYQi0zniNNnrFj9JcJWpv5x5vKdb6nr1P5iZk4bGfrZOd8/tVymoLVXDxVGjjagaTnduCa+gtsK3CFJ5Ag8bZ4ARyfGqwhaVtAhadMxOKNDiCCLEkA+6PfHZvulq3sy4W6GD4MYYa7hIoRQNQDEiheJfwkydazYkVn2hf29tzmGkA3sYGpzZko3sKUWrgKvlUso
X-MS-Exchange-AntiSpam-MessageData: u6MDrM/BAUXcFo1KZwu3LFOOn8vwvKOocDYapE8Fo/j8F9TppeUFPJDVe9AyMPwg9rqqH/r25Uz2c3NmpeFTWxK/MWfCmw6LL2JOXesnshaJ/TcwUFARcNijf1N+ZEYOGpkvvyvMxDwi/abQlxu9+Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f67d02-7ffc-42a0-7d73-08d7dad448ed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 09:15:58.8785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIeyXFfADCFTiSEkOq+JthWsKF6ewToKzQBiGvECJUEknxrbOz6CJZ4PhzleepbuP1HotxfIOqNJLBILdzd/XSETxf+k3u8HE2v0/Jf9eYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5432
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.124
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
Cc: qemu-block@nongnu.org, s.reiter@proxmox.com, qemu-devel@nongnu.org,
 dietmar@proxmox.com, stefanha@redhat.com, mreitz@redhat.com,
 t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.04.2020 11:59, Kevin Wolf wrote:
> Am 07.04.2020 um 08:52 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 06.04.2020 20:14, Kevin Wolf wrote:
>>> Waiting in blk_wait_while_drained() while blk->in_flight is increased
>>> for the current request is wrong because it will cause the drain
>>> operation to deadlock.
>>>
>>> This patch makes sure that blk_wait_while_drained() is called with
>>> blk->in_flight increased exactly once for the current request, and that
>>> it temporarily decreases the counter while it waits.
>>>
>>> Fixes: cf3129323f900ef5ddbccbe86e4fa801e88c566e
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>    block/block-backend.c | 17 +++++------------
>>>    1 file changed, 5 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/block/block-backend.c b/block/block-backend.c
>>> index d330e08b05..f621435f0b 100644
>>> --- a/block/block-backend.c
>>> +++ b/block/block-backend.c
>>> @@ -1140,10 +1140,15 @@ static int blk_check_byte_request(BlockBackend *blk, int64_t offset,
>>>        return 0;
>>>    }
>>> +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
>>>    static void coroutine_fn blk_wait_while_drained(BlockBackend *blk)
>>>    {
>>> +    assert(blk->in_flight > 0);
>>
>> Hmm. You promise to make sure that in_flight increased exactly once.
>> Shouldn't it be assert(blk->in_flight == 1) ?
> 
> Exactly once for this specific request, but if you have multiple
> requests in flight, blk->in_flight will be the sum of all requests.
> 
> Just asserting > 0 should still catch potential bugs because you won't
> always have multiple requests in flight.
> 
>>> +
>>>        if (blk->quiesce_counter && !blk->disable_request_queuing) {
>>> +        blk_dec_in_flight(blk);
>>>            qemu_co_queue_wait(&blk->queued_requests, NULL);
>>> +        blk_inc_in_flight(blk);
>>>        }
>>>    }
>>> @@ -1416,12 +1421,6 @@ static void blk_aio_read_entry(void *opaque)
>>>        BlkRwCo *rwco = &acb->rwco;
>>>        QEMUIOVector *qiov = rwco->iobuf;
>>> -    if (rwco->blk->quiesce_counter) {
>>> -        blk_dec_in_flight(rwco->blk);
>>> -        blk_wait_while_drained(rwco->blk);
>>> -        blk_inc_in_flight(rwco->blk);
>>> -    }
>>
>> Hm, you drop it as it's called from blk_do_preadv too. I think it
>> worth mentioning in commit message still.
> 
> Okay, I can add a sentence like "The blk_wait_while_drained() call in
> blk_aio_read/write_entry is redundant with the one in blk_co_*(), so
> drop it."

Yes, that works
> 
>>> -
>>>        assert(qiov->size == acb->bytes);
>>>        rwco->ret = blk_do_preadv(rwco->blk, rwco->offset, acb->bytes,
>>>                                  qiov, rwco->flags);
>>> @@ -1434,12 +1433,6 @@ static void blk_aio_write_entry(void *opaque)
>>>        BlkRwCo *rwco = &acb->rwco;
>>>        QEMUIOVector *qiov = rwco->iobuf;
>>> -    if (rwco->blk->quiesce_counter) {
>>> -        blk_dec_in_flight(rwco->blk);
>>> -        blk_wait_while_drained(rwco->blk);
>>> -        blk_inc_in_flight(rwco->blk);
>>> -    }
>>> -
>>>        assert(!qiov || qiov->size == acb->bytes);
>>>        rwco->ret = blk_do_pwritev_part(rwco->blk, rwco->offset, acb->bytes,
>>>                                        qiov, 0, rwco->flags);
>>>
>>
>> With assert(blk->in_flight == 1) and mention extra wait removing in commit message:
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> Thanks, and I hope you agree with blk->in_flight > 0 now.
> 

Yes, I agree.

Hmm still interesting, could we move somehow blk_wait_while_drained out of inc/dec section? It seems there are no yields and no coroutine switches between first in_flight increment and call of blk_wait_while_drained, only initialization of acb.


-- 
Best regards,
Vladimir

