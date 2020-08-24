Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CEEC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:50:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81462208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="l/AwVKEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81462208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA8BR-0003Aw-PI
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 04:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kA8An-0002iU-Lh; Mon, 24 Aug 2020 04:49:49 -0400
Received: from mail-eopbgr80102.outbound.protection.outlook.com
 ([40.107.8.102]:44717 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kA8Ak-0005uj-0l; Mon, 24 Aug 2020 04:49:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZTXosQFLwTs/qcDnLjF+idEetFYL+T80T1QdPdGsckB1zwWcDC2lzhG+vC2Je/PQqt5S5Ifj2ffcKVHYV5l3My1D7WyPkmYQl5Qt+KPAtD5lcokYvmgfUTmXd9ODXdms8d9frDeZqxIToDpcf9nucbybaNOzF74oHftAiX/AJdmzqRn2y32A8LvXTEpJ/4CCTyu4tSGpXCFGWqx/h6yHNfdSCcojM8I4Hg3pVDJhTWtAezEkRAE+s4c2Afwy+ER3ErLQSHC4wq4CKC8LDLKYOzfUxY3RWqZlOI5GFQ9TZk3f/gi9esTgavV3J5sztHG3aAtcYXP/mjbGmiwG/Jdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IA7sS2kypHDsE2y9S7nRi6Eu7+IPSaAHC44ul78RleE=;
 b=l/Vu3W5gVtCwYNh7mIfRvqGpHzee0ekk+u+33/SGUb3VyqDjYL+ikNNQ6QfqploqYQCRjGjY7ddzvO+OboIcCU6AH1rV708ypGPnvdNLQ7YmCfZatE2EhpQ7ZCiCPfTzC9Oz6/ZKcyZzF9AAPqhIh+twS46lVp040FT3IfET9e3pp3JCJAu2zHO/fk0Rek3WOgrZbap3qayLxD+onwHXzCATAe+udkennbTnXE4PAH3A7QRqYCwyIu543IwrsEh/WRB+9Y9WXTQ4AkpeZgCI+BwiwW3PoFnbiLYbF00G5UG7dct615tvuCNPGFBUxAKOf6SN+mdaGIC2nnYFYT/Mdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IA7sS2kypHDsE2y9S7nRi6Eu7+IPSaAHC44ul78RleE=;
 b=l/AwVKEU6odf98MOiqmic+/eJNz3jJYevmOywJ/Qy0tXueyLEQUGS+kEnDU39BaSK4vQ9LJUaZxqKBwScwiLW4el1SctY4iDwRgEcrPWoEpV6trV67c/AjJA6V5BTiOkw4V9dNVNJh1WSSEWvtvde3Jz+opNCRSAZO2Z4l5kbXo=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0801MB1642.eurprd08.prod.outlook.com (2603:10a6:3:86::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 08:49:41 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a%9]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 08:49:41 +0000
Subject: Re: [PATCH v6 4/4] block: apply COR-filter to block-stream jobs
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1597785880-431103-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1597785880-431103-5-git-send-email-andrey.shinkevich@virtuozzo.com>
 <6bb4c66e-fb52-c947-1ef2-64a060a92db3@virtuozzo.com>
 <103d5732-7812-17d3-82d0-effa76325c50@virtuozzo.com>
 <b1153a54-96c8-3ddc-e4ee-42c613d02924@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <3d71e88f-7769-717b-8f68-a2bba52ee388@virtuozzo.com>
Date: Mon, 24 Aug 2020 11:49:37 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <b1153a54-96c8-3ddc-e4ee-42c613d02924@virtuozzo.com>
Content-Type: multipart/alternative;
 boundary="------------8F4C5FAC0111E4C25DAB082B"
Content-Language: en-GB
X-ClientProxiedBy: AM0P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::16) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 08:49:39 +0000
X-Originating-IP: [109.252.114.22]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5575ac9-84e5-4d64-63c7-08d8480aa3d9
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1642:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB164278FE1743345DC879A1A2F4560@HE1PR0801MB1642.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yeevhSwLR8gKd+nARpHEpaPYEzKbqiuUoruzGJ3wRpA8+udlPn1zghtWE3qvMLejpkfQ/L6GlwDXgoUrUDpcpRz/UhVpO8sv/AdRzqGBO7zUp84jX4X9SK5b9pswBcoh3mxtdhwtKjL8OHbeBhnM9IAO2GoJqJ1pO+HQxFrGwnSjaNRvIUo6e/skM414t8yKqJ0s8rKw/7jpkm+MNkEUpBkR1Hg45PhFVtw+1pnbWUJF4kj0TJmgpZ+ta67IJtq2e/yLYVhEgL/3QcO80Aef+T1nkFvRz7NINGWj8/0jpCADFgAJgHsnRzKqjO56K/DijjM+IimO7Cdk6jjuF06Kc1InoiY54fhnVmjEeJdg3jyi7/TznWzqd74661Fiv4/b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39840400004)(316002)(2616005)(52116002)(86362001)(30864003)(44832011)(956004)(31686004)(5660300002)(2906002)(107886003)(4326008)(8676002)(6512007)(31696002)(83380400001)(6486002)(8936002)(33964004)(478600001)(66556008)(36756003)(16526019)(186003)(53546011)(6506007)(66946007)(26005)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: E8Az6p7eLHX6Aa3hWny3MT/UnabJ9wCi0Yr3dQl/JatIVWbnqu7qV5Cjru1snUTJ60zmRZojV+xF5BBywouywmbNad7tG7dDOrO//ZFKaQTe0MjL3kotve6/dRQcN90ZxFfptqCvpHLVMJVUXnaLHbNz9llndqyHFt6VEHyszx9FIlbgmDzb7Obs7GPFcCjDqA/RFqNxdfcnLn1h38twQjLEkLnLWNrj5CO+BBor8oGblAdg5rVCeP+5WaTGfqqebuwXLy4EGCjvB/zdoQQ02rypcCKxOOaLZACG6j/3o9MARBRoerPC7g+YEUlcQTAoAPFpUkBOGMMa0G2eUl+1t21ZQsGYnC4BUDOiLt9uPjDWTlUnqEMgRDbv9Z2h+uTO7avdB8nIQRVvg9S9snROSqJkLfnzla19LDNjcahkgASBzvVUnM75Xc4HMPjV6ccfl2axzYRchagFUAQMRDI1wdbVbW/p7eTmVcek6FpyOb+sKSQKiC4NpRng4fqKOmfmCpXNR6o2gT911FWgbkEqo5UAnxP0ZX2m9MrBKCb92KC1Nw3YILFEcpBngbikC1CorCoLT0+OgmjZ+/aH3SkWkD5Ri1zfo7KkJaV3adKCjRmrvWvfkWjQcn6VVbrr7a1NxCZFO4DRmkDXJzgrWeIYlw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5575ac9-84e5-4d64-63c7-08d8480aa3d9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 08:49:41.2259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vvsyp9CatsGA33SfAjqAeuQVgdtLjbzKoJR5TZQlormtfMMU5LLWxsvkWGJCxP/6A9c87J+vqUp9l/H+aPeguQprZ/QsQJl7nyoFOCU9zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1642
Received-SPF: pass client-ip=40.107.8.102;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 04:49:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--------------8F4C5FAC0111E4C25DAB082B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.08.2020 11:20, Vladimir Sementsov-Ogievskiy wrote:
> 23.08.2020 22:28, Andrey Shinkevich wrote:
>> On 19.08.2020 13:46, Vladimir Sementsov-Ogievskiy wrote:
>>> 19.08.2020 00:24, Andrey Shinkevich wrote:
>>>> The patch completes the series with the COR-filter insertion to any
>>>> block-stream operation. It also makes changes to the iotests 030.
>>>> The test case 'test_stream_parallel' was deleted due to multiple
>>>> errors.
>>>
>> ...
>>>
>>>>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---
>>>>   block/stream.c             | 76 
>>>> ++++++++++++++++++++++++++++++++--------------
>>>>   tests/qemu-iotests/030     | 50 +++---------------------------
>>>>   tests/qemu-iotests/030.out |  4 +--
>>>>   3 files changed, 61 insertions(+), 69 deletions(-)
>>>>
>>>> diff --git a/block/stream.c b/block/stream.c
>>>> index 8bf6b6d..0b11979 100644
>>>> --- a/block/stream.c
>>>> +++ b/block/stream.c
>>>> @@ -19,6 +19,7 @@
>>>>   #include "qapi/qmp/qerror.h"
>>>>   #include "qemu/ratelimit.h"
>>>>   #include "sysemu/block-backend.h"
>>>> +#include "block/copy-on-read.h"
>>>>     enum {
>>>>       /*
>>>> @@ -33,8 +34,11 @@ typedef struct StreamBlockJob {
>>>>       BlockJob common;
>>>>       BlockDriverState *base_overlay; /* COW overlay (stream from 
>>>> this) */
>>>>       BlockDriverState *above_base;   /* Node directly above the 
>>>> base */
>>>> +    BlockDriverState *cor_filter_bs;
>>>> +    BlockDriverState *target_bs;
>>>>       BlockdevOnError on_error;
>>>>       char *backing_file_str;
>>>> +    char *base_fmt;
>>>>       bool bs_read_only;
>>>>       bool chain_frozen;
>>>>   } StreamBlockJob;
>>>> @@ -53,34 +57,26 @@ static void stream_abort(Job *job)
>>>>       StreamBlockJob *s = container_of(job, StreamBlockJob, 
>>>> common.job);
>>>>         if (s->chain_frozen) {
>>>> -        BlockJob *bjob = &s->common;
>>>> -        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), 
>>>> s->above_base);
>>>> +        bdrv_unfreeze_backing_chain(s->cor_filter_bs, s->above_base);
>>>>       }
>>>>   }
>>>>     static int stream_prepare(Job *job)
>>>>   {
>>>>       StreamBlockJob *s = container_of(job, StreamBlockJob, 
>>>> common.job);
>>>> -    BlockJob *bjob = &s->common;
>>>> -    BlockDriverState *bs = blk_bs(bjob->blk);
>>>> +    BlockDriverState *bs = s->target_bs;
>>>>       BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>>>>       BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
>>>>       Error *local_err = NULL;
>>>>       int ret = 0;
>>>>   -    bdrv_unfreeze_backing_chain(bs, s->above_base);
>>>> +    bdrv_unfreeze_backing_chain(s->cor_filter_bs, s->above_base);
>>>>       s->chain_frozen = false;
>>>>         if (bdrv_cow_child(unfiltered_bs)) {
>>>> -        const char *base_id = NULL, *base_fmt = NULL;
>>>> -        if (base) {
>>>> -            base_id = s->backing_file_str;
>>>> -            if (base->drv) {
>>>> -                base_fmt = base->drv->format_name;
>>>> -            }
>>>> -        }
>>>>           bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
>>>> -        ret = bdrv_change_backing_file(unfiltered_bs, base_id, 
>>>> base_fmt);
>>>> +        ret = bdrv_change_backing_file(unfiltered_bs, 
>>>> s->backing_file_str,
>>>> +                                       s->base_fmt);
>>>>           if (local_err) {
>>>>               error_report_err(local_err);
>>>>               return -EPERM;
>>>> @@ -94,7 +90,9 @@ static void stream_clean(Job *job)
>>>>   {
>>>>       StreamBlockJob *s = container_of(job, StreamBlockJob, 
>>>> common.job);
>>>>       BlockJob *bjob = &s->common;
>>>> -    BlockDriverState *bs = blk_bs(bjob->blk);
>>>> +    BlockDriverState *bs = s->target_bs;
>>>> +
>>>> +    bdrv_cor_filter_drop(s->cor_filter_bs);
>>>>         /* Reopen the image back in read-only mode if necessary */
>>>>       if (s->bs_read_only) {
>>>> @@ -104,13 +102,14 @@ static void stream_clean(Job *job)
>>>>       }
>>>>         g_free(s->backing_file_str);
>>>> +    g_free(s->base_fmt);
>>>>   }
>>>>     static int coroutine_fn stream_run(Job *job, Error **errp)
>>>>   {
>>>>       StreamBlockJob *s = container_of(job, StreamBlockJob, 
>>>> common.job);
>>>>       BlockBackend *blk = s->common.blk;
>>>> -    BlockDriverState *bs = blk_bs(blk);
>>>> +    BlockDriverState *bs = s->target_bs;
>>>>       BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>>>>       bool enable_cor = !bdrv_cow_child(s->base_overlay);
>>>>       int64_t len;
>>>> @@ -231,6 +230,12 @@ void stream_start(const char *job_id, 
>>>> BlockDriverState *bs,
>>>>       int basic_flags = BLK_PERM_CONSISTENT_READ | 
>>>> BLK_PERM_WRITE_UNCHANGED;
>>>>       BlockDriverState *base_overlay = bdrv_find_overlay(bs, base);
>>>>       BlockDriverState *above_base;
>>>> +    BlockDriverState *cor_filter_bs = NULL;
>>>> +    char *base_fmt = NULL;
>>>> +
>>>> +    if (base && base->drv) {
>>>> +        base_fmt = g_strdup(base->drv->format_name);
>>>> +    }
>>>>         if (!base_overlay) {
>>>>           error_setg(errp, "'%s' is not in the backing chain of '%s'",
>>>> @@ -264,17 +269,36 @@ void stream_start(const char *job_id, 
>>>> BlockDriverState *bs,
>>>>           }
>>>>       }
>>>>   -    /* Prevent concurrent jobs trying to modify the graph 
>>>> structure here, we
>>>> -     * already have our own plans. Also don't allow resize as the 
>>>> image size is
>>>> -     * queried only at the job start and then cached. */
>>>> -    s = block_job_create(job_id, &stream_job_driver, NULL, bs,
>>>> -                         basic_flags | BLK_PERM_GRAPH_MOD,
>>>> -                         basic_flags | BLK_PERM_WRITE,
>>>> +    cor_filter_bs = bdrv_cor_filter_append(bs, filter_node_name, 
>>>> errp);
>>>> +    if (cor_filter_bs == NULL) {
>>>> +        goto fail;
>>>> +    }
>>>> +
>>>> +    if (bdrv_freeze_backing_chain(cor_filter_bs, bs, errp) < 0) {
>>>> +        bdrv_cor_filter_drop(cor_filter_bs);
>>>> +        cor_filter_bs = NULL;
>>>> +        goto fail;
>>>> +    }
>>>> +
>>>> +    s = block_job_create(job_id, &stream_job_driver, NULL, 
>>>> cor_filter_bs,
>>>> +                         BLK_PERM_CONSISTENT_READ,
>>>> +                         basic_flags | BLK_PERM_WRITE | 
>>>> BLK_PERM_GRAPH_MOD,
>>>>                            speed, creation_flags, NULL, NULL, errp);
>>>>       if (!s) {
>>>>           goto fail;
>>>>       }
>>>>   +    /*
>>>> +     * Prevent concurrent jobs trying to modify the graph 
>>>> structure here, we
>>>> +     * already have our own plans. Also don't allow resize as the 
>>>> image size is
>>>> +     * queried only at the job start and then cached.
>>>> +     */
>>>> +    if (block_job_add_bdrv(&s->common, "active node", bs,
>>>> +                           basic_flags | BLK_PERM_GRAPH_MOD,
>>>> +                           basic_flags | BLK_PERM_WRITE, 
>>>> &error_abort)) {
>>>> +        goto fail;
>>>> +    }
>>>> +
>>>>       /* Block all intermediate nodes between bs and base, because 
>>>> they will
>>>>        * disappear from the chain after this operation. The 
>>>> streaming job reads
>>>>        * every block only once, assuming that it doesn't change, so 
>>>> forbid writes
>>>> @@ -294,6 +318,9 @@ void stream_start(const char *job_id, 
>>>> BlockDriverState *bs,
>>>>         s->base_overlay = base_overlay;
>>>>       s->above_base = above_base;
>>>> +    s->cor_filter_bs = cor_filter_bs;
>>>> +    s->target_bs = bs;
>>>> +    s->base_fmt = base_fmt;
>>>
>>> it's wrong to keep base_fmt during the job, as base may change
>>
>>
>> So, the format can differ from that of the backing_file_str given as 
>> the input parameter of the stream_start()...
>>
>> ...while the backing_file_str path is written to the QCOW2 header on 
>> a disk.
>>
>
> Or better, let's try to revert c624b015bf14f and freeze base again.


The reversion won't help as the patch "stream: Deal with filters" did 
that work already. We have to freeze the base again. I guess it will 
discard the concept of the 'base_overlay' and the  'above_base'  
introduced by Max in the series "block: Deal withfilters".

Andrey


>
>>
>>
>>>
>>>>       s->backing_file_str = g_strdup(backing_file_str);
>>>>       s->bs_read_only = bs_read_only;
>>>>       s->chain_frozen = true;
>>>> @@ -307,5 +334,10 @@ fail:
>>>>       if (bs_read_only) {
>>>>           bdrv_reopen_set_read_only(bs, true, NULL);
>>>>       }
>>>> -    bdrv_unfreeze_backing_chain(bs, above_base);
>>>> +    if (cor_filter_bs) {
>>>> +        bdrv_unfreeze_backing_chain(cor_filter_bs, above_base);
>>>> +        bdrv_cor_filter_drop(cor_filter_bs);
>>>> +    } else {
>>>> +        bdrv_unfreeze_backing_chain(bs, above_base);
>>>> +    }
>>>>   }
>>>> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
>>>> index 1cdd7e2..fec9d89 100755
>>>> --- a/tests/qemu-iotests/030
>>>> +++ b/tests/qemu-iotests/030
>>>> @@ -221,60 +221,20 @@ class TestParallelOps(iotests.QMPTestCase):
>>>>           for img in self.imgs:
>>>>               os.remove(img)
>> ...
>
>

--------------8F4C5FAC0111E4C25DAB082B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 24.08.2020 11:20, Vladimir
      Sementsov-Ogievskiy wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:b1153a54-96c8-3ddc-e4ee-42c613d02924@virtuozzo.com">23.08.2020
      22:28, Andrey Shinkevich wrote:
      <br>
      <blockquote type="cite">On 19.08.2020 13:46, Vladimir
        Sementsov-Ogievskiy wrote:
        <br>
        <blockquote type="cite">19.08.2020 00:24, Andrey Shinkevich
          wrote:
          <br>
          <blockquote type="cite">The patch completes the series with
            the COR-filter insertion to any
            <br>
            block-stream operation. It also makes changes to the iotests
            030.
            <br>
            The test case 'test_stream_parallel' was deleted due to
            multiple
            <br>
            errors.
            <br>
          </blockquote>
          <br>
        </blockquote>
        ...
        <br>
        <blockquote type="cite">
          <br>
          <blockquote type="cite">
            <br>
            Signed-off-by: Andrey Shinkevich
            <a class="moz-txt-link-rfc2396E" href="mailto:andrey.shinkevich@virtuozzo.com">&lt;andrey.shinkevich@virtuozzo.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; block/stream.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 76
            ++++++++++++++++++++++++++++++++--------------
            <br>
            &nbsp; tests/qemu-iotests/030&nbsp;&nbsp;&nbsp;&nbsp; | 50
            +++---------------------------
            <br>
            &nbsp; tests/qemu-iotests/030.out |&nbsp; 4 +--
            <br>
            &nbsp; 3 files changed, 61 insertions(+), 69 deletions(-)
            <br>
            <br>
            diff --git a/block/stream.c b/block/stream.c
            <br>
            index 8bf6b6d..0b11979 100644
            <br>
            --- a/block/stream.c
            <br>
            +++ b/block/stream.c
            <br>
            @@ -19,6 +19,7 @@
            <br>
            &nbsp; #include &quot;qapi/qmp/qerror.h&quot;
            <br>
            &nbsp; #include &quot;qemu/ratelimit.h&quot;
            <br>
            &nbsp; #include &quot;sysemu/block-backend.h&quot;
            <br>
            +#include &quot;block/copy-on-read.h&quot;
            <br>
            &nbsp; &nbsp; enum {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
            <br>
            @@ -33,8 +34,11 @@ typedef struct StreamBlockJob {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BlockJob common;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BlockDriverState *base_overlay; /* COW overlay (stream
            from this) */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BlockDriverState *above_base;&nbsp;&nbsp; /* Node directly above
            the base */
            <br>
            +&nbsp;&nbsp;&nbsp; BlockDriverState *cor_filter_bs;
            <br>
            +&nbsp;&nbsp;&nbsp; BlockDriverState *target_bs;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BlockdevOnError on_error;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *backing_file_str;
            <br>
            +&nbsp;&nbsp;&nbsp; char *base_fmt;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool bs_read_only;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool chain_frozen;
            <br>
            &nbsp; } StreamBlockJob;
            <br>
            @@ -53,34 +57,26 @@ static void stream_abort(Job *job)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; StreamBlockJob *s = container_of(job, StreamBlockJob,
            common.job);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;chain_frozen) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BlockJob *bjob = &amp;s-&gt;common;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdrv_unfreeze_backing_chain(blk_bs(bjob-&gt;blk),
            s-&gt;above_base);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdrv_unfreeze_backing_chain(s-&gt;cor_filter_bs,
            s-&gt;above_base);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; static int stream_prepare(Job *job)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; StreamBlockJob *s = container_of(job, StreamBlockJob,
            common.job);
            <br>
            -&nbsp;&nbsp;&nbsp; BlockJob *bjob = &amp;s-&gt;common;
            <br>
            -&nbsp;&nbsp;&nbsp; BlockDriverState *bs = blk_bs(bjob-&gt;blk);
            <br>
            +&nbsp;&nbsp;&nbsp; BlockDriverState *bs = s-&gt;target_bs;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BlockDriverState *unfiltered_bs =
            bdrv_skip_filters(bs);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BlockDriverState *base =
            bdrv_filter_or_cow_bs(s-&gt;above_base);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error *local_err = NULL;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret = 0;
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; bdrv_unfreeze_backing_chain(bs, s-&gt;above_base);
            <br>
            +&nbsp;&nbsp;&nbsp; bdrv_unfreeze_backing_chain(s-&gt;cor_filter_bs,
            s-&gt;above_base);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;chain_frozen = false;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bdrv_cow_child(unfiltered_bs)) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *base_id = NULL, *base_fmt = NULL;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (base) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base_id = s-&gt;backing_file_str;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (base-&gt;drv) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base_fmt = base-&gt;drv-&gt;format_name;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdrv_set_backing_hd(unfiltered_bs, base,
            &amp;local_err);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = bdrv_change_backing_file(unfiltered_bs,
            base_id, base_fmt);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = bdrv_change_backing_file(unfiltered_bs,
            s-&gt;backing_file_str,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;base_fmt);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (local_err) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_report_err(local_err);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EPERM;
            <br>
            @@ -94,7 +90,9 @@ static void stream_clean(Job *job)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; StreamBlockJob *s = container_of(job, StreamBlockJob,
            common.job);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BlockJob *bjob = &amp;s-&gt;common;
            <br>
            -&nbsp;&nbsp;&nbsp; BlockDriverState *bs = blk_bs(bjob-&gt;blk);
            <br>
            +&nbsp;&nbsp;&nbsp; BlockDriverState *bs = s-&gt;target_bs;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; bdrv_cor_filter_drop(s-&gt;cor_filter_bs);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reopen the image back in read-only mode if
            necessary */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;bs_read_only) {
            <br>
            @@ -104,13 +102,14 @@ static void stream_clean(Job *job)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_free(s-&gt;backing_file_str);
            <br>
            +&nbsp;&nbsp;&nbsp; g_free(s-&gt;base_fmt);
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; static int coroutine_fn stream_run(Job *job, Error
            **errp)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; StreamBlockJob *s = container_of(job, StreamBlockJob,
            common.job);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BlockBackend *blk = s-&gt;common.blk;
            <br>
            -&nbsp;&nbsp;&nbsp; BlockDriverState *bs = blk_bs(blk);
            <br>
            +&nbsp;&nbsp;&nbsp; BlockDriverState *bs = s-&gt;target_bs;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BlockDriverState *unfiltered_bs =
            bdrv_skip_filters(bs);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable_cor = !bdrv_cow_child(s-&gt;base_overlay);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int64_t len;
            <br>
            @@ -231,6 +230,12 @@ void stream_start(const char *job_id,
            BlockDriverState *bs,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int basic_flags = BLK_PERM_CONSISTENT_READ |
            BLK_PERM_WRITE_UNCHANGED;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BlockDriverState *base_overlay = bdrv_find_overlay(bs,
            base);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BlockDriverState *above_base;
            <br>
            +&nbsp;&nbsp;&nbsp; BlockDriverState *cor_filter_bs = NULL;
            <br>
            +&nbsp;&nbsp;&nbsp; char *base_fmt = NULL;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (base &amp;&amp; base-&gt;drv) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base_fmt = g_strdup(base-&gt;drv-&gt;format_name);
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!base_overlay) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;'%s' is not in the backing chain
            of '%s'&quot;,
            <br>
            @@ -264,17 +269,36 @@ void stream_start(const char *job_id,
            BlockDriverState *bs,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; /* Prevent concurrent jobs trying to modify the graph
            structure here, we
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; * already have our own plans. Also don't allow resize
            as the image size is
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; * queried only at the job start and then cached. */
            <br>
            -&nbsp;&nbsp;&nbsp; s = block_job_create(job_id, &amp;stream_job_driver,
            NULL, bs,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; basic_flags | BLK_PERM_GRAPH_MOD,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; basic_flags | BLK_PERM_WRITE,
            <br>
            +&nbsp;&nbsp;&nbsp; cor_filter_bs = bdrv_cor_filter_append(bs,
            filter_node_name, errp);
            <br>
            +&nbsp;&nbsp;&nbsp; if (cor_filter_bs == NULL) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (bdrv_freeze_backing_chain(cor_filter_bs, bs, errp)
            &lt; 0) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdrv_cor_filter_drop(cor_filter_bs);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cor_filter_bs = NULL;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; s = block_job_create(job_id, &amp;stream_job_driver,
            NULL, cor_filter_bs,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BLK_PERM_CONSISTENT_READ,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; basic_flags | BLK_PERM_WRITE |
            BLK_PERM_GRAPH_MOD,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; speed, creation_flags, NULL,
            NULL, errp);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!s) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; +&nbsp;&nbsp;&nbsp; /*
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * Prevent concurrent jobs trying to modify the graph
            structure here, we
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * already have our own plans. Also don't allow resize
            as the image size is
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * queried only at the job start and then cached.
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            +&nbsp;&nbsp;&nbsp; if (block_job_add_bdrv(&amp;s-&gt;common, &quot;active
            node&quot;, bs,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; basic_flags |
            BLK_PERM_GRAPH_MOD,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; basic_flags | BLK_PERM_WRITE,
            &amp;error_abort)) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Block all intermediate nodes between bs and base,
            because they will
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * disappear from the chain after this operation. The
            streaming job reads
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * every block only once, assuming that it doesn't
            change, so forbid writes
            <br>
            @@ -294,6 +318,9 @@ void stream_start(const char *job_id,
            BlockDriverState *bs,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;base_overlay = base_overlay;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;above_base = above_base;
            <br>
            +&nbsp;&nbsp;&nbsp; s-&gt;cor_filter_bs = cor_filter_bs;
            <br>
            +&nbsp;&nbsp;&nbsp; s-&gt;target_bs = bs;
            <br>
            +&nbsp;&nbsp;&nbsp; s-&gt;base_fmt = base_fmt;
            <br>
          </blockquote>
          <br>
          it's wrong to keep base_fmt during the job, as base may change
          <br>
        </blockquote>
        <br>
        <br>
        So, the format can differ from that of the backing_file_str
        given as the input parameter of the stream_start()...
        <br>
        <br>
        ...while the backing_file_str path is written to the QCOW2
        header on a disk.
        <br>
        <br>
      </blockquote>
      <br>
      Or better, let's try to revert c624b015bf14f and freeze base
      again.
      <br>
    </blockquote>
    <p><br>
    </p>
    <p>The reversion won't help as the patch &quot;stream: Deal with filters&quot;
      did that work already. We have to freeze the base again. I guess
      it will discard the concept of the <span style="color: rgb(32,
        31, 30); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web
        (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,
        system-ui, Roboto, &quot;Helvetica Neue&quot;, sans-serif;
        font-size: 14.6667px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: start; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
        255); text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">'base_overlay'
        and the</span><span style="color: rgb(32, 31, 30); font-family:
        &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;,
        &quot;Segoe UI&quot;, -apple-system, system-ui, Roboto,
        &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;">&nbsp; 'above_base'&nbsp; introduced by Max in
        the series &quot;block: Deal with</span><span style="color: rgb(32,
        31, 30); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web
        (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,
        system-ui, Roboto, &quot;Helvetica Neue&quot;, sans-serif;
        font-size: 14.6667px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: start; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
        255); text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"> filters&quot;.</span></p>
    <p>Andrey<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:b1153a54-96c8-3ddc-e4ee-42c613d02924@virtuozzo.com">
      <br>
      <blockquote type="cite">
        <br>
        <br>
        <blockquote type="cite">
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;backing_file_str =
            g_strdup(backing_file_str);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;bs_read_only = bs_read_only;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;chain_frozen = true;
            <br>
            @@ -307,5 +334,10 @@ fail:
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bs_read_only) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdrv_reopen_set_read_only(bs, true, NULL);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            -&nbsp;&nbsp;&nbsp; bdrv_unfreeze_backing_chain(bs, above_base);
            <br>
            +&nbsp;&nbsp;&nbsp; if (cor_filter_bs) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdrv_unfreeze_backing_chain(cor_filter_bs,
            above_base);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdrv_cor_filter_drop(cor_filter_bs);
            <br>
            +&nbsp;&nbsp;&nbsp; } else {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdrv_unfreeze_backing_chain(bs, above_base);
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; }
            <br>
            diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
            <br>
            index 1cdd7e2..fec9d89 100755
            <br>
            --- a/tests/qemu-iotests/030
            <br>
            +++ b/tests/qemu-iotests/030
            <br>
            @@ -221,60 +221,20 @@ class
            TestParallelOps(iotests.QMPTestCase):
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for img in self.imgs:
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; os.remove(img)
            <br>
          </blockquote>
        </blockquote>
        ...
        <br>
      </blockquote>
      <br>
      <br>
    </blockquote>
  </body>
</html>

--------------8F4C5FAC0111E4C25DAB082B--

