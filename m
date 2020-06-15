Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942BCC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E1332067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="h6lSNn+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1332067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkjrY-0000gE-RB
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 03:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jkjqC-0007wL-Pk; Mon, 15 Jun 2020 03:47:37 -0400
Received: from mail-db8eur05on2115.outbound.protection.outlook.com
 ([40.107.20.115]:58578 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jkjq8-0008Fm-DD; Mon, 15 Jun 2020 03:47:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdwEEbzcbDaxyDc5huz4b/InkABR6kDy+EwoBCmRu7bpsfXbHYLnAQDu7KYOAM7AJV+CeAQ7/uJL2jMRZwzipXj/7x6gVYdbpYxU+rMXq190yEFyWhi//HlQVM4PQ2WNeYHWqZjtCeGuW0k2ZUXPvwEjP806jbB4b1AxhG4RK9yiUG2BOZ6GOyf6qjl826Br6bRGhk3eQiPIGxcPJi40+KJ9z7JdDRt4IK8PWfCoDx0mO79heV3m5CFXhUWA+2FB4J0IOSAhugLt9SVanzC6ivRncJDwDm64iCRnCicMI34MEHtUejB/0tZ+5StQFxk6RPCNpwSFnLwNPwP5nEAStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExnZ8VoP/4zLpcQdPCqk5ZxVhJGoufDLAknLAI/5psI=;
 b=J9myUwBvqrn3d4C9MLJh0BjaNwo/wXnQoqg5Gy55roDVnJH4kVjxFgsfNJB5SU6jzscbr3/M48ZJkcpNsGB8Q72iWa6Z5aqvuo01CzTI6s0ZHKwU9eVVlFJUwhCOZEdrMStW6rlpIOsJS0QiwKqHwSIHpfOOjKG3xAy3YvPvodAM/5bhoUNZOMtjyOksKKN5+44rmTQazlGlRZqDpbqBoNL0eWw9zK3d0Wo+DR3b29PYh1ZgF52Mq74sAiH1G0Ss60Q1rT+I2vo686+VNBx4yiDopbRLlWUZHAu+exdFztieJjfu7jNkU51eOx53OzlpBbuyXDVfQwt8ROoGq580rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExnZ8VoP/4zLpcQdPCqk5ZxVhJGoufDLAknLAI/5psI=;
 b=h6lSNn+TMOBb7jUdzPQcQKfHpbZOHVHWz+k0/Riqyvk3BSUIBwZNOEa5Jt6BApGMLynFOGMPoTvXo69Nl1e0xMRMuboSEtQKEFwPkz340JcqG86vPOA6NsGkarBG5lXh24uhsaxZ/qMPAorcsuCr1geykEnIMkb4SUMU/dl2+DQ=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5429.eurprd08.prod.outlook.com (2603:10a6:20b:107::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Mon, 15 Jun
 2020 07:47:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 07:47:29 +0000
Subject: Re: [PATCH 2/4] block/aio_task: allow start/wait task from any
 coroutine
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200611171143.21589-1-den@openvz.org>
 <20200611171143.21589-3-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <46a4083e-8944-e46b-ea77-0283c0ed5069@virtuozzo.com>
Date: Mon, 15 Jun 2020 10:47:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200611171143.21589-3-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0039.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 AM0PR10CA0039.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Mon, 15 Jun 2020 07:47:28 +0000
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a077771-5b19-4a04-f14e-08d811005a81
X-MS-TrafficTypeDiagnostic: AM7PR08MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54298D2C4D2C91B67BDE88BEC19C0@AM7PR08MB5429.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +EhcLYjajR1+LVAXda61IHVKMyk7+sVKH9kQNuUbGxkx8/X4fDCoAWhmYQQNcp3kPOnxcrtrZqausgLnGFMQYVwmngtjLrPXPwVKwjQXXay0CTTcIDvj/d5dk4g1k6AO7d9vqwhLZO7mxDPGgHcdzt/fR5o+5XjshsyQ89tZJ0qqRCK3Jxr28DpjMAPxjqGAwk835wVUfHkGRnptfc0Hwdg1KETdBp3aOuwfo5Vq++sye+Ss/8LEVe019QxOk/ppIjp0lA56Uf2a1x+yYry6qeHGP8FMoeKpHohzW8C8GnGfA4NBWgodjlSL1HIEtgKkXBDZSrqvaLnum0Q5S+KhUuEMTonA0oqcKepenV3ssGZ8r5NM+nL/pf4b1Jm3D7OD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39830400003)(346002)(366004)(376002)(5660300002)(86362001)(4326008)(2906002)(8676002)(54906003)(8936002)(52116002)(956004)(2616005)(31686004)(478600001)(316002)(186003)(26005)(6486002)(16576012)(66476007)(16526019)(31696002)(66556008)(36756003)(107886003)(66946007)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: oowyQ5KZXd9IAJoyDPmOc2emjPy1Jp/sFQRoYJOVn0PkDlkVpDDbnjNAab47JwlbaQquApZ3ydB4MgJNIAfkaKBTxylz5plw9sR9t+t2vTfu0nK55SNNARVTsBjM3HDJxe/BwTXuwnB+J1cEWtab3rxZ3eu0MTSE0S4/iFikKMUOz6GChGu4iXl7mpUTQEP5hlFyN5ol2RNN4ThrjXW5URiVtk9QduUQ8kYaxB4Er+JmlhAaHK4QoyXOwzTGfCQmhMBkDBnryezL3Rqnt0FaG/adsRcZQbabtIFzMMBPEWiLPSxmIRLhK7VNEQTudiqOnuE/KtsdoR0iVg7D8S9MtU4fleSAVLE2qT4gNh5Jgb/GSHhznbeoH9IhtVwajNGXBcxIeAQkVckKtrwrVSyeL1eZ3Iw+bYTU64zF7lQC6DpquP4QS2cMx2/oydbKMwxoVKFaOZBX2I+7bBfgKBHJsAj55KVgb9VUwKbm3Ngyt6pxBvBIqNpT6HQP/k4ZoMOY
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a077771-5b19-4a04-f14e-08d811005a81
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 07:47:29.0471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WarrLMr84Pc//+eNH4tsBagAp65Fr2KOC/Pl0YUAXcFCvsqAtXtBn+qhjkSSlE8woXanlI59dZCeQExi+p+i4BJyX/ZSLxxX3Jwx+BdboRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5429
Received-SPF: pass client-ip=40.107.20.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 03:47:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.06.2020 20:11, Denis V. Lunev wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> Currently, aio task pool assumes that there is a main coroutine, which
> creates tasks and wait for them. Let's remove the restriction by using
> CoQueue. Code becomes clearer, interface more obvious.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Fam Zheng <fam@euphon.net>
> CC: Juan Quintela <quintela@redhat.com>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   block/aio_task.c | 21 ++++++---------------
>   1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/block/aio_task.c b/block/aio_task.c
> index 88989fa248..cf62e5c58b 100644
> --- a/block/aio_task.c
> +++ b/block/aio_task.c
> @@ -27,11 +27,10 @@
>   #include "block/aio_task.h"
>   
>   struct AioTaskPool {
> -    Coroutine *main_co;
>       int status;
>       int max_busy_tasks;
>       int busy_tasks;
> -    bool waiting;
> +    CoQueue waiters;
>   };
>   
>   static void coroutine_fn aio_task_co(void *opaque)
> @@ -52,31 +51,23 @@ static void coroutine_fn aio_task_co(void *opaque)
>   
>       g_free(task);
>   
> -    if (pool->waiting) {
> -        pool->waiting = false;
> -        aio_co_wake(pool->main_co);
> -    }
> +    qemu_co_queue_restart_all(&pool->waiters);
>   }
>   
>   void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool)
>   {
>       assert(pool->busy_tasks > 0);
> -    assert(qemu_coroutine_self() == pool->main_co);
>   
> -    pool->waiting = true;
> -    qemu_coroutine_yield();
> +    qemu_co_queue_wait(&pool->waiters, NULL);
>   
> -    assert(!pool->waiting);
>       assert(pool->busy_tasks < pool->max_busy_tasks);

As we wake up several coroutines now, I'm afraid this assertion may start to fire.
And aio_task_pool_wait_one() becomes useless as a public API (still, it's used only locally, so we can make it static).

I'll send updated patch after reviewing the rest of the series.

>   }
>   
>   void coroutine_fn aio_task_pool_wait_slot(AioTaskPool *pool)
>   {
> -    if (pool->busy_tasks < pool->max_busy_tasks) {
> -        return;
> +    while (pool->busy_tasks >= pool->max_busy_tasks) {
> +        aio_task_pool_wait_one(pool);
>       }
> -
> -    aio_task_pool_wait_one(pool);
>   }
>   
>   void coroutine_fn aio_task_pool_wait_all(AioTaskPool *pool)
> @@ -98,8 +89,8 @@ AioTaskPool *coroutine_fn aio_task_pool_new(int max_busy_tasks)
>   {
>       AioTaskPool *pool = g_new0(AioTaskPool, 1);
>   
> -    pool->main_co = qemu_coroutine_self();
>       pool->max_busy_tasks = max_busy_tasks;
> +    qemu_co_queue_init(&pool->waiters);
>   
>       return pool;
>   }
> 


-- 
Best regards,
Vladimir

