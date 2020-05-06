Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C36C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 07:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4365E206F9
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 07:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X7zLCvv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4365E206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWE5x-00018S-BR
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 03:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWE4w-0000aI-8P; Wed, 06 May 2020 03:02:50 -0400
Received: from mail-eopbgr20098.outbound.protection.outlook.com
 ([40.107.2.98]:38075 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWE4t-0000Ih-4i; Wed, 06 May 2020 03:02:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJZ1vcQvn/me0RaZivmc/CIbfDFfFimiv58Y6cEDmpQQ31HXLtDhKhp4ZQeSS7sYPvLOx8Ii1H/rB6JseTxdK4w3HWFUFZdZGN8hIcg6ScSImx4oQZNqDQYSnXLxjcsoePWiX5kq3AmFk4wGy4j9pRcfr/eGi0bJO21TrD3ccnkmcHVHzESEzAHziBenASEgGmMGUWmTjdz/iLdqbN8gsD0cUXUpbqMu0bgS3KfZqJxQOxM/zLV6ejCUf0o7gmoRnC5OL1rK23QRW7O2Xa/NNT4R88lRwrZSKmBiY8iK0uPm1qsIAUuIaNWbpzji3cvXwBFGj8hjZqTPu76RKOi5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQn+iLAcDJwLSMIXQ6+gtJh+QbFdKs+alnawdMUfUYU=;
 b=e3dpGSvz5ddnkBVyBUPUavUVBE+PDYgG1076BDUv3ni1g5GApHzy0f0I3gaf1egYi3MchqVmlq7f6Tlx8WvO/afr1alQSizzji5Qig5SkWcu2tvuzW23D0LWpbdRtD+rxYPdzHnEUrc668JN5bVelLtXeU3QAruYRaNIs322Ukjln3dF2MpL/MgH6LA7IHcu2j031uQvqPQ69sS5ZJK4c34Ue+ACnKcOHjA2+Fz5icUnb4s2Yekl08P/XzYrTZEviipF9Fvu7bB2pfRYq28rWDnOgQkX45yP90wHYki7cgsVLsem1tGKMV4ZAHFUFIY4QU3CZ3+FZ4e+PFgqnqX8zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQn+iLAcDJwLSMIXQ6+gtJh+QbFdKs+alnawdMUfUYU=;
 b=X7zLCvv5ZR+fmxQWcOuZ36UKuriadraR0nwo88iFLcHcZDW76M5VzYgGPyb/TNn9P//mtN2ns3l5zqCZKLfZYRz867411lqeZzC+QU0XRYI/mRX8RtEyX0dNxc51s7cFbj4LKRFKtuQ/DTRwP2ydMQJVNOyGyC+ly2kzyab2HQg=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5350.eurprd08.prod.outlook.com (2603:10a6:20b:101::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 6 May
 2020 07:02:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 07:02:43 +0000
Subject: Re: [PATCH v2 5/9] block/io: expand in_flight inc/dec section: simple
 cases
To: qemu-block@nongnu.org
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
 <20200427143907.5710-6-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200506100239499
Message-ID: <efc8e783-0541-6b95-1356-71ccc823cad2@virtuozzo.com>
Date: Wed, 6 May 2020 10:02:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200427143907.5710-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0116.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM0PR10CA0116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Wed, 6 May 2020 07:02:41 +0000
X-Tagtoolbar-Keys: D20200506100239499
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa1e0c18-4924-48e3-5ff9-08d7f18b7960
X-MS-TrafficTypeDiagnostic: AM7PR08MB5350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53504C90691B562B94ED7A09C1A40@AM7PR08MB5350.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDVyng/FcDXrsicJHrFQJrkvBoFUEn1x7C01DJGV9H2LEdYDyPJzR6f6aFCTaw7INxZMIEB+5cL/gKuowKhSWQdo9xr5OS5+XlQckxiRl6eK7A+EcIGQfLXKzbWbBjrPA4Ou5dgJ5P/YuoCUw3/Lf3G/I9fXKovawrmGp/ALec3pjmRu5or14xHixnLMMWwMN+++I5jc5kNPXCndEX0z/5P1aZ/YlxCPI6uyHdupXP9CIS+t+JL9vETZT3dOjtyKV+I9aFnAl3ai/HHdrcRmB+mR4VTA840C+Vla1/OeCOpaGmuOZ8Rz+KOefScr75ZWLODRLd22t3+QBv3gCrAWlnZg/nDGIskLipckpsNl3ho33xvw3AVMsnc+d6Gf6Nt5icg5kgb5y82Az6i8eRnB5VsMAd0QOrL+Y2n3PsgsP+YXQmr1DvIdeqpwqK3TL190TtPkPEprTvHU57AJAbTxp1uhGeiYqu6aw5lBsFz6VCvQ/HFbGQkyeCvQFOypT6Eay+4CZPGMGQerr8qACy/0hYWXfxZ0/aJ9jh8tZMFgOUyrE0KQMomU8HvnKmxH2Hgu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39830400003)(376002)(366004)(346002)(136003)(33430700001)(66946007)(66476007)(66556008)(36756003)(26005)(8936002)(8676002)(16576012)(316002)(86362001)(6916009)(5660300002)(31686004)(6486002)(186003)(2616005)(478600001)(956004)(107886003)(31696002)(16526019)(2906002)(52116002)(4326008)(33440700001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Z/53FQPjli7mIl+2LeZ7a1y81Opib7zEIMXd6ptFJ0Dfm57QYGlm0qa+fx/O/B0Ll3JFQwkZMNbIAWR4eiAF3mi4WgisQNFHq7oL0t0Vyh7KpZgs8A0Mdek3yBTfq7Y/5F6LB0wPHv5a54LCaiERRCw2l7//lyJUcq2hZrygymn1KAUYOzau9uLVLkrB2N2kkcpdFUrKJeZaQtgjVNkd8onmew230UXt1bF6lXAGo8LvS0Sni0x6dU2WpSgEG9Mut3kupCJeniuSCG0R+NVQyyHVtjojB5tlM+Evvfa2i9r+It9pFWbPLRVLLAEm0BIiK/fKzMnOjAFvfmBXs1gLoEhIe0k5KpVaEwkMGyiCndOQBeM/tDo3oGg2hgJlWD7p34qJZQI6TrNn3RZ9JzAG8Af6lZ2lK6o60ybF0aGp+4AHPQA80QlrmAeziRVwH3iYVuqzFiboArDEkvJOpvLiAueM/CkziIGkpUvwN5abrF/jMLUDuuvd3EeEaXPKfBkQS59je3a6eMFKiOYz4vewTaKPxUkbNmFMH7/b7ZODaYktcXa80tURGfllS69zjkS9rOm6vPqu88yb5ht+Bq00yWcJYXpjX/SxXGxJpipmuVw3MWEROBxSZC97/dbl/QTK74h6GQwA/7rN0stGwUce2LgihOj0MthD//+sR3/ywHYAjBZ3gSBNI4d8flJ0smmCpwIEx7UjmatEvm00R6mDsfoXIXtnYXd/hPT+njt3sa+CC8dC9XORB4oVkHR4UXCmRRiPBR45LoYiwm4IZeK8TcWUlPK0i5wgyCIawpWxbSc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1e0c18-4924-48e3-5ff9-08d7f18b7960
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 07:02:43.6257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHtiBiobDUuWZsEgV1Cyo64H7nRUYUj9QvPwMcdTg95iAVfPKNXA6swhtSqooygl2VlMP8vn//GTD6oLwhzD8pK6XRxb8AzIsn8pG2E4fzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5350
Received-SPF: pass client-ip=40.107.2.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 03:02:44
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.04.2020 17:39, Vladimir Sementsov-Ogievskiy wrote:
> It's safer to expand in_flight request to start before enter to
> coroutine in synchronous wrappers, due to the following (theoretical)
> problem:
> 
> Consider write.
> It's possible, that qemu_coroutine_enter only schedules execution,
> assume such case.
> 
> Then we may possibly have the following:
> 
> 1. Somehow check that we are not in drained section in outer code.
> 
> 2. Call bdrv_pwritev(), assuming that it will increase in_flight, which
> will protect us from starting drained section.
> 
> 3. It calls bdrv_prwv_co() -> bdrv_coroutine_enter() (not yet increased
> in_flight).
> 
> 4. Assume coroutine not yet actually entered, only scheduled, and we go
> to some code, which starts drained section (as in_flight is zero).
> 
> 5. Scheduled coroutine starts, and blindly increases in_flight, and we
> are in drained section with in_flight request.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Very interesting: this patch breaks test-replication. It hangs:

(gdb) thr a a bt

Thread 2 (Thread 0x7eff256cd700 (LWP 2843)):
#0  0x00007eff2f5fd1fd in syscall () from /lib64/libc.so.6
#1  0x000055af9a9a4f11 in qemu_futex_wait (f=0x55af9aa6f758 <rcu_call_ready_event>, val=4294967295) at /work/src/qemu/up-expand-bdrv-in_flight-bounds/include/qemu/futex.h:29
#2  0x000055af9a9a50d5 in qemu_event_wait (ev=0x55af9aa6f758 <rcu_call_ready_event>) at util/qemu-thread-posix.c:459
#3  0x000055af9a9bd20d in call_rcu_thread (opaque=0x0) at util/rcu.c:260
#4  0x000055af9a9a5288 in qemu_thread_start (args=0x55af9c4f1b80) at util/qemu-thread-posix.c:519
#5  0x00007eff2f6d44c0 in start_thread () from /lib64/libpthread.so.0
#6  0x00007eff2f602553 in clone () from /lib64/libc.so.6

Thread 1 (Thread 0x7eff25820a80 (LWP 2842)):
#0  0x00007eff2f5f7bd6 in ppoll () from /lib64/libc.so.6
#1  0x000055af9a99e405 in qemu_poll_ns (fds=0x55af9c52a830, nfds=1, timeout=-1) at util/qemu-timer.c:335
#2  0x000055af9a9a1cab in fdmon_poll_wait (ctx=0x55af9c526890, ready_list=0x7ffc73e8c5d0, timeout=-1) at util/fdmon-poll.c:79
#3  0x000055af9a9a160c in aio_poll (ctx=0x55af9c526890, blocking=true) at util/aio-posix.c:600
#4  0x000055af9a8f0bb0 in bdrv_do_drained_begin (bs=0x55af9c52a8d0, recursive=false, parent=0x0, ignore_bds_parents=false, poll=true) at block/io.c:429
#5  0x000055af9a8f0c95 in bdrv_drained_begin (bs=0x55af9c52a8d0) at block/io.c:435
#6  0x000055af9a8dc6a8 in blk_drain (blk=0x55af9c542c10) at block/block-backend.c:1681
#7  0x000055af9a8da0b6 in blk_unref (blk=0x55af9c542c10) at block/block-backend.c:473
#8  0x000055af9a8eb5e7 in mirror_exit_common (job=0x55af9c6c45c0) at block/mirror.c:667
#9  0x000055af9a8eb9c1 in mirror_prepare (job=0x55af9c6c45c0) at block/mirror.c:765
#10 0x000055af9a87cd65 in job_prepare (job=0x55af9c6c45c0) at job.c:781
#11 0x000055af9a87b62a in job_txn_apply (job=0x55af9c6c45c0, fn=0x55af9a87cd28 <job_prepare>) at job.c:158
#12 0x000055af9a87cdee in job_do_finalize (job=0x55af9c6c45c0) at job.c:798
#13 0x000055af9a87cfb5 in job_completed_txn_success (job=0x55af9c6c45c0) at job.c:852
#14 0x000055af9a87d055 in job_completed (job=0x55af9c6c45c0) at job.c:865
#15 0x000055af9a87d0a8 in job_exit (opaque=0x55af9c6c45c0) at job.c:885
#16 0x000055af9a99b981 in aio_bh_call (bh=0x55af9c547440) at util/async.c:136
#17 0x000055af9a99ba8b in aio_bh_poll (ctx=0x55af9c526890) at util/async.c:164
#18 0x000055af9a9a17ff in aio_poll (ctx=0x55af9c526890, blocking=true) at util/aio-posix.c:650
#19 0x000055af9a8f7011 in bdrv_flush (bs=0x55af9c53b900) at block/io.c:3019
#20 0x000055af9a874351 in bdrv_close (bs=0x55af9c53b900) at block.c:4252
#21 0x000055af9a874ca3 in bdrv_delete (bs=0x55af9c53b900) at block.c:4498
#22 0x000055af9a877862 in bdrv_unref (bs=0x55af9c53b900) at block.c:5866
#23 0x000055af9a870837 in bdrv_root_unref_child (child=0x55af9c6c4430) at block.c:2684
#24 0x000055af9a8da9a2 in blk_remove_bs (blk=0x55af9c547bd0) at block/block-backend.c:803
#25 0x000055af9a8d9e54 in blk_delete (blk=0x55af9c547bd0) at block/block-backend.c:422
#26 0x000055af9a8da0f8 in blk_unref (blk=0x55af9c547bd0) at block/block-backend.c:477
#27 0x000055af9a86a6f1 in teardown_secondary () at tests/test-replication.c:392
#28 0x000055af9a86aac1 in test_secondary_stop () at tests/test-replication.c:490
#29 0x00007eff2fd7df7e in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
#30 0x00007eff2fd7dd24 in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
#31 0x00007eff2fd7dd24 in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
#32 0x00007eff2fd7e46a in g_test_run_suite () from /lib64/libglib-2.0.so.0
#33 0x00007eff2fd7e485 in g_test_run () from /lib64/libglib-2.0.so.0
#34 0x000055af9a86b19c in main (argc=1, argv=0x7ffc73e8d088) at tests/test-replication.c:645


(gdb) p ((BlockBackend *)0x55af9c547bd0)->in_flight
$5 = 0
(gdb) p ((BlockBackend *)0x55af9c542c10)->in_flight
$6 = 0
(gdb) p ((BlockDriverState *)0x55af9c53b900)->in_flight
$7 = 1
(gdb) p ((BlockDriverState *)0x55af9c52a8d0)->in_flight
$8 = 0
(gdb) fr 20
#20 0x000055af9a874351 in bdrv_close (bs=0x55af9c53b900) at block.c:4252
4252        bdrv_flush(bs);
(gdb) p bs->node_name
$9 = "#block5317", '\000' <repeats 21 times>
(gdb) p bs->drv
$10 = (BlockDriver *) 0x55af9aa63c40 <bdrv_replication>
(gdb) p bs->in_flight
$11 = 1
(gdb) p bs->tracked_requests
$12 = {lh_first = 0x0}


So, we entered bdrv_flush at frame 19, and increased in_flight. Then we go to aio_poll and to nested event loop, and we never return to decrease in_flight field.

Hmm. I'm afraid, I don't know what to do with that. Kevin, could you take a look? And could similar thing happen with blk layer, because of you recent similar patch?


-- 
Best regards,
Vladimir

