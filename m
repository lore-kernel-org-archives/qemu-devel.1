Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D634C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1745722B4D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Bl0dh0c+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1745722B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxXUC-00044i-8F
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 11:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jxXTF-0003bB-DM; Mon, 20 Jul 2020 11:12:49 -0400
Received: from mail-eopbgr70101.outbound.protection.outlook.com
 ([40.107.7.101]:6423 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jxXTD-0003DF-JD; Mon, 20 Jul 2020 11:12:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpXG5bFD9ja3kRmlrbpzmnaVFNCfv6eCqCCdF/8msnrJ8YofUKkc7JPRhnWzqQULDp+sO13EsGrfAO0Lh0FJcYz2mz/qK2YEn4tF0bLwEr3Vivy5xfl16ogCs5/02iQYhZpB8v1w4rx+okgdrtfb4tcbGr45XIWhfUnigEDkFAw0iSIzX1XPENeb//e22sHnz4ZKie1MrcDsngLyhhwxcYUGfgAJWbV+bv7fM14gWg9q5dfK/EGI5DdB9MlN9ICtjEnt39BbFAupcKD9wptwYXILHMMEqt85jwm/jK2/Tt8uXptdUSnTodsMXnIfZlFPi8wJ4ev67zJm32eOjtPkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23PuekRZfdQZixjcQBNCpLlPGCzLex1CrA8GE/B2az0=;
 b=ljAqzItA6pTHR4yMl0JPdfElScgQNHuZXcguqwWmRLBvnOMpWymPkxdqEUhJUbjuxEjtlv1ISJ8Um+A0z+UOahMrmYQ2/tChPZohqnxr9g/1ZmMkQEjI9zU/bZ9xlm3RilI097Mie/VoxuQYvkDScSD/YW6fh5iPOB8hrsq93O/xaXcO4U+qB0Izw4MccaylMo4+mUFx2d+fPuACYuUbKeMfAIWCUiyavcw0L/ylwRdHXolVftVYcCEvSc35jEbRBT/TXbUthOuq2E6O43YzALChRgZ9Dkb7HGN9LTk9ZWGYNNb9LVIgn2Dk47RbkpoE1Usitdblav2RC5PqR7dNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23PuekRZfdQZixjcQBNCpLlPGCzLex1CrA8GE/B2az0=;
 b=Bl0dh0c+R6HWN5dtOfChrZb+MxfP04/36FKjglNMnBPrbPs8PnfaaKqMshsyblN72rhJgrutX67FLMFBYfc+fyK+JTghdVAaBPYW4QhyLctbIx9ZPgCMZ8SQgk0BcNphe+rwuYNkydthFgyHd+rrVxzxSEKdGKLBTamXAEsjCqI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4408.eurprd08.prod.outlook.com (2603:10a6:20b:be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 15:12:44 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 15:12:44 +0000
Subject: Re: [PATCH v7 26/47] block: Improve get_allocated_file_size's default
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-27-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <7a5890d9-57af-5eec-98fc-951489026397@virtuozzo.com>
Date: Mon, 20 Jul 2020 18:12:41 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-27-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM4PR0501CA0064.eurprd05.prod.outlook.com
 (2603:10a6:200:68::32) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM4PR0501CA0064.eurprd05.prod.outlook.com (2603:10a6:200:68::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Mon, 20 Jul 2020 15:12:43 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82184eaa-4e59-4909-050c-08d82cbf5a95
X-MS-TrafficTypeDiagnostic: AM6PR08MB4408:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4408D58ECCCBF7356755407CF47B0@AM6PR08MB4408.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggoG2IZddcNuwZ5YyeLvGTJsX2lzz9tPyQCC9oHboV8FjwrIstch5ETtq9WIYPwJTf9hy7NN2J4rO/2ReIRaK/Jgv1Qf6kb2QL/upP3E8VLr2Ti1vphrJPdoJSd8xY/2Z9HvzkkaabQ2Wb08ELHKLRP2SD+jWYBTooy6lK8Tb50ytzLWGzYjgvYER40xyl3l1aA1E3/ze9qKr3XV3AVunBizh6RitIQwuo+juyTy3f0I4/+rVGNZRDO+S32lvrMbGgz9oKMSU+ilNwtJ1O2gM3RSRj2dWXIeP/xJ0Cj9nosULeQu7Jkfm5eGOi8A9zacbFR90UWE9YxCNhr5HKLTfBw2Dc2K6VPwty9n7Gtod3NR+FVrbWELvXytAgoWeLQZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39840400004)(136003)(376002)(53546011)(31686004)(4326008)(54906003)(44832011)(6506007)(36756003)(2616005)(316002)(83380400001)(956004)(8676002)(26005)(478600001)(6486002)(5660300002)(8936002)(2906002)(52116002)(16526019)(31696002)(86362001)(6512007)(66556008)(66946007)(186003)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TdRFRfgk65YL6IRRy1Htbhyt/zbGZdkIRWS3Qi2JTDJTuZQsFFEilgjgDdOdC8P292a7YCPURa4BWQUNY4TpjJC23NqXn5BMCO5qJ3GFE/poQsm77Zpp1vHXqtdxPXkb8cmuvNg+zRsUVh6VFOT+mjM8sqhykzDXXDr1GMDPkry977XjZ5LjKDBV/65TIoUvGTCjOmh2gg1pARTgI25JQo8JPpsDcf5yachDhbw6ikB+LD+5AiEqplSPYVjqhoCwPkRzh7im4r9sb+/MBUWrl2axnbA7zyfxHkRkSxPuGzJFa9Rl0ZEa2vM6CJW1Jbf/xQBR5azld7WZovGYGJF7hWLTJRS/6fTDmHBn3G2Pbt/i3Y/tcNFYmShyHbUAPwFx7W+BQy4Ve/Kua+/3hatYU57hGZJjuF92Qkbz3YM1f30ASAxkx0KKOex/IrnyuO9ff/9lfjkKrdwlriPUaWa0RT/8d9XOedV/hrFEE+Qe5/zKw3M1GQxByx9q7pmepcCM
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82184eaa-4e59-4909-050c-08d82cbf5a95
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 15:12:44.5035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfIwlak/+VOoVBJxuzcPTP7aafxYGQ8HeL4BMzGwmwq5Bq75mIdkZlIaT1Nqqpz78Ovsfu/cG7SaYbS28jBj2Wqj0gPoOfvbEFMIuiC8304=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4408
Received-SPF: pass client-ip=40.107.7.101;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 11:12:45
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
> There are two practical problems with bdrv_get_allocated_file_size()'s
> default right now:
> (1) For drivers with children, we should generally sum all their sizes
>      instead of just passing the request through to bs->file.  The latter
>      is good for filters, but not so much for format drivers.
>
> (2) Filters need not have bs->file, so we should actually go to the
>      filtered child instead of hard-coding bs->file.
>
> And we can make the whole default implementation more idiomatic by using
> the three generic functions added by the previous patch.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/block.c b/block.c
> index fc01ce90b3..a19f243997 100644
> --- a/block.c
> +++ b/block.c
> @@ -4997,10 +4997,21 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
>       if (drv->bdrv_get_allocated_file_size) {
>           return drv->bdrv_get_allocated_file_size(bs);
>       }
> -    if (bs->file) {
> -        return bdrv_get_allocated_file_size(bs->file->bs);
> +
> +    if (drv->bdrv_file_open) {
> +        /*
> +         * Protocol drivers default to -ENOTSUP (most of their data is
> +         * not stored in any of their children (if they even have any),
> +         * so there is no generic way to figure it out).
> +         */
> +        return bdrv_notsup_allocated_file_size(bs);
> +    } else if (drv->is_filter) {
> +        /* Filter drivers default to the size of their primary child */
> +        return bdrv_primary_allocated_file_size(bs);
> +    } else {
> +        /* Other drivers default to summing their children's sizes */
> +        return bdrv_sum_allocated_file_size(bs);
>       }
> -    return -ENOTSUP;
>   }
>   
>   /**


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



