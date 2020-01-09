Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47655C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD7D206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD7D206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYE0-0007kr-3E
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:51:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ipYCs-0005sw-2o
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ipYCq-0006sE-Kt
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:50:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:35134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ipYCq-0006oE-CF
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:50:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ipYCp-0001v0-7s
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 13:50:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 005CA2E80D4
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 13:50:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jan 2020 13:41:27 -0000
From: Thomas Huth <1838913@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm tcg testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: elouan-appere pmaydell
X-Launchpad-Bug-Reporter: =?utf-8?q?Elouan_App=C3=A9r=C3=A9_=28elouan-apper?=
 =?utf-8?q?e=29?=
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <156496429682.24531.17468125820972523019.malonedeb@soybean.canonical.com>
Message-Id: <157857728880.3160.1897739779717705199.launchpad@soybean.canonical.com>
Subject: [Bug 1838913] Re: Single-step exceptions incorrectly routed to EL1
 when ELD is EL2 (TDE = 1) (qemu version 3.1)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: f6fd39bdee6175eb1e69d75a2b619b360bff0a56
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
Reply-To: Bug 1838913 <1838913@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1838913

Title:
  Single-step exceptions incorrectly routed to EL1 when ELD is EL2 (TDE
  =3D 1) (qemu version 3.1)

Status in QEMU:
  Fix Released

Bug description:
  Hi,

  I've been encountering issues with QEMU 3.1 when trying to single-step
  EL1 code, with ELD =3D EL2 (MDCR_EL2.TDE =3D 1). I could test with latest
  commit in a few hours, if you want.

  EL1 is Aarch64.

  This happens as soon as MDSCR_EL1.SS is set to 1 and ERET is executed:

  - Single-step exceptions are routed to EL1

  Exception return from AArch64 EL2 to AArch64 EL1 PC 0x4000005c
  Taking exception 1 [Undefined Instruction]
  ...from EL1 to EL1
  ...with ESR 0x32/0xca000022
  ...with ELR 0x4000005c
  ...to EL1 PC 0x200 PSTATE 0x3c5

  EC 0x32 (0b110010) is Exception_SoftwareStepLowerEl.

  You can find enclosed minimal code (and resulting .elf) for
  reproduction.

  qemu-system-aarch64 -nographic -machine virt,virtualization=3Don -d
  unimp,int -cpu cortex-a57 -kernel test_hyp.elf

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1838913/+subscriptions

