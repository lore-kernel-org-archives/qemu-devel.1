Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBBBC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49A9206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49A9206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rkmorris.us
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53515 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbLT-0006M7-SH
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jMbKG-0005He-IJ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jMbKF-00042N-GI
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:50:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:54122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jMbKF-00041m-Aw
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:50:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jMbKD-00010A-L3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 17:50:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8C90E2E8109
 for <qemu-devel@nongnu.org>; Thu,  9 Apr 2020 17:50:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Apr 2020 17:41:10 -0000
From: Russell Morris <ubuntu@rkmorris.us>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: whpx
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 6-u3untu-h ajbennee eminus
X-Launchpad-Bug-Reporter: Emin Ghuliev (eminus)
X-Launchpad-Bug-Modifier: Russell Morris (6-u3untu-h)
References: <155352235092.32006.12315829232895734213.malonedeb@soybean.canonical.com>
Message-Id: <158645407061.28209.16582830963465746573.malone@gac.canonical.com>
Subject: [Bug 1821595] Re: Failed to emulate MMIO access with
 EmulatorReturnStatus: 2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: dbc1a3275d52a2799b78484f728ea2fa3fa65b73
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
Reply-To: Bug 1821595 <1821595@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I tried backing up ... nothing but startup and UEFI (i.e. no OS, just
get to the EFI Shell). Can't even get there ... does that make sense?

Thanks!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1821595

Title:
  Failed to emulate MMIO access with EmulatorReturnStatus: 2

Status in QEMU:
  New

Bug description:
  I have compiled qemu with enable-whpx parameter for Hyper-V Platform API =
in Mingw64 . When I tried run with Windows 7 iso file I have faced issue wi=
th the following problem: =

  qemu-system-x86_64.exe: WHPX: Failed to emulate MMIO access with Emulator=
ReturnStatus: 2
  qemu-system-x86_64.exe: WHPX: Failed to exec a virtual processor

  =

  configuration directives:

  ../configure --target-list=3Dx86_64-softmmu,i386-softmmu --enable-lzo\
   --enable-bzip2 --enable-tools --enable-sdl --enable-gtk --enable-hax\
   --enable-vdi --enable-qcow1 --enable-whpx --disable-capstone\
   --disable-werror --disable-stack-protector --prefix=3D"../../QEMU-bin"

  =

  Qemu command line:
  qemu-system-x86_64.exe -m 1024 -cdrom "C:\Users\vmcs\Documents\en_windows=
_7_home_premium_with_sp1_x86_dvd_u_676701.iso" -display sdl -machine q35 -a=
ccel whpx

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1821595/+subscriptions

