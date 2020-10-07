Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1072AC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9E920870
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CxUXzPXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9E920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ6a8-0003eD-09
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQ6ZJ-00039F-85; Wed, 07 Oct 2020 06:21:09 -0400
Received: from mail-db8eur05on2105.outbound.protection.outlook.com
 ([40.107.20.105]:64736 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQ6ZH-0006M0-44; Wed, 07 Oct 2020 06:21:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8mgbTNgfs+Gf6F0Hd+uj9V7DCwXc1hxDV3OPp1pa5Ad9brnJq+/FJuCRd0fyDTxHCYpRmO2k9wwsbfozCrlHS4qlM5zAMIB9LubUNuQ5rW0yYeQfcmO+tmB+QvnvHDwIR3p0zHT52gALS1LJhEi/kkx7kq9537pgf51zDgkbHpMZDxzA6ud4oiM/Tozx2mrfxPXkcSg7Zu086DmgGPN6zCQnfm85+GbDcDQU1CJcTJprJ34F1svKuKroh8lLQ8nTbX6SEtjyNKUOWkQTZ1dJqPLvRZkPCS3FM5UNYJ0Zmm8kz2qcimVdmz73tL/U+77798GMW7T8198zQFszJGOgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkBj/KbodUoTgWA1QR8ol1zRFLLG6fLZL9GYjs4AQ4w=;
 b=R6l4Zel9ockpDmwQFcO72pZu0bPhOobkf/hzxXK53sXQ4kd5J6HjqGDLPU7XZCiEcRHq0ijnqfTTg9Yz7ZfI5CllzHcY5gJGV2Pm/GgP8+kes83R66AygfP1jI8LTRHmeuGqYxa5PLn9UVGSdGarlzXLRoy9Qk7B5MhwUv1hdaX5pfsFo/KSbYRdbtfa4+kekuUAj/9/n4dcGi4TcWs8FtSdRM6Wwf3MmiLD0LJ/fBkKXolZH6vJTt7WztI4RrhDG7XgCHYvOwbHWBF48aF6EFOutye7TiPtfdq/nOwanSm+Rv31wztPcuOGPahYekdWjAf9CzCZ2sOy1QUA25KTqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkBj/KbodUoTgWA1QR8ol1zRFLLG6fLZL9GYjs4AQ4w=;
 b=CxUXzPXmBXzm4duW6n14qteNYdbLvvfCnhDeeN65RGJQS6HvER34PfF4eo/U4ftXnYXXe2pSkejIkLF9WIji2JZ/KbEiruJz1KY4tNgNnkSrpJvTa8ubOLl2L2OteHtTlJHqCY9LUK9Rj7W5+g017Ut0vo15UbUn8dUxFGlK9p8=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1649.eurprd08.prod.outlook.com (2603:10a6:203:38::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 10:21:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 10:21:03 +0000
Subject: Re: [PATCH v10 8/9] block: remove unused backing-file name parameter
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1601383109-110988-9-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7944f050-1158-bda7-a3f9-c90001322599@virtuozzo.com>
Date: Wed, 7 Oct 2020 13:21:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <1601383109-110988-9-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.87]
X-ClientProxiedBy: AM0PR02CA0018.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.87) by
 AM0PR02CA0018.eurprd02.prod.outlook.com (2603:10a6:208:3e::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 10:21:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 263eba96-f904-448a-1215-08d86aaab1d4
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1649:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1649007FCD78C6D282579DFBC10A0@AM5PR0801MB1649.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mJu+OpaCzVVrJw8q9iyu0+zE5m3bACL6v7eLAL9Y8R5zkH+MNppeIlDqLZ8zvctDdsoTOhCLc74Iod/BZEjmDIDpvHUqpLhlz39GRsxDMNDwSi0KDwocRZYo4rTeFX0DABqWofAZdTCxvJH7vMSxVOEf635C/CWSE09Ws0TNuWiXQKwZ805vZrDByTitsIq2Lkl2XryC7lZ8fbuIC6XLLfFSQUQCuwZH6eHZ7Bg4tlEqKRameNaC88UgOh+okAZtCo9rYS7rOJn5bwQDCXecGgQY+ghS1vzJBiljAkLY1rJKUuV+Ct2hyfjDjrvVEnkW3swGicBzF7Cuz67FuqUP9E2dxwLhf5D9DLwpBVhq+C6frSWPHUe2o4jtAbCecxH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(376002)(346002)(396003)(366004)(136003)(16526019)(186003)(5660300002)(31696002)(8936002)(26005)(83380400001)(36756003)(86362001)(2906002)(478600001)(52116002)(6486002)(316002)(4326008)(66476007)(66556008)(31686004)(2616005)(66946007)(16576012)(8676002)(107886003)(956004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JRs5LxBFlcf8goGK/QsOD+CIuQKLZ/+GP9xat3aaLbyzRVOJXd80eGk7p+0YRCBliI/WdQ1S5dbAn4pp945TgR8PzVKUPdV1Dr/UINxopLyVYi+a2AhA7EVUy0nu+B2MbzERMhPXSAfOQIl1h4a4x4K9eb/zCAuC/I9xJkAjGLSsf7Funh+MMJGya/Vy3YiOIkw3DQntxDfjenX3ETfjePizFR7OMLCpdbnGdN29quHFmWSEEghsftl752pnIWysuzu+OSicn2H2AkGL1sB+vzyxmM3yVnsnCelQE1bYC72Sw3Iy1qbNL54KdEwOCjT7lQUfhQ0YUnrYcb+TtjPEtl40DDGV+aGsbEHXB/Zb4gBv+zu7cc6k1hoeKcvex5Qzft49EBJ1MCCbp58U8u12qVWf+ZFGb0nH4TcmANmfPlXbZ/cSfP7WuKlnztpZv7DHKHrIO9Jt7ZfMiLDSUFGIIJC8MMcXaOz0ENDqwi54+O8eRHQjtSObsp1LuIkg8aRzpoVWgIT2Tb3t9W2TeCeLbXNKvaI94tV7BTKspJpxhhWCed+mZKtM4UzPxraQfKYgYMHq/pdaP8Gd7XEXc3vsbkl5ciUWOeYBv4WFnHdroKrPWxgSce3uK1Nm7B2tyo4eS5rrhvF6BGEfX15JCYLRkA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263eba96-f904-448a-1215-08d86aaab1d4
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 10:21:03.4420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYYJ2DmAOg9dJFyq2AnWDTFMsb/aYqupGJXxW3xK2iXg8YQTe2G7KjaFhcE07IVOGv94uMXi8DCa6VXhZ2077J1DIhuRmEH+a7Wxg7wuefE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1649
Received-SPF: pass client-ip=40.107.20.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 06:21:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

29.09.2020 15:38, Andrey Shinkevich wrote:
> The block stream QMP parameter backing-file is in use no more. It
> designates a backing file name to set in QCOW2 image header after the
> block stream job finished. The base file name is used instead.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

We can't just remove it without a deprecation period of three releases.

So actually, in a previous patch, we should implement new behavior for
automatic backing-file detection if this parameter is unspecified. Amd
keep old behavior for backing-file-name if it is given.

Hmm. Or, probably, we can use direct base for base-filename? And in cases
when we should skip filters (for example of parallel jobs) user should
specify backing-file explicitly?

> ---
>   block/monitor/block-hmp-cmds.c |  2 +-
>   block/stream.c                 |  6 +-----
>   blockdev.c                     | 17 +----------------
>   include/block/block_int.h      |  2 +-
>   qapi/block-core.json           | 17 +----------------
>   5 files changed, 5 insertions(+), 39 deletions(-)
> 
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> index 4e66775..5f19499 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -506,7 +506,7 @@ void hmp_block_stream(Monitor *mon, const QDict *qdict)
>       int64_t speed = qdict_get_try_int(qdict, "speed", 0);
>   
>       qmp_block_stream(true, device, device, base != NULL, base, false, NULL,
> -                     false, NULL, qdict_haskey(qdict, "speed"), speed, true,
> +                     qdict_haskey(qdict, "speed"), speed, true,
>                        BLOCKDEV_ON_ERROR_REPORT, false, NULL, false, false, false,
>                        false, &error);
>   
> diff --git a/block/stream.c b/block/stream.c
> index b0719e9..fe2663f 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -34,7 +34,6 @@ typedef struct StreamBlockJob {
>       BlockDriverState *base_overlay; /* COW overlay (stream from this) */
>       BlockDriverState *above_base;   /* Node directly above the base */
>       BlockdevOnError on_error;
> -    char *backing_file_str;
>       bool bs_read_only;
>       bool chain_frozen;
>   } StreamBlockJob;
> @@ -103,8 +102,6 @@ static void stream_clean(Job *job)
>           blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
>           bdrv_reopen_set_read_only(bs, true, NULL);
>       }
> -
> -    g_free(s->backing_file_str);
>   }
>   
>   static int coroutine_fn stream_run(Job *job, Error **errp)
> @@ -220,7 +217,7 @@ static const BlockJobDriver stream_job_driver = {
>   };
>   
>   void stream_start(const char *job_id, BlockDriverState *bs,
> -                  BlockDriverState *base, const char *backing_file_str,
> +                  BlockDriverState *base,
>                     int creation_flags, int64_t speed,
>                     BlockdevOnError on_error,
>                     const char *filter_node_name,
> @@ -295,7 +292,6 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>   
>       s->base_overlay = base_overlay;
>       s->above_base = above_base;
> -    s->backing_file_str = g_strdup(backing_file_str);
>       s->bs_read_only = bs_read_only;
>       s->chain_frozen = true;
>   
> diff --git a/blockdev.c b/blockdev.c
> index d719c47..b223601 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2486,7 +2486,6 @@ out:
>   void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>                         bool has_base, const char *base,
>                         bool has_base_node, const char *base_node,
> -                      bool has_backing_file, const char *backing_file,
>                         bool has_speed, int64_t speed,
>                         bool has_on_error, BlockdevOnError on_error,
>                         bool has_filter_node_name, const char *filter_node_name,
> @@ -2498,7 +2497,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>       BlockDriverState *base_bs = NULL;
>       AioContext *aio_context;
>       Error *local_err = NULL;
> -    const char *base_name = NULL;
>       int job_flags = JOB_DEFAULT;
>   
>       if (!has_on_error) {
> @@ -2526,7 +2524,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>               goto out;
>           }
>           assert(bdrv_get_aio_context(base_bs) == aio_context);
> -        base_name = base;
>       }
>   
>       if (has_base_node) {
> @@ -2541,7 +2538,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>           }
>           assert(bdrv_get_aio_context(base_bs) == aio_context);
>           bdrv_refresh_filename(base_bs);
> -        base_name = base_bs->filename;
>       }
>   
>       /* Check for op blockers in the whole chain between bs and base */
> @@ -2553,17 +2549,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>           }
>       }
>   
> -    /* if we are streaming the entire chain, the result will have no backing
> -     * file, and specifying one is therefore an error */
> -    if (base_bs == NULL && has_backing_file) {
> -        error_setg(errp, "backing file specified, but streaming the "
> -                         "entire chain");
> -        goto out;
> -    }
> -
> -    /* backing_file string overrides base bs filename */
> -    base_name = has_backing_file ? backing_file : base_name;
> -
>       if (has_auto_finalize && !auto_finalize) {
>           job_flags |= JOB_MANUAL_FINALIZE;
>       }
> @@ -2571,7 +2556,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>           job_flags |= JOB_MANUAL_DISMISS;
>       }
>   
> -    stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
> +    stream_start(has_job_id ? job_id : NULL, bs, base_bs,
>                    job_flags, has_speed ? speed : 0, on_error,
>                    filter_node_name, &local_err);
>       if (local_err) {
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index f782737..bbe2ee6 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1147,7 +1147,7 @@ int is_windows_drive(const char *filename);
>    * BlockDriverState.
>    */
>   void stream_start(const char *job_id, BlockDriverState *bs,
> -                  BlockDriverState *base, const char *backing_file_str,
> +                  BlockDriverState *base,
>                     int creation_flags, int64_t speed,
>                     BlockdevOnError on_error,
>                     const char *filter_node_name,
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 32fb097..6358606 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2512,21 +2512,6 @@
>   # @base-node: the node name of the backing file.
>   #             It cannot be set if @base is also set. (Since 2.8)
>   #
> -# @backing-file: The backing file string to write into the top
> -#                image. This filename is not validated.
> -#
> -#                If a pathname string is such that it cannot be
> -#                resolved by QEMU, that means that subsequent QMP or
> -#                HMP commands must use node-names for the image in
> -#                question, as filename lookup methods will fail.
> -#
> -#                If not specified, QEMU will automatically determine
> -#                the backing file string to use, or error out if there
> -#                is no obvious choice.  Care should be taken when
> -#                specifying the string, to specify a valid filename or
> -#                protocol.
> -#                (Since 2.1)
> -#
>   # @speed: the maximum speed, in bytes per second
>   #
>   # @on-error: the action to take on an error (default report).
> @@ -2566,7 +2551,7 @@
>   ##
>   { 'command': 'block-stream',
>     'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
> -            '*base-node': 'str', '*backing-file': 'str', '*speed': 'int',
> +            '*base-node': 'str', '*speed': 'int',
>               '*on-error': 'BlockdevOnError',
>               '*filter-node-name': 'str',
>               '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
> 


-- 
Best regards,
Vladimir

