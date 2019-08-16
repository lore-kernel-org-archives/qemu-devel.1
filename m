Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2CEC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 04:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E72206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 04:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E72206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyUK1-00022k-2C
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 00:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1hyUH5-0006lw-BK
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 00:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hyUH3-0006tS-BQ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 00:55:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:50862)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hyUH1-0006sH-Qo
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 00:55:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hyUH1-0002Yd-2a
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 04:55:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 107072E8070
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 04:55:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2019 04:46:09 -0000
From: Thomas Huth <1838277@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: elouan-appere pmaydell th-huth
X-Launchpad-Bug-Reporter: =?utf-8?q?Elouan_App=C3=A9r=C3=A9_=28elouan-apper?=
 =?utf-8?q?e=29?=
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <156441235921.17753.6613889826588806043.malonedeb@gac.canonical.com>
Message-Id: <156593076935.16651.14007103329866424116.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 998b44522614b935c21f3de9b17375955bf9def4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1838277] Re: qemu-system-aarch64: regression in
 3.1: breakpoint instructions always routed to EL_D even when current EL is
 higher
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

Fix included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D987a23224218fa3bb

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1838277

Title:
  qemu-system-aarch64: regression in 3.1: breakpoint instructions always
  routed to EL_D even when current EL is higher

Status in QEMU:
  Fix Released

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

