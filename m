Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A144AC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 17:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 789F1217F5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 17:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789F1217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htbZ1-0008Vk-KT
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 13:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53219)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1htbXw-000843-O1
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1htbXv-0002Ff-Aj
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:40:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:46560)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1htbXv-0002EH-3p
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:40:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1htbXs-0006ry-RG
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 17:40:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CC7BE2E80C7
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2019 17:40:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Aug 2019 17:35:03 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: djlwilder mopsfelder pmaydell
X-Launchpad-Bug-Reporter: David Wilder (djlwilder)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <152357545161.20027.863482450235173908.malonedeb@gac.canonical.com>
Message-Id: <156476730324.25042.1565339201054615760.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19014";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 202854b3e8a0675bc6ae1df3ad873ce3b524d855
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1763536] Re: go build fails under
 qemu-ppc64le-static (qemu-user)
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
Reply-To: Bug 1763536 <1763536@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We recently fixed bug #1696773 which was a cause of various crashes or
other problems when trying to run go binaries under linux-user,
including "go build hello.go". So I strongly suspect this is a duplicate
of that bug. Could you test with the QEMU v4.1.0 rc3 or later, please?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1763536

Title:
  go build fails under qemu-ppc64le-static (qemu-user)

Status in QEMU:
  New

Bug description:
  I am using qemu-user (built static) in a docker container environment.
  When running multi-threaded go commands in the container (go build for
  example) the process may hang, report segfaults or other errors.  I
  built qemu-ppc64le from the upstream git (master).

  I see the problem running on a multi core system with Intel i7 processors.
  # cat /proc/cpuinfo | grep "model name"
  model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
  model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
  model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
  model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
  model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
  model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
  model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
  model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz

  Steps to reproduce:
  1) Build qemu-ppc64le as static and copy into docker build directory name=
d it qemu-ppc64le-static.

  2) Add hello.go to docker build dir.

  package main
  import "fmt"
  func main() {
  	fmt.Println("hello world")
  }

  3) Create the Dockerfile from below:

  FROM ppc64le/golang:1.10.1-alpine3.
  COPY qemu-ppc64le-static /usr/bin/
  COPY hello.go /go

  4) Build container
  $ docker build -t qemutest -f Dockerfile ./go =


  5) Run test
  $ docker run -it qemutest

  /go # /usr/bin/qemu-ppc64le-static --version
  qemu-ppc64le version 2.11.93 (v2.12.0-rc3-dirty)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  /go # go version
  go version go1.10.1 linux/ppc64le

  /go # go build hello.go
  fatal error: fatal error: stopm holding locksunexpected signal during run=
time execution

  panic during panic
  [signal SIGSEGV: segmentation violation code=3D0x1 addr=3D0x0 pc=3D0x1003=
528c]

  runtime stack:
  runtime: unexpected return pc for syscall.Syscall6 called from 0xc42007f5=
00
  stack: frame=3D{sp:0xc4203be840, fp:0xc4203be860} stack=3D[0x4000b7ecf0,0=
x4000b928f0)

  syscall.Syscall6(0x100744e8, 0x3d, 0xc42050c140, 0x20, 0x18, 0x10422b80, =
0xc4203be968[signal , 0x10012d88SIGSEGV: segmentation violation, 0xc4205940=
00 code=3D, 0x00x1 addr=3D0x0 pc=3D0x1003528c)
  ]

  runtime stack:
  	/usr/local/go/src/syscall/asm_linux_ppc64x.s:61runtime.throw(0x10472d19,=
 0x13)
   +	/usr/local/go/src/runtime/panic.go:0x6c616 +0x68

  =

  runtime.stopm()
  	/usr/local/go/src/runtime/proc.go:1939goroutine  +10x158
   [runtime.exitsyscall0semacquire(0xc42007f500)
  	/usr/local/go/src/runtime/proc.go:3129 +]:
  0x130
  runtime.mcall(0xc42007f500)
  	/usr/local/go/src/runtime/asm_ppc64x.s:183 +0x58sync.runtime_Semacquire
  (0xc4201fab1c)
  	/usr/local/go/src/runtime/sema.go:56 +0x38

  ----
  Note the results may differ between attempts,  hangs and other faults som=
etimes happen.
  ----
  If I run "go: single threaded I don't see the problem, for example:

  /go # GOMAXPROCS=3D1 go build -p 1 hello.go =

  /go # ./hello
  hello world

  I see the same issue with arm64.  I don't think this is a go issue,
  but don't have a real evidence to prove that.  This problem looks
  similar to other problem I have seen reported against qemu running
  multi-threaded applications.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1763536/+subscriptions

