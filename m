Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33617C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0834020661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0834020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipY57-0006o7-7S
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ipY3P-0004bK-1L
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ipY3N-0004e9-Tw
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:40:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:33812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ipY3M-0004br-3X
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:40:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ipY3K-00017N-Fg
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 13:40:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7586D2E8074
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 13:40:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jan 2020 13:32:13 -0000
From: Thomas Huth <1841491@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 7-pc rth th-huth
X-Launchpad-Bug-Reporter: Paul Clarke (7-pc)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <156686849716.6431.16425651381928336460.malonedeb@gac.canonical.com>
Message-Id: <157857673323.2497.12116916948054570736.malone@soybean.canonical.com>
Subject: [Bug 1841491] Re: floating point emulation can fail to set
 FE_UNDERFLOW
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 330b2d80ac5aeb9ef5c7815228950e3a802ae4af
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
Reply-To: Bug 1841491 <1841491@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A patch for this bug has been merged here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dcbc65a8f22b29680f3
... can we close this ticket now or is there more to do?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1841491

Title:
  floating point emulation can fail to set FE_UNDERFLOW

Status in QEMU:
  Confirmed

Bug description:
  Floating point emulation can fail to set FE_UNDERFLOW in some
  circumstances. This shows up often in glibc's "math" tests. A similar
  test is attached.

  This is similar to bug #1841442, but not the same problem, and I don't
  think the fix will be in the same code.

  On ppc64le native:
  --
  $ gcc -c -O2 fma.c
  $ gcc -O2 test-fma.c fma.o -lm -o test-fma
  $ ./test-fma $(./test-fma)
  fma(0x1.ffffffffffffcp-1022, 0x1.0000000000001p-1, 0x0.0000000000001p-102=
2)
  0x0

  0xa000000
  FE_INEXACT FE_UNDERFLOW =

  0x1p-1022
  --

  On qemu-system-ppc64:
  --
  $ ./test-fma $(./test-fma)
  fma(0x1.ffffffffffffcp-1022, 0x1.0000000000001p-1, 0x0.0000000000001p-102=
2)
  0x0

  0x2000000
  FE_INEXACT =

  0x1p-1022
  --

  QEMU versions vary, but not too much, and are pretty close to git HEAD:
  - 586f3dced9 (HEAD -> master, origin/master, origin/HEAD) Merge remote-tr=
acking branch 'remotes/cohuck/tags/s390x-20190822' into staging
  - 864ab31 Update version for v4.1.0-rc4 release

  There are worse symptoms on qemu-x86_64, but this is apparently not
  surprising per
  https://bugs.launchpad.net/qemu/+bug/1841442/comments/6.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1841491/+subscriptions

