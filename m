Return-Path: <SRS0=vKWr=3A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5BEC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 00:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632CA24649
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 00:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632CA24649
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq4vZ-0006Ec-08
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 19:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iq4uL-0005MK-6I
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 19:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iq4uJ-0005Ww-Js
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 19:45:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:49478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iq4uJ-0005RY-Ce
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 19:45:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iq4uH-0004Fu-R4
 for <qemu-devel@nongnu.org>; Sat, 11 Jan 2020 00:45:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C84D42E80BA
 for <qemu-devel@nongnu.org>; Sat, 11 Jan 2020 00:45:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jan 2020 00:36:09 -0000
From: Benjamin David Lunt <1859254@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fysnet
X-Launchpad-Bug-Reporter: Benjamin David Lunt (fysnet)
X-Launchpad-Bug-Modifier: Benjamin David Lunt (fysnet)
Message-Id: <157870296945.2981.16734744521304733139.malonedeb@soybean.canonical.com>
Subject: [Bug 1859254] [NEW] host window size does not change when guest video
 screen size changes while moving host window
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1e3a15a11df4740dc4284df5c0384577f60805cb
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
Reply-To: Bug 1859254 <1859254@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

When QEMU is emulating a legacy text mode, then switches to a VESA mode,
if you happen to be moving the host window while the switch is made, the
host window never changes size.  The emulated size does, but the host
window doesn't.

For example, at Legacy boot up, the screen mode is mode 03 at 80x25.
Then when the GUEST OS changes the screen to a VESA mode, say
1024x768x16, normally the host window will change to that size to
accommodate the new emulated screen size.

However, if you happen to be moving the host window at the time of the
screen mode change, the host window doesn't change in size to
accommodate the new screen size.

I am using:
  QEMU for Windows, version 4.1.0-11789
  Host: Windows 10 (latest updates)
  Emulating: Intel x64, Legacy BIOS
Command line:
"c:\program files\qemu\qemu-system-x86_64.exe" -m 256 -drive file=3DC:\fyso=
s64.img,format=3Draw,if=3Dide,media=3Ddisk,index=3D0 -parallel file:para.tx=
t -boot c -d guest_errors -vga std -smp cpus=3D4 -rtc base=3Dlocaltime,cloc=
k=3Dhost,driftfix=3Dslew -net none -monitor stdio

I tried different -vga settings:
   -vga std
   -vga cirrus
   -vga vmware
Each did the same thing.

[ Side note (possible error in documentation):
[  at: https://qemu.weilnetz.de/doc/qemu-doc.html#SVGA-graphic-modes-support
[  end of 2.16.2.1
[  (option -std-vga)
[    possibly should be
[  (option -vga std)

If you need an image to test with, I have been using
www.fysnet.net/temp/fysos64.zip (2meg zipped/10meg raw).  It starts in
Legacy BIOS/Hardware mode 3, then switches to VESA 1024x768x16 within a
few seconds, so be ready to move the HOST window when the mode changes.

I do not have a Linux box to test with, so unknown if this is only an
issue with the Windows version or not.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859254

Title:
  host window size does not change when guest video screen size changes
  while moving host window

Status in QEMU:
  New

Bug description:
  When QEMU is emulating a legacy text mode, then switches to a VESA
  mode, if you happen to be moving the host window while the switch is
  made, the host window never changes size.  The emulated size does, but
  the host window doesn't.

  For example, at Legacy boot up, the screen mode is mode 03 at 80x25.
  Then when the GUEST OS changes the screen to a VESA mode, say
  1024x768x16, normally the host window will change to that size to
  accommodate the new emulated screen size.

  However, if you happen to be moving the host window at the time of the
  screen mode change, the host window doesn't change in size to
  accommodate the new screen size.

  I am using:
    QEMU for Windows, version 4.1.0-11789
    Host: Windows 10 (latest updates)
    Emulating: Intel x64, Legacy BIOS
  Command line:
  "c:\program files\qemu\qemu-system-x86_64.exe" -m 256 -drive file=3DC:\fy=
sos64.img,format=3Draw,if=3Dide,media=3Ddisk,index=3D0 -parallel file:para.=
txt -boot c -d guest_errors -vga std -smp cpus=3D4 -rtc base=3Dlocaltime,cl=
ock=3Dhost,driftfix=3Dslew -net none -monitor stdio

  I tried different -vga settings:
     -vga std
     -vga cirrus
     -vga vmware
  Each did the same thing.

  [ Side note (possible error in documentation):
  [  at: https://qemu.weilnetz.de/doc/qemu-doc.html#SVGA-graphic-modes-supp=
ort
  [  end of 2.16.2.1
  [  (option -std-vga)
  [    possibly should be
  [  (option -vga std)

  If you need an image to test with, I have been using
  www.fysnet.net/temp/fysos64.zip (2meg zipped/10meg raw).  It starts in
  Legacy BIOS/Hardware mode 3, then switches to VESA 1024x768x16 within
  a few seconds, so be ready to move the HOST window when the mode
  changes.

  I do not have a Linux box to test with, so unknown if this is only an
  issue with the Windows version or not.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1859254/+subscriptions

