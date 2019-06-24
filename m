Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D35C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8999E20645
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8999E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52252 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfQm5-0005Pd-S0
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 11:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hfQcI-0005UA-Aq
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:10:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hfQcF-0004PC-Dv
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:10:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:58370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hfQcF-0004NX-8H
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:10:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hfQcD-0000hk-Io
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:10:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 83DE42E80C7
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:10:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Jun 2019 15:04:20 -0000
From: roblabla <1834051@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: roblabla
X-Launchpad-Bug-Reporter: roblabla (roblabla)
X-Launchpad-Bug-Modifier: roblabla (roblabla)
Message-Id: <156138866047.31005.4592891012762616724.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18991";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 9709cdcb5c3763108f34789539573c518be816b6
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1834051] [NEW] IRQ2 ignored under KVM when using
 IOAPIC
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
Reply-To: Bug 1834051 <1834051@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

When using KVM, and an OS that supports the IOAPIC, interrupts mapped on
IRQ2 (for instance, routing an HPET timer on interrupt 2) will cause the
interrupts to never be delivered. This is because QEmu, when setting up
the KVM interrupt routes, will not set one up for IRQ2[0]. When running
without KVM, IRQ2 is identity-mapped to GSI2.

My understanding is that IRQs should be identity mapped to their
equivalent GSI unless a redirection entry is present in the MADT. This
is supported by ACPI 6.2 spec[1], 5.2.12.5 Interrupt Source Override
Structure, which claims: "It is assumed that the ISA interrupts will be
identity-mapped into the first I/O APIC sources.".

I stumbled across this while working on my own custom OS, got very
confused why the HPET wasn't triggering any interruption - and even more
confused why the behavior only happened in KVM and not in non-KVM.

[0]:
https://github.com/qemu/qemu/blob/37560c259d7a0d6aceb96e9d6903ee002f4e5e0c/=
hw/i386/kvm/ioapic.c#L40

[1]: https://uefi.org/sites/default/files/resources/ACPI_6_2.pdf

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1834051

Title:
  IRQ2 ignored under KVM when using IOAPIC

Status in QEMU:
  New

Bug description:
  When using KVM, and an OS that supports the IOAPIC, interrupts mapped
  on IRQ2 (for instance, routing an HPET timer on interrupt 2) will
  cause the interrupts to never be delivered. This is because QEmu, when
  setting up the KVM interrupt routes, will not set one up for IRQ2[0].
  When running without KVM, IRQ2 is identity-mapped to GSI2.

  My understanding is that IRQs should be identity mapped to their
  equivalent GSI unless a redirection entry is present in the MADT. This
  is supported by ACPI 6.2 spec[1], 5.2.12.5 Interrupt Source Override
  Structure, which claims: "It is assumed that the ISA interrupts will
  be identity-mapped into the first I/O APIC sources.".

  I stumbled across this while working on my own custom OS, got very
  confused why the HPET wasn't triggering any interruption - and even
  more confused why the behavior only happened in KVM and not in non-
  KVM.

  [0]:
  https://github.com/qemu/qemu/blob/37560c259d7a0d6aceb96e9d6903ee002f4e5e0=
c/hw/i386/kvm/ioapic.c#L40

  [1]: https://uefi.org/sites/default/files/resources/ACPI_6_2.pdf

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1834051/+subscriptions

