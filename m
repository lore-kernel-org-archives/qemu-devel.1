Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HEXHASH_WORD,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DEBC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83ACE208E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83ACE208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgX3n-000251-Lg
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34507)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hgWMP-0000HK-Ao
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hgWMO-0004gx-0n
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:30:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:39264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hgWMN-0004ee-Qh
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:30:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hgWMK-0008P7-5x
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 15:30:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2AB262E80D4
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 15:30:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Jun 2019 15:20:49 -0000
From: Christophe Lyon <christophe.lyon+launchpad@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: christophe-lyon
X-Launchpad-Bug-Reporter: Christophe Lyon (christophe-lyon)
X-Launchpad-Bug-Modifier: Christophe Lyon (christophe-lyon)
Message-Id: <156164884976.17804.15592866928864750515.malonedeb@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18991";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 72b73eeeaf7809e7d5723381199d86803bcab805
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1834496] [NEW] Regressions on arm target with
 some GCC tests
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
Reply-To: Bug 1834496 <1834496@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hi,

After trying qemu master:
commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde
Merge: 68d7ff0 14f5d87
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Fri Jun 21 15:40:50 2019 +0100

I found several regressions compared to qemu-3.1 when running the GCC tests=
uite.
I'm attaching a tarball containing several GCC tests (binaries), needed sha=
red libs, and a short script to run all the tests.

All tests used to pass w/o error (one of them is verbose), but with a
recent qemu, all of them make qemu crash:

qemu: uncaught target signal 6 (Aborted) - core dumped

This was noticed with GCC master configured with
--target arm-none-linux-gnueabi
--with-mode arm
--with-cpu cortex-a9

and calling qemu with --cpu cortex-a9 (the script uses "any", this makes
no difference).

I have noticed other failures with arm-v8 code, but this is probably the
same root cause. Since it's a bit tedious to manually rebuild & extract
the testcases, I'd prefer to start with this subset, and I can extract
more if needed later.

Thanks

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "qemu-errors.tar.xz"
   https://bugs.launchpad.net/bugs/1834496/+attachment/5273789/+files/qemu-=
errors.tar.xz

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1834496

Title:
  Regressions on arm target with some GCC tests

Status in QEMU:
  New

Bug description:
  Hi,

  After trying qemu master:
  commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde
  Merge: 68d7ff0 14f5d87
  Author: Peter Maydell <peter.maydell@linaro.org>
  Date:   Fri Jun 21 15:40:50 2019 +0100

  I found several regressions compared to qemu-3.1 when running the GCC tes=
tsuite.
  I'm attaching a tarball containing several GCC tests (binaries), needed s=
hared libs, and a short script to run all the tests.

  All tests used to pass w/o error (one of them is verbose), but with a
  recent qemu, all of them make qemu crash:

  qemu: uncaught target signal 6 (Aborted) - core dumped

  This was noticed with GCC master configured with
  --target arm-none-linux-gnueabi
  --with-mode arm
  --with-cpu cortex-a9

  and calling qemu with --cpu cortex-a9 (the script uses "any", this
  makes no difference).

  I have noticed other failures with arm-v8 code, but this is probably
  the same root cause. Since it's a bit tedious to manually rebuild &
  extract the testcases, I'd prefer to start with this subset, and I can
  extract more if needed later.

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1834496/+subscriptions

