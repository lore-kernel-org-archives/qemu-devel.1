Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9550C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 22:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A477924658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 22:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A477924658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irUG8-0005Cn-Ov
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 17:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1irUFE-0004kn-En
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 17:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1irUFA-0000zq-GU
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 17:01:04 -0500
Received: from indium.canonical.com ([91.189.90.7]:45108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1irUFA-0000yI-A9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 17:01:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1irUF8-00063q-6Z
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 22:00:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EBBC52E80D3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 22:00:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jan 2020 21:53:00 -0000
From: =?utf-8?q?Nils_ANDR=C3=89-CHANG?= <1859723@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: nilsa
X-Launchpad-Bug-Reporter: =?utf-8?q?Nils_ANDR=C3=89-CHANG_=28nilsa=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Nils_ANDR=C3=89-CHANG_=28nilsa=29?=
Message-Id: <157903878062.27252.729025731260908080.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1859723] [NEW] Qemu ungrabs before cursor reaches border
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: bf992d2d5647135e7979ad3bcaa302a29d84b852
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
Reply-To: Bug 1859723 <1859723@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

This was first reported
https://bugzilla.redhat.com/show_bug.cgi?id=3D1285378

video: https://peertube.co.uk/videos/watch/fedaa432-79ef-4d30-bd0e-
26c806e48db0

version: QEMU emulator version 4.2.0

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859723

Title:
  Qemu ungrabs before cursor reaches border

Status in QEMU:
  New

Bug description:
  This was first reported
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1285378

  video: https://peertube.co.uk/videos/watch/fedaa432-79ef-4d30-bd0e-
  26c806e48db0

  version: QEMU emulator version 4.2.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1859723/+subscriptions

