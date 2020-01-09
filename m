Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59646C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6DC20661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6DC20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYA1-0002e3-Rs
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ipY8G-0001BF-IC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ipY8B-00064K-Ep
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:45:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:34490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ipY8B-0005xA-7F
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:45:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ipY88-0001TR-13
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 13:45:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 053D82E80D4
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 13:45:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jan 2020 13:39:17 -0000
From: Thomas Huth <1840922@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: christophe-lyon pmaydell rth
X-Launchpad-Bug-Reporter: Christophe Lyon (christophe-lyon)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <156639548437.26869.13792283715555746637.malonedeb@gac.canonical.com>
Message-Id: <157857715832.14730.3737866084047442231.launchpad@wampee.canonical.com>
Subject: [Bug 1840922] Re: qemu-arm for cortex-m33 aborts with unhandled CPU
 exception 0x8
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 61c516ab1d04ab10a9499d789c414781774efc63
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
Reply-To: Bug 1840922 <1840922@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1840922

Title:
  qemu-arm for cortex-m33 aborts with unhandled CPU exception 0x8

Status in QEMU:
  Fix Released

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

