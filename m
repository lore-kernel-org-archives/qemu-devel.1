Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B92DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9244207FB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nhqtsZbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9244207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8LMk-0005Gd-15
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 06:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8LLy-0004jT-2o; Wed, 19 Aug 2020 06:29:58 -0400
Received: from mail-vi1eur05on2122.outbound.protection.outlook.com
 ([40.107.21.122]:65153 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8LLu-000116-Vp; Wed, 19 Aug 2020 06:29:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmSiYTV0noFrBp2DbdVDIrGkptqzdSpKWSrsmN/MipS3PcnQBo3nWJ4Xd0zPmGVEq9IJ9oRnUJW0+VSTwXQX/2hmlIb76pmvNxluLqx7RHt/LU2T+gEJDb4UypJypbncOYoAVV2uASqsomOAV7isUYLxO1Qxf4nRvvstEjQ7KnpenMhS2Pdqyf1HcIKvwbdnjM9NONzzy1WKCDQrD6j5qXR7ba09F2Kn+EvG599P04HptYQptAlkj2C/grS1cch3M39pxJsJPagtRXaxzm8o5LsNxove0d4skkVBSSOD2E5xPwfqjiNPb2NUfbyeJvl5Gsa1ztQg3rtSJGRzOei+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWIj17QYk84/wSIMXrnFuP88uF+xegxLavfX3SHAWmg=;
 b=jTFd/qpj2K1DtV5dbK3HIpc+8hCjJAOzd13Ursg6reNNFV2BMTVDSXGi+JYx7n9E3J3Qzh5J4SVfjS3UY/g9qJ6Qz31mKgl9i3DN02CUCEJ/QQS1M++KkffCTqOs3zDxLWkwYAaDkLSa2uxY69oZyPQZXqiV4gpn6qYgqBmYVM4ArRa+UDG96eHBiYSIxNda9EHGRwoSBRQW8qtOB84wGVmRdEpPg5sa1asSeWa5FYFem8FwpKQD+6Cr5q2f/FH3It9E1R/lLkhOcevTwydU5uxE1J420x+yR6lwbn3Sn4Ac1s59L/R0sWhLqQT+RaSmgNPeNaRlZPNUPdfKk86nNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWIj17QYk84/wSIMXrnFuP88uF+xegxLavfX3SHAWmg=;
 b=nhqtsZbOtrkq2zz10r6g6T7im7boua4ZT/TqReePdwVBXpRD78lxYjO5dej139LGPI0aKGWcRVjDdGE5to2TKT0pJXk8+1BWVR2UY4PqMEu07ZyBZCJzTFnFc0hznuROHhNcMTkSvRL9RmxiVE8x0Tu2dGdjJqtBxX5Sd4DCB7o=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2982.eurprd08.prod.outlook.com (2603:10a6:209:43::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 19 Aug
 2020 10:29:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Wed, 19 Aug 2020
 10:29:48 +0000
Subject: Re: [PATCH v6 3/4] qapi: add filter-node-name to block-stream
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1597785880-431103-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1597785880-431103-4-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d49840c1-cdf2-37ba-4ca3-e81dfb039958@virtuozzo.com>
Date: Wed, 19 Aug 2020 13:29:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <1597785880-431103-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0087.eurprd05.prod.outlook.com
 (2603:10a6:207:1::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM3PR05CA0087.eurprd05.prod.outlook.com (2603:10a6:207:1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.18 via Frontend Transport; Wed, 19 Aug 2020 10:29:47 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fae7894b-2304-47ac-5950-08d8442acc8e
X-MS-TrafficTypeDiagnostic: AM6PR08MB2982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB2982784C0EF95136BB9241E9C15D0@AM6PR08MB2982.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W0lkfOPaOmbhaUU4NHmWkkwdAskQixPdkqtjZNsejUbHvn5HF54FIrlUgwYxTtayOEB+xDPHot6mUBk7XTcVLNuBkhTiO3w9AT/Y36LX03d46CHX0X5+6+esgsrOFAeL6kUO0U2jA6IFr3EHiMBaRFp9v4odjc2Cr8NsPcVKs2uCRgUKbTgFSp+nOQEHlV2+njqM5+2JRwurYGxwItGcM/pbteHBKTPtmaRI6FYiOjSuHx7JBnHEn+x3CtaqHPclwMz+6nMqdxy8c1kQurjMYMbbPEEqYkgENtJX47pf5wrTciUle5KGjTRdd2QU0kbnrhGHwxJjZVO2whbEBqOT8vFugpyBl3ljdiDA5nClV6cyz+aAAAQ5hH46783Fgk21
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39840400004)(396003)(346002)(366004)(376002)(4326008)(36756003)(86362001)(478600001)(5660300002)(6486002)(31686004)(66476007)(66556008)(66946007)(316002)(26005)(16576012)(2906002)(8676002)(186003)(16526019)(107886003)(52116002)(31696002)(2616005)(8936002)(956004)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qamUcSC9G93dgIdcNFbOgROQkeKJf6I9d7lJNmphF5mpsoMPpr0HSIOn2DN5QEDXXUfg9wv4c5Z8N3F871jsXgpa8xl+VgA5BbIuUcuPrKudUuwoTwioN6mirg0y7XItqTnb90m+7TAFa+HWXdKcbSfpLhjdoDtKgYZwkBE2g2JByBUaHPyM/Dzq7NxxLgpSyRMV1tBtcYS02PtVGnlYou8qbxYzj0L0v4JZfmdfvcqmXNP8AEtzKWRsBcEoZF9Q4kjssaqIVDBgrc0Xkrr2gqMUfxoLpeN+bsuzoq0nv+PD3i7BNt72t9+MpFCFemThv0Ch5tq3w0vfO7T7WScpscrBhEb0N0FxPGWNzsQNYNrFjXh5HjglsuEDTR8HCzLUmukrEUsBZzF4s7OT43x7j0GmCGXkfWiv9NP+isgZrD3V3EuSw1rhErlSq9Kvnb80auxskuhFOJu+ImFrwlggoOz4GzMxPZq0Wsopn46liBxFeZNzzjPxgBEbl6FXwHmFOwQSQdUOWdyiwptMVTUuzMr6EXEJ1uPGEMnoxkbo40v6mwKfbODdshel4h1/QKxDYDaQGHLO4aDyOQ8TLPN/UKqg2WYYMON75ntyQEw+M55KBfaGJGJZj0ejstiwT+teuIS+D3oWt1lSCenDZijQhA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae7894b-2304-47ac-5950-08d8442acc8e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 10:29:48.6321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyoA2fe1KQDZR9/QywXBeN7By60b0fgTBmULcP8k6BvYgM6rqQ8vw8Ifz6rAtLlTnPTgx3IBS+/1kjbNmrd0f5EGVUbPdAn7Mru9UPfh2O4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2982
Received-SPF: pass client-ip=40.107.21.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 06:29:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.08.2020 00:24, Andrey Shinkevich wrote:
> Provide the possibility to pass the 'filter-node-name' parameter to the
> block-stream job as it is done for the commit block job. That will be
> needed for further iotests implementations.

and for users as well. I think, the last sentence may be dropped.

> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/monitor/block-hmp-cmds.c | 4 ++--
>   block/stream.c                 | 4 +++-
>   blockdev.c                     | 8 +++++++-
>   include/block/block_int.h      | 7 ++++++-
>   qapi/block-core.json           | 6 ++++++
>   5 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> index 4d3db5e..4e66775 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -507,8 +507,8 @@ void hmp_block_stream(Monitor *mon, const QDict *qdict)
>   
>       qmp_block_stream(true, device, device, base != NULL, base, false, NULL,
>                        false, NULL, qdict_haskey(qdict, "speed"), speed, true,
> -                     BLOCKDEV_ON_ERROR_REPORT, false, false, false, false,
> -                     &error);
> +                     BLOCKDEV_ON_ERROR_REPORT, false, NULL, false, false, false,
> +                     false, &error);
>   
>       hmp_handle_error(mon, error);
>   }
> diff --git a/block/stream.c b/block/stream.c
> index b9c1141..8bf6b6d 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -221,7 +221,9 @@ static const BlockJobDriver stream_job_driver = {
>   void stream_start(const char *job_id, BlockDriverState *bs,
>                     BlockDriverState *base, const char *backing_file_str,
>                     int creation_flags, int64_t speed,
> -                  BlockdevOnError on_error, Error **errp)
> +                  BlockdevOnError on_error,
> +                  const char *filter_node_name,
> +                  Error **errp)
>   {
>       StreamBlockJob *s;
>       BlockDriverState *iter;
> diff --git a/blockdev.c b/blockdev.c
> index 237fffb..800ecb3 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2476,6 +2476,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>                         bool has_backing_file, const char *backing_file,
>                         bool has_speed, int64_t speed,
>                         bool has_on_error, BlockdevOnError on_error,
> +                      bool has_filter_node_name, const char *filter_node_name,
>                         bool has_auto_finalize, bool auto_finalize,
>                         bool has_auto_dismiss, bool auto_dismiss,
>                         Error **errp)
> @@ -2491,6 +2492,10 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>           on_error = BLOCKDEV_ON_ERROR_REPORT;
>       }
>   
> +    if (!has_filter_node_name) {
> +        filter_node_name = NULL;
> +    }

this works automatically, you don't need to initialize it by hand

> +
>       bs = bdrv_lookup_bs(device, device, errp);
>       if (!bs) {
>           return;
> @@ -2558,7 +2563,8 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>       }
>   
>       stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
> -                 job_flags, has_speed ? speed : 0, on_error, &local_err);
> +                 job_flags, has_speed ? speed : 0, on_error,
> +                 filter_node_name, &local_err);
>       if (local_err) {
>           error_propagate(errp, local_err);
>           goto out;
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 465a601..3efde33 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1122,6 +1122,9 @@ int is_windows_drive(const char *filename);
>    *                  See @BlockJobCreateFlags
>    * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
>    * @on_error: The action to take upon error.
> + * @filter_node_name: The node name that should be assigned to the filter
> + * driver that the commit job inserts into the graph above @bs. NULL means
> + * that a node name should be autogenerated.
>    * @errp: Error object.
>    *
>    * Start a streaming operation on @bs.  Clusters that are unallocated
> @@ -1134,7 +1137,9 @@ int is_windows_drive(const char *filename);
>   void stream_start(const char *job_id, BlockDriverState *bs,
>                     BlockDriverState *base, const char *backing_file_str,
>                     int creation_flags, int64_t speed,
> -                  BlockdevOnError on_error, Error **errp);
> +                  BlockdevOnError on_error,
> +                  const char *filter_node_name,
> +                  Error **errp);
>   
>   /**
>    * commit_start:
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0b8ccd3..1db6ce1 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2524,6 +2524,11 @@
>   #            'stop' and 'enospc' can only be used if the block device
>   #            supports io-status (see BlockInfo).  Since 1.3.
>   #
> +# @filter-node-name: the node name that should be assigned to the
> +#                    filter driver that the stream job inserts into the graph
> +#                    above @device. If this option is not given, a node name is
> +#                    autogenerated. (Since: 5.1)
> +#
>   # @auto-finalize: When false, this job will wait in a PENDING state after it has
>   #                 finished its work, waiting for @block-job-finalize before
>   #                 making any block graph changes.
> @@ -2554,6 +2559,7 @@
>     'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
>               '*base-node': 'str', '*backing-file': 'str', '*speed': 'int',
>               '*on-error': 'BlockdevOnError',
> +            '*filter-node-name': 'str',
>               '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
>   
>   ##
> 


With extra "filter_node_name = NULL" dropped:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

