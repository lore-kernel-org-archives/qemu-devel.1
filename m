Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01761C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD8B218CA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD8B218CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjO9a-0005R8-UU
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 09:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36100)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hjO87-0004MF-Na
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hjO83-0004r9-Qk
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:19:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:37524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hjO81-0004Nb-Dm
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:19:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hjO7x-0008D0-5h
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 13:19:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1BA662E80D2
 for <qemu-devel@nongnu.org>; Fri,  5 Jul 2019 13:19:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jul 2019 13:06:53 -0000
From: Ari Sundholm <1462640@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor megari th-huth v-adrien
X-Launchpad-Bug-Reporter: AH (v-adrien)
X-Launchpad-Bug-Modifier: Ari Sundholm (megari)
References: <20150606150101.12665.95850.malonedeb@soybean.canonical.com>
Message-Id: <156233201336.2726.2829300029753713180.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 56f037e8266f6bdd86b6fd4f81f1e7218c7d4c13
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1462640] Re: shmat fails on 32-to-64 setup
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
Reply-To: Bug 1462640 <1462640@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I can confirm that this bug still exists in the current qemu master
(short commit ID 0050f9978e):

~/qemu$ gcc -m32 shm_bug.c -o shm_bug32
shm_bug.c: In function =E2=80=98main=E2=80=99:
shm_bug.c:12:24: warning: initialization makes pointer from integer without=
 a cast [-Wint-conversion]
       const void *at =3D 0x7f7df38ea000;
                        ^~~~~~~~~~~~~~
~/qemu$ i386-linux-user/qemu-i386 ./shm_bug32 =

got err 0, ptr 0xffffffff
ari@ari-thinkpad:~/qemu$ gcc shm_bug.c -o shm_bug64
shm_bug.c: In function =E2=80=98main=E2=80=99:
shm_bug.c:12:24: warning: initialization makes pointer from integer without=
 a cast [-Wint-conversion]
       const void *at =3D 0x7f7df38ea000;
                        ^~~~~~~~~~~~~~
~/qemu$ x86_64-linux-user/qemu-x86_64 ./shm_bug64 =

got err 0, ptr 0x7f7df38ea000
ari@ari-thinkpad:~/qemu$ =


Additionally, running each executable directly on a 64-bit Ubuntu 18.04
system, we can see that the behavior of the 32-bit binary differs
between qemu-i386 and native, while that of the 64-bit binary does not:

~/qemu$ ./shm_bug32 =

got err 0, ptr 0xf38ea000
~/qemu$ ./shm_bug64
got err 0, ptr 0x7f7df38ea000
~/qemu$ =



** Changed in: qemu
       Status: Expired =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1462640

Title:
  shmat fails on 32-to-64 setup

Status in QEMU:
  Confirmed

Bug description:
  =

  I am trying to run a guest mips32 program (user mode) on a x86_64 host. T=
he program fails on a call to shmat() reproducibly. when digging into this =
problem, I could make a small guest POC that fails when compiled as i386 (-=
m32) running on a x86_64 host, but pass when compiled as 64bit. The problem=
 has to do with mmap flags.

  From what I can understand, when running 32bits guests programs, qemu
  reserve the whole guest virtual space with an mmap call. That mmap
  call specifys MAP:PRIVATE flag. When shmat is called, it tries to make
  part of that region MAP_SHARED and that fails.

  As a possible fix, it looks like it is possible to first unmap the shm
  region before calling shmat.

  steps to reproduce: =

  1 - create a file shm.c with content below
  2 - compile with: gcc -m32 shm.c -o shm32
  3 - run on a x86_64 host: qemu-i386 ./shm32 =

  4 - observe shmat fails, by returning ptr -1

  5- compile without -m32: : gcc shm.c -o shm64
  6 - observe it pass: qemu-x84_64 ./shm64


  #include <sys/ipc.h>
  #include <sys/shm.h>
  #include <sys/mman.h>
  #include <stdio.h>

  int main()
  {
      struct shmid_ds shm_desc;
      int err =3D 0;
      int id =3D shmget(IPC_PRIVATE, 688128, IPC_CREAT|IPC_EXCL|0666);
      err =3D shmctl(id, IPC_STAT, &shm_desc);
      const void *at =3D 0x7f7df38ea000;
      void* ptr =3D shmat(id, at, 0);
      printf( "got err %d, ptr %p\n", err, ptr );
  }

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1462640/+subscriptions

