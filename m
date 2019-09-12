Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DDFC4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 17:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1F420830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 17:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1F420830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8STr-0001HR-RL
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 13:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i8SSm-0000pB-63
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i8SSk-0003rR-Q3
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:00:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:38162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i8SSk-0003qz-Jp
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:00:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i8SSi-0005ey-F0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 17:00:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6FD5C2E80CE
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 17:00:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2019 16:52:44 -0000
From: Paul Clarke <pc@us.ibm.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 7-pc
X-Launchpad-Bug-Reporter: Paul Clarke (7-pc)
X-Launchpad-Bug-Modifier: Paul Clarke (7-pc)
Message-Id: <156830716414.515.16944012251535902875.malonedeb@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8ebae8d5cd4f2b3a5e5af78698c3af8aeef39c2b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1843795] [NEW] 'mtfsf' instruction can clear FI
 incorrectly
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
Reply-To: Bug 1843795 <1843795@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Using mtfsf instruction can clear the FPSCR FI bit incorrectly.  This code =
snippet exhibits the issue:
--
  fpscr.ll =3D 0x1fffffff;
  __builtin_mtfsf (0b11111111, fpscr.d);
  fpscr.d =3D __builtin_mffs ();
--

On POWER9 hardware:
mffs    : FPSCR =3D 0x000000007ffff7ff

On qemu (git master; "-cpu POWER9"):
--
$ ./mtfsf
mffs    : FPSCR =3D 0x000000007ffdffff
--

Two differences:
bit 52: "reserved", so maybe a "don't care" case
bit 46: "FI"

$ git log -1 master
commit 89ea03a7dc83ca36b670ba7f787802791fcb04b1
Merge: 019217c 2531164
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Mon Sep 9 09:48:34 2019 +0100

I tracked the clear is coming from do_float_check_status, likely the one
in gen_mtfsf, but then I get lost figuring out what _should_ be
happening. :-/

Test attached.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "test case - mtfsf clears FI"
   https://bugs.launchpad.net/bugs/1843795/+attachment/5288363/+files/mtfsf=
.c

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1843795

Title:
  'mtfsf' instruction can clear FI incorrectly

Status in QEMU:
  New

Bug description:
  Using mtfsf instruction can clear the FPSCR FI bit incorrectly.  This cod=
e snippet exhibits the issue:
  --
    fpscr.ll =3D 0x1fffffff;
    __builtin_mtfsf (0b11111111, fpscr.d);
    fpscr.d =3D __builtin_mffs ();
  --

  On POWER9 hardware:
  mffs    : FPSCR =3D 0x000000007ffff7ff

  On qemu (git master; "-cpu POWER9"):
  --
  $ ./mtfsf
  mffs    : FPSCR =3D 0x000000007ffdffff
  --

  Two differences:
  bit 52: "reserved", so maybe a "don't care" case
  bit 46: "FI"

  $ git log -1 master
  commit 89ea03a7dc83ca36b670ba7f787802791fcb04b1
  Merge: 019217c 2531164
  Author: Peter Maydell <peter.maydell@linaro.org>
  Date:   Mon Sep 9 09:48:34 2019 +0100

  I tracked the clear is coming from do_float_check_status, likely the
  one in gen_mtfsf, but then I get lost figuring out what _should_ be
  happening. :-/

  Test attached.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1843795/+subscriptions

