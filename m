Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97902CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:16:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C15D205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jHWIRUMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C15D205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYYVo-0000U0-He
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 13:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYYUo-0008Ig-Ka; Tue, 12 May 2020 13:15:10 -0400
Received: from mail-eopbgr60125.outbound.protection.outlook.com
 ([40.107.6.125]:55429 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYYUl-0000eI-7d; Tue, 12 May 2020 13:15:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqNCsghBAQ4tj8kGgPy7tgFQXJ1OXWdKrVCEdnUFFrsR3CiBrtmyhfOFpQe3DG/R7SemvYlJyEunfwYSs5h7bGCb4+O8eycriIe6sRUgUkdhNZRWSdoSLZCR0caHS9V9+xt1FwifmZOiPIomNq4NJ7LwjSoOavHFFBfQ/SNTjXVXN1cYxyJhubdfh/fNARFEDKOtzucTVMO6z3lGQWS8JULVaFDalTmXhVg9YfivAe20PUWJbdjak5aNPcF/i5pPO2+P7sUZgWUv/OhekbKqfdV5RgIeUQvkggERoM/wfnyqwk7MbCB2ItLZM/FkIoz4R2PMwRX7oJMsH+Gg9YEAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkUmHUzvKDbPFEGKV6gOwiCLkt4TyYzqqw9VAss6ct4=;
 b=TmxCIMM29ni2l++W9ZM+Fj2C6Cvtc5dtWFUgJQfjN9ps24HFpOZcTnUcJpKz3hdmFS2ALn6n0cF4fyswMQrUSoTtaDcLB5Q9krAAf+vUBEu4XRciQyQ1OLv9aFz5+rGD5w+q9B6Lv9g6n5eRTaoavj2g35HI0lBFuJEzYJVkQFTEVGgzVjXXHp0xpA0WVVCfJLLdRYhiOoPp9Bg/vIt08uhPeOxInySx4OMqeMDh8y4mwUHOIoCs3De+dWBSp9zKri3/+jD+CzSLOeS1sB9T4/PEf3O26adVw7mV2pLQUd1veZNV3uLIdcComGVEqzgV21nqVjLJqq/ENFqHBrGbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkUmHUzvKDbPFEGKV6gOwiCLkt4TyYzqqw9VAss6ct4=;
 b=jHWIRUMt8f1h/qxjlPBVN61ytGKvGC3yyCuJh3kzNt3hHk1btFEn0fxI3o5RuLzqMJv6grAAFHzsa+lNio9uQWE2jFSJIc5j6sq+7ReTcw/Fgjqshg9u30pp19NwBr3hhMpc4W6sGp7p378r5GiQs+jKDxtdbzguBn0FHaw2v6o=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5461.eurprd08.prod.outlook.com (2603:10a6:20b:10e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Tue, 12 May
 2020 17:15:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 17:15:03 +0000
Subject: Re: [PATCH v2 3/4] mirror: Make sure that source and target size match
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200511135825.219437-1-kwolf@redhat.com>
 <20200511135825.219437-4-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cbeba850-5c46-e946-596a-c8f33140b898@virtuozzo.com>
Date: Tue, 12 May 2020 20:15:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200511135825.219437-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0091.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.163) by
 AM0PR06CA0091.eurprd06.prod.outlook.com (2603:10a6:208:fa::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28 via Frontend Transport; Tue, 12 May 2020 17:15:02 +0000
X-Originating-IP: [185.215.60.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 476bd4e1-b702-4001-f6b0-08d7f6980279
X-MS-TrafficTypeDiagnostic: AM7PR08MB5461:
X-Microsoft-Antispam-PRVS: <AM7PR08MB546103986AA831843A3879B4C1BE0@AM7PR08MB5461.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:103;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PGmEw9zJsmUd7aLMa9e8fiMbNIZN3p46nlOQ2vuFBC40M/j5aZmHYWMYYV1WKgcWHGlo/fdNvfuuuTbBvi0CM9mdhKWDX4Nk2GttZxMxX2UJtUGY7SJHOgfv6vaKOf+SgcbYaHk1g/gsAAIPXrTxauVxtHLKrzfcPGbzOREPcsvcbsaUab9VGOz9XejOCWvTNq4NkxIGiCelJbGY/7k/hzeW7fvcHZkL9c6ih80zodcB3bfoLV3RrCoAfH+tt5qfxVt0i9VFcwQ+EovIifoTk6kz6V5TzShxkz8OuwLtmZQ+1BpkM5FOsD3e0DGbjGlqKVJ5A0Ag6Qc4tUS53Nx2VMw47mc0rzQNgMy56wkPj7d+HavcKq8nOzpmvB59WJxxhjcsw3zcykbLQkrNJL2VKfv1fgJclfiElgLDraogi0TfejT0Mdo5N0Kk5SgmzRFhOMj9qg+EfEZqMw4fPlvVWZv5lG8hwL1jiahyYWNA6UcupbNhYeyfaqSVTJfgOLrjJA+BZ9t8PKSwieigw8svv7GPQZLxEAJSZRA7QW0cFHT9Q+/Qzkv/QW7S4MzNi22G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(39840400004)(376002)(136003)(396003)(33430700001)(16526019)(86362001)(26005)(52116002)(16576012)(316002)(478600001)(33440700001)(6486002)(186003)(8936002)(8676002)(5660300002)(31696002)(66946007)(66556008)(36756003)(956004)(2906002)(2616005)(4326008)(66476007)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ZT/nF7ySV7dNibGOxFhvS/bTsZKrAuU4qP6gIkaR+8IZMR4tXXGdwA5IVj5BSBiYPeiVHmUVt6r8WXcdFdNY4gzKnY3rKoXNzeB7zcCfD7IJbYToHlBIK6xJPKcX16+gPIFMVaM+LHS88mpLyZNS52Crz5bnkLM/C01rnjV+0dmROMsD7ZmWQ6SXlnW4v0GsJPzVqgPNrXDwvm5LTcs6jEewXBh6XCxcu3CiFt9/THVWxU3eSOyGLNiy/htQdtHsuxLEeGO/hac2Fk71BvD1V2AVsRiZT+JZqYagPAwz49tYTKw4N5gh/laL/NiGqQltpl8Sr9zcoaWPggJdcRHHmTqiARQQKsQDxUwSIvd6boAlDkWBO3AaHq+XC298Nspq/dRsiTOZOl8+r91UOrdCo2XbyzgTYwV6kCw7hpyX23Ch/OZpm4HqNO8eBLZ14vpeFlejQOVZyJVbJEOjDe6jsdjbKJhdeGXslh8YQ4aeCcFqkFJ95rb1IIbMPm0/FShX
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476bd4e1-b702-4001-f6b0-08d7f6980279
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 17:15:03.6011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhbzNEjal8G3c126xwKA5ZgF3hIwioAUyeTQKrEOTY6IPKCteUpKhnvYS4AfCdLXi66nOG/RUaN2BzUM1u99YsqKx8jHolIgGqt4wFOdZAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5461
Received-SPF: pass client-ip=40.107.6.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 13:15:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.05.2020 16:58, Kevin Wolf wrote:
> If the target is shorter than the source, mirror would copy data until
> it reaches the end of the target and then fail with an I/O error when
> trying to write past the end.
> 
> If the target is longer than the source, the mirror job would complete
> successfully, but the target wouldn't actually be an accurate copy of
> the source image (it would contain some additional garbage at the end).
> 
> Fix this by checking that both images have the same size when the job
> starts.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Message-Id: <20200507145228.323412-3-kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/mirror.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index aca95c9bc9..201ffa26f9 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -872,6 +872,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
>       BlockDriverState *target_bs = blk_bs(s->target);
>       bool need_drain = true;
>       int64_t length;
> +    int64_t target_length;
>       BlockDriverInfo bdi;
>       char backing_filename[2]; /* we only need 2 characters because we are only
>                                    checking for a NULL string */
> @@ -887,24 +888,26 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
>           goto immediate_exit;
>       }
>   
> +    target_length = blk_getlength(s->target);
> +    if (target_length < 0) {
> +        ret = target_length;
> +        goto immediate_exit;
> +    }
> +
>       /* Active commit must resize the base image if its size differs from the
>        * active layer. */
>       if (s->base == blk_bs(s->target)) {
> -        int64_t base_length;
> -
> -        base_length = blk_getlength(s->target);
> -        if (base_length < 0) {
> -            ret = base_length;
> -            goto immediate_exit;
> -        }
> -
> -        if (s->bdev_length > base_length) {
> +        if (s->bdev_length > target_length) {
>               ret = blk_truncate(s->target, s->bdev_length, false,
>                                  PREALLOC_MODE_OFF, 0, NULL);
>               if (ret < 0) {
>                   goto immediate_exit;
>               }
>           }

Hmm, interesting, if base is larger, is our behavior correct? Blockdev becomes larger after commit and old data becomes available? I think we should zero the tail after old EOF or shrink the target..

> +    } else if (s->bdev_length != target_length) {
> +        error_setg(errp, "Source and target image have different sizes");
> +        ret = -EINVAL;

Seems, the only case, when mirror_run() sets errp. And, therefore, the only correct one..

> +        goto immediate_exit;
>       }
>   
>       if (s->bdev_length == 0) {
> 


-- 
Best regards,
Vladimir

