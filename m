Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A59C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F41B207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SrvgSVng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F41B207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDMH-0004Mn-5u
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jlCtv-0001Lz-82; Tue, 16 Jun 2020 10:49:23 -0400
Received: from mail-eopbgr60105.outbound.protection.outlook.com
 ([40.107.6.105]:13430 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jlCtq-0003qy-PD; Tue, 16 Jun 2020 10:49:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0QxJ2TGL02QOhPTEoID3ooFJHWT07ndZSqXF7TSygElbfW6/55yPx4NT+FZO/I1Q/rIQPNm+9HKNDXVkIMc4NteBu2A4jGII8C9L+yB5NAjq5/iw/eMRdBgqlpcgADabhxki9XKHAQpnsic0n1FSnRJjF2MMVrvGCsSXFOq54d+s+Y3XL34Y6BlUUjS03W7grNsmY+gamh1Pi7TZGkJmKgLfcPD0pKeeJxR4NoCyxA5vgrwf5sARp6S+qs7pSzKJ0uWUDpzLodXdVvZMNVc3RqOs1nBTmjYnY1tE7H67br0PrL2xFyJ2ti+z2Mlz2cb+J+1tGQ0pKIRYifTXrp6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Tv/pSrigrFdxuLN/zhxMCWcCl5XBxmZm3Rw9InizfE=;
 b=MjvD6yjQ3gxYhjyAZwgF9zpPSXC98gjBzg1r6JmDp1eeKeqeLMHe/UM/HmwYcyHe3xjyF/te/IW5suU01+if4Mwq/SXIL+f+zOF76VoSktcJd+QvkLrfSqJ9Qv+uVa41d2wCf/9mfSfhpYVpm8vdKWsrgfz16CcnCtVGvsZTIEECVKx584NmWYG451FgMa0k1LVAJ4h/TTmhnHEr7wB2yIDIhCSUMnphEPn76z9xyc7EDuJM6eTuuZkDOXO24W93AxrI3lrDYsZzbJ9Zetsi5gNMOEh/t3hiY+rRW+iMqt5zMt2wnUuncBcsZ3Uzl3t+RhXYarmc64X67ZoyDU3BeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Tv/pSrigrFdxuLN/zhxMCWcCl5XBxmZm3Rw9InizfE=;
 b=SrvgSVngZTqk/ubsrgioNcOHDdYQ958J1ar5lwTiz5fkRXjqv+bLOKPCmmr+MDB7cpnkCF1eY6JdHvh1zUY3wciFIeSWrXfAY7+FIp6xIkYQeW00SECFvavjqCVBAIbM6KfLFp72LhexvdQjjkd9dq6oy8Sr+jWebuADQ1r9yCI=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB4949.eurprd08.prod.outlook.com (2603:10a6:20b:ee::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Tue, 16 Jun
 2020 14:49:14 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 14:49:14 +0000
Subject: Re: [PATCH 2/4] block/aio_task: allow start/wait task from any
 coroutine
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200611171143.21589-1-den@openvz.org>
 <20200611171143.21589-3-den@openvz.org>
 <46a4083e-8944-e46b-ea77-0283c0ed5069@virtuozzo.com>
 <93966e61-df72-8d3d-87dc-95dc25ec37d4@virtuozzo.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <75e3e09a-4863-810f-80d9-734d348a7978@openvz.org>
Date: Tue, 16 Jun 2020 17:49:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <93966e61-df72-8d3d-87dc-95dc25ec37d4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR08CA0066.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::37) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR08CA0066.eurprd08.prod.outlook.com (2603:10a6:7:2a::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Tue, 16 Jun 2020 14:49:13 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 331386a0-caf3-42bf-aa47-08d81204700c
X-MS-TrafficTypeDiagnostic: AM6PR08MB4949:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4949C1685489DD417DE96C3DB69D0@AM6PR08MB4949.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQsKxkEN72jwfYTGGFhs8GQ0hSvFzwSu06qwtHaRxgHN+TVW3kTnfAXElx5NUAbw4MS1hNdDw8GRUw+nHBO4s2Obf8KZBE5wKbyCZUckDrJteoePGeH0yGHjI758WxpaylOOTUau8tGyHj20rERxxDhmkK1RcgrGJOZsY/iGpviLC+FSXNOuTkxSMVAoVxD0SDclX69vw26nPDKAivWxz7g8VN0xtVNhjiB0eJukxNE/LhgfduFvPHiASHj6tOW6Ud6nObiDi3wd63buHTcWNGXbspROc4r5SepvLDl1ayQuJPv7TbH7XhTlb3ZzPH0tlq3EbNB2MYz4L+c21LpOG5is7dAuiuOudUE9O2PUuKItiQyGIxCvuzQmo2MFJEq1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(396003)(136003)(376002)(346002)(36756003)(53546011)(186003)(16526019)(83170400001)(478600001)(52116002)(66556008)(42882007)(6486002)(83380400001)(2906002)(107886003)(26005)(66946007)(66476007)(31696002)(4326008)(31686004)(8936002)(316002)(16576012)(8676002)(2616005)(956004)(54906003)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bb3UssV+Sf9K7Kyym8+AcUJ2LtYk4z1OGmS9olP1oL+SSKVhEC2fo5k421zpxtMwdGSEud0ibshbR5u0oPp/cxPcSj0rEgjgOIOdZmR5GUHWJQ7SS5xup8lZklHdZ3uOeISyhZlf38NiAA6sYgNzjcJL3HG1MbGxfQ3Cx1KLpGPZL9nQN/YU9Y8Ar0B66kZJ7omqVfUACilDSqhRvHuvkoaDa8F3+ncovyfw4exxD4e/uDcqE5NFIIwtVtwcehDQOymSrTK/w6G9FOBfprxC7XpoB4//xhXqdsSSalXMeosibdf6ApBK9DEAhJeoPfbJJ+DrPXO3sTK5ayVydBrzWJJAUTZ1tmxPJlvdEtH4u6UeFhVSgVy8nAyTY0fo+OJ9N0Ub+kdUo/nXwa2nFePOP7myXLl8angvDu8XoAOJsJw49wc/DU5x8uzNyTiSivRnZbGEY1vphBR/Ka7IL5extacDX106lv9BxICIeFMRHQb4TuBZg9m90MffIo7ZZ7Mp
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 331386a0-caf3-42bf-aa47-08d81204700c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 14:49:14.4810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGneEmYZyXe0/LHaaUVKqIofa4rKnS1Y9ktNlr69kIGNW0uoEDQrR/Gxp+355HhK82hXh9R2EXhEUzZxgh6GDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4949
Received-SPF: pass client-ip=40.107.6.105; envelope-from=den@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 10:49:15
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 12:34 PM, Vladimir Sementsov-Ogievskiy wrote:
> 15.06.2020 10:47, Vladimir Sementsov-Ogievskiy wrote:
>> 11.06.2020 20:11, Denis V. Lunev wrote:
>>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>
>>> Currently, aio task pool assumes that there is a main coroutine, which
>>> creates tasks and wait for them. Let's remove the restriction by using
>>> CoQueue. Code becomes clearer, interface more obvious.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> CC: Kevin Wolf <kwolf@redhat.com>
>>> CC: Max Reitz <mreitz@redhat.com>
>>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>> CC: Fam Zheng <fam@euphon.net>
>>> CC: Juan Quintela <quintela@redhat.com>
>>> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>> ---
>>>   block/aio_task.c | 21 ++++++---------------
>>>   1 file changed, 6 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/block/aio_task.c b/block/aio_task.c
>>> index 88989fa248..cf62e5c58b 100644
>>> --- a/block/aio_task.c
>>> +++ b/block/aio_task.c
>>> @@ -27,11 +27,10 @@
>>>   #include "block/aio_task.h"
>>>   struct AioTaskPool {
>>> -    Coroutine *main_co;
>>>       int status;
>>>       int max_busy_tasks;
>>>       int busy_tasks;
>>> -    bool waiting;
>>> +    CoQueue waiters;
>>>   };
>>>   static void coroutine_fn aio_task_co(void *opaque)
>>> @@ -52,31 +51,23 @@ static void coroutine_fn aio_task_co(void *opaque)
>>>       g_free(task);
>>> -    if (pool->waiting) {
>>> -        pool->waiting = false;
>>> -        aio_co_wake(pool->main_co);
>>> -    }
>>> +    qemu_co_queue_restart_all(&pool->waiters);
>>>   }
>>>   void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool)
>>>   {
>>>       assert(pool->busy_tasks > 0);
>>> -    assert(qemu_coroutine_self() == pool->main_co);
>>> -    pool->waiting = true;
>>> -    qemu_coroutine_yield();
>>> +    qemu_co_queue_wait(&pool->waiters, NULL);
>>> -    assert(!pool->waiting);
>>>       assert(pool->busy_tasks < pool->max_busy_tasks);
>>
>> As we wake up several coroutines now, I'm afraid this assertion may
>> start to fire.
>> And aio_task_pool_wait_one() becomes useless as a public API (still,
>> it's used only locally, so we can make it static).
>>
>> I'll send updated patch after reviewing the rest of the series.
>>
>
> Hm, OK, we have two kinds of waiters: waiting for a slot and for all
> tasks to finish. So, either we need two queues, or do like this patch
> (one queue, but wake-up all waiters, for them to check does their
> condition satisfied or not).
>
> I'm OK with this patch with the following squashed-in:
>
> diff --git a/include/block/aio_task.h b/include/block/aio_task.h
> index 50bc1e1817..50b1c036c5 100644
> --- a/include/block/aio_task.h
> +++ b/include/block/aio_task.h
> @@ -48,7 +48,6 @@ bool aio_task_pool_empty(AioTaskPool *pool);
>  void coroutine_fn aio_task_pool_start_task(AioTaskPool *pool, AioTask
> *task);
>  
>  void coroutine_fn aio_task_pool_wait_slot(AioTaskPool *pool);
> -void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool);
>  void coroutine_fn aio_task_pool_wait_all(AioTaskPool *pool);
>  
>  #endif /* BLOCK_AIO_TASK_H */
> diff --git a/block/aio_task.c b/block/aio_task.c
> index cf62e5c58b..7ba15ff41f 100644
> --- a/block/aio_task.c
> +++ b/block/aio_task.c
> @@ -54,26 +54,17 @@ static void coroutine_fn aio_task_co(void *opaque)
>      qemu_co_queue_restart_all(&pool->waiters);
>  }
>  
> -void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool)
> -{
> -    assert(pool->busy_tasks > 0);
> -
> -    qemu_co_queue_wait(&pool->waiters, NULL);
> -
> -    assert(pool->busy_tasks < pool->max_busy_tasks);
> -}
> -
>  void coroutine_fn aio_task_pool_wait_slot(AioTaskPool *pool)
>  {
>      while (pool->busy_tasks >= pool->max_busy_tasks) {
> -        aio_task_pool_wait_one(pool);
> +        qemu_co_queue_wait(&pool->waiters, NULL);
>      }
>  }
>  
>  void coroutine_fn aio_task_pool_wait_all(AioTaskPool *pool)
>  {
>      while (pool->busy_tasks > 0) {
> -        aio_task_pool_wait_one(pool);
> +        qemu_co_queue_wait(&pool->waiters, NULL);
>      }
>  }
>  
>
>
>
I'd better make this separate

Den

