Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286C9CA9ED0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 04:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91BD20663
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 04:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91BD20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iR7iA-0002RD-1M
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 00:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iR7h9-0001Wj-5s
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 00:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iR7h6-00046G-W8
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 00:40:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:39170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iR7h6-00045n-Oa
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 00:40:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iR7h4-0003We-Ni
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2019 04:40:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B21BF2E80C0
 for <qemu-devel@nongnu.org>; Sun,  3 Nov 2019 04:40:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 Nov 2019 04:26:48 -0000
From: Shawn Landden <1851095@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: scientes
X-Launchpad-Bug-Reporter: Shawn Landden (scientes)
X-Launchpad-Bug-Modifier: Shawn Landden (scientes)
Message-Id: <157275520880.19702.5640428141206739403.malonedeb@wampee.canonical.com>
Subject: [Bug 1851095] [NEW] [feature request] awareness of instructions that
 are well emulated
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: fad958e843139cf49861ee1a8feabb2222c9e8c4
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

Public bug reported:

While qemu's scalar emulation tends to be excellent, qemu's SIMD
emulation tends to be incorrect (except for arm64 from x86_64)--i have
found this both for mipsel and arm32. Until these code paths are
audited, which is probably a large job, it would be nice if qemu knew
its emulation of this class of instructions was not very good, and thus
it would give up on finding these instructions if a "careful" operation
is passed.

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  While qemu's scalar emulation tends to be excellent, qemu's SIMD
- emulation tends to be incorrect (except for arm64 from x86_64). Until
- these code paths are audited, which is probably a large job, it would be
- nice if qemu knew its emulation of this class of instructions was not
- very good, and thus it would give up on finding these instructions if a
- "careful" operation is passed.
+ emulation tends to be incorrect (except for arm64 from x86_64)--i have
+ found this both for mipsel and arm32. Until these code paths are
+ audited, which is probably a large job, it would be nice if qemu knew
+ its emulation of this class of instructions was not very good, and thus
+ it would give up on finding these instructions if a "careful" operation
+ is passed.

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

