Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D370C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3D22072F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VZEhtr3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3D22072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjMNu-0004xZ-3F
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 08:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jjMNA-0003qh-3D; Thu, 11 Jun 2020 08:31:56 -0400
Received: from mail-eopbgr40112.outbound.protection.outlook.com
 ([40.107.4.112]:60051 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jjMN6-0004Uy-Jc; Thu, 11 Jun 2020 08:31:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LT3J8SlDAs04WZB1rxeKIQq+a+A/2ohY+MZ8BmS00EUtdMf9aFT149AZu080uOBi8zcl/HjsWuSeZxFKMT2ESLSHnNcok6E/DyiaURn5CQxo6cyTdH8DpF1WOqBzPBPOMneVn6UWrp5MrCl4gTKwbWGUFF3LhkGJWCXZc6qIwggkqWt0sqeXXmDNxBOa+LnF5rCDnvhOgXMihH5H5JrfhQwa+kN7jOWQ3tIvE4ylLd/AZjN96/zm3TV15WylKdMfglAmwYWCgAXpaQT/z9RX2aeVzU9CIzrnhyz/0JwjG6cbExEg0I5mDLEkth7WSTl5RzQkvjZgFfnRAapbiaqaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiUqIbLOQj7/lj8Jp/FGX/bbh00fmW4Rn+q9iiMc7Mc=;
 b=b8mQXqHmRg5Z3u2wuoVoIXCYuCGvppj48p3k6SS6Hmm+6V3s/6pAATbG9Pyg/5w7U9EPPRQOuD3y7+5ZjXa6gypFR6ZqxrsWdaV1BR1prUHDh0F6+N/c2YjqZoQkZKdr0JvTYBun90kzQomhCUp3w+igoEwjntLF5Jha/t/HsMhA3ZbSDOi1IzWUbsUG2x9nWuCsK2mM932URnqO+YbSSwDicDDr6V3cZ2pi0akwIgoLwuoPi1qxJeXs4RTRG9GuYF1glIdf/401OBS0FBvpYtSrjamG6kDlcaHD7LdUTO1BKoaVycKPHgpiJAeUiCNcD+SDUbMIn00P1CqxcD5DAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiUqIbLOQj7/lj8Jp/FGX/bbh00fmW4Rn+q9iiMc7Mc=;
 b=VZEhtr3fCUEvy8j7oZXlRnv6t2MCVZuposEzlI44ihl8KJEQjiVzLM5ubiq+WYsfmNaVUFhaqpTYNurHdfVc5wCppOr0kBjo1/c8wHRwkW3o9DuXY2W4gK7WzGsEJMF9sX4sJGWY4yyMqM4UbXdVXRHQO0oUKBV23DhKqs1jDsE=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB4707.eurprd08.prod.outlook.com (2603:10a6:20b:c2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 11 Jun
 2020 12:31:49 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3088.018; Thu, 11 Jun 2020
 12:31:49 +0000
Subject: Re: [PATCH] block/aio_task: allow start/wait task from any coroutine
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200610190058.10781-2-den@openvz.org>
 <20200611073631.10817-1-vsementsov@virtuozzo.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <5904554c-4c12-7f59-00ec-f842aa813a12@openvz.org>
Date: Thu, 11 Jun 2020 15:31:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200611073631.10817-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1P18901CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::24) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1P18901CA0014.EURP189.PROD.OUTLOOK.COM (2603:10a6:3:8b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 12:31:48 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c7dc50d-206c-4fb7-7ccf-08d80e03697c
X-MS-TrafficTypeDiagnostic: AM6PR08MB4707:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4707BEDD7B971E767FB9FB29B6800@AM6PR08MB4707.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o6fnz3yzfQrlzPa0JvBJEz8fTNxr8tHPyh5+z6XCfWCa5l4pjmU5g6O9EILg2+5vK0ERQPTDro6qpjxepsCEd82i91VVpwPIWN0kebC8VJTjXvdei+CKRQP7KXDC84MoCn/CNutkoCo8GEzzdOuo/wN7yTkG5UVdao3IdPWTFS/K5OWWxh02lhiPHpeRdUeL4iFilSCETCiqHLpwscCuxQ9FJKclUJ7Y05LkY94H1MtslWZWOkP4qHk1ppvaOtOLD43kIOO6lEwe3NCu9dT4qZtejHJQjjaopSdFHBA5PFgjRm8eNcFHJX3AZfWj2NhhX5JH7GWT7P8cLGK/M40Nvh6LioaVSzf9IX/n1v1m9ot5jBEE+fOZm2H9aC4MLKsH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(396003)(366004)(346002)(376002)(83170400001)(5660300002)(66476007)(31686004)(2906002)(66556008)(31696002)(66946007)(42882007)(6486002)(36756003)(478600001)(16526019)(316002)(16576012)(186003)(8936002)(8676002)(26005)(83380400001)(2616005)(107886003)(53546011)(956004)(4326008)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: t/H+/AfkkgheH9whHihDJWhRHLyOuPX0Z4Vqo8YgQu/rJMveH4ZdxVJoFiq5ybU5jOWyOpmL31kALO1Gc4Nz6VqaHWIoIl85BfB9zTKw/WinJw8CaEgLmUG+c+kqyfJboIOqLs/ws34bm3yTQbtYy2o+B1nvbnfB1ENMluPFCmNGyXgcX1yS03MbKZ4KTDZYU5LOMsLyQqOAc8DnhruBixBv3VKPjtpB7SudgsKGjV+rRLRDYy7dABr9nJAjwzgDfZXooAzVUNv1NZAkK/1pjZ8Ji87QdaqG/68hgYLaaB+h5j1qilCkbtBsK25Ai72v2sbEhlGRqGI3xCXLMc9UscyRgrcxZWFJp9CfpYStiJE274IfrL8bl8ijXrpyW28b8Od1q8bzifRuvnJpS1vDA7h+jDV/awlyVJ+z48NeeOKaf66NUzegIOFxYr3sGY2bH/4vFIKo7ysbp7R6S4ID8KtFZoJn7PwGDEiD4d2W9jUM3Gq5N7jgMVCoDRik/9eK
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7dc50d-206c-4fb7-7ccf-08d80e03697c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 12:31:49.2480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VW7k73tvK07HYM7VkCSnvDU5Wu0TtvQye9Q2EtLp/nE+G4rIxTrHEW0wmfwZRN0+LIqmOpLFwSzwGc1z5kp+zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4707
Received-SPF: pass client-ip=40.107.4.112; envelope-from=den@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:31:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: kwolf@redhat.com, dplotnikov@virtuozzo.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 10:36 AM, Vladimir Sementsov-Ogievskiy wrote:
> Currently, aio task pool assumes that there is a main coroutine, which
> creates tasks and wait for them. Let's remove the restriction by using
> CoQueue. Code becomes clearer, interface more obvious.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>
> Hi! Here is my counter-propasal for
> "[PATCH 1/2] aio: allow to wait for coroutine pool from different coroutine"
> by Denis. I'm sure that if we are going to change something here, better
> is make the interface work from any coroutine without the restriction of
> only-on-waiter at the moment.
>
> (Note, that it is still not thread-safe)
>
>
>  block/aio_task.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/block/aio_task.c b/block/aio_task.c
> index 88989fa248..d48b29ff83 100644
> --- a/block/aio_task.c
> +++ b/block/aio_task.c
> @@ -27,11 +27,10 @@
>  #include "block/aio_task.h"
>  
>  struct AioTaskPool {
> -    Coroutine *main_co;
>      int status;
>      int max_busy_tasks;
>      int busy_tasks;
> -    bool waiting;
> +    CoQueue waiters;
>  };
>  
>  static void coroutine_fn aio_task_co(void *opaque)
> @@ -52,21 +51,15 @@ static void coroutine_fn aio_task_co(void *opaque)
>  
>      g_free(task);
>  
> -    if (pool->waiting) {
> -        pool->waiting = false;
> -        aio_co_wake(pool->main_co);
> -    }
> +    qemu_co_queue_next(&pool->waiters);
nope, this will wakeup only single waiter.
the code will deadlock If there are 2 waiters for the last
entry.

You need something like qemu_co_queue_restart_all() here
at least.

Den

