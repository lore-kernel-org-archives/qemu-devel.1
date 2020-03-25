Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0727C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9939E20772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9939E20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH9eN-0002wm-Hz
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jH9dI-0002Bb-AV
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jH9dH-0004sI-7t
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:16:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:37728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jH9dH-0004rG-2d
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:15:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jH9dE-00072o-2U
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 17:15:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8BD092E80CF
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 17:15:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Mar 2020 17:04:44 -0000
From: RTOS Pharos <1815721@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bmeng-cn rtos.pharos
X-Launchpad-Bug-Reporter: RTOS Pharos (rtos.pharos)
X-Launchpad-Bug-Modifier: RTOS Pharos (rtos.pharos)
References: <155004342499.19242.14077661245921319117.malonedeb@soybean.canonical.com>
Message-Id: <158515588475.8334.16690140737637770701.malone@wampee.canonical.com>
Subject: [Bug 1815721] Re: RISC-V PLIC enable interrupt for multicore
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d7dc7597929a15984ccdc47bc2a4299e5574784a
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Bug 1815721 <1815721@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you for the explanation. I actually built it for "Virt" machine.
I'll try the "sifive_u" when I can.

But I guess your explanation is correct so this bug could be closed from
my part.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815721

Title:
  RISC-V PLIC enable interrupt for multicore

Status in QEMU:
  New

Bug description:
  Hello all,

  There is a bug in Qemu related to the enabling of external interrupts
  for multicores (Virt machine).

  After correcting Qemu as described in #1815078
  (https://bugs.launchpad.net/qemu/+bug/1815078), when we try to enable
  interrupts for core 1 at address 0x0C00_2080 we don't seem to be able
  to trigger an external interrupt  (e.g. UART0).

  This works perfectly for core 0, but fore core 1 it does not work at
  all. I assume that given bug #1815078 does not enable any external
  interrupt then this feature has not been tested. I tried to look at
  the qemu source code but with no luck so far.

  I guess the problem is related to function parse_hart_config (in
  sfive_plic.c) that initializes incorrectly the
  plic->addr_config[addrid].hartid, which is later on read in
  sifive_plic_update. But this is a guess.

  Best regards,
  Pharos team

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815721/+subscriptions

