Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=FORGED_HOTMAIL_RCVD2,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAFAC606CF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 20:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBE02173E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 20:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBE02173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkaiw-0007i7-EP
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 16:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36147)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hkZGf-0003Qp-0H
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hkZGd-0005Sm-4N
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:25:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:56004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hkZGc-0005SD-Ue
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:25:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hkZGb-0002nH-LI
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 19:25:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9ED972E80C7
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 19:25:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jul 2019 19:15:56 -0000
From: shacknetisp <shacknetisp@hotmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: shacknetisp
X-Launchpad-Bug-Reporter: shacknetisp (shacknetisp)
X-Launchpad-Bug-Modifier: shacknetisp (shacknetisp)
Message-Id: <156261335686.24679.15455554757536791509.malonedeb@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 995ce5da9a40e7379afdaf7f912602d5b8246fe8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Mon, 08 Jul 2019 16:58:03 -0400
Subject: [Qemu-devel] [Bug 1835827] [NEW] HTIF symbols no longer recognized
 by RISC-V spike board
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
Reply-To: Bug 1835827 <1835827@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Tested commit: f34edbc760b0f689deddd175fc08732ecb46665f

I belive this was introduced in 0ac24d56c5e7d32423ea78ac58a06b444d1df04d
when the spike's load_kernel() was moved to riscv_load_kernel() which no
longer included htif_symbol_callback().

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1835827

Title:
  HTIF symbols no longer recognized by RISC-V spike board

Status in QEMU:
  New

Bug description:
  Tested commit: f34edbc760b0f689deddd175fc08732ecb46665f

  I belive this was introduced in
  0ac24d56c5e7d32423ea78ac58a06b444d1df04d when the spike's
  load_kernel() was moved to riscv_load_kernel() which no longer
  included htif_symbol_callback().

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1835827/+subscriptions

