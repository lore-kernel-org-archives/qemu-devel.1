Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EFCC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3052051A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3052051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbCE-0000Qz-Dn
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jBb9D-0003lZ-7e
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jBb99-0008Eo-V0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:25:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:41638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jBb99-0008Dm-Or
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:25:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jBb99-0005Bz-2F
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 09:25:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0FF812E8041
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 09:25:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Mar 2020 09:11:55 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: audio dos games gus sb16 timed timer
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: laurent-vivier zezuspam
X-Launchpad-Bug-Reporter: David Miller (zezuspam)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <157833854539.28173.10729724748625497755.malonedeb@chaenomeles.canonical.com>
Message-Id: <158383151578.6857.16954302324772620027.malone@chaenomeles.canonical.com>
Subject: [Bug 1858488] Re: qemu git && 4.2:  timed audio issues with sb16,
 gus not working?
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: f75d936df6ac3a029435225007bac69cbff9e55d
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
Reply-To: Bug 1858488 <1858488@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dfdc8c5f4717f

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1858488

Title:
  qemu git && 4.2:  timed audio issues with sb16,  gus not working?

Status in QEMU:
  Fix Committed

Bug description:
  =

  I have built [both] current git, and 4.2.0, there are issues with audio/s=
oundhw for both.

  Specifics:

  Linux nullrig 5.3.0-24-generic #26-Ubuntu SMP Thu Nov 14 01:33:18 UTC
  2019 x86_64 x86_64 x86_64 GNU/Linux

  Out of source build, successful for both:

  ../configure --prefix=3D/opt/qemu --target-list=3Di386-softmmu,mips64el-
  softmmu ---enable-sdl --enable-sdl-image --enable-lzo --enable-bzip2
  --enable-avx2 --enable-kvm --enable-membarrier --enable-plugin

  Call:

  ./qemu -machine pc,accel=3Dkvm,usb=3Doff -cpu pentium -m 64 -rtc
  base=3Dlocaltime -parallel none -soundhw sb16,adlib,pcspk -device
  cirrus-vga,bus=3Dpci.0 -drive
  id=3Ddisk1,file=3Ddoom.cow,format=3Dqcow2,if=3Dvirtio -audiodev pa,id=3Dpa

  Audio for sb16 sounds ok,  however if i switch to a timer based audio:
  -audiodev wav

  The output is wrong..  I had assumed it was all timer based audio,
  however it seems to be limited to sb16.

  So I then tried the next popular/compatible audio device for dos
  games:  gravis ultrasound [gus].

  I get no output at all for it.
  I have tried more than one piece of software,  DOOM shareware is any easy=
 example.

  I realize there are better solutions for playing DOS games, however I
  am interested in snapshot support which many of them lack.

  I am willing to put the work into fixing it myself if need be,
  however i'm not very familiar with the audio backend.   Specifically,
  it is already mixed into a single buffer,  if 'adlib' driver is
  already working: (audio_pcm_ops.write() output is correct on timer
  based output) I failed to see how it affects emulation of the sound
  blaster.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1858488/+subscriptions

