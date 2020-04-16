Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49455C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 19:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5FA2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 19:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5FA2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=email.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPALH-0000MC-B5
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 15:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jPAIY-0005wl-5y
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jPAIW-00064r-L9
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:35:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:41498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jPAIV-00063H-Gb
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:35:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jPAIT-0005Xz-C3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 19:35:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 50B822E806D
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 19:35:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2020 19:28:26 -0000
From: ruthan <ruthan@email.cz>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ruthan
X-Launchpad-Bug-Reporter: ruthan (ruthan)
X-Launchpad-Bug-Modifier: ruthan (ruthan)
Message-Id: <158706530687.6368.4226982042682182002.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1873335] [NEW] Dos Keypad is not working for numbers - numlock
 is not working
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1e916786ac5e91ef76e7ef07c1ccf89570cc66c3
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
Reply-To: Bug 1873335 <1873335@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello,
i tried to use Qemu 4.2 for Dos, but there is problem what in Dos is not po=
ssible turn on Numlock for input numbers, so games need it.. Numlock only w=
orking as arrow keys.
=C2=A0=C2=A0I tested bough Windows and Linux builds.

With same setting, when i use Windows 98 or later os, numlock is working
fine.

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  Hello,
  i tried to use Qemu 4.2 for Dos, but there is problem what in Dos is not =
possible turn on Numlock for input numbers, so games need it.. Numlock only=
 working as arrow keys.
-   I tested bough Windows and Linux builds.
+ =C2=A0=C2=A0I tested bough Windows and Linux builds.
+ =

+ With same setting, when i use Windows 98 or later os, numlock is working
+ fine.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1873335

Title:
  Dos Keypad is not working for numbers - numlock is not working

Status in QEMU:
  New

Bug description:
  Hello,
  i tried to use Qemu 4.2 for Dos, but there is problem what in Dos is not =
possible turn on Numlock for input numbers, so games need it.. Numlock only=
 working as arrow keys.
  =C2=A0=C2=A0I tested bough Windows and Linux builds.

  With same setting, when i use Windows 98 or later os, numlock is
  working fine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1873335/+subscriptions

