Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337DCC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 19:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BBAF221E8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 19:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBAF221E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKoGT-0006LN-RU
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 15:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kKoEP-0005JE-K8
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 15:45:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:49800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kKoEM-0003cS-RK
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 15:45:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kKoEK-0002Un-P6
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 19:45:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9D5D52E8071
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 19:45:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2020 19:39:03 -0000
From: Eduardo Habkost <1896263@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ehabkost laurent-vivier maxco stefanha vkuznets
X-Launchpad-Bug-Reporter: Apteryx (maxco)
X-Launchpad-Bug-Modifier: Eduardo Habkost (ehabkost)
References: <160044888692.1133.11388395637815022535.malonedeb@chaenomeles.canonical.com>
Message-ID: <20200922193903.GA2044576@habkost.net>
Subject: [Bug 1896263] Re: [PATCH] i386: Don't try to set MSR_KVM_ASYNC_PF_EN
 if kernel-irqchip=off
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: 0718d79fd872bcafbf407e61d8f8252571f4ff42
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:45:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1896263 <1896263@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200922193903.a0bozy9U61QnCaWhZNiEG5alde539sauISeGo5smTaE@z>

On Tue, Sep 22, 2020 at 07:26:42PM +0200, Paolo Bonzini wrote:
> On 22/09/20 19:22, Eduardo Habkost wrote:
> > If it was possible, did KVM break live migration of
> > kernel-irqchip=3Doff guests that enabled APF?  This would mean my
> > patch is replacing a crash with a silent migration bug.  Not nice
> > either way.
> =

> Let's drop kernel-irqchip=3Doff completely so migration is not broken. :)
> =

> I'm actually serious, I don't think we need a deprecation period even.

I wasn't sure about this, but then I've noticed the man page says
"disabling the in-kernel irqchip completely is not recommended
except for debugging purposes."

Does this note apply to all architectures?

-- =

Eduardo

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1896263

Title:
  The bios-tables-test test causes QEMU to crash (Assertion `ret =3D=3D
  cpu->kvm_msr_buf->nmsrs' failed) on AMD processors

Status in QEMU:
  New

Bug description:
  QEMU release version: Any recent version (5.0.0, 5.1.0, git master)
  Host CPU: AMD Ryzen 3900X

  The following backtrace is from commit
  e883b492c221241d28aaa322c61536436090538a.

  QTEST_QEMU_BINARY=3D./build/qemu-system-x86_64 gdb ./build/tests/qtest/bi=
os-tables-test
  GNU gdb (GDB) 9.2
  Copyright (C) 2020 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.
  Type "show copying" and "show warranty" for details.
  This GDB was configured as "x86_64-unknown-linux-gnu".
  Type "show configuration" for configuration details.
  For bug reporting instructions, please see:
  <http://www.gnu.org/software/gdb/bugs/>.
  Find the GDB manual and other documentation resources online at:
      <http://www.gnu.org/software/gdb/documentation/>.

  For help, type "help".
  Type "apropos word" to search for commands related to "word"...
  Reading symbols from ./build/tests/qtest/bios-tables-test...
  (gdb) run
  Starting program: /home/mcournoyer/src/qemu/build/tests/qtest/bios-tables=
-test =

  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/gnu/store/fa6wj5bxkj5ll1d7292a70knmyl7a=
0cr-glibc-2.31/lib/libthread_db.so.1".
  [New Thread 0x7ffff7af6700 (LWP 18955)]
  # random seed: R02S5106b7afa2fd84a0353605795c04ab7d
  1..19
  # Start of x86_64 tests
  # Start of acpi tests
  # starting QEMU: exec ./build/qemu-system-x86_64 -qtest unix:/tmp/qtest-1=
8951.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-18951.qmp,=
id=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -machine pc,ke=
rnel-irqchip=3Doff -accel kvm -accel tcg -net none -display none  -drive id=
=3Dhd0,if=3Dnone,file=3Dtests/acpi-test-disk-R3kbyc,format=3Draw -device id=
e-hd,drive=3Dhd0  -accel qtest
  [Attaching after Thread 0x7ffff7af7900 (LWP 18951) fork to child process =
18956]
  [New inferior 2 (process 18956)]
  [Detaching after fork from parent process 18951]
  [Inferior 1 (process 18951) detached]
  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/gnu/store/fa6wj5bxkj5ll1d7292a70knmyl7a=
0cr-glibc-2.31/lib/libthread_db.so.1".
  [New Thread 0x7ffff7af6700 (LWP 18957)]
  [Thread 0x7ffff7af6700 (LWP 18957) exited]
  process 18956 is executing new program: /gnu/store/87kif0bpf0anwbsaw0jvg8=
fyciw4sz67-bash-5.0.16/bin/bash
  process 18956 is executing new program: /home/mcournoyer/src/qemu/build/q=
emu-system-x86_64
  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/gnu/store/fa6wj5bxkj5ll1d7292a70knmyl7a=
0cr-glibc-2.31/lib/libthread_db.so.1".
  [New Thread 0x7ffff48ed700 (LWP 18958)]
  [New Thread 0x7fffeffff700 (LWP 18960)]
  [New Thread 0x7fffef61c700 (LWP 18961)]
  [New Thread 0x7fffed5ff700 (LWP 18962)]
  qemu-system-x86_64: error: failed to set MSR 0x4b564d02 to 0x0
  qemu-system-x86_64: ../target/i386/kvm.c:2714: kvm_buf_set_msrs: Assertio=
n `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.

  Thread 2.5 "qemu-system-x86" received signal SIGABRT, Aborted.
  [Switching to Thread 0x7fffef61c700 (LWP 18961)]
  0x00007ffff65dbaba in raise () from /gnu/store/fa6wj5bxkj5ll1d7292a70knmy=
l7a0cr-glibc-2.31/lib/libc.so.6
  (gdb) taas bt

  Thread 2.6 (Thread 0x7fffed5ff700 (LWP 18962)):
  #0  0x00007ffff6770c4d in pthread_cond_timedwait@@GLIBC_2.3.2 () from /gn=
u/store/fa6wj5bxkj5ll1d7292a70knmyl7a0cr-glibc-2.31/lib/libpthread.so.0
  #1  0x0000555555cc8a0e in qemu_sem_timedwait (sem=3Dsem@entry=3D0x5555566=
2f758, ms=3Dms@entry=3D10000) at ../util/qemu-thread-posix.c:282
  #2  0x0000555555cd91b5 in worker_thread (opaque=3Dopaque@entry=3D0x555556=
62f6e0) at ../util/thread-pool.c:91
  #3  0x0000555555cc7e86 in qemu_thread_start (args=3D<optimized out>) at .=
./util/qemu-thread-posix.c:521
  #4  0x00007ffff6769f64 in start_thread () from /gnu/store/fa6wj5bxkj5ll1d=
7292a70knmyl7a0cr-glibc-2.31/lib/libpthread.so.0
  #5  0x00007ffff669b9af in clone () from /gnu/store/fa6wj5bxkj5ll1d7292a70=
knmyl7a0cr-glibc-2.31/lib/libc.so.6

  Thread 2.5 (Thread 0x7fffef61c700 (LWP 18961)):
  #0  0x00007ffff65dbaba in raise () from /gnu/store/fa6wj5bxkj5ll1d7292a70=
knmyl7a0cr-glibc-2.31/lib/libc.so.6
  #1  0x00007ffff65dcbf5 in abort () from /gnu/store/fa6wj5bxkj5ll1d7292a70=
knmyl7a0cr-glibc-2.31/lib/libc.so.6
  #2  0x00007ffff65d470a in __assert_fail_base () from /gnu/store/fa6wj5bxk=
j5ll1d7292a70knmyl7a0cr-glibc-2.31/lib/libc.so.6
  #3  0x00007ffff65d4782 in __assert_fail () from /gnu/store/fa6wj5bxkj5ll1=
d7292a70knmyl7a0cr-glibc-2.31/lib/libc.so.6
  #4  0x0000555555a3e979 in kvm_buf_set_msrs (cpu=3D0x555556688a20) at ../t=
arget/i386/kvm.c:2714
  #5  0x0000555555a438cc in kvm_put_msrs (level=3D3, cpu=3D0x555556688a20) =
at ../target/i386/kvm.c:3005
  #6  kvm_arch_put_registers (cpu=3Dcpu@entry=3D0x555556688a20, level=3Dlev=
el@entry=3D3) at ../target/i386/kvm.c:3989
  #7  0x0000555555af7b0e in do_kvm_cpu_synchronize_post_init (cpu=3D0x55555=
6688a20, arg=3D...) at ../accel/kvm/kvm-all.c:2355
  #8  0x00005555558ef8e2 in process_queued_cpu_work (cpu=3Dcpu@entry=3D0x55=
5556688a20) at ../cpus-common.c:343
  #9  0x0000555555b6ac25 in qemu_wait_io_event_common (cpu=3Dcpu@entry=3D0x=
555556688a20) at ../softmmu/cpus.c:1117
  #10 0x0000555555b6ac84 in qemu_wait_io_event (cpu=3Dcpu@entry=3D0x5555566=
88a20) at ../softmmu/cpus.c:1157
  #11 0x0000555555b6aec8 in qemu_kvm_cpu_thread_fn (arg=3Darg@entry=3D0x555=
556688a20) at ../softmmu/cpus.c:1193
  #12 0x0000555555cc7e86 in qemu_thread_start (args=3D<optimized out>) at .=
./util/qemu-thread-posix.c:521
  #13 0x00007ffff6769f64 in start_thread () from /gnu/store/fa6wj5bxkj5ll1d=
7292a70knmyl7a0cr-glibc-2.31/lib/libpthread.so.0
  #14 0x00007ffff669b9af in clone () from /gnu/store/fa6wj5bxkj5ll1d7292a70=
knmyl7a0cr-glibc-2.31/lib/libc.so.6

  Thread 2.4 (Thread 0x7fffeffff700 (LWP 18960)):
  #0  0x00007ffff66919d9 in poll () from /gnu/store/fa6wj5bxkj5ll1d7292a70k=
nmyl7a0cr-glibc-2.31/lib/libc.so.6
  #1  0x00007ffff78f0051 in g_main_context_iterate.isra () from /gnu/store/=
n1mx1dp0hcrzm1akf8qdqa9gmybzazs2-profile/lib/libglib-2.0.so.0
  #2  0x00007ffff78f0392 in g_main_loop_run () from /gnu/store/n1mx1dp0hcrz=
m1akf8qdqa9gmybzazs2-profile/lib/libglib-2.0.so.0
  #3  0x000055555584b5a1 in iothread_run (opaque=3Dopaque@entry=3D0x5555565=
57720) at ../iothread.c:80
  #4  0x0000555555cc7e86 in qemu_thread_start (args=3D<optimized out>) at .=
./util/qemu-thread-posix.c:521
  #5  0x00007ffff6769f64 in start_thread () from /gnu/store/fa6wj5bxkj5ll1d=
7292a70knmyl7a0cr-glibc-2.31/lib/libpthread.so.0
  #6  0x00007ffff669b9af in clone () from /gnu/store/fa6wj5bxkj5ll1d7292a70=
knmyl7a0cr-glibc-2.31/lib/libc.so.6

  Thread 2.3 (Thread 0x7ffff48ed700 (LWP 18958)):
  #0  0x00007ffff66657a1 in clock_nanosleep@GLIBC_2.2.5 () from /gnu/store/=
fa6wj5bxkj5ll1d7292a70knmyl7a0cr-glibc-2.31/lib/libc.so.6
  #1  0x00007ffff666ac03 in nanosleep () from /gnu/store/fa6wj5bxkj5ll1d729=
2a70knmyl7a0cr-glibc-2.31/lib/libc.so.6
  #2  0x00007ffff7919cdf in g_usleep () from /gnu/store/n1mx1dp0hcrzm1akf8q=
dqa9gmybzazs2-profile/lib/libglib-2.0.so.0
  #3  0x0000555555cb3b04 in call_rcu_thread (opaque=3Dopaque@entry=3D0x0) a=
t ../util/rcu.c:250
  #4  0x0000555555cc7e86 in qemu_thread_start (args=3D<optimized out>) at .=
./util/qemu-thread-posix.c:521
  #5  0x00007ffff6769f64 in start_thread () from /gnu/store/fa6wj5bxkj5ll1d=
7292a70knmyl7a0cr-glibc-2.31/lib/libpthread.so.0
  #6  0x00007ffff669b9af in clone () from /gnu/store/fa6wj5bxkj5ll1d7292a70=
knmyl7a0cr-glibc-2.31/lib/libc.so.6

  Thread 2.1 (Thread 0x7ffff48f2c80 (LWP 18956)):
  #0  0x00007ffff677094c in pthread_cond_wait@@GLIBC_2.3.2 () from /gnu/sto=
re/fa6wj5bxkj5ll1d7292a70knmyl7a0cr-glibc-2.31/lib/libpthread.so.0
  #1  0x0000555555cc854f in qemu_cond_wait_impl (cond=3D0x5555563b0020 <qem=
u_work_cond>, mutex=3D0x5555563cd620 <qemu_global_mutex>, file=3D0x555555db=
ad06 "../cpus-common.c", line=3D154) at ../util/qemu-thread-posix.c:174
  #2  0x00005555558ef484 in do_run_on_cpu (cpu=3Dcpu@entry=3D0x555556688a20=
, func=3Dfunc@entry=3D0x555555af7b00 <do_kvm_cpu_synchronize_post_init>, da=
ta=3D..., mutex=3Dmutex@entry=3D0x5555563cd620 <qemu_global_mutex>) at ../c=
pus-common.c:154
  #3  0x0000555555b6aa7c in run_on_cpu (cpu=3Dcpu@entry=3D0x555556688a20, f=
unc=3Dfunc@entry=3D0x555555af7b00 <do_kvm_cpu_synchronize_post_init>, data=
=3D..., data@entry=3D...) at ../softmmu/cpus.c:1085
  #4  0x0000555555af8d4e in kvm_cpu_synchronize_post_init (cpu=3Dcpu@entry=
=3D0x555556688a20) at ../accel/kvm/kvm-all.c:2361
  #5  0x0000555555b6a94a in cpu_synchronize_post_init (cpu=3D0x555556688a20=
) at /home/mcournoyer/src/qemu/include/sysemu/hw_accel.h:55
  #6  cpu_synchronize_all_post_init () at ../softmmu/cpus.c:953
  #7  0x0000555555b0dca7 in qemu_init (argc=3D<optimized out>, argv=3D<opti=
mized out>, envp=3D<optimized out>) at ../softmmu/vl.c:4387
  #8  0x0000555555840609 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>, envp=3D<optimized out>) at ../softmmu/main.c:49

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1896263/+subscriptions

