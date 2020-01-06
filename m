Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22BAC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 23:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7756B2072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 23:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7756B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iobnc-0001y5-9w
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 18:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ioY9z-000350-7V
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ioY9x-0000kZ-VE
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:35:31 -0500
Received: from indium.canonical.com ([91.189.90.7]:45562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ioY9x-0000jh-PQ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:35:29 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ioY9w-0004QT-Ra
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 19:35:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CF5B52E80C3
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 19:35:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jan 2020 19:26:48 -0000
From: David Miller <zezuspam@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: audio dos games gus sb16 timed timer
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: zezuspam
X-Launchpad-Bug-Reporter: David Miller (zezuspam)
X-Launchpad-Bug-Modifier: David Miller (zezuspam)
References: <157833854539.28173.10729724748625497755.malonedeb@chaenomeles.canonical.com>
Message-Id: <157833880848.3062.6630996346887021056.malone@soybean.canonical.com>
Subject: [Bug 1858488] Re: qemu git && 4.2:  timed audio issues with sb16,
 gus not working?
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4059a55347c6390ff9cc4c74fecaa9a598f4c4c5
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Mon, 06 Jan 2020 18:26:20 -0500
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

./qemu is a symlink to qemu/build/i386-softmmu/qemu-system-i386

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1858488

Title:
  qemu git && 4.2:  timed audio issues with sb16,  gus not working?

Status in QEMU:
  New

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

