Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96773C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 668E0206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vhA5Qiso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668E0206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtECT-0001En-9b
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtEBo-0000ou-EG; Wed, 08 Jul 2020 13:49:00 -0400
Received: from mail-eopbgr80101.outbound.protection.outlook.com
 ([40.107.8.101]:6699 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtEBl-0007nB-Q4; Wed, 08 Jul 2020 13:48:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFKwsZGmvGrJDtgmkZBGrkUaYLXZgg946to7zZHSowBv0eKcbhP8l66GacZNQDnMVMJ+iKs7k2IIGIYmbf/l54aMztJ8zHjUbczj/7DKEcQNKJZ7t3AO5d3UdP4/ljFrArfbbvMev6wZLBILK8nqZMSg88YbJqudZPaPTTRbuTeRp2UDEOCAX0QbeJujUtUCiey7kdIRMrYcbcV5NyLMCElR5HE5pxduK+Gchy4omZ8vu+jBFDuDkteCnB5u+moj60Otxz4/KK3JU1YudKQYM0qn0vOlJbqVvGsIHj5OX5SzcXw3t4A8VCO048kG9upMLwGJaJAlxdzK0ZRk52QOKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HONu8+6KIDT2NX6PCRnTo9SeXMl7od1OZNnvw8X8Ek=;
 b=C7Si2uPDcUiRYp1zfWRTSr0sjrG6odIp9grhSivMF9i2TlwMh3ZggH3V2PLt1KD2xbWQkghc1FqGC24hpq17UgmPrC6ZVCN9N1n8SPWMS/eF2hyt6rO/qDmHba1ppkt43slPXDLiBxiJGVSROJWnMs9H6zZ5j2O4x+iPTegJhtyY/fAWPnWiPyW/L/b6r8Y+jKHb/8se/J53jsCkk1JhZs8R5UBntAvUVdkIxyuD4HJpOhQJUZlKt8QtFaslWqxa9+zHdnakfQXxhZ/pZHC3bWVV9GPoDydcAkW3FtiM9WkC64Lp7ztYaH+oJ+yGx3U9o2qGpuhE4TvqJqieqYs4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HONu8+6KIDT2NX6PCRnTo9SeXMl7od1OZNnvw8X8Ek=;
 b=vhA5Qiso01p62wvZGkUXxvrNIDxsbpW3wgzr/Qr9H7V724z++2bvr6vwkFzBvaLfxLcR4MP8+tTIoPEbPmXInNjgfNRGLaoQdVeLx8ycnvRg4aN2zx4FjmF74AzLPOrL8soAeGuKjxfWGHWcdxttR1PQN7+J438mVkzbETAYAuI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM7PR08MB5384.eurprd08.prod.outlook.com (2603:10a6:20b:10c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 17:48:54 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 17:48:54 +0000
Subject: Re: [PATCH v7 07/47] block: Add bdrv_supports_compressed_writes()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-8-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <f172c41a-566b-80f8-322d-e575f1ddb1ca@virtuozzo.com>
Date: Wed, 8 Jul 2020 20:48:50 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-8-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR08CA0034.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::47) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR08CA0034.eurprd08.prod.outlook.com (2603:10a6:208:d2::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 17:48:53 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c5a29c8-6954-4fc7-3189-08d823672e8c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53844FE26E3AC62595FB3DC4F4670@AM7PR08MB5384.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtUbUvlzbtp83EeQQv63BF9irNUyFA7b1Oc/ebww82ny5YJkPvTzC8GH8cQnEcZN+DbhHX/85XTEXw02btIaoLYFQiwLy1uXPag+DokPGf4+h1bGrllnLv7opLo6Mjh/5BnVxz4XjbKjNz1ysxxyjbpbhq/OX5CmLlAOs+bZieCXXXe1PobwLv7aF5wfqhSMBceErQgCUw00P3SygrzzEbfcjAXCpBEWAc/Z3Vq4PxsujqOH8GV/LrSd3RUeGGhfQP1NsJK2AhQKDSawLyg4XeyhkN1ltOlWXm8m4SRRyN5VYZKZVdv756YeL5MU3BTQ3GjNL9KzGTumU5teNqBMfUZ6YmKoDL49Em65r/wh/ehnZYu6FCmGgqQIm/uB+4/0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(136003)(396003)(376002)(346002)(316002)(8676002)(956004)(6486002)(2616005)(44832011)(8936002)(478600001)(66556008)(66476007)(5660300002)(66946007)(31696002)(16526019)(186003)(36756003)(52116002)(4326008)(26005)(6512007)(54906003)(31686004)(83380400001)(2906002)(53546011)(86362001)(6506007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pRJDuMo81rYcYL1wmZRlsYf3DWCjsofEEJ7h1zGbgbx4zqPFFn56VXOH9gdJIZyAU8pUeA2j+zWo2LVFplhaVdtJ+k9jU8R8jLokwl+cEqHPb2SzjY2kRS1Rp1qsnkou6x4pJr8Vbb66J4XUAH9PeMTwTeBLh9IgF9zUTMNcYOlkVd6HXATndMzsmi4cVyg2CTLko+9bH8hb1CoXpmZeVtHW2mxnpoDn8p4eEmmyk0yK1z+nSsuqPqmR8tbwDDZKKRzrMo2uzNgPrK39EhsWZGieRfHPFAo4HvYr2BSZFqxUHgeFqF5iW8wG10P2kpTX/qj2QvHoLRbBMo9Oxb/z+spoperNNdyMA8ddz1BvZQjW4ve4nZ2lr82uCwVVtbF1QS97DXg+UQ7cK9wv1f9e9bvA+Wmi8l9rPNPXn2hp3C/+0pdJ0aZul84hXg0laZbWTeSiKIvLs7Ry3xH0t2LWE2Es8XO0yLXejLxjbn6gNz8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5a29c8-6954-4fc7-3189-08d823672e8c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 17:48:54.4567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sO2Nd+sNKdgkCyuluv4orN6jSaAivaBcHg3lq1dyIuniTCTnQoS+QZvFKlvjP8pd65U4m9/YmmAaius4tpMYkgcvyKqP/RBossAPen/u9p8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5384
Received-SPF: pass client-ip=40.107.8.101;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 13:48:55
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
> Filters cannot compress data themselves but they have to implement
> .bdrv_co_pwritev_compressed() still (or they cannot forward compressed
> writes).  Therefore, checking whether
> bs->drv->bdrv_co_pwritev_compressed is non-NULL is not sufficient to
> know whether the node can actually handle compressed writes.  This
> function looks down the filter chain to see whether there is a
> non-filter that can actually convert the compressed writes into
> compressed data (and thus normal writes).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/block/block.h |  1 +
>   block.c               | 23 +++++++++++++++++++++++
>   2 files changed, 24 insertions(+)
>
> diff --git a/include/block/block.h b/include/block/block.h
> index 0080fe1311..a905a5ec05 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -538,6 +538,7 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it);
>   void bdrv_next_cleanup(BdrvNextIterator *it);
>   
>   BlockDriverState *bdrv_next_monitor_owned(BlockDriverState *bs);
> +bool bdrv_supports_compressed_writes(BlockDriverState *bs);
>   void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
>                            void *opaque, bool read_only);
>   const char *bdrv_get_node_name(const BlockDriverState *bs);
> diff --git a/block.c b/block.c
> index 76277ea4e0..6449f3a11d 100644
> --- a/block.c
> +++ b/block.c
> @@ -5044,6 +5044,29 @@ bool bdrv_is_sg(BlockDriverState *bs)
>       return bs->sg;
>   }
>   
> +/**
> + * Return whether the given node supports compressed writes.
> + */
> +bool bdrv_supports_compressed_writes(BlockDriverState *bs)
> +{
> +    BlockDriverState *filtered;
> +
> +    if (!bs->drv || !block_driver_can_compress(bs->drv)) {
> +        return false;
> +    }
> +
> +    filtered = bdrv_filter_bs(bs);
> +    if (filtered) {
> +        /*
> +         * Filters can only forward compressed writes, so we have to
> +         * check the child.
> +         */
> +        return bdrv_supports_compressed_writes(filtered);
> +    }
> +
> +    return true;
> +}
> +
>   const char *bdrv_get_format_name(BlockDriverState *bs)
>   {
>       return bs->drv ? bs->drv->format_name : NULL;


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


