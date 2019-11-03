Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A24CA9EB0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 15:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83E22067D
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 15:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83E22067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRHqi-0007hS-Rl
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 10:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iRHq2-0007HG-PD
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 10:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iRHq1-0004Rd-LB
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 10:30:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:50956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iRHq1-0004RO-Fq
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 10:30:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iRHq0-0002gW-4H
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2019 15:30:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1EB0A2E804E
 for <qemu-devel@nongnu.org>; Sun,  3 Nov 2019 15:30:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 Nov 2019 15:25:10 -0000
From: Shawn Landden <1851095@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell scientes
X-Launchpad-Bug-Reporter: Shawn Landden (scientes)
X-Launchpad-Bug-Modifier: Shawn Landden (scientes)
References: <157275520880.19702.5640428141206739403.malonedeb@wampee.canonical.com>
Message-Id: <157279471030.28519.11658134388517975846.malone@chaenomeles.canonical.com>
Subject: [Bug 1851095] Re: [feature request] awareness of instructions that
 are well emulated
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8560919cc258bc1636a4d2ca5b4f8fefded68101
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

ok, here is a double precision exponent implementation that works on
arm32 hardware, but fails in qemu with the wrong checksum.
https://github.com/shawnl/zig-libmvec/blob/master/exp.zig

You need to build zig with the above patch-set.

I guess I am starting from a pessimistic perspective, where I have only
ever seen SIMD work with arm64 emulation (which is quite new), and am
sorry for that.

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

