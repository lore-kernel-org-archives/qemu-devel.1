Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE05BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79AFB20738
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sV6LM32f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AFB20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA7jY-0000fm-Nm
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 04:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kA7im-0000C4-UR; Mon, 24 Aug 2020 04:20:52 -0400
Received: from mail-eopbgr140100.outbound.protection.outlook.com
 ([40.107.14.100]:40782 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kA7ii-00028g-TP; Mon, 24 Aug 2020 04:20:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atsJ39OyeyZC2rmvmXB/IHXhM8NWPXkgnkeAgTlXxVSS3RyPb2sHPXMu1wnt0n8JN4YbmsrIWC+J60uQ+fZLBh7e74QFmGNxGL6kuWw0I142XlJVX3gzE5aZ233pq4ypnpl8A2LG2ZflI9+mxhtL9L3Glz0bnKtrnsmUgL70hZ5qs49sn+Xysow/ID452SkfdH40gQc6LBCeM0ob1LNRh+qONwgXW9Kzkig+9ERYUnyLholNJx5UksQDfbcYgu7uxk9AjkWpUfeUK8QRVtpcI7xHsoIV0TJLTL/wehWmAv8lQy45JXUDkJ/hA80BUHwT3nkpNBGxtQgw+6ydGhdFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fMd9spi0LuXZ6exgjWauKm8zasR6Vx6i1/l6WeLrms=;
 b=ViaL1m/z67TsTBjPG7ArgIKPYBVAVEj2QloXcwVlgAyDJRZ/OxxAqAc3FoMARMKIn5oi79HSOn4ABioGFKp7aYFq1Q+e/fBL/xvPZwfa0R/MbUzUNARfA9i32TOZQe+WNRbcDfeZua+RRcBCKQV7LDTsjARSgykTzZ5SDba9anVi2epwV7aiXakAGI/RNNgCuVxeuFnMJLXas874aw9bPdEnd57rji/H2ZmQ+iB6APmjxgv2KEFPYg9ZAOlaC0IG58lJp7WpuAQf1s7dRwtdA134r+4nzNKYi4nZO60sN57rTPdbRYzMWc9rLaFJyvLBFJBdOpeGnTdL5VEUqpnvNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fMd9spi0LuXZ6exgjWauKm8zasR6Vx6i1/l6WeLrms=;
 b=sV6LM32feDI05XmfwDKF3p1VnxD17E+B+34mDrfD6S5g24uwdPSDlVzEVHyPDlIvoUVZ556+uyETzjC29cuVJYLqumKKUXnazh+LrotYnacOWtVNE0J9zhHVXXY1PiDPK5o0sBhtSDq7iRjoF1qFt+xpITpOA0yGz555xJoTvnc=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4021.eurprd08.prod.outlook.com (2603:10a6:20b:aa::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 08:20:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%9]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 08:20:40 +0000
Subject: Re: [PATCH v6 4/4] block: apply COR-filter to block-stream jobs
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1597785880-431103-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1597785880-431103-5-git-send-email-andrey.shinkevich@virtuozzo.com>
 <6bb4c66e-fb52-c947-1ef2-64a060a92db3@virtuozzo.com>
 <103d5732-7812-17d3-82d0-effa76325c50@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b1153a54-96c8-3ddc-e4ee-42c613d02924@virtuozzo.com>
Date: Mon, 24 Aug 2020 11:20:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <103d5732-7812-17d3-82d0-effa76325c50@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0098.eurprd04.prod.outlook.com
 (2603:10a6:208:be::39) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0PR04CA0098.eurprd04.prod.outlook.com (2603:10a6:208:be::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 08:20:39 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e52fb6b-7e2a-4177-375d-08d848069617
X-MS-TrafficTypeDiagnostic: AM6PR08MB4021:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB40218F9AE569EC02972DC61EC1560@AM6PR08MB4021.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vx5cwcLsiMEJV+8yJV1Awbw4VUv0Lr29Ce8w9FbdYBg0FTC2a+buRSPfKxlFuNf+4kYaV+nBoQAWwrd2XNHKWSJPoIm9lLT6g2pTXsdIzonyybh6Jg4cmUMw7OX/hdbpQZC4i989xOLnONY8PmXC7WKZx5KUiBilUYSFsM5qdzV3CQGB/XqHB3dzfuUs49NyXWoJXQcZYWc2qsSv3w66JfZp1Suw/LAFO+9nWAWdtQshK8+kH/oirjtPbHV8GO8ZRO6znup7xmY95ULldHeaFruhbAoXzWKnbUNQQu4vMPdeiIWeiGNfZFQ9FU105MEQ5UQ+1xzEXxy7vAtIOUJk3ZJNhb+S57biogSpTkOlXX57LSIMU/oGcunckae+WGEG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39830400003)(366004)(136003)(6486002)(26005)(478600001)(16576012)(186003)(8676002)(316002)(83380400001)(16526019)(5660300002)(956004)(8936002)(52116002)(36756003)(31686004)(66556008)(31696002)(2616005)(86362001)(4326008)(53546011)(66946007)(2906002)(66476007)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Gurq/APnBU8TlmsRVVbQwhadRD9vuL66+2G5OdyG9LBNsnP/VB/Eunpi5u9h3WDOCBD9BCpWhza9P4LfakI+ltsVbuZD9jqej8a8fnVk9yxFyJubPQvjCQEQUxRwbM/fF9fNEi+cCMlnD8V0oagC+B97a7Vdz1kzTSAMZOwwNMxYWDLhqtyuZ6sePDVpp8CnCanVIrl0+0vOiEKFnu7Wcvbpn1MMf1UkbxLJEAp2oEFLdEKobatPgkK4EE/pHLQqDcA5rp3qfwZiZxt57XflhGP0SzVQMkFsWfZHShbhPNa6MTGAEP1U1BGt74sWoZygy+dJ591HO2xZeaNBnY2tF7Il6AtWUZxn9X4yuWaDUzIOzNaTGMQ0m/WMTECKLFPS20uLruL8AU/drCg2AUVk1B0UDw1C5v6e2zUwN85PormvBqRBq6tfJ+NR+kGO1gHUeca3t6ERCD++QvqIa/WunO5HelJUKsbOSRPOvUHa3ahdnGJdfBhcy/Gvr3+sJafJuqNvajPqFbE1gzRVEBq3dHU2AvGguFjzNjmWLQnPuawAm7kf6ui829kk60Jl7wQC9NTiUz6c/WXWTVvKFxPEDvCZmthFx/ej/xZRoCslgT3LiMF2ojztC4D9W6MEt/1iMJIUfDuRfTNOO90/z6rpzA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e52fb6b-7e2a-4177-375d-08d848069617
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 08:20:39.9565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiH/NRUsNw7eD1rnRMR258fmA/rSG4ertisB9/6dzoRjz/xnQw/38DHp+4dFKGCXnrr70Gdoe0z564SIqjceF1i7WNd77noVeDAUp45Yf6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4021
Received-SPF: pass client-ip=40.107.14.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 04:20:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.381, RCVD_IN_DNSWL_LOW=-0.7,
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.08.2020 22:28, Andrey Shinkevich wrote:
> On 19.08.2020 13:46, Vladimir Sementsov-Ogievskiy wrote:
>> 19.08.2020 00:24, Andrey Shinkevich wrote:
>>> The patch completes the series with the COR-filter insertion to any
>>> block-stream operation. It also makes changes to the iotests 030.
>>> The test case 'test_stream_parallel' was deleted due to multiple
>>> errors.
>>
> ...
>>
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   block/stream.c             | 76 ++++++++++++++++++++++++++++++++--------------
>>>   tests/qemu-iotests/030     | 50 +++---------------------------
>>>   tests/qemu-iotests/030.out |  4 +--
>>>   3 files changed, 61 insertions(+), 69 deletions(-)
>>>
>>> diff --git a/block/stream.c b/block/stream.c
>>> index 8bf6b6d..0b11979 100644
>>> --- a/block/stream.c
>>> +++ b/block/stream.c
>>> @@ -19,6 +19,7 @@
>>>   #include "qapi/qmp/qerror.h"
>>>   #include "qemu/ratelimit.h"
>>>   #include "sysemu/block-backend.h"
>>> +#include "block/copy-on-read.h"
>>>     enum {
>>>       /*
>>> @@ -33,8 +34,11 @@ typedef struct StreamBlockJob {
>>>       BlockJob common;
>>>       BlockDriverState *base_overlay; /* COW overlay (stream from this) */
>>>       BlockDriverState *above_base;   /* Node directly above the base */
>>> +    BlockDriverState *cor_filter_bs;
>>> +    BlockDriverState *target_bs;
>>>       BlockdevOnError on_error;
>>>       char *backing_file_str;
>>> +    char *base_fmt;
>>>       bool bs_read_only;
>>>       bool chain_frozen;
>>>   } StreamBlockJob;
>>> @@ -53,34 +57,26 @@ static void stream_abort(Job *job)
>>>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>>>         if (s->chain_frozen) {
>>> -        BlockJob *bjob = &s->common;
>>> -        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->above_base);
>>> +        bdrv_unfreeze_backing_chain(s->cor_filter_bs, s->above_base);
>>>       }
>>>   }
>>>     static int stream_prepare(Job *job)
>>>   {
>>>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>>> -    BlockJob *bjob = &s->common;
>>> -    BlockDriverState *bs = blk_bs(bjob->blk);
>>> +    BlockDriverState *bs = s->target_bs;
>>>       BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>>>       BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
>>>       Error *local_err = NULL;
>>>       int ret = 0;
>>>   -    bdrv_unfreeze_backing_chain(bs, s->above_base);
>>> +    bdrv_unfreeze_backing_chain(s->cor_filter_bs, s->above_base);
>>>       s->chain_frozen = false;
>>>         if (bdrv_cow_child(unfiltered_bs)) {
>>> -        const char *base_id = NULL, *base_fmt = NULL;
>>> -        if (base) {
>>> -            base_id = s->backing_file_str;
>>> -            if (base->drv) {
>>> -                base_fmt = base->drv->format_name;
>>> -            }
>>> -        }
>>>           bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
>>> -        ret = bdrv_change_backing_file(unfiltered_bs, base_id, base_fmt);
>>> +        ret = bdrv_change_backing_file(unfiltered_bs, s->backing_file_str,
>>> +                                       s->base_fmt);
>>>           if (local_err) {
>>>               error_report_err(local_err);
>>>               return -EPERM;
>>> @@ -94,7 +90,9 @@ static void stream_clean(Job *job)
>>>   {
>>>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>>>       BlockJob *bjob = &s->common;
>>> -    BlockDriverState *bs = blk_bs(bjob->blk);
>>> +    BlockDriverState *bs = s->target_bs;
>>> +
>>> +    bdrv_cor_filter_drop(s->cor_filter_bs);
>>>         /* Reopen the image back in read-only mode if necessary */
>>>       if (s->bs_read_only) {
>>> @@ -104,13 +102,14 @@ static void stream_clean(Job *job)
>>>       }
>>>         g_free(s->backing_file_str);
>>> +    g_free(s->base_fmt);
>>>   }
>>>     static int coroutine_fn stream_run(Job *job, Error **errp)
>>>   {
>>>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>>>       BlockBackend *blk = s->common.blk;
>>> -    BlockDriverState *bs = blk_bs(blk);
>>> +    BlockDriverState *bs = s->target_bs;
>>>       BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>>>       bool enable_cor = !bdrv_cow_child(s->base_overlay);
>>>       int64_t len;
>>> @@ -231,6 +230,12 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>>>       int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
>>>       BlockDriverState *base_overlay = bdrv_find_overlay(bs, base);
>>>       BlockDriverState *above_base;
>>> +    BlockDriverState *cor_filter_bs = NULL;
>>> +    char *base_fmt = NULL;
>>> +
>>> +    if (base && base->drv) {
>>> +        base_fmt = g_strdup(base->drv->format_name);
>>> +    }
>>>         if (!base_overlay) {
>>>           error_setg(errp, "'%s' is not in the backing chain of '%s'",
>>> @@ -264,17 +269,36 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>>>           }
>>>       }
>>>   -    /* Prevent concurrent jobs trying to modify the graph structure here, we
>>> -     * already have our own plans. Also don't allow resize as the image size is
>>> -     * queried only at the job start and then cached. */
>>> -    s = block_job_create(job_id, &stream_job_driver, NULL, bs,
>>> -                         basic_flags | BLK_PERM_GRAPH_MOD,
>>> -                         basic_flags | BLK_PERM_WRITE,
>>> +    cor_filter_bs = bdrv_cor_filter_append(bs, filter_node_name, errp);
>>> +    if (cor_filter_bs == NULL) {
>>> +        goto fail;
>>> +    }
>>> +
>>> +    if (bdrv_freeze_backing_chain(cor_filter_bs, bs, errp) < 0) {
>>> +        bdrv_cor_filter_drop(cor_filter_bs);
>>> +        cor_filter_bs = NULL;
>>> +        goto fail;
>>> +    }
>>> +
>>> +    s = block_job_create(job_id, &stream_job_driver, NULL, cor_filter_bs,
>>> +                         BLK_PERM_CONSISTENT_READ,
>>> +                         basic_flags | BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD,
>>>                            speed, creation_flags, NULL, NULL, errp);
>>>       if (!s) {
>>>           goto fail;
>>>       }
>>>   +    /*
>>> +     * Prevent concurrent jobs trying to modify the graph structure here, we
>>> +     * already have our own plans. Also don't allow resize as the image size is
>>> +     * queried only at the job start and then cached.
>>> +     */
>>> +    if (block_job_add_bdrv(&s->common, "active node", bs,
>>> +                           basic_flags | BLK_PERM_GRAPH_MOD,
>>> +                           basic_flags | BLK_PERM_WRITE, &error_abort)) {
>>> +        goto fail;
>>> +    }
>>> +
>>>       /* Block all intermediate nodes between bs and base, because they will
>>>        * disappear from the chain after this operation. The streaming job reads
>>>        * every block only once, assuming that it doesn't change, so forbid writes
>>> @@ -294,6 +318,9 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>>>         s->base_overlay = base_overlay;
>>>       s->above_base = above_base;
>>> +    s->cor_filter_bs = cor_filter_bs;
>>> +    s->target_bs = bs;
>>> +    s->base_fmt = base_fmt;
>>
>> it's wrong to keep base_fmt during the job, as base may change
> 
> 
> So, the format can differ from that of the backing_file_str given as the input parameter of the stream_start()...
> 
> ...while the backing_file_str path is written to the QCOW2 header on a disk.
> 

Or better, let's try to revert c624b015bf14f and freeze base again.

> 
> 
>>
>>>       s->backing_file_str = g_strdup(backing_file_str);
>>>       s->bs_read_only = bs_read_only;
>>>       s->chain_frozen = true;
>>> @@ -307,5 +334,10 @@ fail:
>>>       if (bs_read_only) {
>>>           bdrv_reopen_set_read_only(bs, true, NULL);
>>>       }
>>> -    bdrv_unfreeze_backing_chain(bs, above_base);
>>> +    if (cor_filter_bs) {
>>> +        bdrv_unfreeze_backing_chain(cor_filter_bs, above_base);
>>> +        bdrv_cor_filter_drop(cor_filter_bs);
>>> +    } else {
>>> +        bdrv_unfreeze_backing_chain(bs, above_base);
>>> +    }
>>>   }
>>> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
>>> index 1cdd7e2..fec9d89 100755
>>> --- a/tests/qemu-iotests/030
>>> +++ b/tests/qemu-iotests/030
>>> @@ -221,60 +221,20 @@ class TestParallelOps(iotests.QMPTestCase):
>>>           for img in self.imgs:
>>>               os.remove(img)
> ...


-- 
Best regards,
Vladimir

