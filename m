Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4886CC5518A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF53C2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dxO3zfqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF53C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQsDP-0004KV-0E
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQsCh-0003q1-4l
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQsCf-0006GM-H6
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:40:42 -0400
Received: from mail-db8eur05on2101.outbound.protection.outlook.com
 ([40.107.20.101]:22752 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQsCf-0006Bo-4Q; Tue, 21 Apr 2020 08:40:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeSkuuOrGev3xpt1abC58tq6rnUnufqLRfLWUCVbbbu3D0FDEuFLdq/5SEqGYasFhXmShLtV0DMgBBdzbtmCFFsis4lxzsVWMCr9jiPL/8Y9bo5NPYNqE7dw39p4EamWOg/E9Rz87ehGHUWRCw0dvkoYuAzai9yeZvQRszQ1rwKqQVMqk990AdSBW7ZGa0ucBeSFwujXT+ASgJuJZNYB2cHR/bQm727Z4CmfD4QybweWjGoCSEJQSY3T66nV5jWO5XIu1s/HtYkA/qcAPo6pEJtvnynNjHPzcorH6hySQMMrsa/PcddZ3fwaoutz7uLL8ODG24On87TKNswYc8nOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvmAEzOzyXZLQG1pKQS6BDBOkJ1pcXk2wNUcJO4gWS0=;
 b=fH1UNJZZAIcv+Y8vo3aDcm7dHsxgG46IVm8m0dEm4JVyPEcaj8hjVR4H3kUjEd3BcCwrClkNKq5gmkA/gl3AtO/Xi6xOUeVcv3Tm5yYgt4ypu4yeLLakkZbvge9yBJmyBuChVKC0Mrtj8YEspGymVddshfbNgvNofw5zIjKx8obr6T9BxNRtskIBPQS+lboopqbI7w+ocIXeyZejGts6PMwx+GBIpmAuz11XcMMQznvP3h7nW5qrAl/5YZiMq7V5h2gNnpgfvd4YGFNTN3mImFaQt8gFevPJqzrO6l7YzmMLDajCH2ZB3z26VoXmXilaaKACC2NGfG/Z+SKnXIVk6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvmAEzOzyXZLQG1pKQS6BDBOkJ1pcXk2wNUcJO4gWS0=;
 b=dxO3zfquWvUoW06bO7XKDjyEpcdsRaW3pV2iLp5ckdIVNQ2rFieGUXPrNLfiqJmmWS6K7EVPaUOMWji1A+ICG8JbC2z6nEDCCeee5/2r01VSRW/W8aHVE7vwwdUn4M961Qe09YEoOfEr3Ugpayb/14byA9bzBuxD+BmKl912xXQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5352.eurprd08.prod.outlook.com (2603:10a6:20b:10e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 12:40:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 12:40:37 +0000
Subject: Re: [PATCH 5/7] qapi: add filter-node-name to block-stream
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1587407806-109784-6-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421154035947
Message-ID: <926a8377-a5dd-27c6-4532-ad28a72d56d5@virtuozzo.com>
Date: Tue, 21 Apr 2020 15:40:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <1587407806-109784-6-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0082.eurprd07.prod.outlook.com
 (2603:10a6:207:6::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 AM3PR07CA0082.eurprd07.prod.outlook.com (2603:10a6:207:6::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.5 via Frontend Transport; Tue, 21 Apr 2020 12:40:37 +0000
X-Tagtoolbar-Keys: D20200421154035947
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14f4bd61-cdef-4087-ed88-08d7e5f1318e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53523573650D184D3731967EC1D50@AM7PR08MB5352.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(136003)(376002)(346002)(366004)(39850400004)(956004)(26005)(8676002)(186003)(52116002)(107886003)(2616005)(16526019)(86362001)(31696002)(316002)(16576012)(5660300002)(31686004)(6486002)(4326008)(66556008)(66476007)(66946007)(478600001)(8936002)(36756003)(81156014)(2906002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMCcqZkdYUilYPUUIBJ9acZ2/RpqI3CQ7DNL/Po0dmiANyeabnVZTUvhmWIKk3VoSI2vA4eJWVYGjApfQdeXVVhnp8o3m3qroXRABJLYqp/4gkvKOQrSE3gZYT7RIeVLnWHxakhEr+/9rqbXDU3kptbO5ErH3JF4yS4n+WLu0k8w4Oo2l+xIT7rjirwtPhFra0UrzVoDxNiGVpxP2pNHO9dJHoYLwGPHza7hdAE9L9lxgMuDzkx5t8CEukNyLYSILfQgNxJ3t3pUGeX9Nr4Pn1DEvReaSjFCIBd7Sr44kdR/K4kW78SiR/BuOTFYLgO9NIUhwNT17jT94qYZ87s2yVD3I7TvNiDj4xK92tKcLgyfTF5WvXTEmlCCRpFzT3ELIuKKA6aXx6okSwtDjqhLdGKuCgd4qarTokppUFExuSaiyIg3glpv3OZDe8aJinRP
X-MS-Exchange-AntiSpam-MessageData: rMI2tkvVc3MrEZ8TvIQA0bsQUSEonX6eJS0LLQh8pmzqEqiBs6OB9lOXyiv3tS+4414oyx+RujhhvW3qZmdGjjd8RKo7u/MFulGisylDQUtEHI79mBSEfhvy4h1cbMBH/CSDvXT1Ue/NKqkacffLXg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f4bd61-cdef-4087-ed88-08d7e5f1318e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 12:40:37.8340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XSEkaavpOBEHBaC3LsbmlmrKegL8kE8DIktI8Q2H6fi5Iu/0sILvsdiQycbSC5re9KOezZFBQO2rvb/MCWgO3z2qF5KHPCw20hzzSOWweQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5352
Received-SPF: pass client-ip=40.107.20.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 08:40:38
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.101
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
 mreitz@redhat.com, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.04.2020 21:36, Andrey Shinkevich wrote:
> Provide the possibility to pass the 'filter-node-name' parameter to the
> block-stream job as it is done for the commit block job.

So, you add it, but it actually do nothing for now. I'd prefer to make this patch the last one, so it actually make the change.

> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/stream.c            | 5 +++--
>   blockdev.c                | 8 +++++++-
>   include/block/block_int.h | 7 ++++++-
>   monitor/hmp-cmds.c        | 4 ++--
>   qapi/block-core.json      | 6 ++++++
>   5 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index d8b4bbe..fab7923 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -229,7 +229,9 @@ static const BlockJobDriver stream_job_driver = {
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
> @@ -265,7 +267,6 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>       } else {
>           bdrv_unfreeze_chain(bottom_cow_node, above_base);
>       }
> -

extra hunk

>       /* Prevent concurrent jobs trying to modify the graph structure here, we
>        * already have our own plans. Also don't allow resize as the image size is
>        * queried only at the job start and then cached. */
> diff --git a/blockdev.c b/blockdev.c
> index 72d28ce..f275a64 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3242,6 +3242,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>                         bool has_backing_file, const char *backing_file,
>                         bool has_speed, int64_t speed,
>                         bool has_on_error, BlockdevOnError on_error,
> +                      bool has_filter_node_name, const char *filter_node_name,
>                         bool has_auto_finalize, bool auto_finalize,
>                         bool has_auto_dismiss, bool auto_dismiss,
>                         Error **errp)
> @@ -3257,6 +3258,10 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>           on_error = BLOCKDEV_ON_ERROR_REPORT;
>       }
>   
> +    if (!has_filter_node_name) {
> +        filter_node_name = NULL;
> +    }

it is guaranteed to be zeroed in this case, so you don't need to set it

> +
>       bs = bdrv_lookup_bs(device, device, errp);
>       if (!bs) {
>           return;
> @@ -3324,7 +3329,8 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
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
> index 993bafc..5ac4891 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1052,6 +1052,9 @@ int is_windows_drive(const char *filename);
>    *                  See @BlockJobCreateFlags
>    * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
>    * @on_error: The action to take upon error.
> + * @filter_node_name: The node name that should be assigned to the filter
> + * driver that the commit job inserts into the graph above @bs. NULL means
> + * that a node name should be autogenerated.
>    * @errp: Error object.
>    *
>    * Start a streaming operation on @bs.  Clusters that are unallocated
> @@ -1064,7 +1067,9 @@ int is_windows_drive(const char *filename);
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
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 5ca3ebe..0432ac9 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -2044,8 +2044,8 @@ void hmp_block_stream(Monitor *mon, const QDict *qdict)
>   
>       qmp_block_stream(true, device, device, base != NULL, base, false, NULL,
>                        false, NULL, qdict_haskey(qdict, "speed"), speed, true,
> -                     BLOCKDEV_ON_ERROR_REPORT, false, false, false, false,
> -                     &error);
> +                     BLOCKDEV_ON_ERROR_REPORT, false, NULL, false, false,
> +                     false, false, &error);
>   
>       hmp_handle_error(mon, &error);
>   }
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 3c54717..169f8ea 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2552,6 +2552,11 @@
>   #            'stop' and 'enospc' can only be used if the block device
>   #            supports io-status (see BlockInfo).  Since 1.3.
>   #
> +# @filter-node-name: the node name that should be assigned to the
> +#                    filter driver that the stream job inserts into the graph
> +#                    above @device. If this option is not given, a node name is
> +#                    autogenerated. (Since: 5.0)
> +#
>   # @auto-finalize: When false, this job will wait in a PENDING state after it has
>   #                 finished its work, waiting for @block-job-finalize before
>   #                 making any block graph changes.
> @@ -2581,6 +2586,7 @@
>     'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
>               '*base-node': 'str', '*backing-file': 'str', '*speed': 'int',
>               '*on-error': 'BlockdevOnError',
> +            '*filter-node-name': 'str',
>               '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
>   
>   ##
> 


-- 
Best regards,
Vladimir

