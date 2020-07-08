Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DF2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACD4206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZJ2vSRgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACD4206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtE5A-0006rI-23
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtE4F-00062C-Pe; Wed, 08 Jul 2020 13:41:11 -0400
Received: from mail-db8eur05on2133.outbound.protection.outlook.com
 ([40.107.20.133]:63862 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtE4C-0006um-Db; Wed, 08 Jul 2020 13:41:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnZUN8wmHGB6VVCTVHT27/0gzeiqwYNz5yNSWN1bBRvtcXuKwM04/frcyL5HHvcq5OWI6mBj/r2whO1gw9A2CBd+BpijUAF3UjoS30geEIb65u8Y2faqRNMNDRvpZmszuLpmHA/1hJuLX2LbYzydRcOxpvIKxF4xDcocIqkk4DuOdNBqt37OamgIOQnY25elVsNbNGlTR+iJqad7j4p4orOHCBKpzgW8yMcl53JuIiKubE7UL7dMtLGQ+e3QYlyZl5o0gcgd98dIP28m3dapWRp5MH/kye3L9/10b+wwynWI9rIgjfvnIt8wfoL+Y6nFs8jcNvPAUnr0hICjZaOTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reDqMBbTtcaAsZzz+ELMLwOV6pDjLzJp3XBX6FkwKHk=;
 b=LSSROcuDlFtx+Y+ewh+pdeMaehf/u24tZv0F28Sl/jGZk/b8bcv5JQx7zOOnrzMsWTgHqyU7n06hzGdyVLTG9jf9Yn5n9rQeuqLlDCi0CWtJgaB+UNnEQC3ytYzhrCU3bqtMdKH+lRcvqBWF8HtS8gqPEj4Xm/nRMCJxY7+9gxn/zZvV3XfKAIotHahWunqFCSt3SmmFoOXwvP7ZMN1XBGNPI6fdZx/vraTdyI3atWnMlFqjFoZRl4adIocj3OZ/U3a5RImZOzYh75JDpEMexLRZz2KyXiAEkbVSuuuCaC/+iVlKldT12Lcb9nKTUxXyi5gvPAc9ZLDRirNdBT9mSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reDqMBbTtcaAsZzz+ELMLwOV6pDjLzJp3XBX6FkwKHk=;
 b=ZJ2vSRgSPLR/zyVrNci12iPu2/FilnFViNr+na6uHAGUXv/+S2pCBGKEsre75BNUCYjWEZJjdDkK2d9rRYakoGwBWcfih3qdJR5iLMkiMmufjtP8hHXoXX5W7yp/d5bu4nBsP+NJRRj77HlfeeMjwSxYyUjJRL/sFMvR/lTGqis=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM5PR0801MB1908.eurprd08.prod.outlook.com (2603:10a6:203:4b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Wed, 8 Jul
 2020 17:41:04 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 17:41:04 +0000
Subject: Re: [PATCH v7 06/47] block: Drop bdrv_is_encrypted()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-7-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <acba2bbc-4415-06e7-bcfe-41174c46d8ab@virtuozzo.com>
Date: Wed, 8 Jul 2020 20:41:01 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR04CA0057.eurprd04.prod.outlook.com
 (2603:10a6:208:1::34) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR04CA0057.eurprd04.prod.outlook.com (2603:10a6:208:1::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Wed, 8 Jul 2020 17:41:03 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f45ced37-a4e0-4022-1975-08d8236616b5
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1908:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1908F4196F6CAA7FDBF3B6DEF4670@AM5PR0801MB1908.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTLDVAVE6926/S7RdVW+fU57Ir6Cm6tsJiIYQEAJ6qnZp7v0fwh+qpN8KwXjvCZtCZ93hh1MfTAF4lo0yDhdI62aF05B3IT02Wq4lK/BAZP0WbCooj5n8COVff40BO/+GrTB4h3zuZjbcDQLyGzQarxrZMqIEzbcaIOglruqXb+sC03ZzFutVQJXhjRR+oI2T1OU6CM0x7Dw9ykirz1tLsKjiGTujnI4MyCT+1d7F2VM61t997pBtvsh9dNXrmuCb7sLPZOhf91w/RV1Vs1BLXcrNN0HuvIr2eNJrYXJ2KDN0s+I4SCmy4/KV30pDo/eYjq7VWhNsN7CuIuJlvegSplOVtA73MMq6sggM6WmXk6Kuro44DS3kme0aTTvNtu0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(136003)(366004)(346002)(376002)(8676002)(31696002)(6512007)(5660300002)(54906003)(316002)(66556008)(478600001)(66946007)(66476007)(52116002)(2906002)(36756003)(26005)(86362001)(31686004)(83380400001)(6486002)(6506007)(53546011)(44832011)(956004)(4326008)(8936002)(2616005)(16526019)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: raCGul4Hp5mu6EsQ0jPvOXZBoZwjMfvbAKniG7r6SC26dt3PvJsysVvb00O2VgjBJaV4cbYnn3ugvKJqNCX0Pb/vE9F6A+SlLQfwOR29rdt8taReJ3NlrrcCfPJfNSgD6qC+RR/FLsTvXiOQFBcxIV9WC88JNCNxRopIRmSmtySopgsPRyhVutT4lWWL+BhotMt+o0z8kkSdrQ7Yx3L2dBRGMxXrEMKjMu5IgxA2c1RDE+iQBTzKgoulB/2tAyiwmWpPbXsbbuhYMJP1iLCYHyhReQ+xWEm0dLi730HYk081b1dZrqyRjb9HwNvyLM5a0YpUcxxSxhMX8CPXXTfWFYeUzaP4LrU1cpisbYSXrBjXZ1Lmn7WE3gXJFPxqcyA53CPmSeKsHoaafMm/Rr5sNFL82Zx6UUeAv3drVojDVXUj3VLPzdZlv81lIPPjKuP1GxkCzqHJCIWlMQ/jQPrUr+R431SItpOVLU4NyIrlZvA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45ced37-a4e0-4022-1975-08d8236616b5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 17:41:04.9197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7J42oAtbZ7JAt352fkjxO4nzJ6HMUDeqcMvN+aD2NDK+0mDAR/UAIDLZ7i5a8YOBufXFmvoaiAy0UCtrKoVw9idTYVHpsz13Dt+StZi4ITw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1908
Received-SPF: pass client-ip=40.107.20.133;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 13:41:06
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
> The original purpose of bdrv_is_encrypted() was to inquire whether a BDS
> can be used without the user entering a password or not.  It has not
> been used for that purpose for quite some time.
>
> Actually, it is not even fit for that purpose, because to answer that
> question, it would have recursively query all of the given node's
> children.
>
> So now we have to decide in which direction we want to fix
> bdrv_is_encrypted(): Recursively query all children, or drop it and just
> use bs->encrypted to get the current node's status?
>
> Nowadays, its only purpose is to report through bdrv_query_image_info()
> whether the given image is encrypted or not.  For this purpose, it is
> probably more interesting to see whether a given node itself is
> encrypted or not (otherwise, a management application cannot discern for
> certain which nodes are really encrypted and which just have encrypted
> children).
>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/block/block.h | 1 -
>   block.c               | 8 --------
>   block/qapi.c          | 2 +-
>   3 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/include/block/block.h b/include/block/block.h
> index 86f9728f00..0080fe1311 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -538,7 +538,6 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it);
>   void bdrv_next_cleanup(BdrvNextIterator *it);
>   
>   BlockDriverState *bdrv_next_monitor_owned(BlockDriverState *bs);
> -bool bdrv_is_encrypted(BlockDriverState *bs);
>   void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
>                            void *opaque, bool read_only);
>   const char *bdrv_get_node_name(const BlockDriverState *bs);
> diff --git a/block.c b/block.c
> index b59bd776cd..76277ea4e0 100644
> --- a/block.c
> +++ b/block.c
> @@ -5044,14 +5044,6 @@ bool bdrv_is_sg(BlockDriverState *bs)
>       return bs->sg;
>   }
>   
> -bool bdrv_is_encrypted(BlockDriverState *bs)
> -{
> -    if (bs->backing && bs->backing->bs->encrypted) {
> -        return true;
> -    }
> -    return bs->encrypted;
> -}
> -
>   const char *bdrv_get_format_name(BlockDriverState *bs)
>   {
>       return bs->drv ? bs->drv->format_name : NULL;
> diff --git a/block/qapi.c b/block/qapi.c
> index afd9f3b4a7..4807a2b344 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -288,7 +288,7 @@ void bdrv_query_image_info(BlockDriverState *bs,
>       info->virtual_size    = size;
>       info->actual_size     = bdrv_get_allocated_file_size(bs);
>       info->has_actual_size = info->actual_size >= 0;
> -    if (bdrv_is_encrypted(bs)) {
> +    if (bs->encrypted) {
>           info->encrypted = true;
>           info->has_encrypted = true;
>       }
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

