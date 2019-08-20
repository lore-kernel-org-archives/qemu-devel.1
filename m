Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DCBC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 09:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9847322CF5
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 09:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9847322CF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i00Yv-0002SR-Kp
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 05:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i00Y7-0001x4-IS
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 05:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i00Y6-0003FU-Af
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 05:35:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:40280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i00Y6-0003Ep-4c
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 05:35:30 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i00Y4-0001Qt-RW
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 09:35:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CB6E22E802D
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 09:35:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Aug 2019 09:29:24 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1840719@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: bios floppy x86
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <156625651066.23088.12772675524876649281.malonedeb@chaenomeles.canonical.com>
Message-Id: <156629336524.26262.17555573022453499413.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 64b269afd2fd07dfd437bf325b464e8f50c80956
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1840719] Re: win98se floppy fails to boot with
 isapc machine
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
Reply-To: Bug 1840719 <1840719@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Apparently the bisection result from comment #1 comes from a different
issue, the VGA display stays blank, can not test the floppy drive.

Bisecting using the pcbios.bin from fd646122418~, the VGA display stops
working at:

345c22aa80d1f6ddfe7898f721fd1be3bccb08f1 is the first bad commit
commit 345c22aa80d1f6ddfe7898f721fd1be3bccb08f1
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Fri Dec 18 12:01:12 2009 +0100

    roms: remove option rom packing logic
    =

    Now that we load the option roms via fw_cfg, we can stop copying
    them to the 0xc000 -> 0xe000.  The patch does just that.
    =

    Also the rom loader gets simplified as all remaining users of the
    rom loader load the bits at a fixed address so the packing and
    aligning logic can go away.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1840719

Title:
  win98se floppy fails to boot with isapc machine

Status in QEMU:
  New

Bug description:
  QEMU emulator version 4.1.50 (commit 50d69ee0d)

  floppy image from:
  https://winworldpc.com/download/417d71c2-ae18-c39a-11c3-a4e284a2c3a5

  $ qemu-system-i386 -M isapc -fda Windows\ 98\ Second\ Edition\ Boot.img
  SeaBIOS (version rel-1.12.1-0...)
  Booting from Floppy...
  Boot failed: could not read the boot disk

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1840719/+subscriptions

