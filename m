Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5A7C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83812233A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83812233A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0RF0-0000ad-Ei
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 10:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i0RAR-0003tA-8B
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i0RAP-0003Pq-8S
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:00:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:60020)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i0RAN-0003OQ-Aj
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:00:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i0RAL-00019X-8M
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 14:00:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 36D8E2E8041
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 14:00:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Aug 2019 13:51:24 -0000
From: Christophe Lyon <christophe.lyon+launchpad@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: christophe-lyon
X-Launchpad-Bug-Reporter: Christophe Lyon (christophe-lyon)
X-Launchpad-Bug-Modifier: Christophe Lyon (christophe-lyon)
Message-Id: <156639548437.26869.13792283715555746637.malonedeb@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: f8c03d73165d0edb0355085fd62d018e415307b3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1840922] [NEW] qemu-arm for cortex-m33 aborts
 with unhandled CPU exception 0x8
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
Reply-To: Bug 1840922 <1840922@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hi,

While experimenting with running the GCC testsuite with cortex-m33 as targe=
t (to exercise v8-m code), I came across this failure:
qemu: unhandled CPU exception 0x8 - aborting
R00=3Dfffeaf58 R01=3Dfffeaf58 R02=3D00000000 R03=3Dfffeaf5d
R04=3Dfffeaf5c R05=3Dfffeaf9c R06=3D00000000 R07=3Dfffeaf80
R08=3D00000000 R09=3D00000000 R10=3D00019dbc R11=3D00000000
R12=3D000000f0 R13=3Dfffeaf58 R14=3D000081f3 R15=3Dfffeaf5c
XPSR=3D61000000 -ZC- T NS priv-thread
qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6033c9=
08

I'm using arm-eabi-gcc, so it targets bare-metal, not linux.

The testcase is GCC's gcc/testsuite/gcc.c-torture/execute/20000822-1.c;
it works when compiled at -O2, but crashes when compiled at -Os. The
test uses nested functions, so it creates a trampoline on the stack,
whose address may be a problem. But since the stack address seems to be
in the same range in the O2 and Os cases, it's not that clear.

I'm attaching the C source, asm, binary executables and qemu traces with
in_asm,cpu.

I execute the binaries with:
qemu-arm --cpu cortex-m33  ./20000822-1.exe.Os

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "C source code"
   https://bugs.launchpad.net/bugs/1840922/+attachment/5283726/+files/20000=
822-1.c

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1840922

Title:
  qemu-arm for cortex-m33 aborts with unhandled CPU exception 0x8

Status in QEMU:
  New

Bug description:
  Hi,

  While experimenting with running the GCC testsuite with cortex-m33 as tar=
get (to exercise v8-m code), I came across this failure:
  qemu: unhandled CPU exception 0x8 - aborting
  R00=3Dfffeaf58 R01=3Dfffeaf58 R02=3D00000000 R03=3Dfffeaf5d
  R04=3Dfffeaf5c R05=3Dfffeaf9c R06=3D00000000 R07=3Dfffeaf80
  R08=3D00000000 R09=3D00000000 R10=3D00019dbc R11=3D00000000
  R12=3D000000f0 R13=3Dfffeaf58 R14=3D000081f3 R15=3Dfffeaf5c
  XPSR=3D61000000 -ZC- T NS priv-thread
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6033=
c908

  I'm using arm-eabi-gcc, so it targets bare-metal, not linux.

  The testcase is GCC's
  gcc/testsuite/gcc.c-torture/execute/20000822-1.c; it works when
  compiled at -O2, but crashes when compiled at -Os. The test uses
  nested functions, so it creates a trampoline on the stack, whose
  address may be a problem. But since the stack address seems to be in
  the same range in the O2 and Os cases, it's not that clear.

  I'm attaching the C source, asm, binary executables and qemu traces
  with in_asm,cpu.

  I execute the binaries with:
  qemu-arm --cpu cortex-m33  ./20000822-1.exe.Os

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1840922/+subscriptions

