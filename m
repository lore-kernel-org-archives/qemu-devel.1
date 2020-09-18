Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E51DC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 11:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BBB21D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 11:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BBB21D42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJEV3-0006CG-Q9
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 07:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1kJEUA-0005c5-DX; Fri, 18 Sep 2020 07:23:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48230 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1kJEU7-00039k-2c; Fri, 18 Sep 2020 07:23:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 786F48C628A6C4399A56;
 Fri, 18 Sep 2020 19:23:12 +0800 (CST)
Received: from [10.174.187.142] (10.174.187.142) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 19:23:04 +0800
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
To: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20200810145246.1049-1-yezhenyu2@huawei.com>
 <20200810153811.GF14538@linux.fritz.box>
 <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
 <20200914132738.GL579094@stefanha-x1.localdomain>
 <7ad220bd-7ee5-1f66-b2e5-7dc57d72eb2e@huawei.com>
 <20200917154415.GB839531@stefanha-x1.localdomain>
 <20200917160054.GA2453251@dev>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <5a5822ec-f3bc-a247-2b5a-f764b941c820@huawei.com>
Date: Fri, 18 Sep 2020 19:23:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200917160054.GA2453251@dev>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.142]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=yezhenyu2@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 07:23:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.869,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, armbru@redhat.com, pbonzini@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan, Fam,

On 2020/9/18 0:01, Fam Zheng wrote:
> On 2020-09-17 16:44, Stefan Hajnoczi wrote:
>> On Thu, Sep 17, 2020 at 03:36:57PM +0800, Zhenyu Ye wrote:
>>> When the hang occurs, the QEMU is blocked at:
>>>
>>> 	#0  0x0000ffff95762b64 in ?? () from target:/usr/lib64/libpthread.so.0
>>> 	#1  0x0000ffff9575bd88 in pthread_mutex_lock () from target:/usr/lib64/libpthread.so.0
>>> 	#2  0x0000aaaabb1f5948 in qemu_mutex_lock_impl (mutex=0xaaaacc8e1860,
>>> 	    file=0xaaaabb4e1bd0 "/Images/eillon/CODE/5-opensource/qemu/util/async.c", line=605)
>>> 	#3  0x0000aaaabb20acd4 in aio_context_acquire (ctx=0xaaaacc8e1800)
>>> 	#4  0x0000aaaabb105e90 in bdrv_query_image_info (bs=0xaaaacc934620,
>>> 	    p_info=0xaaaaccc41e18, errp=0xffffca669118)
>>> 	#5  0x0000aaaabb105968 in bdrv_block_device_info (blk=0xaaaacdca19f0, bs=0xaaaacc934620,
>>> 	    flat=false, errp=0xffffca6692b8)
>>> 	#6  0x0000aaaabb1063dc in bdrv_query_info (blk=0xaaaacdca19f0, p_info=0xaaaacd29c9a8,
>>> 	    errp=0xffffca6692b8)
>>> 	#7  0x0000aaaabb106c14 in qmp_query_block (errp=0x0)
>>> 	#8  0x0000aaaabacb8e6c in hmp_info_block (mon=0xffffca6693d0, qdict=0xaaaacd089790)
>>
>> Great, this shows that the main loop thread is stuck waiting for the
>> AioContext lock.
>>
>> Please post backtraces from all QEMU threads ((gdb) thread apply all bt)
>> so we can figure out which thread is holding up the main loop.
> 
> I think that is reflected in the perf backtrace posted by Zheny already:
> 
> And in the host, the information of sys_enter_io_submit() is:
> 
> Samples: 3K of event 'syscalls:sys_enter_io_submit', Event count
> (approx.): 3150
>    Children      Self  Trace output
>    -   66.70%    66.70%  ctx_id: 0xffff9c044000,
>    nr: 0x00000001, iocbpp: 0xffff9f7fad28
>    0xffffae7f871c
>    0xffffae8a27c4
>    qemu_thread_start
>    iothread_run
>    aio_poll
>    aio_dispatch_ready_handlers
>    aio_dispatch_handler
>    virtio_queue_host_notifier_aio_read
>    virtio_queue_notify_aio_vq
>    virtio_blk_data_plane_handle_output
>    virtio_blk_handle_vq
>    blk_io_unplug
>    bdrv_io_unplug
>    bdrv_io_unplug
>    raw_aio_unplug
>    laio_io_unplug
>    syscall
> 
> So the iothread is blocked by a slow io_submit holding the AioContext
> lock.
> 
> It would be interesting to know what in kernel is blocking io_submit
> from returning.
> 

Sorry, I only get the backtraces of all QEMU threads, like below:

	(gdb) thread apply all bt

	Thread 35 (LWP 49700):
	#0  0x0000ffff83148fe4 in pthread_cond_timedwait () at /lib64/libpthread.so.0
	#1  0x0000aaaae85f2080 in qemu_sem_timedwait (sem=0xaaaaef12e748, ms=10000)
	    at ../util/qemu-thread-posix.c:282
	#2  0x0000aaaae861c600 in worker_thread (opaque=0xaaaaef12e6c0)
	    at ../util/thread-pool.c:91
	#3  0x0000aaaae85f269c in qemu_thread_start (args=0xaaaaf0204be0)
	    at ../util/qemu-thread-posix.c:521
	#4  0x0000ffff831428bc in  () at /lib64/libpthread.so.0
	#5  0x0000ffff8308aa1c in  () at /lib64/libc.so.6

	Thread 34 (LWP 45337):
	#0  0x0000ffff83148fe4 in pthread_cond_timedwait () at /lib64/libpthread.so.0
	#1  0x0000aaaae85f2080 in qemu_sem_timedwait (sem=0xaaaaef12e748, ms=10000)
	    at ../util/qemu-thread-posix.c:282
	#2  0x0000aaaae861c600 in worker_thread (opaque=0xaaaaef12e6c0)
	    at ../util/thread-pool.c:91
	#3  0x0000aaaae85f269c in qemu_thread_start (args=0xfffcc8000b20)
	    at ../util/qemu-thread-posix.c:521
	#4  0x0000ffff831428bc in  () at /lib64/libpthread.so.0
	#5  0x0000ffff8308aa1c in  () at /lib64/libc.so.6

	Thread 33 (LWP 45336):
	#0  0x0000ffff83148fe4 in pthread_cond_timedwait () at /lib64/libpthread.so.0
	#1  0x0000aaaae85f2080 in qemu_sem_timedwait (sem=0xaaaaef12e748, ms=10000)
	    at ../util/qemu-thread-posix.c:282
	#2  0x0000aaaae861c600 in worker_thread (opaque=0xaaaaef12e6c0)
	    at ../util/thread-pool.c:91
	#3  0x0000aaaae85f269c in qemu_thread_start (args=0xfffd14000b20)
	    at ../util/qemu-thread-posix.c:521
	#4  0x0000ffff831428bc in  () at /lib64/libpthread.so.0
	#5  0x0000ffff8308aa1c in  () at /lib64/libc.so.6

	Thread 32 (LWP 45335):
	#0  0x0000ffff83148fe4 in pthread_cond_timedwait () at /lib64/libpthread.so.0
	#1  0x0000aaaae85f2080 in qemu_sem_timedwait (sem=0xaaaaef12e748, ms=10000)
	    at ../util/qemu-thread-posix.c:282
	#2  0x0000aaaae861c600 in worker_thread (opaque=0xaaaaef12e6c0)
	    at ../util/thread-pool.c:91
	#3  0x0000aaaae85f269c in qemu_thread_start (args=0xaaaaefb00f00)
	    at ../util/qemu-thread-posix.c:521
	#4  0x0000ffff831428bc in  () at /lib64/libpthread.so.0
	#5  0x0000ffff8308aa1c in  () at /lib64/libc.so.6

	Thread 12 (LWP 4849):
	#0  0x0000ffff83082a0c in ioctl () at /lib64/libc.so.6
	#1  0x0000aaaae83738dc in kvm_vcpu_ioctl (cpu=0xaaaaef26c8f0, type=44672)
	    at ../accel/kvm/kvm-all.c:2631
	#2  0x0000aaaae8373144 in kvm_cpu_exec (cpu=0xaaaaef26c8f0) at ../accel/kvm/kvm-all.c:2468
	#3  0x0000aaaae832a994 in qemu_kvm_cpu_thread_fn (arg=0xaaaaef26c8f0)
	    at ../softmmu/cpus.c:1188
	#4  0x0000aaaae85f269c in qemu_thread_start (args=0xaaaaef2c48c0)
	    at ../util/qemu-thread-posix.c:521
	#5  0x0000ffff831428bc in  () at /lib64/libpthread.so.0
	#6  0x0000ffff8308aa1c in  () at /lib64/libc.so.6

	Thread 11 (LWP 4848):
	#0  0x0000ffff83082a0c in ioctl () at /lib64/libc.so.6
	#1  0x0000aaaae83738dc in kvm_vcpu_ioctl (cpu=0xaaaaef213020, type=44672)
	    at ../accel/kvm/kvm-all.c:2631
	#2  0x0000aaaae8373144 in kvm_cpu_exec (cpu=0xaaaaef213020) at ../accel/kvm/kvm-all.c:2468
	#3  0x0000aaaae832a994 in qemu_kvm_cpu_thread_fn (arg=0xaaaaef213020)
	    at ../softmmu/cpus.c:1188
	#4  0x0000aaaae85f269c in qemu_thread_start (args=0xaaaaef26b810)
	    at ../util/qemu-thread-posix.c:521
	#5  0x0000ffff831428bc in  () at /lib64/libpthread.so.0
	#6  0x0000ffff8308aa1c in  () at /lib64/libc.so.6

	Thread 10 (LWP 4846):
	#0  0x0000ffff8314c1cc in  () at /lib64/libpthread.so.0
	#1  0x0000ffff83145050 in pthread_mutex_lock () at /lib64/libpthread.so.0
	#2  0x0000aaaae85f1848 in qemu_mutex_lock_impl
	    (mutex=0xaaaae8f594a0 <qemu_global_mutex>, file=0xaaaae8893270 "../exec.c", line=3140)
	    at ../util/qemu-thread-posix.c:79
	#3  0x0000aaaae832bc30 in qemu_mutex_lock_iothread_impl
	    (file=0xaaaae8893270 "../exec.c", line=3140) at ../softmmu/cpus.c:1782
	#4  0x0000aaaae84186cc in prepare_mmio_access (mr=0xaaaaf07f2540) at ../exec.c:3140
	#5  0x0000aaaae8418788 in flatview_write_continue
	    (fv=0xfffd3c438780, addr=549772603392, attrs=..., ptr=0xffff83f3a028, len=2, addr1=0, l=2, mr=0xaaaaf07f2540) at ../exec.c:3172
	#6  0x0000aaaae8418980 in flatview_write
	    (fv=0xfffd3c438780, addr=549772603392, attrs=..., buf=0xffff83f3a028, len=2)
	    at ../exec.c:3217
	#7  0x0000aaaae8418d68 in address_space_write
	    (as=0xaaaae8f75fd0 <address_space_memory>, addr=549772603392, attrs=..., buf=0xffff83f3a028, len=2) at ../exec.c:3308
	#8  0x0000aaaae8418de4 in address_space_rw
	    (as=0xaaaae8f75fd0 <address_space_memory>, addr=549772603392, attrs=..., buf=0xffff83f3a028, len=2, is_write=true) at ../exec.c:3318
	#9  0x0000aaaae8373388 in kvm_cpu_exec (cpu=0xaaaaef1b9b80) at ../accel/kvm/kvm-all.c:2518
	#10 0x0000aaaae832a994 in qemu_kvm_cpu_thread_fn (arg=0xaaaaef1b9b80)
	    at ../softmmu/cpus.c:1188
	#11 0x0000aaaae85f269c in qemu_thread_start (args=0xaaaaef211f40)
	    at ../util/qemu-thread-posix.c:521
	#12 0x0000ffff831428bc in  () at /lib64/libpthread.so.0
	#13 0x0000ffff8308aa1c in  () at /lib64/libc.so.6

	Thread 9 (LWP 4845):
	#0  0x0000ffff83082a0c in ioctl () at /lib64/libc.so.6
	#1  0x0000aaaae83738dc in kvm_vcpu_ioctl (cpu=0xaaaaef15a0f0, type=44672)
	    at ../accel/kvm/kvm-all.c:2631
	#2  0x0000aaaae8373144 in kvm_cpu_exec (cpu=0xaaaaef15a0f0) at ../accel/kvm/kvm-all.c:2468
	#3  0x0000aaaae832a994 in qemu_kvm_cpu_thread_fn (arg=0xaaaaef15a0f0)
	    at ../softmmu/cpus.c:1188
	#4  0x0000aaaae85f269c in qemu_thread_start (args=0xaaaaef1b1e40)
	    at ../util/qemu-thread-posix.c:521
	#5  0x0000ffff831428bc in  () at /lib64/libpthread.so.0
	#6  0x0000ffff8308aa1c in  () at /lib64/libc.so.6

	Thread 8 (LWP 4826):
	#0  0x0000ffff83080b04 in poll () at /lib64/libc.so.6
	#1  0x0000ffff83807648 in  () at /lib64/libglib-2.0.so.0
	#2  0x0000ffff83807a88 in g_main_loop_run () at /lib64/libglib-2.0.so.0
	#3  0x0000aaaae8027038 in iothread_run (opaque=0xaaaaef1141b0) at ../iothread.c:80
	#4  0x0000aaaae85f269c in qemu_thread_start (args=0xaaaaef10dc00)
	    at ../util/qemu-thread-posix.c:521
	#5  0x0000ffff831428bc in  () at /lib64/libpthread.so.0
	#6  0x0000ffff8308aa1c in  () at /lib64/libc.so.6

	Thread 7 (LWP 4805):
	#0  0x0000ffff83080c18 in ppoll () at /lib64/libc.so.6
	#1  0x0000aaaae860dc4c in qemu_poll_ns (fds=0xffff68001fb0, nfds=6, timeout=-1)
	    at ../util/qemu-timer.c:335
	#2  0x0000aaaae86228fc in fdmon_poll_wait
	    (ctx=0xaaaaef0aaf50, ready_list=0xffff72ffbf70, timeout=-1) at ../util/fdmon-poll.c:79
	#3  0x0000aaaae85fb270 in aio_poll (ctx=0xaaaaef0aaf50, blocking=true)
	    at ../util/aio-posix.c:601
	#4  0x0000aaaae8027004 in iothread_run (opaque=0xaaaaeee62c00) at ../iothread.c:73
	#5  0x0000aaaae85f269c in qemu_thread_start (args=0xaaaaef0ab4b0)
	    at ../util/qemu-thread-posix.c:521
	#6  0x0000ffff831428bc in  () at /lib64/libpthread.so.0
	#7  0x0000ffff8308aa1c in  () at /lib64/libc.so.6

	Thread 6 (LWP 4804):
	#0  0x0000ffff83080c18 in ppoll () at /lib64/libc.so.6
	#1  0x0000aaaae860dc4c in qemu_poll_ns (fds=0xffff64001fb0, nfds=6, timeout=-1)
	    at ../util/qemu-timer.c:335
	#2  0x0000aaaae86228fc in fdmon_poll_wait
	    (ctx=0xaaaaef0a9930, ready_list=0xffff737fcf70, timeout=-1) at ../util/fdmon-poll.c:79
	#3  0x0000aaaae85fb270 in aio_poll (ctx=0xaaaaef0a9930, blocking=true)
	    at ../util/aio-posix.c:601
	#4  0x0000aaaae8027004 in iothread_run (opaque=0xaaaaeee6f400) at ../iothread.c:73
	#5  0x0000aaaae85f269c in qemu_thread_start (args=0xaaaaef0aab20)
	    at ../util/qemu-thread-posix.c:521
	#6  0x0000ffff831428bc in  () at /lib64/libpthread.so.0
	#7  0x0000ffff8308aa1c in  () at /lib64/libc.so.6

	Thread 5 (LWP 4802):
	#0  0x0000ffff83086b54 in syscall () at /lib64/libc.so.6
	#1  0x0000ffff834598b8 in io_submit () at /lib64/libaio.so.1
	#2  0x0000aaaae851e89c in ioq_submit (s=0xfffd3c001bb0) at ../block/linux-aio.c:299
	#3  0x0000aaaae851eb50 in laio_io_unplug (bs=0xaaaaef0f2340, s=0xfffd3c001bb0)
	    at ../block/linux-aio.c:344
	#4  0x0000aaaae8559f1c in raw_aio_unplug (bs=0xaaaaef0f2340) at ../block/file-posix.c:2063
	#5  0x0000aaaae8538344 in bdrv_io_unplug (bs=0xaaaaef0f2340) at ../block/io.c:3135
	#6  0x0000aaaae8538360 in bdrv_io_unplug (bs=0xaaaaef0eb020) at ../block/io.c:3140
	#7  0x0000aaaae8496104 in blk_io_unplug (blk=0xaaaaef0e8f20)
	    at ../block/block-backend.c:2147
	#8  0x0000aaaae830e1a4 in virtio_blk_handle_vq (s=0xaaaaf0374280, vq=0xffff700fc1d8)
	    at ../hw/block/virtio-blk.c:796
	#9  0x0000aaaae82e6b68 in virtio_blk_data_plane_handle_output
	    (vdev=0xaaaaf0374280, vq=0xffff700fc1d8) at ../hw/block/dataplane/virtio-blk.c:165
	#10 0x0000aaaae83878fc in virtio_queue_notify_aio_vq (vq=0xffff700fc1d8)
	    at ../hw/virtio/virtio.c:2325
	#11 0x0000aaaae838ab50 in virtio_queue_host_notifier_aio_poll (opaque=0xffff700fc250)
	    at ../hw/virtio/virtio.c:3545
	#12 0x0000aaaae85fab3c in run_poll_handlers_once
	    (ctx=0xaaaaef0a87b0, now=77604310618960, timeout=0xffff73ffdf78)
	    at ../util/aio-posix.c:398
	#13 0x0000aaaae85fae5c in run_poll_handlers
	    (ctx=0xaaaaef0a87b0, max_ns=4000, timeout=0xffff73ffdf78) at ../util/aio-posix.c:492
	#14 0x0000aaaae85fb078 in try_poll_mode (ctx=0xaaaaef0a87b0, timeout=0xffff73ffdf78)
	    at ../util/aio-posix.c:535
	#15 0x0000aaaae85fb180 in aio_poll (ctx=0xaaaaef0a87b0, blocking=true)
	    at ../util/aio-posix.c:571
	#16 0x0000aaaae8027004 in iothread_run (opaque=0xaaaaeee79a00) at ../iothread.c:73
	#17 0x0000aaaae85f269c in qemu_thread_start (args=0xaaaaef0a8d10)
	    at ../util/qemu-thread-posix.c:521
	#18 0x0000ffff831428bc in  () at /lib64/libpthread.so.0
	#19 0x0000ffff8308aa1c in  () at /lib64/libc.so.6

	Thread 4 (LWP 4801):
	#0  0x0000ffff83086b54 in syscall () at /lib64/libc.so.6
	#1  0x0000ffff834598b8 in io_submit () at /lib64/libaio.so.1
	#2  0x0000aaaae851e89c in ioq_submit (s=0xfffd3c4328e0) at ../block/linux-aio.c:299
	#3  0x0000aaaae851eb50 in laio_io_unplug (bs=0xaaaaef0e3860, s=0xfffd3c4328e0)
	    at ../block/linux-aio.c:344
	#4  0x0000aaaae8559f1c in raw_aio_unplug (bs=0xaaaaef0e3860) at ../block/file-posix.c:2063
	#5  0x0000aaaae8538344 in bdrv_io_unplug (bs=0xaaaaef0e3860) at ../block/io.c:3135
	#6  0x0000aaaae8538360 in bdrv_io_unplug (bs=0xaaaaef0dc540) at ../block/io.c:3140
	#7  0x0000aaaae8496104 in blk_io_unplug (blk=0xaaaaef0aea90)
	    at ../block/block-backend.c:2147
	#8  0x0000aaaae830e1a4 in virtio_blk_handle_vq (s=0xaaaaf0252b90, vq=0xffff70224010)
	    at ../hw/block/virtio-blk.c:796
	#9  0x0000aaaae82e6b68 in virtio_blk_data_plane_handle_output
	    (vdev=0xaaaaf0252b90, vq=0xffff70224010) at ../hw/block/dataplane/virtio-blk.c:165
	#10 0x0000aaaae83878fc in virtio_queue_notify_aio_vq (vq=0xffff70224010)
	    at ../hw/virtio/virtio.c:2325
	#11 0x0000aaaae838ab50 in virtio_queue_host_notifier_aio_poll (opaque=0xffff70224088)
	    at ../hw/virtio/virtio.c:3545
	#12 0x0000aaaae85fa360 in poll_set_started (ctx=0xaaaaef0a7e70, started=false)
	    at ../util/aio-posix.c:231
	#13 0x0000aaaae85fb098 in try_poll_mode (ctx=0xaaaaef0a7e70, timeout=0xffff8096bf78)
	    at ../util/aio-posix.c:540
	#14 0x0000aaaae85fb180 in aio_poll (ctx=0xaaaaef0a7e70, blocking=true)
	    at ../util/aio-posix.c:571
	#15 0x0000aaaae8027004 in iothread_run (opaque=0xaaaaeee8de20) at ../iothread.c:73
	#16 0x0000aaaae85f269c in qemu_thread_start (args=0xaaaaef0a83d0)
	    at ../util/qemu-thread-posix.c:521
	#17 0x0000ffff831428bc in  () at /lib64/libpthread.so.0
	#18 0x0000ffff8308aa1c in  () at /lib64/libc.so.6

	Thread 3 (LWP 4800):
	#0  0x0000ffff82fe8fd4 in sigtimedwait () at /lib64/libc.so.6
	#1  0x0000ffff8314d78c in sigwait () at /lib64/libpthread.so.0
	#2  0x0000aaaae860e974 in sigwait_compat (opaque=0xaaaaeee06e70) at ../util/compatfd.c:37
	#3  0x0000aaaae85f269c in qemu_thread_start (args=0xaaaaef092860)
	    at ../util/qemu-thread-posix.c:521
	#4  0x0000ffff831428bc in  () at /lib64/libpthread.so.0
	#5  0x0000ffff8308aa1c in  () at /lib64/libc.so.6

	Thread 2 (LWP 4779):
	#0  0x0000ffff83086b50 in syscall () at /lib64/libc.so.6
	#1  0x0000aaaae85f2278 in qemu_futex_wait
	    (f=0xaaaae8f78a58 <rcu_call_ready_event>, val=4294967295)
	    at /Images/eillon/CODE/5-opensource/qemu/include/qemu/futex.h:29
	#2  0x0000aaaae85f24f4 in qemu_event_wait (ev=0xaaaae8f78a58 <rcu_call_ready_event>)
	    at ../util/qemu-thread-posix.c:460
	#3  0x0000aaaae85d2938 in call_rcu_thread (opaque=0x0) at ../util/rcu.c:258
	#4  0x0000aaaae85f269c in qemu_thread_start (args=0xaaaaeed38e20)
	    at ../util/qemu-thread-posix.c:521
	#5  0x0000ffff831428bc in  () at /lib64/libpthread.so.0
	#6  0x0000ffff8308aa1c in  () at /lib64/libc.so.6

	Thread 1 (LWP 4720):
	#0  0x0000ffff8314c1cc in  () at /lib64/libpthread.so.0
	#1  0x0000ffff83145060 in pthread_mutex_lock () at /lib64/libpthread.so.0
	#2  0x0000aaaae85f1848 in qemu_mutex_lock_impl
	    (mutex=0xaaaaef0a8810, file=0xaaaae89026d0 "../util/async.c", line=615)
	    at ../util/qemu-thread-posix.c:79
	#3  0x0000aaaae86089d4 in aio_context_acquire (ctx=0xaaaaef0a87b0) at ../util/async.c:615
	#4  0x0000aaaae84df9b8 in bdrv_query_image_info
	    (bs=0xaaaaef0eb020, p_info=0xaaaaef13c188, errp=0xffffeb48ee60) at ../block/qapi.c:278
	#5  0x0000aaaae84df4e8 in bdrv_block_device_info
	    (blk=0xaaaaef0e8f20, bs=0xaaaaef0eb020, flat=false, errp=0xffffeb48f008)
	    at ../block/qapi.c:155
	#6  0x0000aaaae84dfed0 in bdrv_query_info
	    (blk=0xaaaaef0e8f20, p_info=0xaaaaef5109f8, errp=0xffffeb48f008)
	    at ../block/qapi.c:402
	#7  0x0000aaaae84e073c in qmp_query_block (errp=0x0) at ../block/qapi.c:621
	#8  0x0000aaaae7e4e254 in hmp_info_block (mon=0xffffeb48f120, qdict=0xaaaaf08757b0)
	    at ../block/monitor/block-hmp-cmds.c:755
	#9  0x0000aaaae7d38d58 in handle_hmp_command
	    (mon=0xffffeb48f120, cmdline=0xaaaaef63093a "") at ../monitor/hmp.c:1082
	#10 0x0000aaaae8305ac0 in qmp_human_monitor_command
	    (command_line=0xaaaaef630930 "info block", has_cpu_index=false, cpu_index=0, errp=0xffffeb48f228) at ../monitor/misc.c:141
	#11 0x0000aaaae85ad944 in qmp_marshal_human_monitor_command
	    (args=0xffff5c0088b0, ret=0xffffeb48f2c0, errp=0xffffeb48f2b8)
	    at qapi/qapi-commands-misc.c:653
	#12 0x0000aaaae861be8c in qmp_dispatch
	    (cmds=0xaaaae8f76718 <qmp_commands>, request=0xffff5c007890, allow_oob=false)
	    at ../qapi/qmp-dispatch.c:155
	#13 0x0000aaaae844d204 in monitor_qmp_dispatch (mon=0xaaaaef10d460, req=0xffff5c007890)
	    at ../monitor/qmp.c:145
	#14 0x0000aaaae844d620 in monitor_qmp_bh_dispatcher (data=0x0) at ../monitor/qmp.c:234
	#15 0x0000aaaae8607a44 in aio_bh_call (bh=0xaaaaeed99790) at ../util/async.c:136
	#16 0x0000aaaae8607b50 in aio_bh_poll (ctx=0xaaaaeedd6e50) at ../util/async.c:164
	#17 0x0000aaaae85faacc in aio_dispatch (ctx=0xaaaaeedd6e50) at ../util/aio-posix.c:380
	#18 0x0000aaaae8608030 in aio_ctx_dispatch
	    (source=0xaaaaeedd6e50, callback=0x0, user_data=0x0) at ../util/async.c:306
	#19 0x0000ffff838072f8 in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
	#20 0x0000aaaae85d8ed8 in glib_pollfds_poll () at ../util/main-loop.c:221
	#21 0x0000aaaae85d8f60 in os_host_main_loop_wait (timeout=64819060)
	    at ../util/main-loop.c:244
	#22 0x0000aaaae85d9080 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:520
	#23 0x0000aaaae82ec2b4 in qemu_main_loop () at ../softmmu/vl.c:1676
	#24 0x0000aaaae7c9b9c4 in main (argc=103, argv=0xffffeb48f7b8, envp=0xffffeb48faf8)
	    at ../softmmu/main.c:50

Thanks,
Zhenyu

