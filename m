Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0387C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 20:41:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B382098B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 20:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B382098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS58l-0000Tt-Rk
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 16:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jS588-0008L8-Na
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jS588-0003Jc-0E
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:41:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:38846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jS587-00034G-IQ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:40:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jS585-0004QA-Cw
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 20:40:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5F2742E806D
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 20:40:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2020 20:27:42 -0000
From: Jean-Yves BAUDY <1874904@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jbytibidi
X-Launchpad-Bug-Reporter: Jean-Yves BAUDY (jbytibidi)
X-Launchpad-Bug-Modifier: Jean-Yves BAUDY (jbytibidi)
Message-Id: <158776006238.17831.1947739599630021875.malonedeb@wampee.canonical.com>
Subject: [Bug 1874904] [NEW] qemu windows with gtk and french keypad not
 working as expected
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="486bbbd6cb608f8eb468ed0d08689a349dfabe49";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 2fa53b136f979d21adb338c4fabd606fc46a7793
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 14:50:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1874904 <1874904@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

When I use qemu on Windows 10 with a French AZERTY keypad with the
correct options the emulated system keypad still QWERTY. If I use sdl it
works fine the emulated keypad is AZERTY.

Example of command with ubuntu live cd:
-> qemu-system-x86_64.exe  -m 4G ubuntu-18.04.4-desktop-amd64.iso -display =
gtk -k fr

NOTES:
=C2=A0- Using the same command on Linux works fine. The emulated keypad is =
AZERTY.

Qemu version : 4.2.0 on Windows 10

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  When I use qemu on Windows 10 with a French AZERTY keypad with the
- correct options the emulated system keypad still QWERTY. If we use sdl
- it works fine the emulated keypad is AZERTY.
+ correct options the emulated system keypad still QWERTY. If I use sdl it
+ works fine the emulated keypad is AZERTY.
  =

  Example of command with ubuntu live cd:
  -> qemu-system-x86_64.exe  -m 4G ubuntu-18.04.4-desktop-amd64.iso -displa=
y gtk -k fr
  =

  NOTES:
-  - Using the same command on Linux works fine. The emulated keypad is AZE=
RTY.
+ =C2=A0- Using the same command on Linux works fine. The emulated keypad i=
s AZERTY.
  =

  Qemu version : 4.2.0 on Windows 10

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1874904

Title:
  qemu windows with gtk and french keypad not working as expected

Status in QEMU:
  New

Bug description:
  When I use qemu on Windows 10 with a French AZERTY keypad with the
  correct options the emulated system keypad still QWERTY. If I use sdl
  it works fine the emulated keypad is AZERTY.

  Example of command with ubuntu live cd:
  -> qemu-system-x86_64.exe  -m 4G ubuntu-18.04.4-desktop-amd64.iso -displa=
y gtk -k fr

  NOTES:
  =C2=A0- Using the same command on Linux works fine. The emulated keypad i=
s AZERTY.

  Qemu version : 4.2.0 on Windows 10

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1874904/+subscriptions

