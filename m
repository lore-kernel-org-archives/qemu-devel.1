Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4587C4740A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 02:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76EFE218DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 02:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EFE218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelpath.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Vhm-0002f2-KP
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 22:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i7Vh9-0002Gb-0B
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 22:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i7Vh7-0000uC-2p
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 22:15:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:33592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i7Vh5-0000mh-NU
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 22:15:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i7Vh2-0004aS-Dp
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:15:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 62DDA2E80CB
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:15:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Sep 2019 02:04:59 -0000
From: Rafael David Tinoco <rafaeldtinoco@kernelpath.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=In Progress; importance=Medium; assignee=rafaeldtinoco@kernelpath.com; 
X-Launchpad-Bug-Tags: qemu-img
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dannf jnsnow lizhengui rafaeldtinoco
X-Launchpad-Bug-Reporter: dann frazier (dannf)
X-Launchpad-Bug-Modifier: Rafael David Tinoco (rafaeldtinoco)
References: <154327283728.15443.11625169757714443608.malonedeb@soybean.canonical.com>
Message-Id: <156808109962.29344.10932981044037953793.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 2593ca13075091e364f7e941735dc1d79aa0762b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1805256] Re: qemu-img hangs on high core count
 ARM system
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
Reply-To: Bug 1805256 <1805256@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alright,

I'm still investigating this but wanted to share some findings... I
haven't got a kernel dump yet after the task is frozen, I have analyzed
only the userland part of it (although I have checked if code was
running inside kernel with perf cycles:u/cycles:k at some point).

The big picture is this: Whenever qemu-img hangs, we have 3 hung tasks
basically with these stacks:

----

TRHREAD #1
__GI_ppoll (../sysdeps/unix/sysv/linux/ppoll.c:39)
ppoll (/usr/include/aarch64-linux-gnu/bits/poll2.h:77)
qemu_poll_ns (./util/qemu-timer.c:322)
os_host_main_loop_wait (./util/main-loop.c:233)
main_loop_wait (./util/main-loop.c:497)
convert_do_copy (./qemu-img.c:1981)
img_convert (./qemu-img.c:2457)
main (./qemu-img.c:4976)

got stack traces:

./33293/stack                          ./33293/stack                       =
  =

[<0>] __switch_to+0xc0/0x218           [<0>] __switch_to+0xc0/0x218        =
  =

[<0>] ptrace_stop+0x148/0x2b0          [<0>] do_sys_poll+0x508/0x5c0       =
  =

[<0>] get_signal+0x5a4/0x730           [<0>] __arm64_sys_ppoll+0xc0/0x118  =
  =

[<0>] do_notify_resume+0x158/0x358     [<0>] el0_svc_common+0xa0/0x168     =
  =

[<0>] work_pending+0x8/0x10            [<0>] el0_svc_handler+0x38/0x78     =
  =

                                       [<0>] el0_svc+0x8/0xc  =


root@d06-1:~$ perf record -F 9999 -e cycles:u -p 33293 -- sleep 10
[ perf record: Woken up 6 times to write data ]
[ perf record: Captured and wrote 1.871 MB perf.data (48730 samples) ]

root@d06-1:~$ perf report --stdio
# Overhead  Command   Shared Object       Symbol
# ........  ........  ..................  ......................
#
    37.82%  qemu-img  libc-2.29.so        [.] 0x00000000000df710
    21.81%  qemu-img  [unknown]           [k] 0xffff000010099504
    14.23%  qemu-img  [unknown]           [k] 0xffff000010085dc0
     9.13%  qemu-img  [unknown]           [k] 0xffff00001008fff8
     6.47%  qemu-img  libc-2.29.so        [.] 0x00000000000df708
     5.69%  qemu-img  qemu-img            [.] qemu_event_reset
     2.57%  qemu-img  libc-2.29.so        [.] 0x00000000000df678
     0.63%  qemu-img  libc-2.29.so        [.] 0x00000000000df700
     0.49%  qemu-img  libc-2.29.so        [.] __sigtimedwait
     0.42%  qemu-img  libpthread-2.29.so  [.] __libc_sigwait

----

TRHREAD #3
__GI___sigtimedwait (../sysdeps/unix/sysv/linux/sigtimedwait.c:29)
__sigwait (linux/sigwait.c:28)
qemu_thread_start (./util/qemu-thread-posix.c:498)
start_thread (pthread_create.c:486)
thread_start (linux/aarch64/clone.S:78)


./33303/stack                          ./33303/stack                       =
        =

[<0>] __switch_to+0xc0/0x218           [<0>] __switch_to+0xc0/0x218        =
        =

[<0>] ptrace_stop+0x148/0x2b0          [<0>] do_sigtimedwait.isra.9+0x194/0=
x288    =

[<0>] get_signal+0x5a4/0x730           [<0>] __arm64_sys_rt_sigtimedwait+0x=
ac/0x110
[<0>] do_notify_resume+0x158/0x358     [<0>] el0_svc_common+0xa0/0x168     =
        =

[<0>] work_pending+0x8/0x10            [<0>] el0_svc_handler+0x38/0x78     =
        =

                                       [<0>] el0_svc+0x8/0xc   =


root@d06-1:~$ perf record -F 9999 -e cycles:u -p 33303 -- sleep 10
[ perf record: Woken up 6 times to write data ]
[ perf record: Captured and wrote 1.905 MB perf.data (49647 samples) ]

root@d06-1:~$ perf report --stdio
# Overhead  Command   Shared Object       Symbol
# ........  ........  ..................  ......................
#
    45.37%  qemu-img  libc-2.29.so        [.] 0x00000000000df710
    23.52%  qemu-img  [unknown]           [k] 0xffff000010099504
     9.08%  qemu-img  [unknown]           [k] 0xffff00001008fff8
     8.89%  qemu-img  [unknown]           [k] 0xffff000010085dc0
     5.56%  qemu-img  libc-2.29.so        [.] 0x00000000000df708
     3.66%  qemu-img  libc-2.29.so        [.] 0x00000000000df678
     1.01%  qemu-img  libc-2.29.so        [.] __sigtimedwait
     0.80%  qemu-img  libc-2.29.so        [.] 0x00000000000df700
     0.64%  qemu-img  qemu-img            [.] qemu_event_reset
     0.55%  qemu-img  libc-2.29.so        [.] 0x00000000000df718
     0.52%  qemu-img  libpthread-2.29.so  [.] __libc_sigwait

----

TRHREAD #2
syscall (linux/aarch64/syscall.S:38)
qemu_futex_wait (./util/qemu-thread-posix.c:438)
qemu_event_wait (./util/qemu-thread-posix.c:442)
call_rcu_thread (./util/rcu.c:261)
qemu_thread_start (./util/qemu-thread-posix.c:498)
start_thread (pthread_create.c:486)
thread_start (linux/aarch64/clone.S:78)

./33302/stack                          ./33302/stack                       =

[<0>] __switch_to+0xc0/0x218           [<0>] __switch_to+0xc0/0x218        =

[<0>] ptrace_stop+0x148/0x2b0          [<0>] ptrace_stop+0x148/0x2b0       =

[<0>] get_signal+0x5a4/0x730           [<0>] get_signal+0x5a4/0x730        =

[<0>] do_notify_resume+0x1c4/0x358     [<0>] do_notify_resume+0x1c4/0x358  =

[<0>] work_pending+0x8/0x10            [<0>] work_pending+0x8/0x10    =


<stack does not change at all>

root@d06-1:~$ perf report --stdio
# Overhead  Command   Shared Object       Symbol
# ........  ........  ..................  ......................
#
    50.30%  qemu-img  libc-2.29.so        [.] 0x00000000000df710
    26.44%  qemu-img  [unknown]           [k] 0xffff000010099504
     5.88%  qemu-img  libc-2.29.so        [.] 0x00000000000df708
     5.26%  qemu-img  [unknown]           [k] 0xffff000010085dc0
     5.25%  qemu-img  [unknown]           [k] 0xffff00001008fff8
     4.25%  qemu-img  libc-2.29.so        [.] 0x00000000000df678
     0.93%  qemu-img  libc-2.29.so        [.] __sigtimedwait
     0.51%  qemu-img  libc-2.29.so        [.] 0x00000000000df700
     0.35%  qemu-img  libpthread-2.29.so  [.] __libc_sigwait

Their stack show those tasks are pretty much "stuck" in same userland
program logic, while one of them is stuck at the same program counter
address. Profiling those tasks give no much information without more
debugging data and less optimizations.

Although all the 0x000000dfXXX addresses seem broken as we get where
libc was mapped (mid heap) and we have:

(gdb) print __libc_sigwait
$25 =3D {int (const sigset_t *, int *)} 0xffffbf128080 <__GI___sigwait>

----

Anyway, continuing.... I investigated the qemu_event_{set,reset,xxx}
logic. In non Linux OSes it uses pthread primitives, but, for Linux, it
uses a futex() implementation with a struct QemuEvent
(rcu_call_ready_event) being the one holding values (busy, set, free,
etc).

I got 2 hung situations:

(gdb) print (struct QemuEvent) *(0xaaaacd35fce8)
$16 =3D {
  value =3D 4294967295,
  initialized =3D true
}

value =3D 4294967295 -> THIS IS A 32-bit 0xFFFF (casting vs overflow issue
?)

AND

a situation where value was either 0 or 1 (like expected). In this last
situation I changed things by hand to make program to continue its
execution:

void qemu_event_wait(QemuEvent *ev)
{
    unsigned value;

    assert(ev->initialized);
    value =3D atomic_read(&ev->value);
    smp_mb_acquire();
    if (value !=3D EV_SET) {
        if (value =3D=3D EV_FREE) {

            if (atomic_cmpxchg(&ev->value, =

                       EV_FREE, EV_BUSY) =3D=3D EV_SET) {
                return;
            }
        }
        qemu_futex_wait(ev, EV_BUSY);
    }
}

438     in ./util/qemu-thread-posix.c
   0x0000aaaaaabd4174 <+44>:    mov     w1, #0xffffffff                 // =
#-1
   0x0000aaaaaabd4178 <+48>:    ldaxr   w0, [x19]
   0x0000aaaaaabd417c <+52>:    cmp     w0, #0x1
   0x0000aaaaaabd4180 <+56>:    b.ne    0xaaaaaabd418c <qemu_event_wait+68>=
  // b.any
=3D> 0x0000aaaaaabd4184 <+60>:    stlxr   w2, w1, [x19]
   0x0000aaaaaabd4188 <+64>:    cbnz    w2, 0xaaaaaabd4178 <qemu_event_wait=
+48>
   0x0000aaaaaabd418c <+68>:    cbz     w0, 0xaaaaaabd41cc <qemu_event_wait=
+132>
   0x0000aaaaaabd4190 <+72>:    mov     w6, #0x0                        // =
#0
   0x0000aaaaaabd4194 <+76>:    mov     x5, #0x0                        // =
#0
   0x0000aaaaaabd4198 <+80>:    mov     x4, #0x0                        // =
#0
   0x0000aaaaaabd419c <+84>:    mov     w3, #0xffffffff                 // =
#-1
   0x0000aaaaaabd41a0 <+88>:    mov     w2, #0x0                        // =
#0
   0x0000aaaaaabd41a4 <+92>:    mov     x1, x19
   0x0000aaaaaabd41a8 <+96>:    mov     x0, #0x62                       // =
#98
   0x0000aaaaaabd41ac <+100>:   bl      0xaaaaaaaff380 <syscall@plt>
   =

I unblocked it by hand, setting the program counter register to outside tha=
t logic:

(gdb) print qemu_event_wait+132
$15 =3D (void (*)(QemuEvent *)) 0xaaaaaabd41cc <qemu_event_wait+132>
(gdb) print rcu_call_ready_event
$16 =3D {value =3D 1, initialized =3D true}
(gdb) set rcu_call_ready_event->value=3D0
(gdb) set $pc=3D0xaaaaaabd41cc

And it got stuck again with program counter in other STLXR instruction:

(gdb) thread 2

[Switching to thread 2 (Thread 0xffffbec61d90 (LWP 33302))]
#0  0x0000aaaaaabd4110 in qemu_event_reset (ev=3D0xaaaaaac87ce8 <rcu_call_r=
eady_event>) at ./util/qemu-thread-posix.c:414
414     ./util/qemu-thread-posix.c: No such file or directory.
(gdb) bt
#0  0x0000aaaaaabd4110 in qemu_event_reset (ev=3D0xaaaaaac87ce8 <rcu_call_r=
eady_event>) at ./util/qemu-thread-posix.c:414
#1  0x0000aaaaaabedff8 in call_rcu_thread (opaque=3Dopaque@entry=3D0x0) at =
./util/rcu.c:255
#2  0x0000aaaaaabd34c8 in qemu_thread_start (args=3D<optimized out>) at ./u=
til/qemu-thread-posix.c:498
#3  0x0000ffffbf26a880 in start_thread (arg=3D0xfffffffff5bf) at pthread_cr=
eate.c:486
#4  0x0000ffffbf1c4b9c in thread_start () at ../sysdeps/unix/sysv/linux/aar=
ch64/clone.S:78

(gdb) print rcu_call_ready_event
$20 =3D {value =3D 1, initialized =3D true}

(gdb) disassemble qemu_event_reset
Dump of assembler code for function qemu_event_reset:
   0x0000aaaaaabd40f0 <+0>:     ldrb    w1, [x0, #4]
   0x0000aaaaaabd40f4 <+4>:     cbz     w1, 0xaaaaaabd411c <qemu_event_rese=
t+44>
   0x0000aaaaaabd40f8 <+8>:     ldr     w1, [x0]
   0x0000aaaaaabd40fc <+12>:    dmb     ishld
   0x0000aaaaaabd4100 <+16>:    cbz     w1, 0xaaaaaabd4108 <qemu_event_rese=
t+24>
   0x0000aaaaaabd4104 <+20>:    ret
   0x0000aaaaaabd4108 <+24>:    ldaxr   w1, [x0]
   0x0000aaaaaabd410c <+28>:    orr     w1, w1, #0x1
=3D> 0x0000aaaaaabd4110 <+32>:    stlxr   w2, w1, [x0]
   0x0000aaaaaabd4114 <+36>:    cbnz    w2, 0xaaaaaabd4108 <qemu_event_rese=
t+24>
   0x0000aaaaaabd4118 <+40>:    ret
   =

And it does not matter if I continue, CPU keeps stuck in that program count=
er (again in a STLXR instruction)

----

So, initially I was afraid that the lack barriers (or not so strong ones
being used) could have caused a race condition that would make one
thread to depend on the other thread logic.

Unfortunately it looks that instruction STLXR might not be behaving
appropriately for this CPU/architecture as program counter seem to be
stuck in the same instruction (which is super weird, by not throwing a
general exception for some microcode issue, for example).

But this was just an initial overview, I still have to revisit this in
order interpret results better (and recompile qemu with debugging data,
and possible with other GCC version).

Any comments are appreciated.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1805256

Title:
  qemu-img hangs on high core count ARM system

Status in QEMU:
  Confirmed
Status in qemu package in Ubuntu:
  In Progress

Bug description:
  On the HiSilicon D06 system - a 96 core NUMA arm64 box - qemu-img
  frequently hangs (~50% of the time) with this command:

  qemu-img convert -f qcow2 -O qcow2 /tmp/cloudimg /tmp/cloudimg2

  Where "cloudimg" is a standard qcow2 Ubuntu cloud image. This
  qcow2->qcow2 conversion happens to be something uvtool does every time
  it fetches images.

  Once hung, attaching gdb gives the following backtrace:

  (gdb) bt
  #0  0x0000ffffae4f8154 in __GI_ppoll (fds=3D0xaaaae8a67dc0, nfds=3D187650=
274213760, =

      timeout=3D<optimized out>, timeout@entry=3D0x0, sigmask=3D0xffffc123b=
950)
      at ../sysdeps/unix/sysv/linux/ppoll.c:39
  #1  0x0000aaaabbefaf00 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<o=
ptimized out>, =

      __fds=3D<optimized out>) at /usr/include/aarch64-linux-gnu/bits/poll2=
.h:77
  #2  qemu_poll_ns (fds=3D<optimized out>, nfds=3D<optimized out>, =

      timeout=3Dtimeout@entry=3D-1) at util/qemu-timer.c:322
  #3  0x0000aaaabbefbf80 in os_host_main_loop_wait (timeout=3D-1)
      at util/main-loop.c:233
  #4  main_loop_wait (nonblocking=3D<optimized out>) at util/main-loop.c:497
  #5  0x0000aaaabbe2aa30 in convert_do_copy (s=3D0xffffc123bb58) at qemu-im=
g.c:1980
  #6  img_convert (argc=3D<optimized out>, argv=3D<optimized out>) at qemu-=
img.c:2456
  #7  0x0000aaaabbe2333c in main (argc=3D7, argv=3D<optimized out>) at qemu=
-img.c:4975

  Reproduced w/ latest QEMU git (@ 53744e0a182)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1805256/+subscriptions

