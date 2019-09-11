Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5C6ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C7262089F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7262089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelpath.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47291 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wu6-0003ku-Fk
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i7wrT-0001gZ-Mp
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i7wrS-0001AR-D5
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:16:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:46138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i7wrS-00018x-84
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:16:18 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i7wrP-0001Uj-Oz
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 07:16:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BA98C2E80C9
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 07:16:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Sep 2019 07:05:41 -0000
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
 <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
Message-Id: <c3bf1a4e-4fa7-2c13-35fb-f63429ee39d1@ubuntu.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: cd93aa51b4b635f8069961ed2ce2552153499142
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
Message-ID: <20190911070541.6tcAZSFPvX65xG3PVMKNiEoddDsHwCBryx90bqLKwlI@z>

Quick update...

> value INT_MAX (4294967295) seems WRONG for qemu_futex_wait():
> =

> - EV_BUSY, being -1, and passed as an argument qemu_futex_wait(void *,
> unsigned), is a two's complement, making argument into a INT_MAX when
> that's not what is expected (unless I missed something).
> =

> *** If that is the case, unsure if you, Paolo, prefer declaring
> *(QemuEvent)->value as an integer or changing EV_BUSY to "2" would okay
> here ***
> =

> BUG: description:
> https://bugs.launchpad.net/qemu/+bug/1805256/comments/15

I realized this might be intentional, but, still, I tried:

    https://pastebin.ubuntu.com/p/6rkkY6fJdm/

looking for anything that could have misbehaved in arm64 (specially
concerned on casting and type conversions between the functions).

> QUESTION:
> =

> - Should qemu_event_set() check return code from
> qemu_futex_wake()->qemu_futex()->syscall() in order to know if ANY
> waiter was ever woken up ? Maybe even loop until at least 1 is awaken ?

And I also tried:

-    qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);
+    while(qemu_futex(pval, FUTEX_WAKE, val, NULL, NULL, 0) =3D=3D 0)
+        continue;

and it made little difference (took way more time for me to reproduce
the issue though):

"""
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

I'll try to check why those tasks exited.

Any thoughts ?

Tks

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

