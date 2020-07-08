Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160A7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BDF206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HNh4aw9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BDF206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtDn3-0004ij-2F
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtDkX-0001Qb-2e; Wed, 08 Jul 2020 13:20:49 -0400
Received: from mail-am6eur05on2104.outbound.protection.outlook.com
 ([40.107.22.104]:40737 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtDkU-0004Yc-Ge; Wed, 08 Jul 2020 13:20:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTPFJxQZCty9Plf+kBasESdRepaGIX/94Ecnh9X5LGcFZjjz5fdl+EtmhKwIYvWQMhliQK9hhpGlczOzM8KWcyGsGjRPkdtPHmP3iGYNSRjh1uH78a1WjGQTHrOmXIbUXhgTRsCMf0qPoIyXKfrg0ggHc5f73ezo9qcbAmVBoCm85zRTJD0YNiLZtAFm6ECoE1h3qobTbyyIge0IbpSjefVsZ5QYbiEakvQaRUfTjwUToVeNTaSfy5RGbWkrmXg9HJdIHYlXI2fJSMEkBCZZyWCwWCevF6Il8nACiLG2jRy/q+xLha6A0dWSDx/3jTjNdCNvlyV//6JSlAUp8xruYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbe1FT7qtlAqlJJ5wRDAJuCilA7x8qVW0HRofJsUlmQ=;
 b=jPEgyF6VZVYRXvvMzyuzBOs4yPP3/qb7RsYbjnFbRTKcdkI1k05aPDooszI9CMne1azigmcURRd/+g/8T6WbAcoBI77ENZ0YrI/fOFj0EvWcPnEC7YHE9k9WgqCVNqY9Hdystn99chxfF+SkTix/JyzmWLdMKQ4EpiSpZHUWWJ3b3kQoADnI45wlCd/QUQ1x+HE3Sh+PGLqskpPXNZ+bjnfCmCZaaqU4/C2qhQeaaXtdvLd7Lah1FxozQupvpkyjQK5bhPL02bathBQSNKZJZOoF1bqZZvBtnZp98N9HykxPPDXf0pveB9FZmcvfR4uOQdVaKlZOFfNJnePP2QSDVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbe1FT7qtlAqlJJ5wRDAJuCilA7x8qVW0HRofJsUlmQ=;
 b=HNh4aw9RuhqaKNHMF34++Go+blohbEpURkjCqATlGwCfNvvtwjY/P3fbiveXlKYm3f8kd0dmhwqGMQrpZBG7rArt8yFpf5GfWBcMmoEKbslEVjg8S7MWVYgqD4niA9HDZnSQQ1FMSWcdpzwmhqy5msjmOzruv3ZIdyVX8YuMFCI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 8 Jul
 2020 17:20:44 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 17:20:44 +0000
Subject: Re: [PATCH v7 02/47] block: Add chain helper functions
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-3-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <5c2a81c7-851c-aeb4-84b7-3bd61417495e@virtuozzo.com>
Date: Wed, 8 Jul 2020 20:20:41 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR04CA0051.eurprd04.prod.outlook.com
 (2603:10a6:208:1::28) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR04CA0051.eurprd04.prod.outlook.com (2603:10a6:208:1::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 17:20:43 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98180d13-403d-4df5-a12d-08d823633f1d
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB42152D0D63869B027686DC39F4670@AM6PR08MB4215.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5n/u05m7s+ySi7PTFnqKYFETatEDUKVbdxYvyo2xLZrNus0sE5Ww7Uwq+lKEDCan95ZMziqtDD8PNZA7PcPlqHe/8n2W9ulOokyb/gRZFgAvHqgF8nfDsakM1lP5FQMIsEk1/p1MMuyy0Nf1jRwN4S7JX9DcUIPEFooHBL8uQZEfvPuXQmL+xAPBqi2g0dqDiGebpW6ZO49Zai6FysQ3AOxu3alUrPNsODxsnyUBKdjQJQzP4Hj+3zDfKHdle3u9vJOgfIMDeo9ItY6fM7MgYOhlRcZhrPu6+WQEhMmlI4oU19r4lIvg/d20RkOI0kpjMkhvXKVg2gRbDys/MdfJTGQvVIskdZGU5UTZTPCCrtznwpvqDtxdgZsQSxobvlR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39840400004)(376002)(478600001)(53546011)(6506007)(83380400001)(5660300002)(186003)(8676002)(16526019)(2906002)(31686004)(8936002)(26005)(36756003)(31696002)(86362001)(44832011)(6486002)(2616005)(956004)(52116002)(54906003)(66476007)(4326008)(66556008)(316002)(6512007)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cvHfYkZ6bqusq9tG+6E+qlrLuK+fPLTJ2ioPU5H81txXb2NaBfn2ESv9migp8hwm+wqgnEfqhgD193PHOFqyySCGjTY9xYwyQuswMsIPKnuGA7DXY3Lj+fC/abaNbIzRw1+AaIbflS4i2aw+FSvc5Cg/uPIle7TKi598ZtGt+7gmNhqpZuZluXK+a9v6PnDrfILviuYHb61yADFkEch6nOaallaaX/6Wp7swltTGAssbkSbe4er7WFNHRHsW2BWCm87y9vzWBuVS2AhYia4LHBQugmsYUOD8AYzsrQ1qVTaIdCTgkv3KjeQ1O4ukbWg9Uxsqr375ACUUZu8JRNIFMLP9k8LF+qXVPHwgJaJVyEkKocmHcTyy0HVAKsac7iZxGxRG4Af1DMN7NC3XxNpuGMehF0dRJP4lT7P3THg1En+ew/Oqc4rMvfn9C+5Hto4jQFGv7UIRJMrZBpcwLQLyXK7nuCKCgCVSmRHMpF+swO1r+/+cm4G0GUrvhD6jOBcj
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98180d13-403d-4df5-a12d-08d823633f1d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 17:20:44.2345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NeHV+naRFP1XTYnkJ0KzL+ox6xI7tfNPzqKRxxWmk3Yyjfj+vDaQKl0JQqeBIdQdaD0YqXscET2mPswlu/0ez8z27IL51vlotHJ1THICU10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4215
Received-SPF: pass client-ip=40.107.22.104;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 13:20:44
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
> Add some helper functions for skipping filters in a chain of block
> nodes.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/block/block_int.h |  3 +++
>   block.c                   | 55 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 58 insertions(+)
>
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index bb3457c5e8..5da793bfc3 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1382,6 +1382,9 @@ BdrvChild *bdrv_cow_child(BlockDriverState *bs);
>   BdrvChild *bdrv_filter_child(BlockDriverState *bs);
>   BdrvChild *bdrv_filter_or_cow_child(BlockDriverState *bs);
>   BdrvChild *bdrv_primary_child(BlockDriverState *bs);
> +BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs);
> +BlockDriverState *bdrv_skip_filters(BlockDriverState *bs);
> +BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs);
>   
>   static inline BlockDriverState *child_bs(BdrvChild *child)
>   {
> diff --git a/block.c b/block.c
> index 5a42ef49fd..0a0b855261 100644
> --- a/block.c
> +++ b/block.c
> @@ -7008,3 +7008,58 @@ BdrvChild *bdrv_primary_child(BlockDriverState *bs)
>   
>       return NULL;
>   }
> +
> +static BlockDriverState *bdrv_do_skip_filters(BlockDriverState *bs,
> +                                              bool stop_on_explicit_filter)
> +{
> +    BdrvChild *c;
> +
> +    if (!bs) {
> +        return NULL;
> +    }
> +
> +    while (!(stop_on_explicit_filter && !bs->implicit)) {
> +        c = bdrv_filter_child(bs);
> +        if (!c) {
> +            break;
> +        }
> +        bs = c->bs;

Could it be child_bs(bs) ?

Andrey

> +    }
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


