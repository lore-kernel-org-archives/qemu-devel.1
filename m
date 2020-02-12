Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4B8C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 04:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C9920842
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 04:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C9920842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1jDk-0001xn-T3
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 23:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j1jCn-0001Nl-Vb
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 23:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j1jCl-0000dL-I9
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 23:00:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:47150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j1jCl-0000bP-CA
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 23:00:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j1jCj-000601-Mp
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 04:00:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A78A42E80C3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 04:00:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Feb 2020 03:54:57 -0000
From: JZ <1862874@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: joshuazhu
X-Launchpad-Bug-Reporter: JZ (joshuazhu)
X-Launchpad-Bug-Modifier: JZ (joshuazhu)
Message-Id: <158147969798.15014.16243548781914826913.malonedeb@soybean.canonical.com>
Subject: [Bug 1862874] [NEW] java may stuck for a long time in system mode
 with "-cpu max"
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: fd0c68cdd762c0d9a90d8722ee7b93cc9249fd3f
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Bug 1862874 <1862874@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Bug Description:
Run "java -version" in guest VM, java may stuck for a long time (several ho=
urs) and then recover.

Steps to reproduce:
1. Launch VM by attached simple script: launch.sh
2. Execute "java -version" and then print "date" in a loop
    while :
    do
      /home/bot/jdk/bin/java -version
      date
    done
3. A long time gap will be observed: may > 24 hours.

Technical details:
* host: x86_64 Linux 4.15.0-70-generic
* qemu v4.2.0
* java: tried two versions: openjdk-11-jre-headless or compiled java-13 =

* command-line: (See details in launch.sh)
/home/bot/qemu/qemu-build/qemu-4.2.0/binaries/bin/qemu-system-x86_64 \
  -drive "file=3D${img},format=3Dqcow2" \
  -drive "file=3D${user_data},format=3Draw" \
  -cpu max \
  -m 24G \
  -serial mon:stdio \
  -smp 8 \
  -nographic \
;

* Observed by java core dump generated by "kill -SIGSEGV" when java stucked:
Different pthreads are blocked on their own condition variables:

  Id   Target Id         Frame
  1    Thread 0x7f48a041a080 (LWP 22470) __GI_raise (sig=3Dsig@entry=3D6)
    at ../sysdeps/unix/sysv/linux/raise.c:51
  2    Thread 0x7f487197d700 (LWP 22473) 0x00007f489f5c49f3 in futex_wait_c=
ancelable (private=3D<optimized out>, expected=3D0, futex_word=3D0x7f489801=
97c0)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
  3    Thread 0x7f4861b89700 (LWP 22483) 0x00007f489f5c4ed9 in futex_reltim=
ed_wait_cancelable (private=3D<optimized out>, reltime=3D0x7f4861b88960, ex=
pected=3D0,
    futex_word=3D0x7f489801b084)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:142
  4    Thread 0x7f4861e8c700 (LWP 22480) 0x00007f489f5c76d6 in futex_abstim=
ed_wait_cancelable (private=3D0, abstime=3D0x0, expected=3D0, futex_word=3D=
0x7f48980107c0)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:205
  5    Thread 0x7f4861c8a700 (LWP 22482) 0x00007f489f5c4ed9 in futex_reltim=
ed_wait_cancelable (private=3D<optimized out>, reltime=3D0x7f4861c89800, ex=
pected=3D0,
    futex_word=3D0x7f489801ed44)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:142
  6    Thread 0x7f48a0418700 (LWP 22471) 0x00007f4880b13200 in ?? ()
  7    Thread 0x7f48703ea700 (LWP 22478) 0x00007f489f5c49f3 in futex_wait_c=
ancelable (private=3D<optimized out>, expected=3D0, futex_word=3D0x7f489801=
dfc0)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
  8    Thread 0x7f48702e9700 (LWP 22479) 0x00007f489f5c49f3 in futex_wait_c=
ancelable (private=3D<optimized out>, expected=3D0, futex_word=3D0x7f489838=
cd84)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
  9    Thread 0x7f4870f71700 (LWP 22475) 0x00007f489f5c49f3 in futex_wait_c=
ancelable (private=3D<optimized out>, expected=3D0, futex_word=3D0x7f489801=
a300)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
  10   Thread 0x7f487187b700 (LWP 22474) 0x00007f489f5c76d6 in futex_abstim=
ed_wait_cancelable (private=3D0, abstime=3D0x0, expected=3D0, futex_word=3D=
0x7f48980cf770)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:205
  11   Thread 0x7f4871a7f700 (LWP 22472) 0x00007f489f5c76d6 in futex_abstim=
ed_wait_cancelable (private=3D0, abstime=3D0x0, expected=3D0, futex_word=3D=
0x7f489809ba30)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:205
  12   Thread 0x7f4861d8b700 (LWP 22481) 0x00007f489f5c4ed9 in futex_reltim=
ed_wait_cancelable (private=3D<optimized out>, reltime=3D0x7f4861d8a680, ex=
pected=3D0,
    futex_word=3D0x7f489801ed44)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:142
  13   Thread 0x7f48704ec700 (LWP 22477) 0x00007f489f5c4ed9 in futex_reltim=
ed_wait_cancelable (private=3D<optimized out>, reltime=3D0x7f48704eb910, ex=
pected=3D0,
    futex_word=3D0x7f489801d120)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:142
  14   Thread 0x7f4870e6f700 (LWP 22476) 0x00007f489f5c4ed9 in futex_reltim=
ed_wait_cancelable (private=3D<optimized out>, reltime=3D0x7f4870e6eb20, ex=
pected=3D0,
    futex_word=3D0x7f489828abd0)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:142

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "Launch guest VM"
   https://bugs.launchpad.net/bugs/1862874/+attachment/5327528/+files/launc=
h.sh

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1862874

Title:
  java may stuck for a long time in system mode with "-cpu max"

Status in QEMU:
  New

Bug description:
  Bug Description:
  Run "java -version" in guest VM, java may stuck for a long time (several =
hours) and then recover.

  Steps to reproduce:
  1. Launch VM by attached simple script: launch.sh
  2. Execute "java -version" and then print "date" in a loop
      while :
      do
        /home/bot/jdk/bin/java -version
        date
      done
  3. A long time gap will be observed: may > 24 hours.

  Technical details:
  * host: x86_64 Linux 4.15.0-70-generic
  * qemu v4.2.0
  * java: tried two versions: openjdk-11-jre-headless or compiled java-13 =

  * command-line: (See details in launch.sh)
  /home/bot/qemu/qemu-build/qemu-4.2.0/binaries/bin/qemu-system-x86_64 \
    -drive "file=3D${img},format=3Dqcow2" \
    -drive "file=3D${user_data},format=3Draw" \
    -cpu max \
    -m 24G \
    -serial mon:stdio \
    -smp 8 \
    -nographic \
  ;

  * Observed by java core dump generated by "kill -SIGSEGV" when java stuck=
ed:
  Different pthreads are blocked on their own condition variables:

    Id   Target Id         Frame
    1    Thread 0x7f48a041a080 (LWP 22470) __GI_raise (sig=3Dsig@entry=3D6)
      at ../sysdeps/unix/sysv/linux/raise.c:51
    2    Thread 0x7f487197d700 (LWP 22473) 0x00007f489f5c49f3 in futex_wait=
_cancelable (private=3D<optimized out>, expected=3D0, futex_word=3D0x7f4898=
0197c0)
      at ../sysdeps/unix/sysv/linux/futex-internal.h:88
    3    Thread 0x7f4861b89700 (LWP 22483) 0x00007f489f5c4ed9 in futex_relt=
imed_wait_cancelable (private=3D<optimized out>, reltime=3D0x7f4861b88960, =
expected=3D0,
      futex_word=3D0x7f489801b084)
      at ../sysdeps/unix/sysv/linux/futex-internal.h:142
    4    Thread 0x7f4861e8c700 (LWP 22480) 0x00007f489f5c76d6 in futex_abst=
imed_wait_cancelable (private=3D0, abstime=3D0x0, expected=3D0, futex_word=
=3D0x7f48980107c0)
      at ../sysdeps/unix/sysv/linux/futex-internal.h:205
    5    Thread 0x7f4861c8a700 (LWP 22482) 0x00007f489f5c4ed9 in futex_relt=
imed_wait_cancelable (private=3D<optimized out>, reltime=3D0x7f4861c89800, =
expected=3D0,
      futex_word=3D0x7f489801ed44)
      at ../sysdeps/unix/sysv/linux/futex-internal.h:142
    6    Thread 0x7f48a0418700 (LWP 22471) 0x00007f4880b13200 in ?? ()
    7    Thread 0x7f48703ea700 (LWP 22478) 0x00007f489f5c49f3 in futex_wait=
_cancelable (private=3D<optimized out>, expected=3D0, futex_word=3D0x7f4898=
01dfc0)
      at ../sysdeps/unix/sysv/linux/futex-internal.h:88
    8    Thread 0x7f48702e9700 (LWP 22479) 0x00007f489f5c49f3 in futex_wait=
_cancelable (private=3D<optimized out>, expected=3D0, futex_word=3D0x7f4898=
38cd84)
      at ../sysdeps/unix/sysv/linux/futex-internal.h:88
    9    Thread 0x7f4870f71700 (LWP 22475) 0x00007f489f5c49f3 in futex_wait=
_cancelable (private=3D<optimized out>, expected=3D0, futex_word=3D0x7f4898=
01a300)
      at ../sysdeps/unix/sysv/linux/futex-internal.h:88
    10   Thread 0x7f487187b700 (LWP 22474) 0x00007f489f5c76d6 in futex_abst=
imed_wait_cancelable (private=3D0, abstime=3D0x0, expected=3D0, futex_word=
=3D0x7f48980cf770)
      at ../sysdeps/unix/sysv/linux/futex-internal.h:205
    11   Thread 0x7f4871a7f700 (LWP 22472) 0x00007f489f5c76d6 in futex_abst=
imed_wait_cancelable (private=3D0, abstime=3D0x0, expected=3D0, futex_word=
=3D0x7f489809ba30)
      at ../sysdeps/unix/sysv/linux/futex-internal.h:205
    12   Thread 0x7f4861d8b700 (LWP 22481) 0x00007f489f5c4ed9 in futex_relt=
imed_wait_cancelable (private=3D<optimized out>, reltime=3D0x7f4861d8a680, =
expected=3D0,
      futex_word=3D0x7f489801ed44)
      at ../sysdeps/unix/sysv/linux/futex-internal.h:142
    13   Thread 0x7f48704ec700 (LWP 22477) 0x00007f489f5c4ed9 in futex_relt=
imed_wait_cancelable (private=3D<optimized out>, reltime=3D0x7f48704eb910, =
expected=3D0,
      futex_word=3D0x7f489801d120)
      at ../sysdeps/unix/sysv/linux/futex-internal.h:142
    14   Thread 0x7f4870e6f700 (LWP 22476) 0x00007f489f5c4ed9 in futex_relt=
imed_wait_cancelable (private=3D<optimized out>, reltime=3D0x7f4870e6eb20, =
expected=3D0,
      futex_word=3D0x7f489828abd0)
      at ../sysdeps/unix/sysv/linux/futex-internal.h:142

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1862874/+subscriptions

