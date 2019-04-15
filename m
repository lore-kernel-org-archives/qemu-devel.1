Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30954C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF2920674
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF2920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49969 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG1Jt-000621-9i
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 09:06:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hG1J0-0005gD-8f
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hG1Iu-0007eg-Hc
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:05:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:53762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hG1Iu-0007be-8f
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:05:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hG1Is-0007hg-LY
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 13:05:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9B8802E8058
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 13:05:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Apr 2019 12:59:20 -0000
From: =?utf-8?b?6LSe6LS15p2O?= <1805256@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: qemu-img
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dannf jnsnow lizhengui
X-Launchpad-Bug-Reporter: dann frazier (dannf)
X-Launchpad-Bug-Modifier: =?utf-8?b?6LSe6LS15p2OIChsaXpoZW5ndWkp?=
References: <154327283728.15443.11625169757714443608.malonedeb@soybean.canonical.com>
Message-Id:
 <155533316061.20414.16005295920588400536.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: da3867dcabae42ec3745b84b56e74d8309333db2
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1805256] Re: qemu-img hangs on high core count
 ARM system
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1805256 <1805256@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415125920.lVsYxDWZYelXBGa-Lk2WujeBBS-CB7epoEfupiiB2fk@z>

Hi, I also found a problem that qemu-img convert hands in ARM.

The convert command line is "qemu-img convert -f qcow2 -O raw disk.qcow2
disk.raw ".

The bt is below:

Thread 2 (Thread 0x40000b776e50 (LWP 27215)):
#0 0x000040000a3f2994 in sigtimedwait () from /lib64/libc.so.6
#1 0x000040000a39c60c in sigwait () from /lib64/libpthread.so.0
#2 0x0000aaaaaae82610 in sigwait_compat (opaque=3D0xaaaac5163b00) at util/c=
ompatfd.c:37
#3 0x0000aaaaaae85038 in qemu_thread_start (args=3Dargs@entry=3D0xaaaac5163=
b90) at util/qemu_thread_posix.c:496
#4 0x000040000a3918bc in start_thread () from /lib64/libpthread.so.0
#5 0x000040000a492b2c in thread_start () from /lib64/libc.so.6

Thread 1 (Thread 0x40000b573370 (LWP 27214)):
#0 0x000040000a489020 in ppoll () from /lib64/libc.so.6
#1 0x0000aaaaaadaefc0 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<opti=
mized out>, __fds=3D<optimized out>) at /usr/include/bits/poll2.h:77
#2 qemu_poll_ns (fds=3D<optimized out>, nfds=3D<optimized out>, timeout=3D<=
optimized out>) at qemu_timer.c:391
#3 0x0000aaaaaadae014 in os_host_main_loop_wait (timeout=3D<optimized out>)=
 at main_loop.c:272
#4 0x0000aaaaaadae190 in main_loop_wait (nonblocking=3D<optimized out>) at =
main_loop.c:534
#5 0x0000aaaaaad97be0 in convert_do_copy (s=3D0xffffdc32eb48) at qemu-img.c=
:1923
#6 0x0000aaaaaada2d70 in img_convert (argc=3D<optimized out>, argv=3D<optim=
ized out>) at qemu-img.c:2414
#7 0x0000aaaaaad99ac4 in main (argc=3D7, argv=3D<optimized out>) at qemu-im=
g.c:5305


Do you find the cause of the problem and fix it? Thanks for your reply!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1805256

Title:
  qemu-img hangs on high core count ARM system

Status in QEMU:
  New

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

