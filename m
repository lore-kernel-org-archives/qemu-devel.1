Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C64BC388F2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0752206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0752206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbhLs-0008AY-Ry
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 04:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbhLK-0007i0-Ki
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:50:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:57534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbhLI-0003M7-UQ
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:50:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kbhLH-0000mm-H4
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 09:50:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 75E382E811E
 for <qemu-devel@nongnu.org>; Sun,  8 Nov 2020 09:50:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2020 09:43:34 -0000
From: Thomas Huth <1895080@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: linux-user mmap
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee hansni laurent-vivier th-huth
X-Launchpad-Bug-Reporter: Hansni Bu (hansni)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <159970958159.31371.12301700684467003959.malonedeb@wampee.canonical.com>
Message-Id: <160482861489.18983.11288736266311012420.malone@soybean.canonical.com>
Subject: [Bug 1895080] Re: pgb_reserved_va: Assertion `addr == test' failed
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 724a8d7731bbee274b13ea36af41f9d9965448ea
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 04:10:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1895080 <1895080@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dfb730c8683807d549c4a

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1895080

Title:
  pgb_reserved_va: Assertion `addr =3D=3D test' failed

Status in QEMU:
  Fix Committed

Bug description:
  This problem occurs on CentOS-7.5 (64-bit) with qemu-5.1.0, qemu head
  (commit 9435a8b3dd35f1f926f1b9127e8a906217a5518a) for riscv32-linux-
  user.

  Firstly, compile fails:
  Compiling C object libqemu-riscv32-linux-user.fa.p/linux-user_strace.c.o
  ../qemu.git/linux-user/strace.c:1210:18: error: =E2=80=98FALLOC_FL_KEEP_S=
IZE=E2=80=99 undeclared here (not in a function)
       FLAG_GENERIC(FALLOC_FL_KEEP_SIZE),

  I have to add below include to linux-user/strace.c
  diff --git a/linux-user/strace.c b/linux-user/strace.c
  index 11fea14fba..22e51d4a8a 100644
  --- a/linux-user/strace.c
  +++ b/linux-user/strace.c
  @@ -7,6 +7,7 @@
   #include <sys/mount.h>
   #include <arpa/inet.h>
   #include <netinet/tcp.h>
  +#include <linux/falloc.h>
   #include <linux/if_packet.h>
   #include <linux/netlink.h>
   #include <sched.h>

  Then trying qemu-riscv32 with a simple ELF, I get:
  linux-user/elfload.c:2341: pgb_reserved_va: Assertion `addr =3D=3D test' =
failed.

  strace shows that:
  mmap(0x1000, 4294963200, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESER=
VE, -1, 0) =3D 0x10000
  write(2, "qemu-riscv32: ../qemu.git/linux-"..., 103qemu-riscv32: ../qemu.=
git/linux-user/elfload.c:2341: pgb_reserved_va: Assertion `addr =3D=3D test=
' failed.
  ) =3D 103

  The source code is in the function pgb_reserved_va (linux-
  user/elfload.c). I think mmap cannot guarantee that the returned
  pointer (test) equals to the parameter of addr. So is this a bug to
  assert (addr =3D=3D test)?

  Attached configure script and test ELF file.

  Thanks.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1895080/+subscriptions

