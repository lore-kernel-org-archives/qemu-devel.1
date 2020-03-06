Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DB8C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93AA2072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93AA2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAB5w-0005gr-Ul
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jAB24-0006VG-9w
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jAB22-0008ST-Ow
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:20:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:59432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jAB22-0008PR-HK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:20:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jAB20-0000Uv-Kd
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 11:20:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4D9462E80C9
 for <qemu-devel@nongnu.org>; Fri,  6 Mar 2020 11:20:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Mar 2020 11:13:07 -0000
From: Stefan Hajnoczi <1862874@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: joshuazhu stefanha
X-Launchpad-Bug-Reporter: JZ (joshuazhu)
X-Launchpad-Bug-Modifier: Stefan Hajnoczi (stefanha)
References: <158147969798.15014.16243548781914826913.malonedeb@soybean.canonical.com>
Message-Id: <158349318708.26762.16772221076564419762.malone@gac.canonical.com>
Subject: [Bug 1862874] Re: java may stuck for a long time in system mode with
 "-cpu max"
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: f236430df7e7da5b13eeefe75535eadf0e4859a4
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

Have you tried with KVM ("-M accel=3Dkvm")?

Please try "strace -o /var/tmp/java.log -f java -version" and upload the
strace.  If the strace is very large, it's probably safe to remove
everything after around 10 seconds.

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

