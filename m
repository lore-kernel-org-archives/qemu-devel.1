Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52397C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219B72065F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Rw4jdsFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219B72065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jklWi-00036N-Ei
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 05:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jklVn-0001k4-4I; Mon, 15 Jun 2020 05:34:39 -0400
Received: from mail-db8eur05on2106.outbound.protection.outlook.com
 ([40.107.20.106]:29632 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jklVk-0004o0-AD; Mon, 15 Jun 2020 05:34:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hmcmy23fEWQvOgkqrhVK0y9FGpL8K+pZ7SF3ukGXCx/5xEGODWFD9JBzE/AKgXXPUR1mKgdJRE/ayNXOnqrQcuzKUyd0VaeA8Mi7Ri7yXoTfEag0FX4lyY2bwVwjJgnVEquIlngGzCyphvpFyiBDos46WLAte3w0fLhiQc5T/P6KUfXZ+h0YrZ8aLqVp9fkZA0nmtaoOmIIC3ytJg2+v8udn0Zt4S/C2R8F94Bzm5UgjFSqf8kaPhX8wjAxTWqPww6d/y1yWSrl2V5iLPRrG5me4V5ptjW7OQ2xqIOQJFhikchpTF/nkewd5xbNbaRpfCzChJANN6Doai4t7yfY1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78c7cgtrVIy2pwpBLqerMk5GNh9d2+RB33K+brSXS5o=;
 b=NBgr0DKYK1eseUeSOmUyd5Lzx2Gy26uyms7UJ/LaZFyYwLU+YlMQQd5b1ZWSGBLTykwNNhLJB1Ck3QswZq7wh5x9cU9fsAPzKLKUynTfO87oqH3oPy3kP4o01M5XD5/oEBVTJP6P7jN/gWzjn+k+WclbgrYvojlrg0R/6N9rGDcVbHN1ShN4qvHsv5c8mI5vsj24wbhaV3Ecn5VWjfTZ1QJisnguGM3i4PQCfcPfnJ5QtHu/KwxUfSX4DUYQDJqI6gIjtc9hRGuypGFdzLXZy/wJXXgOeOsoniEBSWF67ojfQXQAW74apRkJm/Sf7AO4ZIJAFOMNDl8ym5xP+bS4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78c7cgtrVIy2pwpBLqerMk5GNh9d2+RB33K+brSXS5o=;
 b=Rw4jdsFyPGnORLYB6fE5K+kkAlgrb8n1/QDfE4ci6FMxI9Sy2788e3uKERDPv6W/nmXiVJFcZ2Nuv5OU5QWFVYsoaUi1vMj2BeoarseQvOL2mX2mNkzuZFOMXDrOtXZKB7TqMQc61gbz52PbtCdcbSiqkv4FjVuEmcXyAyZ42eo=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Mon, 15 Jun
 2020 09:34:31 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 09:34:31 +0000
Subject: Re: [PATCH 2/4] block/aio_task: allow start/wait task from any
 coroutine
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200611171143.21589-1-den@openvz.org>
 <20200611171143.21589-3-den@openvz.org>
 <46a4083e-8944-e46b-ea77-0283c0ed5069@virtuozzo.com>
Message-ID: <93966e61-df72-8d3d-87dc-95dc25ec37d4@virtuozzo.com>
Date: Mon, 15 Jun 2020 12:34:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <46a4083e-8944-e46b-ea77-0283c0ed5069@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0202CA0013.eurprd02.prod.outlook.com
 (2603:10a6:200:89::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 AM4PR0202CA0013.eurprd02.prod.outlook.com (2603:10a6:200:89::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Mon, 15 Jun 2020 09:34:30 +0000
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23d53acf-c9cb-4e34-5621-08d8110f4ea3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5366034B51C56B74A0379BA8C19C0@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWiDRwOLbBQibyQhOfB1Fe+kOTNFKvfiPhtdXNL8E8aqE7djaCMXKaC+2lBDMNmiGKuy37Zv6QX2t2Edh4/KhlzA95aPyorYrjWnLVnY8iuzHJtjiH61gIztWQG9hlpXCoG3TaAMyLOLWWkiA6izObqRqNBGFgCTMb57PGrLSDyGw6rywTZ9ySZ+VHX3RY7lco1Mpxs3/GaETPyMfvS1esCg5aj2q3hPoNvV0F9MNe987RYTsujWjMt45MIKGtEPf6OXAzXjGj+z3tB8Q1msoyHq7fVzq6D8pYsQuCLnqMVPTMVcSt63/FWeS9wIpLK9wWJ4jvbQuDatHZ1q48H6sEY6bzqDlTBjKYe3YVowTat3j8rEesTpWzMbHI3yCnZp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39840400004)(316002)(52116002)(16576012)(107886003)(5660300002)(956004)(2616005)(54906003)(8676002)(26005)(16526019)(36756003)(478600001)(186003)(8936002)(4326008)(83380400001)(2906002)(6486002)(31696002)(31686004)(86362001)(66556008)(66946007)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: drj19O+d3K+bcrWEPAS6AVlX+Ip3i479z3p6k2WHbcuCs7AOEg/X67u8xzxfgt+Ud2sMXZgh5gi5JNFgH9RmG7XWdkGlYgcfckESnZ7Aqpp18r6Hqp+lphRjkg402jBttBz4zLHkykvig3kAHDnEwP9mQwkLnIumUiENXVjYiDwCYiYUE7r3l1TO3+Ovcji5239VqSFSDgsjet164La8AirXKUAtU0D8eGF02hs8MY0aiYOFQEO2/Yv8pf+OWmxxWpAET8nStz/IytuOsfGEHv1YXKtV9SjApEUpRxs4awwRSfSB23UZJJsDbFu/Ked9S/7u+cCFNhUOlOgiEHJqDrwhRJBoQYid/eBbVET1m/6643DaE3IzR0sQJ8xAQovpmDdyc+e1dzzag/QWrupNP9OloE9u+pZvmfSF3UXcL7YDBUUpbvJBsVm5k2SCFP4RFWMhAba6HqWjx+4+ActTaeFmZynINM8/uMY/PHrLidfeio7odvXU3UPhqstnh6g2
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d53acf-c9cb-4e34-5621-08d8110f4ea3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 09:34:31.5743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1q1Vec7KbQK6S2Vku18t8WtAW8gzGvJGjatrgQSli7YhZ/KXmjbGJbe06yw+a3L85/0q59+SN79ahfbfzKbFD5JkXC0DjcxjIDfCfly0SM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Received-SPF: pass client-ip=40.107.20.106;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 05:34:33
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

15.06.2020 10:47, Vladimir Sementsov-Ogievskiy wrote:
> 11.06.2020 20:11, Denis V. Lunev wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Currently, aio task pool assumes that there is a main coroutine, which
>> creates tasks and wait for them. Let's remove the restriction by using
>> CoQueue. Code becomes clearer, interface more obvious.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> CC: Fam Zheng <fam@euphon.net>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>>   block/aio_task.c | 21 ++++++---------------
>>   1 file changed, 6 insertions(+), 15 deletions(-)
>>
>> diff --git a/block/aio_task.c b/block/aio_task.c
>> index 88989fa248..cf62e5c58b 100644
>> --- a/block/aio_task.c
>> +++ b/block/aio_task.c
>> @@ -27,11 +27,10 @@
>>   #include "block/aio_task.h"
>>   struct AioTaskPool {
>> -    Coroutine *main_co;
>>       int status;
>>       int max_busy_tasks;
>>       int busy_tasks;
>> -    bool waiting;
>> +    CoQueue waiters;
>>   };
>>   static void coroutine_fn aio_task_co(void *opaque)
>> @@ -52,31 +51,23 @@ static void coroutine_fn aio_task_co(void *opaque)
>>       g_free(task);
>> -    if (pool->waiting) {
>> -        pool->waiting = false;
>> -        aio_co_wake(pool->main_co);
>> -    }
>> +    qemu_co_queue_restart_all(&pool->waiters);
>>   }
>>   void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool)
>>   {
>>       assert(pool->busy_tasks > 0);
>> -    assert(qemu_coroutine_self() == pool->main_co);
>> -    pool->waiting = true;
>> -    qemu_coroutine_yield();
>> +    qemu_co_queue_wait(&pool->waiters, NULL);
>> -    assert(!pool->waiting);
>>       assert(pool->busy_tasks < pool->max_busy_tasks);
> 
> As we wake up several coroutines now, I'm afraid this assertion may start to fire.
> And aio_task_pool_wait_one() becomes useless as a public API (still, it's used only locally, so we can make it static).
> 
> I'll send updated patch after reviewing the rest of the series.
> 

Hm, OK, we have two kinds of waiters: waiting for a slot and for all tasks to finish. So, either we need two queues, or do like this patch (one queue, but wake-up all waiters, for them to check does their condition satisfied or not).

I'm OK with this patch with the following squashed-in:

diff --git a/include/block/aio_task.h b/include/block/aio_task.h
index 50bc1e1817..50b1c036c5 100644
--- a/include/block/aio_task.h
+++ b/include/block/aio_task.h
@@ -48,7 +48,6 @@ bool aio_task_pool_empty(AioTaskPool *pool);
  void coroutine_fn aio_task_pool_start_task(AioTaskPool *pool, AioTask *task);
  
  void coroutine_fn aio_task_pool_wait_slot(AioTaskPool *pool);
-void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool);
  void coroutine_fn aio_task_pool_wait_all(AioTaskPool *pool);
  
  #endif /* BLOCK_AIO_TASK_H */
diff --git a/block/aio_task.c b/block/aio_task.c
index cf62e5c58b..7ba15ff41f 100644
--- a/block/aio_task.c
+++ b/block/aio_task.c
@@ -54,26 +54,17 @@ static void coroutine_fn aio_task_co(void *opaque)
      qemu_co_queue_restart_all(&pool->waiters);
  }
  
-void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool)
-{
-    assert(pool->busy_tasks > 0);
-
-    qemu_co_queue_wait(&pool->waiters, NULL);
-
-    assert(pool->busy_tasks < pool->max_busy_tasks);
-}
-
  void coroutine_fn aio_task_pool_wait_slot(AioTaskPool *pool)
  {
      while (pool->busy_tasks >= pool->max_busy_tasks) {
-        aio_task_pool_wait_one(pool);
+        qemu_co_queue_wait(&pool->waiters, NULL);
      }
  }
  
  void coroutine_fn aio_task_pool_wait_all(AioTaskPool *pool)
  {
      while (pool->busy_tasks > 0) {
-        aio_task_pool_wait_one(pool);
+        qemu_co_queue_wait(&pool->waiters, NULL);
      }
  }
  



-- 
Best regards,
Vladimir

