Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE180C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD7A2080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD7A2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKoQ-0007XW-KZ
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iBKnJ-0006Hd-GS
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iBKnI-0003Ts-3z
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:26:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:37678)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iBKnH-0003TQ-Sh
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:26:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iBKnF-0004wG-PK
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 15:25:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8917C2E819B
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 15:25:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Sep 2019 15:18:56 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: glaubitz pmaydell
X-Launchpad-Bug-Reporter: John Paul Adrian Glaubitz (glaubitz)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <156518306048.32528.10373743991208371347.malonedeb@chaenomeles.canonical.com>
Message-Id: <156899273640.812.14671509408363934087.malone@wampee.canonical.com>
Subject: [Bug 1839325] Re: Go programs crash on qemu-sh4 due to issues with
 atomics
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: aec023021b564fa47f184663b4a2c05ffdae288d
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
Reply-To: Bug 1839325 <1839325@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm going to close this bug, since it's a problem with the gccgo
codegen, not a QEMU bug. (I'm interested in any response you get from
the go/gcc upstream folks, though.)


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1839325

Title:
  Go programs crash on qemu-sh4 due to issues with atomics

Status in QEMU:
  Invalid

Bug description:
  After #1738545 [1] was fixed, Go applications work fine on qemu-arm
  but still crash on qemu-sh4. From the backtrace, it looks like an
  issue with the atomics in qemu-sh4:

  (sid-sh4-sbuild)root@epyc:/# cat hello.go
  package main

  import "fmt"

  func main() {
        fmt.Println("hello world")
  }

  (sid-sh4-sbuild)root@epyc:/# gccgo-9 hello.go -o hello
  (sid-sh4-sbuild)root@epyc:/# ./hello =

  panic: (        runtime runtime.errorString) (0x7f74527c,0x80a038)
  fatal error: panic on system stack
  panic: (        runtime runtime.errorString) (0x7f74527c,0x80a038)
  fatal error: panic on system stack

  runtime stack:
  runtime..z2finternal..z2fatomic.Load64
          ../../../src/libgo/go/runtime/internal/atomic/atomic.c:37
  runtime_mstart
          ../../../src/libgo/runtime/proc.c:596

  goroutine 1 [running]:
          goroutine running on other thread; stack unavailable

  runtime stack:
  runtime..z2finternal..z2fatomic.Load64
          ../../../src/libgo/go/runtime/internal/atomic/atomic.c:37
  runtime_mstart
          ../../../src/libgo/runtime/proc.c:596
  (sid-sh4-sbuild)root@epyc:/#

  The same sample Go program runs fine on my SH7785LCR SH4 evaluation
  board:

  root@tirpitz:~> uname -a
  Linux tirpitz 3.16.7-ckt7 #8 PREEMPT Fri Oct 21 18:47:41 CEST 2016 sh4a G=
NU/Linux
  root@tirpitz:~> cat hello.go
  package main

  import "fmt"

  func main() {
        fmt.Println("hello world")
  }

  root@tirpitz:~> gccgo-9 hello.go -o hello
  root@tirpitz:~> ./hello =

  hello world
  root@tirpitz:~>

  Please note: In order to be able to reproduce this, one also needs to
  revert commit 61dedf2af7 [2], otherwise the Go application crashes
  differently:

  (sid-sh4-sbuild)root@epyc:/# ./hello        =

  Unhandled trap: 0x180
  pc=3D0x7e5f7f9e sr=3D0x00000000 pr=3D0x7ee3d582 fpscr=3D0x00080004
  spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0x7e590480 vbr=3D0x00000000
  sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0x7e5f7f60 fpul=3D0x00034f=
3b
  r0=3D0x008007d4 r1=3D0x00000000 r2=3D0xfffe0b2a r3=3D0x00000002
  r4=3D0x008006e4 r5=3D0x00872000 r6=3D0x00200000 r7=3D0x00000000
  r8=3D0x7f7bca7c r9=3D0x7fffebd4 r10=3D0x00800480 r11=3D0x7f7bc0f0
  r12=3D0x7f7a3fa4 r13=3D0x008004c0 r14=3D0x7f7b2238 r15=3D0x7fffebd0
  r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
  r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
  (sid-sh4-sbuild)root@epyc:/#

  > [1] https://bugs.launchpad.net/bugs/1738545
  > [2] https://bugs.launchpad.net/bugs/1796520

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1839325/+subscriptions

