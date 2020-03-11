Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278B3C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63C92146E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="k3TNdu52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63C92146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBxrV-0005p9-5R
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 05:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBxqH-0004cG-Pa
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBxqF-0003wk-JH
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:39:56 -0400
Received: from mail-am6eur05on2097.outbound.protection.outlook.com
 ([40.107.22.97]:13202 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jBxqB-0003tu-HH; Wed, 11 Mar 2020 05:39:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqijJqKVQJXehhmAjs+bzXHTjcWdEquRFExGWRD9a/EOTqA3jr/VeIzZJePEIMs9GFPtoQLHV2TKSNWeQLG3XjTClrXElCDejmDLTIPqo2sxJoo5/DGYa6WxiXHP1jAbgcFcHEL9tICvT01tkqlULnB597q3vJQZ7wLzTGSjobmXYVOSV1bfD6ds6Qprb8w6jDQE+1wl8yeU/iQSHMs9A6ezkCLfn6aHgsNteu/w9ByautxTFtxU0/Xe+TdD+YDomPNLtlw/ZWTjTxUr8Pzt+1/dd1CDieCcHnhUk5h7ahC+LszHOAgVX+7b7P711ea6tyqDjqt4sH/q8NDyuTtIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zqd+IG5EOw1rWvx7ntlVvHV59lsf+pquLtT9Uq2GBQ=;
 b=ocnmj7CNJmWZg/49RB8nlL0SJxgmn+He+vKzOiDFSeiTe6m520VquA2FUihP1IivkaVy91nEJYO1YfOuF+igSsnSdvOLJtZ5i6c97G05c2fMadQ1uZql++pa3+IHgGTadQB+dMC5W1QGO50mtOJV/bbGFvNzsHaSRfwEhPOSQsmbLV378fHM4WvthmDk74KvrGuxiLvhleYHjiGARxOD4vQ6VAi4w+r95rNtIcLShbmJO4fjFFi/o0G8BkgtXPqOUpPH6KYVnaV6Txx8Hh6QJNKyDuYcBqCi2VLPGBzttVwuRvH9Q5zILjk6+/5B51UrrHlA8RMxcY9swD61UboebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zqd+IG5EOw1rWvx7ntlVvHV59lsf+pquLtT9Uq2GBQ=;
 b=k3TNdu520G91RhQLu1ZE5SFzyz91EKY0ZGULtk16YO06mPojaxymPzRBYpx+G8/o6IxMpc2nQPdBtaYCHvLW5rgA8bDrY7BFRmMsNdlhdjWwEbOm4xH+k11jddTUI0HJVU5qb5esZ4Az27w5lxTHTXpefmTz+cdFN+tb5BHZJ9s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4771.eurprd08.prod.outlook.com (10.255.97.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 09:39:49 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 09:39:49 +0000
Subject: Re: [PATCH v3 8/9] block/block-copy: reduce intersecting request lock
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200306073831.7737-1-vsementsov@virtuozzo.com>
 <20200306073831.7737-9-vsementsov@virtuozzo.com>
 <d261061c-607b-d7a3-e43b-f436d46e4f0a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200311123946837
Message-ID: <0cd24c55-ac0c-38ee-a9df-daadddd6fb37@virtuozzo.com>
Date: Wed, 11 Mar 2020 12:39:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <d261061c-607b-d7a3-e43b-f436d46e4f0a@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0101CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::13) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0101CA0003.eurprd01.prod.exchangelabs.com (2603:10a6:3:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13 via Frontend
 Transport; Wed, 11 Mar 2020 09:39:48 +0000
X-Tagtoolbar-Keys: D20200311123946837
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8cd6cf6-8946-4ebe-5280-08d7c5a02453
X-MS-TrafficTypeDiagnostic: AM6PR08MB4771:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB47716D92F4305A630038D986C1FC0@AM6PR08MB4771.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(136003)(376002)(396003)(346002)(199004)(186003)(86362001)(956004)(16526019)(26005)(31686004)(2906002)(8676002)(4326008)(2616005)(16576012)(8936002)(81156014)(66556008)(81166006)(66476007)(66946007)(31696002)(316002)(5660300002)(107886003)(36756003)(478600001)(53546011)(52116002)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4771;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UG4JO3ot4NjBmOFQ98Gh1YXZLpYOIKSW/kM1DYBXHYSVMQL5TWFS2VwoHW9ueoLHPbv8uOOmas/WBzl3sM1BNMsvnzgAeFSgWrKT0ITkYNEDegYHwsApV+jQgwqA01puO5oWhTPXVFP6zfgzdoi0fh4tmq2GFiMoOp2et+iFt7RVK4CbcvRk07690B/nezKWY7Kk4ktO21pQSdTyeKbgOwXKC+GwzBJ090AOEPvfDpYhLQ3L2K9X+PoIDcl9gNZNyVktqmqcG2uJVScao59yCzWH0cXo0JPsKHXgztWzaoZTmmIP1KOrFzPvL177GFP/FDpk15c70hLphkFtuvPyaayvzxwleL2E/HKlJd+c43CVgJXj4/f4DpWK2ybx7uCtXDLDLpNQkI1pbY6p5UHUkVOZe4HgBemr2VlMK6FkdmCMO431Ao45bqODTFso5jqF
X-MS-Exchange-AntiSpam-MessageData: XGAV2THyVu/foNJhjrd8g+U0PfOvdrTWXnuBvJQ9YDz/doQC14n5BjhJrvE8Rc7AcayS4JjAxd06hBxS7oj9N/uJsjIUNkiTVSLGiNTqc4rk4VPzBOBdCZx7M1B5atBSL1I52fjTn6s7QYOgsEuMyQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cd6cf6-8946-4ebe-5280-08d7c5a02453
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 09:39:49.2553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyvSpGBjcR0C15Jj2QaYEyNh1uCuJyXmcBkH7v4InolDyT0XtnMk7OU/0O0HCVx7cd26kPQ/mpAwzdC2AiipYtMsLV5b6aPa6HoxI0YZeqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4771
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.97
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
Cc: kwolf@redhat.com, andrey.shinkevich@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.03.2020 18:32, Max Reitz wrote:
> On 06.03.20 08:38, Vladimir Sementsov-Ogievskiy wrote:
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
>> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/block-copy.c | 128 ++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 104 insertions(+), 24 deletions(-)
>>
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 2b29131653..d66b8eb691 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
>=20
> [...]
>=20
>> +/* Called only on full-dirty region */
>>   static void block_copy_inflight_req_begin(BlockCopyState *s,
>>                                             BlockCopyInFlightReq *req,
>>                                             int64_t offset, int64_t byte=
s)
>>   {
>> +    assert(!find_conflicting_inflight_req(s, offset, bytes));
>> +
>> +    bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
>> +    s->in_flight_bytes +=3D bytes;
>> +
>>       req->offset =3D offset;
>>       req->bytes =3D bytes;
>>       qemu_co_queue_init(&req->wait_queue);
>>       QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
>>   }
>>  =20
>> -static void coroutine_fn block_copy_inflight_req_end(BlockCopyInFlightR=
eq *req)
>> +/*
>> + * block_copy_inflight_req_shrink
>> + *
>> + * Drop the tail of the request to be handled later. Set dirty bits bac=
k and
>> + * wake up all requests waiting for us (may be some of them are not int=
ersecting
>> + * with shrunk request)
>> + */
>> +static void coroutine_fn block_copy_inflight_req_shrink(BlockCopyState =
*s,
>> +        BlockCopyInFlightReq *req, int64_t new_bytes)
>>   {
>> +    if (new_bytes =3D=3D req->bytes) {
>> +        return;
>> +    }
>> +
>> +    assert(new_bytes > 0 && new_bytes < req->bytes);
>> +
>> +    bdrv_set_dirty_bitmap(s->copy_bitmap,
>> +                          req->offset + new_bytes, req->bytes - new_byt=
es);
>=20
> I think we need to reduce in_flight_bytes here.

Yes, you are right, thanks!

>=20
>> +
>> +    req->bytes =3D new_bytes;
>> +    qemu_co_queue_restart_all(&req->wait_queue);
>> +}
>> +
>> +static void coroutine_fn block_copy_inflight_req_end(BlockCopyState *s,
>> +                                                     BlockCopyInFlightR=
eq *req,
>> +                                                     int ret)
>> +{
>> +    s->in_flight_bytes -=3D req->bytes;
>> +    if (ret < 0) {
>> +        bdrv_set_dirty_bitmap(s->copy_bitmap, req->offset, req->bytes);
>> +    }
>>       QLIST_REMOVE(req, list);
>>       qemu_co_queue_restart_all(&req->wait_queue);
>>   }
>=20
> [...]
>=20
>> @@ -432,7 +479,40 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>           bytes -=3D cur_bytes;
>>       }
>>  =20
>> -    block_copy_inflight_req_end(&req);
>> +    return found_dirty;
>> +}
>> +
>> +/*
>> + * block_copy
>> + *
>> + * Copy requested region, accordingly to dirty bitmap.
>> + * Collaborate with parallel block_copy requests: if they success it he=
lp us. If
>=20
> s/success/succeed/, s/it help/it will help/
>=20
>> + * they fail, we retry not-copied regions. So, if we return error, it m=
eans that
>=20
> s/retry/will retry/
>=20
> (In theory also s/it means/it will mean/, but I suppose that also works
> as-is.)
>=20
>> + * io operation failed in context of _this_ block_copy call, not some p=
arallel
>=20
> Perhaps rather =93some I/O operation failed in the context of [=85]=94?
>=20
>> + * operation.
>> + */
>> +int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t =
bytes,
>> +                            bool *error_is_read)
>> +{
>> +    int ret;
>> +
>> +    do {
>> +        ret =3D block_copy_dirty_clusters(s, offset, bytes, error_is_re=
ad);
>> +
>> +        if (ret =3D=3D 0) {
>> +            ret =3D block_copy_wait_one(s, offset, bytes);
>> +        }
>> +
>> +        /*
>> +         * We retry in two cases:
>> +         * 1. Some progress done
>> +         *    Something was copied, which means that there were yield p=
oints
>> +         *    and some new dirty bits may have appeared (due to failed =
parallel
>> +         *    block-copy requests).
>> +         * 2. We have waited for some intersecting block-copy request
>> +         *    It may have failed and produced new dirty bits.
>> +         */
>> +    } while (ret > 0);
>>  =20
>>       return ret;
>>   }
>=20
> This new code looks good.
>=20
> Max
>=20


--=20
Best regards,
Vladimir

