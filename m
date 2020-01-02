Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DC0C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF3420848
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF3420848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in2l5-0003tx-8E
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 10:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1in2kS-0003Ra-0Q
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1in2kQ-0003hb-MM
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:50:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:59404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1in2kQ-0003g7-GF
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:50:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1in2kM-0007Fe-ST
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 15:50:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1FAE02E80D8
 for <qemu-devel@nongnu.org>; Thu,  2 Jan 2020 15:50:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jan 2020 15:40:52 -0000
From: Ryan Lahfa <1858046@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: raito-bezarius
X-Launchpad-Bug-Reporter: Ryan Lahfa (raito-bezarius)
X-Launchpad-Bug-Modifier: Ryan Lahfa (raito-bezarius)
References: <157791695959.3198.15546015289430538780.malonedeb@soybean.canonical.com>
Message-Id: <157797965247.15306.10849745436618286359.malone@wampee.canonical.com>
Subject: [Bug 1858046] Re: qemu-aarch64 hangs on cptofs during a build of
 NixOS SD card image
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ab99de121745fc0380f71638bdf730d452246df0
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
Reply-To: Bug 1858046 <1858046@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update: compiling qemu upstream & using the latest version didn't change
anything.


I don't know if this is an instance of user emulation limitations due to mi=
ssing syscalls.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1858046

Title:
  qemu-aarch64 hangs on cptofs during a build of NixOS SD card image

Status in QEMU:
  New

Bug description:
  First, thank you for this incredible project.

  While following this guide to build my own image of NixOS:
  https://nixos.wiki/wiki/NixOS_on_ARM#Compiling_through_QEMU on ARM
  Aarch64.

  I encountered a very strange behavior, qemu is correctly used and
  build most of the binaries until it executes this exact line over
  qemu: https://github.com/NixOS/nixpkgs/blob/master/nixos/lib/make-
  ext4-fs.nix#L55

  At this step, the qemu process goes to 100 % of CPU, hangs in a
  certain syscall I don't know which one (according to strace & gdb
  which has no symbols so breaking and looking the backtrace was
  useless).

  According to iotop, no I/O was done.

  And it spent all its time in this syscall during more than 10 hours,
  which looks anomalous to me.

  I attach some of my CPU info:

  model		: 142
  model name	: Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz
  stepping	: 10
  microcode	: 0x96
  cpu MHz		: 3107.071
  cache size	: 8192 KB

  I'm using a ThinkPad T480 to perform those builds, I'm uncertain of
  how to debug further this issue, I discussed this with some people
  over #nixos-aarch64 and they told me they didn't know how to debug it
  further too.

  I tried all with this package: https://aur.archlinux.org/packages
  /qemu-arm-static/ =E2=80=94=C2=A0I'm currently compiling qemu-git to see =
if it
  happens on upstream too. Will comment when it's done.

  Thank you in advance!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1858046/+subscriptions

