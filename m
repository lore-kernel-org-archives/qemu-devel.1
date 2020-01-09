Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F28AC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 16:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15626206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 16:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15626206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipawI-0001D6-5X
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 11:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ipavN-0000R7-TY
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ipavM-0002et-L1
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:44:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:49692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ipavM-0002X9-Dp
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:44:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ipavK-0001UM-JD
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 16:44:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7C89E2E80D3
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 16:44:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jan 2020 16:34:45 -0000
From: Thomas Huth <1528239@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: lukasdurfina m-ostapenko th-huth
X-Launchpad-Bug-Reporter: Maxim Ostapenko (m-ostapenko)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20151221142914.18731.60931.malonedeb@wampee.canonical.com>
Message-Id: <157858768516.14692.12310351355065765881.malone@wampee.canonical.com>
Subject: [Bug 1528239] Re: Unable to debug PIE binaries with QEMU gdb stub.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 61e47520fa06dbb5d7e7f005d92e87e6fde4b6eb
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1528239 <1528239@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch has been included in QEMU v4.2:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Ddc12567a53c88d7a91b9

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1528239

Title:
  Unable to debug PIE binaries with QEMU gdb stub.

Status in QEMU:
  Fix Released

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

