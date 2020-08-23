Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64184C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F29520774
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OA4R0ddH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F29520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9vvI-0000Pz-BW
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 15:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k9vuU-0008EB-HQ; Sun, 23 Aug 2020 15:44:10 -0400
Received: from mail-am6eur05on2128.outbound.protection.outlook.com
 ([40.107.22.128]:19808 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k9vuQ-0005Xe-U3; Sun, 23 Aug 2020 15:44:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfHF+oPREJAbG61Qt8lgbFH4LnnYoEB3W/70wEpS1blVdJN8BM1wOq2pIdGgwFGkdBhtaa82YOhmfchtktw4TyZNPQdFYHdctL9E9X+TNNRt27YkeOqiUDFxeBm7PY8cpl/uMD6+ehw9sdbzfJWyPupn/lJpt+xPdttRyEQmIdM9W3FmDi0GHavONus7FEqZtqPi2Cwthfe4q8vS4sAmlPtk2iv3UwQl6+UJwDUWeWWp0+ly1X/9UMKkzunRBtwYEnv3DsuhJd0XiZNC3AVAWuGLPTo3jiYRIqtrmvUbyCM6ESmzun8U462oEJsDm1tm2pmt2pM1rUHmDxsonTDZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwZDrzHxjDm5LBrmZHXbZ3HnHSzZmnzYl17fxbiMwCM=;
 b=nD0QFhfOyRgYqJhu6P79JzT6WK3fmqqohawPi5XzOghVqq5VNEno7M0t7LL1O5FG4upjDm3I8MzloUiI7lQffOD6Qq9P0QWU1r8/jfczJvJc5obC2dbFbHDXUEpjclVa8RQjPmA5yJQY3irUz8TTTsguzSt0PbMn7ZGySKfY1UilD6Tg4kPpqzbTPUGw1wbP4PscJEhf2CwKgS4Oleu8++bXTa/N6mxj5MIKKzs3Doo4EAt74kYrgb/ATOkWA9hKzG1MTYXDI2boc4rnWdQYx3qZCIyHvkgwVqGVYaDNiv9nFM7UCSUOE8n7sGlufEouR31OSUuMDtdaE10BMP6QkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwZDrzHxjDm5LBrmZHXbZ3HnHSzZmnzYl17fxbiMwCM=;
 b=OA4R0ddHNeMIC8QfaC3CNcCdU+r8DL4mwJYDoR5HSXj7nzPkmG9GnpiugKp8UiqGd0U5aUVvGue1io/S3mu8vkKWgDKcJ5MS0U5rHiftjj1USrkD1IbWes2V+tFS9WWebdIXn2K6/J2olsVQJUuNlCZy8JjQP+FVOPaEj4O2dRs=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0802MB2521.eurprd08.prod.outlook.com (2603:10a6:3:df::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Sun, 23 Aug
 2020 19:28:54 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a%9]) with mapi id 15.20.3305.026; Sun, 23 Aug 2020
 19:28:54 +0000
Subject: Re: [PATCH v6 4/4] block: apply COR-filter to block-stream jobs
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1597785880-431103-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1597785880-431103-5-git-send-email-andrey.shinkevich@virtuozzo.com>
 <6bb4c66e-fb52-c947-1ef2-64a060a92db3@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <103d5732-7812-17d3-82d0-effa76325c50@virtuozzo.com>
Date: Sun, 23 Aug 2020 22:28:49 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <6bb4c66e-fb52-c947-1ef2-64a060a92db3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR04CA0045.eurprd04.prod.outlook.com
 (2603:10a6:208:1::22) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0PR04CA0045.eurprd04.prod.outlook.com (2603:10a6:208:1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Sun, 23 Aug 2020 19:28:52 +0000
X-Originating-IP: [109.252.114.22]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2b2a7c4-1bed-4976-468e-08d8479ac575
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2521:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2521B20759D0EBD5F9E3AA77F4590@HE1PR0802MB2521.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02KgrORwJwhQTIx/k1wYajzEAo1jfEUk95XUhxyPMT+RWsjSCfxwQWqZG0KtCtUpS3OEO/PYR3xMXQociFX3KAvFhGLaOO47fOhaIycKN+ij0y7IQGb+Xe6156P7+WDMKSHpepWEvUAcOO9c+GseSdNAogf+4YaEwn4qe4H7y1eJtDzGJLaNF9W7GeEmwG/2kCsSwHZvFhnCkIrdXtI5x/2hv0wFS1kZ9IOQYcXp4H5D5pnQ/BsWbR8eU3D5L8yRH2Ol/KrPWQRp0qyG4aySlybQQU6T4wpUTt1rC/NqyOdJk2GiPbEvv465l82SvMpBGqqwGfTcaxQfQm91yW4JlUapWgW4BusNeBHe2vX5jQPZx7+VqPULrc/NDhaVQ3zA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39830400003)(346002)(136003)(2616005)(956004)(36756003)(44832011)(83380400001)(2906002)(31686004)(52116002)(8676002)(6506007)(53546011)(8936002)(478600001)(6512007)(5660300002)(31696002)(66476007)(86362001)(186003)(6666004)(107886003)(4326008)(66556008)(26005)(316002)(6486002)(16526019)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: S7Uq8igmOAVtY5K0h7jc108FYHrtZ+rLQH6RgCZ70DmJXk2wSG+o482cmw+djWobkibHMJit7L4Imh5niDjajRvYafDYDHgIhpp7mZwZQ81dg0oFbQ3rOyMGgbLZPeVDPjEMreT13IJ2Yy73prUWu83vkxMKs4AfP+3cEBC2CkvU99XGMsq5VfxnrSOosoW+LMrvXFDWKI3m3Phn705DJX0enMS99IluxUl5TTRPJYx6/eMpieNIfKbbb7BC0QgNtoYA7oMVSAjF7ox0p/+G1vdird07210tWSmp3L/C8ym1eiMYhKqY3ajiHOiNVp1f+DcYoVvkj5f6NiyWhEtnw1SE6mUgd5RKf8gjxDmNCpV5kqYU9cvvsupNMZJWXCWTpKs+1IlqO4pc0Pggd+OWgDMgFw5WERbCjWCvVPnVeMQ2OAhETKCcYZDn+PfrMcEulY3e7uM2DCBSX0u3cjLtShw5Sdk8IaouRqfUDVoPVoaz8swcGZsCaYC5Dw4Rf6qgEH07N4OFLgaKj2sIXix/3uawry3GDtaMu7rEIbJAJ1+/6OgPYNBc+t/HHht8Ar5fq5PPtQcHE1EOgiK2ynykXRcAaLLcRULfjhk3+eqRr7MSdttbStKAG7vzYYqRrJBcnxSeYYW5YTktzxj0RjexLQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b2a7c4-1bed-4976-468e-08d8479ac575
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2020 19:28:53.9186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emWH1E5Kt+tHNxID6pe2trSIOcnDcbWEJxWfAg90JA1+WoRjBQvGuCjn46WJn9lWtKzvqxpalsHZ8dcj3Z+62MfOOcPHdXVBrhP7tBeWbGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2521
Received-SPF: pass client-ip=40.107.22.128;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 15:44:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.381, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 19.08.2020 13:46, Vladimir Sementsov-Ogievskiy wrote:
> 19.08.2020 00:24, Andrey Shinkevich wrote:
>> The patch completes the series with the COR-filter insertion to any
>> block-stream operation. It also makes changes to the iotests 030.
>> The test case 'test_stream_parallel' was deleted due to multiple
>> errors.
>
...
>
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/stream.c             | 76 
>> ++++++++++++++++++++++++++++++++--------------
>>   tests/qemu-iotests/030     | 50 +++---------------------------
>>   tests/qemu-iotests/030.out |  4 +--
>>   3 files changed, 61 insertions(+), 69 deletions(-)
>>
>> diff --git a/block/stream.c b/block/stream.c
>> index 8bf6b6d..0b11979 100644
>> --- a/block/stream.c
>> +++ b/block/stream.c
>> @@ -19,6 +19,7 @@
>>   #include "qapi/qmp/qerror.h"
>>   #include "qemu/ratelimit.h"
>>   #include "sysemu/block-backend.h"
>> +#include "block/copy-on-read.h"
>>     enum {
>>       /*
>> @@ -33,8 +34,11 @@ typedef struct StreamBlockJob {
>>       BlockJob common;
>>       BlockDriverState *base_overlay; /* COW overlay (stream from 
>> this) */
>>       BlockDriverState *above_base;   /* Node directly above the base */
>> +    BlockDriverState *cor_filter_bs;
>> +    BlockDriverState *target_bs;
>>       BlockdevOnError on_error;
>>       char *backing_file_str;
>> +    char *base_fmt;
>>       bool bs_read_only;
>>       bool chain_frozen;
>>   } StreamBlockJob;
>> @@ -53,34 +57,26 @@ static void stream_abort(Job *job)
>>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>>         if (s->chain_frozen) {
>> -        BlockJob *bjob = &s->common;
>> -        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->above_base);
>> +        bdrv_unfreeze_backing_chain(s->cor_filter_bs, s->above_base);
>>       }
>>   }
>>     static int stream_prepare(Job *job)
>>   {
>>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>> -    BlockJob *bjob = &s->common;
>> -    BlockDriverState *bs = blk_bs(bjob->blk);
>> +    BlockDriverState *bs = s->target_bs;
>>       BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>>       BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
>>       Error *local_err = NULL;
>>       int ret = 0;
>>   -    bdrv_unfreeze_backing_chain(bs, s->above_base);
>> +    bdrv_unfreeze_backing_chain(s->cor_filter_bs, s->above_base);
>>       s->chain_frozen = false;
>>         if (bdrv_cow_child(unfiltered_bs)) {
>> -        const char *base_id = NULL, *base_fmt = NULL;
>> -        if (base) {
>> -            base_id = s->backing_file_str;
>> -            if (base->drv) {
>> -                base_fmt = base->drv->format_name;
>> -            }
>> -        }
>>           bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
>> -        ret = bdrv_change_backing_file(unfiltered_bs, base_id, 
>> base_fmt);
>> +        ret = bdrv_change_backing_file(unfiltered_bs, 
>> s->backing_file_str,
>> +                                       s->base_fmt);
>>           if (local_err) {
>>               error_report_err(local_err);
>>               return -EPERM;
>> @@ -94,7 +90,9 @@ static void stream_clean(Job *job)
>>   {
>>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>>       BlockJob *bjob = &s->common;
>> -    BlockDriverState *bs = blk_bs(bjob->blk);
>> +    BlockDriverState *bs = s->target_bs;
>> +
>> +    bdrv_cor_filter_drop(s->cor_filter_bs);
>>         /* Reopen the image back in read-only mode if necessary */
>>       if (s->bs_read_only) {
>> @@ -104,13 +102,14 @@ static void stream_clean(Job *job)
>>       }
>>         g_free(s->backing_file_str);
>> +    g_free(s->base_fmt);
>>   }
>>     static int coroutine_fn stream_run(Job *job, Error **errp)
>>   {
>>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>>       BlockBackend *blk = s->common.blk;
>> -    BlockDriverState *bs = blk_bs(blk);
>> +    BlockDriverState *bs = s->target_bs;
>>       BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>>       bool enable_cor = !bdrv_cow_child(s->base_overlay);
>>       int64_t len;
>> @@ -231,6 +230,12 @@ void stream_start(const char *job_id, 
>> BlockDriverState *bs,
>>       int basic_flags = BLK_PERM_CONSISTENT_READ | 
>> BLK_PERM_WRITE_UNCHANGED;
>>       BlockDriverState *base_overlay = bdrv_find_overlay(bs, base);
>>       BlockDriverState *above_base;
>> +    BlockDriverState *cor_filter_bs = NULL;
>> +    char *base_fmt = NULL;
>> +
>> +    if (base && base->drv) {
>> +        base_fmt = g_strdup(base->drv->format_name);
>> +    }
>>         if (!base_overlay) {
>>           error_setg(errp, "'%s' is not in the backing chain of '%s'",
>> @@ -264,17 +269,36 @@ void stream_start(const char *job_id, 
>> BlockDriverState *bs,
>>           }
>>       }
>>   -    /* Prevent concurrent jobs trying to modify the graph 
>> structure here, we
>> -     * already have our own plans. Also don't allow resize as the 
>> image size is
>> -     * queried only at the job start and then cached. */
>> -    s = block_job_create(job_id, &stream_job_driver, NULL, bs,
>> -                         basic_flags | BLK_PERM_GRAPH_MOD,
>> -                         basic_flags | BLK_PERM_WRITE,
>> +    cor_filter_bs = bdrv_cor_filter_append(bs, filter_node_name, errp);
>> +    if (cor_filter_bs == NULL) {
>> +        goto fail;
>> +    }
>> +
>> +    if (bdrv_freeze_backing_chain(cor_filter_bs, bs, errp) < 0) {
>> +        bdrv_cor_filter_drop(cor_filter_bs);
>> +        cor_filter_bs = NULL;
>> +        goto fail;
>> +    }
>> +
>> +    s = block_job_create(job_id, &stream_job_driver, NULL, 
>> cor_filter_bs,
>> +                         BLK_PERM_CONSISTENT_READ,
>> +                         basic_flags | BLK_PERM_WRITE | 
>> BLK_PERM_GRAPH_MOD,
>>                            speed, creation_flags, NULL, NULL, errp);
>>       if (!s) {
>>           goto fail;
>>       }
>>   +    /*
>> +     * Prevent concurrent jobs trying to modify the graph structure 
>> here, we
>> +     * already have our own plans. Also don't allow resize as the 
>> image size is
>> +     * queried only at the job start and then cached.
>> +     */
>> +    if (block_job_add_bdrv(&s->common, "active node", bs,
>> +                           basic_flags | BLK_PERM_GRAPH_MOD,
>> +                           basic_flags | BLK_PERM_WRITE, 
>> &error_abort)) {
>> +        goto fail;
>> +    }
>> +
>>       /* Block all intermediate nodes between bs and base, because 
>> they will
>>        * disappear from the chain after this operation. The streaming 
>> job reads
>>        * every block only once, assuming that it doesn't change, so 
>> forbid writes
>> @@ -294,6 +318,9 @@ void stream_start(const char *job_id, 
>> BlockDriverState *bs,
>>         s->base_overlay = base_overlay;
>>       s->above_base = above_base;
>> +    s->cor_filter_bs = cor_filter_bs;
>> +    s->target_bs = bs;
>> +    s->base_fmt = base_fmt;
>
> it's wrong to keep base_fmt during the job, as base may change


So, the format can differ from that of the backing_file_str given as the 
input parameter of the stream_start()...

...while the backing_file_str path is written to the QCOW2 header on a disk.

Andrey


>
>>       s->backing_file_str = g_strdup(backing_file_str);
>>       s->bs_read_only = bs_read_only;
>>       s->chain_frozen = true;
>> @@ -307,5 +334,10 @@ fail:
>>       if (bs_read_only) {
>>           bdrv_reopen_set_read_only(bs, true, NULL);
>>       }
>> -    bdrv_unfreeze_backing_chain(bs, above_base);
>> +    if (cor_filter_bs) {
>> +        bdrv_unfreeze_backing_chain(cor_filter_bs, above_base);
>> +        bdrv_cor_filter_drop(cor_filter_bs);
>> +    } else {
>> +        bdrv_unfreeze_backing_chain(bs, above_base);
>> +    }
>>   }
>> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
>> index 1cdd7e2..fec9d89 100755
>> --- a/tests/qemu-iotests/030
>> +++ b/tests/qemu-iotests/030
>> @@ -221,60 +221,20 @@ class TestParallelOps(iotests.QMPTestCase):
>>           for img in self.imgs:
>>               os.remove(img)
...

