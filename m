Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56019C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 18:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262A1206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 18:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XJCBzY2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262A1206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtElj-00071h-BA
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 14:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtEkf-0006Ie-B5; Wed, 08 Jul 2020 14:25:01 -0400
Received: from mail-db8eur05on2097.outbound.protection.outlook.com
 ([40.107.20.97]:45057 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtEkb-0003ZZ-B8; Wed, 08 Jul 2020 14:24:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muffAUNf+oyoZLPpCtoMbKagT49UzDY0VXZOKa5cUIEGfGKWOVjRNv9sHhl96P6mnEM2aaAs6hVvwAiwptUMWKLAAnutNzY+H2eJS+gKVyN8BzNPXO4G6eeF51K0hCDIKtNXthvgvbvfGFUoHw0NxbrV3qMIHjjUuUDcthb01jgkwJzaiJvnbg/YyMJ8kosw8D84ytln8ir/SQqQWTzlFeHfxrlL1/XCMe/TeyWnpiNdj+mOtGV11g2oJGdDYoCBgl3JqLBnICySydljB1Tpa3XyHi6YJrN01Atk8f/A8axYtFUbx3+auDwThycpx+LGzdhdQqy1JWh0lZvaiOmKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3RPG4BPOeAa9uYM51Hphknt6QgXzAfPnPX8rIgquSw=;
 b=Mu3HlcexSEYcwykxosVA3Uaf4AGAvux8WL0eAgDxnt88LB4vH/fEC2Lj8HJJW/8THLfZlStpL/IljwehH3NGow1GE8hf4G1MLnanvScHqBa7PFMAa2mxc6t6MnuXsfFIMBwYLl6ln+3i4bRjyb9aAwN/tz5Nlib6L//KjuXxPv4hqhBYf7ANIOTCS5aGwNIn18mHwcJzvSFVnonRiuN7DHwRkFWPl/yIfUX4jbg6gJmJS61aWBy0bSBOLIgQBB3sLN78nAIKHQbNSyE4WGv9kbE8H6Gwzsaw8vXpIcIqu1iVRBYb4ZB7JyYikn+G2aHJpcS25riuH3PnBB/yqyXDQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3RPG4BPOeAa9uYM51Hphknt6QgXzAfPnPX8rIgquSw=;
 b=XJCBzY2ozK4+a0/bEZPdrRWzNAXLAhc+cqncwL04CMBdS2uzP3d/sHi3xDRAdzaYF5nriYbswvOMb+JsyDGKsOU+fuTAKy/RMoMay9jYeFNhXn2SKhek+0tFHlI5kfjRdqA5ehGiZfVBm42FDJebvgVQ/vyaqhb0dfVGaII1FMU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM5PR0801MB2098.eurprd08.prod.outlook.com (2603:10a6:203:4a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 18:24:54 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 18:24:54 +0000
Subject: Re: [PATCH v7 12/47] block: Use bdrv_filter_(bs|child) where obvious
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-13-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <82792291-86a1-34cc-98e8-6d585755c79b@virtuozzo.com>
Date: Wed, 8 Jul 2020 21:24:49 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-13-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR03CA0001.eurprd03.prod.outlook.com
 (2603:10a6:208:14::14) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR03CA0001.eurprd03.prod.outlook.com (2603:10a6:208:14::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 18:24:52 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca508b83-7cab-45eb-5f34-08d8236c35dc
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2098:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB2098D06B3A93E39E8DC19316F4670@AM5PR0801MB2098.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YqyRNmKqbJuHFk/b3/IJJF050imrhOnr+egyBKbklzzKgQCJrYLH9J2rSjYs3l/gnYTY/Ukk0kHdnQOHnTaD6fpE+hMkr6/pmbywFxPRWRUTnucOtYyvRi3J7Q/unB2k4zUYKsdgl9Q5TWZH8pV5nFz5SoFRyyFkIK6CvUmEfaxuCSqq0oBM2tuGN+Cq5vlsplQ0VO8c3rkzSibbufMEvD0w+UJjJFw3Kh9qpiJ887DejVW1c2evzV6GZWNlcO5MGhp340IM/hAWwslIo0PQNwQRc84rLUTO70cqh92YNs5LdpXkiNLmLc291m+ItnkkdG2/7BJtxgT3rsFNUWdldy/cBdHIGZ86VpbgKWlier2mXSAKm2VlMvla/nuq++73
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39840400004)(66476007)(44832011)(66946007)(5660300002)(6666004)(16526019)(186003)(26005)(478600001)(6512007)(31686004)(6486002)(53546011)(6506007)(4326008)(2616005)(956004)(54906003)(36756003)(66556008)(52116002)(316002)(86362001)(31696002)(83380400001)(8676002)(2906002)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lnsvpfbv2x/azhGl9v6GKcxDNuAjB4qwci3djQdeSRrtHSVRWZ7yapjxYlatZaMonLNec6yn3hCd6yLjjfI+BO7z66cYl81CPAoL2Z5H74UTp8zd3HwCghEmcVE3Z13ei8p4JudWKdw5A1EhSzTEkPRiwkia9HFLARbB9Tp1bMpfkhosVj5925BE9wBqOd8cnUnqexy0ORCAV5IE1vVoLyHj/o21ArUTf89e/iR2ySzGxI1azjFWitQPwxng/OiRuV97/zh547e94eKFKeF0qzjCqXyWM7Gm6+LRT7r7W7Fz7IlF5qfFQmj50EXZqAO2/vrdJbcuxuRZIeiBbdFxuU5LbvXiHVe0HYHzFJe/4ZnGSGRdnlwtpgJ+QRcHSEfJNDj9JxGXCAnSvTZHlJv1/JOpoYd8TENg2a5XX5S+vAxMqeSvaTS/3OfDYzbZd9vzXkVnojAqe4ZE7jd7sUqNSiDhJ9AzZrnK2yMIPoXolrvReYPnv8+ouee9nfd+F6bD
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca508b83-7cab-45eb-5f34-08d8236c35dc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 18:24:54.2298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnB+Mwqc4cPUwdcs7Xbgf4psylfg/fcpMJdsDw3eQ3tDR9cVYEPQ1i4E98RnSa7c+WPTnouP/kUM7KiYdKvtzwkm/EoJ7d6kfSUQK1nBEzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2098
Received-SPF: pass client-ip=40.107.20.97;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 14:24:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25.06.2020 18:21, Max Reitz wrote:
> Places that use patterns like
>
>      if (bs->drv->is_filter && bs->file) {
>          ... something about bs->file->bs ...
>      }
>
> should be
>
>      BlockDriverState *filtered = bdrv_filter_bs(bs);
>      if (filtered) {
>          ... something about @filtered ...
>      }
>
> instead.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c                        | 31 ++++++++++++++++++++-----------
>   block/io.c                     |  7 +++++--
>   migration/block-dirty-bitmap.c |  8 +-------
>   3 files changed, 26 insertions(+), 20 deletions(-)
>
...
> diff --git a/block/io.c b/block/io.c
> index df8f2a98d4..385176b331 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -3307,6 +3307,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
>                                     Error **errp)
>   {
>       BlockDriverState *bs = child->bs;
> +    BdrvChild *filtered;
>       BlockDriver *drv = bs->drv;
>       BdrvTrackedRequest req;
>       int64_t old_size, new_bytes;
> @@ -3358,6 +3359,8 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
>           goto out;
>       }
>   
> +    filtered = bdrv_filter_child(bs);
> +

Isn't better to have this initialization right before the relevant 
if/else block?

Andrey

>       /*
>        * If the image has a backing file that is large enough that it would
>        * provide data for the new area, we cannot leave it unallocated because
> @@ -3390,8 +3393,8 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
>               goto out;
>           }
>           ret = drv->bdrv_co_truncate(bs, offset, exact, prealloc, flags, errp);
> -    } else if (bs->file && drv->is_filter) {
> -        ret = bdrv_co_truncate(bs->file, offset, exact, prealloc, flags, errp);
> +    } else if (filtered) {
> +        ret = bdrv_co_truncate(filtered, offset, exact, prealloc, flags, errp);
>       } else {
>           error_setg(errp, "Image format driver does not support resize");
>           ret = -ENOTSUP;

...

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


