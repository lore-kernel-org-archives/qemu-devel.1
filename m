Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E19C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 09:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963A32073F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 09:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963A32073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47074 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFxeK-0004iD-Ta
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 05:11:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hFxdW-0004P2-GC
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hFxdV-0006hm-GZ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:10:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:50986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hFxdV-0006hZ-76
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:10:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hFxdT-0000Zo-N5
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 09:10:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A301F2E8055
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 09:10:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Apr 2019 09:02:31 -0000
From: Johan Carlsson <1824778@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: ppc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jkan
X-Launchpad-Bug-Reporter: Johan Carlsson (jkan)
X-Launchpad-Bug-Modifier: Johan Carlsson (jkan)
Message-Id:
 <155531895115.20861.16647644389038821246.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: b113113e1daa0387552ae24dff3479fafb4cf6f1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1824778] [NEW] PowerPC64: tlbivax does not work
 for addresses above 4G
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1824778 <1824778@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415090231.V4iihB83EqXrQ_yERm2TzEaDCotCHrUYmYX1Jc4bjJo@z>

Public bug reported:

The tlbivax instruction in QEMU does not work for address above 4G. The rea=
son behind this is a simple 32bit trunction of an address.
Changing the argument ea from uint32_t to target_ulong for the function boo=
ke206_invalidate_ea_tlb() in target/ppc/mmu_helper.c solves the issue.

I did not reproduce this using Linux so I have no public example for
reproducing it. However it's a pretty straight forward change.

Issue can be seen in all version of QEMU.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: ppc

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824778

Title:
  PowerPC64: tlbivax does not work for addresses above 4G

Status in QEMU:
  New

Bug description:
  The tlbivax instruction in QEMU does not work for address above 4G. The r=
eason behind this is a simple 32bit trunction of an address.
  Changing the argument ea from uint32_t to target_ulong for the function b=
ooke206_invalidate_ea_tlb() in target/ppc/mmu_helper.c solves the issue.

  I did not reproduce this using Linux so I have no public example for
  reproducing it. However it's a pretty straight forward change.

  Issue can be seen in all version of QEMU.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824778/+subscriptions

