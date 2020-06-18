Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EBBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBC0206F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBC0206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmwL-0001AZ-4u
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlmfa-0005px-KU
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 01:00:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:35616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlmfW-0008Pz-SC
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 01:00:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jlmfU-0005qo-HW
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 05:00:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7EE492E8060
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 05:00:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2020 04:54:32 -0000
From: David Glover <1884017@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: qemu-system-i386
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: me-davidglover
X-Launchpad-Bug-Reporter: David Glover (me-davidglover)
X-Launchpad-Bug-Modifier: David Glover (me-davidglover)
Message-Id: <159245607293.6124.18309162054825340522.malonedeb@soybean.canonical.com>
Subject: [Bug 1884017] [NEW] Intermittently erratic mouse under Windows 95
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 3261ae1108fc1b475cf911e8f6834e18896107dc
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:00:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Reply-To: Bug 1884017 <1884017@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

The mouse works fine maybe 75-80% of the time, but intermittently (every
20-30 seconds or so), moving the mouse will cause the pointer to fly
around the screen at high speed, usually colliding with the edges, and
much more problematically, click all the mouse buttons at random, even
if you are not clicking. This causes random objects on the screen to be
clicked and dragged around, rendering the system generally unusable.

I don't know if this is related to #1785485 - it happens even if you
never use the scroll wheel.

qemu version: 5.0.0 (openSUSE Tumbleweed)

Launch command line: qemu-system-i386 -hda win95.qcow2 -cpu pentium2 -m
16 -vga cirrus -soundhw sb16 -nic user,model=3Dpcnet -rtc base=3Dlocaltime

OS version: Windows 95 4.00.950 C

I have made the disk image available here:
https://home.gloveraoki.me/share/win95.qcow2.lz

Setup notes: In order to make Windows 95 detect the system devices
correctly, after first install you must change the driver for "Plug and
Play BIOS" to "PCI bus". I have already done this in the above image.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: qemu-system-i386

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1884017

Title:
  Intermittently erratic mouse under Windows 95

Status in QEMU:
  New

Bug description:
  The mouse works fine maybe 75-80% of the time, but intermittently
  (every 20-30 seconds or so), moving the mouse will cause the pointer
  to fly around the screen at high speed, usually colliding with the
  edges, and much more problematically, click all the mouse buttons at
  random, even if you are not clicking. This causes random objects on
  the screen to be clicked and dragged around, rendering the system
  generally unusable.

  I don't know if this is related to #1785485 - it happens even if you
  never use the scroll wheel.

  qemu version: 5.0.0 (openSUSE Tumbleweed)

  Launch command line: qemu-system-i386 -hda win95.qcow2 -cpu pentium2
  -m 16 -vga cirrus -soundhw sb16 -nic user,model=3Dpcnet -rtc
  base=3Dlocaltime

  OS version: Windows 95 4.00.950 C

  I have made the disk image available here:
  https://home.gloveraoki.me/share/win95.qcow2.lz

  Setup notes: In order to make Windows 95 detect the system devices
  correctly, after first install you must change the driver for "Plug
  and Play BIOS" to "PCI bus". I have already done this in the above
  image.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1884017/+subscriptions

