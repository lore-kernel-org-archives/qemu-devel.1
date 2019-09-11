Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7350CC5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 19:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C89420838
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 19:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C89420838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelpath.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i88BK-00070l-HA
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 15:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i88Ac-0006YL-TP
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 15:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i88Ab-0005hc-3h
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 15:20:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:35194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i88Aa-0005hG-Rd
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 15:20:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i88AZ-0001dy-DJ
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 19:20:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5F9A12E80CD
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 19:20:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Sep 2019 19:09:25 -0000
From: Rafael David Tinoco <rafaeldtinoco@kernelpath.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=rafaeldtinoco@kernelpath.com; 
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
Message-Id: <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: bdce987cc9861213a13481a92478b9e26e071c9a
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1805256] Re: qemu_futex_wait() lockups in ARM64:
 2 possible issues
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
Message-ID: <20190911190925.0vp6QDpasMkAzWDbTLeEX3JzBiThyvtc21CnE4sHnh8@z>

> Zhengui's theory that notify_me doesn't work properly on ARM is more
> promising, but he couldn't provide a clear explanation of why he thought
> notify_me is involved.  In particular, I would have expected notify_me to
> be wrong if the qemu_poll_ns call came from aio_ctx_dispatch, for example:
> =

> =

>     glib_pollfds_fill
>       g_main_context_prepare
>         aio_ctx_prepare
>           atomic_or(&ctx->notify_me, 1)
>     qemu_poll_ns
>     glib_pollfds_poll
>       g_main_context_check
>         aio_ctx_check
>           atomic_and(&ctx->notify_me, ~1)
>       g_main_context_dispatch
>         aio_ctx_dispatch
>           /* do something for event */
>             qemu_poll_ns =

> =


Paolo,

I tried confining execution in a single NUMA domain (cpu & mem) and
still faced the issue, then, I added a mutex "ctx->notify_me_lcktest"
into context to protect "ctx->notify_me", like showed bellow, and it
seems to have either fixed or mitigated it.

I was able to cause the hung once every 3 or 4 runs. I have already ran
qemu-img convert more than 30 times now and couldn't reproduce it again.

Next step is to play with the barriers and check why existing ones
aren't enough for ordering access to ctx->notify_me ... or should I
try/do something else in your opinion ?

This arch/machine (Huawei D06):

$ lscpu
Architecture:        aarch64
Byte Order:          Little Endian
CPU(s):              96
On-line CPU(s) list: 0-95
Thread(s) per core:  1
Core(s) per socket:  48
Socket(s):           2
NUMA node(s):        4
Vendor ID:           0x48
Model:               0
Stepping:            0x0
CPU max MHz:         2000.0000
CPU min MHz:         200.0000
BogoMIPS:            200.00
L1d cache:           64K
L1i cache:           64K
L2 cache:            512K
L3 cache:            32768K
NUMA node0 CPU(s):   0-23
NUMA node1 CPU(s):   24-47
NUMA node2 CPU(s):   48-71
NUMA node3 CPU(s):   72-95
Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
cpuid asimdrdm dcpop

----

diff --git a/include/block/aio.h b/include/block/aio.h
index 0ca25dfec6..0724086d91 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -84,6 +84,7 @@ struct AioContext {
      * dispatch phase, hence a simple counter is enough for them.
      */
     uint32_t notify_me;
+    QemuMutex notify_me_lcktest;

     /* A lock to protect between QEMUBH and AioHandler adders and deleter,
      * and to ensure that no callbacks are removed while we're walking and
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 51c41ed3c9..031d6e2997 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -529,7 +529,9 @@ static bool run_poll_handlers(AioContext *ctx,
int64_t max_ns, int64_t *timeout)
     bool progress;
     int64_t start_time, elapsed_time;

+    qemu_mutex_lock(&ctx->notify_me_lcktest);
     assert(ctx->notify_me);
+    qemu_mutex_unlock(&ctx->notify_me_lcktest);
     assert(qemu_lockcnt_count(&ctx->list_lock) > 0);

     trace_run_poll_handlers_begin(ctx, max_ns, *timeout);
@@ -601,8 +603,10 @@ bool aio_poll(AioContext *ctx, bool blocking)
      * so disable the optimization now.
      */
     if (blocking) {
+        qemu_mutex_lock(&ctx->notify_me_lcktest);
         assert(in_aio_context_home_thread(ctx));
         atomic_add(&ctx->notify_me, 2);
+        qemu_mutex_unlock(&ctx->notify_me_lcktest);
     }

     qemu_lockcnt_inc(&ctx->list_lock);
@@ -647,8 +651,10 @@ bool aio_poll(AioContext *ctx, bool blocking)
     }

     if (blocking) {
+        qemu_mutex_lock(&ctx->notify_me_lcktest);
         atomic_sub(&ctx->notify_me, 2);
         aio_notify_accept(ctx);
+        qemu_mutex_unlock(&ctx->notify_me_lcktest);
     }

     /* Adjust polling time */
diff --git a/util/async.c b/util/async.c
index c10642a385..140e1e86f5 100644
--- a/util/async.c
+++ b/util/async.c
@@ -221,7 +221,9 @@ aio_ctx_prepare(GSource *source, gint    *timeout)
 {
     AioContext *ctx =3D (AioContext *) source;

+    qemu_mutex_lock(&ctx->notify_me_lcktest);
     atomic_or(&ctx->notify_me, 1);
+    qemu_mutex_unlock(&ctx->notify_me_lcktest);

     /* We assume there is no timeout already supplied */
     *timeout =3D qemu_timeout_ns_to_ms(aio_compute_timeout(ctx));
@@ -239,8 +241,10 @@ aio_ctx_check(GSource *source)
     AioContext *ctx =3D (AioContext *) source;
     QEMUBH *bh;

+    qemu_mutex_lock(&ctx->notify_me_lcktest);
     atomic_and(&ctx->notify_me, ~1);
     aio_notify_accept(ctx);
+    qemu_mutex_unlock(&ctx->notify_me_lcktest);

     for (bh =3D ctx->first_bh; bh; bh =3D bh->next) {
         if (bh->scheduled) {
@@ -346,11 +350,13 @@ void aio_notify(AioContext *ctx)
     /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
      * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
      */
-    smp_mb();
+    //smp_mb();
+    qemu_mutex_lock(&ctx->notify_me_lcktest);
     if (ctx->notify_me) {
         event_notifier_set(&ctx->notifier);
         atomic_mb_set(&ctx->notified, true);
     }
+    qemu_mutex_unlock(&ctx->notify_me_lcktest);
 }

 void aio_notify_accept(AioContext *ctx)
@@ -424,6 +430,8 @@ AioContext *aio_context_new(Error **errp)
     ctx->co_schedule_bh =3D aio_bh_new(ctx, co_schedule_bh_cb, ctx);
     QSLIST_INIT(&ctx->scheduled_coroutines);

+    qemu_rec_mutex_init(&ctx->notify_me_lcktest);
+
     aio_set_event_notifier(ctx, &ctx->notifier,
                            false,
                            (EventNotifierHandler *)

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

