Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0756DC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD6E207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD6E207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomvK-0005Sj-Qr
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iolth-0005xM-RJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ioltg-0008SI-E6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:15:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:40888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ioltg-0008RQ-6b
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:15:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iolte-0008U0-SH
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 10:15:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CFE892E805B
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 10:15:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jan 2020 10:02:02 -0000
From: Artyom <1858623@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: theartlav
X-Launchpad-Bug-Reporter: Artyom (theartlav)
X-Launchpad-Bug-Modifier: Artyom (theartlav)
Message-Id: <157839132261.5317.2350112240462311551.malonedeb@gac.canonical.com>
Subject: [Bug 1858623] [NEW] VNC outputs garbage in zlib mode
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 734500ca3a66b7e0e60892318635db6e3607779b
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
Reply-To: Bug 1858623 <1858623@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

TL;DR: When QEMU is launched with VNC as the output and viewed with a
client that defaults to zlib VNC encoding, the resulting output tends to
accumulate artifacts.

Reproduction:
Launch QEMU (tried with versions 4.2.0 and 4.1.0 on Linux  64bit) with -vnc=
 0.0.0.0:0
Connect to it with a VNC client that allows you to select encoding, i.e. Ul=
traVNC.
Set encoding to zlib (type 6), 32bit color.
As screen content changes it starts accumulating artifacts. Almost certain =
to appear if you open-close windows over a pattern.
Does not seem to depend on guest used, but easier to reproduce with a GUI.

Looks like this: https://orbides.org/img/vnc.png

It appears to be a deflate glitch of some sort - all of the bad pixels
are generated by length/distance codes. Can't narrow it down any more.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1858623

Title:
  VNC outputs garbage in zlib mode

Status in QEMU:
  New

Bug description:
  TL;DR: When QEMU is launched with VNC as the output and viewed with a
  client that defaults to zlib VNC encoding, the resulting output tends
  to accumulate artifacts.

  Reproduction:
  Launch QEMU (tried with versions 4.2.0 and 4.1.0 on Linux  64bit) with -v=
nc 0.0.0.0:0
  Connect to it with a VNC client that allows you to select encoding, i.e. =
UltraVNC.
  Set encoding to zlib (type 6), 32bit color.
  As screen content changes it starts accumulating artifacts. Almost certai=
n to appear if you open-close windows over a pattern.
  Does not seem to depend on guest used, but easier to reproduce with a GUI.

  Looks like this: https://orbides.org/img/vnc.png

  It appears to be a deflate glitch of some sort - all of the bad pixels
  are generated by length/distance codes. Can't narrow it down any more.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1858623/+subscriptions

