Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54825C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C792206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VdDBShbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C792206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrOa-0000x2-6x
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDrNV-0008AH-7P; Thu, 03 Sep 2020 11:42:21 -0400
Received: from mail-eopbgr10091.outbound.protection.outlook.com
 ([40.107.1.91]:55325 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDrNS-0002np-5B; Thu, 03 Sep 2020 11:42:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyD6kEsFVmO+eAhhpfBBDeJ99E9IZ3TRsUy+CTwIgJfOrd40npyw95jmS8k89WXt0IiaJ1PPqJuXmPrEvKfCTINAbcn5CQARKA6+NZuilDH0qY/3PVSSggjDD23rpeITQBZ26tqakK04Ud6fmzMMv30AqQ4yqYrVx1Nu7dI0vx3OdqFoGzJGwL3FjzLnVLQS67KDeVa+JY2ZlV/DQCW84ZUdZpkFMaAc/J0EmgRGUptCphP1N6JlCCjIG3HSNqBQpqy1ZF3k7cuKjRBBanUH9xP9q3DBTetuTEikiG3pqjh6t0o7WQNqsIe8NT/bxLhNsCrVzRZe8nqJFjxsPU9ecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bh93ofO8sSw1bXzPpA7HOW99mBCnlhMyCnYVuYHVxBw=;
 b=altJh1jW7dEpXiw6wLpkeUFY0sbhNsIQuOU0HlZv6ogA6TyAGK0dzh0ct1o9F6Lcg0hhgM0hEOTFvKgq03PfnUkig7zJvGUjqvPApb0Ov96Mg34+Eo0dQaiHVFIfrT0DQl/Jw8EMVBuqlor1WWnHdlehulj/p/GiNyeFSdGeVbIRS2YFsWjs4a5E/uG+JoKa49x6ZwPXzlWSZImJolDXtkBo6nxDl7rgcuCy5uOsb1nFddEGDeGycs9ZG7RghvJad1KAuFpj0xyUD97TaU8xHpU95Uqgx76MYdV1pAcVNJcMFk+5uZtABJJMQ3TqbId0XcUJ9cGnQAr25JpIAbIj+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bh93ofO8sSw1bXzPpA7HOW99mBCnlhMyCnYVuYHVxBw=;
 b=VdDBShbLVg8Euvxabv1xhqxxNHz90Xkru3qP+quUxrNZ5YjbLbimDUPjeQtedI642y/FhRSJdrqR+MlLuxLVtdW6HVCW6XaRlTKHmkejvDCOpq56XL+BFLjP1b4zZA7lcgxACOpz5Efwx8sqDBNc++6TjhIa4QZiitLNStBy2Wg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4690.eurprd08.prod.outlook.com (2603:10a6:20b:cd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 3 Sep
 2020 15:42:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 15:42:14 +0000
Subject: Re: flatview_write_continue global mutex deadlock
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu block <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <3abe8579-3540-72fd-c452-3cc52d7fcf26@virtuozzo.com>
 <d8bb04e7-6edd-8b3d-8896-31c4d4075006@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <242c6d2e-9c9a-7a73-aa47-c2283c3d3a1e@virtuozzo.com>
Date: Thu, 3 Sep 2020 18:42:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <d8bb04e7-6edd-8b3d-8896-31c4d4075006@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0097.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM0PR01CA0097.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Thu, 3 Sep 2020 15:42:13 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a983104-4e97-4f76-61bb-08d8501fedf5
X-MS-TrafficTypeDiagnostic: AM6PR08MB4690:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4690A91AD38F516F0C22B07CC12C0@AM6PR08MB4690.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:199;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CwOpZT09EYkOk7xYwH29XaZ9qiwU66qAKJEfzlbJdWXyCKDhCa/SK+dKPOyBr5ELNto5txs9RUgmXNsZ4bL4sy6eE9+Wjm05eqz51QT7FJBv0rsU6O+Fl5hXfgUIFn9VcQnSCLjQlHzwCsALOl+Fhg/9Sr2ugOcWvsEMnKuQXaTlxcTq5iuAYbqIvrqOG2E8pT0tfGU6JEKYCNwoSXqy06V3MHCc/siNJWmMcpP2xHqMzZjVvbPleKIGj5wYunrolHiZgUDi207RLHj1gXEz4NED2UvhF46fiM4QESnqgseqdsQn6xYiDBKgn214Lwk7pgEGtMzfAWVX2UHTU3aTTZdiDi/oiLSvK4h1gHBG3clK4MrrHzOOl5vfwhPhOHRw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(396003)(376002)(346002)(136003)(8936002)(2616005)(8676002)(31696002)(86362001)(4326008)(956004)(316002)(66476007)(66946007)(110136005)(54906003)(16576012)(2906002)(26005)(53546011)(186003)(6486002)(5660300002)(36756003)(52116002)(83380400001)(31686004)(478600001)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4mDGw1wLXevP/FrIAv22V265m+Blg3Sp6u/ShfkmvDd3DBNATaWaMc1PWA/UMzlOAL02dkzW7dPMTMWC67KdJTwhwOx44G5pShExUp513FR98FM8/PZrg6v6Uhu5rykd+83Z726C+RnpXOMMaPT9LZqsESGDejpdI+UXQjGpROlJjVCshz3GbkcGv+px7RbzQrLWWRGe0iTrGNkHO9AWl8zJkMCnGWjqxxHuM64Q+A3jWextSrek30SAljiKAWrUDdu0n29Vfv6yZnGodvl+Czj+rTSaA0cpkUt9XmmgcOkpq45KXXo6/rJj4NuAI6lZEAguAsB5M6Tk3racIogmo6v6a7Zbv8+XbPl16Ex5iuaC5DwJRigl4ztqC54sh0sVUNZT66D3dFNpwOKGO5PpnDp9LNHnaDg5Ba75q+VIC8GP+XGqBHuVZrXMvwx3SMm6h4lLaf5m2FZSA4y8uttGbyTDQY8AXPzZjUE5OinJReWIfn2T8YruqvE4jEqh/6yQPHWeCX/68u3m1zdW6FY0RRVNA/e0H+1fgwO0P3YHcRqdZEUfpwjMtiJVxX8ZfrpWCVj4Aw9+HYtXFspwr+HoL1U1o99cUAgdXYKTqfAOaadWs/ccH3a7ohpcInr/SZsjDUir74guT+CeqY4eyzBzhA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a983104-4e97-4f76-61bb-08d8501fedf5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 15:42:14.0848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83JnnRNIBKryfswbIKOlR96cHOJ6EA27TR89uVhNyzJPYudXkb2N2zfnqaQGTpQ5i6uXXQlyvtfto4IbtuqXnh7JbPtuxPynIJtU2WktCjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4690
Received-SPF: pass client-ip=40.107.1.91;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 11:42:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.403, RCVD_ILLEGAL_IP=1.3,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.09.2020 15:29, Paolo Bonzini wrote:
> On 03/09/20 13:16, Vladimir Sementsov-Ogievskiy wrote:
>> (gdb) info thr
>>    Id   Target Id                                            Frame
>> * 1    Thread 0x7fb9f0f39e00 (LWP 215115) "qemu-system-x86"
>> 0x00007fb9d784f54d in __lll_lock_wait () from /lib64/libpthread.so.0
>> [...]
>> #1  0x000056069bfbd3f1 in qemu_poll_ns (fds=0x7fb9401dcdf0, nfds=1,
>> timeout=542076652475) at ../util/qemu-timer.c:347
>> #2  0x000056069bfd949f in fdmon_poll_wait (ctx=0x56069e6864c0,
>> ready_list=0x7fb9481fc200, timeout=542076652475) at ../util/fdmon-poll.c:79
>> #3  0x000056069bfcdf4c in aio_poll (ctx=0x56069e6864c0, blocking=true)
>> at ../util/aio-posix.c:601
>> #4  0x000056069be80cf3 in bdrv_do_drained_begin (bs=0x56069e6c0950,
>> recursive=false, parent=0x0, ignore_bds_parents=false, poll=true) at
>> ../block/io.c:427
>> #5  0x000056069be80ddb in bdrv_drained_begin (bs=0x56069e6c0950) at
>> ../block/io.c:433
>> #6  0x000056069bf1e5b4 in blk_drain (blk=0x56069e6adb50) at
>> ../block/block-backend.c:1718
>> #7  0x000056069ba40fb5 in ide_cancel_dma_sync (s=0x56069f0d1548) at
>> ../hw/ide/core.c:723
>> [...]
>> #13 0x000056069bd965e2 in flatview_write_continue (fv=0x7fb9401ce100,
>> addr=49152, attrs=..., ptr=0x7fb9f0f87000, len=1, addr1=0, l=1,
>> mr=0x56069f0d2420) at ../exec.c:3176
> 
> So this is a vCPU thread.  The question is, why is the reconnect timer
> not on the same AioContext?  If it were, aio_poll would execute it.
> 
> Paolo
> 

(gdb) fr 4
#4  0x0000564cdffabcf3 in bdrv_do_drained_begin (bs=0x564ce2112950, recursive=false, parent=0x0, ignore_bds_parents=false, poll=true) at ../block/io.c:427
427             BDRV_POLL_WHILE(bs, bdrv_drain_poll_top_level(bs, recursive, parent));
(gdb) p bs->aio_context
$2 = (AioContext *) 0x564ce20d84c0
(gdb) p bs->drv
$3 = (BlockDriver *) 0x564ce088bb60 <bdrv_nbd_unix>
(gdb) set $s=(BDRVNBDState *)bs->opaque
(gdb) p $s->connection_co
connection_co                 connection_co_sleep_ns_state
(gdb) p $s->connection_co_sleep_ns_state
$4 = (QemuCoSleepState *) 0x0
(gdb) p $s->state
$5 = NBD_CLIENT_CONNECTING_WAIT
(gdb) p $s->connection_co
$6 = (Coroutine *) 0x564ce2118880

...

(gdb) qemu coroutine $6
#0  0x0000564ce00f402b in qemu_coroutine_switch (from_=0x564ce2118880, to_=0x7f8dd2fff598, action=COROUTINE_YIELD) at ../util/coroutine-ucontext.c:302
#1  0x0000564ce00c2b1a in qemu_coroutine_yield () at ../util/qemu-coroutine.c:193
#2  0x0000564cdffc4e50 in nbd_co_reconnect_loop (s=0x564ce21180e0) at ../block/nbd.c:352
#3  0x0000564cdffc4f13 in nbd_connection_entry (opaque=0x564ce21180e0) at ../block/nbd.c:386
#4  0x0000564ce00f3d33 in coroutine_trampoline (i0=-502167424, i1=22092) at ../util/coroutine-ucontext.c:173
#5  0x00007f8e621cc190 in ?? () from /lib64/libc.so.6
#6  0x00007ffcb9b51540 in ?? ()
#7  0x0000000000000000 in ?? ()

so no timer exists now: reconnect code goes to yield during drain, to continue after drain-end.. Haha, that's obviously bad design, as nobody will wake up the waiting requests, and drain will hang forever. OK thanks, you helped me, I see now that nbd code is wrong..

But still, is it OK to do blk_drain holding the global mutex? Drain may take a relatively long time, and vm is not responding due to global mutex locked in cpu thread..

-- 
Best regards,
Vladimir

