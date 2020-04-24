Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E94FC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484A320736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Or5YPo3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484A320736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRzJr-0006Fe-9E
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 10:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRzIq-0004O2-7M
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRzIo-0000R2-94
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:27:39 -0400
Received: from mail-eopbgr00104.outbound.protection.outlook.com
 ([40.107.0.104]:11950 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jRzIn-0000HY-El; Fri, 24 Apr 2020 10:27:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBUHeu5ovbi7ZaoT8d0kf6+AERGrQKImOT5a4k1C1ImhK5Mf93FyBE0saOU6tGE0wZBnFbdS/+GbZ4VbBqrIjP9EXXgTnburFQgJzwv2jFgRoCDNqIOBUXF+K13JQo03Rkfa63NKJTwzi6qD+gSaVJTR5G/wrH/8WhLrpzM7aZUJU7XHt6fsO37SriOVei6uXPvl2jRH48bSZnaBS7suuX7OynOwef14NoKC8n6Ce6X7X7W8I1Af0XjnHKuJeKlyfuNnkuxSjIgN3myVWmD5aV9jFaIcdnB5axVn1SbtPrFPohp1ZPjxz1uUW7sBQpop6XPpqmozDx4Bbe0H7pSkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxIXJDhxw/TPLCwOt2BaCjnrjFpbR18jy+uzS78zOQk=;
 b=K2gDg++6t4doVU+Ihv/Jj4LSstoY6+Ri3Y9ODGYLq+K2grMJELiHQ1Cd5/vCBjvNM8YjBPo1U4h0WhYhZsKdjBp+ZlC05+86rK08BjJJUr+scUWMEqkLxr2lQZuWgnE3cgq3bprKZcYpQa3u7y4z6dqNNj7OnY3FIxINbFRff2rstixDH8wNlfi40C9XyVOQLyiwsm5gQEXqcX9vveKiv2qTiahuTf/ortb6uqnc/FduuGlqKx+YsdxdO03nfSqbeW0CEI3TTDc1abLiSEC6jCooMc7kpaYaDZt/Cua2L+gDcRZiZEtoQrAAR4l6DTJ9I2dR+K0qmbYaA0j8e/PMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxIXJDhxw/TPLCwOt2BaCjnrjFpbR18jy+uzS78zOQk=;
 b=Or5YPo3y/ggAR9imGDdzlLbXnh9McGZs4WsCP3vtZ1yK3M95zmetN9U3fQiDy4h72uH9dYkvqrGCHqqCK/HlZT4BJ/V2LCo2FQ2CkwKbf+uS8Uu7cvpQJ9i6DBDuXqCnQCQuhfq+1qCZZgdu8RoM23EfMEj2R9cNwTlb2el4fyk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5464.eurprd08.prod.outlook.com (2603:10a6:20b:10a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 14:27:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 14:27:33 +0000
Subject: Re: [PATCH v6 04/10] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
To: Kevin Wolf <kwolf@redhat.com>
References: <20200423150127.142609-1-kwolf@redhat.com>
 <20200423150127.142609-5-kwolf@redhat.com>
 <436f15ce-da79-7016-6478-c5ab8642ee25@virtuozzo.com>
 <20200424121712.GA4921@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200424172731528
Message-ID: <015257be-922b-d8fd-2ae5-85e59d2377c6@virtuozzo.com>
Date: Fri, 24 Apr 2020 17:27:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200424121712.GA4921@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.181) by
 FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 14:27:32 +0000
X-Tagtoolbar-Keys: D20200424172731528
X-Originating-IP: [185.215.60.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4da5a8d3-f9e4-44eb-beeb-08d7e85ba0b7
X-MS-TrafficTypeDiagnostic: AM7PR08MB5464:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5464FF8D879651DC3611F737C1D00@AM7PR08MB5464.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39850400004)(376002)(346002)(136003)(31696002)(36756003)(26005)(16576012)(6916009)(16526019)(52116002)(86362001)(316002)(186003)(2616005)(5660300002)(31686004)(956004)(2906002)(66476007)(66556008)(66946007)(8936002)(4326008)(478600001)(6486002)(81156014)(8676002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3tVAo6qWeoWOHKvSS0PasyeNSI9Mv/jQmEauiIHhcQbzlXTluu0gk8H5E/N02vmBnPQufJs3YyOXZ219TsWsy2OkwW3raW7D01pPBRrvXBt+5G+7zFVPQ+BHQsWrXq4c0eNIn4GhUyJlZ36kto7ExmWUL8+5c2gmFWvY/KMWH1qYyZOInU/5WsczO1DpGfF/2ntbDaQiNKmh2sQvlluwZ0MlzuZQ5YMbgdNsG2iBzEf37GCjHsEuMzswhTLhqglAltdsWvoa3Ek8uDM0XzJ9FNZX5AnHkQQIavic8eRGSQz37WIAqQLi3Qx9o5rlJV44fP7J0RMzNEXcy7Z4ejHsF5OILmlyYZK0BsKZowkVN4NO9pgcAuYUHVtbVAuvgik0XAk0/+OEHo7CIM9SAZlVhEjUldpubv0fTeKslMTNKOvFisQkwIWslnew/lKtkc5
X-MS-Exchange-AntiSpam-MessageData: +bm+l1atC0LmqE2wZIos014p6pt1s8Buzr6SFaYmX09oA032fYyS1FGZzv15Op05lRMOsTeswHK6n8gsNbnfisBsdMpjxL5mvvdHKtqQpJOTgWfDE8PandStpJDIn0vI3tWOJ64vQg1Wt2N9Qv/xBQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da5a8d3-f9e4-44eb-beeb-08d7e85ba0b7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 14:27:33.4628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eV34qU5SgpUoi11Fm35B1D0jVZK0Xyo+mKX+vX9EgChVqMfiTstncY4xp30kJ2FnLGFuZ68TmCotFMsBEq5GXBADtl1xhu3mtkIAMUyVJo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5464
Received-SPF: pass client-ip=40.107.0.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 10:27:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.0.104
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
Cc: berto@igalia.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.04.2020 15:17, Kevin Wolf wrote:
> Am 24.04.2020 um 08:16 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 23.04.2020 18:01, Kevin Wolf wrote:
>>> If BDRV_REQ_ZERO_WRITE is set and we're extending the image, calling
>>> qcow2_cluster_zeroize() with flags=0 does the right thing: It doesn't
>>> undo any previous preallocation, but just adds the zero flag to all
>>> relevant L2 entries. If an external data file is in use, a write_zeroes
>>> request to the data file is made instead.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>    block/qcow2-cluster.c |  2 +-
>>>    block/qcow2.c         | 33 +++++++++++++++++++++++++++++++++
>>>    2 files changed, 34 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>>> index 17f1363279..4b5fc8c4a7 100644
>>> --- a/block/qcow2-cluster.c
>>> +++ b/block/qcow2-cluster.c
>>> @@ -1795,7 +1795,7 @@ int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
>>>        /* Caller must pass aligned values, except at image end */
>>>        assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>>>        assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
>>> -           end_offset == bs->total_sectors << BDRV_SECTOR_BITS);
>>> +           end_offset >= bs->total_sectors << BDRV_SECTOR_BITS);
>>>        /* The zero flag is only supported by version 3 and newer */
>>>        if (s->qcow_version < 3) {
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index 9cfbdfc939..ad621fe404 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -1726,6 +1726,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>>>        bs->supported_zero_flags = header.version >= 3 ?
>>>                                   BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK : 0;
>>> +    bs->supported_truncate_flags = BDRV_REQ_ZERO_WRITE;
>>>        /* Repair image if dirty */
>>>        if (!(flags & (BDRV_O_CHECK | BDRV_O_INACTIVE)) && !bs->read_only &&
>>> @@ -4214,6 +4215,38 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>>>            g_assert_not_reached();
>>>        }
>>> +    if ((flags & BDRV_REQ_ZERO_WRITE) && offset > old_length) {
>>> +        uint64_t zero_start = QEMU_ALIGN_UP(old_length, s->cluster_size);
>>> +
>>> +        /*
>>> +         * Use zero clusters as much as we can. qcow2_cluster_zeroize()
>>> +         * requires a cluster-aligned start. The end may be unaligned if it is
>>> +         * at the end of the image (which it is here).
>>> +         */
>>> +        ret = qcow2_cluster_zeroize(bs, zero_start, offset - zero_start, 0);
>>> +        if (ret < 0) {
>>> +            error_setg_errno(errp, -ret, "Failed to zero out new clusters");
>>> +            goto fail;
>>> +        }
>>> +
>>> +        /* Write explicit zeros for the unaligned head */
>>> +        if (zero_start > old_length) {
>>> +            uint8_t *buf = qemu_blockalign0(bs, s->cluster_size);
>>
>> Why not s/s->cluster_size/zero_start - old_length/? We may save a lot
>> of pages if cluster_size is large.
> 
> Ok.
> 
>>> +            QEMUIOVector qiov;
>>> +            qemu_iovec_init_buf(&qiov, buf, zero_start - old_length);
>>> +
>>> +            qemu_co_mutex_unlock(&s->lock);
>>
>> We are in intermediate state here. Is it safe to unlock? Anything may
>> happen, up to another truncate..
> 
> I don't think it's worse than unlocking during normal writes, which we
> have been doing for a long time. I don't see anything that would corrupt
> any internal state.
> 
> Of course, doing truncate in parallel with other operations around EOF
> has somewhat undefined semantics because the order could be anything.
> But if you don't want to get undefined results, you just shouldn't make
> such requests. It's similar to reading and writing the same area at the
> same time.

If there would be two truncate operations in parallel, we may finish up with s->l1_vm_state_index bs->total_sectors not corresponding to other metadata. Not sure how much is it bad..

> 
>>> +            ret = qcow2_co_pwritev_part(bs, old_length, qiov.size, &qiov, 0, 0);
>>
>> Better not do it if this cluster is already ZERO.. But it may be a
>> later patch to improve that.
> 
> I doubt it's worth writing code to optimise a corner case inside a
> corner case.
> 
>>> +            qemu_co_mutex_lock(&s->lock);
>>> +
>>> +            qemu_vfree(buf);
>>> +            if (ret < 0) {
>>> +                error_setg_errno(errp, -ret, "Failed to zero out the new area");
>>> +                goto fail;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>>        if (prealloc != PREALLOC_MODE_OFF) {
>>>            /* Flush metadata before actually changing the image size */
>>>            ret = qcow2_write_caches(bs);
> 
> Kevin
> 


-- 
Best regards,
Vladimir

