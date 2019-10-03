Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616EDC32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253DB20862
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253DB20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelpath.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG0Np-0008Bg-D6
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 08:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iG0LK-0005Xh-B7
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iG0LI-0005G9-Bq
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:36:26 -0400
Received: from indium.canonical.com ([91.189.90.7]:46680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iG0LH-0005EX-0A
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:36:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iG0LF-0002Ls-Ig
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 12:36:21 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 85CA32E80C9
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 12:36:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Oct 2019 12:29:00 -0000
From: Rafael David Tinoco <rafaeldtinoco@kernelpath.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=rafaeldtinoco@kernelpath.com; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=In Progress; importance=Medium; assignee=rafaeldtinoco@kernelpath.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=bionic; sourcepackage=qemu; 
 component=main; status=New; importance=Medium; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=disco; sourcepackage=qemu; 
 component=main; status=New; importance=Medium; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=eoan; sourcepackage=qemu;
 component=main; status=In Progress; importance=Medium;
 assignee=rafaeldtinoco@kernelpath.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=ff-series;
 sourcepackage=qemu; component=None; status=New; importance=Medium;
 assignee=None; 
X-Launchpad-Bug-Tags: qemu-img
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dannf jan-glauber-i jnsnow lizhengui rafaeldtinoco
X-Launchpad-Bug-Reporter: dann frazier (dannf)
X-Launchpad-Bug-Modifier: Rafael David Tinoco (rafaeldtinoco)
References: <154327283728.15443.11625169757714443608.malonedeb@soybean.canonical.com>
Message-Id: <157010574006.20314.3695722982511199374.malone@soybean.canonical.com>
Subject: [Bug 1805256] Re: qemu-img hangs on rcu_call_ready_event logic in
 Aarch64 when converting images
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19066";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b35846a92988efbf4926b72bc8fcbf163e39f60c
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
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

On Wed, 2019-10-02 at 15:20 +0200, Paolo Bonzini wrote:
> On 02/10/19 13:05, Jan Glauber wrote:
>> The arm64 code generated for the
>> atomic_[add|sub] accesses of ctx->notify_me doesn't contain any
>> memory barriers. It is just plain ldaxr/stlxr.
>>
>> From my understanding this is not sufficient for SMP sync.
>>
>>>> If I read this comment correct:
>>>>
>>>>     void aio_notify(AioContext *ctx)
>>>>     {
>>>>         /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pa=
irs
>>>>          * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
>>>>          */
>>>>         smp_mb();
>>>>         if (ctx->notify_me) {
>>>>
>>>> it points out that the smp_mb() should be paired. But as
>>>> I said the used atomics don't generate any barriers at all.
>>>
>>> Awesome!  That would be a compiler bug though, as atomic_add and atomic=
_sub
>>> are defined as sequentially consistent:
>>>
>>> #define atomic_add(ptr, n) ((void) __atomic_fetch_add(ptr, n, __ATOMIC_=
SEQ_CST))
>>> #define atomic_sub(ptr, n) ((void) __atomic_fetch_sub(ptr, n, __ATOMIC_=
SEQ_CST))
>>
>> Compiler bug sounds kind of unlikely...
>
> Indeed the assembly produced by the compiler matches for example the
> mappings at https://www.cl.cam.ac.uk/~pes20/cpp/cpp0xmappings.html.  A
> small testcase is as follows:
>
>   int ctx_notify_me;
>   int bh_scheduled;
>
>   int x()
>   {
>       int one =3D 1;
>       int ret;
>       __atomic_store(&bh_scheduled, &one, __ATOMIC_RELEASE);     // x1
>       __atomic_thread_fence(__ATOMIC_SEQ_CST);                   // x2
>       __atomic_load(&ctx_notify_me, &ret, __ATOMIC_RELAXED);     // x3
>       return ret;
>   }
>
>   int y()
>   {
>       int ret;
>       __atomic_fetch_add(&ctx_notify_me, 2, __ATOMIC_SEQ_CST);  // y1
>       __atomic_load(&bh_scheduled, &ret, __ATOMIC_RELAXED);     // y2
>       return ret;
>   }
>
> Here y (which is aio_poll) wants to order the write to ctx->notify_me
> before reads of bh->scheduled.  However, the processor can speculate the
> load of bh->scheduled between the load-acquire and store-release of
> ctx->notify_me.  So you can have something like:
>
>  thread 0 (y)                          thread 1 (x)
>  -----------------------------------   -----------------------------
>  y1: load-acq ctx->notify_me
>  y2: load-rlx bh->scheduled
>                                        x1: store-rel bh->scheduled <-- 1
>                                        x2: memory barrier
>                                        x3: load-rlx ctx->notify_me
>  y1: store-rel ctx->notify_me <-- 2
>
> Being very puzzled, I tried to put this into cppmem:
>
>   int main() {
>     atomic_int ctx_notify_me =3D 0;
>     atomic_int bh_scheduled =3D 0;
>     {{{ {
>           bh_scheduled.store(1, mo_release);
>           atomic_thread_fence(mo_seq_cst);
>           // must be zero since the bug report shows no notification
>           ctx_notify_me.load(mo_relaxed).readsvalue(0);
>         }
>     ||| {
>           ctx_notify_me.store(2, mo_seq_cst);
>           r2=3Dbh_scheduled.load(mo_relaxed);
>         }
>     }}};
>     return 0;
>   }
>
> and much to my surprise, the tool said r2 *can* be 0.  Same if I put a
> CAS like
>
>         cas_strong_explicit(ctx_notify_me.readsvalue(0), 0, 2,
>                             mo_seq_cst, mo_seq_cst);
>
> which resembles the code in the test case a bit more.

This example looks like Dekker synchronization (if I get the intent
right).

Two possible implementations of this are either (1) with all memory
accesses having seq-cst MO, or (2) with relaxed-MO accesses and seq-cst
fences on between the store and load on both ends.  It's possible to mix
both, but that get's trickier I think.  I'd prefer the one with just
fences, just because it's easiest, conceptually.

> I then found a discussion about using the C11 memory model in Linux
> (https://gcc.gnu.org/ml/gcc/2014-02/msg00058.html) which contains the
> following statement, which is a bit disheartening even though it is
> about a different test:
>
>    My first gut feeling was that the assertion should never fire, but
>    that was wrong because (as I seem to usually forget) the seq-cst
>    total order is just a constraint but doesn't itself contribute
>    to synchronizes-with -- but this is different for seq-cst fences.

It works if you use (1) or (2) consistently.  cppmem and the Batty et al.
tech report should give you the gory details.
My comment is just about seq-cst working differently on memory accesses vs.
fences (in the way it's specified in the memory model).

> and later in the thread:
>
>    Use of C11 atomics to implement Linux kernel atomic operations
>    requires knowledge of the underlying architecture and the compiler's
>    implementation, as was noted earlier in this thread.
>
> Indeed if I add an atomic_thread_fence I get only one valid execution,
> where r2 must be 1.  This is similar to GCC's bug
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D65697, and we can fix it in
> QEMU by using __sync_fetch_and_add; in fact cppmem also shows one valid
> execution if the store is replaced with something like GCC's assembly
> for __sync_fetch_and_add (or Linux's assembly for atomic_add_return):
>
>         cas_strong_explicit(ctx_notify_me.readsvalue(0), 0, 2,
>                             mo_release, mo_release);
>         atomic_thread_fence(mo_seq_cst);
>
> So we should:
>
> 1) understand why ATOMIC_SEQ_CST is not enough in this case.  QEMU code
> seems to be making the same assumptions as Linux about the memory model,
> and this is wrong because QEMU uses C11 atomics if available.
> Fortunately, this kind of synchronization in QEMU is relatively rare and
> only this particular bit seems affected.  If there is a fix which stays
> within the C11 memory model, and does not pessimize code on x86, we can
> use it[1] and document the pitfall.

Using the fences between the store/load pairs in Dekker-like
synchronization should do that, right?  It's also relatively easy to deal
with.

> 2) if there's no way to fix the bug, qemu/atomic.h needs to switch to
> __sync_fetch_and_add and friends.  And again, in this case the
> difference between the C11 and Linux/QEMU memory models must be documente=
d.

I surely not aware of all the constraints here, but I'd be surprised if the
C11 memory model isn't good enough for portable synchronization code (with
the exception of the consume MO minefield, perhaps).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1805256

Title:
  qemu-img hangs on rcu_call_ready_event logic in Aarch64 when
  converting images

Status in QEMU:
  In Progress
Status in qemu package in Ubuntu:
  In Progress
Status in qemu source package in Bionic:
  New
Status in qemu source package in Disco:
  New
Status in qemu source package in Eoan:
  In Progress
Status in qemu source package in FF-Series:
  New

Bug description:
  Command:

  qemu-img convert -f qcow2 -O qcow2 ./disk01.qcow2 ./output.qcow2

  Hangs indefinitely approximately 30% of the runs.

  ----

  Workaround:

  qemu-img convert -m 1 -f qcow2 -O qcow2 ./disk01.qcow2 ./output.qcow2

  Run "qemu-img convert" with "a single coroutine" to avoid this issue.

  ----

  (gdb) thread 1
  ...
  (gdb) bt
  #0 0x0000ffffbf1ad81c in __GI_ppoll
  #1 0x0000aaaaaabcf73c in ppoll
  #2 qemu_poll_ns
  #3 0x0000aaaaaabd0764 in os_host_main_loop_wait
  #4 main_loop_wait
  ...

  (gdb) thread 2
  ...
  (gdb) bt
  #0 syscall ()
  #1 0x0000aaaaaabd41cc in qemu_futex_wait
  #2 qemu_event_wait (ev=3Dev@entry=3D0xaaaaaac86ce8 <rcu_call_ready_event>)
  #3 0x0000aaaaaabed05c in call_rcu_thread
  #4 0x0000aaaaaabd34c8 in qemu_thread_start
  #5 0x0000ffffbf25c880 in start_thread
  #6 0x0000ffffbf1b6b9c in thread_start ()

  (gdb) thread 3
  ...
  (gdb) bt
  #0 0x0000ffffbf11aa20 in __GI___sigtimedwait
  #1 0x0000ffffbf2671b4 in __sigwait
  #2 0x0000aaaaaabd1ddc in sigwait_compat
  #3 0x0000aaaaaabd34c8 in qemu_thread_start
  #4 0x0000ffffbf25c880 in start_thread
  #5 0x0000ffffbf1b6b9c in thread_start

  ----

  (gdb) run
  Starting program: /usr/bin/qemu-img convert -f qcow2 -O qcow2
  ./disk01.ext4.qcow2 ./output.qcow2

  [New Thread 0xffffbec5ad90 (LWP 72839)]
  [New Thread 0xffffbe459d90 (LWP 72840)]
  [New Thread 0xffffbdb57d90 (LWP 72841)]
  [New Thread 0xffffacac9d90 (LWP 72859)]
  [New Thread 0xffffa7ffed90 (LWP 72860)]
  [New Thread 0xffffa77fdd90 (LWP 72861)]
  [New Thread 0xffffa6ffcd90 (LWP 72862)]
  [New Thread 0xffffa67fbd90 (LWP 72863)]
  [New Thread 0xffffa5ffad90 (LWP 72864)]

  [Thread 0xffffa5ffad90 (LWP 72864) exited]
  [Thread 0xffffa6ffcd90 (LWP 72862) exited]
  [Thread 0xffffa77fdd90 (LWP 72861) exited]
  [Thread 0xffffbdb57d90 (LWP 72841) exited]
  [Thread 0xffffa67fbd90 (LWP 72863) exited]
  [Thread 0xffffacac9d90 (LWP 72859) exited]
  [Thread 0xffffa7ffed90 (LWP 72860) exited]

  <HUNG w/ 3 threads in the stack trace showed before>
  """

  All the tasks left are blocked in a system call, so no task left to call
  qemu_futex_wake() to unblock thread #2 (in futex()), which would unblock
  thread #1 (doing poll() in a pipe with thread #2).

  Those 7 threads exit before disk conversion is complete (sometimes in
  the beginning, sometimes at the end).

  ----

  [ Original Description ]

  On the HiSilicon D06 system - a 96 core NUMA arm64 box - qemu-img
  frequently hangs (~50% of the time) with this command:

  qemu-img convert -f qcow2 -O qcow2 /tmp/cloudimg /tmp/cloudimg2

  Where "cloudimg" is a standard qcow2 Ubuntu cloud image. This
  qcow2->qcow2 conversion happens to be something uvtool does every time
  it fetches images.

  Once hung, attaching gdb gives the following backtrace:

  (gdb) bt
  #0  0x0000ffffae4f8154 in __GI_ppoll (fds=3D0xaaaae8a67dc0, nfds=3D187650=
274213760,
  =C2=A0=C2=A0=C2=A0=C2=A0timeout=3D<optimized out>, timeout@entry=3D0x0, s=
igmask=3D0xffffc123b950)
  =C2=A0=C2=A0=C2=A0=C2=A0at ../sysdeps/unix/sysv/linux/ppoll.c:39
  #1  0x0000aaaabbefaf00 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<o=
ptimized out>,
  =C2=A0=C2=A0=C2=A0=C2=A0__fds=3D<optimized out>) at /usr/include/aarch64-=
linux-gnu/bits/poll2.h:77
  #2  qemu_poll_ns (fds=3D<optimized out>, nfds=3D<optimized out>,
  =C2=A0=C2=A0=C2=A0=C2=A0timeout=3Dtimeout@entry=3D-1) at util/qemu-timer.=
c:322
  #3  0x0000aaaabbefbf80 in os_host_main_loop_wait (timeout=3D-1)
  =C2=A0=C2=A0=C2=A0=C2=A0at util/main-loop.c:233
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

