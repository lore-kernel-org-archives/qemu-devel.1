Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705C0C8300B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 04:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426A12076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 04:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426A12076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTeL8-00024W-Ea
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 00:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jTeIk-0007zl-6E
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 00:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jTeI5-0007qm-7F
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 00:26:25 -0400
Received: from indium.canonical.com ([91.189.90.7]:50030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jTeI4-0007qb-OT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 00:25:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jTeI3-0001Oj-6K
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 04:25:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2EB832E8048
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 04:25:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2020 04:17:21 -0000
From: Launchpad Bug Tracker <1862986@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor jermy-07 laurent-vivier rth
X-Launchpad-Bug-Reporter: Marco (jermy-07)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <158152698766.24807.871332888169155245.malonedeb@gac.canonical.com>
Message-Id: <158813384120.15908.4742399015698592335.malone@loganberry.canonical.com>
Subject: [Bug 1862986] Re: qemu-s390x crashes when run on aarch64
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d1105341713c5be348effe2a5142c4a210ce4cde";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 50363c22f8f0ae5369a5a60b210ac5a77d4d121c
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:25:43
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
Reply-To: Bug 1862986 <1862986@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1862986

Title:
  qemu-s390x crashes when run on aarch64

Status in QEMU:
  Expired

Bug description:
  All tested versions (2.11 and 4.2) qemu-s390x crashes with a segfault
  when run on an aarch64 odroid Ubuntu.


  Steps to reproduce:

  root@odroid:~/workspace/bitcoin-core# /usr/local/bin/qemu-s390x "/root/wo=
rkspace/bitcoin-core/build/bitcoin-s390x-linux-gnu/src/test/test_bitcoin_or=
ig"
  Segmentation fault (core dumped)
  root@odroid:~/workspace/bitcoin-core# /usr/local/bin/qemu-s390x --version
  qemu-s390x version 4.2.0
  Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
  root@odroid:~/workspace/bitcoin-core# /usr/bin/qemu-s390x "/root/workspac=
e/bitcoin-core/build/bitcoin-s390x-linux-gnu/src/test/test_bitcoin_orig"
  Segmentation fault (core dumped)
  root@odroid:~/workspace/bitcoin-core# /usr/bin/qemu-s390x --version
  qemu-s390x version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.22)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  qemu-arm does work on the same machine:

  root@odroid:~/workspace/bitcoin-core# /usr/bin/qemu-arm bitcoin-0.19.0.1-=
armhf/bin/test_bitcoin -t amount_tests
  Running 4 test cases...

  *** No errors detected
  root@odroid:~/workspace/bitcoin-core# /usr/local/bin/qemu-arm bitcoin-0.1=
9.0.1-armhf/bin/test_bitcoin -t amount_tests
  Running 4 test cases...

  *** No errors detected


  =

  What kind of debug information would be helpful for this issue report?
  GDB for the self-compiled latest release is not particularly helpful:

  (gdb) run
  Starting program: /usr/local/bin/qemu-s390x /root/workspace/bitcoin-core/=
build/bitcoin-s390x-linux-gnu/src/test/test_bitcoin_orig
  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/lib/aarch64-linux-gnu/libthread_db.so.1=
".
  [New Thread 0x7fb7a2a140 (LWP 28264)]

  Thread 1 "qemu-s390x" received signal SIGSEGV, Segmentation fault.
  0x000000555596b218 in __bss_start__ ()
  (gdb) bt
  #0  0x000000555596b218 in __bss_start__ ()
  #1  0x00000055556120a8 in ?? ()
  #2  0x00000055579904b0 in ?? ()
  Backtrace stopped: previous frame inner to this frame (corrupt stack?)


  =

  A bit more information is available in the version shipped by Ubuntu:

  (gdb) run
  Starting program: /usr/bin/qemu-s390x /root/workspace/bitcoin-core/build/=
bitcoin-s390x-linux-gnu/src/test/test_bitcoin_orig
  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/lib/aarch64-linux-gnu/libthread_db.so.1=
".
  [New Thread 0x7fb7a01180 (LWP 28271)]

  Thread 1 "qemu-s390x" received signal SIGSEGV, Segmentation fault.
  0x0000005555738f98 in code_gen_buffer ()
  (gdb) bt
  #0  0x0000005555738f98 in code_gen_buffer ()
  #1  0x00000055555e96c8 in cpu_exec ()
  #2  0x00000055555ee430 in cpu_loop ()
  #3  0x00000055555c3328 in main ()

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1862986/+subscriptions

