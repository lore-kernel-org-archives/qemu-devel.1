Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E274BC34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 07:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977F224654
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 07:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wohRfcJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977F224654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4gAh-0006YR-Qb
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 02:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4g9t-00062X-QN
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 02:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4g9r-0003VF-Su
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 02:22:05 -0500
Received: from mail-eopbgr50091.outbound.protection.outlook.com
 ([40.107.5.91]:38658 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j4g9r-0003Us-53; Thu, 20 Feb 2020 02:22:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6W5jq8VE1EYlSJbAOMul+Zzgtx5MgoN8suOKhDlYSCKEzHTBdX35/4oVUqw19KUHRe15FmMzYWTRDPtbGZ5cPUEDtDdWNqFGSBQF/HSZw7tWCCJ/rqZzV8yE5cUrRsHidxbX2FEh7jQiGzKo3mGAxbYnOGg1uNkMYWal+VIDgOdRrQarheuXfHOmNNHIkdJsaX+xMPFou69fxGclZIc+2l2k19mDWnf50q5P1Vi8IjvY6jvSBDoqK+w4iI+FqJfsMpVv6/P5Q5R5CAI6KYXY3a29HOI+FiU+siSeqq0nhBxPj2BZbZdFZWUYG9m7lXIqerglMMhd7YXGkCKFpaRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di5VmdVk5RsBF3ydnxd8iJ4FAfFvrqgalBGFC7zMEoM=;
 b=CiKkCR8+P5XBSNPn3ei2EEQ5rmhGxfxI+ai4Vpu6kHvRua29cclFz1FiYbkjTZ1FaWDgBqwDjZnG2UItkfbcTG66M+OlCKjo7gFZ3m7MwPttl2F2v6ud8DbmDZcQwbNus9K6rjr6Ey3U8qcHSG8z4WZt/0JmLswJM9E9zwCbmzOPEXLyWAWeowCjzJXI/+nXhY1iABq2lIVP4WovAWLN2SlgzXXfucVLr3tIZr8Zfd4mixjjdKvj/9c/+g80Uo9GFqlms+0vdpHOAXxRa4iPTIlUSgmrhmtYI9EOu0AKXre33uS0OVbauxorpv0WVwtrZAe8tCEC1qgkoUd3daPtAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di5VmdVk5RsBF3ydnxd8iJ4FAfFvrqgalBGFC7zMEoM=;
 b=wohRfcJO2TuBgaFV/k1hO1Ej+86bAI9B0TScD0p4JoOVAz2N7Qy/JUT9XasmnjTRNsWewoocgSmM4MVocPCTZzdEP652uKz8Mjk48YYmWaaoIweWMeRcPOd7zzP4VWGJVWsr7No1suuFxNOc+80mNf+8pK8G/mFrOwrThHisdEQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3928.eurprd08.prod.outlook.com (20.179.2.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 20 Feb 2020 07:21:59 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 07:21:59 +0000
Subject: Re: [PATCH v2 6/7] block/block-copy: reduce intersecting request lock
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-7-vsementsov@virtuozzo.com>
 <1ae71183-4732-fbe6-62d5-58252f01d2d6@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200220102157404
Message-ID: <d1f5f953-8dfe-2f27-c00a-9e0d7070a13e@virtuozzo.com>
Date: Thu, 20 Feb 2020 10:21:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <1ae71183-4732-fbe6-62d5-58252f01d2d6@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR09CA0044.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::12) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR09CA0044.eurprd09.prod.outlook.com (2603:10a6:7:3c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Thu, 20 Feb 2020 07:21:58 +0000
X-Tagtoolbar-Keys: D20200220102157404
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22e2de84-2950-4016-984a-08d7b5d592c6
X-MS-TrafficTypeDiagnostic: AM6PR08MB3928:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB39280CA25B29172EA0F7F98BC1130@AM6PR08MB3928.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(136003)(366004)(39830400003)(346002)(189003)(199004)(52116002)(478600001)(16526019)(26005)(66946007)(6486002)(5660300002)(31696002)(186003)(16576012)(53546011)(316002)(31686004)(86362001)(4326008)(66556008)(8936002)(66476007)(107886003)(8676002)(81156014)(81166006)(2906002)(2616005)(956004)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3928;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vC94tPzoC1M6j5kdYJtRnaa35rm1+DK4GBCR/dMgzVwgsq1dinz09V4SM2EyT4H/p02j7O59MhXRRpptSs+S5orvfWWGlZ3BXUpXyOlIb1GNVm3k+WBln1ZN2DrrwW9+6/IoX2z6pXAD+YxS7bIH+1VWfTX7sicxoJ4fYVL/G+mQFyPGEi5phQx3pHFPwJeODPCpWOJFHMsbqwLRdge+4aDQ5lf13pCxm9DsNKw41FpLamShpa1vW8/Q+Ym+k58jsnS+b4DPNUWFtmE6QDPzGY75que0akLyG6dsvWst+NMHDnXQqgQOY17Bz03j2Od6msnBwydGmKHdOifYNhPcTFDhVwIHvoNGK6/10J/u6P3AbcVQC++BDf7vspU7pWC3skPrtB7WnLi5XTUpTMPMnCXgMGRbgO3H5B4OwnWesep9gl6knhhqNtXTz5eoD50v
X-MS-Exchange-AntiSpam-MessageData: yElU77ff9iJJcj+n+YTARyGeKbRQk9T4eSFvtFvII9GR2rBtCqO2E3XKIyJ11TRd0e001Pi/lDcHt5c12A/Mq5yUo4jE1YIzSJYdp5VpaSouQsr5X/vVRDv+OL3GXG/I1hea9xvWkW18BxL3I2UOoA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e2de84-2950-4016-984a-08d7b5d592c6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 07:21:59.2833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWwNJWtLZ3q/Bn1/VeLv5vOTaK6IMq+dnuakQsqPLg0SztC9odEgDpPpldO218X4191LEKLpyGLD8b8k+9nwA14SM2LVSaF54VTkQ9SmnzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3928
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.91
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.02.2020 16:38, Max Reitz wrote:
> On 27.11.19 19:08, Vladimir Sementsov-Ogievskiy wrote:
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
>=20
> Just a thought spoken aloud:
>=20
> I would expect the number of intersecting CBW requests to be low in
> general, so I don=92t know how useful this change is in practice.  OTOH,
> it makes block_copy call the existing implementation in a loop, which
> seems just worse.
>=20
> But then again, in the common case, block_copy_dirty_clusters() won=92t
> copy anything because it=92s all been copied already, so there is no
> change; and even if something is copied, the second call will just
> re-check the dirty bitmap to see that the area=92s clean (which will be
> quick compared to the copy operation).  So there=92s probably nothing to
> worry about.
>=20
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/block-copy.c | 116 +++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 95 insertions(+), 21 deletions(-)
>>
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 20068cd699..aca44b13fb 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
>> @@ -39,29 +39,62 @@ static BlockCopyInFlightReq *block_copy_find_infligh=
t_req(BlockCopyState *s,
>>       return NULL;
>>   }
>>  =20
>> -static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *=
s,
>> -                                                       int64_t offset,
>> -                                                       int64_t bytes)
>> +/*
>> + * If there are no intersecting requests return false. Otherwise, wait =
for the
>> + * first found intersecting request to finish and return true.
>> + */
>> +static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t=
 start,
>> +                                             int64_t end)
>=20
> s/end/bytes/?
>=20
> (And maybe s/start/offset/, too)
>=20
>>   {
>> -    BlockCopyInFlightReq *req;
>> +    BlockCopyInFlightReq *req =3D block_copy_find_inflight_req(s, start=
, end);
>>  =20
>> -    while ((req =3D block_copy_find_inflight_req(s, offset, bytes))) {
>> -        qemu_co_queue_wait(&req->wait_queue, NULL);
>> +    if (!req) {
>> +        return false;
>>       }
>> +
>> +    qemu_co_queue_wait(&req->wait_queue, NULL);
>> +
>> +    return true;
>>   }
>>  =20
>> +/* Called only on full-dirty region */
>>   static void block_copy_inflight_req_begin(BlockCopyState *s,
>>                                             BlockCopyInFlightReq *req,
>>                                             int64_t offset, int64_t byte=
s)
>>   {
>> +    assert(!block_copy_find_inflight_req(s, offset, bytes));
>> +
>> +    bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
>> +
>>       req->offset =3D offset;
>>       req->bytes =3D bytes;
>>       qemu_co_queue_init(&req->wait_queue);
>>       QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
>>   }
>>  =20
>> -static void coroutine_fn block_copy_inflight_req_end(BlockCopyInFlightR=
eq *req)
>> +static void coroutine_fn block_copy_inflight_req_shrink(BlockCopyState =
*s,
>> +        BlockCopyInFlightReq *req, int64_t new_bytes)
>=20
> It took me a while to understand that this is operation drops the tail
> of the request.  I think there should be a comment on this.
>=20
> (I thought it would successively drop the head after each copy, and so I
> was wondering why the code didn=92t match that.)
>=20
>>   {
>> +    if (new_bytes =3D=3D req->bytes) {
>> +        return;
>> +    }
>> +
>> +    assert(new_bytes > 0 && new_bytes < req->bytes);
>> +
>> +    bdrv_set_dirty_bitmap(s->copy_bitmap,
>> +                          req->offset + new_bytes, req->bytes - new_byt=
es);> +
>> +    req->bytes =3D new_bytes;
>> +    qemu_co_queue_restart_all(&req->wait_queue);
>> +}
>> +
>> +static void coroutine_fn block_copy_inflight_req_end(BlockCopyState *s,
>> +                                                     BlockCopyInFlightR=
eq *req,
>> +                                                     int ret)
>> +{
>> +    if (ret < 0) {
>> +        bdrv_set_dirty_bitmap(s->copy_bitmap, req->offset, req->bytes);
>> +    }
>>       QLIST_REMOVE(req, list);
>>       qemu_co_queue_restart_all(&req->wait_queue);
>>   }
>> @@ -344,12 +377,19 @@ int64_t block_copy_reset_unallocated(BlockCopyStat=
e *s,
>>       return ret;
>>   }
>>  =20
>> -int coroutine_fn block_copy(BlockCopyState *s,
>> -                            int64_t offset, uint64_t bytes,
>> -                            bool *error_is_read)
>> +/*
>> + * block_copy_dirty_clusters
>> + *
>> + * Copy dirty clusters in @start/@bytes range.
>> + * Returns 1 if dirty clusters found and successfully copied, 0 if no d=
irty
>> + * clusters found and -errno on failure.
>> + */
>> +static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
>> +                                                  int64_t offset, int64=
_t bytes,
>> +                                                  bool *error_is_read)
>>   {
>>       int ret =3D 0;
>> -    BlockCopyInFlightReq req;
>> +    bool found_dirty =3D false;
>>  =20
>>       /*
>>        * block_copy() user is responsible for keeping source and target =
in same
>> @@ -361,10 +401,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>       assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>>       assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
>>  =20
>> -    block_copy_wait_inflight_reqs(s, offset, bytes);
>> -    block_copy_inflight_req_begin(s, &req, offset, bytes);
>> -
>>       while (bytes) {
>> +        BlockCopyInFlightReq req;
>>           int64_t next_zero, cur_bytes, status_bytes;
>>  =20
>>           if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
>> @@ -374,6 +412,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>               continue; /* already copied */
>>           }
>>  =20
>> +        found_dirty =3D true;
>> +
>>           cur_bytes =3D MIN(bytes, s->copy_size);
>>  =20
>>           next_zero =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offs=
et,
>> @@ -383,10 +423,12 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>               assert(next_zero < offset + cur_bytes); /* no need to do M=
IN() */
>>               cur_bytes =3D next_zero - offset;
>>           }
>> +        block_copy_inflight_req_begin(s, &req, offset, cur_bytes);
>>  =20
>>           ret =3D block_copy_block_status(s, offset, cur_bytes, &status_=
bytes);
>> +        block_copy_inflight_req_shrink(s, &req, status_bytes);
>=20
> block_copy_inflight_req_shrink() asserts that status_bytes <=3D cur_bytes=
.
>   That isn=92t necessarily correct, as block_copy_block_status() rounds u=
p
> on the last cluster.  So this should use the same MIN() as for the
> cur_bytes update after the next block.
>=20
> Would it make sense to move the block_copy_inflight_req_shrink() there
> and pass the updated cur_bytes to it?
>=20
>>           if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
>> -            bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, status_byte=
s);
>> +            block_copy_inflight_req_end(s, &req, 0);
>>               s->progress_reset_callback(s->progress_opaque);
>>               trace_block_copy_skip_range(s, offset, status_bytes);
>>               offset +=3D status_bytes;
>> @@ -398,15 +440,13 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>  =20
>>           trace_block_copy_process(s, offset);
>>  =20
>> -        bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
>> -
>>           co_get_from_shres(s->mem, cur_bytes);
>>           ret =3D block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BL=
OCK_ZERO,
>>                                    error_is_read);
>>           co_put_to_shres(s->mem, cur_bytes);
>> +        block_copy_inflight_req_end(s, &req, ret);
>>           if (ret < 0) {
>> -            bdrv_set_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
>> -            break;
>> +            return ret;
>>           }
>>  =20
>>           s->progress_bytes_callback(cur_bytes, s->progress_opaque);
>> @@ -414,7 +454,41 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>           bytes -=3D cur_bytes;
>>       }
>>  =20
>> -    block_copy_inflight_req_end(&req);
>> +    return found_dirty;
>> +}
>>  =20
>> -    return ret;
>> +int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t =
bytes,
>> +                            bool *error_is_read)
>> +{
>> +    while (true) {
>> +        int ret =3D block_copy_dirty_clusters(s, start, bytes, error_is=
_read);
>> +
>> +        if (ret < 0) {
>> +            /*
>> +             * IO operation failed, which means the whole block_copy re=
quest
>> +             * failed.
>> +             */
>> +            return ret;
>> +        }
>> +        if (ret) {
>> +            /*
>> +             * Something was copied, which means that there were yield =
points
>> +             * and some new dirty bits may appered (due to failed paral=
lel
>=20
> s/appered/have appeared/
>=20
>> +             * block-copy requests).
>> +             */
>> +            continue;
>> +        }
>> +
>> +        /*
>> +         * Here ret =3D=3D 0, which means that there is no dirty cluste=
rs in
>> +         * requested region.
>> +         */
>> +
>> +        if (!block_copy_wait_one(s, start, bytes)) {
>> +            /* No dirty bits and nothing to wait: the whole request is =
done */
>=20
> Wouldn=92t it make more sense to keep block_copy_wait_one() a loop (i.e.,
> keep it as block_copy_wait_inflight_reqs()) that returns whether it
> waited or not?  Because I suppose if we had to wait for anything, we
> might as well wait for everything in the range.

No, we don't need to wait all. If some dirty bits appeared we may start cop=
y them
immediately, not waiting for others.

>=20
>> +            break;
>> +        }
>> +    }
>=20
> Continuing my loud thought from the beginning, I would have written this
> as a tail-recursive function to stress that this isn=92t really a
> (potentially expensive) loop but more of a re-check to be sure.
>=20
> (i.e.
>=20
> int ret =3D block_copy_dirty...();
> if (ret < 0) {
>      return ret;
> }
>=20
> if (ret || block_copy_wait_one()) {
>      /* Something might have changed, re-check */
>      return block_copy();
> }
>=20
> /* Done */
> return 0;
> )
>=20
> But who cares.
>=20

Hm, I'd prefer to avoid recursion. But combining two if operators seems goo=
d anyway.


With this patch I have two aims:

1. May be you are right and we don't have too much intersecting requests.. =
Actually, the only
case is intersection of guest write with block-job block_copy call, as inte=
rsection of
two job requests is not possible and intersection of guest writes is not no=
rmal thing. But anyway,
it should work better for intersecting requests, a bit more interactive.

2. As block-status handling and aio-tasking should be done here in block-co=
py, there is no reason
to keep a loop in backup.c. So at the end of the original series only one c=
all block_copy(0, disk_size)
is left in backup.c. And this definitely needs this patch. So, it's an arch=
itectural patch, which
makes block_copy to be more universal thing.

--=20
Best regards,
Vladimir

