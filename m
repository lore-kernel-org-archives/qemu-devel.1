Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C1CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 22:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A70F20656
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 22:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="E4PNFGL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A70F20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvqLa-0006DD-93
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 18:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvqKj-0005j7-LP; Wed, 15 Jul 2020 18:57:01 -0400
Received: from mail-vi1eur05on2135.outbound.protection.outlook.com
 ([40.107.21.135]:56960 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvqKg-0007Ss-8I; Wed, 15 Jul 2020 18:57:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJJV4jcq30w7R45Cx5TSlUXX7oMfvPB3t3Mu9q0DgrfI22shUQTM+dG1RjcyjFQjJSJcSj7AY6L76WD7eEGqU3TYU2ekoVoHe7w0RQD48A4Nsz769SvzD3Vagp77p0bB6Na2Ny2fiqOgY4x4BTioWUlJtQ7k/yiPGTpeo7GbhN/g9ta6XCY0sry5wIdYqhAK+oT4XV4ega/elLhCvZvPPBSCV8uCcSguZ2JzlyfFyfu3PXGJvK+CU5nkxDDXkCwKvUql69mImmG/4fVCpssWhIKm6dWvE/cr9AmV6LzAlwW+08KHF8PoLEydLgEj6e505I2yvQz317CFp2X1T5Y6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qz2HXlhI7TkKBc/SIQSsgxfcCx9Unnowg7JOm3sjXE4=;
 b=K7gyPB+M1ctAQFb0CcNDkArpYzmPZ88sLCqlvzoIB7XkMbJccLVNgc9jCxBQv1E3LOY7ljcmLU3DUS/Hb+aioz+12kuUUUVZjnBiDf3+3+DBddOhcYatYG9RNuSzCCpcZdwotTXyY/sGsb8AXOqVotLODCaVCtCpV3xtoC6w6dyXf7gaexk2Im5K90IcEgfUE/BXT2su67DNKgQRFi41kVnNd5RAv/I0GWKaURvS1dxTy2JIZbeAIPcKjl9THe7g29WElyQUtaGAT5y1hdvttgTFOZHwf5VNhMXgOaQS9dqrS11TJPzAlbuEsap75IYOGPS95CZ8uPrpQFi6b1/WrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qz2HXlhI7TkKBc/SIQSsgxfcCx9Unnowg7JOm3sjXE4=;
 b=E4PNFGL7nTn0mAzEiMuo2+uxPlvTfHQfW8Z/53sU4PU/fong4CJ2wAH5Sfplw2U6hMheIwWKhkFjcJW9pTFLCIeNnXmUD/v4uNPsWdADIYf1IC2dzs1Xkf164OXDSqgEyWpHPV3VtlCP1VTv1zVL/53lgg2lBOG6XKZqw8XQN0s=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Wed, 15 Jul
 2020 22:56:54 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 22:56:54 +0000
Subject: Re: [PATCH v7 25/47] block: Def. impl.s for get_allocated_file_size
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-26-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <0b52c48e-906c-8d2c-4ddf-94b6c9f4d612@virtuozzo.com>
Date: Thu, 16 Jul 2020 01:56:50 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-26-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR10CA0056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::36) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR10CA0056.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Wed, 15 Jul 2020 22:56:52 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a219178-8e4b-45d7-39ae-08d829125e10
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB261040C1809D3EA44E2D05F1F47E0@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AweLVrTCEgm3tLal3pwJumT4g/QSUtUvq+66joqyyZ2hz+BJR5XBNsgz1fCIVGV9/9Z4Qk41WajrYvnodF2DOKtTJW2b2YUNtHTxvTE3KpvLokGfMjvT9bWG06plYazkLu/QWAJHoxGkCro/Hxw4XMZyaScCd7g4i9GxRhNCET4sEP3l0rNDFImUfB8DxQoBk/DVj9Lahz/riVcTuI/S4PTSXAra59S8C7vTMv41LhhcpasSAHWUIwHdb8z8ZK35tZF99e7LHzaVty/o1hrPzhVL+31QMjAyS6yLQvqYUIKLv9UHeK7uuc3zqU1tDckJ9Le8VqmXu8n9WyuUKJDvGDKDLm4Rmq8zrZfwDS3mIe5ew/Gkxja8ErFc57N+80LH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(39840400004)(396003)(376002)(366004)(54906003)(53546011)(44832011)(66556008)(66946007)(66476007)(16526019)(6512007)(478600001)(8676002)(8936002)(6486002)(186003)(2906002)(83380400001)(52116002)(4326008)(26005)(86362001)(31686004)(36756003)(6506007)(2616005)(956004)(5660300002)(31696002)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Z7bsc/19ax+5TUp6Wrz21pb2hADWlzsaBwin4XlFkrfwY98Om9p3j/+sIgUhG5z16/L+pmkXxQQIzI6u/USGt5aol5HnNnrFijuk3UqtExYihqkeeTJjIS5tkScnMeMYKItJ7UxksGzgpThDTIwbMfSnEjVTzQONC5/Bv99pVEQ/0jH4VznMeSBRFYjWWmV/5FIl5HPCo1HbOjCFa4IrTZqtzw07QRceW9aXLMLwVn3LBlBbDcl4xRl9SDY7KkNdIWBOdlMA0U9CAUrxlgo1u5vscHs7GxMQCh1TjEPRdpGHu+JwcqaWlqBF2VNjvesOFCsXYD5UllN9icPnwcCQsY1yGWId72ucwB+0pVBQw0uR81FP3BLMDFNWfUqs30zs8Z2JTobJrPAcMydwGBhfU/OEvpyyIwM6IVeFQkHzkcKllJfAzmkRWAyglhC3H5CKCVI+ufwvlNIjlL70Wnk0ELrhAY0No0fmu23/eDok5WvrvRgBgk6XkmUQD2XnyH9E
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a219178-8e4b-45d7-39ae-08d829125e10
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 22:56:53.9815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wv1MWMZn6DRMqOInkQm8+POf0OC5yiWbBDb28YwYkbHY04OpUhjqmsq2nrmCAJFmn/+O9oDIewVqgsL5e1vEChflhmZrRZwBf+SUA/xxf20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.21.135;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 18:56:55
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

On 25.06.2020 18:21, Max Reitz wrote:
> If every BlockDriver were to implement bdrv_get_allocated_file_size(),
> there are basically three ways it would be handled:
> (1) For protocol drivers: Figure out the actual allocated file size in
>      some protocol-specific way
> (2) For protocol drivers: If that is not possible (or we just have not
>      bothered to implement it yet), return -ENOTSUP
> (3) For drivers with children: Return the sum of some or all their
>      children's sizes
>
> For the drivers we have, case (3) boils down to either:
> (a) The sum of all children's sizes
> (b) The size of the primary child
>
> (2), (3a) and (3b) can be implemented generically, so this patch adds
> such generic implementations for drivers to use.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/block/block_int.h |  5 ++++
>   block.c                   | 51 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 56 insertions(+)
>
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 5da793bfc3..c963ee9f28 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1318,6 +1318,11 @@ int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
>                                                      int64_t *pnum,
>                                                      int64_t *map,
>                                                      BlockDriverState **file);
> +
> +int64_t bdrv_sum_allocated_file_size(BlockDriverState *bs);
> +int64_t bdrv_primary_allocated_file_size(BlockDriverState *bs);
> +int64_t bdrv_notsup_allocated_file_size(BlockDriverState *bs);
> +
>   const char *bdrv_get_parent_name(const BlockDriverState *bs);
>   void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **errp);
>   bool blk_dev_has_removable_media(BlockBackend *blk);
> diff --git a/block.c b/block.c
> index 1c71ecab7c..fc01ce90b3 100644
> --- a/block.c
> +++ b/block.c
> @@ -5003,6 +5003,57 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
>       return -ENOTSUP;
>   }
>   
> +/**
> + * Implementation of BlockDriver.bdrv_get_allocated_file_size() for
> + * block drivers that want it to sum all children they store data on.
> + * (This excludes backing children.)
> + */
> +int64_t bdrv_sum_allocated_file_size(BlockDriverState *bs)
> +{
> +    BdrvChild *child;
> +    int64_t child_size, sum = 0;
> +
> +    QLIST_FOREACH(child, &bs->children, next) {
> +        if (child->role & (BDRV_CHILD_DATA | BDRV_CHILD_METADATA |
> +                           BDRV_CHILD_FILTERED))
> +        {
> +            child_size = bdrv_get_allocated_file_size(child->bs);
> +            if (child_size < 0) {
> +                return child_size;
> +            }
> +            sum += child_size;
> +        }
> +    }
> +
> +    return sum;
> +}
> +
> +/**
> + * Implementation of BlockDriver.bdrv_get_allocated_file_size() for
> + * block drivers that want it to return only the size of a node's
> + * primary child.
> + */
> +int64_t bdrv_primary_allocated_file_size(BlockDriverState *bs)
> +{
> +    BlockDriverState *primary_bs;
> +
> +    primary_bs = bdrv_primary_bs(bs);
> +    if (!primary_bs) {
> +        return -ENOTSUP;
> +    }
> +
> +    return bdrv_get_allocated_file_size(primary_bs);
> +}
> +
> +/**
> + * Implementation of BlockDriver.bdrv_get_allocated_file_size() for
> + * protocol block drivers that just do not support it.
> + */
> +int64_t bdrv_notsup_allocated_file_size(BlockDriverState *bs)
> +{
> +    return -ENOTSUP;
> +}
> +
>   /*
>    * bdrv_measure:
>    * @drv: Format driver


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


