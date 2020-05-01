Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5EBC35280
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 20:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D55E2137B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 20:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D55E2137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUc6E-0004Xt-F1
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 16:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jUc59-00045k-Sd
 for qemu-devel@nongnu.org; Fri, 01 May 2020 16:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jUc4O-0002oT-Dl
 for qemu-devel@nongnu.org; Fri, 01 May 2020 16:16:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:35774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jUc4N-0002ju-Ut
 for qemu-devel@nongnu.org; Fri, 01 May 2020 16:15:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jUc4L-0003TU-Ur
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 20:15:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E57422E80E7
 for <qemu-devel@nongnu.org>; Fri,  1 May 2020 20:15:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2020 20:07:21 -0000
From: Jonathan Marler <1876373@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: marler8997
X-Launchpad-Bug-Reporter: Jonathan Marler (marler8997)
X-Launchpad-Bug-Modifier: Jonathan Marler (marler8997)
Message-Id: <158836364215.11388.17303335808881708822.malonedeb@wampee.canonical.com>
Subject: [Bug 1876373] [NEW] segfault mremap 4096
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a63c7d13b9674b58e81d9f1671c99dca803a4aab
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 16:15:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1876373 <1876373@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

a qemu-hosted process segfaults when the program calls mremap to shrink
the size of a buffer to 4096 that was allocated with mmap. See below for
a C program to reproduce this issue.  I was able to compile this program
for both i386 and 32-bit arm, and use qemu-i386 and qemu-arm to
reproduce the segfault.  If I run the i386 program natively on my x86_64
system, no segfault occurs.  Also note that if I change the mremap size
to something else such as 12288, no segfault occurs.  I also confirmed
using qemu's -singlestep debug option that the segfault occurs during
the mremap syscall.

If you save the source below to mremapbug.c, the following should
reproduce the issue given you have gcc-multilib:

gcc -m32 mremapbug.c
# works
./a.out
# segfault
qemu-i386 a.out

If you can also compile to arm, the same thing happens when running
"qemu-arm a.out".  I also tried compiling natively and running "qemu-
x86_64 a.out" but no segfault in that case, not sure if it's because it
is 64-bits or if it was because it was my native target.


#define _GNU_SOURCE
#include <stdlib.h>
#include <stdio.h>
#include <sys/mman.h>

int main(int argc, char *argv[])
{
  const size_t initial_size =3D 8192;

  printf("calling mmap, size=3D%llu\n", (unsigned long long)initial_size);
  void *mmap_ptr =3D mmap(NULL, initial_size,
                   PROT_READ | PROT_WRITE ,
                   MAP_PRIVATE | MAP_ANONYMOUS,
                   -1, 0);
  printf("mmap returned  : %p\n", mmap_ptr);
  if (mmap_ptr =3D=3D MAP_FAILED) {
    perror("mmap");
    exit(1);
  }

  const size_t new_size =3D 4096;
  printf("calling mremap, size=3D%llu\n", (unsigned long long)new_size);
  void *remap_ptr =3D mremap(mmap_ptr, initial_size, new_size, 0);
  printf("mremap returned: %p\n", remap_ptr);
  if (remap_ptr !=3D mmap_ptr) {
    perror("mreamap");
    exit(1);
  }
  printf("Success: pointers match\n");
}


This issue was found while I was pushing code that calls "mremap" to the Zi=
g compiler repository, it's CI testing uses qemu-i386 and qemu-arm to run t=
ests for non-native hosts.  I've filed an issue in that repository as well =
with details on how to reproduce this issue with the Zig compiler as well: =
https://github.com/ziglang/zig/issues/5245

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1876373

Title:
  segfault mremap 4096

Status in QEMU:
  New

Bug description:
  a qemu-hosted process segfaults when the program calls mremap to
  shrink the size of a buffer to 4096 that was allocated with mmap. See
  below for a C program to reproduce this issue.  I was able to compile
  this program for both i386 and 32-bit arm, and use qemu-i386 and qemu-
  arm to reproduce the segfault.  If I run the i386 program natively on
  my x86_64 system, no segfault occurs.  Also note that if I change the
  mremap size to something else such as 12288, no segfault occurs.  I
  also confirmed using qemu's -singlestep debug option that the segfault
  occurs during the mremap syscall.

  If you save the source below to mremapbug.c, the following should
  reproduce the issue given you have gcc-multilib:

  gcc -m32 mremapbug.c
  # works
  ./a.out
  # segfault
  qemu-i386 a.out

  If you can also compile to arm, the same thing happens when running
  "qemu-arm a.out".  I also tried compiling natively and running "qemu-
  x86_64 a.out" but no segfault in that case, not sure if it's because
  it is 64-bits or if it was because it was my native target.

  =

  #define _GNU_SOURCE
  #include <stdlib.h>
  #include <stdio.h>
  #include <sys/mman.h>

  int main(int argc, char *argv[])
  {
    const size_t initial_size =3D 8192;

    printf("calling mmap, size=3D%llu\n", (unsigned long long)initial_size);
    void *mmap_ptr =3D mmap(NULL, initial_size,
                     PROT_READ | PROT_WRITE ,
                     MAP_PRIVATE | MAP_ANONYMOUS,
                     -1, 0);
    printf("mmap returned  : %p\n", mmap_ptr);
    if (mmap_ptr =3D=3D MAP_FAILED) {
      perror("mmap");
      exit(1);
    }

    const size_t new_size =3D 4096;
    printf("calling mremap, size=3D%llu\n", (unsigned long long)new_size);
    void *remap_ptr =3D mremap(mmap_ptr, initial_size, new_size, 0);
    printf("mremap returned: %p\n", remap_ptr);
    if (remap_ptr !=3D mmap_ptr) {
      perror("mreamap");
      exit(1);
    }
    printf("Success: pointers match\n");
  }

  =

  This issue was found while I was pushing code that calls "mremap" to the =
Zig compiler repository, it's CI testing uses qemu-i386 and qemu-arm to run=
 tests for non-native hosts.  I've filed an issue in that repository as wel=
l with details on how to reproduce this issue with the Zig compiler as well=
: https://github.com/ziglang/zig/issues/5245

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1876373/+subscriptions

