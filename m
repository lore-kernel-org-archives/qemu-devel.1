Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762F1C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B17120661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B17120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXxa-0005lb-Cu
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ipXte-0001DD-So
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ipXtZ-0000Zg-PG
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:30:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:32988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ipXtY-0000XZ-DC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:30:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ipXtX-0000Tp-7d
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 13:30:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 37C722E80C8
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 13:30:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jan 2020 13:22:45 -0000
From: Thomas Huth <1847906@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: corwin-amber pmaydell zenojevski
X-Launchpad-Bug-Reporter: Shachar Itzhaky (corwin-amber)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <157097450557.5820.4200729468686724078.malonedeb@gac.canonical.com>
Message-Id: <157857616661.3421.17759281630965095006.launchpad@soybean.canonical.com>
Subject: [Bug 1847906] Re: Cocoa display hangs on macOS 10.15 (Catalina)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b793b48e71b2d4bf023d6f581c30aa4769039b1a
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
Reply-To: Bug 1847906 <1847906@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1847906

Title:
  Cocoa display hangs on macOS 10.15 (Catalina)

Status in QEMU:
  Fix Released

Bug description:
  I have downloaded the latest stable source tarball 4.1.0 and compiled
  it (i386-softmmu target).

  After opening a black window, QEMU hangs (spinning beach ball).
  When building with `--disable-cocoa --enable-sdl`, display seems to work =
fine.

  The same happened when I tried to build QEMU through HomeBrew and
  MacPorts.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1847906/+subscriptions

