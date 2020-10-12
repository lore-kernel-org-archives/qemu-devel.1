Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7B3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0A52074D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0A52074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRuvQ-00016M-CQ
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kRuqd-0004TX-Sg
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:14:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:60608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kRuqb-0004Xu-BA
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:14:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0B967AC6C;
 Mon, 12 Oct 2020 10:14:27 +0000 (UTC)
Subject: Re: [RFC v1 3/4] qtest: do not build ide-test if TCG is not available
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20201009152108.16120-1-cfontana@suse.de>
 <20201009152108.16120-4-cfontana@suse.de>
 <673c52e5-e22e-bda1-b262-ec476a966f3f@redhat.com>
 <d95cc25f-eef1-5a78-5762-6211582e8a06@suse.de>
Message-ID: <a34a5010-e24d-0cfe-2f77-f12d6c483cea@suse.de>
Date: Mon, 12 Oct 2020 12:14:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d95cc25f-eef1-5a78-5762-6211582e8a06@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 01:21:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/20 12:50 PM, Claudio Fontana wrote:
> On 10/9/20 6:01 PM, Paolo Bonzini wrote:
>> On 09/10/20 17:21, Claudio Fontana wrote:
>>> it seems that ide-test depends on TCG currently.
>>>
>>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>>> ---
>>>  tests/qtest/meson.build | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>>> index ad33ac311d..3418f65e2a 100644
>>> --- a/tests/qtest/meson.build
>>> +++ b/tests/qtest/meson.build
>>> @@ -46,9 +46,9 @@ qtests_i386 = \
>>>    (config_all_devices.has_key('CONFIG_TPM_TIS_ISA') ? ['tpm-tis-test'] : []) +              \
>>>    (config_all_devices.has_key('CONFIG_TPM_TIS_ISA') ? ['tpm-tis-swtpm-test'] : []) +        \
>>>    (config_all_devices.has_key('CONFIG_RTL8139_PCI') ? ['rtl8139-test'] : []) +              \
>>> +  (config_all.has_key('CONFIG_TCG') ? ['ide-test'] : []) +                                  \
>>>    qtests_pci +                                                                              \
>>>    ['fdc-test',
>>> -   'ide-test',
>>>     'hd-geo-test',
>>>     'boot-order-test',
>>>     'bios-tables-test',
>>>
>>
>> Interesting, why?...
>>
>> Paolo
>>
>>
> 
> I am slowly trying to find out. I found out that the qos-test that buzzes is ide-test,
> and I found out which specific ide test it was by manually bisecting functions inside the qtest_add_func in ide-test.c.
> 
> The issue seems limited to qtest_add_func("/ide/bmdma/trim", test_bmdma_trim);
> No idea yet why that test buzzes forever.
> 
> Side note, maybe more verbose output on which specific test is attempted could be helpful? maybe only enabled on make V=2 ?
> 
> So the buzz.
> top says:
> 
> 22621 claudio   20   0   89700   3292   3004 R 53.82 0.010   1:22.43 ide-test                                                              
> 22844 claudio   20   0 1026700  61168  38632 R 99.67 0.188   2:39.53 qemu-system-i38                                                       
> 25325 claudio   20   0   89700   3208   2940 R 52.16 0.010   0:56.05 ide-test       
> 25403 claudio   20   0 1026720  63028  38416 R 99.67 0.194   1:48.63 qemu-system-x86                                                       
> 
> 
> i386 and x86_64 seem to show the exact same behaviour.
> 
> 
> gdb says:
> 
> qemu-system-x86 (25403):
> 
> (gdb) info threads
>   Id   Target Id                                           Frame 
> * 1    Thread 0x7fe35a406140 (LWP 25403) "qemu-system-x86" 0x00007fe35157f7d6 in ppoll () from /lib64/libc.so.6
>   2    Thread 0x7fe33946e700 (LWP 25415) "qemu-system-x86" 0x00007fe351584839 in syscall () from /lib64/libc.so.6
>   3    Thread 0x7fe338c6d700 (LWP 25439) "qemu-system-x86" 0x00007fe35157f6db in poll () from /lib64/libc.so.6
>   4    Thread 0x7fe333fff700 (LWP 25440) "qemu-system-x86" 0x00007fe35185bdcf in do_sigwait () from /lib64/libpthread.so.0
> 
> (gdb) thread 1
> [Switching to thread 1 (Thread 0x7fe35a406140 (LWP 25403))]
> #0  0x00007fe35157f7d6 in ppoll () from /lib64/libc.so.6
> (gdb) bt
> #0  0x00007fe35157f7d6 in ppoll () at /lib64/libc.so.6
> #1  0x000055a1f3138309 in ppoll (__ss=0x0, __timeout=0x7fff64d10b70, __nfds=<optimized out>, __fds=<optimized out>)
>     at /usr/include/bits/poll2.h:77
> #2  0x000055a1f3138309 in qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>, timeout=timeout@entry=27462700)
>     at ../util/qemu-timer.c:349
> #3  0x000055a1f31512a5 in os_host_main_loop_wait (timeout=27462700) at ../util/main-loop.c:239
> #4  0x000055a1f31512a5 in main_loop_wait (nonblocking=nonblocking@entry=0) at ../util/main-loop.c:520
> #5  0x000055a1f2fc4bbd in qemu_main_loop () at ../softmmu/vl.c:1677
> #6  0x000055a1f2d001fe in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at ../softmmu/main.c:50
> 
> (gdb) thread 2
> [Switching to thread 2 (Thread 0x7fe33946e700 (LWP 25415))]
> #0  0x00007fe351584839 in syscall () from /lib64/libc.so.6
> (gdb) bt
> #0  0x00007fe351584839 in syscall () at /lib64/libc.so.6
> #1  0x000055a1f312605b in qemu_futex_wait (val=<optimized out>, f=<optimized out>)
>     at /home/claudio/git/qemu-pristine/qemu/include/qemu/futex.h:29
> #2  0x000055a1f312605b in qemu_event_wait (ev=ev@entry=0x55a1f3a44208 <rcu_call_ready_event>) at ../util/qemu-thread-posix.c:460
> #3  0x000055a1f314f868 in call_rcu_thread (opaque=opaque@entry=0x0) at ../util/rcu.c:258
> #4  0x000055a1f3125276 in qemu_thread_start (args=<optimized out>) at ../util/qemu-thread-posix.c:521
> #5  0x00007fe3518514f9 in start_thread () at /lib64/libpthread.so.0
> #6  0x00007fe351589fbf in clone () at /lib64/libc.so.6
> (gdb) frame 3
> #3  0x000055a1f314f868 in call_rcu_thread (opaque=opaque@entry=0x0) at ../util/rcu.c:258
> 258                         qemu_event_wait(&rcu_call_ready_event);
> (gdb) list 258
> 253                     n = qatomic_read(&rcu_call_count);
> 254                     if (n == 0) {
> 255     #if defined(CONFIG_MALLOC_TRIM)
> 256                         malloc_trim(4 * 1024 * 1024);
> 257     #endif
> 258                         qemu_event_wait(&rcu_call_ready_event);
> 259                     }
> 260                 }
> 261                 n = qatomic_read(&rcu_call_count);
> 262             }
> 
> 
> (gdb) thread 3
> [Switching to thread 3 (Thread 0x7fe338c6d700 (LWP 25439))]
> #0  0x00007fe35157f6db in poll () from /lib64/libc.so.6
> (gdb) bt
> #0  0x00007fe35157f6db in poll () at /lib64/libc.so.6
> #1  0x00007fe357087779 in  () at /usr/lib64/libglib-2.0.so.0
> #2  0x00007fe357087ac2 in g_main_loop_run () at /usr/lib64/libglib-2.0.so.0
> #3  0x000055a1f2dc1c51 in iothread_run (opaque=opaque@entry=0x55a1f4b20250) at ../iothread.c:80
> #4  0x000055a1f3125276 in qemu_thread_start (args=<optimized out>) at ../util/qemu-thread-posix.c:521
> #5  0x00007fe3518514f9 in start_thread () at /lib64/libpthread.so.0
> #6  0x00007fe351589fbf in clone () at /lib64/libc.so.6
> (gdb) frame 3
> #3  0x000055a1f2dc1c51 in iothread_run (opaque=opaque@entry=0x55a1f4b20250) at ../iothread.c:80
> 80                  g_main_loop_run(iothread->main_loop);
> (gdb) list 80
> 75              /*
> 76               * We must check the running state again in case it was
> 77               * changed in previous aio_poll()
> 78               */
> 79              if (iothread->running && qatomic_read(&iothread->run_gcontext)) {
> 80                  g_main_loop_run(iothread->main_loop);
> 81              }
> 82          }
> 83
> 
> 
> (gdb) thread 4
> [Switching to thread 4 (Thread 0x7fe333fff700 (LWP 25440))]
> #0  0x00007fe35185bdcf in do_sigwait () from /lib64/libpthread.so.0
> (gdb) bt
> #0  0x00007fe35185bdcf in do_sigwait () at /lib64/libpthread.so.0
> #1  0x00007fe35185be5d in sigwait () at /lib64/libpthread.so.0
> #2  0x000055a1f2fd0543 in qtest_cpu_thread_fn (arg=arg@entry=0x55a1f4e84be0) at ../accel/qtest/qtest-cpus.c:59
> #3  0x000055a1f3125276 in qemu_thread_start (args=<optimized out>) at ../util/qemu-thread-posix.c:521
> #4  0x00007fe3518514f9 in start_thread () at /lib64/libpthread.so.0
> #5  0x00007fe351589fbf in clone () at /lib64/libc.so.6
> 
> (gdb) list qtest_cpu_thread_fn 
> 26      #include "hw/core/cpu.h"
> 27
> 28      #include "qtest-cpus.h"
> 29
> 30      static void *qtest_cpu_thread_fn(void *arg)
> 31      {
> 32      #ifdef _WIN32
> 33          error_report("qtest is not supported under Windows");
> 34          exit(1);
> 35      #else
> 36          CPUState *cpu = arg;
> 37          sigset_t waitset;
> 38          int r;
> 39
> 40          rcu_register_thread();
> 41
> 42          qemu_mutex_lock_iothread();
> 43          qemu_thread_get_self(cpu->thread);
> 44          cpu->thread_id = qemu_get_thread_id();
> 45          cpu->can_do_io = 1;
> 46          current_cpu = cpu;
> 47
> 48          sigemptyset(&waitset);
> 49          sigaddset(&waitset, SIG_IPI);
> 50
> 51          /* signal CPU creation */
> 52          cpu_thread_signal_created(cpu);
> 53          qemu_guest_random_seed_thread_part2(cpu->random_seed);
> 54
> 55          do {
> 56              qemu_mutex_unlock_iothread();
> 57              do {
> 58                  int sig;
> 59                  r = sigwait(&waitset, &sig);
> 60              } while (r == -1 && (errno == EAGAIN || errno == EINTR));
> 61              if (r == -1) {
> 62                  perror("sigwait");
> 63                  exit(1);
> 64              }
> 65              qemu_mutex_lock_iothread();
> 66              qemu_wait_io_event(cpu);
> 67          } while (!cpu->unplug);
> 68
> 69          qemu_mutex_unlock_iothread();
> 70          rcu_unregister_thread();
> 71          return NULL;
> 72      #endif
> 73      }
> 74
> 
> ----
> 
> ide-test (25325):
> 
> (gdb) thread 1
> [Switching to thread 1 (Thread 0x7fdce50b81c0 (LWP 25325))]
> #0  0x00007fdce4651deb in write () from /lib64/libpthread.so.0
> (gdb) bt
> #0  0x00007fdce4651deb in write () from /lib64/libpthread.so.0
> #1  0x000055dc0150a3a7 in socket_send (fd=5, buf=0x55dc036b4bd0 "inb 0xc012\n", size=11) at ../tests/qtest/libqtest.c:400
> #2  0x000055dc0150a73b in qtest_sendf (s=s@entry=0x55dc036b4ca0, fmt=fmt@entry=0x55dc015377e3 "%s 0x%x\n") at ../tests/qtest/libqtest.c:424
> #3  0x000055dc0150aeea in qtest_in (s=0x55dc036b4ca0, cmd=<optimized out>, addr=<optimized out>) at ../tests/qtest/libqtest.c:929
> #4  0x000055dc0150c613 in qtest_inb (s=<optimized out>, addr=<optimized out>) at ../tests/qtest/libqtest.c:940
> #5  0x000055dc0150ef08 in qpci_io_readb (dev=<optimized out>, token=..., off=<optimized out>) at ../tests/qtest/libqos/pci.c:283
> #6  0x000055dc015079c2 in send_dma_request (qts=0x55dc036b4ca0, cmd=<optimized out>, sector=0, nb_sectors=1, prdt=<optimized out>, 
>     prdt_entries=<optimized out>, post_exec=0x0) at ../tests/qtest/ide-test.c:283
> #7  0x000055dc0150839c in test_bmdma_trim () at ../tests/qtest/ide-test.c:426
> #8  0x00007fdce4c11826 in ?? () from /usr/lib64/libglib-2.0.so.0
> #9  0x00007fdce4c1173b in ?? () from /usr/lib64/libglib-2.0.so.0
> #10 0x00007fdce4c1173b in ?? () from /usr/lib64/libglib-2.0.so.0
> #11 0x00007fdce4c1173b in ?? () from /usr/lib64/libglib-2.0.so.0
> #12 0x00007fdce4c11ce2 in g_test_run_suite () from /usr/lib64/libglib-2.0.so.0
> #13 0x00007fdce4c11d01 in g_test_run () from /usr/lib64/libglib-2.0.so.0
> #14 0x000055dc01506da6 in main (argc=<optimized out>, argv=<optimized out>) at ../tests/qtest/ide-test.c:1059
> 
> (gdb) thread 2
> [Switching to thread 2 (Thread 0x7fdce3ff9700 (LWP 25327))]
> #0  0x00007fdce437b839 in syscall () from /lib64/libc.so.6
> (gdb) bt
> #0  0x00007fdce437b839 in syscall () from /lib64/libc.so.6
> #1  0x000055dc01528b1b in qemu_futex_wait (val=<optimized out>, f=<optimized out>)
>     at /home/claudio/git/qemu-pristine/qemu/include/qemu/futex.h:29
> #2  qemu_event_wait (ev=ev@entry=0x55dc017566e8 <rcu_call_ready_event>) at ../util/qemu-thread-posix.c:460
> #3  0x000055dc01525c88 in call_rcu_thread (opaque=opaque@entry=0x0) at ../util/rcu.c:258
> #4  0x000055dc01527d36 in qemu_thread_start (args=<optimized out>) at ../util/qemu-thread-posix.c:521
> #5  0x00007fdce46484f9 in start_thread () from /lib64/libpthread.so.0
> #6  0x00007fdce4380fbf in clone () from /lib64/libc.so.6
> 
> ----
> 
> ide-test (22621):
> 
> (gdb) bt
> #0  0x00007f4f9b723e88 in read () from /lib64/libpthread.so.0
> #1  0x00005573ffafb512 in read (__nbytes=1024, __buf=0x7ffdd0be3bf0, __fd=<optimized out>) at /usr/include/bits/unistd.h:44
> #2  qtest_client_socket_recv_line (s=0x55740104fca0) at ../tests/qtest/libqtest.c:472
> #3  0x00005573ffafb7b1 in qtest_rsp (s=s@entry=0x55740104fca0, expected_args=expected_args@entry=2) at ../tests/qtest/libqtest.c:499
> #4  0x00005573ffafbef7 in qtest_in (s=0x55740104fca0, cmd=<optimized out>, addr=<optimized out>) at ../tests/qtest/libqtest.c:930
> #5  0x00005573ffafd613 in qtest_inb (s=<optimized out>, addr=<optimized out>) at ../tests/qtest/libqtest.c:940
> #6  0x00005573ffafff08 in qpci_io_readb (dev=<optimized out>, token=..., off=<optimized out>) at ../tests/qtest/libqos/pci.c:283
> #7  0x00005573ffaf89c2 in send_dma_request (qts=0x55740104fca0, cmd=<optimized out>, sector=0, nb_sectors=1, prdt=<optimized out>, 
>     prdt_entries=<optimized out>, post_exec=0x0) at ../tests/qtest/ide-test.c:283
> #8  0x00005573ffaf939c in test_bmdma_trim () at ../tests/qtest/ide-test.c:426
> #9  0x00007f4f9bce3826 in ?? () from /usr/lib64/libglib-2.0.so.0
> #10 0x00007f4f9bce373b in ?? () from /usr/lib64/libglib-2.0.so.0
> #11 0x00007f4f9bce373b in ?? () from /usr/lib64/libglib-2.0.so.0
> #12 0x00007f4f9bce373b in ?? () from /usr/lib64/libglib-2.0.so.0
> #13 0x00007f4f9bce3ce2 in g_test_run_suite () from /usr/lib64/libglib-2.0.so.0
> #14 0x00007f4f9bce3d01 in g_test_run () from /usr/lib64/libglib-2.0.so.0
> #15 0x00005573ffaf7da6 in main (argc=<optimized out>, argv=<optimized out>) at ../tests/qtest/ide-test.c:1059
> 
> (gdb) thread 2
> [Switching to thread 2 (Thread 0x7f4f9b0cb700 (LWP 22625))]
> #0  0x00007f4f9b44d839 in syscall () from /lib64/libc.so.6
> (gdb) bt
> #0  0x00007f4f9b44d839 in syscall () from /lib64/libc.so.6
> #1  0x00005573ffb19b1b in qemu_futex_wait (val=<optimized out>, f=<optimized out>)
>     at /home/claudio/git/qemu-pristine/qemu/include/qemu/futex.h:29
> #2  qemu_event_wait (ev=ev@entry=0x5573ffd476e8 <rcu_call_ready_event>) at ../util/qemu-thread-posix.c:460
> #3  0x00005573ffb16c88 in call_rcu_thread (opaque=opaque@entry=0x0) at ../util/rcu.c:258
> #4  0x00005573ffb18d36 in qemu_thread_start (args=<optimized out>) at ../util/qemu-thread-posix.c:521
> #5  0x00007f4f9b71a4f9 in start_thread () from /lib64/libpthread.so.0
> #6  0x00007f4f9b452fbf in clone () from /lib64/libc.so.6
> 
> This send_dma_request seems to never end but why..?
> 
> Ciao,
> 
> Claudio
> 

The problem stems from replay changes, in this case it is replay_bh_schedule_event.

The function tests for events_enabled presence inside the implementation, and only if replay events is not enabled it forwards stuff to qemu_bh_schedule().

This is done for other events, including

replay_bh_schedule_event
replay_bh_schedule_oneshot_event
replay_block_event

files like block/blkreplay.c and others should also be made conditional on TCG.

I'll try to sort out this and propose a patch.

Ciao,

Claudio





