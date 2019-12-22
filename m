Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628C5C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 13:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BFA2067C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 13:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BFA2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exploide.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ij1fE-0004BR-8T
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 08:52:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iiyLp-0004mW-0Y
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 05:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iiyLn-0002IV-KP
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 05:20:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:59092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iiyLn-0002Fv-Dz
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 05:20:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iiyLl-0008M3-H5
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2019 10:20:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7CAFE2E80C0
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2019 10:20:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Dec 2019 10:14:00 -0000
From: Jannik <me@exploide.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: exploide
X-Launchpad-Bug-Reporter: Jannik (exploide)
X-Launchpad-Bug-Modifier: Jannik (exploide)
Message-Id: <157700964058.28040.6250427039167117245.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1857226] [NEW] 'set_link net0 off' not working with e1000e driver
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8cd09dbb72502cca26d413881ec7a60460a0e320
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Sun, 22 Dec 2019 08:52:11 -0500
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
Reply-To: Bug 1857226 <1857226@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I'm encountering a bug with the e1000e network driver, that appears to
got previously reported at rhbz. Steps to reproduce are provided in
detail there:

https://bugzilla.redhat.com/show_bug.cgi?id=3D1707646

It is about switching off network link state (set_link net0 off) having
no effect when using the e1000e driver.

Version details:
QEMU emulator version 4.1.1 (qemu-4.1.1-1.fc31)
Fedora 31

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1857226

Title:
  'set_link net0 off' not working with e1000e driver

Status in QEMU:
  New

Bug description:
  I'm encountering a bug with the e1000e network driver, that appears to
  got previously reported at rhbz. Steps to reproduce are provided in
  detail there:

  https://bugzilla.redhat.com/show_bug.cgi?id=3D1707646

  It is about switching off network link state (set_link net0 off)
  having no effect when using the e1000e driver.

  Version details:
  QEMU emulator version 4.1.1 (qemu-4.1.1-1.fc31)
  Fedora 31

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1857226/+subscriptions

