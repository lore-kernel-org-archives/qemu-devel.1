Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E11C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 19:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2768620578
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 19:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2768620578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ0M4-0007K1-V7
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 15:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jJ0HC-00048E-DJ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jJ0HB-0008S9-50
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:40:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:33214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jJ0HA-0008RL-Vm
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:40:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jJ0H9-0006Rl-Ky
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 19:40:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 96CCE2E80C8
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 19:40:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Mar 2020 19:33:48 -0000
From: Manuel Reimer <manuel.reimer@gmx.de>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: manuel-reimer pmaydell
X-Launchpad-Bug-Reporter: Manuel Reimer (manuel-reimer)
X-Launchpad-Bug-Modifier: Manuel Reimer (manuel-reimer)
References: <158559478745.21027.13296208481863226077.malonedeb@gac.canonical.com>
Message-Id: <158559682886.21309.16404661287902367676.malone@gac.canonical.com>
Subject: [Bug 1869782] Re: qemu-arm-static crashes "segmentation fault" when
 running "svn checkout"
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 061ca331da27f0ccf38c3e97086486cb0106272f
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
Reply-To: Bug 1869782 <1869782@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here we go:
https://travis-ci.com/github/VDR4Arch/vdr4arch/jobs/309187889#L332

Created with this commit:
https://github.com/VDR4Arch/vdr4arch/commit/29ec2197483bf15102c889eef2749bb=
0cffc0839

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1869782

Title:
  qemu-arm-static crashes "segmentation fault" when running "svn
  checkout"

Status in QEMU:
  New

Bug description:
  I'm not actually sure how far I can help as I so far failed to
  reproduce the issue on my local VM but I get it on Travis CI every
  time. I even went through the hassle of hacking a Debian repository
  into their Ubuntu Bionic VM to get qemu 4.2 as I hoped a new version
  could fix this.

  This build runs in an armv6h chroot. I don't get the segfault if I do
  the same on an armv7h chroot for some reason.

  Here is where the error occured: https://travis-
  ci.com/github/VDR4Arch/vdr4arch/jobs/309106220#L5420

  Maybe now I'll just try to remove all uses of svn in my build
  scripts...

  Is it actually a viable solution to cross-build with qemu? I'm
  starting to doubt it...

  Would it help if I manage to get this core dump out of Travis somehow
  (maybe make Travis push it to some GIT or upload it to my webserver)?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1869782/+subscriptions

