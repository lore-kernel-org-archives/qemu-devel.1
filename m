Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD39C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327F122202
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IAiinn/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327F122202
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQrr-00032q-4J
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXQbz-0008GT-6e; Tue, 27 Oct 2020 11:10:11 -0400
Received: from mail-vi1eur05on2118.outbound.protection.outlook.com
 ([40.107.21.118]:20065 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXQbv-0006Xx-Hr; Tue, 27 Oct 2020 11:10:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXsa4ZQsFEX3bBhFWVzyL3oYbmNYzFnxwuv0xBPzzD0UpTOLDFTnH81LNu24s0GhAnxe1dA5F+TQFKtEa9Xhi3glwheuw+JQLCK6jghzblbr8FfzPf0ktQoaESc9b/KJ6rRpDN2KJSPG/9qlIZlHf8MAKaqDXR0FyZ0XY+kxeOYxATQXql5kfsy9NF3pAsXsF+kT3cpio4yHC68tBmPSLbe7N5in/g4fP5m1DNsEC2eUbqGjzHVSFY4g2qKEQMlwK9XyzWaUPSr1fgsPPctsvQSTIyUj0qmCucSwy4LRiRgXsZJ/+SWT5PACiikolOO0y1aLozS7pSBbBcTzGS9tng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MPvILf9H5XyIVJjQoQKZ0995FMH7oXqQE+bGZnTgBU=;
 b=B/N+TeYadPfeevVjJCc0yLMsL7EDiyhMg7gqlSnzWZoUdci8Zf1pIVLBD02dVdgM6fUFGHY/FeTpQHIGLutTxKV/052zdu4Ee2x9KhUroKPlUpp0CAWJh2qA7PBj1uJlAVZ+GELsrCZ9yljsqr+BdkWSYcoZIGtYASh9TocSyI9Z1DX4ws+JU+vbeDuQJAp9omN4Rcu/lHitgwJRjBC/3fxnuSKguLEZtx9j938+nuDP66uB9UdXERhOzeQTZ8B7OmKjr7lK9+7qd4UWMba6+Bhl9u859do8483Ia3yYOC3XF15Kvc/7vovX/c9AysMMNjLde6Yo4JqZYInmvbW8Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MPvILf9H5XyIVJjQoQKZ0995FMH7oXqQE+bGZnTgBU=;
 b=IAiinn/n+cAC3jTYF+C5ELEG5HVpDBFR9Zq0mhV5gR7gu893eR661tI90SBBfYhgd0i7EmscL6Obh5pMDu77qOgvTUzTKwnEojFaSk467B5nEf6r8EopDQebb92erXK6rGhYVJ2nTHXBaZublQZ6KnlkEDDC7kPGqZjDXSSEilE=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR0802MB2334.eurprd08.prod.outlook.com (2603:10a6:800:9d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Tue, 27 Oct
 2020 15:10:02 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%9]) with mapi id 15.20.3455.037; Tue, 27 Oct 2020
 15:10:01 +0000
Subject: Re: [PATCH v12 13/14] stream: skip filters when writing backing file
 name to QCOW2 header
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-14-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4dadeb14-0744-1cbd-04c5-516ba509cc14@virtuozzo.com>
Date: Tue, 27 Oct 2020 18:09:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <1603390423-980205-14-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.93]
X-ClientProxiedBy: AM0PR10CA0083.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::36) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.93) by
 AM0PR10CA0083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 15:10:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a29200a-01eb-4757-26b6-08d87a8a6086
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2334FFA26EDAEB835C3E99CEC1160@VI1PR0802MB2334.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dyd0doFPjxL5scSbmzcjPpVnw+FKaZXXaDNRKbTCiC7UfduUuyAMUE2Xu1uld8MWy2OQnq6/VKTRdH0TCWutM8DbuqFmlWT8fKmANWhMCgw3/uehQiruDa6yaKH3n9EdCAvccV9tvR6Lq+8s+4DPykSSFPgTQQ2jT3F2RprW1kLHDvV1hGSJwkCpwxozDkbHalDL6E6uyhnPjwUQ06g2NUv3IEvREukFmmuc+LDCykjS2wtIy5vFAPSEvYjOf3w3gwILRFZXaTzqRONhIAwI6F95xYJ0RlXrh423NomrpQMARcFb9f5ymxw7MLjepyIbUs+mSx4wTtnT3+zvTWZEKG7sy5GC6nc59E/dkY2b3VSZ4YR/DekOCWFqPh3Lsff0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39840400004)(2616005)(107886003)(31696002)(36756003)(8676002)(2906002)(86362001)(16526019)(8936002)(6486002)(186003)(31686004)(478600001)(5660300002)(26005)(316002)(83380400001)(4326008)(52116002)(66946007)(66476007)(16576012)(66556008)(956004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: s9oW9Ft09Lmvb8qlF+c09miZiIVcbp6LcU2Uhg78KcrMTW+lWLybHweQtMPP6N+J7sPBT9O6841/Q6FS2FNfCzIk9gn0idbI0AC8xD1HfwXdsyVVm692qy4faWlV92C+ieoiAbVMWzNUdnKeE9G8b8vbx+oEeQ9osEa+HrtKVH9FsIZpaqrv3Pb9F6sAuq5czsIPS4UNgyQHx3vVfHHk/P5AJ7JQZzLdFAD7dnsWF0FNSYuKra2TVNrN8bZnsNFSCriFjMPFDxU+GSmIz4YCZPJIS1TLqJD5RkGKYfIIq4AX+wcy/O8NkhtYIQ89a1S/lN38qx2wGKdv3SIrOJsVDjHumS5RPcWPGnxVlimo8+aqJdk0g1au16pPaHsokUD7zijbNwSEUCaxzxjs+HxHsGgO5vBgwkFCWYk9Y61odf+OBHskDdtQKzPxuOST0Nwl6Vu1uWDAyoSPuo19p3iW0dhgxV2optU+xErxUTrJSyLQOCC44NOd//LylFt5kiRXV5GLBo+uvxTORvAVfgQJiPc0R+zWKSk3W6qodJgE5am3J79IZ48coPuwTHJzEe/NadeOptt8rwlknDeUFcNDuSEDio/3vQh3nDDKBykI6dEAoUiK9AK8J0bp4yfCHRbsIDs/iQV/RuS2z+IBdvkmrQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a29200a-01eb-4757-26b6-08d87a8a6086
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 15:10:01.8018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVlj+3U++glnRvQ5M4pV3BREfNu4ehcie0ePxoqNJ8llUhx4pj5uvMp9UQffw97TSq9yL+60elAgDLXNrPvIuMObGzbEkQmxkz2Cizbw/pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2334
Received-SPF: pass client-ip=40.107.21.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 11:10:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

22.10.2020 21:13, Andrey Shinkevich wrote:
> Avoid writing a filter JSON file name and a filter format name to QCOW2
> image when the backing file is changed after the block stream job.
> A user is still able to assign the 'backing-file' parameter for a
> block-stream job keeping in mind the possible issue mentioned above.
> If the user does not specify the 'backing-file' parameter, QEMU will
> assign it automatically.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/stream.c | 15 +++++++++++++--
>   blockdev.c     |  9 ++-------
>   2 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index e0540ee..1ba74ab 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -65,6 +65,7 @@ static int stream_prepare(Job *job)
>       BlockDriverState *bs = blk_bs(bjob->blk);
>       BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>       BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
> +    BlockDriverState *base_unfiltered = NULL;
>       Error *local_err = NULL;
>       int ret = 0;
>   
> @@ -75,8 +76,18 @@ static int stream_prepare(Job *job)
>           const char *base_id = NULL, *base_fmt = NULL;
>           if (base) {
>               base_id = s->backing_file_str;
> -            if (base->drv) {
> -                base_fmt = base->drv->format_name;
> +            if (base_id) {
> +                if (base->drv) {
> +                    base_fmt = base->drv->format_name;

hmm. this doesn't make real sense: so, we assume that user specified backing_file_str, which may not relate to base, but we use base->drv->format_name? But it may be name of the filter driver, which would be wrong..

Any ideas?

1. we can use base_fmt=NULL, to provoke probing on next open of the qcow2 file..
2. we can do probing now
3. we can at least check, if backing_file_str == base_unfiltered->filename, in this case we can use base_unfiltered->drv->format_name


> +                }
> +            } else {
> +                base_unfiltered = bdrv_skip_filters(base);
> +                if (base_unfiltered) {
> +                    base_id = base_unfiltered->filename;
> +                    if (base_unfiltered->drv) {
> +                        base_fmt = base_unfiltered->drv->format_name;
> +                    }
> +                }
>               }
>           }
>           bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
> diff --git a/blockdev.c b/blockdev.c
> index c917625..0e9c783 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2508,7 +2508,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>       BlockDriverState *base_bs = NULL;
>       AioContext *aio_context;
>       Error *local_err = NULL;
> -    const char *base_name = NULL;
>       int job_flags = JOB_DEFAULT;
>   
>       if (!has_on_error) {
> @@ -2536,7 +2535,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>               goto out;
>           }
>           assert(bdrv_get_aio_context(base_bs) == aio_context);
> -        base_name = base;
>       }
>   
>       if (has_base_node) {
> @@ -2551,7 +2549,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>           }
>           assert(bdrv_get_aio_context(base_bs) == aio_context);
>           bdrv_refresh_filename(base_bs);
> -        base_name = base_bs->filename;
>       }
>   
>       /* Check for op blockers in the whole chain between bs and base */
> @@ -2571,9 +2568,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>           goto out;
>       }
>   
> -    /* backing_file string overrides base bs filename */
> -    base_name = has_backing_file ? backing_file : base_name;
> -
>       if (has_auto_finalize && !auto_finalize) {
>           job_flags |= JOB_MANUAL_FINALIZE;
>       }
> @@ -2581,7 +2575,8 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>           job_flags |= JOB_MANUAL_DISMISS;
>       }
>   
> -    stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
> +    stream_start(has_job_id ? job_id : NULL, bs, base_bs,
> +                 has_backing_file ? backing_file : NULL,

backing_file should be NULL if has_backing_file is false, so you can use just backing_file instead of ternary operator.

>                    job_flags, has_speed ? speed : 0, on_error,
>                    filter_node_name, &local_err);
>       if (local_err) {
> 


-- 
Best regards,
Vladimir

