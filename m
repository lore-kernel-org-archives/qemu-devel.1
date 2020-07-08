Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6C9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C666206E2
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aWwA2oqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C666206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtFX6-0000yy-8G
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 15:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtFWD-0000Tb-2a; Wed, 08 Jul 2020 15:14:09 -0400
Received: from mail-am6eur05on2096.outbound.protection.outlook.com
 ([40.107.22.96]:64449 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtFW9-0001Ec-FU; Wed, 08 Jul 2020 15:14:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgseWSdieI7wFrfCLH7+iV31nlzIVfLU93MaiQRVuWzDyPqaBovV0wgAQ810a/1Fuf5f4QMrWWWWDLcf3njR1hKAKEQL0fmLSGxEJkS02Erxz6MWV5ovdchEG51SXWX7ifKFfGfZ8BwOmJ8Tr3bSDvfucnod1agbH9huN2sRn/ZLG/o6jtx+LWXyVq6K/mlyL1gXqUDOIp24Uuf/b8Im9cUv7vvCupJFqVlgRKnDjO/4rg0TeHXC75RA19BkAR4MvSS2j+o0bZ2n450okyxtgGt423+Wr6n4DbojW4Jpn2CQ0u1Tmkq0zs0rtvpC7HCifu0v66ceH/+jHDrTU0vR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkK2nqYhvmfRVg4FbFE6YlY0mmETbH5nmqmbQkAS6JE=;
 b=fWTYjnG90LjQvYJp6OVFMFr8gwnMyOSe3zVr4ehh6lVeB1rAXIETrh/UkLC+MrBIlNQqaaEdhLsXafP3aGd5QL6Bq0gNSDxzm+8/xkTjNbo2cNMaVJ7MVg8hDqTywXKV+fgmJUmcpsIDsZkVpTiM8EuVbEwBgMEerJvOproXqUbCWwB7QlSv6B8JRXSTPP7oiwmbgLXyE7EoxLReGz0cPoPK+e5elTuhBH/Uw9NMQYVi8f1LqHCeoaQnJwdPmXyimHcBxabMBw3MvtbALwOBw/uaCBtVcxkabLmUH45Jcy8pCPDjaU+YNJqFtA/S04GtwtaAnQeXzPq5WhPRI7pZtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkK2nqYhvmfRVg4FbFE6YlY0mmETbH5nmqmbQkAS6JE=;
 b=aWwA2oqRho9XXbHbcS+pT9d+rLA1Jo2WT1AzhoVNQeyDqq3LTeWC/zI5RdiLhFpEvZ6XzDk+En3k9ulAygz3J1Jf+1qGnXPNj33mki3QcaVKIXKtx5QTSih++BquSzVQz9otK1PRKfrNsj1o+0M7u2+ydRahmLhKxpRJjMWRfgo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM7PR08MB5496.eurprd08.prod.outlook.com (2603:10a6:20b:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 19:14:00 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 19:14:00 +0000
Subject: Re: [PATCH v7 13/47] block: Use CAFs in block status functions
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-14-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <0b441000-d33b-e833-1ecd-dc343e7afe00@virtuozzo.com>
Date: Wed, 8 Jul 2020 22:13:57 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-14-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR06CA0137.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::42) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR06CA0137.eurprd06.prod.outlook.com (2603:10a6:208:ab::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Wed, 8 Jul 2020 19:13:59 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4292c001-1f43-45d6-b664-08d8237311c5
X-MS-TrafficTypeDiagnostic: AM7PR08MB5496:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54966820E9F636CB8737DF8FF4670@AM7PR08MB5496.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j60rA12HQ7vNbMd8iEm+5fihT1i4wygarAGpUMfevuJiERecyo54ewaOS1mcNYE1I1pYS/rU5anUQWqTgzBLHQzW1MIdpZ6tK9HD+ehg15l88y+yR2fjXgJ95Os2PTcRAFADCRal1EZPayWmvnXOvd5hyrvHLnrgiJQdSHF9gdrafn/nJI6Xg/OAdh/VWB1a8MkD68pcNxpSiL61MJNk8WsQMZf7FEwWBpPhCsRpkGw2XfxgjC3NzdCc47oT/kmjlNfwEv8T+KNG6T8b9gkYigB4w6jEf2sHCrhqnnNOiW+fp4qRFV39USxulrdKUK3ozFLHVdJisDPUH2kUKFBg2XMnJyL3g+jSpt2PZuluLI8R0vOf2wHtlDBewBTimnUt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(53546011)(6506007)(5660300002)(26005)(186003)(16526019)(44832011)(54906003)(66476007)(66556008)(956004)(2616005)(316002)(6486002)(66946007)(8936002)(2906002)(8676002)(31696002)(36756003)(86362001)(52116002)(4326008)(31686004)(6512007)(83380400001)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /fkWkpmKkyWvOJiOPXuJ0QAd6sZUdOZGQCtB8bh+QZwnoe4++SDL/NNhn/tpbL084Gy1B4ScqJfoCMyLAwz6jHvSN2Ut/isw3lmuGC/KT4SGvJTms6M5MknDkYi/Bg5K59XJvPKKBlLmltcuICp8J8AOekKngp6W3vQJ4wVFJlIF8km7RrSfgYdDHGDrdFPhVbRdIN3ijjQSCzl3pISJ0jkgR1GyB7B2mK8A1vZAeCT8MWTIqtktaZbvapzD7t/S8Q6IDv5hfFF9Yy1cX+BN7BApNDkbNBVqzpDhvNgbjpGM14ShHYDZUsN5pwn4QEboh2laGXJqmZRTXani3axgrhFthX39XfQrgFfmOus0Umruppy8REv3s6pSwr9ytEXuDWQ/FwN/lGerchCVk3tAfU7HQS08Xv2JGMBB7JPJ6HxRFMrclM8QoSG11tNgtV0JCEpJ+BPfh60VqvgVCYRDs4iHgn6cP8Up3rjow8A+0nxCWd5On+Tif3PhX0B8wxNC
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4292c001-1f43-45d6-b664-08d8237311c5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 19:14:00.2034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFqg8FxzCdLgAAYSQdCgniH/R8v2ehi0puhwYhFKYZkkoTJhm2+BeBonPbBmmiIoUi+C8U4S7v8JVBxxH8lgwnBw6sFa91EVZye8z849Uuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496
Received-SPF: pass client-ip=40.107.22.96;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 15:14:02
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
> Use the child access functions in the block status inquiry functions as
> appropriate.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/io.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/block/io.c b/block/io.c
> index 385176b331..dc9891d6ce 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2407,11 +2407,12 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
>       if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
>           ret |= BDRV_BLOCK_ALLOCATED;
>       } else if (want_zero) {
> +        BlockDriverState *cow_bs = bdrv_cow_bs(bs);
> +
>           if (bdrv_unallocated_blocks_are_zero(bs)) {
>               ret |= BDRV_BLOCK_ZERO;
> -        } else if (bs->backing) {
> -            BlockDriverState *bs2 = bs->backing->bs;
> -            int64_t size2 = bdrv_getlength(bs2);
> +        } else if (cow_bs) {
> +            int64_t size2 = bdrv_getlength(cow_bs);
>   
>               if (size2 >= 0 && offset >= size2) {
>                   ret |= BDRV_BLOCK_ZERO;
> @@ -2477,7 +2478,7 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
>       bool first = true;
>   
>       assert(bs != base);
> -    for (p = bs; p != base; p = backing_bs(p)) {
> +    for (p = bs; p != base; p = bdrv_filter_or_cow_bs(p)) {
>           ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
>                                      file);
>           if (ret < 0) {
> @@ -2551,7 +2552,7 @@ int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
>   int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
>                         int64_t *pnum, int64_t *map, BlockDriverState **file)
>   {
> -    return bdrv_block_status_above(bs, backing_bs(bs),
> +    return bdrv_block_status_above(bs, bdrv_filter_or_cow_bs(bs),
>                                      offset, bytes, pnum, map, file);
>   }
>   
> @@ -2561,9 +2562,9 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
>       int ret;
>       int64_t dummy;
>   
> -    ret = bdrv_common_block_status_above(bs, backing_bs(bs), false, offset,
> -                                         bytes, pnum ? pnum : &dummy, NULL,
> -                                         NULL);
> +    ret = bdrv_common_block_status_above(bs, bdrv_filter_or_cow_bs(bs), false,
> +                                         offset, bytes, pnum ? pnum : &dummy,
> +                                         NULL, NULL);
>       if (ret < 0) {
>           return ret;
>       }
> @@ -2626,7 +2627,7 @@ int bdrv_is_allocated_above(BlockDriverState *top,
>               break;
>           }
>   
> -        intermediate = backing_bs(intermediate);
> +        intermediate = bdrv_filter_or_cow_bs(intermediate);
>       }
>   
>       *pnum = n;


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


