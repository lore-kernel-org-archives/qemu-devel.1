Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255C0C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9EF20A8B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9EF20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSwD-0007oN-6X
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45948 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jQSvP-000763-KS
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:41:11 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jQSvN-00022F-Q3
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:41:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:49680)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jQSvN-0001zv-B9
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:41:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jQSvI-000871-Dg
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 09:41:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 669752E8110
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 09:41:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2020 09:28:13 -0000
From: =?utf-8?q?Marko_=C5=A0tamcar?= <1873769@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: markostamcar
X-Launchpad-Bug-Reporter: =?utf-8?q?Marko_=C5=A0tamcar_=28markostamcar=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Marko_=C5=A0tamcar_=28markostamcar=29?=
Message-Id: <158737489336.27883.11672421823937229418.malonedeb@gac.canonical.com>
Subject: [Bug 1873769] [NEW] SB16 audio playback freezes emulation in Windows
 95 guest
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 7141e5918b7a463b406fb593ba1b01bd106479ea
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 05:41:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1873769 <1873769@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

- QEMU 4.2.93 (v5.0.0-rc3) built from latest git master
20038cd7a8412feeb49c01f6ede89e36c8995472 using MSYS2 on Windows 10 and
launched on same Windows 10

- Launched using "qemu-system-i386.exe -drive format=3Draw,file=3Dhdd-
2gb.img -soundhw pcspk,sb16 -m 16 -cpu pentium -vga std -cdrom
Windows_95.iso -boot c"

- I have attached video screen capture of the issue

---

I decided to make my first ever QEMU build after encountering the dsound
issues using the latest 4.2.0 binary from https://qemu.weilnetz.de/w64/.
In my 5.0.0-rc3 build the sound playback is working correctly, however
the whole Windows 95 UI freezes while sound is playing.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "Video screen capture of the issue"
   https://bugs.launchpad.net/bugs/1873769/+attachment/5357082/+files/win95=
audio.mp4

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

