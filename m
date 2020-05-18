Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D870C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B3620756
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="krsVrQ1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B3620756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jafuw-0005A5-GK
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 09:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jafte-0004c5-TZ; Mon, 18 May 2020 09:33:35 -0400
Received: from mail-vi1eur05on2139.outbound.protection.outlook.com
 ([40.107.21.139]:17537 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jafta-0002sV-9a; Mon, 18 May 2020 09:33:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dq5B3VlGNYBkP/kxxU7YitBQiZU/GmwvNuMYZ8MtotrJdxIMhGs9j0gT1ncRf1hklKoHzwHTqdo8kj0bXEJEctt1ufDu3UbZLj5ebxNUaVpvFD94fbvvZgmPfmGPrrZGZoGVKPigzf9mTD4ugomIS5OjxBI7/ox6qM/mkcmczt6AdcfgjoCqNocAtAMr2reGfu7n+PiGkdNduBwYua8BLQqxdVbIgU+e65AbJILeqMf5SGY8G6aaQ+IV7Mnj71iQP8lHSXdO0A6JrbaXXp3lKGxEYxoA9ex7A/FN5ZAkzesg4dMvsIx3coa0Vf3tMuu58vDURm4JatQaLmB9vWjNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmG7msa6LBrmVcOFpknk52Evhs0PosE0JOlBwh3Yssc=;
 b=QDaWhvY3V3mYPTMqyM4TYvPU/+M+VzU02OQ3zFq3x85yzAVWHxVUHujLhlb+HhhoD1Sx0p7S4iuRCI8N+mm58CG+MYHaD5Lrz48x8RTQ30BcZhjkFjK6bbXdGPZ6rJWetwymafXYpX/Pe5jLnIBBLghFhJzNFSdOKB1rhGfQJU1lnalnI/qJ/P3jqoXpsnC4AoAqi7B19dxu7alvl3A+fWf8tvNmj+KALQkWc5XvwsPIjZtQaSAgq7xDoJ8coXzXsNrpil+LoZmAwgVROIHT/+rrwDBxpeKAayGOI7KFtl6UoW67VpkK9g2hFaWMabPC9Y2vhUtFr3hAsiRRSPEFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmG7msa6LBrmVcOFpknk52Evhs0PosE0JOlBwh3Yssc=;
 b=krsVrQ1bruGAXRbfj8Cc+EaeaMSJVkR66JTeBPruCdpGmVU1cr/BfYY0djjFIjAmqHJKHzlXFhW9dpbqWgHhFTDrHcLZI+iipigfLrnz7R75LFxsprDPcNU9YXG+panhSBtA6708a6Ex6mo7ILdPZzedglXZ3MX6oIlArOhlRBs=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB3309.eurprd08.prod.outlook.com (2603:10a6:803:41::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 13:33:24 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 13:33:24 +0000
Subject: Re: [PATCH v4 8/9] qemu-img: Add convert --bitmaps option
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-9-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f3ffd596-5f9f-53a4-b491-e4f166c8bde2@virtuozzo.com>
Date: Mon, 18 May 2020 16:33:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200513011648.166876-9-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::19) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.187) by
 AM0P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26 via Frontend Transport; Mon, 18 May 2020 13:33:24 +0000
X-Originating-IP: [185.215.60.187]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f3d1422-c55d-439a-6fca-08d7fb300a47
X-MS-TrafficTypeDiagnostic: VI1PR08MB3309:
X-Microsoft-Antispam-PRVS: <VI1PR08MB3309121DFA57DCA3FD5FAE25C1B80@VI1PR08MB3309.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZaU78Okwcs92Wfu9tXVc40vG7ukQDhopzE56A0HU9WrFixS9eOyAPGyexGeHtuuWt6yUuzhWsOB4omfbeVRvcIIGIRicXqOhj6TUTdQyeI0XAvtVbBhkOpwQUBh7ift41S5Fi0rgQTVETnZGbVzR5LK4V6Tjv2skzG+CT9oFPxA85ncVuYU8ucer9OGaXr1SxTZhQlG7tyOUq3oIa5h1g+X/ym5+S8UC0pcrSJddI1s0oMAiN0hwhmEd/GYEMw9yUHRc8Pf2WvrPAzmKvoiNY1GAXrIywx5u/KKYc4vqS8VUjtJqUO3ja5HfoaGxSpcLXzB7U6JFTqC9qJHdeD4VqTNy0tzgufGG06UyFkInyYha9yDTDEnsNWaUGtitb8kg4l5xis+yFkT2aY+lYjbyspgIhfuNwisvQU0txT2YrheiG3EtIwVYQiQJLCfQuYAcGPDoRrneNFoX2FXh05jmW55FVxseSERI0v5IhTZr6QbbjKPzhnjBbD+QyxBQCZGnljx/yfl04HeloVVUrlE6gfj1eEa4dUMs+fZsk1BTZi21qDqQxExX3zaxrutUNpDneAP9Cm7JV6NoyddmpBDFBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(39840400004)(396003)(366004)(376002)(31686004)(6486002)(2906002)(5660300002)(16526019)(26005)(186003)(4326008)(66946007)(36756003)(66476007)(66556008)(86362001)(52116002)(31696002)(966005)(478600001)(316002)(16576012)(8936002)(2616005)(8676002)(956004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TZZSgn76l8pWI5ytXg8x8yNbA+2J9nHla5WtdCsG6FWwxTezGZn2rV4k2TQezcZPBt/x9/dNd/GIIz67upqCV9/cFaBpJnXIbVRPoUZp/7wdUG236MJ2rt12VMqzMdR1aoE7kYmEo4YSzJa1ptYyUXBDSXDRWpIgA0jJxQckbFgNJ+wAGjbr1Z0AxbGlsaAPQ9gKR7gjlKCx9S9fn8Q6ygec2Ta1mMQU0k7vBw+bdSUbkICP80G+WnRHspqG9BaZZ0v4xLj8GOKOapftLM6eISshxlWuGta2Q6fghOIzhKzF4NPxtqsJhI4HyEI8JXK1O4SMZ4GSpnM9QdhNVSL8ttQtPB+BSzVCq794F+1uRXi0PAu7zO3DyJzQ5pmsma9Y0mtJIaqjW6Bn4J3FbQgt9pdzq99OC55RW/loI2rOD2GsIr/1SXBCOHGaa5c52KfsII7fZ3LgjbQ/UWEY6iMhmjGvLP3pFxnrcxZPMNs8DdrWKHgBl/KQ2Ig9xwsdfKdq
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3d1422-c55d-439a-6fca-08d7fb300a47
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 13:33:24.8144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/8T8zELFVtdDI/k8qMrpjsi428QyKlDI7ZJOUO6jSBEVQ20j8VFcSLaswAxlhUxYUvuMFEUZtPm3tgrunbFURYd5CippaXKFyqO4i+bSts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3309
Received-SPF: pass client-ip=40.107.21.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 09:33:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.05.2020 04:16, Eric Blake wrote:
> Make it easier to copy all the persistent bitmaps of (the top layer
> of) a source image along with its guest-visible contents, by adding a
> boolean flag for use with qemu-img convert.  This is basically
> shorthand, as the same effect could be accomplished with a series of
> 'qemu-img bitmap --add' and 'qemu-img bitmap --merge -b source'
> commands, or by QMP commands.
> 
> Note that this command will fail in the same scenarios where 'qemu-img
> measure --bitmaps' fails, when either the source or the destanation
> lacks persistent bitmap support altogether.
> 
> See also https://bugzilla.redhat.com/show_bug.cgi?id=1779893
> 
> While touching this, clean up a couple coding issues spotted in the
> same function: an extra blank line, and merging back-to-back 'if
> (!skip_create)' blocks.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   docs/tools/qemu-img.rst |  6 ++-
>   qemu-img.c              | 85 +++++++++++++++++++++++++++++++++++++++--
>   qemu-img-cmds.hx        |  4 +-
>   3 files changed, 89 insertions(+), 6 deletions(-)
> 

[..]

> 
> +static int convert_copy_bitmaps(BlockDriverState *src, BlockDriverState *dst)
> +{
> +    BdrvDirtyBitmap *bm;
> +    Error *err = NULL;
> +    BlockDirtyBitmapMergeSource *merge;
> +    BlockDirtyBitmapMergeSourceList *list;
> +
> +    FOR_EACH_DIRTY_BITMAP(src, bm) {
> +        const char *name;
> +
> +        if (!bdrv_dirty_bitmap_get_persistence(bm)) {
> +            continue;
> +        }
> +        name = bdrv_dirty_bitmap_name(bm);
> +        qmp_block_dirty_bitmap_add(dst->node_name, name,
> +                                   true, bdrv_dirty_bitmap_granularity(bm),
> +                                   true, true,
> +                                   true, !bdrv_dirty_bitmap_enabled(bm),
> +                                   &err);
> +        if (err) {
> +            error_reportf_err(err, "Failed to create bitmap %s: ", name);
> +            return -1;
> +        }
> +
> +        merge = g_new0(BlockDirtyBitmapMergeSource, 1);
> +        merge->type = QTYPE_QDICT;
> +        merge->u.external.node = g_strdup(src->node_name);
> +        merge->u.external.name = g_strdup(name);
> +        list = g_new0(BlockDirtyBitmapMergeSourceList, 1);
> +        list->value = merge;
> +        qmp_block_dirty_bitmap_merge(dst->node_name, name, list, &err);
> +        qapi_free_BlockDirtyBitmapMergeSourceList(list);

^ duplicated code chunk with "case BITMAP_MERGE". Small helper function will not hurt.

> +        if (err) {
> +            error_reportf_err(err, "Failed to populate bitmap %s: ", name);
> +            return -1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>   #define MAX_BUF_SECTORS 32768
> 
>   static int img_convert(int argc, char **argv)
> @@ -2130,6 +2172,8 @@ static int img_convert(int argc, char **argv)
>       int64_t ret = -EINVAL;
>       bool force_share = false;
>       bool explict_min_sparse = false;
> +    bool bitmaps = false;
> +    size_t nbitmaps = 0;
> 
>       ImgConvertState s = (ImgConvertState) {
>           /* Need at least 4k of zeros for sparse detection */
> @@ -2149,6 +2193,7 @@ static int img_convert(int argc, char **argv)
>               {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
>               {"salvage", no_argument, 0, OPTION_SALVAGE},
>               {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
> +            {"bitmaps", no_argument, 0, OPTION_BITMAPS},
>               {0, 0, 0, 0}
>           };
>           c = getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
> @@ -2272,6 +2317,9 @@ static int img_convert(int argc, char **argv)
>                */
>               s.has_zero_init = true;
>               break;
> +        case OPTION_BITMAPS:
> +            bitmaps = true;
> +            break;
>           }
>       }
> 
> @@ -2333,7 +2381,6 @@ static int img_convert(int argc, char **argv)
>           goto fail_getopt;
>       }
> 
> -
>       /* ret is still -EINVAL until here */
>       ret = bdrv_parse_cache_mode(src_cache, &src_flags, &src_writethrough);
>       if (ret < 0) {
> @@ -2493,6 +2540,27 @@ static int img_convert(int argc, char **argv)
>           }
>       }
> 
> +    /* Determine how many bitmaps need copying */
> +    if (bitmaps) {
> +        BdrvDirtyBitmap *bm;
> +
> +        if (s.src_num > 1) {
> +            error_report("Copying bitmaps only possible with single source");
> +            ret = -1;
> +            goto out;
> +        }
> +        if (!bdrv_supports_persistent_dirty_bitmap(blk_bs(s.src[0]))) {
> +            error_report("Source lacks bitmap support");
> +            ret = -1;
> +            goto out;
> +        }
> +        FOR_EACH_DIRTY_BITMAP(blk_bs(s.src[0]), bm) {
> +            if (bdrv_dirty_bitmap_get_persistence(bm)) {

Just note, that we can't have not persistent bitmaps here.. But the check doesn't hurt.

> +                nbitmaps++;
> +            }
> +        }
> +    }
> +
>       /*
>        * The later open call will need any decryption secrets, and
>        * bdrv_create() will purge "opts", so extract them now before
> @@ -2501,9 +2569,7 @@ static int img_convert(int argc, char **argv)
>       if (!skip_create) {
>           open_opts = qdict_new();
>           qemu_opt_foreach(opts, img_add_key_secrets, open_opts, &error_abort);
> -    }
> 
> -    if (!skip_create) {
>           /* Create the new image */
>           ret = bdrv_create(drv, out_filename, opts, &local_err);
>           if (ret < 0) {
> @@ -2541,6 +2607,13 @@ static int img_convert(int argc, char **argv)
>       }
>       out_bs = blk_bs(s.target);
> 
> +    if (nbitmaps > 0 && !bdrv_supports_persistent_dirty_bitmap(out_bs)) {
> +        error_report("Format driver '%s' does not support bitmaps",
> +                     out_fmt);
> +        ret = -1;
> +        goto out;
> +    }
> +
>       if (s.compressed && !block_driver_can_compress(out_bs->drv)) {
>           error_report("Compression not supported for this file format");
>           ret = -1;
> @@ -2600,6 +2673,12 @@ static int img_convert(int argc, char **argv)
>       }
> 
>       ret = convert_do_copy(&s);
> +
> +    /* Now copy the bitmaps */
> +    if (nbitmaps > 0 && ret == 0) {
> +        ret = convert_copy_bitmaps(blk_bs(s.src[0]), out_bs);
> +    }
> +
>   out:
>       if (!ret) {
>           qemu_progress_print(100, 0);
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index bfcd9f32dddf..2791c4f58ddd 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -46,9 +46,9 @@ SRST
>   ERST
> 
>   DEF("convert", img_convert,
> -    "convert [--object objectdef] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
> +    "convert [--object objectdef] [--image-opts] [--target-image-opts] [--target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
>   SRST
> -.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
> +.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
>   ERST
> 
>   DEF("create", img_create,
> 


-- 
Best regards,
Vladimir

