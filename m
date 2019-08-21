Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766D5C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB1A233A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB1A233A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0R6X-0001gz-91
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 09:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i0R5T-0000Jg-4k
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i0R5R-0001DR-QW
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:55:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:59312)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i0R5R-0001Ce-Ky
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:55:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i0R5P-0000Y3-HM
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 13:55:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7AD1A2E80CF
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 13:55:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Aug 2019 13:48:00 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1819289@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cbparker curryrice71 dgilbert-h philmd pmaydell
X-Launchpad-Bug-Reporter: John M (curryrice71)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <155216177409.9624.16357609956497374456.malonedeb@gac.canonical.com>
Message-Id: <156639528052.27151.8641350033638469136.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: d67ae4941da8f40d97c3ce1719d868859b17f4f4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1819289] Re: Windows 95 and Windows 98 will not
 install or run
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
Reply-To: Bug 1819289 <1819289@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> cd1bfd5ef336166b275a09dc9842542bf5e63ae3 is the first bad commit

Unfortunately this is a commit related to SeaBIOS submodule.
This commit only update the built BIOS roms.

The commits before this one are the ones modifying SeaBIOS, justifying
roms to be rebuilt:

eda553a442 seabios: enable ide dma
429d3ae2c8 seabios: update submodule to release 1.11.2

The first one (enable ide dma) is a change in the config.
You can rebuild the BIOS image and bisect around this commit.

You can rebuild the SeaBIOS image running this command in QEMU source
repository:

  $ make -C roms bios

This will update 'pc-bios/bios.bin' which you use while bisecting.

The second one update the SeaBIOS submodule from commit 0551a4be2c to
commit f9626ccb91.

These are not so many commits, so the bisect won't be painful:

$ git log --oneline 0551a4be2~..f9626ccb91
f9626cc (tag: rel-1.11.2) cbvga_set_mode: refine clear display logic
f88297a qemu: add qemu ramfb support
a2e4001 vgasrc: add allocate_pmm()
17b01f4 pmm: use tmp zone on oom
44b17d0 bochs_display_setup: return error on failure
4ba61fa cbvga_set_mode: disable clearmem in windows x86 emulator.
dd69189 cbvga_list_modes: don't list current mode twice
5f0e7c9 cbvga_setup_modes: use real mode number instead of 0x140
961f67c qemu: add bochs-display support
767365e cbvga: factor out cbvga_setup_modes()
7906460 optionrom: enable non-vga display devices
0551a4b (tag: rel-1.11.1) paravirt: Only enable sercon in NOGRAPHIC mode if=
 no other console specified

I recommend doing your bisection using 2 terminals:

- one in QEMU source, running 'make -C roms bios' to rebuild 'pc-
bios/bios.bin' and run QEMU installing your image,

- one in roms/seabios/ where you run the 'git bisect' commands.

Note, you don't have to rebuild QEMU.

Alternatively, using a single terminal, you can stand in the
roms/seabios/ directory, bisect and run 'make -C .. bios'. In this case
it might be useful to run QEMU with -L ../../pc-bios to specify the path
to the generated bios.bin.

You are close, good luck!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1819289

Title:
  Windows 95 and Windows 98 will not install or run

Status in QEMU:
  New

Bug description:
  The last version of QEMU I have been able to run Windows 95 or Windows
  98 on was 2.7 or 2.8. Recent versions since then even up to 3.1 will
  either not install or will not run 95 or 98 at all. I have tried every
  combination of options like isapc or no isapc, cpu pentium  or cpu as
  486. Tried different memory configurations, but they just don't work
  anymore.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1819289/+subscriptions

