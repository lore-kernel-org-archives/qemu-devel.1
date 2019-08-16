Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A899C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F197D206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F197D206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyUhh-0006Il-7O
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 01:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1hyUfR-00048n-20
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hyUfN-0008Un-GX
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:20:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:53844)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hyUfN-0008Th-6y
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:20:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hyUfM-0004d7-2z
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:20:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 147E22E80C9
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:20:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2019 05:14:09 -0000
From: Thomas Huth <1838946@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: arheneus pmaydell
X-Launchpad-Bug-Reporter: Antony Rheneus (arheneus)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <156499265611.25363.5857358041161895848.malonedeb@soybean.canonical.com>
Message-Id: <156593245018.22921.6931350581694914454.launchpad@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 4e848625869a79d44b9a2ddaa50fa328d0d43505
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1838946] Re: qemu 3.10 golang crash
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
Reply-To: Bug 1838946 <1838946@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1838946

Title:
  qemu 3.10 golang crash

Status in QEMU:
  Fix Released

Bug description:
  Encountered below crashes in qemu 3.10 arm =

  Also have raised the same in golang groups. But seems like in ARM32 hardw=
are, the below commands works fine, only in qemu if crashes. =

  https://groups.google.com/forum/?utm_medium=3Demail&utm_source=3Dfooter#!=
topic/golang-nuts/1txPOGa4aGc

  Need some pointers to narrow down

  Please see log below.

  $ qemu-arm-static --version
  qemu-arm version 3.1.0 (qemu-3.1.0-6.fc30)
  Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers


  =

  arheneus@bbdee4f6f57d:/sonic/src/telemetry/test$ /usr/local/go/bin/go get=
 -v github.com/Azure/sonic-telemetry/dialout/dialout_client_cli
  github.com/openconfig/ygot (download)
  github.com/kylelemons/godebug (download)
  github.com/openconfig/goyang (download)
  SIGSEGV: segmentation violation
  PC=3D0x4512c m=3D12 sigcode=3D1

  goroutine 15 [syscall]:
  syscall.Syscall6(0x118, 0x1, 0x11c3, 0xf513b0, 0x1000004, 0x0, 0x0, 0x1c6=
3c, 0x15e54, 0xe280a0)
          /usr/local/go/src/syscall/asm_linux_arm.s:45 +0x8 fp=3D0xf51380 s=
p=3D0xf5137c pc=3D0x88298
  os.(*Process).blockUntilWaitable(0xf80300, 0xf80300, 0x0, 0x0)
          /usr/local/go/src/os/wait_waitid.go:31 +0x64 fp=3D0xf51438 sp=3D0=
xf51380 pc=3D0xa94a0
  os.(*Process).wait(0xf80300, 0x13, 0xe6e1d0, 0xeba010)
          /usr/local/go/src/os/exec_unix.go:22 +0x2c fp=3D0xf51470 sp=3D0xf=
51438 pc=3D0xa2d58
  os.(*Process).Wait(0xf80300, 0x4d5f58, 0x4d5f5c, 0x4d5f54)
          /usr/local/go/src/os/exec.go:125 +0x1c fp=3D0xf51484 sp=3D0xf5147=
0 pc=3D0xa2494
  os/exec.(*Cmd).Wait(0xe14000, 0x0, 0x0)
          /usr/local/go/src/os/exec/exec.go:465 +0x40 fp=3D0xf514bc sp=3D0x=
f51484 pc=3D0xf8620
  os/exec.(*Cmd).Run(0xe14000, 0xd5c720, 0xf30000)
          /usr/local/go/src/os/exec/exec.go:309 +0x44 fp=3D0xf514cc sp=3D0x=
f514bc pc=3D0xf7e1c
  cmd/go/internal/work.(*Builder).toolID(0xd5cf60, 0x497ee2, 0x7, 0x2c, 0x1=
16f8e0)
          /usr/local/go/src/cmd/go/internal/work/buildid.go:193 +0x2e0 fp=
=3D0xf515bc sp=3D0xf514cc pc=3D0x3549bc
  cmd/go/internal/work.(*Builder).buildActionID(0xd5cf60, 0x1177d90, 0x0, 0=
x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:223 +0xb8c fp=3D0x=
f51978 sp=3D0xf515bc pc=3D0x3594fc
  cmd/go/internal/work.(*Builder).build(0xd5cf60, 0x1177d90, 0x0, 0x0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:373 +0x3d3c fp=3D0=
xf51f44 sp=3D0xf51978 pc=3D0x35e374
  cmd/go/internal/work.(*Builder).Do.func1(0x1177d90)
          /usr/local/go/src/cmd/go/internal/work/exec.go:107 +0x58 fp=3D0xf=
51f84 sp=3D0xf51f44 pc=3D0x38287c
  cmd/go/internal/work.(*Builder).Do.func2(0xdf0070, 0xd5cf60, 0x10427a0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:165 +0x84 fp=3D0xf=
51fdc sp=3D0xf51f84 pc=3D0x382b24
  runtime.goexit()
          /usr/local/go/src/runtime/asm_arm.s:867 +0x4 fp=3D0xf51fdc sp=3D0=
xf51fdc pc=3D0x67f44
  created by cmd/go/internal/work.(*Builder).Do
          /usr/local/go/src/cmd/go/internal/work/exec.go:152 +0x2e4

  goroutine 1 [semacquire]:
  sync.runtime_Semacquire(0xdf0078)
          /usr/local/go/src/runtime/sema.go:56 +0x2c
  sync.(*WaitGroup).Wait(0xdf0070)
          /usr/local/go/src/sync/waitgroup.go:130 +0x84
  cmd/go/internal/work.(*Builder).Do(0xd5cf60, 0x1177290)
          /usr/local/go/src/cmd/go/internal/work/exec.go:174 +0x304
  cmd/go/internal/work.InstallPackages(0xc82078, 0x1, 0x1, 0xc0e938, 0x1, 0=
x2)
          /usr/local/go/src/cmd/go/internal/work/build.go:506 +0xa88
  cmd/go/internal/get.runGet(0x810d78, 0xc82078, 0x1, 0x1)
          /usr/local/go/src/cmd/go/internal/get/get.go:196 +0x1b0
  main.main()
          /usr/local/go/src/cmd/go/main.go:219 +0x93c

  goroutine 19 [syscall]:
  os/signal.signal_recv(0x0)
          /usr/local/go/src/runtime/sigqueue.go:139 +0x130
  os/signal.loop()
          /usr/local/go/src/os/signal/signal_unix.go:23 +0x14
  created by os/signal.init.0
          /usr/local/go/src/os/signal/signal_unix.go:29 +0x30

  goroutine 13 [syscall]:
  syscall.Syscall6(0x118, 0x1, 0x11ec, 0x10153b0, 0x1000004, 0x0, 0x0, 0x1c=
63c, 0x15e54, 0xe001e0)
          /usr/local/go/src/syscall/asm_linux_arm.s:45 +0x8
  os.(*Process).blockUntilWaitable(0xe62840, 0xe62840, 0x0, 0x0)
          /usr/local/go/src/os/wait_waitid.go:31 +0x64
  os.(*Process).wait(0xe62840, 0x1, 0xc0e360, 0xe00160)
          /usr/local/go/src/os/exec_unix.go:22 +0x2c
  os.(*Process).Wait(0xe62840, 0x4d5f58, 0x4d5f5c, 0x4d5f54)
          /usr/local/go/src/os/exec.go:125 +0x1c
  os/exec.(*Cmd).Wait(0xf8e0b0, 0x0, 0x0)
          /usr/local/go/src/os/exec/exec.go:465 +0x40
  os/exec.(*Cmd).Run(0xf8e0b0, 0xca8060, 0xe6cd00)
          /usr/local/go/src/os/exec/exec.go:309 +0x44
  cmd/go/internal/work.(*Builder).toolID(0xd5cf60, 0x49631b, 0x3, 0x11, 0x1=
015890)
          /usr/local/go/src/cmd/go/internal/work/buildid.go:193 +0x2e0
  cmd/go/internal/work.(*Builder).buildActionID(0xd5cf60, 0xfb6210, 0x0, 0x=
0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:225 +0x11d4
  cmd/go/internal/work.(*Builder).build(0xd5cf60, 0xfb6210, 0x0, 0x0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:373 +0x3d3c
  cmd/go/internal/work.(*Builder).Do.func1(0xfb6210)
          /usr/local/go/src/cmd/go/internal/work/exec.go:107 +0x58
  cmd/go/internal/work.(*Builder).Do.func2(0xdf0070, 0xd5cf60, 0x10427a0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:165 +0x84
  created by cmd/go/internal/work.(*Builder).Do
          /usr/local/go/src/cmd/go/internal/work/exec.go:152 +0x2e4

  goroutine 14 [syscall]:
  syscall.Syscall6(0x118, 0x1, 0x11ed, 0xe393b0, 0x1000004, 0x0, 0x0, 0x1c6=
3c, 0x15e54, 0xd280f0)
          /usr/local/go/src/syscall/asm_linux_arm.s:45 +0x8
  os.(*Process).blockUntilWaitable(0x115c4e0, 0x115c4e0, 0x0, 0x0)
          /usr/local/go/src/os/wait_waitid.go:31 +0x64
  os.(*Process).wait(0x115c4e0, 0x1, 0xe78160, 0xd28070)
          /usr/local/go/src/os/exec_unix.go:22 +0x2c
  os.(*Process).Wait(0x115c4e0, 0x4d5f58, 0x4d5f5c, 0x4d5f54)
          /usr/local/go/src/os/exec.go:125 +0x1c
  os/exec.(*Cmd).Wait(0x10b8000, 0x0, 0x0)
          /usr/local/go/src/os/exec/exec.go:465 +0x40
  os/exec.(*Cmd).Run(0x10b8000, 0xf3e060, 0xf0c000)
          /usr/local/go/src/os/exec/exec.go:309 +0x44
  cmd/go/internal/work.(*Builder).toolID(0xd5cf60, 0x49631b, 0x3, 0x11, 0xe=
39890)
          /usr/local/go/src/cmd/go/internal/work/buildid.go:193 +0x2e0
  cmd/go/internal/work.(*Builder).buildActionID(0xd5cf60, 0x1177b80, 0x0, 0=
x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:225 +0x11d4
  cmd/go/internal/work.(*Builder).build(0xd5cf60, 0x1177b80, 0x0, 0x0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:373 +0x3d3c
  cmd/go/internal/work.(*Builder).Do.func1(0x1177b80)
          /usr/local/go/src/cmd/go/internal/work/exec.go:107 +0x58
  cmd/go/internal/work.(*Builder).Do.func2(0xdf0070, 0xd5cf60, 0x10427a0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:165 +0x84
  created by cmd/go/internal/work.(*Builder).Do
          /usr/local/go/src/cmd/go/internal/work/exec.go:152 +0x2e4

  goroutine 16 [runnable]:
  os/exec.(*Cmd).writerDescriptor(0x10b80b0, 0x54bd38, 0xf3e120, 0xf3e0c0, =
0x0, 0x0)
          /usr/local/go/src/os/exec/exec.go:257 +0x484
  os/exec.(*Cmd).stderr(0x10b80b0, 0x1112090, 0x0, 0x0)
          /usr/local/go/src/os/exec/exec.go:254 +0xac
  os/exec.(*Cmd).Start(0x10b80b0, 0x496701, 0xf3e120)
          /usr/local/go/src/os/exec/exec.go:372 +0xa8
  os/exec.(*Cmd).Run(0x10b80b0, 0xf3e120, 0xf0c300)
          /usr/local/go/src/os/exec/exec.go:306 +0x1c
  cmd/go/internal/work.(*Builder).toolID(0xd5cf60, 0x49631b, 0x3, 0x11, 0xf=
49890)
          /usr/local/go/src/cmd/go/internal/work/buildid.go:193 +0x2e0
  cmd/go/internal/work.(*Builder).buildActionID(0xd5cf60, 0x1177ce0, 0x0, 0=
x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:225 +0x11d4
  cmd/go/internal/work.(*Builder).build(0xd5cf60, 0x1177ce0, 0x0, 0x0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:373 +0x3d3c
  cmd/go/internal/work.(*Builder).Do.func1(0x1177ce0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:107 +0x58
  cmd/go/internal/work.(*Builder).Do.func2(0xdf0070, 0xd5cf60, 0x10427a0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:165 +0x84
  created by cmd/go/internal/work.(*Builder).Do
          /usr/local/go/src/cmd/go/internal/work/exec.go:152 +0x2e4

  goroutine 82 [runnable]:
  syscall.Syscall(0x3, 0xb, 0x11c2000, 0x8000, 0x0, 0x0, 0x0)
          /usr/local/go/src/syscall/asm_linux_arm.s:14 +0x8
  syscall.read(0xb, 0x11c2000, 0x8000, 0x8000, 0x10ea501, 0x0, 0x0)
          /usr/local/go/src/syscall/zsyscall_linux_arm.go:732 +0x40
  syscall.Read(0xb, 0x11c2000, 0x8000, 0x8000, 0xdedf9577, 0xe9841d9d, 0xdb=
b1d24e)
          /usr/local/go/src/syscall/syscall_unix.go:172 +0x34
  internal/poll.(*FD).Read(0xd9c140, 0x11c2000, 0x8000, 0x8000, 0x0, 0x0, 0=
x0)
          /usr/local/go/src/internal/poll/fd_unix.go:165 +0xf0
  os.(*File).read(0xcdc0f0, 0x11c2000, 0x8000, 0x8000, 0x11c3700, 0x1d, 0x6=
940)
          /usr/local/go/src/os/file_unix.go:249 +0x3c
  os.(*File).Read(0xcdc0f0, 0x11c2000, 0x8000, 0x8000, 0x171d, 0x0, 0x0)
          /usr/local/go/src/os/file.go:108 +0x4c
  io.copyBuffer(0xe77be000, 0xe88380, 0x54c3f8, 0xcdc0f0, 0x11c2000, 0x8000=
, 0x8000, 0x443d58, 0x47a900, 0x0, ...)
          /usr/local/go/src/io/io.go:402 +0xd8
  io.Copy(0xe77be000, 0xe88380, 0x54c3f8, 0xcdc0f0, 0xe88380, 0x0, 0x40, 0x=
b)
          /usr/local/go/src/io/io.go:364 +0x48
  cmd/go/internal/cache.FileHash(0xe628a0, 0x25, 0x0, 0x0, 0x0, 0x0, 0x0, 0=
x0, 0x0, 0x0, ...)
          /usr/local/go/src/cmd/go/internal/cache/hash.go:149 +0x240
  cmd/go/internal/work.(*Builder).fileHash(0xd5cf60, 0xe628a0, 0x25, 0xe628=
a0, 0x25)
          /usr/local/go/src/cmd/go/internal/work/buildid.go:396 +0x24
  cmd/go/internal/work.(*Builder).buildActionID(0xd5cf60, 0x1177760, 0x0, 0=
x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:292 +0x5ec
  cmd/go/internal/work.(*Builder).build(0xd5cf60, 0x1177760, 0x0, 0x0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:373 +0x3d3c
  cmd/go/internal/work.(*Builder).Do.func1(0x1177760)
          /usr/local/go/src/cmd/go/internal/work/exec.go:107 +0x58
  cmd/go/internal/work.(*Builder).Do.func2(0xdf0070, 0xd5cf60, 0x10427a0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:165 +0x84
  created by cmd/go/internal/work.(*Builder).Do
          /usr/local/go/src/cmd/go/internal/work/exec.go:152 +0x2e4

  goroutine 83 [syscall]:
  syscall.Syscall6(0x118, 0x1, 0x11d1, 0xf4d3b0, 0x1000004, 0x0, 0x0, 0x1c6=
3c, 0x15e54, 0xe280b0)
          /usr/local/go/src/syscall/asm_linux_arm.s:45 +0x8
  os.(*Process).blockUntilWaitable(0xf80330, 0xf80330, 0x0, 0x0)
          /usr/local/go/src/os/wait_waitid.go:31 +0x64
  os.(*Process).wait(0xf80330, 0x1, 0xc7e1b0, 0xe28010)
          /usr/local/go/src/os/exec_unix.go:22 +0x2c
  os.(*Process).Wait(0xf80330, 0x4d5f58, 0x4d5f5c, 0x4d5f54)
          /usr/local/go/src/os/exec.go:125 +0x1c
  os/exec.(*Cmd).Wait(0x11760b0, 0x0, 0x0)
          /usr/local/go/src/os/exec/exec.go:465 +0x40
  os/exec.(*Cmd).Run(0x11760b0, 0xfc8060, 0xefa800)
          /usr/local/go/src/os/exec/exec.go:309 +0x44
  cmd/go/internal/work.(*Builder).toolID(0xd5cf60, 0x497ee2, 0x7, 0x2c, 0xf=
278e0)
          /usr/local/go/src/cmd/go/internal/work/buildid.go:193 +0x2e0
  cmd/go/internal/work.(*Builder).buildActionID(0xd5cf60, 0x1177e40, 0x0, 0=
x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:223 +0xb8c
  cmd/go/internal/work.(*Builder).build(0xd5cf60, 0x1177e40, 0x0, 0x0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:373 +0x3d3c
  cmd/go/internal/work.(*Builder).Do.func1(0x1177e40)
          /usr/local/go/src/cmd/go/internal/work/exec.go:107 +0x58
  cmd/go/internal/work.(*Builder).Do.func2(0xdf0070, 0xd5cf60, 0x10427a0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:165 +0x84
  created by cmd/go/internal/work.(*Builder).Do
          /usr/local/go/src/cmd/go/internal/work/exec.go:152 +0x2e4

  goroutine 84 [syscall]:
  syscall.Syscall6(0x118, 0x1, 0x11cf, 0xf453b0, 0x1000004, 0x0, 0x0, 0x1c6=
3c, 0x15e54, 0xeba040)
          /usr/local/go/src/syscall/asm_linux_arm.s:45 +0x8
  os.(*Process).blockUntilWaitable(0xf74180, 0xf74180, 0x0, 0x0)
          /usr/local/go/src/os/wait_waitid.go:31 +0x64
  os.(*Process).wait(0xf74180, 0x1, 0x1112070, 0x100e010)
          /usr/local/go/src/os/exec_unix.go:22 +0x2c
  os.(*Process).Wait(0xf74180, 0x4d5f58, 0x4d5f5c, 0x4d5f54)
          /usr/local/go/src/os/exec.go:125 +0x1c
  os/exec.(*Cmd).Wait(0xfe8000, 0x0, 0x0)
          /usr/local/go/src/os/exec/exec.go:465 +0x40
  os/exec.(*Cmd).Run(0xfe8000, 0xe10060, 0xf18000)
          /usr/local/go/src/os/exec/exec.go:309 +0x44
  cmd/go/internal/work.(*Builder).toolID(0xd5cf60, 0x497ee2, 0x7, 0x2c, 0x1=
0878e0)
          /usr/local/go/src/cmd/go/internal/work/buildid.go:193 +0x2e0
  cmd/go/internal/work.(*Builder).buildActionID(0xd5cf60, 0x1177a20, 0x0, 0=
x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:223 +0xb8c
  cmd/go/internal/work.(*Builder).build(0xd5cf60, 0x1177a20, 0x0, 0x0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:373 +0x3d3c
  cmd/go/internal/work.(*Builder).Do.func1(0x1177a20)
          /usr/local/go/src/cmd/go/internal/work/exec.go:107 +0x58
  cmd/go/internal/work.(*Builder).Do.func2(0xdf0070, 0xd5cf60, 0x10427a0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:165 +0x84
  created by cmd/go/internal/work.(*Builder).Do
          /usr/local/go/src/cmd/go/internal/work/exec.go:152 +0x2e4

  goroutine 85 [syscall]:
  syscall.Syscall6(0x118, 0x1, 0x11d5, 0xe373b0, 0x1000004, 0x0, 0x0, 0x1c6=
3c, 0x15e54, 0xeba050)
          /usr/local/go/src/syscall/asm_linux_arm.s:45 +0x8
  os.(*Process).blockUntilWaitable(0xf741b0, 0xf741b0, 0x0, 0x0)
          /usr/local/go/src/os/wait_waitid.go:31 +0x64
  os.(*Process).wait(0xf741b0, 0x50, 0xc0e290, 0xe00090)
          /usr/local/go/src/os/exec_unix.go:22 +0x2c
  os.(*Process).Wait(0xf741b0, 0x4d5f58, 0x4d5f5c, 0x4d5f54)
          /usr/local/go/src/os/exec.go:125 +0x1c
  os/exec.(*Cmd).Wait(0xf8e000, 0x0, 0x0)
          /usr/local/go/src/os/exec/exec.go:465 +0x40
  os/exec.(*Cmd).Run(0xf8e000, 0xcb5e00, 0xe6ca00)
          /usr/local/go/src/os/exec/exec.go:309 +0x44
  cmd/go/internal/work.(*Builder).toolID(0xd5cf60, 0x497ee2, 0x7, 0x2c, 0xf=
2b8e0)
          /usr/local/go/src/cmd/go/internal/work/buildid.go:193 +0x2e0
  cmd/go/internal/work.(*Builder).buildActionID(0xd5cf60, 0x1177ef0, 0x0, 0=
x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:223 +0xb8c
  cmd/go/internal/work.(*Builder).build(0xd5cf60, 0x1177ef0, 0x0, 0x0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:373 +0x3d3c
  cmd/go/internal/work.(*Builder).Do.func1(0x1177ef0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:107 +0x58
  cmd/go/internal/work.(*Builder).Do.func2(0xdf0070, 0xd5cf60, 0x10427a0)
          /usr/local/go/src/cmd/go/internal/work/exec.go:165 +0x84
  created by cmd/go/internal/work.(*Builder).Do
          /usr/local/go/src/cmd/go/internal/work/exec.go:152 +0x2e4

  goroutine 31 [IO wait]:
  internal/poll.runtime_pollWait(0xecac29c0, 0x72, 0x9cc90)
          /usr/local/go/src/runtime/netpoll.go:173 +0x44
  internal/poll.(*pollDesc).wait(0xd7c3d4, 0x72, 0xffffff01, 0x54cc68, 0x7e=
0240)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:85 +0x7c
  internal/poll.(*pollDesc).waitRead(0xd7c3d4, 0x1040601, 0x200, 0x200)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:90 +0x2c
  internal/poll.(*FD).Read(0xd7c3c0, 0x1040600, 0x200, 0x200, 0x0, 0x0, 0x0)
          /usr/local/go/src/internal/poll/fd_unix.go:169 +0x14c
  os.(*File).read(0xe78168, 0x1040600, 0x200, 0x200, 0x1040600, 0x0, 0x0)
          /usr/local/go/src/os/file_unix.go:249 +0x3c
  os.(*File).Read(0xe78168, 0x1040600, 0x200, 0x200, 0xe9d2f000, 0xff667d78=
, 0x3)
          /usr/local/go/src/os/file.go:108 +0x4c
  bytes.(*Buffer).ReadFrom(0xf3e060, 0x54c3f8, 0xe78168, 0xe9d2f000, 0xf3e0=
60, 0x1b001, 0xcf62b0)
          /usr/local/go/src/bytes/buffer.go:206 +0xb0
  io.copyBuffer(0x54bd38, 0xf3e060, 0x54c3f8, 0xe78168, 0x0, 0x0, 0x0, 0x0,=
 0xcf60c0, 0x0, ...)
          /usr/local/go/src/io/io.go:388 +0x300
  io.Copy(0x54bd38, 0xf3e060, 0x54c3f8, 0xe78168, 0x19, 0xfa910, 0xcf6280, =
0xf977dc)
          /usr/local/go/src/io/io.go:364 +0x48
  os/exec.(*Cmd).writerDescriptor.func1(0xcf6280, 0xf977dc)
          /usr/local/go/src/os/exec/exec.go:279 +0x38
  os/exec.(*Cmd).Start.func1(0x10b8000, 0xd280c0)
          /usr/local/go/src/os/exec/exec.go:400 +0x1c
  created by os/exec.(*Cmd).Start
          /usr/local/go/src/os/exec/exec.go:399 +0x41c

  goroutine 30 [IO wait]:
  internal/poll.runtime_pollWait(0xecac2dc0, 0x72, 0x9cc90)
          /usr/local/go/src/runtime/netpoll.go:173 +0x44
  internal/poll.(*pollDesc).wait(0xd7c354, 0x72, 0xffffff01, 0x54cc68, 0x7e=
0240)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:85 +0x7c
  internal/poll.(*pollDesc).waitRead(0xd7c354, 0xddc001, 0x200, 0x200)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:90 +0x2c
  internal/poll.(*FD).Read(0xd7c340, 0xddc000, 0x200, 0x200, 0x0, 0x0, 0x0)
          /usr/local/go/src/internal/poll/fd_unix.go:169 +0x14c
  os.(*File).read(0xe78148, 0xddc000, 0x200, 0x200, 0xddc000, 0x0, 0x0)
          /usr/local/go/src/os/file_unix.go:249 +0x3c
  os.(*File).Read(0xe78148, 0xddc000, 0x200, 0x200, 0xe9d2f000, 0xff667d78,=
 0x5)
          /usr/local/go/src/os/file.go:108 +0x4c
  bytes.(*Buffer).ReadFrom(0xf3e000, 0x54c3f8, 0xe78148, 0xe9d2f000, 0xf3e0=
00, 0x1b001, 0xcf62b0)
          /usr/local/go/src/bytes/buffer.go:206 +0xb0
  io.copyBuffer(0x54bd38, 0xf3e000, 0x54c3f8, 0xe78148, 0x0, 0x0, 0x0, 0x0,=
 0xcf6140, 0x0, ...)
          /usr/local/go/src/io/io.go:388 +0x300
  io.Copy(0x54bd38, 0xf3e000, 0x54c3f8, 0xe78148, 0x0, 0xfa910, 0xcf6280, 0=
xf95fdc)
          /usr/local/go/src/io/io.go:364 +0x48
  os/exec.(*Cmd).writerDescriptor.func1(0xcf6280, 0xf95fdc)
          /usr/local/go/src/os/exec/exec.go:279 +0x38
  os/exec.(*Cmd).Start.func1(0x10b8000, 0xd280a0)
          /usr/local/go/src/os/exec/exec.go:400 +0x1c
  created by os/exec.(*Cmd).Start
          /usr/local/go/src/os/exec/exec.go:399 +0x41c

  goroutine 37 [IO wait]:
  internal/poll.runtime_pollWait(0xecac2f40, 0x72, 0x9cc90)
          /usr/local/go/src/runtime/netpoll.go:173 +0x44
  internal/poll.(*pollDesc).wait(0xdc8514, 0x72, 0xffffff01, 0x54cc68, 0x7e=
0240)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:85 +0x7c
  internal/poll.(*pollDesc).waitRead(0xdc8514, 0x1040801, 0x200, 0x200)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:90 +0x2c
  internal/poll.(*FD).Read(0xdc8500, 0x1040800, 0x200, 0x200, 0x0, 0x0, 0x0)
          /usr/local/go/src/internal/poll/fd_unix.go:169 +0x14c
  os.(*File).read(0xc0e338, 0x1040800, 0x200, 0x200, 0x1040800, 0x0, 0x0)
          /usr/local/go/src/os/file_unix.go:249 +0x3c
  os.(*File).Read(0xc0e338, 0x1040800, 0x200, 0x200, 0xe9d2f000, 0xff669250=
, 0x3)
          /usr/local/go/src/os/file.go:108 +0x4c
  bytes.(*Buffer).ReadFrom(0xca8000, 0x54c3f8, 0xc0e338, 0xe9d2f000, 0xca80=
00, 0x16601, 0xc36f54)
          /usr/local/go/src/bytes/buffer.go:206 +0xb0
  io.copyBuffer(0x54bd38, 0xca8000, 0x54c3f8, 0xc0e338, 0x0, 0x0, 0x0, 0x0,=
 0xd9c0c0, 0x0, ...)
          /usr/local/go/src/io/io.go:388 +0x300
  io.Copy(0x54bd38, 0xca8000, 0x54c3f8, 0xc0e338, 0xd9c100, 0xfa910, 0xd9c1=
00, 0xc36fdc)
          /usr/local/go/src/io/io.go:364 +0x48
  os/exec.(*Cmd).writerDescriptor.func1(0xd9c100, 0xc36fdc)
          /usr/local/go/src/os/exec/exec.go:279 +0x38
  os/exec.(*Cmd).Start.func1(0xf8e0b0, 0xe00190)
          /usr/local/go/src/os/exec/exec.go:400 +0x1c
  created by os/exec.(*Cmd).Start
          /usr/local/go/src/os/exec/exec.go:399 +0x41c

  goroutine 114 [IO wait]:
  internal/poll.runtime_pollWait(0xecac23c0, 0x72, 0x9cc90)
          /usr/local/go/src/runtime/netpoll.go:173 +0x44
  internal/poll.(*pollDesc).wait(0xce8694, 0x72, 0xffffff01, 0x54cc68, 0x7e=
0240)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:85 +0x7c
  internal/poll.(*pollDesc).waitRead(0xce8694, 0x108e001, 0x200, 0x200)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:90 +0x2c
  internal/poll.(*FD).Read(0xce8680, 0x108e000, 0x200, 0x200, 0x0, 0x0, 0x0)
          /usr/local/go/src/internal/poll/fd_unix.go:169 +0x14c
  os.(*File).read(0xe6e1b8, 0x108e000, 0x200, 0x200, 0x108e000, 0x0, 0x0)
          /usr/local/go/src/os/file_unix.go:249 +0x3c
  os.(*File).Read(0xe6e1b8, 0x108e000, 0x200, 0x200, 0xe9d2f000, 0x4e9d0, 0=
xc37f18)
          /usr/local/go/src/os/file.go:108 +0x4c
  bytes.(*Buffer).ReadFrom(0x1024000, 0x54c3f8, 0xe6e1b8, 0xe9d2f000, 0x102=
4000, 0x1177a01, 0xd5cf98)
          /usr/local/go/src/bytes/buffer.go:206 +0xb0
  io.copyBuffer(0x54bd38, 0x1024000, 0x54c3f8, 0xe6e1b8, 0x0, 0x0, 0x0, 0x2=
, 0x0, 0x1, ...)
          /usr/local/go/src/io/io.go:388 +0x300
  io.Copy(0x54bd38, 0x1024000, 0x54c3f8, 0xe6e1b8, 0x1, 0x0, 0x0, 0x0)
          /usr/local/go/src/io/io.go:364 +0x48
  os/exec.(*Cmd).writerDescriptor.func1(0x0, 0x0)
          /usr/local/go/src/os/exec/exec.go:279 +0x38
  os/exec.(*Cmd).Start.func1(0xe14000, 0x1042840)
          /usr/local/go/src/os/exec/exec.go:400 +0x1c
  created by os/exec.(*Cmd).Start
          /usr/local/go/src/os/exec/exec.go:399 +0x41c

  goroutine 115 [IO wait]:
  internal/poll.runtime_pollWait(0xecac22c0, 0x72, 0x9cc90)
          /usr/local/go/src/runtime/netpoll.go:173 +0x44
  internal/poll.(*pollDesc).wait(0xce8714, 0x72, 0xffffff01, 0x54cc68, 0x7e=
0240)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:85 +0x7c
  internal/poll.(*pollDesc).waitRead(0xce8714, 0x108e601, 0x200, 0x200)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:90 +0x2c
  internal/poll.(*FD).Read(0xce8700, 0x108e600, 0x200, 0x200, 0x0, 0x0, 0x0)
          /usr/local/go/src/internal/poll/fd_unix.go:169 +0x14c
  os.(*File).read(0xe6e1d8, 0x108e600, 0x200, 0x200, 0x108e600, 0x0, 0x0)
          /usr/local/go/src/os/file_unix.go:249 +0x3c
  os.(*File).Read(0xe6e1d8, 0x108e600, 0x200, 0x200, 0xe9d2f000, 0x0, 0x0)
          /usr/local/go/src/os/file.go:108 +0x4c
  bytes.(*Buffer).ReadFrom(0xd5c720, 0x54c3f8, 0xe6e1d8, 0xe9d2f000, 0xd5c7=
20, 0x1, 0x0)
          /usr/local/go/src/bytes/buffer.go:206 +0xb0
  io.copyBuffer(0x54bd38, 0xd5c720, 0x54c3f8, 0xe6e1d8, 0x0, 0x0, 0x0, 0x0,=
 0x0, 0x0, ...)
          /usr/local/go/src/io/io.go:388 +0x300
  io.Copy(0x54bd38, 0xd5c720, 0x54c3f8, 0xe6e1d8, 0x0, 0x0, 0x0, 0x0)
          /usr/local/go/src/io/io.go:364 +0x48
  os/exec.(*Cmd).writerDescriptor.func1(0x0, 0x0)
          /usr/local/go/src/os/exec/exec.go:279 +0x38
  os/exec.(*Cmd).Start.func1(0xe14000, 0x1042860)
          /usr/local/go/src/os/exec/exec.go:400 +0x1c
  created by os/exec.(*Cmd).Start
          /usr/local/go/src/os/exec/exec.go:399 +0x41c

  goroutine 116 [IO wait]:
  internal/poll.runtime_pollWait(0xecac2c40, 0x72, 0x9cc90)
          /usr/local/go/src/runtime/netpoll.go:173 +0x44
  internal/poll.(*pollDesc).wait(0xc72214, 0x72, 0xffffff01, 0x54cc68, 0x7e=
0240)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:85 +0x7c
  internal/poll.(*pollDesc).waitRead(0xc72214, 0xea4201, 0x200, 0x200)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:90 +0x2c
  internal/poll.(*FD).Read(0xc72200, 0xea4200, 0x200, 0x200, 0x0, 0x0, 0x0)
          /usr/local/go/src/internal/poll/fd_unix.go:169 +0x14c
  os.(*File).read(0xc7e190, 0xea4200, 0x200, 0x200, 0xea4200, 0x0, 0x0)
          /usr/local/go/src/os/file_unix.go:249 +0x3c
  os.(*File).Read(0xc7e190, 0xea4200, 0x200, 0x200, 0xe9d2f000, 0x3e206820,=
 0x3331203e)
          /usr/local/go/src/os/file.go:108 +0x4c
  bytes.(*Buffer).ReadFrom(0xfc8000, 0x54c3f8, 0xc7e190, 0xe9d2f000, 0xfc80=
00, 0x61686d01, 0x32336873)
          /usr/local/go/src/bytes/buffer.go:206 +0xb0
  io.copyBuffer(0x54bd38, 0xfc8000, 0x54c3f8, 0xc7e190, 0x0, 0x0, 0x0, 0x34=
202b20, 0x7361682a, 0x79656b68, ...)
          /usr/local/go/src/io/io.go:388 +0x300
  io.Copy(0x54bd38, 0xfc8000, 0x54c3f8, 0xc7e190, 0x70283233, 0x68090a29, 0=
x72203d20, 0x5f6c746f)
          /usr/local/go/src/io/io.go:364 +0x48
  os/exec.(*Cmd).writerDescriptor.func1(0x203d5e20, 0x3e3e2068)
          /usr/local/go/src/os/exec/exec.go:279 +0x38
  os/exec.(*Cmd).Start.func1(0x11760b0, 0xe28040)
          /usr/local/go/src/os/exec/exec.go:400 +0x1c
  created by os/exec.(*Cmd).Start
          /usr/local/go/src/os/exec/exec.go:399 +0x41c

  goroutine 117 [IO wait]:
  internal/poll.runtime_pollWait(0xecac2740, 0x72, 0x9cc90)
          /usr/local/go/src/runtime/netpoll.go:173 +0x44
  internal/poll.(*pollDesc).wait(0xc72294, 0x72, 0xffffff01, 0x54cc68, 0x7e=
0240)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:85 +0x7c
  internal/poll.(*pollDesc).waitRead(0xc72294, 0xea4001, 0x200, 0x200)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:90 +0x2c
  internal/poll.(*FD).Read(0xc72280, 0xea4000, 0x200, 0x200, 0x0, 0x0, 0x0)
          /usr/local/go/src/internal/poll/fd_unix.go:169 +0x14c
  os.(*File).read(0xc7e1b8, 0xea4000, 0x200, 0x200, 0xea4000, 0x0, 0x0)
          /usr/local/go/src/os/file_unix.go:249 +0x3c
  os.(*File).Read(0xc7e1b8, 0xea4000, 0x200, 0x200, 0xe9d2f000, 0x0, 0x0)
          /usr/local/go/src/os/file.go:108 +0x4c
  bytes.(*Buffer).ReadFrom(0xfc8060, 0x54c3f8, 0xc7e1b8, 0xe9d2f000, 0xfc80=
60, 0x1, 0x0)
          /usr/local/go/src/bytes/buffer.go:206 +0xb0
  io.copyBuffer(0x54bd38, 0xfc8060, 0x54c3f8, 0xc7e1b8, 0x0, 0x0, 0x0, 0x0,=
 0x0, 0x0, ...)
          /usr/local/go/src/io/io.go:388 +0x300
  io.Copy(0x54bd38, 0xfc8060, 0x54c3f8, 0xc7e1b8, 0x0, 0x0, 0x0, 0x0)
          /usr/local/go/src/io/io.go:364 +0x48
  os/exec.(*Cmd).writerDescriptor.func1(0x0, 0x0)
          /usr/local/go/src/os/exec/exec.go:279 +0x38
  os/exec.(*Cmd).Start.func1(0x11760b0, 0xe28070)
          /usr/local/go/src/os/exec/exec.go:400 +0x1c
  created by os/exec.(*Cmd).Start
          /usr/local/go/src/os/exec/exec.go:399 +0x41c

  goroutine 130 [IO wait]:
  internal/poll.runtime_pollWait(0xecac25c0, 0x72, 0x9cc90)
          /usr/local/go/src/runtime/netpoll.go:173 +0x44
  internal/poll.(*pollDesc).wait(0xc8a114, 0x72, 0xffffff01, 0x54cc68, 0x7e=
0240)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:85 +0x7c
  internal/poll.(*pollDesc).waitRead(0xc8a114, 0xea4401, 0x200, 0x200)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:90 +0x2c
  internal/poll.(*FD).Read(0xc8a100, 0xea4400, 0x200, 0x200, 0x0, 0x0, 0x0)
          /usr/local/go/src/internal/poll/fd_unix.go:169 +0x14c
  os.(*File).read(0x1112058, 0xea4400, 0x200, 0x200, 0xea4400, 0x0, 0x0)
          /usr/local/go/src/os/file_unix.go:249 +0x3c
  os.(*File).Read(0x1112058, 0xea4400, 0x200, 0x200, 0xe9d2f000, 0x0, 0x0)
          /usr/local/go/src/os/file.go:108 +0x4c
  bytes.(*Buffer).ReadFrom(0xe10000, 0x54c3f8, 0x1112058, 0xe9d2f000, 0xe10=
000, 0x1177d01, 0xd5cf98)
          /usr/local/go/src/bytes/buffer.go:206 +0xb0
  io.copyBuffer(0x54bd38, 0xe10000, 0x54c3f8, 0x1112058, 0x0, 0x0, 0x0, 0x2=
, 0x0, 0x1, ...)
          /usr/local/go/src/io/io.go:388 +0x300
  io.Copy(0x54bd38, 0xe10000, 0x54c3f8, 0x1112058, 0x1, 0x0, 0x0, 0x0)
          /usr/local/go/src/io/io.go:364 +0x48
  os/exec.(*Cmd).writerDescriptor.func1(0x0, 0x0)
          /usr/local/go/src/os/exec/exec.go:279 +0x38
  os/exec.(*Cmd).Start.func1(0xfe8000, 0x100e040)
          /usr/local/go/src/os/exec/exec.go:400 +0x1c
  created by os/exec.(*Cmd).Start
          /usr/local/go/src/os/exec/exec.go:399 +0x41c

  goroutine 131 [IO wait]:
  internal/poll.runtime_pollWait(0xecac24c0, 0x72, 0x9cc90)
          /usr/local/go/src/runtime/netpoll.go:173 +0x44
  internal/poll.(*pollDesc).wait(0xc8a214, 0x72, 0xffffff01, 0x54cc68, 0x7e=
0240)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:85 +0x7c
  internal/poll.(*pollDesc).waitRead(0xc8a214, 0x1044001, 0x200, 0x200)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:90 +0x2c
  internal/poll.(*FD).Read(0xc8a200, 0x1044000, 0x200, 0x200, 0x0, 0x0, 0x0)
          /usr/local/go/src/internal/poll/fd_unix.go:169 +0x14c
  os.(*File).read(0x1112078, 0x1044000, 0x200, 0x200, 0x1044000, 0x0, 0x0)
          /usr/local/go/src/os/file_unix.go:249 +0x3c
  os.(*File).Read(0x1112078, 0x1044000, 0x200, 0x200, 0xe9d2f000, 0xa, 0x2)
          /usr/local/go/src/os/file.go:108 +0x4c
  bytes.(*Buffer).ReadFrom(0xe10060, 0x54c3f8, 0x1112078, 0xe9d2f000, 0xe10=
060, 0x1, 0x2)
          /usr/local/go/src/bytes/buffer.go:206 +0xb0
  io.copyBuffer(0x54bd38, 0xe10060, 0x54c3f8, 0x1112078, 0x0, 0x0, 0x0, 0xe=
e3e90, 0x27, 0xd2, ...)
          /usr/local/go/src/io/io.go:388 +0x300
  io.Copy(0x54bd38, 0xe10060, 0x54c3f8, 0x1112078, 0x2, 0xedca50, 0x2b, 0xb=
c)
          /usr/local/go/src/io/io.go:364 +0x48
  os/exec.(*Cmd).writerDescriptor.func1(0x0, 0x0)
          /usr/local/go/src/os/exec/exec.go:279 +0x38
  os/exec.(*Cmd).Start.func1(0xfe8000, 0x100e060)
          /usr/local/go/src/os/exec/exec.go:400 +0x1c
  created by os/exec.(*Cmd).Start
          /usr/local/go/src/os/exec/exec.go:399 +0x41c

  goroutine 132 [IO wait]:
  internal/poll.runtime_pollWait(0xecac2240, 0x72, 0x9cc90)
          /usr/local/go/src/runtime/netpoll.go:173 +0x44
  internal/poll.(*pollDesc).wait(0xdc82d4, 0x72, 0xffffff01, 0x54cc68, 0x7e=
0240)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:85 +0x7c
  internal/poll.(*pollDesc).waitRead(0xdc82d4, 0x1044201, 0x200, 0x200)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:90 +0x2c
  internal/poll.(*FD).Read(0xdc82c0, 0x1044200, 0x200, 0x200, 0x0, 0x0, 0x0)
          /usr/local/go/src/internal/poll/fd_unix.go:169 +0x14c
  os.(*File).read(0xc0e270, 0x1044200, 0x200, 0x200, 0x1044200, 0x0, 0x0)
          /usr/local/go/src/os/file_unix.go:249 +0x3c
  os.(*File).Read(0xc0e270, 0x1044200, 0x200, 0x200, 0xe9d2f000, 0x0, 0x0)
          /usr/local/go/src/os/file.go:108 +0x4c
  bytes.(*Buffer).ReadFrom(0xcb5800, 0x54c3f8, 0xc0e270, 0xe9d2f000, 0xcb58=
00, 0x1, 0x0)
          /usr/local/go/src/bytes/buffer.go:206 +0xb0
  io.copyBuffer(0x54bd38, 0xcb5800, 0x54c3f8, 0xc0e270, 0x0, 0x0, 0x0, 0x0,=
 0x0, 0x0, ...)
          /usr/local/go/src/io/io.go:388 +0x300
  io.Copy(0x54bd38, 0xcb5800, 0x54c3f8, 0xc0e270, 0x0, 0x0, 0x0, 0x0)
          /usr/local/go/src/io/io.go:364 +0x48
  os/exec.(*Cmd).writerDescriptor.func1(0x0, 0xcc9f80)
          /usr/local/go/src/os/exec/exec.go:279 +0x38
  os/exec.(*Cmd).Start.func1(0xf8e000, 0xe000c0)
          /usr/local/go/src/os/exec/exec.go:400 +0x1c
  created by os/exec.(*Cmd).Start
          /usr/local/go/src/os/exec/exec.go:399 +0x41c

  goroutine 133 [IO wait]:
  internal/poll.runtime_pollWait(0xecac27c0, 0x72, 0x9cc90)
          /usr/local/go/src/runtime/netpoll.go:173 +0x44
  internal/poll.(*pollDesc).wait(0xdc8354, 0x72, 0xffffff01, 0x54cc68, 0x7e=
0240)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:85 +0x7c
  internal/poll.(*pollDesc).waitRead(0xdc8354, 0x1040401, 0x200, 0x200)
          /usr/local/go/src/internal/poll/fd_poll_runtime.go:90 +0x2c
  internal/poll.(*FD).Read(0xdc8340, 0x1040400, 0x200, 0x200, 0x0, 0x0, 0x0)
          /usr/local/go/src/internal/poll/fd_unix.go:169 +0x14c
  os.(*File).read(0xc0e298, 0x1040400, 0x200, 0x200, 0x1040400, 0x0, 0x0)
          /usr/local/go/src/os/file_unix.go:249 +0x3c
  os.(*File).Read(0xc0e298, 0x1040400, 0x200, 0x200, 0xe9d2f000, 0x0, 0x10b=
81d0)
          /usr/local/go/src/os/file.go:108 +0x4c
  bytes.(*Buffer).ReadFrom(0xcb5e00, 0x54c3f8, 0xc0e298, 0xe9d2f000, 0xcb5e=
00, 0x1, 0x0)
          /usr/local/go/src/bytes/buffer.go:206 +0xb0
  io.copyBuffer(0x54bd38, 0xcb5e00, 0x54c3f8, 0xc0e298, 0x0, 0x0, 0x0, 0x0,=
 0x0, 0x0, ...)
          /usr/local/go/src/io/io.go:388 +0x300
  io.Copy(0x54bd38, 0xcb5e00, 0x54c3f8, 0xc0e298, 0x0, 0x0, 0x0, 0x0)
          /usr/local/go/src/io/io.go:364 +0x48
  os/exec.(*Cmd).writerDescriptor.func1(0x0, 0x0)
          /usr/local/go/src/os/exec/exec.go:279 +0x38
  os/exec.(*Cmd).Start.func1(0xf8e000, 0xe000e0)
          /usr/local/go/src/os/exec/exec.go:400 +0x1c
  created by os/exec.(*Cmd).Start
          /usr/local/go/src/os/exec/exec.go:399 +0x41c
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault (core dumped)


  =

  --------------

  With newer golang version
  go version
  go version go1.11.9 linux/arm
  - show quoted text -
  GOGCCFLAGS=3D"-fPIC -marm -pthread -fmessage-length=3D0 -fdebug-prefix-ma=
p=3D/tmp/go-build218432843=3D/tmp/go-build -gno-record-gcc-switches"

  =

  $ /usr/local/go/bin/go get -v github.com/Azure/sonic-telemetry/dialout/di=
alout_client_cli
  panic: runtime error: invalid memory address or nil pointer dereference
  [signal SIGSEGV: segmentation violation code=3D0x1 addr=3D0x0 pc=3D0x6618=
0]

  goroutine 11fatal error:  [malloc deadlock
  , panic during panic
  [signal SIGSEGV: segmentation violation code=3D0x1 addr=3D0x0 pc=3D0x6618=
0]

  108033889401^Ifatal error: unexpected signal during runtime execution
  stack trace unavailable

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1838946/+subscriptions

