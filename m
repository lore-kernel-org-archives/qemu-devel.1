Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E5ECE58D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87E920B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87E920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFh1-0005NE-8e
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iI78o-0005fO-F4
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iI78m-0001Kd-Ne
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:16:14 -0400
Received: from indium.canonical.com ([91.189.90.7]:51808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iI78m-0001KS-Hw
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:16:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iI78l-0004VG-6p
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 08:16:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 295462E8070
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 08:16:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Oct 2019 08:02:38 -0000
From: Jan Glauber <jglauber@marvell.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=kunpeng920; status=New; importance=Undecided;
 assignee=None; 
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
X-Launchpad-Bug-Modifier: Jan Glauber (jan-glauber-i)
References: <154327283728.15443.11625169757714443608.malonedeb@soybean.canonical.com>
Message-Id: <20191009080220.GA2905@hc>
Subject: [Bug 1805256] Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2
 possible issues
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="af2eefe214bd95389a09b7c956720881bab16807";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 3ae3824d3451fab4ecd42e8050746f0d6a55d34b
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
Message-ID: <20191009080238.IknEajmUdnZb-lWe5lRWD3jGiRbQYQUDL49l-WvoTwM@z>

On Mon, Oct 07, 2019 at 04:58:30PM +0200, Paolo Bonzini wrote:
> On 07/10/19 16:44, dann frazier wrote:
> > On Mon, Oct 07, 2019 at 01:06:20PM +0200, Paolo Bonzini wrote:
> >> On 02/10/19 11:23, Jan Glauber wrote:
> >>> I've looked into this on ThunderX2. The arm64 code generated for the
> >>> atomic_[add|sub] accesses of ctx->notify_me doesn't contain any
> >>> memory barriers. It is just plain ldaxr/stlxr.
> >>>
> >>> From my understanding this is not sufficient for SMP sync.
> >>>
> >>> If I read this comment correct:
> >>>
> >>>     void aio_notify(AioContext *ctx)
> >>>     {
> >>>         /* Write e.g. bh->scheduled before reading ctx->notify_me.  P=
airs
> >>>          * with atomic_or in aio_ctx_prepare or atomic_add in aio_pol=
l.
> >>>          */
> >>>         smp_mb();
> >>>         if (ctx->notify_me) {
> >>>
> >>> it points out that the smp_mb() should be paired. But as
> >>> I said the used atomics don't generate any barriers at all.
> >>
> >> Based on the rest of the thread, this patch should also fix the bug:
> >>
> >> diff --git a/util/async.c b/util/async.c
> >> index 47dcbfa..721ea53 100644
> >> --- a/util/async.c
> >> +++ b/util/async.c
> >> @@ -249,7 +249,7 @@ aio_ctx_check(GSource *source)
> >>      aio_notify_accept(ctx);
> >>  =

> >>      for (bh =3D ctx->first_bh; bh; bh =3D bh->next) {
> >> -        if (bh->scheduled) {
> >> +        if (atomic_mb_read(&bh->scheduled)) {
> >>              return true;
> >>          }
> >>      }
> >>
> >>
> >> And also the memory barrier in aio_notify can actually be replaced
> >> with a SEQ_CST load:
> >>
> >> diff --git a/util/async.c b/util/async.c
> >> index 47dcbfa..721ea53 100644
> >> --- a/util/async.c
> >> +++ b/util/async.c
> >> @@ -349,11 +349,11 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx)
> >>  =

> >>  void aio_notify(AioContext *ctx)
> >>  {
> >> -    /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
> >> -     * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
> >> +    /* Using atomic_mb_read ensures that e.g. bh->scheduled is writte=
n before
> >> +     * ctx->notify_me is read.  Pairs with atomic_or in aio_ctx_prepa=
re or
> >> +     * atomic_add in aio_poll.
> >>       */
> >> -    smp_mb();
> >> -    if (ctx->notify_me) {
> >> +    if (atomic_mb_read(&ctx->notify_me)) {
> >>          event_notifier_set(&ctx->notifier);
> >>          atomic_mb_set(&ctx->notified, true);
> >>      }
> >>
> >>
> >> Would you be able to test these (one by one possibly)?
> > =

> > Paolo,
> >   I tried them both separately and together on a Hi1620 system, each
> > time it hung in the first iteration. Here's a backtrace of a run with
> > both patches applied:
> =

> Ok, not a great start...  I'll find myself an aarch64 machine and look
> at it more closely.  I'd like the patch to be something we can
> understand and document, since this is probably the second most-used
> memory barrier idiom in QEMU.
> =

> Paolo

I'm still not sure what the actual issue is here, but could it be some bad
interaction between the notify_me and the list_lock? The are both 4 byte
and side-by-side:

address notify_me: 0xaaaadb528aa0  sizeof notify_me: 4
address list_lock: 0xaaaadb528aa4  sizeof list_lock: 4

AFAICS the generated code looks OK (all load/store exclusive done
with 32 bit size):

     e6c:       885ffc01        ldaxr   w1, [x0]
     e70:       11000821        add     w1, w1, #0x2
     e74:       8802fc01        stlxr   w2, w1, [x0]

...but if I bump notify_me size to uint64_t the issue goes away.

BTW, the image file I convert in the testcase is ~20 GB.

--Jan

diff --git a/include/block/aio.h b/include/block/aio.h
index a1d6b9e24939..e8a5ea3860bb 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -83,7 +83,7 @@ struct AioContext {
      * Instead, the aio_poll calls include both the prepare and the
      * dispatch phase, hence a simple counter is enough for them.
      */
-    uint32_t notify_me;
+    uint64_t notify_me;
 =

     /* A lock to protect between QEMUBH and AioHandler adders and deleter,
      * and to ensure that no callbacks are removed while we're walking and

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1805256

Title:
  qemu-img hangs on rcu_call_ready_event logic in Aarch64 when
  converting images

Status in kunpeng920:
  New
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
https://bugs.launchpad.net/kunpeng920/+bug/1805256/+subscriptions

