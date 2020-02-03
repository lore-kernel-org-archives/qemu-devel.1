Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09A7C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7142087E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oZlX7GJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7142087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygLp-0002CM-U1
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iygKg-0000pZ-TW
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:20:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iygKf-0003PU-BV
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:20:26 -0500
Received: from mail-eopbgr40103.outbound.protection.outlook.com
 ([40.107.4.103]:62081 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iygKa-00038B-LX; Mon, 03 Feb 2020 13:20:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1GXSGp0gn9KYFtXr5xh6lB8xwzgY2mKFmQJ0Brt8PZ5xyjga2wRMB0Z8z/qgSTRj67QU2T++EMsbglL71hOW17wBJmZgPlAa5nGXtajtXXOb6TEdOkd/8Hm1xGd0STQraxnX2sgLAXXPYjGIzoCZk3/1fwTAAf5ZemeMpS2vvdV6cVaiTiS3vxoZadtl9xL622K3u7TumnHfICqzVGfuewImzPd5we553YZkRneLkoTiV3iYZAeP7buRfH+bP9IQLL4cEmbfiZXX1x1Gxubv0Npy59a+XrR7zJ/f3tnfvNj0cF5mrEVuUjLnbj/JDKr+1ZLM4IB6lMPEYqz2R81Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNs3hZteGTdqoqaJM39dIYRWFeCSWLBybj6Um2IelHE=;
 b=cJ8TaWqd3e5fZA7iPNjij5bEELAqmPF4b4T/alO3oaz5Zceb5TMIedk9UiCw3XlgR++HLE3itHC4GPbCW/lu6giiU2/Js6AEKeAOvbKty8tFMzHxgBG8k2o/hPpdeB4JN7psWdDu8eA43EqfECy2UTCWeUHcHHC/2PrrZSqC82m0VtMpYGYZX6G0zNANfKwy3KR4oNDEG0h2kxiQQItHuDC3oYj0g93i704XREFDFyIExkuH6YXT9cO88dAdKsTm47TkbhBc7n9oOpF/GOgvgwEFUUEr0hItGAvJ4yX7kjAu96mqJF0HBR0dT4qaHfHi2xC3+iJ1PogAndNQLGU4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNs3hZteGTdqoqaJM39dIYRWFeCSWLBybj6Um2IelHE=;
 b=oZlX7GJ2punoec5cd6/Aod98+Q2uJjmONKIVRiSj/LGU5e46lymFdltHYAEMSKp2+FYRaRMlOkc57HUZr6l3reECX+4IVA13mc8M9Wu0+o6zNYQfUb0b6ZlO6Zl4489drd5E5BTNvMfLptCFKHT3kQN4eijoLWDzyak5LXiWinU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3655.eurprd08.prod.outlook.com (20.177.113.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Mon, 3 Feb 2020 18:20:18 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.030; Mon, 3 Feb 2020
 18:20:18 +0000
Subject: Re: [PATCH v2 1/2] qemu-img: Add --target-is-zero to convert
To: David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20200124103458.1525982-1-david.edmondson@oracle.com>
 <20200124103458.1525982-2-david.edmondson@oracle.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200203212016635
Message-ID: <4b23f9d9-efe4-000d-0d68-66028ad3d2f3@virtuozzo.com>
Date: Mon, 3 Feb 2020 21:20:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200124103458.1525982-2-david.edmondson@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P18901CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::17) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P18901CA0007.EURP189.PROD.OUTLOOK.COM (2603:10a6:3:8b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32 via Frontend Transport; Mon, 3 Feb 2020 18:20:18 +0000
X-Tagtoolbar-Keys: D20200203212016635
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57def73b-731e-48a0-7bd8-08d7a8d5b915
X-MS-TrafficTypeDiagnostic: AM6PR08MB3655:
X-Microsoft-Antispam-PRVS: <AM6PR08MB365558E972F77959B03F0D10C1000@AM6PR08MB3655.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(366004)(396003)(346002)(376002)(199004)(189003)(956004)(26005)(86362001)(31696002)(5660300002)(2616005)(8936002)(6486002)(16576012)(81156014)(81166006)(316002)(8676002)(52116002)(66476007)(66556008)(66946007)(31686004)(16526019)(186003)(478600001)(36756003)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3655;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYtehGU+oI7Lz8+Rli3bbLPzFrj6GNPYkMDJLnqumg2xTsZP5hoxIyLK7L5n8rqslKgd+9hnLAmNGSnreHdd3iHZYEVSqv3/s+Y2Z8XmPr6ImOnduAnhpM3EwT4loO2h6LCi8RanVXb2+7dCJAXjCljR0huLLng2Fq2A9uDPqVbZ/+wiDyE8bHojIse9g+mtgkUFZYcncn3E7ULF7Oa7KqZ4dGBbjl19/6zz3QA3TQsbJj7Iit46e6rmiumq/29Ep7WMMkSxLWawDfSsFL3aOLdsMYh1Dow9Tu0lkbRxE2txLt00FUAU5rDfQrJxI71eh/iaF0D/4R8kgtM5yuR7RBimMGu7t/WpGrZHHZ2XNec8LbcHgf7+MZNzMYMPuPqDC9BKqxJIeEiVK+579OKCU03RHK9P4ECIoyiM18OWajYD+J5tYVkUPqEOzv0QF/3Q
X-MS-Exchange-AntiSpam-MessageData: EZ3+etSyonuE+VKgD8qflw0a0L6qxa/5x6OGgNocc1YxxixV0MB0CiiSHJWNDg1AC5/DTDDG1mS1uktvhNK/8SEoFa2zM/zbNqBMFnFl3Vcq0/Ord5DLwxSnUZpGssWPi34/ff7puCp+wTZXqBxwjA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57def73b-731e-48a0-7bd8-08d7a8d5b915
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 18:20:18.4646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fa9NP8WCCjoc2dwvPvXAa8Zz2y8Ty3Cudh5Zjb9pT5hdNpaFcosVrDIyYU1bkiOQ0saG3jXaTjotw6NDNjpqMq91eQxEX4GQrV3gL3waXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3655
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.103
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

24.01.2020 13:34, David Edmondson wrote:
> In many cases the target of a convert operation is a newly provisioned
> target that the user knows is blank (filled with zeroes). In this
> situation there is no requirement for qemu-img to wastefully zero out
> the entire device.
> 
> Add a new option, --target-is-zero, allowing the user to indicate that
> an existing target device is already zero filled.

Hi! qemu-img.c part looks OK for me, but other doesn't apply on master now.

I like this thing, and I'd like to make similar option for backup job.

> 
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---
>   qemu-img-cmds.hx |  4 ++--
>   qemu-img.c       | 25 ++++++++++++++++++++++---
>   qemu-img.texi    |  4 ++++
>   3 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index 1c93e6d185..6f958a0a48 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -44,9 +44,9 @@ STEXI
>   ETEXI
>   
>   DEF("convert", img_convert,
> -    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
> +    "convert [--object objectdef] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
>   STEXI
> -@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] [--salvage] @var{filename} [@var{filename2} [...]] @var{output_filename}
> +@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] [--salvage] @var{filename} [@var{filename2} [...]] @var{output_filename}
>   ETEXI
>   
>   DEF("create", img_create,
> diff --git a/qemu-img.c b/qemu-img.c
> index 6233b8ca56..46db72dbe0 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -70,6 +70,7 @@ enum {
>       OPTION_PREALLOCATION = 265,
>       OPTION_SHRINK = 266,
>       OPTION_SALVAGE = 267,
> +    OPTION_TARGET_IS_ZERO = 268,
>   };
>   
>   typedef enum OutputFormat {
> @@ -1984,10 +1985,9 @@ static int convert_do_copy(ImgConvertState *s)
>       int64_t sector_num = 0;
>   
>       /* Check whether we have zero initialisation or can get it efficiently */
> -    if (s->target_is_new && s->min_sparse && !s->target_has_backing) {
> +    if (!s->has_zero_init && s->target_is_new && s->min_sparse &&
> +        !s->target_has_backing) {
>           s->has_zero_init = bdrv_has_zero_init(blk_bs(s->target));
> -    } else {
> -        s->has_zero_init = false;
>       }
>   
>       if (!s->has_zero_init && !s->target_has_backing &&
> @@ -2086,6 +2086,7 @@ static int img_convert(int argc, char **argv)
>               {"force-share", no_argument, 0, 'U'},
>               {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
>               {"salvage", no_argument, 0, OPTION_SALVAGE},
> +            {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
>               {0, 0, 0, 0}
>           };
>           c = getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
> @@ -2209,6 +2210,14 @@ static int img_convert(int argc, char **argv)
>           case OPTION_TARGET_IMAGE_OPTS:
>               tgt_image_opts = true;
>               break;
> +        case OPTION_TARGET_IS_ZERO:
> +            /*
> +             * The user asserting that the target is blank has the
> +             * same effect as the target driver supporting zero
> +             * initialisation.
> +             */
> +            s.has_zero_init = true;
> +            break;
>           }
>       }
>   
> @@ -2247,6 +2256,11 @@ static int img_convert(int argc, char **argv)
>           warn_report("This will become an error in future QEMU versions.");
>       }
>   
> +    if (s.has_zero_init && !skip_create) {
> +        error_report("--target-is-zero requires use of -n flag");
> +        goto fail_getopt;
> +    }
> +
>       s.src_num = argc - optind - 1;
>       out_filename = s.src_num >= 1 ? argv[argc - 1] : NULL;
>   
> @@ -2380,6 +2394,11 @@ static int img_convert(int argc, char **argv)
>       }
>       s.target_has_backing = (bool) out_baseimg;
>   
> +    if (s.has_zero_init && s.target_has_backing) {
> +        error_report("Cannot use --target-is-zero with a backing file");
> +        goto out;
> +    }
> +
>       if (s.src_num > 1 && out_baseimg) {
>           error_report("Having a backing file for the target makes no sense when "
>                        "concatenating multiple input images");
> diff --git a/qemu-img.texi b/qemu-img.texi
> index b5156d6316..3b6dfd8682 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -179,6 +179,10 @@ information.
>   Try to ignore I/O errors when reading.  Unless in quiet mode (@code{-q}), errors
>   will still be printed.  Areas that cannot be read from the source will be
>   treated as containing only zeroes.
> +@item --target-is-zero
> +Assume that the destination is filled with zeros. This parameter is
> +mutually exclusive with the use of a backing file. It is required to
> +also use the @code{-n} parameter to skip image creation.
>   @end table
>   
>   Parameters to dd subcommand:
> 


-- 
Best regards,
Vladimir

