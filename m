Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D87C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331242076A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hLsNFZZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331242076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtx2u-0000od-GX
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 13:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtx2D-00007L-K4; Fri, 10 Jul 2020 13:42:06 -0400
Received: from mail-eopbgr60127.outbound.protection.outlook.com
 ([40.107.6.127]:20439 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtx29-00006Q-Lu; Fri, 10 Jul 2020 13:42:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/HtwDqjqegcuP7UZZME6GfZRfl/xNHT/5sIBDymp6/ZjedUmzuWbSn9DArllDHlQb4GhocIasDFdjAlcHxruYZrRT8TfQ87zZ+TZbBEEdk8pi+HHt/Ijk+PE39Ur1N5J3B3sAeqopMPraN2mOa6fG2evI3xrq+uTz11xKOc7Cb/UdVePEfbi4MIYXFo/mGk37ZGgwVOTeuoTDjQ0tpxfLA94uBE9JeATbml4L4v1vKl5vpt/F3dTU3BlSS3vUsKytmSE3WoxUiuNb3boujMSzGSy7tny6qJZZyPsLPtuXWY8egcPt99tXGNCR99cObC1MGexduMJZzXFpQ7/cxKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1Vyv2IYXcNelW2Xwhr20Y2ppriAI+swGgAS3Fy4HCw=;
 b=n+UMCm1H4RBUQxYiPnACLyRYkHxMBph+Akv2Nr1OhAQYz9ARpp53c0ce8FC6xqUVKTIc0VTRaZrYhjdFjdx0raiRlOzAhJQJpSz5q9Yka8D8XY3tjormnu4MpIT0K3Fwy8LaNw+MOqruA5t7oW09aOaxN92noo4SF9XOF5kjZA60Q3/Dwi+THBwvpP5xgl7lOlOYDKH0XBQXDnXupWIIcC3B1USMmFTP1DSayaqPNQcHR6bceidVB62yf6XnBbCzOkGKZ/Nf+FDZg6T/rEdBw7aCW5UehGdhbXX3xVo47zjPSRwQX8NeKM6XS2e4/CB/tG8TjVaPv3AetO10fOt4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1Vyv2IYXcNelW2Xwhr20Y2ppriAI+swGgAS3Fy4HCw=;
 b=hLsNFZZKI69cc3e0DVUpBeSBqZy7o944o8PZwC7VYLFy6S9AE3HJQA/LPnCuhl3tseXL5E4l0/tfDsbnld1OPVUGg2eg8hdcxzrsSkadh3BWqgQcGaAoDNo24UB+gzt1BnvXUu+DbN7WxU0hkDhbfva8RnKRYbHaBGJFOgNNeLo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4405.eurprd08.prod.outlook.com (2603:10a6:20b:b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 10 Jul
 2020 17:41:58 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 17:41:58 +0000
Subject: Re: [PATCH v7 14/47] stream: Deal with filters
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-15-mreitz@redhat.com>
 <ed502f80-f4a2-bfb8-7395-5842f8103991@virtuozzo.com>
 <63ad2152-3861-1f9f-1bb9-1c14fd68cfbd@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <002af188-5576-1685-9c23-735d9a2cf50c@virtuozzo.com>
Date: Fri, 10 Jul 2020 20:41:54 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <63ad2152-3861-1f9f-1bb9-1c14fd68cfbd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::37) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR07CA0024.eurprd07.prod.outlook.com (2603:10a6:208:ac::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.11 via Frontend Transport; Fri, 10 Jul 2020 17:41:56 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 391fe0ec-eea1-4bbf-3cc3-08d824f88b6b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4405:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4405AC767457B70BD0D1B4B1F4650@AM6PR08MB4405.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 046060344D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awiZmzh7XGTjtnmoWg56KbU04RA/+a1BjvZBs+vh4OG2quPHZ3H/O99hPCVFe/o52mKxCQrdMG4H2IJy5tRxJN0agYqE0Ht+QaC+fPlXCZEP0Z5f8GciD/sW1hZOHRh/PZiz/rbDwTGP5eMK6+lGwKt/dnk5s6kOX8sB60Vn6tvXuRuWqP+ZzRqF63/E8p8C/Nj+S8RQEpbZfgw7/x0QC7B7VwMTcBdERnokB2TpkIo1teJcRjrjgRQO/mAZCXkmYksXGRWiSkt1y20Rdl3yhKXNI/3BvPkctfjD8DKmN3qXqoNCw9vZ3SpJUg19M1KVhT6aonRoq6cGgJqMlcHYzTWFF5dn7Zi2FRUtyDE/MVULFRycmYc/v9PTNG32cQNE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39840400004)(346002)(366004)(376002)(83380400001)(4326008)(66476007)(66556008)(66946007)(86362001)(31696002)(8936002)(8676002)(6512007)(2906002)(5660300002)(30864003)(16526019)(6486002)(44832011)(2616005)(31686004)(186003)(478600001)(54906003)(53546011)(6506007)(36756003)(316002)(956004)(26005)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: oCv94qqWIJWqKfjnZFYcTmVOxqqL1u/AGMKIlvDM3MZ8/4rIaHgEzm4cymwZ1da1dfp8IQpuQy7npm66hPx1niq1Q0Yl9PiAQZtmWrMVkNeaCbVN07GnrHmiw9DTPHu/S2c7xQZRAllxcd1mLSBAC0h1V1EYAQYtRFH81yiJWu/teK1jft3iUaUUYrjFS/uo3VpVtI1Qp+Iye/QyxQdS5vHcuVNa8WY5ZhbSXMMtdhf1eti+EcKynX9fbeR0sBuGb3B7rmGtlubxg2rRDW6sq6LiOv70FZLejs9CdSmEJ9/DyuD/F07UWC4HEEN1bq9nIqZIAXXxuGF+GEamck25pyR/JHyKmXR/2pdMlNOO1IFQ/KZfNkdSl/i7lbi19U8+8KtDub6CvvlI6TMW5bC/2zd1zLEfikbfU8WhQkXmFaGSqNcSXXOEm1WdINP3bPZLJFqBIOR0hXIQOlYTfYvcV2lQBKw42HNVEf3A4BL6xNK1Q9fIY94FSUjdHgLM5iBo
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391fe0ec-eea1-4bbf-3cc3-08d824f88b6b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 17:41:58.3864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HMHUvh06Yv75KhV1yYB++QbXjd5d1yBV/30gZhDHxIS2BDDQSl7xNbwS6sIiO/rsOrP/TRxMlXVfTBnXCErhOdAQYjV7OGg6tj7icTV2kE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4405
Received-SPF: pass client-ip=40.107.6.127;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 13:41:59
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10.07.2020 18:24, Max Reitz wrote:
> On 09.07.20 16:52, Andrey Shinkevich wrote:
>> On 25.06.2020 18:21, Max Reitz wrote:
>>> Because of the (not so recent anymore) changes that make the stream job
>>> independent of the base node and instead track the node above it, we
>>> have to split that "bottom" node into two cases: The bottom COW node,
>>> and the node directly above the base node (which may be an R/W filter
>>> or the bottom COW node).
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>    qapi/block-core.json |  4 +++
>>>    block/stream.c       | 63 ++++++++++++++++++++++++++++++++------------
>>>    blockdev.c           |  4 ++-
>>>    3 files changed, 53 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index b20332e592..df87855429 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -2486,6 +2486,10 @@
>>>    # On successful completion the image file is updated to drop the
>>> backing file
>>>    # and the BLOCK_JOB_COMPLETED event is emitted.
>>>    #
>>> +# In case @device is a filter node, block-stream modifies the first
>>> non-filter
>>> +# overlay node below it to point to base's backing node (or NULL if
>>> @base was
>>> +# not specified) instead of modifying @device itself.
>>> +#
>>>    # @job-id: identifier for the newly-created block job. If
>>>    #          omitted, the device name will be used. (Since 2.7)
>>>    #
>>> diff --git a/block/stream.c b/block/stream.c
>>> index aa2e7af98e..b9c1141656 100644
>>> --- a/block/stream.c
>>> +++ b/block/stream.c
>>> @@ -31,7 +31,8 @@ enum {
>>>      typedef struct StreamBlockJob {
>>>        BlockJob common;
>>> -    BlockDriverState *bottom;
>>> +    BlockDriverState *base_overlay; /* COW overlay (stream from this) */
>>> +    BlockDriverState *above_base;   /* Node directly above the base */
>> Keeping the base_overlay is enough to complete the stream job.
> Depends on the definition.  If we decide it isn’t enough, then it isn’t
> enough.
>
>> The above_base may disappear during the job and we can't rely on it.
> In this version of this series, it may not, because the chain is frozen.
>   So the above_base cannot disappear.

Once we insert a filter above the top bs of the stream job, the parallel 
jobs in

the iotests #030 will fail with 'frozen link error'. It is because of the

independent parallel stream or commit jobs that insert/remove their filters

asynchroniously.

>
> We can discuss whether we should allow it to disappear, but I think not.
>
> The problem is, we need something to set as the backing file after
> streaming.  How do we figure out what that should be?  My proposal is we
> keep above_base and use its immediate child.

We can do the same with the base_overlay.

If the backing node turns out to be a filter, the proper backing child will

be set after the filter is removed. So, we shouldn't care.

>
> If we don’t keep above_base, then we’re basically left guessing as to
> what should be the backing file after the stream job.
>
>>>        BlockdevOnError on_error;
>>>        char *backing_file_str;
>>>        bool bs_read_only;
>>> @@ -53,7 +54,7 @@ static void stream_abort(Job *job)
>>>          if (s->chain_frozen) {
>>>            BlockJob *bjob = &s->common;
>>> -        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->bottom);
>>> +        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->above_base);
>>>        }
>>>    }
>>>    @@ -62,14 +63,15 @@ static int stream_prepare(Job *job)
>>>        StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>>>        BlockJob *bjob = &s->common;
>>>        BlockDriverState *bs = blk_bs(bjob->blk);
>>> -    BlockDriverState *base = backing_bs(s->bottom);
>>> +    BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>>> +    BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
>> The initial base node may be a top node for a concurrent commit job and
>>
>> may disappear.
> Then it would just be replaced by another node, though, so above_base
> keeps a child.  The @base here is not necessarily the initial @base, and
> that’s intentional.

Not really. In my example, above_base becomes a dangling

pointer because after the commit job finishes, its filter that should 
belong to the

commit job frozen chain will be deleted. If we freeze the link to the 
above_base

for this job, the iotests #30 will not pass.

>> base = bdrv_filter_or_cow_bs(s->base_overlay) is more reliable.
> But also wrong.  The point of keeping above_base around is to get its
> child here to use that child as the new backing child of the top node.
>
>>>        Error *local_err = NULL;
>>>        int ret = 0;
>>>    -    bdrv_unfreeze_backing_chain(bs, s->bottom);
>>> +    bdrv_unfreeze_backing_chain(bs, s->above_base);
>>>        s->chain_frozen = false;
>>>    -    if (bs->backing) {
>>> +    if (bdrv_cow_child(unfiltered_bs)) {
>>>            const char *base_id = NULL, *base_fmt = NULL;
>>>            if (base) {
>>>                base_id = s->backing_file_str;
>>> @@ -77,8 +79,8 @@ static int stream_prepare(Job *job)
>>>                    base_fmt = base->drv->format_name;
>>>                }
>>>            }
>>> -        bdrv_set_backing_hd(bs, base, &local_err);
>>> -        ret = bdrv_change_backing_file(bs, base_id, base_fmt);
>>> +        bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
>>> +        ret = bdrv_change_backing_file(unfiltered_bs, base_id,
>>> base_fmt);
>>>            if (local_err) {
>>>                error_report_err(local_err);
>>>                return -EPERM;
>>> @@ -109,14 +111,15 @@ static int coroutine_fn stream_run(Job *job,
>>> Error **errp)
>>>        StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>>>        BlockBackend *blk = s->common.blk;
>>>        BlockDriverState *bs = blk_bs(blk);
>>> -    bool enable_cor = !backing_bs(s->bottom);
>>> +    BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>>> +    bool enable_cor = !bdrv_cow_child(s->base_overlay);
>>>        int64_t len;
>>>        int64_t offset = 0;
>>>        uint64_t delay_ns = 0;
>>>        int error = 0;
>>>        int64_t n = 0; /* bytes */
>>>    -    if (bs == s->bottom) {
>>> +    if (unfiltered_bs == s->base_overlay) {
>>>            /* Nothing to stream */
>>>            return 0;
>>>        }
>>> @@ -150,13 +153,14 @@ static int coroutine_fn stream_run(Job *job,
>>> Error **errp)
>>>              copy = false;
>>>    -        ret = bdrv_is_allocated(bs, offset, STREAM_CHUNK, &n);
>>> +        ret = bdrv_is_allocated(unfiltered_bs, offset, STREAM_CHUNK,
>>> &n);
>>>            if (ret == 1) {
>>>                /* Allocated in the top, no need to copy.  */
>>>            } else if (ret >= 0) {
>>>                /* Copy if allocated in the intermediate images.  Limit
>>> to the
>>>                 * known-unallocated area [offset,
>>> offset+n*BDRV_SECTOR_SIZE).  */
>>> -            ret = bdrv_is_allocated_above(backing_bs(bs), s->bottom,
>>> true,
>>> +            ret = bdrv_is_allocated_above(bdrv_cow_bs(unfiltered_bs),
>>> +                                          s->base_overlay, true,
>>>                                              offset, n, &n);
>>>                /* Finish early if end of backing file has been reached */
>>>                if (ret == 0 && n == 0) {
>>> @@ -223,9 +227,29 @@ void stream_start(const char *job_id,
>>> BlockDriverState *bs,
>>>        BlockDriverState *iter;
>>>        bool bs_read_only;
>>>        int basic_flags = BLK_PERM_CONSISTENT_READ |
>>> BLK_PERM_WRITE_UNCHANGED;
>>> -    BlockDriverState *bottom = bdrv_find_overlay(bs, base);
>>> +    BlockDriverState *base_overlay = bdrv_find_overlay(bs, base);
>>> +    BlockDriverState *above_base;
>>>    -    if (bdrv_freeze_backing_chain(bs, bottom, errp) < 0) {
>>> +    if (!base_overlay) {
>>> +        error_setg(errp, "'%s' is not in the backing chain of '%s'",
>>> +                   base->node_name, bs->node_name);
>> Sorry, I am not clear with the error message.
>>
>> In this case, there is no an intermediate COW node but the base, if not
>> NULL, is
>>
>> in the backing chain of bs, isn't it?
>>
>>> +        return;
>>> +    }
>>> +
>>> +    /*
>>> +     * Find the node directly above @base.  @base_overlay is a COW
>>> overlay, so
>>> +     * it must have a bdrv_cow_child(), but it is the immediate
>>> overlay of
>>> +     * @base, so between the two there can only be filters.
>>> +     */
>>> +    above_base = base_overlay;
>>> +    if (bdrv_cow_bs(above_base) != base) {
>>> +        above_base = bdrv_cow_bs(above_base);
>>> +        while (bdrv_filter_bs(above_base) != base) {
>>> +            above_base = bdrv_filter_bs(above_base);
>>> +        }
>>> +    }
>>> +
>>> +    if (bdrv_freeze_backing_chain(bs, above_base, errp) < 0) {
>> When a concurrent stream job tries to freeze or remove the above_base node,
>>
>> we will encounter the frozen node error. The above_base node is a part
>> of the
>>
>> concurrent job frozen chain.
> Correct.
>
>>>            return;
>>>        }
>>>    @@ -255,14 +279,19 @@ void stream_start(const char *job_id,
>>> BlockDriverState *bs,
>>>         * and resizes. Reassign the base node pointer because the
>>> backing BS of the
>>>         * bottom node might change after the call to
>>> bdrv_reopen_set_read_only()
>>>         * due to parallel block jobs running.
>>> +     * above_base node might change after the call to
>> Yes, if not frozen.
>>> +     * bdrv_reopen_set_read_only() due to parallel block jobs running.
>>>         */
>>> -    base = backing_bs(bottom);
>>> -    for (iter = backing_bs(bs); iter && iter != base; iter =
>>> backing_bs(iter)) {
>>> +    base = bdrv_filter_or_cow_bs(above_base);
>>> +    for (iter = bdrv_filter_or_cow_bs(bs); iter != base;
>>> +         iter = bdrv_filter_or_cow_bs(iter))
>>> +    {
>>>            block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
>>>                               basic_flags, &error_abort);
>>>        }
>>>    -    s->bottom = bottom;
>>> +    s->base_overlay = base_overlay;
>>> +    s->above_base = above_base;
>> Generally, being the filter for a concurrent job, the above_base node
>> may be deleted any time
>>
>> and we will keep the dangling pointer. It may happen even earlier if
>> above_base is not frozen.
>>
>> If it is, as it here, we may get the frozen link error then.
> I’m not sure what you mean here.  Freezing it was absolutely
> intentional.  A dangling pointer would be a problem, but that’s why it’s
> frozen, so it stays around and can’t be deleted any time.
>
> Max

The nodes we freeze should be in one context of the relevant job:

filter->top_node->intermediate_node(s)

We would not include the base or any filter above it to the frozen chain

because they are of a different job context.

Once 'this' job is completed, we set the current backing child of the 
base_overlay

and may not care of its character. If that is another job filter, it 
will be replaced

with the proper node afterwards.


Andrey


