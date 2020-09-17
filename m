Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0559C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DB42072E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DB42072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIoUm-0006oF-AP
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1kIoTp-0006KV-SZ; Thu, 17 Sep 2020 03:37:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4752 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1kIoTm-0003VC-Q3; Thu, 17 Sep 2020 03:37:21 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 42F7812804110A51BA6F;
 Thu, 17 Sep 2020 15:37:06 +0800 (CST)
Received: from [10.174.187.142] (10.174.187.142) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:36:57 +0800
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200810145246.1049-1-yezhenyu2@huawei.com>
 <20200810153811.GF14538@linux.fritz.box>
 <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
 <20200914132738.GL579094@stefanha-x1.localdomain>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <7ad220bd-7ee5-1f66-b2e5-7dc57d72eb2e@huawei.com>
Date: Thu, 17 Sep 2020 15:36:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200914132738.GL579094@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.142]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=yezhenyu2@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 03:37:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.062,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, fam@euphon.net, qemu-block@nongnu.org,
 armbru@redhat.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 2020/9/14 21:27, Stefan Hajnoczi wrote:
>>
>> Theoretically, everything running in an iothread is asynchronous. However,
>> some 'asynchronous' actions are not non-blocking entirely, such as
>> io_submit().  This will block while the iodepth is too big and I/O pressure
>> is too high.  If we do some qmp actions, such as 'info block', at this time,
>> may cause vm soft lockup.  This series can make these qmp actions safer.
>>
>> I constructed the scene as follow:
>> 1. create a vm with 4 disks, using iothread.
>> 2. add press to the CPU on the host.  In my scene, the CPU usage exceeds 95%.
>> 3. add press to the 4 disks in the vm at the same time.  I used the fio and
>> some parameters are:
>>
>> 	 fio -rw=randrw -bs=1M -size=1G -iodepth=512 -ioengine=libaio -numjobs=4
>>
>> 4. do block query actions, for example, by virsh:
>>
>> 	virsh qemu-monitor-command [vm name] --hmp info block
>>
>> Then the vm will soft lockup, the calltrace is:
>>
>> [  192.311393] watchdog: BUG: soft lockup - CPU#1 stuck for 42s! [kworker/1:1:33]
> 
> Hi,
> Sorry I haven't had time to investigate this myself yet.
> 
> Do you also have a QEMU backtrace when the hang occurs?
> 
> Let's find out if QEMU is stuck in the io_submit(2) syscall or whether
> there's an issue in QEMU itself that causes the softlockup (for example,
> aio_poll() with the global mutex held).

Sorry for the delay.

I traced the io_submit() within the guest. The maximum execution time exceeds 16s:

	guest# perf trace -p `pidof -s fio` --duration 1
	    14.808 (3843.082 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
	  3861.336 (11470.608 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
	 15341.998 (479.283 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
	 15831.380 (3704.997 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
	 19547.869 (3412.839 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
	 22966.953 (1080.854 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
	 24062.689 (6939.813 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
	 31019.219 (532.147 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
	 31556.610 (3469.920 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
	 35038.885 (9007.175 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
	 44053.578 (16006.405 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
	 60068.944 (3068.748 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
	 63138.474 (13012.499 ms): io_getevents(ctx_id: 281472924459008, min_nr: 511, nr: 511, events: 0x19a83150) = 511
	 76191.073 (2872.657 ms): io_submit(ctx_id: 281472924459008, nr: 1, iocbpp: 0x19a87160          ) = 1
	...

And in the host, the information of sys_enter_io_submit() is:

	Samples: 3K of event 'syscalls:sys_enter_io_submit', Event count (approx.): 3150
	Children      Self  Trace output
	-   66.70%    66.70%  ctx_id: 0xffff9c044000, nr: 0x00000001, iocbpp: 0xffff9f7fad28
	0xffffae7f871c
	0xffffae8a27c4
	qemu_thread_start
	iothread_run
	aio_poll
	aio_dispatch_ready_handlers
	aio_dispatch_handler
	virtio_queue_host_notifier_aio_read
	virtio_queue_notify_aio_vq
	virtio_blk_data_plane_handle_output
	virtio_blk_handle_vq
	blk_io_unplug
	bdrv_io_unplug
	bdrv_io_unplug
	raw_aio_unplug
	laio_io_unplug
	syscall


When the hang occurs, the QEMU is blocked at:

	#0  0x0000ffff95762b64 in ?? () from target:/usr/lib64/libpthread.so.0
	#1  0x0000ffff9575bd88 in pthread_mutex_lock () from target:/usr/lib64/libpthread.so.0
	#2  0x0000aaaabb1f5948 in qemu_mutex_lock_impl (mutex=0xaaaacc8e1860,
	    file=0xaaaabb4e1bd0 "/Images/eillon/CODE/5-opensource/qemu/util/async.c", line=605)
	#3  0x0000aaaabb20acd4 in aio_context_acquire (ctx=0xaaaacc8e1800)
	#4  0x0000aaaabb105e90 in bdrv_query_image_info (bs=0xaaaacc934620,
	    p_info=0xaaaaccc41e18, errp=0xffffca669118)
	#5  0x0000aaaabb105968 in bdrv_block_device_info (blk=0xaaaacdca19f0, bs=0xaaaacc934620,
	    flat=false, errp=0xffffca6692b8)
	#6  0x0000aaaabb1063dc in bdrv_query_info (blk=0xaaaacdca19f0, p_info=0xaaaacd29c9a8,
	    errp=0xffffca6692b8)
	#7  0x0000aaaabb106c14 in qmp_query_block (errp=0x0)
	#8  0x0000aaaabacb8e6c in hmp_info_block (mon=0xffffca6693d0, qdict=0xaaaacd089790)
	#9  0x0000aaaabb0068f0 in handle_hmp_command (mon=0xffffca6693d0,
	    cmdline=0xaaaacc9013ca "")
	#10 0x0000aaaabaab5034 in qmp_human_monitor_command (
	    command_line=0xaaaacc9013c0 "info block", has_cpu_index=false, cpu_index=0,
	    errp=0xffffca6694d8)
	#11 0x0000aaaabb03c720 in qmp_marshal_human_monitor_command (args=0xffff70008070,
	    ret=0xffffca669570, errp=0xffffca669568) at qapi/qapi-commands-misc.c:653
	#12 0x0000aaaabb18fdbc in qmp_dispatch (cmds=0xaaaabbb197c0 <qmp_commands>,
	    request=0xffff70005cc0, allow_oob=false)
	#13 0x0000aaaabb003074 in monitor_qmp_dispatch (mon=0xaaaacc962320, req=0xffff70005cc0)
	#14 0x0000aaaabb003488 in monitor_qmp_bh_dispatcher (data=0x0)
	#15 0x0000aaaabb209d44 in aio_bh_call (bh=0xaaaacc5f0810)
	#16 0x0000aaaabb209e50 in aio_bh_poll (ctx=0xaaaacc5ef320)
	#17 0x0000aaaabb1f1494 in aio_dispatch (ctx=0xaaaacc5ef320)
	#18 0x0000aaaabb20a330 in aio_ctx_dispatch (source=0xaaaacc5ef320, callback=0x0,
	    user_data=0x0)
	#19 0x0000ffff95f00a7c in g_main_context_dispatch ()
	   from target:/usr/lib64/libglib-2.0.so.0
	#20 0x0000aaaabb2128e8 in glib_pollfds_poll ()
	#21 0x0000aaaabb212970 in os_host_main_loop_wait (timeout=64805420)
	#22 0x0000aaaabb212a90 in main_loop_wait (nonblocking=0)
	#23 0x0000aaaabaad63d0 in qemu_main_loop ()
	#24 0x0000aaaabb188b54 in main (argc=117, argv=0xffffca669a68, envp=0xffffca669e18)

And the QEMU process backtrace in kernel is:
	[<0>] __switch_to+0xdc/0x140
	[<0>] futex_wait_queue_me+0xd4/0x158
	[<0>] futex_wait+0xf4/0x230
	[<0>] do_futex+0x46c/0x608
	[<0>] __arm64_sys_futex+0x13c/0x188
	[<0>] el0_svc_common+0x80/0x1b8
	[<0>] el0_svc_handler+0x38/0x78
	[<0>] el0_svc+0x10/0x14
	[<0>] 0xffffffffffffffff


Thanks,
Zhenyu

