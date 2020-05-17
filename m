Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B8DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 00:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2D22081A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 00:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2D22081A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaTQQ-0005oV-Ed
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 20:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jaTC7-00023i-TY
 for qemu-devel@nongnu.org; Sun, 17 May 2020 19:59:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:35742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jaTBy-00028A-PV
 for qemu-devel@nongnu.org; Sun, 17 May 2020 19:59:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jaTBt-00025L-Pt
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 23:59:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AFB092E80E7
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 23:59:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2020 23:45:36 -0000
From: Amaro Jr <1295587@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: sb16
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alvarezviu aslopes crobinso dennis123321
 milasudril volitank
X-Launchpad-Bug-Reporter: alvarez (alvarezviu)
X-Launchpad-Bug-Modifier: Amaro Jr (aslopes)
References: <20140321093246.9788.71300.malonedeb@soybean.canonical.com>
Message-Id: <158975913673.23472.17511573539682548486.malone@gac.canonical.com>
Subject: [Bug 1295587] Re: Temporal freeze and slowdown while using emulated
 sb16
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0385b538081bc4718df6fb844a3afc89729c94ce";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 9b5a547b8cf754730e67180d256d2f637d4b5425
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 19:59:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1295587 <1295587@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After banging my head in a wall for tree or four days, I got the ac97 to
work on windows 98se applying something called "Auto-patcher for windows
98se" downloaded from retrosystemsrevival, then using the windows 95
"VXD_A406" driver updated manually by unpacking the executable and
picking the .inf file manually. The auto-patcher is mandatory to get
everything working. I followed steps from a youtube video for creating a
windows 98 VM in Virtualbox, worked on qemu. The installation process
was long and boring, but in the end, everything seems to be working
without problems (so far). All links can be found in a youtube video by
the name "Windows 98 on VirualBox Part 2. AutoPatching, AC97 Sound
Drivers, Windows 98 Plus! Gamepad Install." or in the following
pastebin: https://pastebin.com/hMvcMzFL

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1295587

Title:
  Temporal freeze and slowdown while using emulated sb16

Status in QEMU:
  New

Bug description:
  I have been carrying around this bug since previous versions and on
  different machines: When I use the -soundhw sb16 option, while playing
  any sound on the virtual machine it temporally freezes the emulated
  machine and loops the last bit of such sound effect for 1-2 minutes,
  then goes back to normal speed (until a new sound is played).

  Console shows:

  =C2=A0sb16: warning: command 0xf9,1 is not truly understood yet
  =C2=A0sb16: warning: command 0xf9,1 is not truly understood yet
  (...)
  main-loop: WARNING: I/O thread spun for 1000 iterations

  -One of my emulated machines is Windows 3.11: I managed to overrun
  this bug by switching from the local 1.5 version of the sound blaster
  driver to the 1.0, although since I updated qemu it freezes that
  machine, so I can't test if it still works.

  I am using the 1.7.90 version, but I suffered this bug for over one
  year (confirmed in version 2.0.0-rc0 too)

  this bug happens anytime I use the -soundhw sb16 switch, but the full
  command I am using in this specific case is:

  qemu-system-i386 -localtime -cpu pentium -m 32 -display sdl -vga
  cirrus -hda c.img -cdrom win95stuff.iso -net nic,model=3Dne2k_pci -net
  user -soundhw sb16

  This bug appears on all my machines: Pentium III running Slackware
  13.0 and freeBSD 10; Dual core T2400, both in Arch, Gentoo and
  Slackware 14.1 (all 32 bits), and a Dual core T4400 64 bits with
  Gentoo and Slackware. Same problem in all of those systems after
  compiling instead of using the distro packages....

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1295587/+subscriptions

