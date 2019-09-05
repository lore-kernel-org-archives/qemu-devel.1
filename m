Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E878AC3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 07:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADC62145D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 07:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADC62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5mKe-0001NF-Sj
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 03:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i5mIK-0000YT-Qk
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 03:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i5mII-0005pf-Ni
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 03:35:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:42140)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i5mII-0005nW-Cl
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 03:35:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i5mIG-0002sh-Qm
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 07:35:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B95AA2E80CC
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 07:35:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Sep 2019 07:19:28 -0000
From: Lukas Durfina <1528239@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: lukasdurfina m-ostapenko
X-Launchpad-Bug-Reporter: Maxim Ostapenko (m-ostapenko)
X-Launchpad-Bug-Modifier: Lukas Durfina (lukasdurfina)
References: <20151221142914.18731.60931.malonedeb@wampee.canonical.com>
Message-Id: <156766796882.5842.18378419680796202140.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c0d59b73b5ec367d3ae374dcd49a7ca3c7a4d5f1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1528239] Re: Unable to debug PIE binaries with
 QEMU gdb stub.
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
Reply-To: Bug 1528239 <1528239@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch
https://patchew.org/QEMU/20190816233422.16715-1-jkz@google.com/ fixes
the issue.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1528239

Title:
  Unable to debug PIE binaries with QEMU gdb stub.

Status in QEMU:
  New

Bug description:
  The issue occurs on current trunk:

  max@max:~/build/qemu$ cat test.c
  #include <stdio.h>

  int main() {
    printf("Hello, world!\n");
    return 0;
  }

  max@max:~/build/qemu$ gcc test.c -fPIC -pie -o bad.x
  max@max:~/build/qemu$ ./x86_64-linux-user/qemu-x86_64 -g 1234 bad.x =

  .............................

  =

  max@max:~/build/qemu$ gdb
  GNU gdb (Ubuntu 7.7.1-0ubuntu5~14.04.2) 7.7.1
  .........................................................................=
...............
  (gdb) file bad.x
  Reading symbols from bad.x...(no debugging symbols found)...done.
  (gdb) b main
  Breakpoint 1 at 0x779
  (gdb) target remote localhost:1234
  Remote debugging using localhost:1234
  Reading symbols from /lib64/ld-linux-x86-64.so.2...warning: the debug inf=
ormation found in "/lib64/ld-2.19.so" does not match "/lib64/ld-linux-x86-6=
4.so.2" (CRC mismatch).

  Reading symbols from /usr/lib/debug//lib/x86_64-linux-gnu/ld-2.19.so...do=
ne.
  done.
  Loaded symbols for /lib64/ld-linux-x86-64.so.2
  Error in re-setting breakpoint 1: Cannot access memory at address 0x775
  Error in re-setting breakpoint 1: Cannot access memory at address 0x775
  0x0000004000a042d0 in _start () from /lib64/ld-linux-x86-64.so.2
  (gdb) c
  Continuing.
  [Inferior 1 (Remote target) exited normally]
  (gdb) =


  =

  max@max:~/build/qemu$ cat config.log
  # Configured with: '/home/max/src/qemu/configure' '--prefix=3D/home/max/i=
nstall/qemu' '--target-list=3Darm-linux-user,aarch64-linux-user,x86_64-linu=
x-user' '--static'

  =

  W/O QEMU or -pie flag breakpoint on main works fine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1528239/+subscriptions

