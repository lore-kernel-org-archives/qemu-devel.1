Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2623FC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 23:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FB32168B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 23:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FB32168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelpath.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7pDP-0008TC-2R
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 19:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i7pCk-00082K-AK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i7pCi-00043h-VE
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:05:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:49854)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i7pCi-00043J-Q8
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:05:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i7pCh-0004x3-Iz
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 23:05:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8472E2E80C7
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 23:05:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Sep 2019 22:56:25 -0000
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
Message-Id: <156815618548.28851.17824681639308053537.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 719fd923f2e97334970026e795d638a82c75011e
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1805256] Re: qemu-img hangs on
 rcu_call_ready_event logic in Aarch64 when converting images
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

QEMU BUG: #1

Alright, one of the issues is (according to comment #14):

"""
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
"""

Now I know why rcu_call_ready_event->value is set to INT_MAX. That is
because in the following declaration:

struct QemuEvent {
#ifndef __linux__
    pthread_mutex_t lock;
    pthread_cond_t cond;
#endif
    unsigned value;
    bool initialized;
};

#define EV_SET         0
#define EV_FREE        1
#define EV_BUSY       -1

"value" is declared as unsigned, but EV_BUSY sets it to -1, and,
according to the Two's Complement Operation
(https://en.wikipedia.org/wiki/Two%27s_complement), it will be INT_MAX
(4294967295).

So this is the "first bug" found AND it is definitely funny that this
hasn't been seen in other architectures at all... I can reproduce it at
will.

With that said, it seems that there is still another issue causing (less
frequently):

(gdb) thread 2
[Switching to thread 2 (Thread 0xffffbec5ad90 (LWP 17459))]
#0  syscall () at ../sysdeps/unix/sysv/linux/aarch64/syscall.S:38
38      ../sysdeps/unix/sysv/linux/aarch64/syscall.S: No such file or direc=
tory.
(gdb) bt
#0  syscall () at ../sysdeps/unix/sysv/linux/aarch64/syscall.S:38
#1  0x0000aaaaaabd41cc in qemu_futex_wait (val=3D<optimized out>, f=3D<opti=
mized out>) at ./util/qemu-thread-posix.c:438
#2  qemu_event_wait (ev=3Dev@entry=3D0xaaaaaac86ce8 <rcu_call_ready_event>)=
 at ./util/qemu-thread-posix.c:442
#3  0x0000aaaaaabed05c in call_rcu_thread (opaque=3Dopaque@entry=3D0x0) at =
./util/rcu.c:261
#4  0x0000aaaaaabd34c8 in qemu_thread_start (args=3D<optimized out>) at ./u=
til/qemu-thread-posix.c:498
#5  0x0000ffffbf25c880 in start_thread (arg=3D0xfffffffff5bf) at pthread_cr=
eate.c:486
#6  0x0000ffffbf1b6b9c in thread_start () at ../sysdeps/unix/sysv/linux/aar=
ch64/clone.S:78

Thread 2 to be stuck at "futex()" kernel syscall (like the FUTEX_WAKE
never happened and/or wasn't atomic for this arch/binary). Need to
investigate this also.

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

