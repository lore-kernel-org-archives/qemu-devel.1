Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EE2C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792652084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792652084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6seU-0003oq-NM
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j6sdV-0002wM-Jv
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:05:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j6sdR-0006TO-Rz
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:05:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:59324)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j6sdR-0006SF-Kk
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:05:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j6sdP-0000kX-W1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 09:05:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EDEA32E8025
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 09:05:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Feb 2020 08:54:20 -0000
From: Peter Vegh <1864814@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pbuntu1
X-Launchpad-Bug-Reporter: Peter Vegh (pbuntu1)
X-Launchpad-Bug-Modifier: Peter Vegh (pbuntu1)
Message-Id: <158270726043.14146.8926447072185498744.malonedeb@wampee.canonical.com>
Subject: [Bug 1864814] [NEW] Improve UX for macOS when launching from a
 fullscreen app
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="9eff1c37c1740693bdcba94d8f8c608164af5689";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a6659bf9503a55c970afb363ace5ab971cf4f322
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Bug 1864814 <1864814@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

System/setup:
* MacBook Pro, macOS (any version from the last 2 years), external monitor.
* IDE on the laptop, emulator is used on the external monitor.

Currently, when starting the emulator from e.g. Android Studio or
IntelliJ IDEA, which is set to fullscreen mode on the laptop, which is
like it's own virtual desktop (Space) in macOS, what happens is this:

1. The virtual desktop (Space) on the laptop screen is switched because of =
#2. The reason is that only one window can be shown in Fullscreen this way.
2. The qemu splashscreen is shown for a few seconds, then it disappears. Th=
is is the reason for the virtual desktop switch. This splashscreen seems ac=
tually unnecessary to me, it has no value and it causes problems.
3. The actual emulator is shown, in my case on the external monitor (correc=
tly). I guess if the splashscreen would not be shown, the virtual desktop s=
witch would not happen, because the emulator would happen on the correct sc=
reen directly.

So maybe the splashscreen and the emulator window should be the same window=
, so that the OS can remember it's position being the same as the emulator?
Or maybe the splash could be disabled (by default? otherwise an update to I=
DEs would be necessary for the improved behavior?)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1864814

Title:
  Improve UX for macOS when launching from a fullscreen app

Status in QEMU:
  New

Bug description:
  System/setup:
  * MacBook Pro, macOS (any version from the last 2 years), external monito=
r.
  * IDE on the laptop, emulator is used on the external monitor.

  Currently, when starting the emulator from e.g. Android Studio or
  IntelliJ IDEA, which is set to fullscreen mode on the laptop, which is
  like it's own virtual desktop (Space) in macOS, what happens is this:

  1. The virtual desktop (Space) on the laptop screen is switched because o=
f #2. The reason is that only one window can be shown in Fullscreen this wa=
y.
  2. The qemu splashscreen is shown for a few seconds, then it disappears. =
This is the reason for the virtual desktop switch. This splashscreen seems =
actually unnecessary to me, it has no value and it causes problems.
  3. The actual emulator is shown, in my case on the external monitor (corr=
ectly). I guess if the splashscreen would not be shown, the virtual desktop=
 switch would not happen, because the emulator would happen on the correct =
screen directly.

  So maybe the splashscreen and the emulator window should be the same wind=
ow, so that the OS can remember it's position being the same as the emulato=
r?
  Or maybe the splash could be disabled (by default? otherwise an update to=
 IDEs would be necessary for the improved behavior?)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1864814/+subscriptions

