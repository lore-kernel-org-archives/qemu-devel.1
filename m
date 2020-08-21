Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99CFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6735520656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEJ+zySx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6735520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99ug-0006wN-Lx
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k99ti-0005cx-AO
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k99td-0006SV-JB
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598027284;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q6xlthVYsMFmo9hKxK2zNCpsFpi61iQz0nOx21CoBtk=;
 b=IEJ+zySxdICWCGLW/FVoo0a+OTJb1D3ps+Evl4FyUXV5l2xoxUD5e0rVQPd8nn+onBmYs/
 jCYte16NbXOwNn6c8OQsguXqoNPxfdc78iQeUyt9Nff8Pxxib87SpCfOLd/1vPracJHJpB
 e6OYi/mJg9nNdPqnf9lxr5tFxKOxx6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-erLbtAJ3OzaZtGA1lpxpOA-1; Fri, 21 Aug 2020 12:27:52 -0400
X-MC-Unique: erLbtAJ3OzaZtGA1lpxpOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83EEB1074663;
 Fri, 21 Aug 2020 16:27:50 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B114D19D7D;
 Fri, 21 Aug 2020 16:27:45 +0000 (UTC)
Date: Fri, 21 Aug 2020 17:27:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 (BROKEN) 0/6] migration: bring improved
 savevm/loadvm/delvm to QMP
Message-ID: <20200821162742.GP348677@redhat.com>
References: <20200727150843.3419256-1-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727150843.3419256-1-berrange@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 04:08:37PM +0100, Daniel P. Berrangé wrote:
> A followup to:
> 
>  v1: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00866.html

snip

> HELP NEEDED:  this series starts to implement the approach that Kevin
> suggested wrto use of generic jobs.
> 
> When I try to actually run the code though it crashes:
> 
> ERROR:/home/berrange/src/virt/qemu/softmmu/cpus.c:1788:qemu_mutex_unlock_ioth=
> read: assertion failed: (qemu_mutex_iothread_locked())
> Bail out! ERROR:/home/berrange/src/virt/qemu/softmmu/cpus.c:1788:qemu_mutex_u=
> nlock_iothread: assertion failed: (qemu_mutex_iothread_locked())
> 
> Obviously I've missed something related to locking, but I've no idea
> what, so I'm sending this v2 simply as a way to solicit suggestions
> for what I've messed up.

What I've found is

qmp_snapshot_save() is the QMP handler and runs in the main thread, so iothread
lock is held.


This calls job_create() which ends up invoking  snapshot_save_job_run
in a background coroutine, but IIUC  iothread lock is still held when
the coroutine starts.

This then invokes save_snapshot() which invokes qemu_savevm_state


This calls   qemu_mutex_unlock_iothread() and then 
qemu_savevm_state_setup().

Eventually something in the qcow2 code triggers qemu_coroutine_yield()
so control goes back to the main event loop thread.


The problem is that the iothread lock has been released, but the main
event loop thread is still expecting it to be held.

I've no idea how to go about solving this problem.


The save_snapshot() code, as written today, needs to run serialized with
everything else, but because the job framework has used a coroutine to
run it, we can switch back to the main event thread at any time.

I don't know how to force save_snapshot() to be serialized when using
the generic job framework.


> 
> You can reproduce with I/O tests using "check -qcow2 310"  and it
> gave a stack:
> 
>   Thread 5 (Thread 0x7fffe6e4c700 (LWP 3399011)):
>   #0  futex_wait_cancelable (private=0, expected=0, futex_word=0x5555566a9fd8) at ../sysdeps/nptl/futex-internal.h:183
>   #1  __pthread_cond_wait_common (abstime=0x0, clockid=0, mutex=0x555556227160 <qemu_global_mutex>, cond=0x5555566a9fb0) at pthread_cond_wait.c:508
>   #2  __pthread_cond_wait (cond=cond@entry=0x5555566a9fb0, mutex=mutex@entry=0x555556227160 <qemu_global_mutex>) at pthread_cond_wait.c:638
>   #3  0x0000555555ceb6cb in qemu_cond_wait_impl (cond=0x5555566a9fb0, mutex=0x555556227160 <qemu_global_mutex>, file=0x555555d44198 "/home/berrange/src/virt/qemu/softmmu/cpus.c", line=1145) at /home/berrange/src/virt/qemu/util/qemu-thread-posix.c:174
>   #4  0x0000555555931974 in qemu_wait_io_event (cpu=cpu@entry=0x555556685050) at /home/berrange/src/virt/qemu/softmmu/cpus.c:1145
>   #5  0x0000555555933a89 in qemu_dummy_cpu_thread_fn (arg=arg@entry=0x555556685050) at /home/berrange/src/virt/qemu/softmmu/cpus.c:1241
>   #6  0x0000555555ceb049 in qemu_thread_start (args=0x7fffe6e476f0) at /home/berrange/src/virt/qemu/util/qemu-thread-posix.c:521
>   #7  0x00007ffff4fdc432 in start_thread (arg=<optimized out>) at pthread_create.c:477
>   #8  0x00007ffff4f0a9d3 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>   
>   Thread 4 (Thread 0x7fffe764d700 (LWP 3399010)):
>   #0  0x00007ffff4effb6f in __GI___poll (fds=0x7fffdc006ec0, nfds=3, timeout=-1) at ../sysdeps/unix/sysv/linux/poll.c:29
>   #1  0x00007ffff7c1aace in g_main_context_iterate.constprop () at /lib64/libglib-2.0.so.0
>   #2  0x00007ffff7c1ae53 in g_main_loop_run () at /lib64/libglib-2.0.so.0
>   #3  0x00005555559a9d81 in iothread_run (opaque=opaque@entry=0x55555632f200) at /home/berrange/src/virt/qemu/iothread.c:82
>   #4  0x0000555555ceb049 in qemu_thread_start (args=0x7fffe76486f0) at /home/berrange/src/virt/qemu/util/qemu-thread-posix.c:521
>   #5  0x00007ffff4fdc432 in start_thread (arg=<optimized out>) at pthread_create.c:477
>   #6  0x00007ffff4f0a9d3 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>   
>   Thread 3 (Thread 0x7fffe7e4e700 (LWP 3399009)):
>   #0  0x00007ffff4fe5c58 in futex_abstimed_wait_cancelable (private=0, abstime=0x7fffe7e49650, clockid=0, expected=0, futex_word=0x5555562bf888) at ../sysdeps/nptl/futex-internal.h:320
>   #1  do_futex_wait (sem=sem@entry=0x5555562bf888, abstime=abstime@entry=0x7fffe7e49650, clockid=0) at sem_waitcommon.c:112
>   #2  0x00007ffff4fe5d83 in __new_sem_wait_slow (sem=sem@entry=0x5555562bf888, abstime=abstime@entry=0x7fffe7e49650, clockid=0) at sem_waitcommon.c:184
>   #3  0x00007ffff4fe5e12 in sem_timedwait (sem=sem@entry=0x5555562bf888, abstime=abstime@entry=0x7fffe7e49650) at sem_timedwait.c:40
>   #4  0x0000555555cebbdf in qemu_sem_timedwait (sem=sem@entry=0x5555562bf888, ms=ms@entry=10000) at /home/berrange/src/virt/qemu/util/qemu-thread-posix.c:307
>   #5  0x0000555555d03fa4 in worker_thread (opaque=opaque@entry=0x5555562bf810) at /home/berrange/src/virt/qemu/util/thread-pool.c:91
>   #6  0x0000555555ceb049 in qemu_thread_start (args=0x7fffe7e496f0) at /home/berrange/src/virt/qemu/util/qemu-thread-posix.c:521
>   #7  0x00007ffff4fdc432 in start_thread (arg=<optimized out>) at pthread_create.c:477
>   #8  0x00007ffff4f0a9d3 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>   
>   Thread 2 (Thread 0x7fffe8750700 (LWP 3399008)):
>   #0  0x00007ffff4ed1871 in __GI___clock_nanosleep (clock_id=clock_id@entry=0, flags=flags@entry=0, req=0x7fffe874b670, rem=0x7fffe874b680) at ../sysdeps/unix/sysv/linux/--Type <RET> for more, q to quit, c to continue without paging--
>   clock_nanosleep.c:48
>   #1  0x00007ffff4ed71c7 in __GI___nanosleep (requested_time=<optimized out>, remaining=<optimized out>) at nanosleep.c:27
>   #2  0x00007ffff7c462f7 in g_usleep () at /lib64/libglib-2.0.so.0
>   #3  0x0000555555cf3fd0 in call_rcu_thread (opaque=opaque@entry=0x0) at /home/berrange/src/virt/qemu/util/rcu.c:250
>   #4  0x0000555555ceb049 in qemu_thread_start (args=0x7fffe874b6f0) at /home/berrange/src/virt/qemu/util/qemu-thread-posix.c:521
>   #5  0x00007ffff4fdc432 in start_thread (arg=<optimized out>) at pthread_create.c:477
>   #6  0x00007ffff4f0a9d3 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>   
>   Thread 1 (Thread 0x7fffe88abec0 (LWP 3398996)):
>   #0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
>   #1  0x00007ffff4e2e895 in __GI_abort () at abort.c:79
>   #2  0x00007ffff7be5b8c in g_assertion_message_expr.cold () at /lib64/libglib-2.0.so.0
>   #3  0x00007ffff7c43a1f in g_assertion_message_expr () at /lib64/libglib-2.0.so.0
>   #4  0x0000555555932da0 in qemu_mutex_unlock_iothread () at /home/berrange/src/virt/qemu/softmmu/cpus.c:1788
>   #5  qemu_mutex_unlock_iothread () at /home/berrange/src/virt/qemu/softmmu/cpus.c:1786
>   #6  0x0000555555cfeceb in os_host_main_loop_wait (timeout=26359275747000) at /home/berrange/src/virt/qemu/util/main-loop.c:232
>   #7  main_loop_wait (nonblocking=nonblocking@entry=0) at /home/berrange/src/virt/qemu/util/main-loop.c:516
>   #8  0x0000555555941f27 in qemu_main_loop () at /home/berrange/src/virt/qemu/softmmu/vl.c:1676
>   #9  0x000055555581a18e in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at /home/berrange/src/virt/qemu/softmmu/main.c:49
>   (gdb)

The coroutine trace to go with this is

(gdb) qemu coroutine 0x5555575b86b0
#0  qemu_coroutine_switch (from_=<optimized out>, to_=<optimized out>, action=action@entry=COROUTINE_YIELD)
    at /home/berrange/src/virt/qemu/util/coroutine-ucontext.c:303
#1  0x0000555555cfbccd in qemu_coroutine_yield () at /home/berrange/src/virt/qemu/util/qemu-coroutine.c:193
#2  0x0000555555d00d49 in thread_pool_submit_co (pool=0x5555562b8810, func=func@entry=0x555555c3a2d0 <handle_aiocb_rw>, arg=arg@entry=0x7fffe61ff200)
    at /home/berrange/src/virt/qemu/util/thread-pool.c:288
#3  0x0000555555c3c4db in raw_thread_pool_submit (arg=0x7fffe61ff200, func=0x555555c3a2d0 <handle_aiocb_rw>, bs=0x55555653c2d0)
    at /home/berrange/src/virt/qemu/block/file-posix.c:1975
#4  raw_co_prw (bs=0x55555653c2d0, offset=131072, bytes=65536, qiov=0x7fffe61ff560, type=1) at /home/berrange/src/virt/qemu/block/file-posix.c:2022
#5  0x0000555555c43131 in bdrv_driver_preadv (bs=0x55555653c2d0, offset=131072, bytes=65536, qiov=0x7fffe61ff560, qiov_offset=<optimized out>, flags=0)
    at /home/berrange/src/virt/qemu/block/io.c:1139
#6  0x0000555555c47484 in bdrv_aligned_preadv
    (req=req@entry=0x7fffe61ff440, offset=131072, bytes=65536, align=<optimized out>, qiov=0x7fffe61ff560, qiov_offset=0, flags=0, child=0x5555562b2a80, child=<optimized out>) at /home/berrange/src/virt/qemu/block/io.c:1515
#7  0x0000555555c48955 in bdrv_co_preadv_part
    (child=0x5555562b2a80, offset=<optimized out>, bytes=<optimized out>, qiov=<optimized out>, qiov_offset=<optimized out>, flags=0)
    at /home/berrange/src/virt/qemu/block/io.c:1757
#8  0x0000555555c48ef4 in bdrv_run_co (opaque=0x7fffe61ff540, entry=0x555555c48a60 <bdrv_rw_co_entry>, bs=0x55555653c2d0)
    at /home/berrange/src/virt/qemu/block/io.c:915
#9  bdrv_prwv_co (flags=0, is_write=false, qiov=0x7fffe61ff560, offset=131072, child=<optimized out>) at /home/berrange/src/virt/qemu/block/io.c:966
#10 bdrv_preadv (qiov=0x7fffe61ff560, offset=131072, child=<optimized out>) at /home/berrange/src/virt/qemu/block/io.c:1024
#11 bdrv_pread (child=<optimized out>, offset=offset@entry=131072, buf=<optimized out>, bytes=<optimized out>) at /home/berrange/src/virt/qemu/block/io.c:1041
#12 0x0000555555c1fa2a in qcow2_cache_do_get (bs=0x555556542e00, c=0x55555654b130, offset=131072, table=0x7fffe61ff630, read_from_disk=<optimized out>)
    at /home/berrange/src/virt/qemu/block/qcow2-cache.c:49
#13 0x0000555555c14206 in qcow2_get_refcount (bs=bs@entry=0x555556542e00, cluster_index=0, refcount=refcount@entry=0x7fffe61ff670)
    at /home/berrange/src/virt/qemu/block/qcow2-refcount.c:271
#14 0x0000555555c1450d in alloc_clusters_noref (bs=bs@entry=0x555556542e00, size=140737054242416, size@entry=24, max=max@entry=72057594037927935)
    at /home/berrange/src/virt/qemu/block/qcow2-refcount.c:981
#15 0x0000555555c15534 in qcow2_alloc_clusters (bs=bs@entry=0x555556542e00, size=size@entry=24) at /home/berrange/src/virt/qemu/block/qcow2-refcount.c:1013
#16 0x0000555555c1a1f3 in qcow2_grow_l1_table (bs=0x555556542e00, min_size=min_size@entry=3, exact_size=exact_size@entry=false)
    at /home/berrange/src/virt/qemu/block/qcow2-cluster.c:139
#17 0x0000555555c1a983 in get_cluster_table
    (bs=bs@entry=0x555556542e00, offset=offset@entry=1073741824, new_l2_slice=new_l2_slice@entry=0x7fffe61ff8b0, new_l2_index=new_l2_index@entry=0x7fffe61ff8a8)
    at /home/berrange/src/virt/qemu/block/qcow2-cluster.c:688
#18 0x0000555555c1bee9 in handle_copied
    (m=0x7fffe61ff968, bytes=<synthetic pointer>, host_offset=<synthetic pointer>, guest_offset=1073741824, bs=0x555556542e00)
    at /home/berrange/src/virt/qemu/block/qcow2-cluster.c:1185
#19 qcow2_alloc_cluster_offset
    (bs=bs@entry=0x555556542e00, offset=offset@entry=1073741824, bytes=bytes@entry=0x7fffe61ff95c, host_offset=host_offset@entry=0x7fffe61ff960, m=m@entry=0x7fffe61ff968) at /home/berrange/src/virt/qemu/block/qcow2-cluster.c:1570
--Type <RET> for more, q to quit, c to continue without paging--
#20 0x0000555555c0adbc in qcow2_co_pwritev_part (bs=0x555556542e00, offset=1073741824, bytes=281, qiov=0x7fffe61ffa30, qiov_offset=0, flags=<optimized out>)
    at /home/berrange/src/virt/qemu/block/qcow2.c:2577
#21 0x0000555555c439f1 in bdrv_co_rw_vmstate (bs=0x555556542e00, qiov=<optimized out>, pos=<optimized out>, is_read=<optimized out>)
    at /home/berrange/src/virt/qemu/block/io.c:2660
#22 0x0000555555c45ecc in bdrv_co_rw_vmstate_entry (opaque=0x7fffe61ff9f0) at /home/berrange/src/virt/qemu/block/io.c:2674
#23 bdrv_run_co (opaque=0x7fffe61ff9f0, entry=0x555555c43a50 <bdrv_co_rw_vmstate_entry>, bs=0x555556542e00) at /home/berrange/src/virt/qemu/block/io.c:915
#24 bdrv_rw_vmstate (is_read=false, pos=0, qiov=0x7fffe61ff9e0, bs=0x555556542e00) at /home/berrange/src/virt/qemu/block/io.c:2688
#25 bdrv_writev_vmstate (bs=bs@entry=0x555556542e00, qiov=qiov@entry=0x7fffe61ffa30, pos=pos@entry=0) at /home/berrange/src/virt/qemu/block/io.c:2707
#26 0x0000555555b43ac8 in block_writev_buffer (opaque=0x555556542e00, iov=<optimized out>, iovcnt=<optimized out>, pos=0, errp=<optimized out>)
    at /home/berrange/src/virt/qemu/migration/savevm.c:139
#27 0x0000555555b4e698 in qemu_fflush (f=f@entry=0x5555566ae980) at /home/berrange/src/virt/qemu/migration/qemu-file.c:232
#28 0x000055555586bdeb in ram_save_setup (f=0x5555566ae980, opaque=<optimized out>) at /home/berrange/src/virt/qemu/migration/ram.c:2513
#29 0x0000555555b45bd1 in qemu_savevm_state_setup (f=f@entry=0x5555566ae980) at /home/berrange/src/virt/qemu/migration/savevm.c:1178
#30 0x0000555555b48713 in qemu_savevm_state (errp=0x5555575ba280, f=0x5555566ae980) at /home/berrange/src/virt/qemu/migration/savevm.c:1535
#31 save_snapshot (name=<optimized out>, vmstate=<optimized out>, devices=0x555556e50ba0, errp=errp@entry=0x5555575ba280)
    at /home/berrange/src/virt/qemu/migration/savevm.c:2744
#32 0x0000555555b48a8b in snapshot_save_job_run (job=0x5555575ba200, errp=0x5555575ba280) at /home/berrange/src/virt/qemu/migration/savevm.c:3016
#33 0x0000555555bef632 in job_co_entry (opaque=0x5555575ba200) at /home/berrange/src/virt/qemu/job.c:908
#34 0x0000555555cf74a3 in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at /home/berrange/src/virt/qemu/util/coroutine-ucontext.c:173
#35 0x00007ffff4e5a250 in __start_context () at ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:91
#36 0x00007fffffffc6a0 in  ()
#37 0x0000000000000000 in  ()


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


