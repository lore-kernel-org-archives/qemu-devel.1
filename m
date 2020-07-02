Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B07C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 20:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23672088E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 20:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23672088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr5tK-0004EL-07
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 16:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jr5rC-0002M4-Gk
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 16:30:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:43474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jr5r9-0005q5-5q
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 16:30:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jr5r5-00033l-Ee
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 20:30:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A0E362E8117
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2020 20:30:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2020 20:21:22 -0000
From: Allan Peramaki <1873769@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: aperamak markostamcar
X-Launchpad-Bug-Reporter: =?utf-8?q?Marko_=C5=A0tamcar_=28markostamcar=29?=
X-Launchpad-Bug-Modifier: Allan Peramaki (aperamak)
References: <158737489336.27883.11672421823937229418.malonedeb@gac.canonical.com>
Message-Id: <159372128303.32236.2486358721218214430.malone@chaenomeles.canonical.com>
Subject: [Bug 1873769] Re: SB16 audio playback freezes emulation in Windows 95
 guest
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6c495716b70b1ec095987a75c9f95304d96a3fad
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 16:30:48
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
Reply-To: Bug 1873769 <1873769@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is with GTK UI? Do you still have the same problem if you use Spice
and remote-viewer instead?

(GTK UI and Sound Blaster 16 emulation don't play well together. GTK UI
does screen updates only when the main event loop becomes idle, but it
never becomes idle when SB16 audio is playing due to the way
hw/dma/i8257 works. The combination of GTK UI screen updates + SB16 DMA
transfer additionally causes i8257_dma_run() getting called at a very
rapid rate.)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1873769

Title:
  SB16 audio playback freezes emulation in Windows 95 guest

Status in QEMU:
  New

Bug description:
  - QEMU 4.2.93 (v5.0.0-rc3) built from latest git master
  20038cd7a8412feeb49c01f6ede89e36c8995472 using MSYS2 on Windows 10 and
  launched on same Windows 10

  - Launched using "qemu-system-i386.exe -drive format=3Draw,file=3Dhdd-
  2gb.img -soundhw pcspk,sb16 -m 16 -cpu pentium -vga std -cdrom
  Windows_95.iso -boot c"

  - I have attached video screen capture of the issue

  ---

  I decided to make my first ever QEMU build after encountering the
  dsound issues using the latest 4.2.0 binary from
  https://qemu.weilnetz.de/w64/. In my 5.0.0-rc3 build the sound
  playback is working correctly, however the whole Windows 95 UI freezes
  while sound is playing.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1873769/+subscriptions

