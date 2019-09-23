Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF17EC32755
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A4D20835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A4D20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCNpQ-0006uV-Jy
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 08:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iCNo5-0005oD-TJ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iCNo4-0000G9-FK
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:51:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:60836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iCNo4-0000FR-9g
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:51:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iCNo1-0004w5-KB
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 12:51:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D90E52E81B7
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 12:51:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Sep 2019 12:38:02 -0000
From: Frank Heimes <1842774@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: product=ubuntu-z-systems; status=Triaged; importance=High;
 assignee=frank.heimes@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=linux; component=main;
 status=In Progress; importance=High; assignee=canonical-kernel-team; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=bionic; sourcepackage=linux;
 component=main; status=In Progress; importance=High;
 assignee=canonical-kernel-team; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=disco; sourcepackage=linux; 
 component=main; status=In Progress; importance=High;
 assignee=canonical-kernel-team; 
X-Launchpad-Bug-Tags: architecture-s39064 bugnameltc-181268 severity-high
 targetmilestone-inin1910
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: andrew-cloke bugproxy frank-heimes
X-Launchpad-Bug-Reporter: bugproxy (bugproxy)
X-Launchpad-Bug-Modifier: Frank Heimes (frank-heimes)
References: <156764756485.6162.5365845259935486076.malonedeb@soybean.canonical.com>
Message-Id: <156924228502.32250.10595638828693152882.launchpad@wampee.canonical.com>
Subject: [Bug 1842774] Re: Enhanced Hardware Support - Finalize Naming
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 68adce9ed8dcf409587cbffb25cf6a62239f0ad5
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
Reply-To: Bug 1842774 <1842774@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Information type changed from Private to Public

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1842774

Title:
  Enhanced Hardware Support - Finalize Naming

Status in QEMU:
  Incomplete
Status in Ubuntu on IBM z Systems:
  Triaged
Status in linux package in Ubuntu:
  In Progress
Status in linux source package in Bionic:
  In Progress
Status in linux source package in Disco:
  In Progress

Bug description:
  SRU Justification:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  [Impact]

  * Add / activate support for IBM z15 and LinuxONE III systems

  [Fix]

  * a0e2251132995b962281aa80ab54a9288f9e0b6b a0e2251 "s390: add support
  for IBM z15 machines"

  [Test Case]

  * check and verify cpuinfo - regression testing is possible by
  Canonical/me

  * functional testing is currently only doable by IBM

  [Regression Potential]

  * There is regression potential with having new code in and the flags
  added/active

  * but the code changes are pretty straight forward, just add config,
  cases and defs

  * and are not used on existing systems, just on the new generation
  that is not yet out in the field

  [Other Info]

  * SRU of LP 1842916 merged with (this) LP 1842774

  __________

  This feature request will provide the final naming of the next machine

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1842774/+subscriptions

