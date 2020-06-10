Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E69C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4492063A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BR0Z+FWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4492063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj2hJ-0000IS-75
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 11:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj2NG-0003h9-Fh; Wed, 10 Jun 2020 11:10:42 -0400
Received: from mail-eopbgr80120.outbound.protection.outlook.com
 ([40.107.8.120]:27367 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj2ND-0008PD-Ig; Wed, 10 Jun 2020 11:10:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7pDTjTQIriCv7eu5E+0TQaTsdoei78z3VVSfL6Zjdosrl939+Z/vk0nw4lLsZOkvKDRcuxAPcbyWcDb7mJ7qTtI2Z7IaJt7AnkifM2KleEABjAm7OgZ9LugxUiGBc8EwKFo6PVw6hCBi3LQujPOQ8oh8NvoLHLutmGQl/Ybi+QFn9AI6Hh6RDvIQsnODIccARgqOMTZsv437tzEk80UC4aKEQ4+WMcpe408EO5Qd6AatV2+BCecqpqcZHEyxWVVh59x5hF/ofMHm5LM4uUn/rHsYhb6gIr6atWbS0V4cLc8YSh7pAK65k5VqDb41XGEYDFoxL/j8b/eYzjyRWJQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pfm33RwQ0/KqLiEnKPvKBk27o/tf8Bq3HxxD+bGh3x0=;
 b=GQt1df5zFFhxkIMddfeEDVNaWZggG1DLStXlKywHxo8e6akwbRzaxKH1GTJr94/tJGBYFgZO+Wd8AIvitwkxxOCQ55f2be+c0uy9arJ/Ef4F9RHCCVq8T56qJeKn8Dwi793WwRVe2FlLKCI+hZIhGFhlYp9zEi+Iri0E3l9i+HCu2FXTcd2ybU3k+NstmHW9FmptIWHkDstrPDNGNfk5LPySwesXmFw+yctHlHOfYLJW1JV53QJZEnotr+I1XTdD5SdJAo0Ye7kYIEZUi1xt8ZSV4H2r5LVKxAT+Jx6FMHBOpHoQXnH7mIun1aPmG/1/2nq4aDh0WJ6j9Fxz0QK7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pfm33RwQ0/KqLiEnKPvKBk27o/tf8Bq3HxxD+bGh3x0=;
 b=BR0Z+FWuTrWcgf/30r1p/PDSoOaAW/BARpOs1CG5V/LvsLRNr5sI5uqMC0dyRwPDtIg5N84Hvx0RxBFyu/P5UZ5OL1AUTPkrPPWXS5xOKFusshC2ZpWomVbq0j8DxmZgEiF+oQIF1eYprdKsM7AmqEFa0ZOwGZnyKhXGQ1YiPxM=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5510.eurprd08.prod.outlook.com (2603:10a6:20b:109::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 15:10:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 15:10:34 +0000
Subject: Re: [PATCH 1/2] aio: allow to wait for coroutine pool from different
 coroutine
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200610144129.27659-1-den@openvz.org>
 <20200610144129.27659-2-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e2208bb0-fc7d-b97f-a4ae-d8e4b265db4d@virtuozzo.com>
Date: Wed, 10 Jun 2020 18:10:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200610144129.27659-2-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0028.eurprd03.prod.outlook.com
 (2603:10a6:208:14::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.166) by
 AM0PR03CA0028.eurprd03.prod.outlook.com (2603:10a6:208:14::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Wed, 10 Jun 2020 15:10:34 +0000
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24d8c58c-5540-4b13-5c84-08d80d506cc5
X-MS-TrafficTypeDiagnostic: AM7PR08MB5510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5510C7C71ABA0F0BDA92B510C1830@AM7PR08MB5510.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SC1CVBdKvPD/9KPn2VRyp8xZ0sU5mZEQk3BgcJTw+Lca8h4Hb7JnVsrDxhGazDXMhyEXS4O4U6CQ2DC9a6RtyIFTsehUi5B3O3ZYmv6Cvl7YLWo4yCJscbmxLO/3NruD7Bw1c+qNrUP/v4E6CypI5iVM1xNk0SC3UXC1dVsusaFXa2RvxWH0lTIEA79R1Ir0wTVNe5wkyXxS5Gl5geVj0coUBmDSvk1UThM0C8kuc21el5JCIOn9Uw+sVPz9cRyJ/f5dw1Z4OBPJeqyVZ8u0Kx8JX4XXlgb1YvzE1Xu2IOL0OHQXsv7+WNFBkYVN6SHaspmUZXbIWDJ7thix14Fy3IzpbeRlI3Gao7W2htMKj7SifA1kzId4Zkpz2PqxeS55
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39850400004)(346002)(66946007)(16576012)(31696002)(2616005)(6486002)(66556008)(66476007)(54906003)(316002)(52116002)(956004)(16526019)(5660300002)(83380400001)(86362001)(8676002)(107886003)(31686004)(36756003)(4326008)(478600001)(186003)(8936002)(2906002)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: n+td0ZZA61GQOhgocLGrbH5h5dhqHpacsJBT/7nc3rXcoF4ofM4bPcXD8uP7+of1WEhrR2J3rXBeVw5d26fqOc6Hy8sv049o8+MB7R5y/LNocXV6gP6YwTZN8jxO5mdf6v8bPNjaaxNA12W0r/RZj9FGgMK9T8sxs8UVYt5t1E2r1cpABnlQ+QY2yI9VfB2/wSzl0+zoh4OVvtgAsF1gvlPzpZTHzH61NOKfq1kPLQNATxxRH2+9F5ZRcpEy1QBcZfhJNRJnDIKKLtvh9PFGUkshU1O0j4oqRBODjvSjcJI2lhNdlObxIVve6OIUfqaC/SYzKLwR0QD4Fu2hf01YiOazwSpzRR5E60IkfBrv0Bj2TDvPTFpfQzIRNMutTRqUJ4+ai6bhwSNFDwa5gSyj3/z5Cy99olcB6Biuh1dIvVvlkIGKG+AYDQRI1IJU0KXJZwGi/h1a9YhVAIElYrms/rngLvw3l8AUKALq7C0Xc745sM3QWwWn/UQStY323KVQ
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d8c58c-5540-4b13-5c84-08d80d506cc5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 15:10:34.7388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72B7QTzHEBPFhTIVrl8R6adL7kv7x+Y+bPaoMq76ac2AjBKe+u3FJ2At+A2+0/vGi09oPyjJIJHobGa1SQMazxY2iLZYm+4v5Nrtxc5MFDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5510
Received-SPF: pass client-ip=40.107.8.120;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 11:10:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.06.2020 17:41, Denis V. Lunev wrote:
> The patch preserves the constraint that the only waiter is allowed.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   block/aio_task.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/aio_task.c b/block/aio_task.c
> index 88989fa248..f338049147 100644
> --- a/block/aio_task.c
> +++ b/block/aio_task.c
> @@ -27,7 +27,7 @@
>   #include "block/aio_task.h"
>   
>   struct AioTaskPool {
> -    Coroutine *main_co;
> +    Coroutine *wake_co;
>       int status;
>       int max_busy_tasks;
>       int busy_tasks;
> @@ -54,15 +54,15 @@ static void coroutine_fn aio_task_co(void *opaque)
>   
>       if (pool->waiting) {
>           pool->waiting = false;
> -        aio_co_wake(pool->main_co);
> +        aio_co_wake(pool->wake_co);
>       }
>   }
>   
>   void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool)
>   {
>       assert(pool->busy_tasks > 0);
> -    assert(qemu_coroutine_self() == pool->main_co);
>   
> +    pool->wake_co = qemu_coroutine_self();
>       pool->waiting = true;
>       qemu_coroutine_yield();
>   
> @@ -98,7 +98,7 @@ AioTaskPool *coroutine_fn aio_task_pool_new(int max_busy_tasks)
>   {
>       AioTaskPool *pool = g_new0(AioTaskPool, 1);
>   
> -    pool->main_co = qemu_coroutine_self();
> +    pool->wake_co = NULL;
>       pool->max_busy_tasks = max_busy_tasks;
>   
>       return pool;
> 

With such approach, if several coroutines will wait simultaneously, the only one will be finally woken and other will hang.

I think, we should use CoQueue here: CoQueue instead of wake_co, qemu_co_queue_wait in wait_one, and qemu_co_queue_next instead of aio_co_wake.


-- 
Best regards,
Vladimir

