Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C40CC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5366F2087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5366F2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33153 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLASE-0005ps-Im
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:52:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hLAQS-0004YQ-PW
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hLAQR-0002lv-Hy
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:50:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:33612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hLAQR-0002lO-CE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:50:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hLAQM-00027G-Vr
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 17:50:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7052D2E80EB
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 17:50:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Apr 2019 17:40:52 -0000
From: Ben Wibking <1818937@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: crash hvf macos
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bwibking cuser2
X-Launchpad-Bug-Reporter: Chen Zhang (cuser2)
X-Launchpad-Bug-Modifier: Ben Wibking (bwibking)
References: <155192472106.28960.15645485731508389788.malonedeb@chaenomeles.canonical.com>
Message-Id:
 <155655965273.7051.11571422786261284957.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 84ebde4dbad0eff55bc49bf4918db67d232a43f4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1818937] Re: Crash with HV_ERROR on macOS host
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
Reply-To: Bug 1818937 <1818937@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429174052.r2FNIVgFOxV3RbPQw8OoLWuwMC86o9EDRSmqOSy8psE@z>

^This is on version:

% qemu-system-x86_64 --version
QEMU emulator version 4.0.50 (v4.0.0-rc4-52-g3284aa1281-dirty)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1818937

Title:
  Crash with HV_ERROR on macOS host

Status in QEMU:
  New

Bug description:
  On macOS host running Windows 10 guest, qemu crashed with error
  message: Error: HV_ERROR.

  Host: macOS Mojave 10.14.3 (18D109) Late 2014 Mac mini presumably Core i5=
 4278U.
  QEMU: git commit a3e3b0a7bd5de211a62cdf2d6c12b96d3c403560
  QEMU parameter: qemu-system-x86_64 -m 3000 -drive file=3Ddisk.img,if=3Dvi=
rtio,discard=3Dunmap -accel hvf -soundhw hda -smp 3

  thread list
  Process 56054 stopped
    thread #1: tid =3D 0x2ffec8, 0x00007fff48d0805a vImage`vLookupTable_Pla=
nar16 + 970, queue =3D 'com.apple.main-thread'
    thread #2: tid =3D 0x2ffecc, 0x00007fff79d6d7de libsystem_kernel.dylib`=
__psynch_cvwait + 10
    thread #3: tid =3D 0x2ffecd, 0x00007fff79d715aa libsystem_kernel.dylib`=
__select + 10
    thread #4: tid =3D 0x2ffece, 0x00007fff79d71d9a libsystem_kernel.dylib`=
__sigwait + 10
  * thread #6: tid =3D 0x2ffed0, 0x00007fff79d7023e libsystem_kernel.dylib`=
__pthread_kill + 10, stop reason =3D signal SIGABRT
    thread #7: tid =3D 0x2ffed1, 0x00007fff79d6d7de libsystem_kernel.dylib`=
__psynch_cvwait + 10
    thread #8: tid =3D 0x2ffed2, 0x00007fff79d6d7de libsystem_kernel.dylib`=
__psynch_cvwait + 10
    thread #11: tid =3D 0x2fff34, 0x00007fff79d6a17a libsystem_kernel.dylib=
`mach_msg_trap + 10, name =3D 'com.apple.NSEventThread'
    thread #30: tid =3D 0x300c04, 0x00007fff79e233f8 libsystem_pthread.dyli=
b`start_wqthread
    thread #31: tid =3D 0x300c16, 0x00007fff79e233f8 libsystem_pthread.dyli=
b`start_wqthread
    thread #32: tid =3D 0x300c17, 0x0000000000000000
    thread #33: tid =3D 0x300c93, 0x00007fff79d6d7de libsystem_kernel.dylib=
`__psynch_cvwait + 10

  =

  Crashed thread:

  * thread #6, stop reason =3D signal SIGABRT
    * frame #0: 0x00007fff79d7023e libsystem_kernel.dylib`__pthread_kill + =
10
      frame #1: 0x00007fff79e26c1c libsystem_pthread.dylib`pthread_kill + 2=
85
      frame #2: 0x00007fff79cd91c9 libsystem_c.dylib`abort + 127
      frame #3: 0x000000010baa476d qemu-system-x86_64`assert_hvf_ok(ret=3D<=
unavailable>) at hvf.c:106 [opt]
      frame #4: 0x000000010baa4c8f qemu-system-x86_64`hvf_vcpu_exec(cpu=3D0=
x00007f8e5283de00) at hvf.c:681 [opt]
      frame #5: 0x000000010b988423 qemu-system-x86_64`qemu_hvf_cpu_thread_f=
n(arg=3D0x00007f8e5283de00) at cpus.c:1636 [opt]
      frame #6: 0x000000010bd9dfce qemu-system-x86_64`qemu_thread_start(arg=
s=3D<unavailable>) at qemu-thread-posix.c:502 [opt]
      frame #7: 0x00007fff79e24305 libsystem_pthread.dylib`_pthread_body + =
126
      frame #8: 0x00007fff79e2726f libsystem_pthread.dylib`_pthread_start +=
 70
      frame #9: 0x00007fff79e23415 libsystem_pthread.dylib`thread_start + 13

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1818937/+subscriptions

