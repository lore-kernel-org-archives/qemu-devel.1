Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18929C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C9521655
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C9521655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7RH-0001XG-6t
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41948)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hs7IU-00011i-PP
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hs7IT-000721-OW
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:10:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:59008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hs7IT-000719-JY
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:10:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hs7IS-0007hS-BJ
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 15:10:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4D7712E804A
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 15:10:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jul 2019 14:59:19 -0000
From: =?utf-8?b?RWxvdWFuIEFwcMOpcsOp?= <1838277@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: elouan-appere
X-Launchpad-Bug-Reporter: =?utf-8?q?Elouan_App=C3=A9r=C3=A9_=28elouan-apper?=
 =?utf-8?q?e=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Elouan_App=C3=A9r=C3=A9_=28elouan-apper?=
 =?utf-8?q?e=29?=
Message-Id: <156441235921.17753.6613889826588806043.malonedeb@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 2f410a29d0ae32ab93c312b49874529035809667
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1838277] [NEW] qemu-system-aarch64: regression:
 msr vbar_el2, xN not working in EL2
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
Reply-To: Bug 1838277 <1838277@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Affects 3.1.0 (latest stable release) and latest commit
(893dc8300c80e3dc32f31e968cf7aa0904da50c3) but did *not* affect 2.11
(qemu from bionic ubuntu LTS).

With the following code and shell commands:

test.s:

.text
mov x0, #0x60000000
msr vbar_el2, x0
dsb sy
isb sy

$ aarch64-none-elf-as test.s -o test.o
$ aarch64-none-elf-objcopy -S -O binary test.o test.bin
$ qemu-system-aarch64 -nographic -machine virt,virtualization=3Don -cpu cor=
tex-a57 -kernel test.bin -s -S

vbar_el2 is still 0 after the code, instead of being the expected
0x60000000. (see screenshot).

This regression doesn't seem to happen for vbar_el1 &
virtualization=3Doff.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "gdb screenshot"
   https://bugs.launchpad.net/bugs/1838277/+attachment/5279820/+files/vbar.=
png

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1838277

Title:
  qemu-system-aarch64: regression: msr vbar_el2, xN not working in EL2

Status in QEMU:
  New

Bug description:
  Affects 3.1.0 (latest stable release) and latest commit
  (893dc8300c80e3dc32f31e968cf7aa0904da50c3) but did *not* affect 2.11
  (qemu from bionic ubuntu LTS).

  With the following code and shell commands:

  test.s:

  .text
  mov x0, #0x60000000
  msr vbar_el2, x0
  dsb sy
  isb sy

  $ aarch64-none-elf-as test.s -o test.o
  $ aarch64-none-elf-objcopy -S -O binary test.o test.bin
  $ qemu-system-aarch64 -nographic -machine virt,virtualization=3Don -cpu c=
ortex-a57 -kernel test.bin -s -S

  vbar_el2 is still 0 after the code, instead of being the expected
  0x60000000. (see screenshot).

  This regression doesn't seem to happen for vbar_el1 &
  virtualization=3Doff.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1838277/+subscriptions

