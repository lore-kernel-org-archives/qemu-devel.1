Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A3AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 11:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B159206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 11:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A7QyyOJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B159206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb0O6-0004bT-8o
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 07:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb0NW-0004BE-DL; Tue, 19 May 2020 07:25:46 -0400
Received: from mail-eopbgr50118.outbound.protection.outlook.com
 ([40.107.5.118]:4073 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb0NU-0006A0-Rl; Tue, 19 May 2020 07:25:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt3ZyDJucpehypytHpmg1msHnNE2k+WxJgf2qXGhYUwJsPzDA3fhyIk91Yfp6y9cpm50aDsZrpD1h1dV5ohKJHlFbqIwp9tzQDnuIrnuqFQWjgyAtLxgvZgELAmjiy6Hb2iFdgONh6tTAsypViSTDI8PqtIODP/IjAIFgYiLSS/FVL8OM0+ekMSENagAUU6CYAqlTnzHutUfBY+QktuQv6Wdtz6RkdQI574srNrFGEzDK/MqnSnXJNj6PwmyQj1y2BHDStaP7LeTCYnGGi5kRbx5tFLkK6KkbKbJ0CXcobqkYiCHx081jVlZz9QVsdRU3pj04MFK+BFdRACDCLbU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVTixBgLImhysSWgsFYYojIcGCE5/ttx/FXEpLiaqP0=;
 b=Gq/XazOEuETj7HdvN99b7F8ITA5P4XRinHQ3OdgvGU4Dm0juLkaT0AYX91kdZanigtbviMA/hXC6y1+9tAok3n+SBHU7oV5ggguxz23COiL++Jsd8icGqxyb5jzlEraj8iANS9iBp6dSOPgTa1YwZTAtjh3mAa4IQx5iynUTRmVzi/InbpcxIWPZyWDJ0XQ4Kov7qIstLcTx2J+OBzcuUWWn1CwL6NFg/7im+HjCxLgM0cviMZxOwLCT1pXctMZeGlRoNT+iGO7qrtjbcc429Vijb6BwHN+UXRSGDhQ2ppESjKvutLqbwd29wWz+SngqSGnVDDA8A6x4Poa3Km5wgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVTixBgLImhysSWgsFYYojIcGCE5/ttx/FXEpLiaqP0=;
 b=A7QyyOJ9MqGxJBK9hKeuYhbJ8MBROlA7nb+huKCaSO8noKXFKfSTz9W3nc7HfpJ4jMtqU5yWY+Op4yXF+gqlfEa+450ZSdAcFQ6QhTgUqeZVrnxe/pJksr0KcthbrVFc/kc6QnzyKgtywRxj2zp9qIeokrlG+LV/7cw3Y1Csv5Y=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5525.eurprd08.prod.outlook.com (2603:10a6:20b:107::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 11:25:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 11:25:41 +0000
Subject: Re: [PATCH v2 5/9] block/io: expand in_flight inc/dec section: simple
 cases
To: Kevin Wolf <kwolf@redhat.com>
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
 <20200427143907.5710-6-vsementsov@virtuozzo.com>
 <efc8e783-0541-6b95-1356-71ccc823cad2@virtuozzo.com>
 <20200519105241.GH7652@linux.fritz.box>
 <d1908d96-4950-22be-45c0-86750f5780c6@virtuozzo.com>
 <20200519111648.GK7652@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f3f34ee7-836e-c329-a1f3-65586faec85f@virtuozzo.com>
Date: Tue, 19 May 2020 14:25:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200519111648.GK7652@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0004.eurprd03.prod.outlook.com
 (2603:10a6:205:2::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM4PR0302CA0004.eurprd03.prod.outlook.com (2603:10a6:205:2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Tue, 19 May 2020 11:25:40 +0000
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80130bb8-87c5-4802-5e9b-08d7fbe75d2d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB552549D802CFF1B62F048151C1B90@AM7PR08MB5525.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnZoafVVapsNuXLyP5dAyivzSTRN6O34MzvABhz18dCKEMBlmf5w6PPat072nCYe33+suQjON3MNYCX+fruDIwCLI49iYJdo9lMvemNEOg7LTxIBxbZ4dH5nfMcPaDWQAfZ/1vawQzmilrTnn2KISsXVtx2A3RZo881N7c6GNOZQDSNhpF/Pkv6Q/qPHzbOubJVNC9Ebkmr94ZyZb+65ZFd/w7QL9WvOgAkichi3BmeaadS6VSryBoQeivG4E0Tfe9mwtZ54NiJ3Osdvu4NAobrcP7YVEwJ4j28zaEFrTA0WZgJh5oVQ5jl2dD6OhBJan6OfvoVkDLnbFSgFT8BBHaroCRe7xTpOkms5Tgt+Jw1yIgga+CkNQ0j9Zl8rVQ5YSk35JPXRrj1XNvI0KtTqrAM/C9EiU665nvm5Ngfelr9ZHUYhNpCMp+uvlMwps3eGXwXXu2am31/zvxgcbFg9ilPLaK1PIVEq9gRs2HbQcN+XTxZ+Bjv1friw4eOpPwty
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39850400004)(66946007)(31696002)(956004)(478600001)(31686004)(8676002)(2616005)(5660300002)(4326008)(6486002)(8936002)(16576012)(316002)(36756003)(26005)(52116002)(2906002)(107886003)(66556008)(66476007)(86362001)(16526019)(6916009)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Tc2pXF5TaKnXYz+WwemB9IZitEL2unU3S+g6pE9DWHPzWSb0z4So7MyzHnsI0LkzVucE++EWiUMBIVZA3Br3T4dvfkjsvlccMvvvSRNEfy3vAP1QlWEfzXM4KymYTdFvfbQtup2Wf9vNt/492RnK4n4m+9SWyoywF3GGzgWr6gdMZNL8hoi50/sB2p8Z5OenQC+P656jVEozi7D1bCDm/1yYjcafQCYV4wS7xL8S2c8gPJ0H4/rGlMF51M31T1i54EliOQAjjWNNRGnrcY9VECU9p6IpaKLMX/90ex7ttu6AKJh1TYdHm9n3nKuFedBk4vV6EtP6a/89nvfy5lZoBc81MKov14j2rxHW4aNRc8CgzWV8WlLPQmazl7q0pjLO4Ner2wR+7VTRNRXceRynJn7yVHTgmc0LGaYZKlxliO+AuUAcXUCt1bT7OZGFkuiIqd0MS/uDksSj3jg5tN+MBnJG9xlEVctC9lhK9Fzy9T68J2SVsqRS7RxvFUzS8Esx
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80130bb8-87c5-4802-5e9b-08d7fbe75d2d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 11:25:41.6262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2MueAzehaiXtatc7v25LwSYm8QqKSl+gmTevMzQiIPB2IAcTaDLPp4wQemq0tf8tN/MX1QondZhO6BgP02oXMMeaVrRFqtMkhnzIBq34P6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5525
Received-SPF: pass client-ip=40.107.5.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 07:25:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: fam@euphon.net, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.05.2020 14:16, Kevin Wolf wrote:
> Am 19.05.2020 um 13:06 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 19.05.2020 13:52, Kevin Wolf wrote:
>>> Am 06.05.2020 um 09:02 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> 27.04.2020 17:39, Vladimir Sementsov-Ogievskiy wrote:
>>>>> It's safer to expand in_flight request to start before enter to
>>>>> coroutine in synchronous wrappers, due to the following (theoretical)
>>>>> problem:
>>>>>
>>>>> Consider write.
>>>>> It's possible, that qemu_coroutine_enter only schedules execution,
>>>>> assume such case.
>>>>>
>>>>> Then we may possibly have the following:
>>>>>
>>>>> 1. Somehow check that we are not in drained section in outer code.
>>>>>
>>>>> 2. Call bdrv_pwritev(), assuming that it will increase in_flight, which
>>>>> will protect us from starting drained section.
>>>>>
>>>>> 3. It calls bdrv_prwv_co() -> bdrv_coroutine_enter() (not yet increased
>>>>> in_flight).
>>>>>
>>>>> 4. Assume coroutine not yet actually entered, only scheduled, and we go
>>>>> to some code, which starts drained section (as in_flight is zero).
>>>>>
>>>>> 5. Scheduled coroutine starts, and blindly increases in_flight, and we
>>>>> are in drained section with in_flight request.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>
>>>> Very interesting: this patch breaks test-replication. It hangs:
>>>>
>>>> (gdb) thr a a bt
>>>>
>>>> Thread 2 (Thread 0x7eff256cd700 (LWP 2843)):
>>>> #0  0x00007eff2f5fd1fd in syscall () from /lib64/libc.so.6
>>>> #1  0x000055af9a9a4f11 in qemu_futex_wait (f=0x55af9aa6f758 <rcu_call_ready_event>, val=4294967295) at /work/src/qemu/up-expand-bdrv-in_flight-bounds/include/qemu/futex.h:29
>>>> #2  0x000055af9a9a50d5 in qemu_event_wait (ev=0x55af9aa6f758 <rcu_call_ready_event>) at util/qemu-thread-posix.c:459
>>>> #3  0x000055af9a9bd20d in call_rcu_thread (opaque=0x0) at util/rcu.c:260
>>>> #4  0x000055af9a9a5288 in qemu_thread_start (args=0x55af9c4f1b80) at util/qemu-thread-posix.c:519
>>>> #5  0x00007eff2f6d44c0 in start_thread () from /lib64/libpthread.so.0
>>>> #6  0x00007eff2f602553 in clone () from /lib64/libc.so.6
>>>>
>>>> Thread 1 (Thread 0x7eff25820a80 (LWP 2842)):
>>>> #0  0x00007eff2f5f7bd6 in ppoll () from /lib64/libc.so.6
>>>> #1  0x000055af9a99e405 in qemu_poll_ns (fds=0x55af9c52a830, nfds=1, timeout=-1) at util/qemu-timer.c:335
>>>> #2  0x000055af9a9a1cab in fdmon_poll_wait (ctx=0x55af9c526890, ready_list=0x7ffc73e8c5d0, timeout=-1) at util/fdmon-poll.c:79
>>>> #3  0x000055af9a9a160c in aio_poll (ctx=0x55af9c526890, blocking=true) at util/aio-posix.c:600
>>>> #4  0x000055af9a8f0bb0 in bdrv_do_drained_begin (bs=0x55af9c52a8d0, recursive=false, parent=0x0, ignore_bds_parents=false, poll=true) at block/io.c:429
>>>> #5  0x000055af9a8f0c95 in bdrv_drained_begin (bs=0x55af9c52a8d0) at block/io.c:435
>>>> #6  0x000055af9a8dc6a8 in blk_drain (blk=0x55af9c542c10) at block/block-backend.c:1681
>>>> #7  0x000055af9a8da0b6 in blk_unref (blk=0x55af9c542c10) at block/block-backend.c:473
>>>> #8  0x000055af9a8eb5e7 in mirror_exit_common (job=0x55af9c6c45c0) at block/mirror.c:667
>>>> #9  0x000055af9a8eb9c1 in mirror_prepare (job=0x55af9c6c45c0) at block/mirror.c:765
>>>> #10 0x000055af9a87cd65 in job_prepare (job=0x55af9c6c45c0) at job.c:781
>>>> #11 0x000055af9a87b62a in job_txn_apply (job=0x55af9c6c45c0, fn=0x55af9a87cd28 <job_prepare>) at job.c:158
>>>> #12 0x000055af9a87cdee in job_do_finalize (job=0x55af9c6c45c0) at job.c:798
>>>> #13 0x000055af9a87cfb5 in job_completed_txn_success (job=0x55af9c6c45c0) at job.c:852
>>>> #14 0x000055af9a87d055 in job_completed (job=0x55af9c6c45c0) at job.c:865
>>>> #15 0x000055af9a87d0a8 in job_exit (opaque=0x55af9c6c45c0) at job.c:885
>>>> #16 0x000055af9a99b981 in aio_bh_call (bh=0x55af9c547440) at util/async.c:136
>>>> #17 0x000055af9a99ba8b in aio_bh_poll (ctx=0x55af9c526890) at util/async.c:164
>>>> #18 0x000055af9a9a17ff in aio_poll (ctx=0x55af9c526890, blocking=true) at util/aio-posix.c:650
>>>> #19 0x000055af9a8f7011 in bdrv_flush (bs=0x55af9c53b900) at block/io.c:3019
>>>> #20 0x000055af9a874351 in bdrv_close (bs=0x55af9c53b900) at block.c:4252
>>>> #21 0x000055af9a874ca3 in bdrv_delete (bs=0x55af9c53b900) at block.c:4498
>>>> #22 0x000055af9a877862 in bdrv_unref (bs=0x55af9c53b900) at block.c:5866
>>>> #23 0x000055af9a870837 in bdrv_root_unref_child (child=0x55af9c6c4430) at block.c:2684
>>>> #24 0x000055af9a8da9a2 in blk_remove_bs (blk=0x55af9c547bd0) at block/block-backend.c:803
>>>> #25 0x000055af9a8d9e54 in blk_delete (blk=0x55af9c547bd0) at block/block-backend.c:422
>>>> #26 0x000055af9a8da0f8 in blk_unref (blk=0x55af9c547bd0) at block/block-backend.c:477
>>>> #27 0x000055af9a86a6f1 in teardown_secondary () at tests/test-replication.c:392
>>>> #28 0x000055af9a86aac1 in test_secondary_stop () at tests/test-replication.c:490
>>>> #29 0x00007eff2fd7df7e in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
>>>> #30 0x00007eff2fd7dd24 in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
>>>> #31 0x00007eff2fd7dd24 in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
>>>> #32 0x00007eff2fd7e46a in g_test_run_suite () from /lib64/libglib-2.0.so.0
>>>> #33 0x00007eff2fd7e485 in g_test_run () from /lib64/libglib-2.0.so.0
>>>> #34 0x000055af9a86b19c in main (argc=1, argv=0x7ffc73e8d088) at tests/test-replication.c:645
>>>>
>>>>
>>>> (gdb) p ((BlockBackend *)0x55af9c547bd0)->in_flight
>>>> $5 = 0
>>>> (gdb) p ((BlockBackend *)0x55af9c542c10)->in_flight
>>>> $6 = 0
>>>> (gdb) p ((BlockDriverState *)0x55af9c53b900)->in_flight
>>>> $7 = 1
>>>> (gdb) p ((BlockDriverState *)0x55af9c52a8d0)->in_flight
>>>> $8 = 0
>>>> (gdb) fr 20
>>>> #20 0x000055af9a874351 in bdrv_close (bs=0x55af9c53b900) at block.c:4252
>>>> 4252        bdrv_flush(bs);
>>>> (gdb) p bs->node_name
>>>> $9 = "#block5317", '\000' <repeats 21 times>
>>>> (gdb) p bs->drv
>>>> $10 = (BlockDriver *) 0x55af9aa63c40 <bdrv_replication>
>>>> (gdb) p bs->in_flight
>>>> $11 = 1
>>>> (gdb) p bs->tracked_requests
>>>> $12 = {lh_first = 0x0}
>>>>
>>>>
>>>> So, we entered bdrv_flush at frame 19, and increased in_flight. Then
>>>> we go to aio_poll and to nested event loop, and we never return to
>>>> decrease in_flight field.
>>>>
>>>> Hmm. I'm afraid, I don't know what to do with that. Kevin, could you
>>>> take a look? And could similar thing happen with blk layer, because of
>>>> you recent similar patch?
>>>
>>> Hmm... You mean blk_prw(), right? Looks like it could have the same
>>> problem, indeed.
>>>
>>> Maybe we need to move the blk/bdrv_dec_in_flight to inside the coroutine
>>> (probably to the place where we currently have aio_wait_kick(), which
>>> would already be built in for bdrv_dec_in_flight). This is the last
>>> thing the coroutine does, so presumably it will still be late enough.
>>>
>>
>> But moving "inc" into coroutine is dangerous too, as we discussed that
>> coroutine_enter may only schedule the coroutine, and something may
>> call drain before actual "inc".
> 
> No, I mean moving only the dec, not inc. So inc before entering the
> coroutine (outside of it), and dec at the end, but still inside the
> coroutine.
> 

Hmm. it probably make sense. Ha, I hastened to answer on cover-letter that this all to be dropped. Ok, I'll give it a roll and check your idea, thanks!


-- 
Best regards,
Vladimir

