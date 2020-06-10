Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC15C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99162067B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QW7r/dvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99162067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj3yG-0001zx-5s
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 12:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jj3xe-0001TD-K0; Wed, 10 Jun 2020 12:52:22 -0400
Received: from mail-eopbgr70122.outbound.protection.outlook.com
 ([40.107.7.122]:46848 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jj3xc-00022F-7U; Wed, 10 Jun 2020 12:52:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnWdv+RwMoqzeLpcplfrVoPvZ9sOSOatPolgz3DJ1CATH5G6sH8P/rTF0ThxHFdol67+Eyn3ryXyNKqcEI2LCF13YJxk1LZaQAizaQlj0o25JUEqSjIdSrHB6FwRAEIi3BEwoHxgxskFe6Z6B/Zi0XJtOCOphiechh93npSru/djU+TeQisc197ajp8rpIrUbLg9s2+H7txf9WljVoC5VBvTEfnrEXwKsyQeJMJPOqigv6K0vf0pbsXBcQrpM7bsEcQybdd8FR8D85beht7N3PK5NlYVZhubi4chFDxnqBfpoVDybKbreHQkqGc6z3ak/OpZEPt6T1QeC8fikJeJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5ff7dMKWnEDvM4DD3VW3G3AxumyL1x6VkawwhDy9ss=;
 b=HhIjfg5yMkYu9kqTd0HnXA5ud4fazPI9pui4Ml5mcHE0O4F1WWmTUMoAWZf4rA/8AgHZMxI3uctwV905odqC74NilTyt1DrgrS956iaWiuko68N2B2Vgg7dcMSgsUrixG3su2p8aw08SmasGCx2Das7LqSqMo3T+EcriGQoXm4UooSTWG4i1nM0LbfcXMNwhQ8evvT0mltDa08wqXQPb3vNJega1ERxzudm3yJ45DpKjAHoZYNfl6LJ8iZlHWcdx1UFS4IP9Z0X9V45PGMdcb9pvolyVhetkAt/7OArYpRVZQx3Ns6tppdzcR5v+EibGMoRpujfVUGr9BMvRSgxzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5ff7dMKWnEDvM4DD3VW3G3AxumyL1x6VkawwhDy9ss=;
 b=QW7r/dvWXqVX587av2cHoIRPXOlGU6ZuCe314UvEEoBXFOS6od6SEMEg4PABSW2U/cWlfpfbFt52QrRFEKkAZuN2m3nrYJnOzGNTYjY/IqSHtB1H+xkHH7EBMPtsszRGqvFyvrmsHin8rzuFHkt+Adrz7UIqdXcksjy4U1qiz9U=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB4487.eurprd08.prod.outlook.com (2603:10a6:20b:74::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 16:52:15 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 16:52:15 +0000
Subject: Re: [PATCH 1/2] aio: allow to wait for coroutine pool from different
 coroutine
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200610144129.27659-1-den@openvz.org>
 <20200610144129.27659-2-den@openvz.org>
 <e2208bb0-fc7d-b97f-a4ae-d8e4b265db4d@virtuozzo.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <94f7d905-8d08-2f40-7212-1a79550a386a@openvz.org>
Date: Wed, 10 Jun 2020 19:52:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <e2208bb0-fc7d-b97f-a4ae-d8e4b265db4d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0901CA0061.eurprd09.prod.outlook.com
 (2603:10a6:3:45::29) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR0901CA0061.eurprd09.prod.outlook.com (2603:10a6:3:45::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Wed, 10 Jun 2020 16:52:14 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8f42113-6840-4532-bff3-08d80d5ea0d0
X-MS-TrafficTypeDiagnostic: AM6PR08MB4487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4487EC7B90D525507C2A6CA5B6830@AM6PR08MB4487.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDfL/kg+D8GIvhZzsLihNvq2wW8s3AbEgQV+Ohh38fRbjxOgXWN+jICKSVzPcTVvi/UJmsF4aH5BxsqsaOgSr/YTzAMySktEbEXGn3ZI/GZalagSgiuL0LuvIYeU6XfMUHkqjtHZUgzHLNbHX6+n3X3tNiSUJzfkHkp3aYK+VnPfjo7S5Fy9e84B3nKTJl6jBZPQW3uX65M+kf/6YMIqRiXk+LYMRpIq28HtNBn0kTPHhS7xvA2oSazhIuXcfLMTJ4mSpy9PPV+oXs4O54wjYnhvvWwDNiz1vPzCPo1jftvFZ5UyQ5D+hGxm4RboDr595ktdWMK1fFW7i2m1wH5rmQhxNsiJryuFTf0Vt6ngIE8m3V4FG0FaWedYIwT5JUGd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(376002)(39850400004)(396003)(186003)(16526019)(52116002)(26005)(53546011)(83380400001)(66476007)(66556008)(83170400001)(2906002)(66946007)(2616005)(478600001)(54906003)(4326008)(36756003)(31686004)(8676002)(8936002)(6486002)(16576012)(107886003)(956004)(316002)(42882007)(5660300002)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0VlC9POWeMPRLKKvatAfu5j5CESg61OzaSDBqjMPgqOr3M0T8ZxraLt77aEZKe2SPsMJvrrH5Q7rFYA7K23YJgK4QFhiOQiYhTAsYMVhTgtzGj3oX3gG0bsT75/JM7of4Z3Pz42NtXIvZczNIpgAy9k8ajPbDEy6owTnHyxDKboxe1l+dWAIjXTjarmO2NdO8a2sPVxFyf1IGVnqQ9yX6AV8r4ctvgpR5K12tiaG3IYi7MNn3eRkL8p6mGwZq3WJv8YVIKKkW1pI2bLjwq+VR+xVPyaza5V0/hT2yb08evqiaZmD9E68I3yCh4dMRV6I7e14icJHm2jimUp1PqOSbBFK4+pPZs5jI3w/L25eJT9qCMmuKzwexyFXGi9GFY42LaoVNj3kHTxwA6pUHrbG+mGG/QkjQ+53/ywTSvWF+JKWqMFgcCljNkOBQGFv8+RHhXHM1eIxFMg0eVOtdJYUTCqXCqQ5FA9ENwC+w4wf9OesxjkEv6Z6Xr2LeKAq359i
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f42113-6840-4532-bff3-08d80d5ea0d0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 16:52:15.0396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mB8l+6+BJicqXdxHZjC8xrVbJ6kqJSfTzDQH+EHac1LBafqRTx9LH8jhpI7miwqv90bn5rrzH/LfOD8Nycg6Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4487
Received-SPF: pass client-ip=40.107.7.122; envelope-from=den@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 12:52:16
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
Cc: Kevin Wolf <kwolf@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 6:10 PM, Vladimir Sementsov-Ogievskiy wrote:
> 10.06.2020 17:41, Denis V. Lunev wrote:
>> The patch preserves the constraint that the only waiter is allowed.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>>   block/aio_task.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/aio_task.c b/block/aio_task.c
>> index 88989fa248..f338049147 100644
>> --- a/block/aio_task.c
>> +++ b/block/aio_task.c
>> @@ -27,7 +27,7 @@
>>   #include "block/aio_task.h"
>>     struct AioTaskPool {
>> -    Coroutine *main_co;
>> +    Coroutine *wake_co;
>>       int status;
>>       int max_busy_tasks;
>>       int busy_tasks;
>> @@ -54,15 +54,15 @@ static void coroutine_fn aio_task_co(void *opaque)
>>         if (pool->waiting) {
>>           pool->waiting = false;
>> -        aio_co_wake(pool->main_co);
>> +        aio_co_wake(pool->wake_co);
>>       }
>>   }
>>     void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool)
>>   {
>>       assert(pool->busy_tasks > 0);
>> -    assert(qemu_coroutine_self() == pool->main_co);
>>   +    pool->wake_co = qemu_coroutine_self();
>>       pool->waiting = true;
>>       qemu_coroutine_yield();
>>   @@ -98,7 +98,7 @@ AioTaskPool *coroutine_fn aio_task_pool_new(int
>> max_busy_tasks)
>>   {
>>       AioTaskPool *pool = g_new0(AioTaskPool, 1);
>>   -    pool->main_co = qemu_coroutine_self();
>> +    pool->wake_co = NULL;
>>       pool->max_busy_tasks = max_busy_tasks;
>>         return pool;
>>
>
> With such approach, if several coroutines will wait simultaneously,
> the only one will be finally woken and other will hang.
>
> I think, we should use CoQueue here: CoQueue instead of wake_co,
> qemu_co_queue_wait in wait_one, and qemu_co_queue_next instead of
> aio_co_wake.
>
>
I will make a check, but for now it would be enough to
add
  assert(!pool->waiting);
at the beginning of aio_task_pool_wait_one

Den

