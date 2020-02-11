Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33655C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0618520675
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0618520675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1X39-00031I-2N
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j1X23-0002FA-2M
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j1X21-00015x-R3
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:00:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:48068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j1X21-00015Y-Lp
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:00:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j1X1z-0002he-R1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 15:00:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7B6DB2E80C9
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 15:00:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Feb 2020 14:51:26 -0000
From: Thomas Huth <1649040@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: lpnow th-huth
X-Launchpad-Bug-Reporter: LPNow (lpnow)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20161211031531.25603.88090.malonedeb@gac.canonical.com>
Message-Id: <158143268669.14294.199510849996108788.malone@gac.canonical.com>
Subject: [Bug 1649040] Re: Ubuntu 16.04.1 Grub Splash Doesn't Appear
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ad849476e895ada6b886fc47fc35d0ad978acbba
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
Reply-To: Bug 1649040 <1649040@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Does this still happen with a newer version of Ubuntu and the latest
version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1649040

Title:
  Ubuntu 16.04.1 Grub Splash Doesn't Appear

Status in QEMU:
  Incomplete

Bug description:
  My Specs:

  Slackware 14.2 x86_64 > Host
  QEMU 2.7.0

  Ubuntu 16.04.1 x86_64 > Guest

  Start options for Ubuntu:

  qemu-system-x86_64 -drive format=3Draw,file=3Dubuntu.img \
  -cpu host \
  --enable-kvm \
  -smp 2 \
  -m 4096 \
  -vga vmware \
  -soundhw ac97 \
  -usbdevice tablet \
  -rtc base=3Dlocaltime \
  -usbdevice host:0781:5575

  I've started Ubuntu around 6-8 times, and I have only see the Grub
  Boot Splash appear twice, so pretty much without fail it typically
  boots past the grub splash and automatically boots...

  These are the /etc/default/grub settings; (I only changed these
  options GRUB_TIMEOUT=3D15 and GRUB_GFXMODE=3D1440x900)

  # If you change this file, run 'update-grub' afterwards to update
  # /boot/grub/grub.cfg.
  # For full documentation of the options in this file, see:
  #   info -f grub -n 'Simple configuration'

  GRUB_DEFAULT=3D0
  GRUB_HIDDEN_TIMEOUT=3D0
  GRUB_HIDDEN_TIMEOUT_QUIET=3Dtrue
  GRUB_TIMEOUT=3D15
  GRUB_DISTRIBUTOR=3D`lsb_release -i -s 2> /dev/null || echo Debian`
  GRUB_CMDLINE_LINUX_DEFAULT=3D"quiet splash"
  GRUB_CMDLINE_LINUX=3D""

  # Uncomment to enable BadRAM filtering, modify to suit your needs
  # This works with Linux (no patch required) and with any kernel that obta=
ins
  # the memory map information from GRUB (GNU Mach, kernel of FreeBSD ...)
  #GRUB_BADRAM=3D"0x01234567,0xfefefefe,0x89abcdef,0xefefefef"

  # Uncomment to disable graphical terminal (grub-pc only)
  #GRUB_TERMINAL=3Dconsole

  # The resolution used on graphical terminal
  # note that you can use only modes which your graphic card supports via V=
BE
  # you can see them in real GRUB with the command `vbeinfo'
  GRUB_GFXMODE=3D1440x900

  # Uncomment if you don't want GRUB to pass "root=3DUUID=3Dxxx" parameter =
to Linux
  #GRUB_DISABLE_LINUX_UUID=3Dtrue

  # Uncomment to disable generation of recovery mode menu entries
  #GRUB_DISABLE_RECOVERY=3D"true"

  # Uncomment to get a beep at grub start
  #GRUB_INIT_TUNE=3D"480 440 1"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1649040/+subscriptions

