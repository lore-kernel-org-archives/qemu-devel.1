Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33BDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 23:31:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BD322263
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 23:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BD322263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWT0X-0006LP-MS
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 19:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kWSzp-0005ts-2U
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 19:30:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:49450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kWSzm-0006BG-F0
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 19:30:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kWSzk-0005RT-CF
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 23:30:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 408CE2E812F
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 23:30:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2020 23:25:20 -0000
From: cinap_lenrek <1901359@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cinaplenrek
X-Launchpad-Bug-Reporter: cinap_lenrek (cinaplenrek)
X-Launchpad-Bug-Modifier: cinap_lenrek (cinaplenrek)
Message-Id: <160358192028.26978.16757353407676731946.malonedeb@wampee.canonical.com>
Subject: [Bug 1901359] [NEW] ignore bit 0 in pci CONFIG_ADDRESS register write
 for Type 1 access
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bc5a16cfdc4ba776ecdf84a052201ef8fb1f3321"; Instance="production"
X-Launchpad-Hash: 718463f1ef9ebd75671f7f9bc7b2ef29925dbfe7
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 19:30:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1901359 <1901359@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I'v recently stumbled upon a bug in the Plan9 PCI config space access
routines for config mode #1.

The code used to set bit 0 in the CONFIG_ADDRESS register for a Type 1
access.

This was most likely a misreading of the PCI local bus specification on
our side.

However, in the PCI local bus specification 3.0, it states the
following:

> 3.2.2.3.2 Software Generation of Configuration Transactions
> ...
> For Type 1 translations, the host bridge directly copies the contents of =
the
> CONFIG_ADDRESS register (excluding bits 31 and 0) onto the PCI AD lines d=
uring the
> address phase of a configuration transaction making sure that AD[1::0] is=
 "01".

note the: "excluding bits 31 and 0"

What happens in qemu instead is that it uses bit 0 of the CONFIG_ADDRESS
register as part of the register offset (when it probably should ignore it)
when translating from Type 1 to Type 0 address. So once it reaches the devi=
ce
behind the bridge the register address is off by one.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1901359

Title:
  ignore bit 0 in pci CONFIG_ADDRESS register write for Type 1 access

Status in QEMU:
  New

Bug description:
  I'v recently stumbled upon a bug in the Plan9 PCI config space access
  routines for config mode #1.

  The code used to set bit 0 in the CONFIG_ADDRESS register for a Type 1
  access.

  This was most likely a misreading of the PCI local bus specification
  on our side.

  However, in the PCI local bus specification 3.0, it states the
  following:

  > 3.2.2.3.2 Software Generation of Configuration Transactions
  > ...
  > For Type 1 translations, the host bridge directly copies the contents o=
f the
  > CONFIG_ADDRESS register (excluding bits 31 and 0) onto the PCI AD lines=
 during the
  > address phase of a configuration transaction making sure that AD[1::0] =
is "01".

  note the: "excluding bits 31 and 0"

  What happens in qemu instead is that it uses bit 0 of the CONFIG_ADDRESS
  register as part of the register offset (when it probably should ignore i=
t)
  when translating from Type 1 to Type 0 address. So once it reaches the de=
vice
  behind the bridge the register address is off by one.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1901359/+subscriptions

