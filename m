Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD235C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 00:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787942086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 00:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787942086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huQp6-0000vD-C3
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 20:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40649)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1huQoi-0000Uw-Th
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 20:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1huQoh-00064t-Ng
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 20:25:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:36294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1huQoh-000634-IO
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 20:25:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1huQog-0007RQ-9x
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 00:25:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4A6112E8019
 for <qemu-devel@nongnu.org>; Mon,  5 Aug 2019 00:25:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Aug 2019 00:18:16 -0000
From: =?utf-8?b?RWxvdWFuIEFwcMOpcsOp?= <1838913@bugs.launchpad.net>
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
Message-Id: <156496429682.24531.17468125820972523019.malonedeb@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19014";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 53878924e2fe22d59963dc1fd69305c63e281e97
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1838913] [NEW] Single-step exceptions incorrectly
 generated and incorrectly routed to EL1 when ELD is EL2 (TDE = 1) (qemu
 version 3.1)
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

Public bug reported:

Hi,

I've been encountering issues with QEMU 3.1 when trying to single-step
EL1 code, with ELD =3D EL2 (MDCR_EL2.TDE =3D 1). I could test with latest
commit in a few hours, if you want.

EL1 is Aarch64.

These happen as soon as MDSCR_EL1.SS is set to 1 and ERET is executed:

1) Single-step exceptions are generated even if they should not be
(SPSR_EL2.SS =3D 0)

2) Single-step exceptions are routed to EL1

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

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "minimal code+elf"
   https://bugs.launchpad.net/bugs/1838913/+attachment/5280823/+files/test_=
hyp.zip

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1838913

Title:
  Single-step exceptions incorrectly generated and incorrectly routed to
  EL1 when ELD is EL2 (TDE =3D 1) (qemu version 3.1)

Status in QEMU:
  New

Bug description:
  Hi,

  I've been encountering issues with QEMU 3.1 when trying to single-step
  EL1 code, with ELD =3D EL2 (MDCR_EL2.TDE =3D 1). I could test with latest
  commit in a few hours, if you want.

  EL1 is Aarch64.

  These happen as soon as MDSCR_EL1.SS is set to 1 and ERET is executed:

  1) Single-step exceptions are generated even if they should not be
  (SPSR_EL2.SS =3D 0)

  2) Single-step exceptions are routed to EL1

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

