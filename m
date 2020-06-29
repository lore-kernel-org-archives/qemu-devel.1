Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB1BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9520F23D23
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9520F23D23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpsn5-0003OX-Re
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 08:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jpsmC-0002v7-KB
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:20:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:50956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jpsmA-0003bd-7T
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:20:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jpsm7-0006vA-SJ
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 12:20:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9C8DD2E810A
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 12:20:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2020 12:13:40 -0000
From: Martin Grigorov <1884719@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: laurent-vivier martingrigorov stefanha
X-Launchpad-Bug-Reporter: Martin Grigorov (martingrigorov)
X-Launchpad-Bug-Modifier: Martin Grigorov (martingrigorov)
References: <159289799812.6175.17000319886186623286.malonedeb@soybean.canonical.com>
Message-Id: <159343282086.1656.5257890853895072288.malone@wampee.canonical.com>
Subject: [Bug 1884719] Re: Function not implemented when using libaio
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0ab6db31628a1ee3cfa13ca905ca5b91e3a06c12
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 06:50:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Reply-To: Bug 1884719 <1884719@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Executing `QEMU_STRACE=3D ./out` here gives:


259 brk(NULL) =3D 0x0000000000421000
259 uname(0x40008003d8) =3D 0
259 faccessat(AT_FDCWD,"/etc/ld.so.preload",R_OK,AT_SYMLINK_NOFOLLOW|0x50) =
=3D -1 errno=3D2 (No such file or directory)
259 openat(AT_FDCWD,"/etc/ld.so.cache",O_RDONLY|O_CLOEXEC) =3D 3
259 fstat(3,0x00000040007ff960) =3D 0
259 mmap(NULL,13646,PROT_READ,MAP_PRIVATE,3,0) =3D 0x0000004000843000
259 close(3) =3D 0
259 openat(AT_FDCWD,"/lib64/libaio.so.1",O_RDONLY|O_CLOEXEC) =3D 3
259 read(3,0x7ffb20,832) =3D 832
259 fstat(3,0x00000040007ff9b0) =3D 0
259 mmap(NULL,131096,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) =3D=
 0x0000004000847000
259 mprotect(0x0000004000849000,118784,PROT_NONE) =3D 0
259 mmap(0x0000004000866000,4096,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYW=
RITE|MAP_FIXED,3,0xf000) =3D 0x0000004000866000
259 mmap(0x0000004000867000,24,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMO=
US|MAP_FIXED,-1,0) =3D 0x0000004000867000
259 close(3) =3D 0
259 openat(AT_FDCWD,"/lib64/libc.so.6",O_RDONLY|O_CLOEXEC) =3D 3
259 read(3,0x7ffb00,832) =3D 832
259 fstat(3,0x00000040007ff990) =3D 0
259 mmap(NULL,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) =3D=
 0x0000004000868000
259 mmap(NULL,1527680,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) =
=3D 0x000000400086a000
259 mprotect(0x00000040009c3000,77824,PROT_NONE) =3D 0
259 mmap(0x00000040009d6000,24576,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENY=
WRITE|MAP_FIXED,3,0x15c000) =3D 0x00000040009d6000
259 mmap(0x00000040009dc000,12160,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANON=
YMOUS|MAP_FIXED,-1,0) =3D 0x00000040009dc000
259 close(3) =3D 0
259 mprotect(0x00000040009d6000,16384,PROT_READ) =3D 0
259 mprotect(0x0000004000866000,4096,PROT_READ) =3D 0
259 mprotect(0x000000000041f000,4096,PROT_READ) =3D 0
259 mprotect(0x0000004000840000,4096,PROT_READ) =3D 0
259 munmap(0x0000004000843000,13646) =3D 0
259 brk(NULL) =3D 0x0000000000421000
259 brk(0x0000000000442000) =3D 0x0000000000442000
259 brk(NULL) =3D 0x0000000000442000
259 io_setup(10,4330144,4330160,4330144,274886726560,511) =3D -1 errno=3D38=
 (Function not implemented)
259 io_destroy(0,274886726560,38,274886726560,511,512) =3D -1 errno=3D38 (F=
unction not implemented)
259 fstat(1,0x0000004000800388) =3D 0
259 write(1,0x4212c0,11)res is: -38 =3D 11
259 exit_group(0)


Thanks for looking into this issue, Laurent Vivier!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1884719

Title:
  Function not implemented when using libaio

Status in QEMU:
  New

Bug description:
  Hello

  I experience "Function not implemented" errors when trying to use
  Linux libaio library in foreign architecture, e.g. aarch64.

  I've faced this problem while using https://github.com/multiarch/qemu-use=
r-static, i.e. Docker+QEMU. =

  I understand that I do not use plain QEMU and you may count this report a=
s a "distribution of QEMU"! Just let me know what are the steps to test it =
with plain QEMU and I will test and update this ticket!

  =

  Here are the steps to reproduce the issue:

  1) On x86_64 machine register QEMU:

      `docker run -it --rm --privileged multiarch/qemu-user-static
  --reset --credential yes --persistent yes`

  2) Start a Docker image with foreign CPU architecture, e.g. aarch64

      `docker run -it arm64v8/centos:8 bash`

  3) Inside the Docker container install GCC and libaio

      `yum install gcc libaio libaio-devel`

  4) Compile the following C program

  ```
  #include <stdio.h>
  #include <errno.h>
  #include <libaio.h>
  #include <stdlib.h>

  struct io_control {
      io_context_t ioContext;
  };

  int main() {
      int queueSize =3D 10;

      struct io_control * theControl =3D (struct io_control *) malloc(sizeo=
f(struct io_control));
      if (theControl =3D=3D NULL) {
          printf("theControl is NULL");
          return 123;
      }

      int res =3D io_queue_init(queueSize, &theControl->ioContext);
      io_queue_release(theControl->ioContext);
      free(theControl);
      printf("res is: %d", res);
  }
  ```

      ```
      cat > test.c
          [PASTE THE CODE ABOVE HERE]
      ^D
      ```

      `gcc test.c -o out -laio && ./out`

  =

  When executed directly on aarch64 machine (i.e. without emulation) or on =
x86_64 Docker image (e.g. centos:8) it prints `res is: 0`, i.e. it successf=
ully initialized a LibAIO queue.

  But when executed on Docker image with foreign/emulated CPU
  architecture it prints `res is: -38` (ENOSYS). `man io_queue_init`
  says that error ENOSYS is returned when "Not implemented."

  Environment:

  QEMU version: 5.0.0.2  (https://github.com/multiarch/qemu-user-static/blo=
b/master/.travis.yml#L24-L28)
  Container application: Docker
  Output of `docker --version`:

  ```
  Client:
   Version:           19.03.8
   API version:       1.40
   Go version:        go1.13.8
   Git commit:        afacb8b7f0
   Built:             Wed Mar 11 23:42:35 2020
   OS/Arch:           linux/amd64
   Experimental:      false

  Server:
   Engine:
    Version:          19.03.8
    API version:      1.40 (minimum version 1.12)
    Go version:       go1.13.8
    Git commit:       afacb8b7f0
    Built:            Wed Mar 11 22:48:33 2020
    OS/Arch:          linux/amd64
    Experimental:     false
   containerd:
    Version:          1.3.3-0ubuntu2
    GitCommit:        =

   runc:
    Version:          spec: 1.0.1-dev
    GitCommit:        =

   docker-init:
    Version:          0.18.0
    GitCommit:        =

  ```

  Same happens with Ubuntu (arm64v8/ubuntu:focal).

  I've tried to `strace` it but :

  ```
  /usr/bin/strace: ptrace(PTRACE_TRACEME, ...): Function not implemented
  /usr/bin/strace: PTRACE_SETOPTIONS: Function not implemented
  /usr/bin/strace: detach: waitpid(112): No child processes
  /usr/bin/strace: Process 112 detached
  ```

  Here are the steps to reproduce the problem with strace:

       ```
       docker run --rm -it --security-opt seccomp:unconfined --security-opt=
 apparmor:unconfined --privileged --cap-add ALL arm64v8/centos:8 bash

       yum install -y strace`

       strace echo Test
       ```

  Note: I used --privileged, disabled seccomp and apparmor, and added
  all capabilities

  Disabling security solves the "Permission denied" problem but then
  comes the "Not implemented" one.

  =

  Any idea what could be the problem and how to work it around ?
  I've googled a lot but I wasn't able to find any problems related to liba=
io on QEMU.

  Thank you!
  Martin

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1884719/+subscriptions

