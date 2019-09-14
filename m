Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8A8C49ED6
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 04:32:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6477D20693
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 04:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6477D20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8zjf-0007GY-AF
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 00:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i8zhC-0006C3-MP
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 00:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i8zhA-0006AF-KE
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 00:30:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:39298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i8zhA-00063P-Ek
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 00:30:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i8zh8-0008D9-SK
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 04:29:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C99DC2E8083
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 04:29:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Sep 2019 04:17:27 -0000
From: Launchpad Bug Tracker <1606708@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor josem11200 th-huth
X-Launchpad-Bug-Reporter: =?utf-8?q?Jos=C3=A9_Miguel_=28josem11200=29?=
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20160726215226.16940.44257.malonedeb@wampee.canonical.com>
Message-Id: <156843464719.4426.10498795199247107743.malone@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e8b6bfaa5b0bafb39d432f5fa8c7f5d0c0a53757
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1606708] Re: QEMU crashes when switching consoles
 using SDL
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
Reply-To: Bug 1606708 <1606708@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1606708

Title:
  QEMU crashes when switching consoles using SDL

Status in QEMU:
  Expired

Bug description:
  I've trying to use QEMU with SDL, and I noticed that it doesn't behave
  well, specially when switching from VGA to any console. Resuming,
  switching is erratic when using SDL, and its effects go from creating
  a new window, doing nothing, showing a window that disappears
  inmediately or even crash.

  Tested with:
  Arch Linux with all packages updated (2016/7/26)
  TWM as window manager
  QEMU (both stable 2.6.0-1 and latest git commit f49ee63)
  Command: qemu-system-x86_64 -display sdl

  sdl2 version 2.0.4-2

  How to reproduce:
  1. Open QEMU with the given command
  2. Try to switch console (Ctrl-Alt-2 for example)

  Expected behaviour:
  As in GTK, the window should now show the desired console

  Actual behaviour:
  Here I have to say I can't explain it very well. Almost always it just cr=
eates a new window that shows the desired console, but it is closed inmedia=
tley. If not, it opens a new window that keeps open, and it sometimes is re=
sponsive, but further attempts to switch consoles end causing a crash, and =
QEMU has to be SIGKILLed

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1606708/+subscriptions

