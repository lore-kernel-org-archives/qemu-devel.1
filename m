Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F846C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2920B20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QVLTEz83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2920B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvNC-0007zs-Et
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtvLr-0006eY-7K; Fri, 10 Jul 2020 11:54:15 -0400
Received: from mail-db8eur05on2124.outbound.protection.outlook.com
 ([40.107.20.124]:16012 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtvLn-0000wy-Ec; Fri, 10 Jul 2020 11:54:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmO0g2FBbFI7LURN7WM3wtmNFu+/H+TSesvz0y2oXhTr1KQl+aGRLQswkMpnIIJnMyq5bCXK0WPFglkbciSksqEKn+79CRvmbZmdFsDRI9KSJshXq5sTWPwpyEPrV9n/tN9CKhL38U1oSmVtgA2rf0x0XdPLZKS2YEk+dNYw9eJ5f8m8l9Usvmc0eQL/E96iyWkI0m2HgIW969EfCUik6OGR0I8F3P5fAoSsxNMOaHOFcFvDtq7PdOnIhQ8sMm8VhNlvXxChtpDYDLIUM4oHkK+vRK6w2rM1H0RVRg8pLUAm1tLVjKigYuBoKt14/3hnnXVH+PvyAdZO89i3ZoO6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuvKlsO0ui3i+/+lZMRUx4yIliTGRa5dVSlGG822KK8=;
 b=Pi+Rzsur1KbNOTrteBB2Ynyj7jisnxFUyZRUDO7H59q3LzVPgYIzly/5Cg7A0VohHDaCM+dS203rmXvgKZbdlrfPVAm3/w2CIxRzFcC2+iJ3rMcc4WtkGxkWnbZzYvL8GCh4/duQEPUAxqV2dfv6/H4G80K0IF8Pg+TB0tYfWQLO4dOIdH1OGwZC+IIvfF7dLPHVdocgAHaxboYqKPYPphXuPd3tPwwmnpNNtUEtN/dVOO0MtV+oR9csqjZgB90hOIIv9TtIwZpKmUhtOFX3xOtIcIRQT1b6AVYzUToZaT0Iroy8jzZDsgpECSN1zSTegL6hilaGgFdpFFeo+sdH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuvKlsO0ui3i+/+lZMRUx4yIliTGRa5dVSlGG822KK8=;
 b=QVLTEz83tWTcoCB5jGee2tsd19gNQb67PRAMkGoyn9fzHm2QcBpJ472ySZQ+05ZSJfU8pPE/FWdVKyBF3Qfava+cAozSt9kKfgzhzk8kQSqTO+qW3zwdVAJIYZwWzJEvN2LeuQ/qa0RmEYQqkcbt5TjbvEOMGNRRakZRYHGFnK8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM5PR0802MB2609.eurprd08.prod.outlook.com (2603:10a6:203:98::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 10 Jul
 2020 15:54:08 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 15:54:08 +0000
Subject: Re: [PATCH v7 16/47] block: Use bdrv_cow_child() in bdrv_co_truncate()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-17-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <4ea280fe-6ba1-7a2c-176d-4448de718b75@virtuozzo.com>
Date: Fri, 10 Jul 2020 18:54:04 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-17-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM4PR0101CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::51) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM4PR0101CA0083.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::51) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Fri, 10 Jul 2020 15:54:07 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d0ca910-5f02-4aa4-ea20-08d824e97ab0
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2609:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB260925D61388DB4AFBB80AC1F4650@AM5PR0802MB2609.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpK5skjXxCFhJp2mLf2kwFDPlniZTFw1Iohb5UbJdn1r6KvQLpAHGC07V4oTytaewtx9NxpIcq16MBJpnMMYnVV/yUTDkZ81qM7cenyD6hqGz1fqXO+5QZIhXquQ+iLyfb3TazwlhOy0wEC856lyADC6pyfjWyjMAbuVjYUw+eTyPaPPTMhSsd9PGBeVmsYO8rOsnx/aHETrlasxEECrFiveK7WGlEdBBxuA+J3FL6PQzKhmJtOtpcU/hlsJyThM4MXMBzafTv/ycRaS++ZDYsR/l/Yp1/HC1z8wfNj84DmmdHrY15xC0xSoswVqvenQq48Mp0tusNLO9zOCmJbupwwe1IL7eiWsSOADZw+zi1pnuakwBKZ8TFAOj+foMBuK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(136003)(396003)(346002)(366004)(5660300002)(16526019)(54906003)(26005)(83380400001)(36756003)(53546011)(52116002)(6512007)(4326008)(6506007)(2616005)(478600001)(31686004)(186003)(44832011)(8936002)(6486002)(31696002)(8676002)(956004)(316002)(66946007)(66476007)(86362001)(6666004)(2906002)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: uqzjB8MMdfuaOxM0Y5oWxGRPdgU66xH4af1axcKetXDp6YyH4LH0/NucEF85/Sr/lQyGyrIVSXrYcQdHkT9V7uYDvq/IqhPiO5M6aGJtH6GKn95VASQxG4CdipfH+CP+HcZWwllVPJb3lLpe6quX8eyBmTtgDEOq5brfcwkjEw4SD4Eu9yDbFbScnZliat99mwBMUFbtSpYsML/ZhCZY1mHXrFPjuLlDQS4qkBII3afmX8LkOyMCFztm2rHcsW2jRp/GpzzxXaInpeKZqaodH8qZh/hYES3zbK/5IMpxWQmuw2c492LTjZnUfcgUxsc3DNxVIOHu+LfziinAeb6qlJhWKSvjJt55i3UiyGIQMtQdrNzS1v/4hBSmN0FGwiiaOH5oMmTy/JMWUeDaBsjYe9hRWJ27OMRaTtNHFlt6TtuHR4TA0Kr3sttF4FLUSw62q0Kt4sqldBHUKhRm/qItskOM/XOuciwWzI9pAws3hYgrzhNzbPbNSB2Fxmpxgfqz
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0ca910-5f02-4aa4-ea20-08d824e97ab0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 15:54:08.1607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7NlDJf85aAzsYK2fHrqmNelNBlLR4CCyHXrngAaoKbv9sCWyj8C2pUSoy8sKyNAhjJkBESzG0JxMIfb4ZE2iLgCmivhV5e7QhC3B018vDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2609
Received-SPF: pass client-ip=40.107.20.124;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 11:54:09
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
> The condition modified here is not about potentially filtered children,
> but only about COW sources (i.e. traditional backing files).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/io.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/block/io.c b/block/io.c
> index dc9891d6ce..097a3861d8 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -3308,7 +3308,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
>                                     Error **errp)
>   {
>       BlockDriverState *bs = child->bs;
> -    BdrvChild *filtered;
> +    BdrvChild *filtered, *backing;
>       BlockDriver *drv = bs->drv;
>       BdrvTrackedRequest req;
>       int64_t old_size, new_bytes;
> @@ -3361,6 +3361,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
>       }
>   
>       filtered = bdrv_filter_child(bs);
> +    backing = bdrv_cow_child(bs);
>   
>       /*
>        * If the image has a backing file that is large enough that it would
> @@ -3372,10 +3373,10 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
>        * backing file, taking care of keeping things consistent with that backing
>        * file is the user's responsibility.
>        */
> -    if (new_bytes && bs->backing) {
> +    if (new_bytes && backing) {
>           int64_t backing_len;
>   
> -        backing_len = bdrv_getlength(backing_bs(bs));
> +        backing_len = bdrv_getlength(backing->bs);
>           if (backing_len < 0) {
>               ret = backing_len;
>               error_setg_errno(errp, -ret, "Could not get backing file size");
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

