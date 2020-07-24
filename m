Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04BEC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DBC0206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="j0QUPT3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBC0206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz21R-0000mt-LJ
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 14:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jz20B-0008Ak-Bo; Fri, 24 Jul 2020 14:00:59 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com
 ([40.107.8.112]:4323 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jz207-0006Vp-3F; Fri, 24 Jul 2020 14:00:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOv+9UCka4x02LtBLDBzdQmwC4jIZCUmT1OgGn+/GShm+G0Zn6FfaqhuXRwgLVVUTC7i6hBKPt+usMgdanJxgvVEkLdnUmT0qpk0Nmi5IT9rZlD0nAgxLmPPTkqfvPKuKqpG05edbSdofNuMo7XfPK7b5wXmEUkirCw4oOBUMGmrjZMfhoezA3EsjqMucpozijGaE76v1jQqVNqFkP/ZOZEaFCXL7n6y88apTfSotNojHZvb6fIX47wYmq58Ox6Us4/NwbAh70ppqk6Z1hSZ6LDfsJktEuPTKu15lfzALwLqQDoNVph47anPJJZmPSJI9jX2FMYLHyFU6tmrqStpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEh50hLg73GVPiibRN3KeqCC/oInQvrbqaBvWBsUXxM=;
 b=jWkMAr2ypryiS8PIcy55ith4wfmGnxU6OMnzrSXzuWGyaCOQpzWEnZINzZm86SRmP6owAYETHrH0plNjw08iand47IFJHaWyOYhgUtZrBCI3kciWfwI6OtgDytQd2evST6DPH0i7kP/wtPS4xpV+kJZRREWecPcGbVwar2W2KXZ139uk83/ee7WX27vHvTa+wxkJhnjOdpHdt+g9rk/1TDtNlHXUu1cLKoUw2ZIpujm1ljbGHw+nYYA9oUlB7d2fRzNQXnn0nQdDB7TT1vSAtoXozjQROVtgiK186M2gZxM8TAQOZrVoHvInRTJWudjKl5gB6ZYXmIc3MBL5DogekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEh50hLg73GVPiibRN3KeqCC/oInQvrbqaBvWBsUXxM=;
 b=j0QUPT3MAO97xX72trV4pYWp8TZo+qDMFc8XOHaY5HF8mEwljaCVGZWKcfRR4w3jxBKrYUqDWc+/WiNS/5pw5HVgp1cBtOfPLfCJz+lR64KPyL/qpqrRXJgXNtNTI94rwRAIOE2mB94zA88a1AcnBtPLeUAgJQxW5Rwe9ebTLT8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 18:00:51 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 18:00:51 +0000
Subject: Re: [PATCH v7 40/47] block: Inline bdrv_co_block_status_from_*()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-41-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <82fdc748-ba0e-39dc-d74e-ffe1c30bedc8@virtuozzo.com>
Date: Fri, 24 Jul 2020 21:00:47 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-41-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR05CA0092.eurprd05.prod.outlook.com
 (2603:10a6:207:1::18) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM3PR05CA0092.eurprd05.prod.outlook.com (2603:10a6:207:1::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 18:00:48 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cec8f057-5b0f-40aa-fd2c-08d82ffb8060
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5448092F9645E721B46C5656F4770@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3eq3zFE2KvcMMGaTFneqqWa21FLSElieblx0kpAvrB5EB9L1YBjMULkzNZC5cQUYLgkiJ11/AlDhPJZtbRDiqqvpJcc4AsjlJJy69Hp7TZtQaztMw12bXZfgNwD2QAPhVhjP7ju81j9koslLh2yH/iLrRKuUeGGUyeBWv3kJCs3RXy6LYxdlTFtoHDTmqiv3mWb+K121BKzGLlxU+RnVOf+Tj+uUC1FcYpU4n8YWWWngosq2f7tumjlU1IwqzFuFXMQydXST9yq0FmjryLyybF4TDj87ud/mWubcO3FOX7gdC1gpf7KVa5lMlXoXqtmAOmBshl35ixnmSBCD9nofnt/K2EBqM6dE/J2vVZCeLU/6Xxxn8HA/NdDh5dnq9Pgj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(366004)(39850400004)(376002)(136003)(31696002)(6512007)(5660300002)(66946007)(4326008)(6506007)(53546011)(31686004)(956004)(2616005)(54906003)(186003)(2906002)(8676002)(26005)(86362001)(36756003)(6486002)(44832011)(52116002)(83380400001)(66476007)(66556008)(8936002)(16526019)(316002)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9eWdPeJZnx03XBpSXtuyvjU3hxynCaXO2+/uNgzfR21eHy8WyPq4y+9KeACfmPsr9ebTzgJsdSjhJtShXih0MduGGsHY+AhXpaHH18WVcBQRolGeE8LvXrWNfX01/LJTq4BKCSrkg8UXV8b/+HPR5FiA4E9TxIrS/YlW1gvFG81bPw1k70qz3vE/SxM3eMNb6paaFLTGCAIY3J/Odam2lbYodqeLP0rtE0DKat+aaP99BRaf5YVHvVXN6vWmZMUjGJKQoQhwD+c83gWfIL/aPYLCjMtqo53GzPiXJ8/7TVd1+OOCmGwLK7IBc0g7yg08qgMlW1T6LxKZibJWha9bTPAsw/96HLDNIDwj1iOqth3fBN2O0EKw5CPE6oAHIkDY6xNdg50iW+0nGRpGQ2VUytmWwrhNXGkapnR+BhjVg2nWJ8v0rbrRNvptJBN5Uoag/GPslybkFAVSDDGYSAwiOu9MYO5AYCo9N3BNGhX0cd2ulfBDgY6ZG1fvlTzxXfTB
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec8f057-5b0f-40aa-fd2c-08d82ffb8060
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 18:00:51.3719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6850UhJyBaReqFmUfMPqSlsaqQDf57w6dpdDEZZuEgVuYnSDHbgPTuZqq2SAUshuMFoDZZg2UGSZpAGo1imsKw5kd3HkU37puIvKugICMHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.8.112;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 14:00:52
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

On 25.06.2020 18:22, Max Reitz wrote:
> With bdrv_filter_bs(), we can easily handle this default filter behavior
> in bdrv_co_block_status().
>
> blkdebug wants to have an additional assertion, so it keeps its own
> implementation, except bdrv_co_block_status_from_file() needs to be
> inlined there.
>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/block/block_int.h | 23 ------------------
>   block/backup-top.c        |  2 --
>   block/blkdebug.c          |  7 ++++--
>   block/blklogwrites.c      |  1 -
>   block/commit.c            |  1 -
>   block/copy-on-read.c      |  2 --
>   block/filter-compress.c   |  2 --
>   block/io.c                | 51 +++++++++++++--------------------------
>   block/mirror.c            |  1 -
>   block/throttle.c          |  1 -
>   10 files changed, 22 insertions(+), 69 deletions(-)
>
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 6e09e15ed4..e5a328c389 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1291,29 +1291,6 @@ void bdrv_default_perms(BlockDriverState *bs, BdrvChild *c,
>                           uint64_t perm, uint64_t shared,
>                           uint64_t *nperm, uint64_t *nshared);
>   
> -/*
> - * Default implementation for drivers to pass bdrv_co_block_status() to
> - * their file.
> - */
> -int coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
> -                                                bool want_zero,
> -                                                int64_t offset,
> -                                                int64_t bytes,
> -                                                int64_t *pnum,
> -                                                int64_t *map,
> -                                                BlockDriverState **file);
> -/*
> - * Default implementation for drivers to pass bdrv_co_block_status() to
> - * their backing file.
> - */
> -int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
> -                                                   bool want_zero,
> -                                                   int64_t offset,
> -                                                   int64_t bytes,
> -                                                   int64_t *pnum,
> -                                                   int64_t *map,
> -                                                   BlockDriverState **file);
> -
>   int64_t bdrv_sum_allocated_file_size(BlockDriverState *bs);
>   int64_t bdrv_primary_allocated_file_size(BlockDriverState *bs);
>   int64_t bdrv_notsup_allocated_file_size(BlockDriverState *bs);
> diff --git a/block/backup-top.c b/block/backup-top.c
> index 89bd3937d0..bf5fc22fc7 100644
> --- a/block/backup-top.c
> +++ b/block/backup-top.c
> @@ -185,8 +185,6 @@ BlockDriver bdrv_backup_top_filter = {
>       .bdrv_co_pwritev_compressed = backup_top_co_pwritev_compressed,
>       .bdrv_co_flush              = backup_top_co_flush,
>   
> -    .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
> -
>       .bdrv_refresh_filename      = backup_top_refresh_filename,
>   
>       .bdrv_child_perm            = backup_top_child_perm,
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index 7194bc7f06..cf78d8809e 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c
> @@ -757,8 +757,11 @@ static int coroutine_fn blkdebug_co_block_status(BlockDriverState *bs,
>           return err;
>       }
>   
> -    return bdrv_co_block_status_from_file(bs, want_zero, offset, bytes,
> -                                          pnum, map, file);
> +    assert(bs->file && bs->file->bs);
> +    *pnum = bytes;
> +    *map = offset;
> +    *file = bs->file->bs;
> +    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
>   }
>   
>   static void blkdebug_close(BlockDriverState *bs)
> diff --git a/block/blklogwrites.c b/block/blklogwrites.c
> index 6753bd9a3e..c6b2711fe5 100644
> --- a/block/blklogwrites.c
> +++ b/block/blklogwrites.c
> @@ -517,7 +517,6 @@ static BlockDriver bdrv_blk_log_writes = {
>       .bdrv_co_pwrite_zeroes  = blk_log_writes_co_pwrite_zeroes,
>       .bdrv_co_flush_to_disk  = blk_log_writes_co_flush_to_disk,
>       .bdrv_co_pdiscard       = blk_log_writes_co_pdiscard,
> -    .bdrv_co_block_status   = bdrv_co_block_status_from_file,
>   
>       .is_filter              = true,
>       .strong_runtime_opts    = blk_log_writes_strong_runtime_opts,
> diff --git a/block/commit.c b/block/commit.c
> index 4122b6736d..ea9282daea 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -238,7 +238,6 @@ static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
>   static BlockDriver bdrv_commit_top = {
>       .format_name                = "commit_top",
>       .bdrv_co_preadv             = bdrv_commit_top_preadv,
> -    .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
>       .bdrv_refresh_filename      = bdrv_commit_top_refresh_filename,
>       .bdrv_child_perm            = bdrv_commit_top_child_perm,
>   
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index a6a864f147..2816e61afe 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -146,8 +146,6 @@ static BlockDriver bdrv_copy_on_read = {
>       .bdrv_eject                         = cor_eject,
>       .bdrv_lock_medium                   = cor_lock_medium,
>   
> -    .bdrv_co_block_status               = bdrv_co_block_status_from_file,
> -
>       .has_variable_length                = true,
>       .is_filter                          = true,
>   };
> diff --git a/block/filter-compress.c b/block/filter-compress.c
> index 8ec1991c1f..5136371bf8 100644
> --- a/block/filter-compress.c
> +++ b/block/filter-compress.c
> @@ -146,8 +146,6 @@ static BlockDriver bdrv_compress = {
>       .bdrv_eject                         = compress_eject,
>       .bdrv_lock_medium                   = compress_lock_medium,
>   
> -    .bdrv_co_block_status               = bdrv_co_block_status_from_file,
> -
>       .has_variable_length                = true,
>       .is_filter                          = true,
>   };
> diff --git a/block/io.c b/block/io.c
> index 9e802804bb..e2196d438c 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2253,36 +2253,6 @@ typedef struct BdrvCoBlockStatusData {
>       BlockDriverState **file;
>   } BdrvCoBlockStatusData;
>   
> -int coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
> -                                                bool want_zero,
> -                                                int64_t offset,
> -                                                int64_t bytes,
> -                                                int64_t *pnum,
> -                                                int64_t *map,
> -                                                BlockDriverState **file)
> -{
> -    assert(bs->file && bs->file->bs);
> -    *pnum = bytes;
> -    *map = offset;
> -    *file = bs->file->bs;
> -    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
> -}
> -
> -int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
> -                                                   bool want_zero,
> -                                                   int64_t offset,
> -                                                   int64_t bytes,
> -                                                   int64_t *pnum,
> -                                                   int64_t *map,
> -                                                   BlockDriverState **file)
> -{
> -    assert(bs->backing && bs->backing->bs);
> -    *pnum = bytes;
> -    *map = offset;
> -    *file = bs->backing->bs;
> -    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
> -}
> -
>   /*
>    * Returns the allocation status of the specified sectors.
>    * Drivers not implementing the functionality are assumed to not support
> @@ -2323,6 +2293,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
>       BlockDriverState *local_file = NULL;
>       int64_t aligned_offset, aligned_bytes;
>       uint32_t align;
> +    bool has_filtered_child;
>   
>       assert(pnum);
>       *pnum = 0;
> @@ -2348,7 +2319,8 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
>   
>       /* Must be non-NULL or bdrv_getlength() would have failed */
>       assert(bs->drv);
> -    if (!bs->drv->bdrv_co_block_status) {
> +    has_filtered_child = bdrv_filter_child(bs);
> +    if (!bs->drv->bdrv_co_block_status && !has_filtered_child) {
>           *pnum = bytes;
>           ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
>           if (offset + bytes == total_size) {
> @@ -2369,9 +2341,20 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
>       aligned_offset = QEMU_ALIGN_DOWN(offset, align);
>       aligned_bytes = ROUND_UP(offset + bytes, align) - aligned_offset;
>   
> -    ret = bs->drv->bdrv_co_block_status(bs, want_zero, aligned_offset,
> -                                        aligned_bytes, pnum, &local_map,
> -                                        &local_file);
> +    if (bs->drv->bdrv_co_block_status) {
> +        ret = bs->drv->bdrv_co_block_status(bs, want_zero, aligned_offset,
> +                                            aligned_bytes, pnum, &local_map,
> +                                            &local_file);
> +    } else {
> +        /* Default code for filters */
> +
> +        local_file = bdrv_filter_bs(bs);
> +        assert(local_file);
> +
> +        *pnum = aligned_bytes;
> +        local_map = aligned_offset;
> +        ret = BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
> +    }
>       if (ret < 0) {
>           *pnum = 0;
>           goto out;
> diff --git a/block/mirror.c b/block/mirror.c
> index 770de3b34e..5a9e42e488 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1541,7 +1541,6 @@ static BlockDriver bdrv_mirror_top = {
>       .bdrv_co_pdiscard           = bdrv_mirror_top_pdiscard,
>       .bdrv_co_pwritev_compressed = bdrv_mirror_top_pwritev_compressed,
>       .bdrv_co_flush              = bdrv_mirror_top_flush,
> -    .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
>       .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
>       .bdrv_child_perm            = bdrv_mirror_top_child_perm,
>   
> diff --git a/block/throttle.c b/block/throttle.c
> index f6e619aca2..473ea758df 100644
> --- a/block/throttle.c
> +++ b/block/throttle.c
> @@ -263,7 +263,6 @@ static BlockDriver bdrv_throttle = {
>       .bdrv_reopen_prepare                =   throttle_reopen_prepare,
>       .bdrv_reopen_commit                 =   throttle_reopen_commit,
>       .bdrv_reopen_abort                  =   throttle_reopen_abort,
> -    .bdrv_co_block_status               =   bdrv_co_block_status_from_file,
>   
>       .bdrv_co_drain_begin                =   throttle_co_drain_begin,
>       .bdrv_co_drain_end                  =   throttle_co_drain_end,


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



