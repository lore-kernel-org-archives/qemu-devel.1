Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E468C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 03:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3229239D4
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 03:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3229239D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKYZD-0004Yp-Ma
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 23:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kKYXy-0003vV-Gf
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 23:00:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:40812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kKYXv-0005Ks-V3
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 23:00:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kKYXt-0004az-NN
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:00:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id ADD872E804B
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:00:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2020 02:52:04 -0000
From: Benjamin David Lunt <1896561@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fysnet
X-Launchpad-Bug-Reporter: Benjamin David Lunt (fysnet)
X-Launchpad-Bug-Modifier: Benjamin David Lunt (fysnet)
Message-Id: <160074312416.13871.13514895218862238849.malonedeb@gac.canonical.com>
Subject: [Bug 1896561] [NEW] EFI GOP Mode 1366x768
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: cacea6e8574983a27d2987b9246514a6dd2eeeea
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 23:00:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1896561 <1896561@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

When using the EFI firmware from
https://www.kraxel.org/repos/jenkins/edk2/
(https://www.kraxel.org/repos/jenkins/edk2/edk2.git-
ovmf-x64-0-20200919.1453.g7faece6985.noarch.rpm) (OVMF-pure-efi.fd and
OVMF_VARS-pure-efi.fd) then using the GOP, setting the mode to 1366x768,
QEMU uses a width of 1360 instead.

I am using QEMU for windows (https://qemu.weilnetz.de/) on a Windows 10
machine.

To verify, while in the EFI firmware loaded code (within BOOTx64.EFI)
and before ExitBootServices(), I choose the 1360x768 mode.  I then took
notice of where the host window was and how many pixels it occupied.  I
then reset the emulation (without quitting) and chose the 1366x768 mode.
QEMU set the host window to the exact same width as the 1360 mode.
i.e.: The same exact pixels where shown in the host background.  The
window did not expand the extra 6 pixels.

I allowed the firmware to run its course to my test environment when
using mode 1366x768, all pixels are 6 pixels off to the right.  i.e.: 6
pixels down the Frame Buffer.  If my test environment changes its HORZ
WIDTH and PIXELS PER SCANLINE to 1360 while using this (1366x768) mode,
the display is correct.

This told me that it could be a few things.
1) Since most (I didn't check them all) of the other modes have the width v=
alue's bits 2:0 clear, mode 1366x768 is the only mode the EDK2 firmware has=
 with a width where bits 2:0 are not zero.  Could EDK2 or QEMU (which for t=
he Windows version may use SDL2 so it must be considered here) be clearing =
these bits?  The value of 1366 when clearing bits 2:0 is 1360.

2) Could there be a typo in the code EDK2 where the width should have been =
1366?
(I went looking at both QEMU (for Windows) and EDK2 and after looking at ma=
ny lines of code, I could not find anywhere where this might happen. =


By the way, in /ui/sdl2-2d.c (QEMU Windows version only?), there is a
typo in a comment, missing the second 'e':

Line 156:  * the native ones. Thes are the ones I have tested.

3) Could EDK2 be sending 1360 instead of 1366?
4) Could QEMU (passing it on to SDL2 in SDL_SetWindowSize()?) be destroying=
 the value (bottom three bits)?

Anyway, using the latest version of the EDK2 from the URL listed above,
choosing the 1366x768 mode, does not set QEMU (for Windows) to 1366
pixels in width.

Ben

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1896561

Title:
  EFI GOP Mode 1366x768

Status in QEMU:
  New

Bug description:
  When using the EFI firmware from
  https://www.kraxel.org/repos/jenkins/edk2/
  (https://www.kraxel.org/repos/jenkins/edk2/edk2.git-
  ovmf-x64-0-20200919.1453.g7faece6985.noarch.rpm) (OVMF-pure-efi.fd and
  OVMF_VARS-pure-efi.fd) then using the GOP, setting the mode to
  1366x768, QEMU uses a width of 1360 instead.

  I am using QEMU for windows (https://qemu.weilnetz.de/) on a Windows
  10 machine.

  To verify, while in the EFI firmware loaded code (within BOOTx64.EFI)
  and before ExitBootServices(), I choose the 1360x768 mode.  I then
  took notice of where the host window was and how many pixels it
  occupied.  I then reset the emulation (without quitting) and chose the
  1366x768 mode.  QEMU set the host window to the exact same width as
  the 1360 mode.  i.e.: The same exact pixels where shown in the host
  background.  The window did not expand the extra 6 pixels.

  I allowed the firmware to run its course to my test environment when
  using mode 1366x768, all pixels are 6 pixels off to the right.  i.e.:
  6 pixels down the Frame Buffer.  If my test environment changes its
  HORZ WIDTH and PIXELS PER SCANLINE to 1360 while using this (1366x768)
  mode, the display is correct.

  This told me that it could be a few things.
  1) Since most (I didn't check them all) of the other modes have the width=
 value's bits 2:0 clear, mode 1366x768 is the only mode the EDK2 firmware h=
as with a width where bits 2:0 are not zero.  Could EDK2 or QEMU (which for=
 the Windows version may use SDL2 so it must be considered here) be clearin=
g these bits?  The value of 1366 when clearing bits 2:0 is 1360.

  2) Could there be a typo in the code EDK2 where the width should have bee=
n 1366?
  (I went looking at both QEMU (for Windows) and EDK2 and after looking at =
many lines of code, I could not find anywhere where this might happen. =


  By the way, in /ui/sdl2-2d.c (QEMU Windows version only?), there is a
  typo in a comment, missing the second 'e':

  Line 156:  * the native ones. Thes are the ones I have tested.

  3) Could EDK2 be sending 1360 instead of 1366?
  4) Could QEMU (passing it on to SDL2 in SDL_SetWindowSize()?) be destroyi=
ng the value (bottom three bits)?

  Anyway, using the latest version of the EDK2 from the URL listed
  above, choosing the 1366x768 mode, does not set QEMU (for Windows) to
  1366 pixels in width.

  Ben

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1896561/+subscriptions

