Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AABAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2625206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CVOLi4ZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2625206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtELU-0006z0-5a
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtEKh-0006TZ-Oo; Wed, 08 Jul 2020 13:58:11 -0400
Received: from mail-eopbgr150090.outbound.protection.outlook.com
 ([40.107.15.90]:8887 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtEKf-0000Us-FJ; Wed, 08 Jul 2020 13:58:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpBNtEQkDIhCkNATqq1ZYqy2VGj+iUz9qDZRHtMDzJIrbEDoqXbv+SOKuoQtExNVPhGEsJKU2o0c7VyxYtLYBW5bJH/LGpjfEBTRIahD2/fjS1ag45zBCiQ8+eUThCmKLPQ8kXs48ynjdVxuUHzEN7qfHynrlZyWTRP0aGTKGAipnIf/0dqIjgaHtFGF8v8EGYOVorLHr0meTjPC2usr/P64NZK20hTljNNu2nRtmYq400BGUPEMRKaigVx+uwKpq+WrO3qfY8JPjkL4f41vRDH3MtROC388nia4lJ8dYi+nGIpC0YGaWT5cup6cxHRnwTa9mJ6DcBg5BfHN/03cIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdRKSisfEXCf/SV1BCZILcdpo31hwxGF2fnjjlJw3Sg=;
 b=euOPOvfhOpzVGhww/4PMSpvXaSdsXzEF6/V9T6/Ri76AOtxJLF5ydfgxpet/vgHLNspIWdvrlqkLZ3bdmBDOMyeRlMAymi3JYQxllul2P24ci1xf1pCOlUBg4FhPK/CoE4KNyPbiHi4+BWs9qyDmjmNLmmiBdkRCWBmwRrJlwzVun4pro5L3vNceeAIZ8JRdwBHtknQjo2WzUeL2jzzk/DaFTFjvZZCUOoWY+HlKJR19zA+YCJDFnwEqN8KLfkjkHxevZjgm9/VBw5G+x62Ql67GOZuIl2Hc17335HkkOo737y8yGpBU1+YkJ2MxIc2HDn0hwdsQkcxu1Gq1cmun/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdRKSisfEXCf/SV1BCZILcdpo31hwxGF2fnjjlJw3Sg=;
 b=CVOLi4ZQWh/FtLVGtaQiInM19YVWyR9Ai0sG1NK7t0QFTI0ZSIG6u/a7Ri63k0aMmiue6TUw8YBBXxq8idu6YmVVYZoQG5Zfe12P4zrwsggO0mHXbn7mq6w1C8okOHWYGXic8Jg46OuwPPPodWDzdQdD/nKEf3jZryJdfuquaDk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 8 Jul
 2020 17:58:06 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 17:58:06 +0000
Subject: Re: [PATCH v7 10/47] mirror-top: Support compressed writes
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-11-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <189619fd-de68-8f85-a8d3-99346f90f4ae@virtuozzo.com>
Date: Wed, 8 Jul 2020 20:58:04 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-11-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM4PR05CA0004.eurprd05.prod.outlook.com (2603:10a6:205::17)
 To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM4PR05CA0004.eurprd05.prod.outlook.com (2603:10a6:205::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20 via Frontend Transport; Wed, 8 Jul 2020 17:58:05 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba76afbb-69b3-4efd-8743-08d8236877d3
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB261070A815D8AFC39C156D30F4670@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aU+9cjczSDKHAGO4MIYBHmyvCSHdfS5HTexlGNiCwxxrZp7qN+RfgGbtylAcfXj4ga59O+tejWKL5fD116dPo6GDaPq+nzffaqI6wS+TCVYSdWdGqlidUPe9OJRi9d4U7HT8irRBRPtYwEZN9GPalY1MGXa+6nTcsk8JYHBoRucYJpy/qS4RkEYY5G28KQFrDQJiIa0JyExi9S5he7IfYThJUjKuRtroSC5SE+2Agq1PTcs7ZyhOkzDwidzqg8F2D/zGR1HZIZ7lC4xLG1P0Qb/gCDmERIxJnwAvqgeXIxbPGq9SVgzkgMa/meboTg3C6gpnVqwBCYFJP0+yt4rlsCvwpLRme56XG4z5XtO4Y0vNaxsJ4BnWd26yvUpvrz0m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(39840400004)(136003)(366004)(44832011)(4326008)(31686004)(8676002)(956004)(2616005)(83380400001)(478600001)(6512007)(8936002)(54906003)(26005)(6486002)(53546011)(6506007)(2906002)(186003)(16526019)(5660300002)(316002)(52116002)(66476007)(66946007)(36756003)(86362001)(66556008)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fRBC3/baEBRtPBDA1uKIrMuG8JYvRZwmoY9u1BzmgOIfzciDsRSZI/2olV2OQmESkK/HNi2hrHuEG5FvLJh1LhbKpcOptPdeXyOozjJdow2LLLynPyIQp4cUi0BpJiShNp1HXPlsww1pIoVzXAIynh/F0AFAE6dTT4p1P9fRaey2Sff4pQQ4/CBCLUhWBb/sc689PfFG2bQiJVEbJMONyJLsbOntNjGkJgYJEv9tALdygfvx0aAeWYdyP2neJO48yR3Aj+goZK4tgPgLBhkiXeKu2C7KgC0Mfvsj9/ub389SGHVUGFyrXIyJBzg6yZshnAa4NeclpFzN8u++oE/lbwKUtYP+IGLvnQdN0fzfIcYXqESVqtpImSbjwNVXc0iWKeS9uh++ykrlAbNf2DfJ2o1qIpCyAIkOjrsfsXdSBWdfM6nhBiVkIalzVyZ9nrCVDBHQjfrPPbOIgNGf7l7jEXlL+72ePDkrKvjUYq3SzvfL7N+rtRcgB3QsfDAM+v83
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba76afbb-69b3-4efd-8743-08d8236877d3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 17:58:06.8156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvL/0VGaDlWuaTKnr4noCwNwcrnKJJOXMXvm2MOLYifYBXc0U6VE8UXf8lAW6gHkMu3Oib/7JBSPVcQgUvkDBPwV2iD9IAZfRTCKpFNMQsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.15.90;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 13:58:07
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
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/mirror.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/block/mirror.c b/block/mirror.c
> index e8e8844afc..469acf4600 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1480,6 +1480,15 @@ static int coroutine_fn bdrv_mirror_top_pdiscard(BlockDriverState *bs,
>                                       NULL, 0);
>   }
>   
> +static int coroutine_fn bdrv_mirror_top_pwritev_compressed(BlockDriverState *bs,
> +                                                           uint64_t offset,
> +                                                           uint64_t bytes,
> +                                                           QEMUIOVector *qiov)
> +{
> +    return bdrv_mirror_top_pwritev(bs, offset, bytes, qiov,
> +                                   BDRV_REQ_WRITE_COMPRESSED);
> +}
> +
>   static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs)
>   {
>       if (bs->backing == NULL) {
> @@ -1526,6 +1535,7 @@ static BlockDriver bdrv_mirror_top = {
>       .bdrv_co_pwritev            = bdrv_mirror_top_pwritev,
>       .bdrv_co_pwrite_zeroes      = bdrv_mirror_top_pwrite_zeroes,
>       .bdrv_co_pdiscard           = bdrv_mirror_top_pdiscard,
> +    .bdrv_co_pwritev_compressed = bdrv_mirror_top_pwritev_compressed,
>       .bdrv_co_flush              = bdrv_mirror_top_flush,
>       .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
>       .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


