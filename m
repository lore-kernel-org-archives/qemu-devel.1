Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93DAC4740A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B4B20863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B4B20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelpath.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7h6d-0005nZ-Mv
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i7h5t-0005NW-4z
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i7h5r-0004bI-6a
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:26:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:43478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i7h5r-0004ag-0X
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:26:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i7h5n-00046V-L4
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 14:26:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 44D772E80D9
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 14:26:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Sep 2019 14:16:48 -0000
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
Message-Id: <156812500849.592.15082482903371865706.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8d6d35b99dcb9a9c56da5610f7671f84c14454fb
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

Alright, here is what is happening:

Whenever program is stuck, thread #2 backtrace is this:

(gdb) bt
#0  syscall () at ../sysdeps/unix/sysv/linux/aarch64/syscall.S:38
#1  0x0000aaaaaabd41b0 in qemu_futex_wait (val=3D<optimized out>, f=3D<opti=
mized out>) at ./util/qemu-thread-posix.c:438
#2  qemu_event_wait (ev=3Dev@entry=3D0xaaaaaac87ce8 <rcu_call_ready_event>)=
 at ./util/qemu-thread-posix.c:442
#3  0x0000aaaaaabee03c in call_rcu_thread (opaque=3Dopaque@entry=3D0x0) at =
./util/rcu.c:261
#4  0x0000aaaaaabd34c8 in qemu_thread_start (args=3D<optimized out>) at ./u=
til/qemu-thread-posix.c:498
#5  0x0000ffffbf26a880 in start_thread (arg=3D0xfffffffff5bf) at pthread_cr=
eate.c:486
#6  0x0000ffffbf1c4b9c in thread_start () at ../sysdeps/unix/sysv/linux/aar=
ch64/clone.S:78

Meaning that code is waiting for a futex inside kernel.

(gdb) print rcu_call_ready_event
$4 =3D {value =3D 4294967295, initialized =3D true}

The QemuEvent "rcu_call_ready_event->value" is set to INT_MAX and I
don't know why yet.

rcu_call_ready_event->value is only touched by:

qemu_event_init() -> bool init ? EV_SET : EV_FREE
qemu_event_reset() -> atomic_or(&ev->value, EV_FREE)
qemu_event_set() -> atomic_xchg(&ev->value, EV_SET)
qemu_event_wait() -> atomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY)'

And there should be no 0x7fff value for "ev->value".

qemu_event_init() is the one initializing the global:

    static QemuEvent rcu_call_ready_event;

and it is called by "rcu_init_complete()" which is called by
"rcu_init()":

    static void __attribute__((__constructor__)) rcu_init(void)

a constructor function.

So, "fixing" this issue by:

    (gdb) print rcu_call_ready_event
    $8 =3D {value =3D 4294967295, initialized =3D true}
    =

    (gdb) watch rcu_call_ready_event
    Hardware watchpoint 1: rcu_call_ready_event
    =

    (gdb) set rcu_call_ready_event.initialized =3D 1
    =

    (gdb) set rcu_call_ready_event.value =3D 0

and note that I added a watchpoint to rcu_call_ready_event global:

<HANG>

Thread 1 "qemu-img" received signal SIGINT, Interrupt.
(gdb) thread 2
[Switching to thread 2 (Thread 0xffffbec61d90 (LWP 33625))]

(gdb) bt
#0  0x0000aaaaaabd4110 in qemu_event_reset (ev=3Dev@entry=3D0xaaaaaac87ce8 =
<rcu_call_ready_event>)
#1  0x0000aaaaaabedff8 in call_rcu_thread (opaque=3Dopaque@entry=3D0x0) at =
./util/rcu.c:255
#2  0x0000aaaaaabd34c8 in qemu_thread_start (args=3D<optimized out>) at ./u=
til/qemu-thread-posix.c:498
#3  0x0000ffffbf26a880 in start_thread (arg=3D0xfffffffff5bf) at pthread_cr=
eate.c:486
#4  0x0000ffffbf1c4b9c in thread_start () at ../sysdeps/unix/sysv/linux/aar=
ch64/clone.S:78
(gdb) print rcu_call_ready_event
$9 =3D {value =3D 0, initialized =3D true}

You can see I advanced in the qemu_event_{reset,set,wait} logic.

    (gdb) disassemble /m 0x0000aaaaaabd4110
    Dump of assembler code for function qemu_event_reset:
    408     in ./util/qemu-thread-posix.c

    409     in ./util/qemu-thread-posix.c

    410     in ./util/qemu-thread-posix.c
    411     in ./util/qemu-thread-posix.c
       0x0000aaaaaabd40f0 <+0>:     ldrb    w1, [x0, #4]
       0x0000aaaaaabd40f4 <+4>:     cbz     w1, 0xaaaaaabd411c <qemu_event_=
reset+44>
       0x0000aaaaaabd411c <+44>:    stp     x29, x30, [sp, #-16]!
       0x0000aaaaaabd4120 <+48>:    adrp    x3, 0xaaaaaac20000
       0x0000aaaaaabd4124 <+52>:    add     x3, x3, #0x908
       0x0000aaaaaabd4128 <+56>:    mov     x29, sp
       0x0000aaaaaabd412c <+60>:    adrp    x1, 0xaaaaaac20000
       0x0000aaaaaabd4130 <+64>:    adrp    x0, 0xaaaaaac20000
       0x0000aaaaaabd4134 <+68>:    add     x3, x3, #0x290
       0x0000aaaaaabd4138 <+72>:    add     x1, x1, #0xc00
       0x0000aaaaaabd413c <+76>:    add     x0, x0, #0xd40
       0x0000aaaaaabd4140 <+80>:    mov     w2, #0x19b    // #411
       0x0000aaaaaabd4144 <+84>:    bl      0xaaaaaaaff190 <__assert_fail@p=
lt>

    412     in ./util/qemu-thread-posix.c
       0x0000aaaaaabd40f8 <+8>:     ldr     w1, [x0]

    413     in ./util/qemu-thread-posix.c
       0x0000aaaaaabd40fc <+12>:    dmb     ishld

    414     in ./util/qemu-thread-posix.c
       0x0000aaaaaabd4100 <+16>:    cbz     w1, 0xaaaaaabd4108 <qemu_event_=
reset+24>
       0x0000aaaaaabd4104 <+20>:    ret
       0x0000aaaaaabd4108 <+24>:    ldaxr   w1, [x0]
       0x0000aaaaaabd410c <+28>:    orr     w1, w1, #0x1
    =3D> 0x0000aaaaaabd4110 <+32>:    stlxr   w2, w1, [x0]
       0x0000aaaaaabd4114 <+36>:    cbnz    w2, 0xaaaaaabd4108 <qemu_event_=
reset+24>
       0x0000aaaaaabd4118 <+40>:    ret

And I'm currently inside the STLXR and LDAXR logic. To make sure my program=
 counter is advancing, I added a breakpoint at 0x0000aaaaaabd4108, so CBNZ =
instruction would branch indefinitely into LDXAR instruction again, until t=
he
LDAXR<->STLXR logic is satisfied (inside qemu_event_wait()).

(gdb) break *(0x0000aaaaaabd4108)
Breakpoint 2 at 0xaaaaaabd4108: file ./util/qemu-thread-posix.c, line 414.

which is basically this:

    if (value =3D=3D EV_SET) {                        EV_SET =3D=3D 0
        atomic_or(&ev->value, EV_FREE);           EV_FREE =3D 1
    }
    =

and we can see that this logic being called one time after another:

(gdb) c
Thread 2 "qemu-img" hit Breakpoint 3, 0x0000aaaaaabd4108 in qemu_event_rese=
t (
    ev=3Dev@entry=3D0xaaaaaac87ce8 <rcu_call_ready_event>) at ./util/qemu-t=
hread-posix.c:414

(gdb) c
Thread 2 "qemu-img" hit Breakpoint 3, 0x0000aaaaaabd4108 in qemu_event_rese=
t (
    ev=3Dev@entry=3D0xaaaaaac87ce8 <rcu_call_ready_event>) at ./util/qemu-t=
hread-posix.c:414
    =

(gdb) c
Thread 2 "qemu-img" hit Breakpoint 3, 0x0000aaaaaabd4108 in qemu_event_rese=
t (
    ev=3Dev@entry=3D0xaaaaaac87ce8 <rcu_call_ready_event>) at ./util/qemu-t=
hread-posix.c:414

EVEN when rcu_call_ready_event->value is already EV_SET (0):

(gdb) print rcu_call_ready_event
$11 =3D {value =3D 0, initialized =3D true}

(gdb) info break
Num     Type           Disp Enb Address            What
1       hw watchpoint  keep y                      rcu_call_ready_event
3       breakpoint     keep n   0x0000aaaaaabd4108 qemu-thread-posix.c:414
        breakpoint already hit 23 times
4       breakpoint     keep y   0x0000aaaaaabd4148 qemu-thread-posix.c:424

IF I enable only rcu_call_ready_event HW watchpoint, nothing is
triggered.

(gdb) watch *(rcu_call_ready_event->value)
Hardware watchpoint 6: *(rcu_call_ready_event->value)

not if I set it directly to QemuEvent->value...

    assert(ev->initialized);
    value =3D atomic_read(&ev->value);
    smp_mb_acquire();
    if (value =3D=3D EV_SET) {
        atomic_or(&ev->value, EV_FREE);
    }

meaning that "value" and "ev->value" might have a diff value... is that
so ?

(gdb) print value
$14 =3D <optimized out>

can't say.. checking registers AND stack:

       0x0000aaaaaabd4100 <+16>:    cbz     w1, 0xaaaaaabd4108 <qemu_event_=
reset+24>
       0x0000aaaaaabd4104 <+20>:    ret
       0x0000aaaaaabd4108 <+24>:    ldaxr   w1, [x0]
       0x0000aaaaaabd410c <+28>:    orr     w1, w1, #0x1
    =3D> 0x0000aaaaaabd4110 <+32>:    stlxr   w2, w1, [x0]
       0x0000aaaaaabd4114 <+36>:    cbnz    w2, 0xaaaaaabd4108 =

       =


x0             0xaaaaaac87ce8      187649986428136
x1             0x1                 1
x2             0x1                 1
x3             0x0                 0
x4             0xffffbec61e98      281473882398360
x5             0xffffbec61c90      281473882397840
x6             0xffffbec61c90      281473882397840
x7             0x1                 1
x8             0x65                101
x9             0x0                 0
x10            0x0                 0
x11            0x0                 0
x12            0xffffbec61d90      281473882398096
x13            0x0                 0
x14            0x0                 0
x15            0x2                 2
x16            0xffffbf67ccf0      281473892994288
x17            0xffffbf274938      281473888766264
x18            0x23f               575
x19            0x0                 0
x20            0xaaaaaac87ce8      187649986428136
x21            0x0                 0
x22            0xfffffffff5bf      281474976708031
x23            0xaaaaaac87ce0      187649986428128
x24            0xaaaaaac29000      187649986039808
x25            0xfffffffff658      281474976708184
x26            0x1000              4096
x27            0xffffbf28c000      281473888862208
x28            0xffffbec61d90      281473882398096
x29            0xffffbec61420      281473882395680
x30            0xaaaaaabedff8      187649985798136
sp             0xffffbec61420      0xffffbec61420
pc             0xaaaaaabd4110      0xaaaaaabd4110 <qemu_event_reset+32>
cpsr           0x0                 [ EL=3D0 ]
fpsr           0x0                 0
fpcr           0x0                 0

AND the ORR instruction is ALWAYS being executed against 0x1 (not 0x0,
which is what I just changed by changing .value):

(gdb) print value
$14 =3D <optimized out>

       0x0000aaaaaabd410c <+28>:    orr     w1, w1, #0x1
       =

#0x1 is being used instead of contents of "value" local variable (volatile).

I'll recompile QEMU flagging all those local "unsigned value" variables
as being volatile and check if optimization changes. Or even try to
disable optimizations.

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

