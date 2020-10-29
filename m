Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E23AC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF20C20720
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDTDiIzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF20C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYD72-0004J8-Ib
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 14:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYD5g-0002yE-G2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:56:04 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:38378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYD5d-0000Az-16
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:56:03 -0400
Received: by mail-ed1-x534.google.com with SMTP id k9so4150536edo.5
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PaWIDXeUHEHFtfEpCfh5hPsZcdRBIOyrUpb0iVty/Ic=;
 b=HDTDiIzc3BZ6pfL+ouCffLjP+UHtAFNQ2jxqFLczW6g0NGWecwxvTCww8iLt9Aq5H4
 Yi9oK1dXpHr0/eJp+VbiQ1eFEDpgWwNfJgoUVBbzan+S1LSbDGcCmjxuOMx9VF/GbfN/
 zwQ3eK7L0MnSC7zVg/5kKq+2KIi2TDuU6dGCHtpQXkJi7KeWv9AuKO5suYnqYUvOLxta
 snkTI8HSlE0dI8k7rLYm2xMpKpXwWcOQB09X7S6taC+MM9lQL9f+6upuQHWHaqyIlwaL
 J+Y9WvbhyT5eOYWXVIAC0oyjdaiwNapONEsjYJrcUHMcx30F+WEnW2nF1lDm+RCtoQZw
 RGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PaWIDXeUHEHFtfEpCfh5hPsZcdRBIOyrUpb0iVty/Ic=;
 b=AeQ2tvZVs7rTzuyburZ3iaWfuX5hoPqVr1C0XJNxANZazirz35DbZERJ4mB+EZTdx+
 /F78DDXVOq1qduIAeDrKZLziVzmZBqoa/DNi3RcOx1Bvpgy1IEn9xXvmaODmVuscsMvz
 R39j2z5PbzQCe74OwGSoUrQP1BghxeP70prUx+Uh98dvpgPwBqBKF9Rj3EqPrkm2gNmm
 67eNd+4tB8HPv04MnYHe76l/q2D+eBR4Vk4ujyd6OF1K7SzjBfuKWD6mk+6vZzt+n9cN
 jHk+JajnxccK8HvEN7ey0gJXfemuR/d0LaY9J57Tac7qEMrH6jiGzvMpCd1v+HHqW7Tk
 WjDw==
X-Gm-Message-State: AOAM530FrRk/YUTVszeJgpINvCfXWDQzTRnHoZpezGfTdFlKZOw9HNah
 vBSfT9CSODx2DgQVDpijUj6VliuW5XjOYAKSe86OEA==
X-Google-Smtp-Source: ABdhPJzJGTfHwVFYARIGNg9FC8Dov1IHsHlYQHhoEmh1tzW9lKrSKEW13k7l29PQdX3bR1jVW7bjTII7nhCTwDCXdW4=
X-Received: by 2002:a05:6402:b35:: with SMTP id
 bo21mr5771405edb.52.1603997757691; 
 Thu, 29 Oct 2020 11:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-EsEZWDbUSy6_AXym5e-wP_B4buZYG0swF946ue41WKg@mail.gmail.com>
 <20201029174124.GD3335@work-vm>
In-Reply-To: <20201029174124.GD3335@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2020 18:55:45 +0000
Message-ID: <CAFEAcA9ex69Ov=hfb4LUQak=_bnwQc8mjUx4MgEwgSciD8Ut+A@mail.gmail.com>
Subject: Re: recent flakiness (intermittent hangs) of migration-test
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 at 17:41, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > Recently I've seen the 'make check' migration-test developing an
> > intermittent hang; I've seen this now on aarch32 host several times
> > and also on s390x host. The symptom is that the test just hangs
> > with a couple of child qemu processes sitting around doing nothing.
> > ^Cing out of 'make check' doesn't kill the qemu processes; they
> > seem to need a 'kill -9'.
>
> If you can send us a copy of the ps -eaf of the qemu commandlines
> in the failing case it would be interesting to see.

ubuntu    2078 46210  0 13:24 pts/0    00:00:00 bash -o pipefail -c
echo 'MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_IMG=./qemu-img
G_TEST_DBUS_DAEMON=/home/ubuntu/qemu/tests/dbus-vmstate-daemon.sh
QTEST_QEMU_BINARY=./qemu-system-x86_64 tests/qtest/migration-test
--tap -k' && MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255
+ 1))} QTEST_QEMU_IMG=./qemu-img
G_TEST_DBUS_DAEMON=/home/ubuntu/qemu/tests/dbus-vmstate-daemon.sh
QTEST_QEMU_BINARY=./qemu-system-x86_64 tests/qtest/migration-test
--tap -k < /dev/null | ./scripts/tap-driver.pl
--test-name="qtest-x86_64/migration-test"
ubuntu    2079  2078  8 13:24 pts/0    00:07:07
tests/qtest/migration-test --tap -k
ubuntu    2080  2078  0 13:24 pts/0    00:00:00 perl
./scripts/tap-driver.pl --test-name=qtest-x86_64/migration-test
ubuntu    3514  2079  6 13:24 pts/0    00:05:56 ./qemu-system-x86_64
-qtest unix:/tmp/qtest-2079.sock -qtest-log /dev/null -chardev
socket,path=/tmp/qtest-2079.qmp,id=char0 -mon
chardev=char0,mode=control -display none -accel kvm -accel tcg -name
source,debug-threads=on -m 150M -serial
file:/tmp/migration-test-EOJPDc/src_serial -drive
file=/tmp/migration-test-EOJPDc/bootsect,format=raw -accel qtest
ubuntu    3528  2079  0 13:24 pts/0    00:00:00 ./qemu-system-x86_64
-qtest unix:/tmp/qtest-2079.sock -qtest-log /dev/null -chardev
socket,path=/tmp/qtest-2079.qmp,id=char0 -mon
chardev=char0,mode=control -display none -accel kvm -accel tcg -name
target,debug-threads=on -m 150M -serial
file:/tmp/migration-test-EOJPDc/dest_serial -incoming
unix:/tmp/migration-test-EOJPDc/migsocket -drive
file=/tmp/migration-test-EOJPDc/bootsect,format=raw -accel qtest


> > Sorry for the low-information-density bug report, but I don't really
> > have time at the moment to debug failures in merge build test runs
> > because the queue of stuff still to merge is enormous...
>
> If you get a moment to breath then a backtrace of the migration-test
> process itself would be useful to see where it's hanging.

Here you go:


Thread 2 (Thread 0x3ff9bcff910 (LWP 2081)):
#0  syscall () at ../sysdeps/unix/sysv/linux/s390/s390-64/syscall.S:53
#1  0x000002aa35e353cc in qemu_futex_wait (val=<optimized out>,
f=<optimized out>)
    at /home/ubuntu/qemu/include/qemu/futex.h:29
#2  qemu_event_wait (ev=ev@entry=0x2aa35e69388 <rcu_call_ready_event>)
at ../../util/qemu-thread-posix.c:460
#3  0x000002aa35e37a8c in call_rcu_thread (opaque=opaque@entry=0x0) at
../../util/rcu.c:258
#4  0x000002aa35e34512 in qemu_thread_start (args=<optimized out>) at
../../util/qemu-thread-posix.c:521
#5  0x000003ff9bf87aa8 in start_thread (arg=0x3ff9bcff910) at
pthread_create.c:463
#6  0x000003ff9be7a896 in thread_start () at
../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65

Thread 1 (Thread 0x3ff9c378750 (LWP 2079)):
#0  0x000003ff9be44040 in __GI___nanosleep
(requested_time=requested_time@entry=0x3ffe49fe4b8,
remaining=remaining@entry=0x0)
    at ../sysdeps/unix/sysv/linux/nanosleep.c:28
#1  0x000003ff9be72d7c in usleep (useconds=useconds@entry=1000) at
../sysdeps/posix/usleep.c:32
#2  0x000002aa35e1074e in wait_for_migration_status (who=<optimized
out>, goal=<optimized out>, ungoals=0x0)
    at ../../tests/qtest/migration-helpers.c:157
#3  0x000002aa35e0ecd2 in migrate_postcopy_complete
(from=0x2aa371feb00, to=0x2aa372092e0)
    at ../../tests/qtest/migration-test.c:746
#4  0x000002aa35e0f31a in test_postcopy_recovery () at
../../tests/qtest/migration-test.c:830
#5  0x000003ff9c17c604 in ?? () from /usr/lib/s390x-linux-gnu/libglib-2.0.so.0
#6  0x000003ff9c17c540 in ?? () from /usr/lib/s390x-linux-gnu/libglib-2.0.so.0
#7  0x000003ff9c17c540 in ?? () from /usr/lib/s390x-linux-gnu/libglib-2.0.so.0
#8  0x000003ff9c17c540 in ?? () from /usr/lib/s390x-linux-gnu/libglib-2.0.so.0
#9  0x000003ff9c17c7e6 in g_test_run_suite () from
/usr/lib/s390x-linux-gnu/libglib-2.0.so.0
#10 0x000003ff9c17c820 in g_test_run () from
/usr/lib/s390x-linux-gnu/libglib-2.0.so.0
#11 0x000002aa35e0ce7c in main (argc=<optimized out>, argv=<optimized
out>) at ../../tests/qtest/migration-test.c:1511

Here's qemu process 3514:
Thread 5 (Thread 0x3ff4affd910 (LWP 3628)):
#0  0x000003ff94c8d936 in futex_wait_cancelable (private=<optimized
out>, expected=0, futex_word=0x2aa26cd74dc)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
#1  0x000003ff94c8d936 in __pthread_cond_wait_common (abstime=0x0,
mutex=0x2aa26cd7488, cond=0x2aa26cd74b0)
    at pthread_cond_wait.c:502
#2  0x000003ff94c8d936 in __pthread_cond_wait
(cond=cond@entry=0x2aa26cd74b0, mutex=mutex@entry=0x2aa26cd7488)
    at pthread_cond_wait.c:655
#3  0x000002aa2497072c in qemu_sem_wait (sem=sem@entry=0x2aa26cd7488)
at ../../util/qemu-thread-posix.c:328
#4  0x000002aa244f4a02 in postcopy_pause (s=0x2aa26cd7000) at
../../migration/migration.c:3192
#5  0x000002aa244f4a02 in migration_detect_error (s=0x2aa26cd7000) at
../../migration/migration.c:3255
#6  0x000002aa244f4a02 in migration_thread
(opaque=opaque@entry=0x2aa26cd7000) at
../../migration/migration.c:3564
#7  0x000002aa2496fa3a in qemu_thread_start (args=<optimized out>) at
../../util/qemu-thread-posix.c:521
#8  0x000003ff94c87aa8 in start_thread (arg=0x3ff4affd910) at
pthread_create.c:463
#9  0x000003ff94b7a896 in thread_start () at
../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65

Thread 4 (Thread 0x3ff68adb910 (LWP 3522)):
#0  0x000003ff94c8d936 in futex_wait_cancelable (private=<optimized
out>, expected=0, futex_word=0x2aa26dd2d58)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
#1  0x000003ff94c8d936 in __pthread_cond_wait_common (abstime=0x0,
mutex=0x2aa2525d870 <qemu_global_mutex>, cond=0x2aa26dd2d30) at
pthread_cond_wait.c:502
#2  0x000003ff94c8d936 in __pthread_cond_wait
(cond=cond@entry=0x2aa26dd2d30, mutex=mutex@entry=0x2aa2525d870
<qemu_global_mutex>) at pthread_cond_wait.c:655
#3  0x000002aa24970196 in qemu_cond_wait_impl (cond=0x2aa26dd2d30,
mutex=0x2aa2525d870 <qemu_global_mutex>, file=0x2aa24a8d162
"../../softmmu/cpus.c", line=<optimized out>) at
../../util/qemu-thread-posix.c:174
#4  0x000002aa2467cbe0 in qemu_wait_io_event
(cpu=cpu@entry=0x2aa26da31e0) at ../../softmmu/cpus.c:411
#5  0x000002aa24760976 in tcg_cpu_thread_fn
(arg=arg@entry=0x2aa26da31e0) at ../../accel/tcg/tcg-cpus.c:455
#6  0x000002aa2496fa3a in qemu_thread_start (args=<optimized out>) at
../../util/qemu-thread-posix.c:521
#7  0x000003ff94c87aa8 in start_thread (arg=0x3ff68adb910) at
pthread_create.c:463
#8  0x000003ff94b7a896 in thread_start () at
../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65

Thread 3 (Thread 0x3ff693cd910 (LWP 3521)):
#0  0x000003ff94b6f5c0 in __GI___poll (fds=0x3ff64007700, nfds=3,
timeout=<optimized out>)
    at ../sysdeps/unix/sysv/linux/poll.c:29
#1  0x000003ff96fd250c in  () at /usr/lib/s390x-linux-gnu/libglib-2.0.so.0
#2  0x000003ff96fd2990 in g_main_loop_run () at
/usr/lib/s390x-linux-gnu/libglib-2.0.so.0
#3  0x000002aa247b76e4 in iothread_run
(opaque=opaque@entry=0x2aa26a47a30) at ../../iothread.c:80
#4  0x000002aa2496fa3a in qemu_thread_start (args=<optimized out>) at
../../util/qemu-thread-posix.c:521
#5  0x000003ff94c87aa8 in start_thread (arg=0x3ff693cd910) at
pthread_create.c:463
#6  0x000003ff94b7a896 in thread_start () at
../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65

Thread 2 (Thread 0x3ff879b7910 (LWP 3520)):
#0  0x000003ff94b75a62 in syscall () at
../sysdeps/unix/sysv/linux/s390/s390-64/syscall.S:53
#1  0x000002aa249708f4 in qemu_futex_wait (val=<optimized out>,
f=<optimized out>)
    at /home/ubuntu/qemu/include/qemu/futex.h:29
#2  0x000002aa249708f4 in qemu_event_wait (ev=ev@entry=0x2aa2527dbf8
<rcu_call_ready_event>)
    at ../../util/qemu-thread-posix.c:460
#3  0x000002aa2497b57c in call_rcu_thread (opaque=opaque@entry=0x0) at
../../util/rcu.c:258
#4  0x000002aa2496fa3a in qemu_thread_start (args=<optimized out>) at
../../util/qemu-thread-posix.c:521
#5  0x000003ff94c87aa8 in start_thread (arg=0x3ff879b7910) at
pthread_create.c:463
#6  0x000003ff94b7a896 in thread_start () at
../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65

Thread 1 (Thread 0x3ff977b8450 (LWP 3514)):
#0  0x000003ff94b6f712 in __GI_ppoll (fds=0x2aa2755ecd0, nfds=6,
timeout=<optimized out>,
    timeout@entry=0x3ffec7fe4c8, sigmask=sigmask@entry=0x0) at
../sysdeps/unix/sysv/linux/ppoll.c:39
#1  0x000002aa24961c9c in ppoll (__ss=0x0, __timeout=0x3ffec7fe4c8,
__nfds=<optimized out>, __fds=<optimized out>)
    at /usr/include/s390x-linux-gnu/bits/poll2.h:77
#2  0x000002aa24961c9c in qemu_poll_ns (fds=<optimized out>,
nfds=<optimized out>, timeout=timeout@entry=1000000000)
    at ../../util/qemu-timer.c:349
#3  0x000002aa2497bb88 in os_host_main_loop_wait (timeout=1000000000)
at ../../util/main-loop.c:239
#4  0x000002aa2497bb88 in main_loop_wait
(nonblocking=nonblocking@entry=0) at ../../util/main-loop.c:520
#5  0x000002aa2475aaf0 in qemu_main_loop () at ../../softmmu/vl.c:1678
#6  0x000002aa243ee178 in main (argc=<optimized out>, argv=<optimized
out>, envp=<optimized out>) at ../../softmmu/main.c:50

And here's 3528:
Thread 6 (Thread 0x3ff6ccfd910 (LWP 3841)):
#0  0x000003ffb1b8d936 in futex_wait_cancelable (private=<optimized
out>, expected=0, futex_word=0x2aa387a6aac)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
#1  0x000003ffb1b8d936 in __pthread_cond_wait_common (abstime=0x0,
mutex=0x2aa387a6a58, cond=0x2aa387a6a80)
    at pthread_cond_wait.c:502
#2  0x000003ffb1b8d936 in __pthread_cond_wait
(cond=cond@entry=0x2aa387a6a80, mutex=mutex@entry=0x2aa387a6a58)
    at pthread_cond_wait.c:655
#3  0x000002aa36bf072c in qemu_sem_wait (sem=sem@entry=0x2aa387a6a58)
at ../../util/qemu-thread-posix.c:328
#4  0x000002aa366c369a in postcopy_pause_incoming (mis=<optimized
out>) at ../../migration/savevm.c:2541
#5  0x000002aa366c369a in qemu_loadvm_state_main
(f=f@entry=0x2aa38897930, mis=mis@entry=0x2aa387a6820)
    at ../../migration/savevm.c:2615
#6  0x000002aa366c44fa in postcopy_ram_listen_thread
(opaque=opaque@entry=0x0) at ../../migration/savevm.c:1830
#7  0x000002aa36befa3a in qemu_thread_start (args=<optimized out>) at
../../util/qemu-thread-posix.c:521
#8  0x000003ffb1b87aa8 in start_thread (arg=0x3ff6ccfd910) at
pthread_create.c:463
#9  0x000003ffb1a7a896 in thread_start () at
../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65

Thread 5 (Thread 0x3ff6d4fe910 (LWP 3840)):
#0  0x000003ffb1b8d936 in futex_wait_cancelable (private=<optimized
out>, expected=0, futex_word=0x2aa387a6b0c)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
#1  0x000003ffb1b8d936 in __pthread_cond_wait_common (abstime=0x0,
mutex=0x2aa387a6ab8, cond=0x2aa387a6ae0)
    at pthread_cond_wait.c:502
#2  0x000003ffb1b8d936 in __pthread_cond_wait
(cond=cond@entry=0x2aa387a6ae0, mutex=mutex@entry=0x2aa387a6ab8)
    at pthread_cond_wait.c:655
#3  0x000002aa36bf072c in qemu_sem_wait (sem=0x2aa387a6ab8,
sem@entry=<error reading variable: value has been optimized out>)
    at ../../util/qemu-thread-posix.c:328
#4  0x000002aa3685282c in postcopy_pause_fault_thread (mis=<optimized
out>) at ../../migration/postcopy-ram.c:841
#5  0x000002aa3685282c in postcopy_ram_fault_thread
(opaque=opaque@entry=0x2aa387a6820) at
../../migration/postcopy-ram.c:905
#6  0x000002aa36befa3a in qemu_thread_start (args=<optimized out>) at
../../util/qemu-thread-posix.c:521
#7  0x000003ffb1b87aa8 in start_thread (arg=0x3ff6d4fe910) at
pthread_create.c:463
#8  0x000003ffb1a7a896 in thread_start () at
../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65

Thread 4 (Thread 0x3ff859db910 (LWP 3536)):
#0  0x000002aa369854ec in load_memop (op=MO_8, haddr=0x3ff6fa61000) at
../../accel/tcg/cputlb.c:1794
#1  0x000002aa369854ec in load_helper (full_load=<optimized out>,
code_read=false, op=MO_8, retaddr=4396002632260, oi=<optimized out>,
addr=18223104, env=0x2aa38879a90) at ../../accel/tcg/cputlb.c:1914
#2  0x000002aa369854ec in full_ldub_mmu (env=0x2aa38879a90,
addr=18223104, oi=<optimized out>, retaddr=4396002632260)
    at ../../accel/tcg/cputlb.c:1930
#3  0x000003ff862ce304 in code_gen_buffer ()
#4  0x000002aa3693ab62 in cpu_tb_exec (itb=<optimized out>,
cpu=<optimized out>) at ../../accel/tcg/cpu-exec.c:178
#5  0x000002aa3693ab62 in cpu_loop_exec_tb (tb_exit=<synthetic
pointer>, last_tb=<synthetic pointer>, tb=<optimized out>,
cpu=<optimized out>) at ../../accel/tcg/cpu-exec.c:658
#6  0x000002aa3693ab62 in cpu_exec (cpu=<optimized out>) at
../../accel/tcg/cpu-exec.c:771
#7  0x000002aa0000000c in  ()

Thread 3 (Thread 0x3ff862cd910 (LWP 3535)):
#0  0x000003ffb1a6f5c0 in __GI___poll (fds=0x3ff78007700, nfds=3,
timeout=<optimized out>)
    at ../sysdeps/unix/sysv/linux/poll.c:29
#1  0x000003ffb3ed250c in  () at /usr/lib/s390x-linux-gnu/libglib-2.0.so.0
#2  0x000003ffb3ed2990 in g_main_loop_run () at
/usr/lib/s390x-linux-gnu/libglib-2.0.so.0
#3  0x000002aa36a376e4 in iothread_run
(opaque=opaque@entry=0x2aa38515a30) at ../../iothread.c:80
#4  0x000002aa36befa3a in qemu_thread_start (args=<optimized out>) at
../../util/qemu-thread-posix.c:521
#5  0x000003ffb1b87aa8 in start_thread (arg=0x3ff862cd910) at
pthread_create.c:463
#6  0x000003ffb1a7a896 in thread_start () at
../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65

Thread 2 (Thread 0x3ffa48b7910 (LWP 3533)):
#0  0x000003ffb1a75a62 in syscall () at
../sysdeps/unix/sysv/linux/s390/s390-64/syscall.S:53
#1  0x000002aa36bf08f4 in qemu_futex_wait (val=<optimized out>,
f=<optimized out>)
    at /home/ubuntu/qemu/include/qemu/futex.h:29
#2  0x000002aa36bf08f4 in qemu_event_wait (ev=ev@entry=0x2aa374fdbf0
<rcu_gp_event>) at ../../util/qemu-thread-posix.c:460
#3  0x000002aa36bfb190 in wait_for_readers () at ../../util/rcu.c:135
#4  0x000002aa36bfb190 in synchronize_rcu () at ../../util/rcu.c:171
#5  0x000002aa36bfb5b2 in call_rcu_thread (opaque=opaque@entry=0x0) at
../../util/rcu.c:265
#6  0x000002aa36befa3a in qemu_thread_start (args=<optimized out>) at
../../util/qemu-thread-posix.c:521
#7  0x000003ffb1b87aa8 in start_thread (arg=0x3ffa48b7910) at
pthread_create.c:463
#8  0x000003ffb1a7a896 in thread_start () at
../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65

Thread 1 (Thread 0x3ffb46b8450 (LWP 3528)):
#0  0x000003ffb1a6f712 in __GI_ppoll (fds=0x2aa39312cb0, nfds=6,
timeout=<optimized out>,
    timeout@entry=0x3ffe76feb78, sigmask=sigmask@entry=0x0) at
../sysdeps/unix/sysv/linux/ppoll.c:39
#1  0x000002aa36be1c9c in ppoll (__ss=0x0, __timeout=0x3ffe76feb78,
__nfds=<optimized out>, __fds=<optimized out>)
    at /usr/include/s390x-linux-gnu/bits/poll2.h:77
#2  0x000002aa36be1c9c in qemu_poll_ns (fds=<optimized out>,
nfds=<optimized out>, timeout=timeout@entry=54858292)
    at ../../util/qemu-timer.c:349
#3  0x000002aa36bfbb88 in os_host_main_loop_wait (timeout=54858292) at
../../util/main-loop.c:239
#4  0x000002aa36bfbb88 in main_loop_wait
(nonblocking=nonblocking@entry=0) at ../../util/main-loop.c:520
#5  0x000002aa369daaf0 in qemu_main_loop () at ../../softmmu/vl.c:1678
#6  0x000002aa3666e178 in main (argc=<optimized out>, argv=<optimized
out>, envp=<optimized out>) at ../../softmmu/main.c:50


thanks
-- PMM

