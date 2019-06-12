Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA41C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97CB220866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CB220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60060 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb2oO-0007vT-Qv
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 08:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54447)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hb2dZ-0001O7-0X
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hb2dV-0003vo-19
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:45:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:39462)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hb2dO-0003no-Ee
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:45:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hb2dE-00068O-FV
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 12:45:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6DB172E80CD
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 12:45:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Jun 2019 12:32:51 -0000
From: QEMU <1832535@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: riscv
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: qemu-bug
X-Launchpad-Bug-Reporter: QEMU (qemu-bug)
X-Launchpad-Bug-Modifier: QEMU (qemu-bug)
Message-Id: <156034277180.16851.16263953909128956213.malonedeb@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18978";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 88cccd7a6c69e8d242bf59a18444105e85c02731
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1832535] [NEW] [riscv/regression] Missing tlb
 flush introduced in refactoring
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
Reply-To: Bug 1832535 <1832535@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello,

In qemu-system-riscv64, following a QEMU update, I get all sort of weird
and not easily reproducible crashes in my risc-v guest.

I have bissected this issue to commit c7b951718815694284501ed01fec7acb8654d=
b7b.
Some TLB flushes were removed in the following places:
target/riscv/cpu_helper.c: `csr_write_helper(env, s, CSR_MSTATUS);` -> `env=
->mstatus =3D s;` (twice)
target/riscv/op_helper.c: `csr_write_helper(env, s, CSR_MSTATUS);` -> `env-=
>mstatus =3D s;` (twice)

Adding TLB flushes in all 4 places fixes the issues for me.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: riscv

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1832535

Title:
  [riscv/regression] Missing tlb flush introduced in refactoring

Status in QEMU:
  New

Bug description:
  Hello,

  In qemu-system-riscv64, following a QEMU update, I get all sort of
  weird and not easily reproducible crashes in my risc-v guest.

  I have bissected this issue to commit c7b951718815694284501ed01fec7acb865=
4db7b.
  Some TLB flushes were removed in the following places:
  target/riscv/cpu_helper.c: `csr_write_helper(env, s, CSR_MSTATUS);` -> `e=
nv->mstatus =3D s;` (twice)
  target/riscv/op_helper.c: `csr_write_helper(env, s, CSR_MSTATUS);` -> `en=
v->mstatus =3D s;` (twice)

  Adding TLB flushes in all 4 places fixes the issues for me.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1832535/+subscriptions

