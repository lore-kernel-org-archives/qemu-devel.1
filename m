Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2AEC4332B
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 06:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEDB20753
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 06:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEDB20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFtgB-0003ZF-LA
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 02:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jFtfT-0003Al-BT
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 02:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jFtfS-0006bI-6L
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 02:01:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:39308)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jFtfS-0006b9-0l
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 02:01:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jFtfQ-0004jR-DX
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 06:01:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5E3572E8029
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 06:01:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Mar 2020 05:55:34 -0000
From: Lockywolf <1868221@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: gui usability
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange lockywolf
X-Launchpad-Bug-Reporter: Lockywolf (lockywolf)
X-Launchpad-Bug-Modifier: Lockywolf (lockywolf)
References: <158469084688.19486.16271224237247905413.malonedeb@chaenomeles.canonical.com>
Message-Id: <158485653452.28071.17126667916468437638.malone@gac.canonical.com>
Subject: [Bug 1868221] Re: /usr/share/applications/qemu.desktop should have an
 "Exec=" key.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0ee69340a343781fe32ce65bf57c82cbbd4c662d
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
Reply-To: Bug 1868221 <1868221@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'll report a bug in KDE and let's see if the guys agree. Maybe it is a
deficiency of the .desktop specification.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1868221

Title:
  /usr/share/applications/qemu.desktop should have an "Exec=3D" key.

Status in QEMU:
  New

Bug description:
  According to the www.freedesktop.org .desktop-file specification, all
  "Application" desktop files should have an "Exec=3D" key. The one in
  qemu doesn't.

  This can be easily verified by running kbuildsycoca4 if KDE4 is
  present, but the issue is not DE-dependent.

  Which binary exactly should be assigned as the default one, I don't
  know.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1868221/+subscriptions

