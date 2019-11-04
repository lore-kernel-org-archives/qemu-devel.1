Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4088CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 20:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A44206BA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 20:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A44206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRjAd-0007FS-IA
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 15:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iRj9f-0006Rx-34
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 15:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iRj9d-0007X6-5i
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 15:40:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:44976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iRj9c-0007VJ-Dy
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 15:40:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iRj9a-0004OY-4q
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 20:40:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 210002E8070
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 20:40:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Nov 2019 20:32:50 -0000
From: Shawn Landden <1851095@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ldesnogu pmaydell scientes
X-Launchpad-Bug-Reporter: Shawn Landden (scientes)
X-Launchpad-Bug-Modifier: Shawn Landden (scientes)
References: <157275520880.19702.5640428141206739403.malonedeb@wampee.canonical.com>
Message-Id: <157289957091.28002.4815834867561075195.malone@chaenomeles.canonical.com>
Subject: [Bug 1851095] Re: [feature request] awareness of instructions that
 are well emulated
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5b2ff2a75292ddfe7e5b130e939029e18d4ac40e
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
Reply-To: Bug 1851095 <1851095@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here is the same thing compiled with optimizations on

** Attachment added: "bench_simple"
   https://bugs.launchpad.net/qemu/+bug/1851095/+attachment/5302825/+files/=
bench_simple

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1851095

Title:
  [feature request] awareness of instructions that are well emulated

Status in QEMU:
  New

Bug description:
  While qemu's scalar emulation tends to be excellent, qemu's SIMD
  emulation tends to be incorrect (except for arm64 from x86_64)--i have
  found this both for mipsel and arm32. Until these code paths are
  audited, which is probably a large job, it would be nice if qemu knew
  its emulation of this class of instructions was not very good, and
  thus it would give up on finding these instructions if a "careful"
  operation is passed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1851095/+subscriptions

