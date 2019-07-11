Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D12EC74A52
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AFD21537
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AFD21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlXvN-0004sE-4R
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48224)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hlXuV-0003zX-Qq
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hlXuU-0007UM-Hg
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:10:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:35176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hlXuU-0007Tp-C2
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:10:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hlXuS-0000Fv-Vf
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 12:10:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id ECE9B2E8070
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 12:10:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jul 2019 11:59:33 -0000
From: Christophe Lyon <christophe.lyon+launchpad@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: christophe-lyon pmaydell
X-Launchpad-Bug-Reporter: Christophe Lyon (christophe-lyon)
X-Launchpad-Bug-Modifier: Christophe Lyon (christophe-lyon)
Message-Id: <156284637398.20784.534354445818037577.malonedeb@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e2f2d1ba35fb06bb6c0e520b5d4d0545189ec5e1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1836192] [NEW] Regressions on arm926 target with
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
Reply-To: Bug 1836192 <1836192@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hi,

After trying qemu master:
commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde
Merge: 68d7ff0 14f5d87
Author: Peter Maydell <email address hidden>
Date: Fri Jun 21 15:40:50 2019 +0100

even with the fix for https://bugs.launchpad.net/qemu/+bug/1834496,
I've noticed several regressions compared to qemu-3.1 when running the GCC =
testsuite, with GCC configured to generate arm10tdmi code by default, and u=
sing qemu's --cpu arm926.

I'm attaching a tarball containing one of the GCC tests (binaries),
needed shared libs, and a short script to run the test.

This was noticed with GCC master configured with
--target arm-none-linux-gnueabi
--with-cpu arm10tdmi
--with-fpu vfp

Thanks

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "qemu-4.0-regressions-arm-none-linux-gnueabihf-arm926.=
tar.xz"
   https://bugs.launchpad.net/bugs/1836192/+attachment/5276482/+files/qemu-=
4.0-regressions-arm-none-linux-gnueabihf-arm926.tar.xz

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1836192

Title:
  Regressions on arm926 target with some GCC tests

Status in QEMU:
  New

Bug description:
  Hi,

  After trying qemu master:
  commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde
  Merge: 68d7ff0 14f5d87
  Author: Peter Maydell <email address hidden>
  Date: Fri Jun 21 15:40:50 2019 +0100

  even with the fix for https://bugs.launchpad.net/qemu/+bug/1834496,
  I've noticed several regressions compared to qemu-3.1 when running the GC=
C testsuite, with GCC configured to generate arm10tdmi code by default, and=
 using qemu's --cpu arm926.

  I'm attaching a tarball containing one of the GCC tests (binaries),
  needed shared libs, and a short script to run the test.

  This was noticed with GCC master configured with
  --target arm-none-linux-gnueabi
  --with-cpu arm10tdmi
  --with-fpu vfp

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1836192/+subscriptions

