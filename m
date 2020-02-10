Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63514C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 23:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3792420715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 23:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3792420715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Iai-0003HT-6N
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 18:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j1IZs-0002dL-KE
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 18:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j1IZr-0001pz-Gh
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 18:34:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:59492)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j1IZr-0001ll-Ax
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 18:34:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j1IZn-0007DP-1b
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:34:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 01BDA2E802B
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:34:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Feb 2020 23:22:21 -0000
From: Sergey Nizovtsev <1502613@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Wishlist;
 assignee=snizovtsev@gmail.com; 
X-Launchpad-Bug-Tags: battery management power virtual
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: naftaly-avadiaev snizovtsev wolfgangandreas
X-Launchpad-Bug-Reporter: Wolfgang Andreas (wolfgangandreas)
X-Launchpad-Bug-Modifier: Sergey Nizovtsev (snizovtsev)
References: <20151004131253.1871.94138.malonedeb@wampee.canonical.com>
Message-Id: <158137694122.19555.10796048629016029147.malone@gac.canonical.com>
Subject: [Bug 1502613] Re: [Feature Request] Battery Status / Virtual Battery
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6386c330afc7090e47f21ee02844692fe2bdd358
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
Reply-To: Bug 1502613 <1502613@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've started working on this issue and have some progress. Fedora 31
guest is already able to see a battery device but its state currently
hardcoded. I think i will finish this in a few weeks.

** Attachment added: "qemu-battery-poc.png"
   https://bugs.launchpad.net/qemu/+bug/1502613/+attachment/5327136/+files/=
qemu-battery-poc.png

** Changed in: qemu
     Assignee: (unassigned) =3D> Sergey Nizovtsev (snizovtsev)

** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1502613

Title:
  [Feature Request] Battery Status / Virtual Battery

Status in QEMU:
  In Progress

Bug description:
  When using virtualization on notebooks heavily then virtual machines
  do not realize that they're running on a notebook device causing high
  power consumption because they're not switching into a optimized
  "laptop mode". This leads to the circumstance that they are trying to
  do things like defragmentation / virtus scan / etc. while the host is
  still running on batteries.

  So it would be great if QEMU / KVM would have support for emulating
  "Virtual Batteries" to guests causing them to enable power-saving
  options like disabling specific services / devices / file operations
  automatically by OS.

  Optionally a great feature would be to set virtual battery's status
  manually. For example: Current charge rate / charging / discharging /
  ...

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1502613/+subscriptions

