Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158B4C49ED9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 02:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF7152168B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 02:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7152168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelpath.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7sLF-00071W-Uj
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 22:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i7sKC-0006CA-K6
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 22:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i7sKB-0000RJ-96
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 22:25:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:40292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i7sKB-0000Qk-3s
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 22:25:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i7sK9-0001I2-4U
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 02:25:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1EC5E2E80CC
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 02:25:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Sep 2019 02:15:00 -0000
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
Message-Id: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 326280af9e9fe57bd29bf2e0a4e30ed70287dafa
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1805256] qemu_futex_wait() lockups in ARM64: 2
 possible issues
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
Message-ID: <20190911021500.TfpxfkCK7Tz0gt8F42I0ZKHO2C-jnpk7YiOhTf4GeSM@z>

Paolo,

While debugging hungs in ARM64 while doing a simple:

qemu-img convert -f qcow2 -O qcow2 file.qcow2 output.qcow2

I might have found 2 issues which I'd like you to review, if possible.

ISSUE #1
=3D=3D=3D=3D=3D=3D=3D=3D

I've caught the following stack trace after an HUNG in qemu-img convert:

(gdb) bt
#0 syscall ()
#1 0x0000aaaaaabd41cc in qemu_futex_wait
#2 qemu_event_wait (ev=3Dev@entry=3D0xaaaaaac86ce8 <rcu_call_ready_event>)
#3 0x0000aaaaaabed05c in call_rcu_thread
#4 0x0000aaaaaabd34c8 in qemu_thread_start
#5 0x0000ffffbf25c880 in start_thread
#6 0x0000ffffbf1b6b9c in thread_start ()

(gdb) print rcu_call_ready_event
$4 =3D {value =3D 4294967295, initialized =3D true}

value INT_MAX (4294967295) seems WRONG for qemu_futex_wait():

- EV_BUSY, being -1, and passed as an argument qemu_futex_wait(void *,
unsigned), is a two's complement, making argument into a INT_MAX when
that's not what is expected (unless I missed something).

*** If that is the case, unsure if you, Paolo, prefer declaring
*(QemuEvent)->value as an integer or changing EV_BUSY to "2" would okay
here ***

BUG: description:
https://bugs.launchpad.net/qemu/+bug/1805256/comments/15

=3D=3D=3D=3D=3D=3D=3D=3D
ISSUE #2
=3D=3D=3D=3D=3D=3D=3D=3D

I found this when debugging lockups while in futex() in a specific ARM64
server - https://bugs.launchpad.net/qemu/+bug/1805256 - which I'm still
investigating.

After fixing the issue above, I'm still getting stuck into:

qemu_event_wait() -> qemu_futex_wait()

***
As if qemu_event_set() has ran before qemu_futex_wait() ever started running
***

The Other threads are waiting for poll() on a PIPE coming from this
stuck thread (thread #1), and in sigwait():

(gdb) thread 1
...
(gdb) bt
#0  0x0000ffffbf1ad81c in __GI_ppoll
#1  0x0000aaaaaabcf73c in ppoll
#2  qemu_poll_ns
#3  0x0000aaaaaabd0764 in os_host_main_loop_wait
#4  main_loop_wait
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
#0  0x0000ffffbf11aa20 in __GI___sigtimedwait
#1  0x0000ffffbf2671b4 in __sigwait
#2  0x0000aaaaaabd1ddc in sigwait_compat
#3  0x0000aaaaaabd34c8 in qemu_thread_start
#4  0x0000ffffbf25c880 in start_thread
#5  0x0000ffffbf1b6b9c in thread_start

QUESTION:

- Should qemu_event_set() check return code from
qemu_futex_wake()->qemu_futex()->syscall() in order to know if ANY
waiter was ever woken up ? Maybe even loop until at least 1 is awaken ?

Tks in advance,

Rafael D. Tinoco

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

