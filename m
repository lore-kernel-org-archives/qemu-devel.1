Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52B3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:01:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F6E2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GMGRq9SG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F6E2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjMpN-0007ru-Pd
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 09:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjMgy-0002xn-L6; Thu, 11 Jun 2020 08:52:25 -0400
Received: from mail-eopbgr80097.outbound.protection.outlook.com
 ([40.107.8.97]:59611 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjMgw-0000QR-2r; Thu, 11 Jun 2020 08:52:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHkcNtXfgXwglstDNujAlDrCRX04tm40Y5HHMxiQ1mtokYLIJriK9f3j9U3D99VKaKVJlftTjPLHpAkX0iZ8w1rNeUNErrQv7Pmd5IQbL4SFWoecGBIGYzIUzWwhGT/D7dL6qHmxBTPRS96DUdsxK0MMARdcV5RJthW6xFsTh/hhs3PT2FFFWAeHmrFY4wZD70ONG6F9Nu2mP9i6fWzejdWQBZsmOy/XIzRjL2wIFDdaIv8buR4HqltoUNO+6xjpST28SbGG+5InLeo6sq9MYJPdt9/gDp/3M2T+4fEHvxR0Ens4/yh2FQ31TVrYO9kIK7BE7aHeXQsjmuq50LRL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3Fkyp5XNhWfJfTm0gk9TOA93VR/8uUlEm8nPZLINxI=;
 b=WKAkdRNmwChWLy3i3TgDwxLUqXYhwYwc5AL3oWVy/9UmIFqINI62+1kqLRuX4HI9l2B20b2I2YeF3e2loHHdzz9QGBAuRUKZcSq6Ds6uwfwvngMPakPo5/2DnpE3THNz5zxUkmWzMi4OMxs6JQdb54D3rddxu2947KEK10Ncuqo93KfIqpq7WaF3saI6x7q4iDb7Q8AylkMPA1Uo5FUmNVhxxd2FLEiS+88XfwuN+5a0kiwCwNAjopHq1+InGhjYGkMOCKttX8CFTQi3ohxXxhOrAaZH9zCUhIadjUPef/6H7r70VXaJh/bN2bGgQcAYDidXIBP/qNOMKtBHsKR7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3Fkyp5XNhWfJfTm0gk9TOA93VR/8uUlEm8nPZLINxI=;
 b=GMGRq9SGPmlmkOAYKOUEH1ft6ERiu+IyERWQwxpHJLURXfbm5IbWPouwv86Hz8rgcNlcJ8Wi2XLVv/dJD88FSAuIqN6eVTll5jqip8afIq6EJVGidrcZ7vbQYkoJJ7wgFF0hyW9hQ9/7P2OHeQTdKAbBKwarFmqLm2czCk8ApiU=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 11 Jun
 2020 12:52:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 12:52:19 +0000
Subject: Re: [PATCH] block/aio_task: allow start/wait task from any coroutine
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200610190058.10781-2-den@openvz.org>
 <20200611073631.10817-1-vsementsov@virtuozzo.com>
 <5904554c-4c12-7f59-00ec-f842aa813a12@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a59a8a51-943f-9796-293d-138493acf469@virtuozzo.com>
Date: Thu, 11 Jun 2020 15:52:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <5904554c-4c12-7f59-00ec-f842aa813a12@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0132.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::49) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.159) by
 AM0PR10CA0132.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 12:52:18 +0000
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05167434-119c-4326-bb70-08d80e06468c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB544806B866B0FF3B5DB8A6A8C1800@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ou47Ham5JOLpgLj0I51q+/qrAi1IrNNFLsO0tOniMpIjtxbRiATDSwE8XDAc88/wlY69+6WL/+NulPBZc0kOVp1o6W2q3n7Czl2uIITKE7RCPz5+TvucOEmUw6KjycMXdZLLxdVX0HyWjMkx12uldQYqwBuaF+p3dkyDFJtSVMkPAKA0NEj0UYp+7PGalyGC595Lh522pKOWPOd3RUsPQPz6QpQ2Bdl+x0TZXYdhborv0RO1dSJ86StDR+48bTVp6OgQvBAbE/TUv+/wndiDbjKEolPBf66CFQ3Sl8NSAsWX00pAO2IOw8kPHe3ZM1fMlfmFyINJCX8rq0RIERHObxaPvPzIKf0kHiPaLVD1oHty6Nrlo9Zt34fGnJvj6itr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39840400004)(136003)(396003)(366004)(186003)(26005)(6486002)(2906002)(31696002)(478600001)(86362001)(4326008)(107886003)(16526019)(8676002)(2616005)(36756003)(8936002)(53546011)(956004)(31686004)(316002)(5660300002)(52116002)(66476007)(83380400001)(66556008)(16576012)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Bdy9BGEzY/Rl+ohuQ5tp/rPNeOQGsBP83GbXOP9d9gBpjU7GQmp5yAYNAQ3mOWTAweH98fbROxainTjQZ/DVQ9HWXBs0XcvRTSCVIIFKYtRaSL+XnPkoboplgVx8I0HNVrXoZ3Qb3YAJqCYFn42xSuUBnIshFj8uYJjaqaDtkUFWCoDQg0jFElBBhnOUi2ffHJ1tdvlweMrShI+8t41z7YjdHk7dUKqqL0/gezACWpx2uylEZFKhzSPze5PaIbDSiWIkebrZZ/W445HX9qRzvrveZ7KtbhtnlAWoKnWLpsrWbdUbjN3CP6rSfUtMl/9L4KO0sEQluXZKqLjdeR0j9XOU2R7GSS0+2IuwvEnUvXIJabb4TnJ2dnUnqVgu9HT8CY+uo257pTb1dJTkpEW3HNcCt5iYv8Ku0B6pDsQRQgvimE80c95TDyrALtPJrQl9AsqG9ZJOLqUHLAJLS5IwYjPLyqi0RoStmMsxIsXyBYH5/NyPkekKEFkOUeNMwreb
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05167434-119c-4326-bb70-08d80e06468c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 12:52:19.0091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3ZMVRbFLlKvXzu7Qb3OX0rzDqkYFM2MuE1ELPKvZFzvlKfxMMKz4dF1OWZEEIx4p82L1Sf4OXZ+6bkH0koA/jB2fBC7LLWq/Xw0vxQgz48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.8.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:52:19
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
Cc: kwolf@redhat.com, dplotnikov@virtuozzo.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.06.2020 15:31, Denis V. Lunev wrote:
> On 6/11/20 10:36 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Currently, aio task pool assumes that there is a main coroutine, which
>> creates tasks and wait for them. Let's remove the restriction by using
>> CoQueue. Code becomes clearer, interface more obvious.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> Hi! Here is my counter-propasal for
>> "[PATCH 1/2] aio: allow to wait for coroutine pool from different coroutine"
>> by Denis. I'm sure that if we are going to change something here, better
>> is make the interface work from any coroutine without the restriction of
>> only-on-waiter at the moment.
>>
>> (Note, that it is still not thread-safe)
>>
>>
>>   block/aio_task.c | 15 ++++-----------
>>   1 file changed, 4 insertions(+), 11 deletions(-)
>>
>> diff --git a/block/aio_task.c b/block/aio_task.c
>> index 88989fa248..d48b29ff83 100644
>> --- a/block/aio_task.c
>> +++ b/block/aio_task.c
>> @@ -27,11 +27,10 @@
>>   #include "block/aio_task.h"
>>   
>>   struct AioTaskPool {
>> -    Coroutine *main_co;
>>       int status;
>>       int max_busy_tasks;
>>       int busy_tasks;
>> -    bool waiting;
>> +    CoQueue waiters;
>>   };
>>   
>>   static void coroutine_fn aio_task_co(void *opaque)
>> @@ -52,21 +51,15 @@ static void coroutine_fn aio_task_co(void *opaque)
>>   
>>       g_free(task);
>>   
>> -    if (pool->waiting) {
>> -        pool->waiting = false;
>> -        aio_co_wake(pool->main_co);
>> -    }
>> +    qemu_co_queue_next(&pool->waiters);
> nope, this will wakeup only single waiter.
> the code will deadlock If there are 2 waiters for the last
> entry.
> 

Hmm, right.
The problem is that original design combines into one thing two different:
  
   1. wait for all tasks to complete
   2. wait for a free slot, to start a new task

2. should work as is, with qemu_co_queue_next() and co-queue, and for 1. we
should have separate yield-point, to be waken up when busy_tasks becomes 0.

I'll resend.



-- 
Best regards,
Vladimir

