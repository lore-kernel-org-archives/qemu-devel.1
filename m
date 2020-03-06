Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A7DC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FC6207FD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FC6207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA9B5-0004cE-EW
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 04:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jA9AB-0003l4-QF
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jA9AA-0002Dy-K8
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:20:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:34264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jA9AA-00026c-Do
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:20:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jA9A8-0003lO-2L
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 09:20:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 690552E8108
 for <qemu-devel@nongnu.org>; Fri,  6 Mar 2020 09:20:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Mar 2020 09:09:08 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1859106@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: chungy philmd
X-Launchpad-Bug-Reporter: Mike Swanson (chungy)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <157861943690.5587.1150668522953222724.malonedeb@gac.canonical.com>
Message-Id: <158348574903.26040.15244673052303085700.malone@gac.canonical.com>
Subject: [Bug 1859106] Re: 4.2 regression: ReactOS crashes on boot
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 845672203181f668e70de4c1b4dbfa6cffacb131
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
Reply-To: Bug 1859106 <1859106@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Possibly related thread:
"Do we need a cpu with TSC support to run SeaBIOS?"
https://www.mail-archive.com/seabios@seabios.org/msg11726.html

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859106

Title:
  4.2 regression: ReactOS crashes on boot

Status in QEMU:
  New

Bug description:
  In QEMU 4.1.x and earlier, ReactOS can successfully boot, but starting
  with 4.2, it fails, instead coming up with an error "The video driver
  failed to initialize."

  This happens regardless of VM configuration (even -M pc-i440fx-4.1)
  and it works well with older versions of QEMU. bisecting QEMU to find
  the first bad commit reveals 0221d73ce6a8e075adaa0a35a6ef853d2652b855
  as the culprit, which is updating the seabios version; perhaps this
  bug belongs there, but I don't know the appropriate avenue (it seems
  seabios is a subproject of QEMU anyway?).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1859106/+subscriptions

