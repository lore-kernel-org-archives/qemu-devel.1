Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA2EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98832063A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YEwKoM6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98832063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz01A-0000N6-Py
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 11:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jyzzI-0007nm-O7; Fri, 24 Jul 2020 11:51:57 -0400
Received: from mail-eopbgr60105.outbound.protection.outlook.com
 ([40.107.6.105]:1094 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jyzzD-00021w-IV; Fri, 24 Jul 2020 11:51:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yybcu8ZnjcQYlFki1gr/w6OwbkKTmXd+KzXfRtxDm59DCmpAv2CsEerlJTWSA64UlD1dQZdVjFVVBqqg4HnDnJFz9fbdDkB2R/ELvYbapuizi0IeU6a1hat/awi3lvUPdnkVXNs6NRu/gsweILQX8wrlwl36Ha6Csb03Pj6cf9xAHphK84MNmoltK0Guv9E2FSC10EQ/HIdy/fo5O1drUzt7IHwQVSZzReAFc9pcSV/eb2eHfOwON7/+pRtT364g/nN95qVBmpoXKEN4NYsF+NCLtp9vXTMTUrtkKqt4edwmC9KxB2YzGSUS2N2LBvYd4ZrGqF/K7ByEaCXJ1w60UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADoDrL3StqSrq7EJ6mu6j7bloXQurmi+bx5NScRb2Qk=;
 b=GWp/Jw/2E2KmQ0t28L1PRSvPMIv5S+Hjx737uyHjUm3hI/dhKEi3uOmjPZaiZ0LfEzYuiBEzN1bQd4oARc0Radt7/M2rIv2OewKsBQdxQ7DaTg+CNsOJ+gsvfZBMNGA30r91pwNqVavOfw7GKFx5MITmELdaLhNNcCWyPlZX7HJJC1HazIG96L7iXhTkbvMkzBht25cZBP8SfY2+BS4yP5TG924BabwLHQNvBW2qAfG2pwW/awN2LXMJB9Dc3XQIO6OwRdx8QIlnFU//WMfWVqCFL6n6qtmWaGeIP4vCz9bHGE5k4EdHHXO2GRLcfq7Fc2aDID6oA0fZB43oo1YxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADoDrL3StqSrq7EJ6mu6j7bloXQurmi+bx5NScRb2Qk=;
 b=YEwKoM6Y3urkbtr0HeyAUsE+EUIaTN6yt3sNIdeGvLkMeqOZ8/OzBP5q8P+6ceUepcnMuTW2LRFEn550JxKq6skdudnCJX91lO95q6si7QRmjg1sDKnqWUQ4WThj/4FxuvvcjBO4HXe2joROTFSvPeTmkw0EwaJQaUlwIfeP3pw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4534.eurprd08.prod.outlook.com (2603:10a6:20b:ba::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 15:51:47 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 15:51:47 +0000
Subject: Re: [PATCH v7 37/47] qemu-img: Use child access functions
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-38-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <69334252-ea43-b4aa-cb05-a94613e235de@virtuozzo.com>
Date: Fri, 24 Jul 2020 18:51:41 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-38-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR02CA0017.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::30) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM0PR02CA0017.eurprd02.prod.outlook.com (2603:10a6:208:3e::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 15:51:44 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88c62c9b-d99b-41fe-b857-08d82fe978ef
X-MS-TrafficTypeDiagnostic: AM6PR08MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB45347F054BE6DC6620406D13F4770@AM6PR08MB4534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:309;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s6N0u2J1dHBPZSxSQuFZnuq0QFGXOk8/1OBlIgC+nSWjDLNpQx/IppksBSWxomzCtL2ZCxkXkxyJRblqeaoxgRcxvek17NkIn+Q3+ci+uAZ3vmogkw+Z6mZvhIygd2QnQ2XZjQYJUvM2C+rVUeGNkcywc821Wdv4uz5Po2HLLRbUQUfedXYOmh+h8HeftLaPXSCM5mF45U6mf+Uxbe30MReA0+nY11EzH2RvsqJKzFTXdXL5BSWg7LE0ow5ktDz6C8km0JY1m189gPfRk6PKA+WZHbPSModHQRTWcacbwY+LqnhNEeQvkWWXMML96lvGVJO65c5E5T7pJcKtWKcWB8kK3hzRtnkjOpBYVtF9odnlhtJbAvLflm8jBpa8VHX3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39850400004)(8676002)(66556008)(6512007)(52116002)(83380400001)(66946007)(4326008)(26005)(66476007)(6506007)(36756003)(6486002)(956004)(44832011)(6666004)(2616005)(53546011)(5660300002)(186003)(478600001)(31696002)(2906002)(8936002)(16526019)(86362001)(316002)(54906003)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: BsJsF+Fj6qJr8LEqS3HcCSXUsWCdmE13adNe6BoGVK6/8VxZxzbjpiH2S5TFdvgFHTLIQgzcdoeIETKgnpooOg7pZa7p1soVt2dzN1ELBQA7PVkUr+m4Pgrktf/o/aQTX7WvRGapOJkcdtghegxegjXsBmRYFtQ9cPO8sgIFhqf9oyNCYP7AR1llUUXSwgET6+X2c6oNUeqJrxZ0k7dVqHvkzd6/2WOlcPgScaXlhAP/gdT8Oqo2KCmInvtsjwSBmtv7pngULkSxv2JVGkH3eaH8MnLpaHFw28QsU1Fm+vgB+Uswz2Lwk7Zpm/LCIxJzph1sljzkNg28R3IFK5lAr7wmfWYkEGpfWNB3lhtXtAS8Su8ue8eTwMs9auL5VokeyLLv84MAoOboZBUorsIVkM/BdpMioEDINsNhaaSTwvZYCvidWamMSttVX4Rdtz70FCbkI1Vl1v88wyxs084uO51MR4Juq+pP9wMN31VAGJCHtn0ojJYo2btDVn6fepDe
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c62c9b-d99b-41fe-b857-08d82fe978ef
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 15:51:47.8195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xa82galR9YLaPCnaDwyxHTVb17Qp+QuxlEsQIYidE+wzHDLOVAAMCwg49NFxPRNmcH8KbOluOe0/A9jwZ4jRfOy9uM94JMhUryyVeQXFnbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4534
Received-SPF: pass client-ip=40.107.6.105;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 11:51:49
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

On 25.06.2020 18:22, Max Reitz wrote:
> This changes iotest 204's output, because blkdebug on top of a COW node
> used to make qemu-img map disregard the rest of the backing chain (the
> backing chain was broken by the filter).  With this patch, the
> allocation in the base image is reported correctly.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qemu-img.c                 | 36 ++++++++++++++++++++++--------------
>   tests/qemu-iotests/204.out |  1 +
>   2 files changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index 381271a74e..947be6ffac 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1089,7 +1089,7 @@ static int img_commit(int argc, char **argv)
>           /* This is different from QMP, which by default uses the deepest file in
>            * the backing chain (i.e., the very base); however, the traditional
>            * behavior of qemu-img commit is using the immediate backing file. */
> -        base_bs = backing_bs(bs);
> +        base_bs = bdrv_backing_chain_next(bs);
>           if (!base_bs) {
>               error_setg(&local_err, "Image does not have a backing file");
>               goto done;
> @@ -1737,18 +1737,20 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
>       if (s->sector_next_status <= sector_num) {
>           uint64_t offset = (sector_num - src_cur_offset) * BDRV_SECTOR_SIZE;
>           int64_t count;
> +        BlockDriverState *src_bs = blk_bs(s->src[src_cur]);
> +        BlockDriverState *base;
> +
> +        if (s->target_has_backing) {
> +            base = bdrv_cow_bs(bdrv_skip_filters(src_bs));
> +        } else {
> +            base = NULL;
> +        }
>   
>           do {
>               count = n * BDRV_SECTOR_SIZE;
>   
> -            if (s->target_has_backing) {
> -                ret = bdrv_block_status(blk_bs(s->src[src_cur]), offset,
> -                                        count, &count, NULL, NULL);
> -            } else {
> -                ret = bdrv_block_status_above(blk_bs(s->src[src_cur]), NULL,
> -                                              offset, count, &count, NULL,
> -                                              NULL);
> -            }
> +            ret = bdrv_block_status_above(src_bs, base, offset, count, &count,
> +                                          NULL, NULL);
>   
>               if (ret < 0) {
>                   if (s->salvage) {
> @@ -2673,7 +2675,8 @@ static int img_convert(int argc, char **argv)
>            * s.target_backing_sectors has to be negative, which it will
>            * be automatically).  The backing file length is used only
>            * for optimizations, so such a case is not fatal. */
> -        s.target_backing_sectors = bdrv_nb_sectors(out_bs->backing->bs);
> +        s.target_backing_sectors =
> +            bdrv_nb_sectors(bdrv_backing_chain_next(out_bs));
>       } else {
>           s.target_backing_sectors = -1;
>       }
> @@ -3044,6 +3047,7 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
>   
>       depth = 0;
>       for (;;) {
> +        bs = bdrv_skip_filters(bs);
>           ret = bdrv_block_status(bs, offset, bytes, &bytes, &map, &file);
>           if (ret < 0) {
>               return ret;
> @@ -3052,7 +3056,7 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
>           if (ret & (BDRV_BLOCK_ZERO|BDRV_BLOCK_DATA)) {
>               break;
>           }
> -        bs = backing_bs(bs);
> +        bs = bdrv_cow_bs(bs);
>           if (bs == NULL) {
>               ret = 0;
>               break;
> @@ -3437,6 +3441,7 @@ static int img_rebase(int argc, char **argv)
>       uint8_t *buf_old = NULL;
>       uint8_t *buf_new = NULL;
>       BlockDriverState *bs = NULL, *prefix_chain_bs = NULL;
> +    BlockDriverState *unfiltered_bs;
>       char *filename;
>       const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
>       int c, flags, src_flags, ret;
> @@ -3571,6 +3576,8 @@ static int img_rebase(int argc, char **argv)
>       }
>       bs = blk_bs(blk);
>   
> +    unfiltered_bs = bdrv_skip_filters(bs);
> +
>       if (out_basefmt != NULL) {
>           if (bdrv_find_format(out_basefmt) == NULL) {
>               error_report("Invalid format name: '%s'", out_basefmt);
> @@ -3582,7 +3589,7 @@ static int img_rebase(int argc, char **argv)
>       /* For safe rebasing we need to compare old and new backing file */
>       if (!unsafe) {
>           QDict *options = NULL;
> -        BlockDriverState *base_bs = backing_bs(bs);
> +        BlockDriverState *base_bs = bdrv_cow_bs(unfiltered_bs);
>   
>           if (base_bs) {
>               blk_old_backing = blk_new(qemu_get_aio_context(),
> @@ -3738,8 +3745,9 @@ static int img_rebase(int argc, char **argv)
>                    * If cluster wasn't changed since prefix_chain, we don't need
>                    * to take action
>                    */
> -                ret = bdrv_is_allocated_above(backing_bs(bs), prefix_chain_bs,
> -                                              false, offset, n, &n);
> +                ret = bdrv_is_allocated_above(bdrv_cow_bs(unfiltered_bs),
> +                                              prefix_chain_bs, false,
> +                                              offset, n, &n);
>                   if (ret < 0) {
>                       error_report("error while reading image metadata: %s",
>                                    strerror(-ret));
> diff --git a/tests/qemu-iotests/204.out b/tests/qemu-iotests/204.out
> index f3a10fbe90..684774d763 100644
> --- a/tests/qemu-iotests/204.out
> +++ b/tests/qemu-iotests/204.out
> @@ -59,5 +59,6 @@ Offset          Length          File
>   0x900000        0x2400000       TEST_DIR/t.IMGFMT
>   0x3c00000       0x1100000       TEST_DIR/t.IMGFMT
>   0x6a00000       0x400000        TEST_DIR/t.IMGFMT
> +0x6e00000       0x1200000       TEST_DIR/t.IMGFMT.base
>   No errors were found on the image.
>   *** done


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



