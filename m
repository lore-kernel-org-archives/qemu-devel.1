Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AC9C10F0B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 08:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23ADB214DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 08:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23ADB214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37771 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH29p-00052R-D4
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 04:12:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hH28E-00044s-75
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hH28C-0008Fi-9m
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:10:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:52606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hH28A-0008EW-Pw
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:10:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hH289-0001tZ-0t
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 08:10:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0014B2E80C7
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 08:10:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2019 08:03:27 -0000
From: Jakub Jermar <1825311@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jakub
X-Launchpad-Bug-Reporter: Jakub Jermar (jakub)
X-Launchpad-Bug-Modifier: Jakub Jermar (jakub)
Message-Id:
 <155557460746.17507.17649109204793492383.malonedeb@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 61e179ac03782b0a8f99edcd48f2b34d2e01202a
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1825311] [NEW] mips_cpu_handle_mmu_fault renders
 all accessed pages executable
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
Reply-To: Bug 1825311 <1825311@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418080327.xYmWKxBRumwSkqBaAWy28VuN_9nQU--NaPk7LiQm3W0@z>

Public bug reported:

On MIPS, data accesses to pages mapped in the TLB result in
mips_cpu_handle_mmu_fault() marking the page unconditionally executable,
even if the TLB entry has the XI bit set. Later on, when there is an
attempt to execute this page, no exception is generated, even though
TLBXI is expected.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1825311

Title:
  mips_cpu_handle_mmu_fault renders all accessed pages executable

Status in QEMU:
  New

Bug description:
  On MIPS, data accesses to pages mapped in the TLB result in
  mips_cpu_handle_mmu_fault() marking the page unconditionally
  executable, even if the TLB entry has the XI bit set. Later on, when
  there is an attempt to execute this page, no exception is generated,
  even though TLBXI is expected.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1825311/+subscriptions

