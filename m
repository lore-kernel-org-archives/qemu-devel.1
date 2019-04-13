Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8ABC10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 02:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1E12084E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 02:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1E12084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF88l-0005Wj-TJ
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 22:11:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hF87y-0004rO-DY
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 22:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hF87x-0008Ts-9h
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 22:10:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:33542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hF87w-0008S3-Vh
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 22:10:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hF87v-0006IW-Ij
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 02:10:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8026E2E8055
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 02:10:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Apr 2019 02:04:01 -0000
From: =?utf-8?b?6LSe6LS15p2O?= <1824053@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: lizhengui
X-Launchpad-Bug-Reporter: =?utf-8?b?6LSe6LS15p2OIChsaXpoZW5ndWkp?=
X-Launchpad-Bug-Modifier: =?utf-8?b?6LSe6LS15p2OIChsaXpoZW5ndWkp?=
References: <155486495593.20543.13567634487304856304.malonedeb@chaenomeles.canonical.com>
Message-Id:
 <155512104169.20376.12640593667293574727.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 16a6e869d48bb09a58d36c651b824e72cc814c35
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1824053] Re: Qemu-img convert appears to be stuck
 on aarch64 host with low probability
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
Reply-To: Bug 1824053 <1824053@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413020401.dUsepvQtcG2-BqN7LC85B1vHM16VJ3cGkqH1K7EwMGY@z>

Anyone else has a similar problem?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824053

Title:
  Qemu-img convert appears to be stuck on aarch64 host with low
  probability

Status in QEMU:
  New

Bug description:
  Hi,  I found a problem that qemu-img convert appears to be stuck on
  aarch64 host with low probability.

  The convert command  line is  "qemu-img convert -f qcow2 -O raw
  disk.qcow2 disk.raw ".

  The bt is below:

  Thread 2 (Thread 0x40000b776e50 (LWP 27215)):
  #0  0x000040000a3f2994 in sigtimedwait () from /lib64/libc.so.6
  #1  0x000040000a39c60c in sigwait () from /lib64/libpthread.so.0
  #2  0x0000aaaaaae82610 in sigwait_compat (opaque=3D0xaaaac5163b00) at uti=
l/compatfd.c:37
  #3  0x0000aaaaaae85038 in qemu_thread_start (args=3Dargs@entry=3D0xaaaac5=
163b90) at util/qemu_thread_posix.c:496
  #4  0x000040000a3918bc in start_thread () from /lib64/libpthread.so.0
  #5  0x000040000a492b2c in thread_start () from /lib64/libc.so.6

  Thread 1 (Thread 0x40000b573370 (LWP 27214)):
  #0  0x000040000a489020 in ppoll () from /lib64/libc.so.6
  #1  0x0000aaaaaadaefc0 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<o=
ptimized out>, __fds=3D<optimized out>) at /usr/include/bits/poll2.h:77
  #2  qemu_poll_ns (fds=3D<optimized out>, nfds=3D<optimized out>, timeout=
=3D<optimized out>) at qemu_timer.c:391
  #3  0x0000aaaaaadae014 in os_host_main_loop_wait (timeout=3D<optimized ou=
t>) at main_loop.c:272
  #4  0x0000aaaaaadae190 in main_loop_wait (nonblocking=3D<optimized out>) =
at main_loop.c:534
  #5  0x0000aaaaaad97be0 in convert_do_copy (s=3D0xffffdc32eb48) at qemu-im=
g.c:1923
  #6  0x0000aaaaaada2d70 in img_convert (argc=3D<optimized out>, argv=3D<op=
timized out>) at qemu-img.c:2414
  #7  0x0000aaaaaad99ac4 in main (argc=3D7, argv=3D<optimized out>) at qemu=
-img.c:5305

  =

  The problem seems to be very similar to the phenomenon described by this =
patch (https://resources.ovirt.org/pub/ovirt-4.1/src/qemu-kvm-ev/0025-aio_n=
otify-force-main-loop-wakeup-with-SIGIO-aarch64.patch), =


  which force main loop wakeup with SIGIO.  But this patch was reverted
  by the patch (http://ovirt.repo.nfrance.com/src/qemu-kvm-ev/kvm-
  Revert-aio_notify-force-main-loop-wakeup-with-SIGIO-.patch).

  The problem still seems to exist in aarch64 host. The qemu version I used=
 is 2.8.1. The host version is 4.19.28-1.2.108.aarch64.
   Do you have any solutions to fix it?  Thanks for your reply !

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824053/+subscriptions

