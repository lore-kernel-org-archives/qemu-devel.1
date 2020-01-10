Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C19C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:32:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC29205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC29205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipxCe-000336-Vn
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 11:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ipxBV-0002WF-7d
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ipxBL-0008QZ-Ef
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:30:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:36052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ipxBL-0008OD-6l
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:30:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ipxBI-0000a4-9h
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 16:30:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1BCE02E80D2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 16:30:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jan 2020 16:20:42 -0000
From: =?utf-8?q?Roman_B=C3=A4riswyl?= <1859081@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: programmingkidx roemeeeer
X-Launchpad-Bug-Reporter: =?utf-8?q?Roman_B=C3=A4riswyl_=28roemeeeer=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Roman_B=C3=A4riswyl_=28roemeeeer=29?=
References: <157860451191.3344.46185682085252095.malonedeb@soybean.canonical.com>
Message-Id: <157867324297.2574.14346765206516276344.malone@soybean.canonical.com>
Subject: [Bug 1859081] Re: Mouse way too fast when Qemu is on a Windows VM
 with a OS 9 Guest
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: dbedb89675abde17375490c22b1d07972be45d5c
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
Reply-To: Bug 1859081 <1859081@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The command line I currently use is:

".\qemu-4.2.0-win64\qemu-system-ppc.exe" -L pc-bios -boot c -M mac99,via=3D=
pmu -m 512 ^
-prom-env "auto-boot?=3Dtrue" -prom-env "boot-args=3D-v" -prom-env "vga-ndr=
v?=3Dtrue" ^
-drive file=3Dc:\qemu\MacOS9.2.img,format=3Draw,media=3Ddisk ^
-drive file=3Dc:\qemu\MacOS9.2.2_Universal_Install.iso,format=3Draw,media=
=3Dcdrom ^
-sdl ^
-netdev user,id=3Dnetwork01 -device sungem,netdev=3Dnetwork01 ^
-device VGA,edid=3Don

I also tried by adding "-device usb-mouse" but it does not make any differe=
nce.
I now tried with 4.2.0 from omledom (yesterday with 4.1.0 from weilnetz.
There is no difference in 4.1.0 and 4.2.0 with or without the usb-mouse.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859081

Title:
  Mouse way too fast when Qemu is on a Windows VM with a OS 9 Guest

Status in QEMU:
  New

Bug description:
  On a server, I have a Windows 10 VM with Qemu 4.1.0 (latest) from https:/=
/qemu.weilnetz.de/w64/ installed.
  There I have a Mac OS 9.2.2 machine.
  Now if I connect to the Windows VM with VNC or RDP or even VMWare console=
, the Mouse in the Mac OS Guest inside Qemu is waaaay to fast. Even when lo=
wering the mouse speed in the Mac OS mouse setting, one pixel in the Host (=
Windows 10 VM) still moves the mouse by 10 pixels inside the Qemu machine.
  I tried different resolutions but that does not help.
  Is there any way to fix this or any way how I can provide more informatio=
n?
  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1859081/+subscriptions

