Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAB6C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 08:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A410C21842
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 08:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A410C21842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpqb5-0005v0-1F
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 04:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38100)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hpqag-0004hf-0l
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 04:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hpqaU-0001YT-Ja
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 04:56:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:53054)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hpqaI-0001Hy-Fq
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 04:55:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hpqaH-0003u3-5j
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 08:55:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1CEC72E8005
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 08:55:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jul 2019 08:48:39 -0000
From: =?utf-8?q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: edward-vielmetti pawel-moll will-newton
X-Launchpad-Bug-Reporter: Will Newton (will-newton)
X-Launchpad-Bug-Modifier: =?utf-8?q?Pawe=C5=82_Moll_=28pawel-moll=29?=
References: <149693268144.10005.16353270944603688746.malonedeb@wampee.canonical.com>
Message-Id: <156387171944.14976.10823269220178795356.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 36cfdaecaee01278ea52149241a104d282498650
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1696773] Re: golang calls to exec crash user
 emulation
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
Reply-To: Bug 1696773 <1696773@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Observed the same here... (details of the environment at the end of the
post)

Just building a hello world is good enough to crash go 3 times out of 4:

--8<---------------------------------------------------------------------
ubuntu@qemu:~$ cat <<EOF > hello.go
> package main
> =

> import "fmt"
> =

> func main() {
>   fmt.Println("Hello")
> }
> EOF

--8<---------------------------------------------------------------------

If I build it with affinity set to a single CPU, all is fine:

ubuntu@qemu:~$ taskset -c 1 /usr/bin/qemu-aarch64-static /usr/lib/go-1.10/b=
in/go build
ubuntu@qemu:~$ taskset -c 1 /usr/bin/qemu-aarch64-static /usr/lib/go-1.10/b=
in/go build
ubuntu@qemu:~$ taskset -c 1 /usr/bin/qemu-aarch64-static /usr/lib/go-1.10/b=
in/go build
ubuntu@qemu:~$ taskset -c 1 /usr/bin/qemu-aarch64-static /usr/lib/go-1.10/b=
in/go build


But with the go build going multithreaded, all sorts of hells break loose:

--8<---------------------------------------------------------------------
ubuntu@qemu:~$ /usr/bin/qemu-aarch64-static /usr/lib/go-1.10/bin/go build
fatal error: exitsyscall: syscall frame is no longer valid
fatal error: malloc deadlock
panic during panic

runtime stack:
runtime.startpanic_m()
	/usr/lib/go-1.10/src/runtime/panic.go:690 +fatal error: unexpected signal =
during runtime execution
0x178stack trace unavailable
--8<---------------------------------------------------------------------

or this:

--8<---------------------------------------------------------------------
ubuntu@qemu:~$ /usr/bin/qemu-aarch64-static /usr/lib/go-1.10/bin/go build
fatal error: unexpected signal value
panic during panic

goroutine 0 [idle]:
runtime: unexpected return pc for runtime.sigtramp called from 0x14420009ff0
stack: frame=3D{sp:0x14420007900, fp:0x14420007920} stack=3D[0x14420002000,=
0x1442000a000)
0000014420007800:  0000000000000000  0000000000000084 =

0000014420007810:  000000000043d694 <runtime.sigtrampgo+44>  00000000000000=
00 =

0000014420007820:  0000000000000000  0000000000000000 =

0000014420007830:  00000144200ae000  0000000000000000 =

0000014420007840:  0000014420007920  00000144200079a0 =

0000014420007850:  000000000045266c <runtime.sigtramp+52>  0000014400000004 =

0000014420007860:  0000014420007920  00000144200079a0 =

0000014420007870:  00000144200ae180  0000000000000000 =

0000014420007880:  0000000000000000  0000000000000000 =

0000014420007890:  0000000000000000  0000000000000000 =

00000144200078a0:  0000000000000000  0000000000000000 =

00000144200078b0:  0000000000000000  00000144200ae180 =

00000144200078c0:  0000000000000000  0000000000000000 =

00000144200078d0:  0000000000000000  0000000000000000 =

00000144200078e0:  0000000000000000  0000000000000000 =

00000144200078f0:  0000000000000000  0000000000000000 =

0000014420007900: <0000014420009ff0  0000000000000004 =

0000014420007910:  0000014420007920  00000144200079a0 =

0000014420007920: >0000000000000004  0000000000000002 =

0000014420007930:  00000144201a4180  0000000000000000 =

0000014420007940:  000000000000000c  0000000000000001 =

0000014420007950:  0000000000000000  0000000000000000 =

0000014420007960:  0000000000000000  0000000000000000 =

0000014420007970:  0000000000000000  0000000000000000 =

0000014420007980:  0000000000000000  0000000000000000 =

0000014420007990:  0000000000000000  0000000000000000 =

00000144200079a0:  0000000000000000  0000000000000000 =

00000144200079b0:  0000014420002000  0000000000000000 =

00000144200079c0:  0000000000008000  0000000000000000 =

00000144200079d0:  0000000000000000  0000000000000000 =

00000144200079e0:  0000000000000000  0000000000000000 =

00000144200079f0:  0000000000000000  0000000000000000 =

0000014420007a00:  0000000000000000  0000000000000000 =

0000014420007a10:  0000000000000000  0000000000000000 =

runtime.startpanic_m()
	/usr/lib/go-1.10/src/runtime/panic.go:690 +0x178
runtime.startpanic()
	/usr/lib/go-1.10/src/runtime/panic.go:589 +0x14
runtime.sighandler(0x14400000004, 0x14420007920, 0x144200079a0, 0x144200ae1=
80)
	/usr/lib/go-1.10/src/runtime/signal_sighandler.go:86 +0x4c4
runtime.sigtrampgo(0x4, 0x14420007920, 0x144200079a0)
	/usr/lib/go-1.10/src/runtime/signal_unix.go:349 +0x19c
runtime: unexpected return pc for runtime.sigtramp called from 0x14420009ff0
stack: frame=3D{sp:0x14420007900, fp:0x14420007920} stack=3D[0x14420002000,=
0x1442000a000)
0000014420007800:  0000000000000000  0000000000000084 =

0000014420007810:  000000000043d694 <runtime.sigtrampgo+44>  00000000000000=
00 =

0000014420007820:  0000000000000000  0000000000000000 =

0000014420007830:  00000144200ae000  0000000000000000 =

0000014420007840:  0000014420007920  00000144200079a0 =

0000014420007850:  000000000045266c <runtime.sigtramp+52>  0000014400000004 =

0000014420007860:  0000014420007920  00000144200079a0 =

0000014420007870:  00000144200ae180  0000000000000000 =

0000014420007880:  0000000000000000  0000000000000000 =

0000014420007890:  0000000000000000  0000000000000000 =

00000144200078a0:  0000000000000000  0000000000000000 =

00000144200078b0:  0000000000000000  00000144200ae180 =

00000144200078c0:  0000000000000000  0000000000000000 =

00000144200078d0:  0000000000000000  0000000000000000 =

00000144200078e0:  0000000000000000  0000000000000000 =

00000144200078f0:  0000000000000000  0000000000000000 =

0000014420007900: <0000014420009ff0  0000000000000004 =

0000014420007910:  0000014420007920  00000144200079a0 =

0000014420007920: >0000000000000004  0000000000000002 =

0000014420007930:  00000144201a4180  0000000000000000 =

0000014420007940:  000000000000000c  0000000000000001 =

0000014420007950:  0000000000000000  0000000000000000 =

0000014420007960:  0000000000000000  0000000000000000 =

0000014420007970:  0000000000000000  0000000000000000 =

0000014420007980:  0000000000000000  0000000000000000 =

0000014420007990:  0000000000000000  0000000000000000 =

00000144200079a0:  0000000000000000  0000000000000000 =

00000144200079b0:  0000014420002000  0000000000000000 =

00000144200079c0:  0000000000008000  0000000000000000 =

00000144200079d0:  0000000000000000  0000000000000000 =

00000144200079e0:  0000000000000000  0000000000000000 =

00000144200079f0:  0000000000000000  0000000000000000 =

0000014420007a00:  0000000000000000  0000000000000000 =

0000014420007a10:  0000000000000000  0000000000000000 =

runtime.sigtramp(0x2, 0x144201a4180, 0x0, 0xc, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0=
, ...)
	/usr/lib/go-1.10/src/runtime/sys_linux_arm64.s:263 +0x34

goroutine 88 [syscall]:
syscall.Syscall6(0x5f, 0x1, 0x2039, 0x144205909a0, 0x1000004, 0x0, 0x0, 0x1=
44201a2320, 0x144200ac000, 0x40009efaf8)
	/usr/lib/go-1.10/src/syscall/asm_linux_arm64.s:36 +0x8 fp=3D0x14420590940 =
sp=3D0x14420590930 pc=3D0x471870
os.(*Process).blockUntilWaitable(0x1442036c000, 0x0, 0x0, 0x410a64)
	/usr/lib/go-1.10/src/os/wait_waitid.go:31 +0x64 fp=3D0x14420590a40 sp=3D0x=
14420590940 pc=3D0x49077c
os.(*Process).wait(0x1442036c000, 0x14420262310, 0x144205841e0, 0x144203d63=
98)
	/usr/lib/go-1.10/src/os/exec_unix.go:22 +0x2c fp=3D0x14420590ac0 sp=3D0x14=
420590a40 pc=3D0x48a234
os.(*Process).Wait(0x1442036c000, 0x0, 0x0, 0x856708)
	/usr/lib/go-1.10/src/os/exec.go:123 +0x20 fp=3D0x14420590af0 sp=3D0x144205=
90ac0 pc=3D0x489898
os/exec.(*Cmd).Wait(0x144203d62c0, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:461 +0x3c fp=3D0x14420590b70 sp=3D0x1=
4420590af0 pc=3D0x4e1354
os/exec.(*Cmd).Run(0x144203d62c0, 0x144200f6150, 0x14420440840)
	/usr/lib/go-1.10/src/os/exec/exec.go:305 +0x48 fp=3D0x14420590b90 sp=3D0x1=
4420590b70 pc=3D0x4e0ad0
cmd/go/internal/work.(*Builder).toolID(0x1442029c0a0, 0x826cab, 0x3, 0x11, =
0x14420591290)
	/usr/lib/go-1.10/src/cmd/go/internal/work/buildid.go:183 +0x274 fp=3D0x144=
20590d40 sp=3D0x14420590b90 pc=3D0x5bc57c
cmd/go/internal/work.(*Builder).buildActionID(0x1442029c0a0, 0x144201537c0,=
 0x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:221 +0x116c fp=3D0x14420=
591450 sp=3D0x14420590d40 pc=3D0x5c0e04
cmd/go/internal/work.(*Builder).build(0x1442029c0a0, 0x144201537c0, 0x0, 0x=
0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:304 +0x64 fp=3D0x1442059=
1e70 sp=3D0x14420591450 pc=3D0x5c153c
cmd/go/internal/work.(*Builder).Do.func1(0x144201537c0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:106 +0x50 fp=3D0x1442059=
1ef0 sp=3D0x14420591e70 pc=3D0x5e7cd8
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:164 +0x8c fp=3D0x1442059=
1fc0 sp=3D0x14420591ef0 pc=3D0x5e7f74
runtime.goexit()
	/usr/lib/go-1.10/src/runtime/asm_arm64.s:1037 +0x4 fp=3D0x14420591fc0 sp=
=3D0x14420591fc0 pc=3D0x451cec
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 1 [semacquire]:
sync.runtime_Semacquire(0x1442027725c)
	/usr/lib/go-1.10/src/runtime/sema.go:56 +0x2c
sync.(*WaitGroup).Wait(0x14420277250)
	/usr/lib/go-1.10/src/sync/waitgroup.go:129 +0x68
cmd/go/internal/work.(*Builder).Do(0x1442029c0a0, 0x14420152c80)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:173 +0x36c
cmd/go/internal/work.runBuild(0xa5d0a0, 0x144200da010, 0x0, 0x0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/build.go:325 +0x4bc
main.main()
	/usr/lib/go-1.10/src/cmd/go/main.go:140 +0x6f4

goroutine 19 [syscall]:
os/signal.signal_recv(0x0)
	/usr/lib/go-1.10/src/runtime/sigqueue.go:139 +0xc8
os/signal.loop()
	/usr/lib/go-1.10/src/os/signal/signal_unix.go:22 +0x18
created by os/signal.init.0
	/usr/lib/go-1.10/src/os/signal/signal_unix.go:28 +0x30

goroutine 11 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 12 [syscall]:
syscall.Syscall6(0x5f, 0x1, 0x2008, 0x1442059e9a0, 0x1000004, 0x0, 0x0, 0x1=
44203d8140, 0x1442006ec00, 0x40009e31e8)
	/usr/lib/go-1.10/src/syscall/asm_linux_arm64.s:36 +0x8
os.(*Process).blockUntilWaitable(0x144203e2240, 0x0, 0x0, 0x410a64)
	/usr/lib/go-1.10/src/os/wait_waitid.go:31 +0x64
os.(*Process).wait(0x144203e2240, 0x1442026a180, 0x14420544020, 0x1442058a2=
38)
	/usr/lib/go-1.10/src/os/exec_unix.go:22 +0x2c
os.(*Process).Wait(0x144203e2240, 0x0, 0x0, 0x856708)
	/usr/lib/go-1.10/src/os/exec.go:123 +0x20
os/exec.(*Cmd).Wait(0x1442058a160, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:461 +0x3c
os/exec.(*Cmd).Run(0x1442058a160, 0x14420132150, 0x14420318840)
	/usr/lib/go-1.10/src/os/exec/exec.go:305 +0x48
cmd/go/internal/work.(*Builder).toolID(0x1442029c0a0, 0x8285a2, 0x7, 0x2c, =
0x1442059f320)
	/usr/lib/go-1.10/src/cmd/go/internal/work/buildid.go:183 +0x274
cmd/go/internal/work.(*Builder).buildActionID(0x1442029c0a0, 0x1442017c8c0,=
 0x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:219 +0xbec
cmd/go/internal/work.(*Builder).build(0x1442029c0a0, 0x1442017c8c0, 0x0, 0x=
0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:304 +0x64
cmd/go/internal/work.(*Builder).Do.func1(0x1442017c8c0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:106 +0x50
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:164 +0x8c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 13 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 14 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 15 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 16 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 82 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 83 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 84 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 85 [runnable]:
os.(*File).Read(0x144200d4060, 0x144202ac000, 0x8000, 0x8000, 0x8000, 0x800=
0, 0x7ed900)
	/usr/lib/go-1.10/src/os/file.go:103 +0x24c
io.copyBuffer(0x40b3596000, 0x144203f8000, 0x894040, 0x144200d4060, 0x14420=
2ac000, 0x8000, 0x8000, 0x7ed900, 0x144200d4000, 0x40b3596000)
	/usr/lib/go-1.10/src/io/io.go:400 +0x100
io.Copy(0x40b3596000, 0x144203f8000, 0x894040, 0x144200d4060, 0x144203f8000=
, 0x0, 0x29)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
cmd/go/internal/cache.FileHash(0x144200cc8a0, 0x29, 0x0, 0x0, 0x0, 0x0, 0x1=
44200cc8a0, 0x29)
	/usr/lib/go-1.10/src/cmd/go/internal/cache/hash.go:149 +0x228
cmd/go/internal/work.(*Builder).fileHash(0x1442029c0a0, 0x144200cc8a0, 0x29=
, 0x144200cc8a0, 0x29)
	/usr/lib/go-1.10/src/cmd/go/internal/work/buildid.go:358 +0x28
cmd/go/internal/work.(*Builder).buildActionID(0x1442029c0a0, 0x14420153400,=
 0x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:286 +0x650
cmd/go/internal/work.(*Builder).build(0x1442029c0a0, 0x14420153400, 0x0, 0x=
0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:304 +0x64
cmd/go/internal/work.(*Builder).Do.func1(0x14420153400)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:106 +0x50
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:164 +0x8c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 86 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 87 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 89 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 90 [syscall]:
syscall.Syscall6(0x5f, 0x1, 0x1ffd, 0x1442058e9a0, 0x1000004, 0x0, 0x0, 0x1=
4420236140, 0x1442006f400, 0x40009e2b20)
	/usr/lib/go-1.10/src/syscall/asm_linux_arm64.s:36 +0x8
os.(*Process).blockUntilWaitable(0x1442055a300, 0x0, 0x0, 0x410a64)
	/usr/lib/go-1.10/src/os/wait_waitid.go:31 +0x64
os.(*Process).wait(0x1442055a300, 0x144201f6110, 0x144205d6040, 0x144202a00=
d8)
	/usr/lib/go-1.10/src/os/exec_unix.go:22 +0x2c
os.(*Process).Wait(0x1442055a300, 0x0, 0x0, 0x856708)
	/usr/lib/go-1.10/src/os/exec.go:123 +0x20
os/exec.(*Cmd).Wait(0x144202a0000, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:461 +0x3c
os/exec.(*Cmd).Run(0x144202a0000, 0x14420144070, 0x144205de580)
	/usr/lib/go-1.10/src/os/exec/exec.go:305 +0x48
cmd/go/internal/work.(*Builder).toolID(0x1442029c0a0, 0x8285a2, 0x7, 0x2c, =
0x1442058f320)
	/usr/lib/go-1.10/src/cmd/go/internal/work/buildid.go:183 +0x274
cmd/go/internal/work.(*Builder).buildActionID(0x1442029c0a0, 0x1442017c780,=
 0x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:219 +0xbec
cmd/go/internal/work.(*Builder).build(0x1442029c0a0, 0x1442017c780, 0x0, 0x=
0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:304 +0x64
cmd/go/internal/work.(*Builder).Do.func1(0x1442017c780)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:106 +0x50
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:164 +0x8c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 91 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 92 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 93 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 94 [syscall]:
syscall.Syscall6(0x5f, 0x1, 0x2036, 0x1442058c9a0, 0x1000004, 0x0, 0x0, 0x1=
44203d8320, 0x1442038ec00, 0x40009ef430)
	/usr/lib/go-1.10/src/syscall/asm_linux_arm64.s:36 +0x8
os.(*Process).blockUntilWaitable(0x144200284b0, 0x0, 0x0, 0x410a64)
	/usr/lib/go-1.10/src/os/wait_waitid.go:31 +0x64
os.(*Process).wait(0x144200284b0, 0x1442026a2a0, 0x144205441a0, 0x1442058a4=
f8)
	/usr/lib/go-1.10/src/os/exec_unix.go:22 +0x2c
os.(*Process).Wait(0x144200284b0, 0x0, 0x0, 0x856708)
	/usr/lib/go-1.10/src/os/exec.go:123 +0x20
os/exec.(*Cmd).Wait(0x1442058a420, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:461 +0x3c
os/exec.(*Cmd).Run(0x1442058a420, 0x144201322a0, 0x14420319080)
	/usr/lib/go-1.10/src/os/exec/exec.go:305 +0x48
cmd/go/internal/work.(*Builder).toolID(0x1442029c0a0, 0x826cab, 0x3, 0x11, =
0x1442058d290)
	/usr/lib/go-1.10/src/cmd/go/internal/work/buildid.go:183 +0x274
cmd/go/internal/work.(*Builder).buildActionID(0x1442029c0a0, 0x14420153a40,=
 0x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:221 +0x116c
cmd/go/internal/work.(*Builder).build(0x1442029c0a0, 0x14420153a40, 0x0, 0x=
0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:304 +0x64
cmd/go/internal/work.(*Builder).Do.func1(0x14420153a40)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:106 +0x50
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:164 +0x8c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 95 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 96 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 97 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 98 [syscall]:
syscall.Syscall6(0x5f, 0x1, 0x2033, 0x1442059c9a0, 0x1000004, 0x0, 0x0, 0x1=
4420274730, 0x144205b0000, 0x40009e2b20)
	/usr/lib/go-1.10/src/syscall/asm_linux_arm64.s:36 +0x8
os.(*Process).blockUntilWaitable(0x1442055a660, 0x0, 0x0, 0x410a64)
	/usr/lib/go-1.10/src/os/wait_waitid.go:31 +0x64
os.(*Process).wait(0x1442055a660, 0x144200c4380, 0x1442033e1a0, 0x144200eee=
98)
	/usr/lib/go-1.10/src/os/exec_unix.go:22 +0x2c
os.(*Process).Wait(0x1442055a660, 0x0, 0x0, 0x856708)
	/usr/lib/go-1.10/src/os/exec.go:123 +0x20
os/exec.(*Cmd).Wait(0x144200eedc0, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:461 +0x3c
os/exec.(*Cmd).Run(0x144200eedc0, 0x144201123f0, 0x144205e0dc0)
	/usr/lib/go-1.10/src/os/exec/exec.go:305 +0x48
cmd/go/internal/work.(*Builder).toolID(0x1442029c0a0, 0x826cab, 0x3, 0x11, =
0x1442059d290)
	/usr/lib/go-1.10/src/cmd/go/internal/work/buildid.go:183 +0x274
cmd/go/internal/work.(*Builder).buildActionID(0x1442029c0a0, 0x14420153cc0,=
 0x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:221 +0x116c
cmd/go/internal/work.(*Builder).build(0x1442029c0a0, 0x14420153cc0, 0x0, 0x=
0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:304 +0x64
cmd/go/internal/work.(*Builder).Do.func1(0x14420153cc0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:106 +0x50
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:164 +0x8c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 99 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x14420277250, 0x1442029c0a0, 0x14=
4201ae940)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 133 [IO wait]:
internal/poll.runtime_pollWait(0x4089492918, 0x72, 0x144201aa000)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x144203d82e8, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x144203d82e8, 0x144201aa001, 0x200, 0x2=
00)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x144203d82d0, 0x144201aa000, 0x200, 0x200, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x144203da060, 0x144201aa000, 0x200, 0x200, 0x144201aa000, =
0x0, 0x0)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x144203da060, 0x144201aa000, 0x200, 0x200, 0x14420268528, =
0x1, 0x0)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x144201322a0, 0x894040, 0x144203da060, 0x40ab5560=
00, 0x144201322a0, 0x404701)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x144201322a0, 0x894040, 0x144203da060, 0x0, 0x0, 0=
x0, 0x4e37c4, 0x14420268500, 0x0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x144201322a0, 0x894040, 0x144203da060, 0x0, 0x4e3830, 0x=
1442016a060)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x1442016a060, 0x1442046bfb0)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x1442058a420, 0x14420544240)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 73 [runnable]:
internal/poll.runtime_pollWait(0x4089492d28, 0x72, 0x144202b4019)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x14420236068, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x14420236068, 0x144202b4001, 0x5e7, 0x5=
e7)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x14420236050, 0x144202b4019, 0x5e7, 0x5e7, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x1442008a010, 0x144202b4019, 0x5e7, 0x5e7, 0x144202b4000, =
0x144201a6000, 0x19)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x1442008a010, 0x144202b4019, 0x5e7, 0x5e7, 0x19, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x14420144000, 0x894040, 0x1442008a010, 0x40ab5560=
00, 0x14420144000, 0x1442047de01)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x14420144000, 0x894040, 0x1442008a010, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x14420144000, 0x894040, 0x1442008a010, 0x0, 0x144201b018=
0, 0x5e7fc4)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x5e7fe8, 0x1)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x144202a0000, 0x144205d60a0)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 74 [runnable]:
internal/poll.runtime_pollWait(0x4089492b88, 0x72, 0x144204e4200)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x14420236108, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x14420236108, 0x144204e4201, 0x200, 0x2=
00)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x144202360f0, 0x144204e4200, 0x200, 0x200, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x1442008a028, 0x144204e4200, 0x200, 0x200, 0x144204e4200, =
0x0, 0x0)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x1442008a028, 0x144204e4200, 0x200, 0x200, 0x0, 0x0, 0x144=
201a51b8)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x14420144070, 0x894040, 0x1442008a028, 0x40ab5560=
00, 0x14420144070, 0x1442047d601)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x14420144070, 0x894040, 0x1442008a028, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x14420144070, 0x894040, 0x1442008a028, 0x0, 0x144201b018=
0, 0x5e7fc4)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x5e7fe8, 0x1)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x144202a0000, 0x144205d60e0)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 132 [IO wait]:
internal/poll.runtime_pollWait(0x4089492ec8, 0x72, 0x144204a4000)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x144203d8248, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x144203d8248, 0x144204a4001, 0x200, 0x2=
00)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x144203d8230, 0x144204a4000, 0x200, 0x200, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x144203da048, 0x144204a4000, 0x200, 0x200, 0x144204a4000, =
0x0, 0x0)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x144203da048, 0x144204a4000, 0x200, 0x200, 0x144200d62a8, =
0x1, 0x0)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x144201321c0, 0x894040, 0x144203da048, 0x40ab5560=
00, 0x144201321c0, 0x404701)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x144201321c0, 0x894040, 0x144203da048, 0x0, 0x0, 0=
x0, 0x4e37c4, 0x144200d6280, 0x0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x144201321c0, 0x894040, 0x144203da048, 0x0, 0x4e3830, 0x=
144200aa0c0)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x144200aa0c0, 0x14420537fb0)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x1442058a420, 0x14420544200)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 75 [IO wait]:
internal/poll.runtime_pollWait(0x402b24ee30, 0x72, 0x1442033a000)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x14420274658, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x14420274658, 0x1442033a001, 0x200, 0x2=
00)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x14420274640, 0x1442033a000, 0x200, 0x200, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x144203dc048, 0x1442033a000, 0x200, 0x200, 0x1442033a000, =
0x0, 0x0)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x144203dc048, 0x1442033a000, 0x200, 0x200, 0x0, 0x0, 0x144=
201a5038)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x14420112310, 0x894040, 0x144203dc048, 0x40ab5560=
00, 0x14420112310, 0x1442047ce01)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x14420112310, 0x894040, 0x144203dc048, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x14420112310, 0x894040, 0x144203dc048, 0x0, 0x144201b018=
0, 0x5e7fc4)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x5e7fe8, 0x1)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x144200eedc0, 0x1442033e200)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 76 [IO wait]:
internal/poll.runtime_pollWait(0x402b24ec90, 0x72, 0x1442033c000)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x144202746f8, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x144202746f8, 0x1442033c001, 0x200, 0x2=
00)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x144202746e0, 0x1442033c000, 0x200, 0x200, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x144203dc060, 0x1442033c000, 0x200, 0x200, 0x1442033c000, =
0x0, 0x0)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x144203dc060, 0x1442033c000, 0x200, 0x200, 0x0, 0x0, 0x144=
201a4eb8)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x144201123f0, 0x894040, 0x144203dc060, 0x40ab5560=
00, 0x144201123f0, 0x1442047c601)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x144201123f0, 0x894040, 0x144203dc060, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x144201123f0, 0x894040, 0x144203dc060, 0x0, 0x144201b018=
0, 0x5e7fc4)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x5e7fe8, 0x1)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x144200eedc0, 0x1442033e240)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 162 [runnable]:
os/exec.(*Cmd).Start.func1(0x144203d62c0, 0x14420584240)
	/usr/lib/go-1.10/src/os/exec/exec.go:395
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 163 [runnable]:
os/exec.(*Cmd).Start.func1(0x144203d62c0, 0x14420584280)
	/usr/lib/go-1.10/src/os/exec/exec.go:395
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468
--8<---------------------------------------------------------------------

It worked once for me:

--8<---------------------------------------------------------------------
ubuntu@qemu:~$ /usr/bin/qemu-aarch64-static /usr/lib/go-1.10/bin/go build
--8<---------------------------------------------------------------------

but then again:

--8<---------------------------------------------------------------------
ubuntu@qemu:~$ /usr/bin/qemu-aarch64-static /usr/lib/go-1.10/bin/go build
=EF=BF=BDAfatal error: malloc deadlock
panic during panic
[signal SIGSEGV: segmentation violation code=3D0x1 addr=3D0x90 pc=3D0x90]

runtime stack:
runtime.startpanic_m()
	/usr/lib/go-1.10/src/runtime/panic.go:690 +0x178
SIGILL: illegal instructionruntime.systemstack(
0x4000000000PC=3D0x44f790)
	/usr/lib/go-1.10/src/runtime/asm_arm64.s:229 + m=3D0x8c
19runtime.mstart sigcode=3D()
2	/usr/lib/go-1.10/src/runtime/proc.go
:1175


goroutine goroutine 80 [ [idlerunning]:
]:
runtime.systemstack_switch()
	/usr/lib/go-1.10/src/runtime/asm_arm64.s:178 +0x8 fp=3D0x144205dcc30runtim=
e.morestack sp=3D()
	0x144205dcc20/usr/lib/go-1.10/src/runtime/asm_arm64.s:301 pc=3D +0x68
0x44f650
runtime.startpanic()
	/usr/lib/go-1.10/src/runtime/panic.go:589 +
0x14goroutine  fp=3D80x144205dcc40 [ sp=3Drunning0x144205dcc30]:
 pc=3D0x428efc
runtime.systemstack_switch()
runtime.throw	(/usr/lib/go-1.10/src/runtime/asm_arm64.s0x82ca61:178 +0x8,  =
fp=3D0x144205dcc30 sp=3D0x144205dcc20 pc=3D0x44f6500xf
)
runtime.startpanic	(/usr/lib/go-1.10/src/runtime/panic.go)
:	615/usr/lib/go-1.10/src/runtime/panic.go +:0x54589 fp=3D +0x144205dcc600x=
14 sp=3D fp=3D0x144205dcc400x144205dcc40 pc=3D sp=3D0x428fec0x144205dcc30
 pc=3D0x428efc
runtime.throw(0x82ca61, 0xf)
	/usr/lib/go-1.10/src/runtime/panic.go:615 +0x54 fp=3D0x144205dcc60 sp=3D0x=
144205dcc40 pc=3D0x428fec
runtime.mallocgcruntime.mallocgc((0x100x10, , 0x78e2800x78e280, , 0x144202c=
a0010x144202ca001, , 0x00x0)
)
		/usr/lib/go-1.10/src/runtime/malloc.go/usr/lib/go-1.10/src/runtime/malloc=
.go::621621 + +0x8180x818 fp=3D fp=3D0x144205dcd100x144205dcd10 sp=3D sp=3D=
0x144205dcc600x144205dcc60 pc=3D pc=3D0x410e200x410e20

runtime.convT2Estringruntime.convT2Estring(0x78e280(, 0x78e2800x144205dcf60=
, , 0x144205dcf600x7, , 0x70x144203aa270, )
	0x144203aa270/usr/lib/go-1.10/src/runtime/iface.go)
:	365/usr/lib/go-1.10/src/runtime/iface.go +:0x58365 fp=3D +0x144205dcd40 s=
p=3D0x580x144205dcd10 fp=3D pc=3D0x144205dcd400x40ead0 sp=3D0x144205dcd10
 pc=3D0x40ead0
cmd/go/internal/work.(*Builder).buildActionID(0x144202a60a0, 0x14420174140,=
 0x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:219 +0xc2c fp=3D0x144205=
dd450 sp=3D0x144205dcd40cmd/go/internal/work.(*Builder).buildActionID pc=3D=
0x5c08c4(
0x144202a60a0cmd/go/internal/work.(*Builder).build, (0x144201741400x144202a=
60a0, , 0x00x14420174140, , 0x00x0, , 0x00x0, )
0x0	)
/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go	:/usr/lib/go-1.10/src/cmd=
/go/internal/work/exec.go304: +2190x64 + fp=3D0xc2c0x144205dde70 fp=3D sp=
=3D0x144205dd4500x144205dd450 sp=3D pc=3D0x144205dcd400x5c153c pc=3D
0x5c08c4
cmd/go/internal/work.(*Builder).Do.func1(0x14420174140cmd/go/internal/work.=
(*Builder).build)
(	0x144202a60a0/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go, :0x144201=
74140106,  +0x00x50,  fp=3D0x00x144205ddef0)
 sp=3D	0x144205dde70/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go pc=3D=
:0x5e7cd8304
 +0x64cmd/go/internal/work.(*Builder).Do.func2 fp=3D(0x144205dde700x144200c=
a7b0 sp=3D, 0x144205dd4500x144202a60a0 pc=3D, 0x5c153c0x1442019a9a0)

	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:cmd/go/internal/work.(*B=
uilder).Do.func1164( +0x144201741400x8c)
 fp=3D	0x144205ddfc0/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go sp=3D=
:0x144205ddef0106 pc=3D +0x5e7f740x50
 fp=3D0x144205ddef0runtime.goexit sp=3D(0x144205dde70)
 pc=3D	0x5e7cd8/usr/lib/go-1.10/src/runtime/asm_arm64.s
:1037cmd/go/internal/work.(*Builder).Do.func2 +(0x40x144200ca7b0 fp=3D, 0x1=
44205ddfc00x144202a60a0 sp=3D, 0x144205ddfc00x1442019a9a0 pc=3D)
0x451cec	=

/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:164 +0x8c fp=3D0x144205dd=
fc0 sp=3D0x144205ddef0 pc=3D0x5e7f74
runtime.goexit()
	/usr/lib/go-1.10/src/runtime/asm_arm64.s:created by 1037 +0x4cmd/go/intern=
al/work.(*Builder).Do fp=3D0x144205ddfc0
 sp=3D0x144205ddfc0 pc=3D0x451cec
created by cmd/go/internal/work.(*Builder).Do
		/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go/usr/lib/go-1.10/src/cmd=
/go/internal/work/exec.go::151151 + +0x34c0x34c


goroutine 1 [semacquire]:
sync.runtime_Semacquire(0x144200ca7bc)
	/usr/lib/go-1.10/src/runtime/sema.go:56 +0x2c
sync.(*WaitGroup).Wait(0x144200ca7b0)
	/usr/lib/go-1.10/src/sync/waitgroup.go:129 +0x68
cmd/go/internal/work.(*Builder).Do(0x144202a60a0, 0x1442014b040)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:173 +0x36c
cmd/go/internal/work.runBuild(0xa5d0a0, 0x144200d4010, 0x0, 0x0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/build.go:325 +0x4bc
main.main()
	/usr/lib/go-1.10/src/cmd/go/main.go:140 +0x6f4

goroutine 19 [syscall]:
os/signal.signal_recv(0x0)
	/usr/lib/go-1.10/src/runtime/sigqueue.go:139 +0xc8
os/signal.loop()
	/usr/lib/go-1.10/src/os/signal/signal_unix.go:22 +0x18
created by os/signal.init.0
	/usr/lib/go-1.10/src/os/signal/signal_unix.go:28 +0x30

goroutine 9 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 10 [chan receive]:
os/exec.(*Cmd).Wait(0x1442011e000, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:469 +0xe4
os/exec.(*Cmd).Run(0x1442011e000, 0x14420142070, 0x1442015c000)
	/usr/lib/go-1.10/src/os/exec/exec.go:305 +0x48
cmd/go/internal/work.(*Builder).toolID(0x144202a60a0, 0x8285a2, 0x7, 0x2c, =
0x144204ed320)
	/usr/lib/go-1.10/src/cmd/go/internal/work/buildid.go:183 +0x274
cmd/go/internal/work.(*Builder).buildActionID(0x144202a60a0, 0x14420174000,=
 0x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:219 +0xbec
cmd/go/internal/work.(*Builder).build(0x144202a60a0, 0x14420174000, 0x0, 0x=
0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:304 +0x64
cmd/go/internal/work.(*Builder).Do.func1(0x14420174000)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:106 +0x50
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:164 +0x8c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 11 [chan receive]:
os/exec.(*Cmd).Wait(0x144202aa000, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:469 +0xe4
os/exec.(*Cmd).Run(0x144202aa000, 0x144200f0070, 0x14420204000)
	/usr/lib/go-1.10/src/os/exec/exec.go:305 +0x48
cmd/go/internal/work.(*Builder).toolID(0x144202a60a0, 0x8285a2, 0x7, 0x2c, =
0x144205df320)
	/usr/lib/go-1.10/src/cmd/go/internal/work/buildid.go:183 +0x274
cmd/go/internal/work.(*Builder).buildActionID(0x144202a60a0, 0x1442014b7c0,=
 0x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:219 +0xbec
cmd/go/internal/work.(*Builder).build(0x144202a60a0, 0x1442014b7c0, 0x0, 0x=
0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:304 +0x64
cmd/go/internal/work.(*Builder).Do.func1(0x1442014b7c0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:106 +0x50
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:164 +0x8c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 12 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 13 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 14 [runnable]:
syscall.Wait4(0x20dd, 0x144204eea80, 0x0, 0x144203a2000, 0x2, 0x2, 0x2)
	/usr/lib/go-1.10/src/syscall/syscall_linux.go:252 +0x74
os.(*Process).wait(0x144200283f0, 0x144202d4060, 0x1442037c020, 0x144202c80=
d8)
	/usr/lib/go-1.10/src/os/exec_unix.go:38 +0x7c
os.(*Process).Wait(0x144200283f0, 0x0, 0x0, 0x856708)
	/usr/lib/go-1.10/src/os/exec.go:123 +0x20
os/exec.(*Cmd).Wait(0x144202c8000, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:461 +0x3c
os/exec.(*Cmd).Run(0x144202c8000, 0x1442012a070, 0x14420136000)
	/usr/lib/go-1.10/src/os/exec/exec.go:305 +0x48
cmd/go/internal/work.(*Builder).toolID(0x144202a60a0, 0x8285a2, 0x7, 0x2c, =
0x144204ef320)
	/usr/lib/go-1.10/src/cmd/go/internal/work/buildid.go:183 +0x274
cmd/go/internal/work.(*Builder).buildActionID(0x144202a60a0, 0x14420174b40,=
 0x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:219 +0xbec
cmd/go/internal/work.(*Builder).build(0x144202a60a0, 0x14420174b40, 0x0, 0x=
0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:304 +0x64
cmd/go/internal/work.(*Builder).Do.func1(0x14420174b40)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:106 +0x50
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:164 +0x8c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 15 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 16 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 82 [runnable]:
syscall.Wait4(0x20e5, 0x144204f2a80, 0x0, 0x1442022e000, 0x2, 0x2, 0x2)
	/usr/lib/go-1.10/src/syscall/syscall_linux.go:252 +0x74
os.(*Process).wait(0x14420376390, 0x144205f4060, 0x1442019a020, 0x144203440=
d8)
	/usr/lib/go-1.10/src/os/exec_unix.go:38 +0x7c
os.(*Process).Wait(0x14420376390, 0x0, 0x0, 0x856708)
	/usr/lib/go-1.10/src/os/exec.go:123 +0x20
os/exec.(*Cmd).Wait(0x14420344000, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:461 +0x3c
os/exec.(*Cmd).Run(0x14420344000, 0x1442010c150, 0x144204cc000)
	/usr/lib/go-1.10/src/os/exec/exec.go:305 +0x48
cmd/go/internal/work.(*Builder).toolID(0x144202a60a0, 0x8285a2, 0x7, 0x2c, =
0x144204f3320)
	/usr/lib/go-1.10/src/cmd/go/internal/work/buildid.go:183 +0x274
cmd/go/internal/work.(*Builder).buildActionID(0x144202a60a0, 0x1442014be00,=
 0x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:219 +0xbec
cmd/go/internal/work.(*Builder).build(0x144202a60a0, 0x1442014be00, 0x0, 0x=
0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:304 +0x64
cmd/go/internal/work.(*Builder).Do.func1(0x1442014be00)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:106 +0x50
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:164 +0x8c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 83 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 84 [syscall]:
syscall.Syscall6(0x5f, 0x1, 0x20d8, 0x144204e69a0, 0x1000004, 0x0, 0x0, 0x1=
44202ac140, 0x1442009c800, 0x40009e16c8)
	/usr/lib/go-1.10/src/syscall/asm_linux_arm64.s:36 +0x8
os.(*Process).blockUntilWaitable(0x144200c67e0, 0x0, 0x0, 0x410a64)
	/usr/lib/go-1.10/src/os/wait_waitid.go:31 +0x64
os.(*Process).wait(0x144200c67e0, 0x144201ee0d0, 0x14420524020, 0x144202dc0=
d8)
	/usr/lib/go-1.10/src/os/exec_unix.go:22 +0x2c
os.(*Process).Wait(0x144200c67e0, 0x0, 0x0, 0x856708)
	/usr/lib/go-1.10/src/os/exec.go:123 +0x20
os/exec.(*Cmd).Wait(0x144202dc000, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:461 +0x3c
os/exec.(*Cmd).Run(0x144202dc000, 0x14420150070, 0x14420324580)
	/usr/lib/go-1.10/src/os/exec/exec.go:305 +0x48
cmd/go/internal/work.(*Builder).toolID(0x144202a60a0, 0x8285a2, 0x7, 0x2c, =
0x144204e7320)
	/usr/lib/go-1.10/src/cmd/go/internal/work/buildid.go:183 +0x274
cmd/go/internal/work.(*Builder).buildActionID(0x144202a60a0, 0x14420174c80,=
 0x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:219 +0xbec
cmd/go/internal/work.(*Builder).build(0x144202a60a0, 0x14420174c80, 0x0, 0x=
0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:304 +0x64
cmd/go/internal/work.(*Builder).Do.func1(0x14420174c80)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:106 +0x50
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:164 +0x8c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 85 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 86 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 87 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 88 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 89 [runnable]:
syscall.Wait4(0x20e9, 0x144204f0a80, 0x0, 0x1442022c000, 0x2, 0x2, 0x2)
	/usr/lib/go-1.10/src/syscall/syscall_linux.go:252 +0x74
os.(*Process).wait(0x144205f01e0, 0x1442025c1c0, 0x144204e4020, 0x144200c00=
d8)
	/usr/lib/go-1.10/src/os/exec_unix.go:38 +0x7c
os.(*Process).Wait(0x144205f01e0, 0x0, 0x0, 0x856708)
	/usr/lib/go-1.10/src/os/exec.go:123 +0x20
os/exec.(*Cmd).Wait(0x144200c0000, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:461 +0x3c
os/exec.(*Cmd).Run(0x144200c0000, 0x1442013c070, 0x144200e8000)
	/usr/lib/go-1.10/src/os/exec/exec.go:305 +0x48
cmd/go/internal/work.(*Builder).toolID(0x144202a60a0, 0x8285a2, 0x7, 0x2c, =
0x144204f1320)
	/usr/lib/go-1.10/src/cmd/go/internal/work/buildid.go:183 +0x274
cmd/go/internal/work.(*Builder).buildActionID(0x144202a60a0, 0x1442014bcc0,=
 0x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:219 +0xbec
cmd/go/internal/work.(*Builder).build(0x144202a60a0, 0x1442014bcc0, 0x0, 0x=
0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:304 +0x64
cmd/go/internal/work.(*Builder).Do.func1(0x1442014bcc0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:106 +0x50
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:164 +0x8c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 90 [chan receive]:
os/exec.(*Cmd).Wait(0x144203e6000, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:469 +0xe4
os/exec.(*Cmd).Run(0x144203e6000, 0x144201300e0, 0x144200ea000)
	/usr/lib/go-1.10/src/os/exec/exec.go:305 +0x48
cmd/go/internal/work.(*Builder).toolID(0x144202a60a0, 0x8285a2, 0x7, 0x2c, =
0x144204eb320)
	/usr/lib/go-1.10/src/cmd/go/internal/work/buildid.go:183 +0x274
cmd/go/internal/work.(*Builder).buildActionID(0x144202a60a0, 0x1442014b400,=
 0x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:219 +0xbec
cmd/go/internal/work.(*Builder).build(0x144202a60a0, 0x1442014b400, 0x0, 0x=
0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:304 +0x64
cmd/go/internal/work.(*Builder).Do.func1(0x1442014b400)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:106 +0x50
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:164 +0x8c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 91 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 92 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 93 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 94 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 95 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 96 [select]:
cmd/go/internal/work.(*Builder).Do.func2(0x144200ca7b0, 0x144202a60a0, 0x14=
42019a9a0)
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:154 +0x10c
created by cmd/go/internal/work.(*Builder).Do
	/usr/lib/go-1.10/src/cmd/go/internal/work/exec.go:151 +0x34c

goroutine 54 [IO wait]:
internal/poll.runtime_pollWait(0x402b252ea8, 0x72, 0x144203c4000)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x144200d01a8, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x144200d01a8, 0x144203c4001, 0x200, 0x2=
00)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x144200d0190, 0x144203c4000, 0x200, 0x200, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x144200ce028, 0x144203c4000, 0x200, 0x200, 0x144203c4000, =
0x0, 0x0)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x144200ce028, 0x144203c4000, 0x200, 0x200, 0x0, 0x0, 0x144=
2046a5b8)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x1442010c000, 0x894040, 0x144200ce028, 0x40aad150=
00, 0x1442010c000, 0x14420069e01)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x1442010c000, 0x894040, 0x144200ce028, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x1442010c000, 0x894040, 0x144200ce028, 0x0, 0x1442019c20=
0, 0x5e7fc4)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x5e7fe8, 0x1)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x14420344000, 0x1442019a080)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 55 [IO wait]:
internal/poll.runtime_pollWait(0x403c3f0c70, 0x72, 0x144204d0600)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x144200d0248, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x144200d0248, 0x144204d0601, 0x200, 0x2=
00)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x144200d0230, 0x144204d0600, 0x200, 0x200, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x144200ce040, 0x144204d0600, 0x200, 0x200, 0x144204d0600, =
0x0, 0x0)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x144200ce040, 0x144204d0600, 0x200, 0x200, 0x0, 0x0, 0x144=
203b51b8)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x1442010c150, 0x894040, 0x144200ce040, 0x40aad150=
00, 0x1442010c150, 0x1442006de01)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x1442010c150, 0x894040, 0x144200ce040, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x1442010c150, 0x894040, 0x144200ce040, 0x0, 0x1442019c20=
0, 0x5e7fc4)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x5e7fe8, 0x1)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x14420344000, 0x1442019a0c0)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 98 [IO wait]:
internal/poll.runtime_pollWait(0x402b2528f8, 0x72, 0x14420340619)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x1442016e068, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x1442016e068, 0x14420340601, 0x5e7, 0x5=
e7)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x1442016e050, 0x14420340619, 0x5e7, 0x5e7, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x14420172010, 0x14420340619, 0x5e7, 0x5e7, 0x14420340600, =
0x14420348000, 0x19)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x14420172010, 0x14420340619, 0x5e7, 0x5e7, 0x19, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x14420142000, 0x894040, 0x14420172010, 0x40aad150=
00, 0x14420142000, 0x144201be601)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x14420142000, 0x894040, 0x14420172010, 0x0, 0x0, 0=
x0, 0x144201beb80, 0x144201beba0, 0x144201bebc0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x14420142000, 0x894040, 0x14420172010, 0x144201beca0, 0x=
144201becc0, 0x144201bece0)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x144201bee40, 0x144201bee60)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x1442011e000, 0x144203ae0a0)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 97 [IO wait]:
internal/poll.runtime_pollWait(0x402b252d08, 0x72, 0x144201a8000)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x1442025e568, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x1442025e568, 0x144201a8001, 0x200, 0x2=
00)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x1442025e550, 0x144201a8000, 0x200, 0x200, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x1442000e0a0, 0x144201a8000, 0x200, 0x200, 0x144201a8000, =
0x0, 0x0)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x1442000e0a0, 0x144201a8000, 0x200, 0x200, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x144200f0000, 0x894040, 0x1442000e0a0, 0x40aad150=
00, 0x144200f0000, 0x1)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x144200f0000, 0x894040, 0x1442000e0a0, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x144200f0000, 0x894040, 0x1442000e0a0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x144202aa000, 0x1442000c0e0)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 99 [IO wait]:
internal/poll.runtime_pollWait(0x403c3f0ee0, 0x72, 0x144202cc000)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x1442016e108, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x1442016e108, 0x144202cc001, 0x200, 0x2=
00)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x1442016e0f0, 0x144202cc000, 0x200, 0x200, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x14420172028, 0x144202cc000, 0x200, 0x200, 0x144202cc000, =
0x0, 0x0)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x14420172028, 0x144202cc000, 0x200, 0x200, 0x144201cc1e0, =
0x144201cc200, 0x144201cc220)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x14420142070, 0x894040, 0x14420172028, 0x40aad150=
00, 0x14420142070, 0x144201cc301)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x14420142070, 0x894040, 0x14420172028, 0x0, 0x0, 0=
x0, 0x144201c1f60, 0x144201c1f80, 0x144201c2020)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x14420142070, 0x894040, 0x14420172028, 0x144201c2100, 0x=
144201c2120, 0x144201c2140)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x144201c2200, 0x144201c2220)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x1442011e000, 0x144203ae0e0)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 114 [IO wait]:
internal/poll.runtime_pollWait(0x402b2525b8, 0x72, 0x144201a6000)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x1442025e608, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x1442025e608, 0x144201a6001, 0x200, 0x2=
00)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x1442025e5f0, 0x144201a6000, 0x200, 0x200, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x1442000e0b8, 0x144201a6000, 0x200, 0x200, 0x144201a6000, =
0x0, 0x0)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x1442000e0b8, 0x144201a6000, 0x200, 0x200, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x144200f0070, 0x894040, 0x1442000e0b8, 0x40aad150=
00, 0x144200f0070, 0x1)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x144200f0070, 0x894040, 0x1442000e0b8, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x144200f0070, 0x894040, 0x1442000e0b8, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x144202aa000, 0x1442000c120)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 41 [IO wait]:
internal/poll.runtime_pollWait(0x402b252f78, 0x72, 0x144204d0000)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x144204d20b8, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x144204d20b8, 0x144204d0001, 0x200, 0x2=
00)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x144204d20a0, 0x144204d0000, 0x200, 0x200, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x1442027c020, 0x144204d0000, 0x200, 0x200, 0x144204d0000, =
0x0, 0x0)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x1442027c020, 0x144204d0000, 0x200, 0x200, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x14420130000, 0x894040, 0x1442027c020, 0x40aad150=
00, 0x14420130000, 0x1)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x14420130000, 0x894040, 0x1442027c020, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x14420130000, 0x894040, 0x1442027c020, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x144203e6000, 0x14420550080)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 42 [IO wait]:
internal/poll.runtime_pollWait(0x402b252278, 0x72, 0x144204d0800)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x144204d2158, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x144204d2158, 0x144204d0801, 0x200, 0x2=
00)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x144204d2140, 0x144204d0800, 0x200, 0x200, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x1442027c090, 0x144204d0800, 0x200, 0x200, 0x144204d0800, =
0x0, 0x0)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x1442027c090, 0x144204d0800, 0x200, 0x200, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x144201300e0, 0x894040, 0x1442027c090, 0x40aad150=
00, 0x144201300e0, 0x1)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x144201300e0, 0x894040, 0x1442027c090, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x144201300e0, 0x894040, 0x1442027c090, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x144203e6000, 0x144205500c0)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 130 [IO wait]:
internal/poll.runtime_pollWait(0x402b253118, 0x72, 0x144203d2000)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x14420282518, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x14420282518, 0x144203d2001, 0x200, 0x2=
00)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x14420282500, 0x144203d2000, 0x200, 0x200, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x14420286030, 0x144203d2000, 0x200, 0x200, 0x144203d2000, =
0x0, 0x0)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x14420286030, 0x144203d2000, 0x200, 0x200, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x1442012a000, 0x894040, 0x14420286030, 0x40aad150=
00, 0x1442012a000, 0x1)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x1442012a000, 0x894040, 0x14420286030, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x1442012a000, 0x894040, 0x14420286030, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x144202c8000, 0x1442037c080)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 131 [IO wait]:
internal/poll.runtime_pollWait(0x403c3f0fb0, 0x72, 0x144204d0c00)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x144202825b8, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x144202825b8, 0x144204d0c01, 0x200, 0x2=
00)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x144202825a0, 0x144204d0c00, 0x200, 0x200, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x14420286068, 0x144204d0c00, 0x200, 0x200, 0x144204d0c00, =
0x0, 0x0)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x14420286068, 0x144204d0c00, 0x200, 0x200, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x1442012a070, 0x894040, 0x14420286068, 0x40aad150=
00, 0x1442012a070, 0x1)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x1442012a070, 0x894040, 0x14420286068, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x1442012a070, 0x894040, 0x14420286068, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x144202c8000, 0x1442037c0c0)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 71 [IO wait]:
internal/poll.runtime_pollWait(0x402b252a98, 0x72, 0x144204d0200)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x14420276388, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x14420276388, 0x144204d0201, 0x200, 0x2=
00)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x14420276370, 0x144204d0200, 0x200, 0x200, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x144200f6010, 0x144204d0200, 0x200, 0x200, 0x144204d0200, =
0x0, 0x0)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x144200f6010, 0x144204d0200, 0x200, 0x200, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x1442013c000, 0x894040, 0x144200f6010, 0x40aad150=
00, 0x1442013c000, 0x1)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x1442013c000, 0x894040, 0x144200f6010, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x1442013c000, 0x894040, 0x144200f6010, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x144200c0000, 0x144204e4080)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468

goroutine 72 [IO wait]:
internal/poll.runtime_pollWait(0x402b252418, 0x72, 0x144204d0a00)
	/usr/lib/go-1.10/src/runtime/netpoll.go:173 +0x3c
internal/poll.(*pollDesc).wait(0x14420276428, 0x72, 0xffffffffffffff01, 0x8=
94b40, 0xa63de0)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:85 +0xa0
internal/poll.(*pollDesc).waitRead(0x14420276428, 0x144204d0a01, 0x200, 0x2=
00)
	/usr/lib/go-1.10/src/internal/poll/fd_poll_runtime.go:90 +0x30
internal/poll.(*FD).Read(0x14420276410, 0x144204d0a00, 0x200, 0x200, 0x0, 0=
x0, 0x0)
	/usr/lib/go-1.10/src/internal/poll/fd_unix.go:157 +0x138
os.(*File).read(0x144200f6028, 0x144204d0a00, 0x200, 0x200, 0x144204d0a00, =
0x0, 0x0)
	/usr/lib/go-1.10/src/os/file_unix.go:226 +0x40
os.(*File).Read(0x144200f6028, 0x144204d0a00, 0x200, 0x200, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/os/file.go:107 +0x48
bytes.(*Buffer).ReadFrom(0x1442013c070, 0x894040, 0x144200f6028, 0x40aad150=
00, 0x1442013c070, 0x1)
	/usr/lib/go-1.10/src/bytes/buffer.go:205 +0x88
io.copyBuffer(0x8937a0, 0x1442013c070, 0x894040, 0x144200f6028, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:386 +0x294
io.Copy(0x8937a0, 0x1442013c070, 0x894040, 0x144200f6028, 0x0, 0x0, 0x0)
	/usr/lib/go-1.10/src/io/io.go:362 +0x44
os/exec.(*Cmd).writerDescriptor.func1(0x0, 0x0)
	/usr/lib/go-1.10/src/os/exec/exec.go:275 +0x40
os/exec.(*Cmd).Start.func1(0x144200c0000, 0x144204e40c0)
	/usr/lib/go-1.10/src/os/exec/exec.go:396 +0x20
created by os/exec.(*Cmd).Start
	/usr/lib/go-1.10/src/os/exec/exec.go:395 +0x468
--8<---------------------------------------------------------------------

Here's what it is:

--8<---------------------------------------------------------------------
ubuntu@qemu:~$ /usr/bin/qemu-aarch64-static --version
qemu-aarch64 version 4.0.91
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
ubuntu@qemu:~$ /usr/bin/qemu-aarch64-static /usr/lib/go-1.10/bin/go version
go version go1.10.4 linux/arm64
ubuntu@qemu:~$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 18.04.2 LTS
Release:	18.04
Codename:	bionic
ubuntu@qemu:~$ uname -a
Linux qemu 4.15.0-51-generic #55-Ubuntu SMP Wed May 15 14:27:21 UTC 2019 x8=
6_64 x86_64 x86_64 GNU/Linux
ubuntu@qemu:~$ lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              24
On-line CPU(s) list: 0-23
Thread(s) per core:  1
Core(s) per socket:  1
Socket(s):           24
NUMA node(s):        1
Vendor ID:           GenuineIntel
CPU family:          6
Model:               94
Model name:          Intel Core Processor (Skylake, IBRS)
Stepping:            3
CPU MHz:             2194.916
BogoMIPS:            4389.83
Virtualization:      VT-x
Hypervisor vendor:   KVM
Virtualization type: full
L1d cache:           32K
L1i cache:           32K
L2 cache:            4096K
L3 cache:            16384K
NUMA node0 CPU(s):   0-23
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge m=
ca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm=
 constant_tsc rep_good nopl xtopology cpuid tsc_known_freq pni pclmulqdq vm=
x ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer =
aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch cpuid_fault =
invpcid_single pti ssbd ibrs ibpb tpr_shadow vnmi flexpriority ept vpid fsg=
sbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm rdseed adx smap x=
saveopt arat
--8<---------------------------------------------------------------------

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1696773

Title:
  golang calls to exec crash user emulation

Status in QEMU:
  New

Bug description:
  An example program can be found here:

  https://github.com/willnewton/qemucrash

  This code starts a goroutine (thread) and calls exec repeatedly. This
  works ok natively but when run under ARM user emulation it segfaults
  (usually, there are occasionally other failures).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1696773/+subscriptions

