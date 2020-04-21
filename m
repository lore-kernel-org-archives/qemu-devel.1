Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B89AC54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73B92076B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KBM4n5sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73B92076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQsUw-0006Kk-3F
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQsU1-0005h6-0t
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQsTy-00067N-W3
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:58:36 -0400
Received: from mail-eopbgr140094.outbound.protection.outlook.com
 ([40.107.14.94]:25155 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQsTy-00065c-3D; Tue, 21 Apr 2020 08:58:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/4fR8DW9khvdhValhOEPa6B6Sch146mTt6m4KZUZUs4cUyTYz2frHB5PE49FPg60FItUz53WUo06DO4ydxSz2KalEToTfM8rlzsuMGSc1ZwvgTS9aIqL9BWic7LKBUDFn7WVGb97WflxHiltO8dXjFfobe/O0i0b6OfaAQBH8+3FQ3H0cWr9VJFb/qvusGMBZzUOrQvlpIYPlPGlzng79OCfpxgzrftAt+Di750yoT7NnJhpmIZdBZNjgmrL4d/3fGfZWSQo6S5Gyy3uL8YeHy2oPt+u8+BEJpRMtEi2VT3H1JFnL8IDSbrEHWyQnQnxIJSO+9R4S9n79HskhY1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shqSR/rB1mi20IdS5h7ksBnDK7XhIToz9Q8XajsY5ak=;
 b=H3ECKzsnQ5Jt0lzSgQVJe3yIyZo1mbCS0xeqauacAldZbUKkp4AVFnurB6gHGTSEA9HIPr350PwHuAdmvWX8i6mwrivgEf+ARqn4b6K6HZdyDKJZB5sQ3Q319yyouow4GESXZkBof5cM5eF7YU4ElA1r7DGainP0t1nLBueQozPfqAG//zHKJJJnik1poEqzvvnKqW/+pE5bDRvs2v4t2eKW9BfWi22xS6jbQmsdA1xK2Lu/jye+hSe8+5w6jUbIQJ3r6FGfByu53i78iGfQoinx0LVobYJHe992lS2W3y0UODM2sKJN8GJmtktqtp33jxs7fXdCM8qhj5AoqtzapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shqSR/rB1mi20IdS5h7ksBnDK7XhIToz9Q8XajsY5ak=;
 b=KBM4n5skzueDN8pF/3CJTGptSCszRDNVcCrNNa2NXUeIp/4ZI9XaffTds3U6ygxReUK1NyXLEDBHlVk0MSHc7lqfaRjE9qQpCsIn4+C4WEVEaou/akVD7T8N6LRjPep5NjMnOGTcYj0tSa1R1FV6ZqtF0tjI7WLz7isZ120nzP4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26; Tue, 21 Apr
 2020 12:58:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 12:58:29 +0000
Subject: Re: [PATCH 7/7] block: apply COR-filter to block-stream jobs
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1587407806-109784-8-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421155827231
Message-ID: <17237b84-d71a-0648-4614-65515b4ecc30@virtuozzo.com>
Date: Tue, 21 Apr 2020 15:58:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <1587407806-109784-8-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0140.eurprd07.prod.outlook.com
 (2603:10a6:207:8::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 AM3PR07CA0140.eurprd07.prod.outlook.com (2603:10a6:207:8::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.6 via Frontend Transport; Tue, 21 Apr 2020 12:58:28 +0000
X-Tagtoolbar-Keys: D20200421155827231
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38f8113a-b30b-40a7-a215-08d7e5f3b001
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495EB7D4BE0745D177FB8D7C1D50@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(376002)(346002)(136003)(366004)(39840400004)(31686004)(5660300002)(26005)(52116002)(8936002)(66556008)(81156014)(8676002)(16576012)(86362001)(66476007)(16526019)(31696002)(66946007)(478600001)(186003)(316002)(6486002)(4326008)(107886003)(2616005)(2906002)(956004)(36756003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCjKdPBd49gMITIuF0TNWuVNCd2QJPjnvzaZmfS0l1zduimfe3TYAanRGlA+haQ+ip41p0i0YCJKKxodlW1A06Jb0Zv4pQ57fg5BxbmYjHI2OOsCyzvSUZuad7dp5MR7UyZZqGEvuW6BV141rUYOVijkJYC8jUuH026tMCUUozN7ne3YHGyVplftMwEj08re0MRaiHyf21myJaC+j1U26nylNXNcIDS9k5kdhwbAKS3FJj6YIhLeyQUrePEQWbaFESiLwfu/1krh5t3loWMbu/0GCy/QDR900e0tfRYk7cDyAsGPMBtzLsEbzKW1uJdgzb5fakIfs/E6eUi3qW8pLluWqxSGkUJ4A0PJgq62Lbo5t1OBtH9bG1VdJh9VvMPKkmcCWnWHum/g6wJyhwd4LYCm7tBK9YS7XsVZ8jzCV40iyX0N9iK5hkGUIrjrXXmZ
X-MS-Exchange-AntiSpam-MessageData: VFOMJvrs1HteWxjTW3Bj0gW50Avswp2+ZJ8WLZ6CqFU6N32aEXVXNTcrNid4J8Bm9YNQhhPsizUmv3UjLkSeWos8ElZpZNH6NsxtnOOkVMPD3XtFJKJWms134Ql/R2kiIdDeaiCQg3VepLpb/oaqAg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f8113a-b30b-40a7-a215-08d7e5f3b001
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 12:58:29.1882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWNBlxUlUElEWVwilwCrQO8+KP/kKQceQSbUjgGQkUAkiGP9T1e4LZGDjDyw5rnw7HAj44vW4uFZshtmij9lxwYyiQtU2cJ+pySG0ERa3I4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.14.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 08:58:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.14.94
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.04.2020 21:36, Andrey Shinkevich wrote:
> The patch completes the series with the COR-filter insertion to any
> block-stream operation. It also makes changes to the iotests 030, 141
> and 245.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/stream.c             | 151 +++++++++++++++++++++++++++++++++++++++------
>   tests/qemu-iotests/030     |   6 +-
>   tests/qemu-iotests/141.out |   2 +-
>   tests/qemu-iotests/245     |   5 +-
>   4 files changed, 141 insertions(+), 23 deletions(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index fab7923..af14ba8 100644
> --- a/block/stream.c
> +++ b/block/stream.c


[..]

> +static int stream_exit(Job *job, bool abort)
> +{
> +    StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
> +    BlockJob *bjob = &s->common;
> +    BlockDriverState *target_bs = s->target_bs;
> +    int ret = 0;
> +
> +    if (s->chain_frozen) {
> +        bdrv_unfreeze_chain(s->target_bs, s->bottom_cow_node);
> +        s->chain_frozen = false;
> +    }
> +
> +    /* Retain the BDS until we complete the graph change. */
> +    bdrv_ref(target_bs);
> +    /* Hold a guest back from writing while permissions are being reset. */
> +    bdrv_drained_begin(target_bs);
> +    /* Drop permissions before the graph change. */
> +    bdrv_child_try_set_perm(bdrv_filtered_rw_child(s->cor_filter_bs),
> +                            0, BLK_PERM_ALL, &error_abort);

Hmm. I don't remember what's wrong with it, but something is. Neither mirror nor backup do this now,
instead they use some flag, that permissions are not needed anymore and call bdrv_child_refresh_perms()


Also, strange that you have insert_filter function, but don't use it here.

Also, could we keep add/remove filter api in block/copy-on-read.c, like it is done for backup-top ?

-- 
Best regards,
Vladimir

