Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4906AC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C80C2184E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C80C2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57978 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUE7f-0004fw-Dp
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 13:36:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hUE5h-0002rB-Jp
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hUE5g-0008SE-Jq
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:34:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:57596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hUE5g-0008R5-EP
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:34:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hUE5f-0004Wc-4p
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 17:34:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 16EF32E8083
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 17:34:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 May 2019 17:21:45 -0000
From: Thomas Huth <1586229@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: frazzledjazz th-huth
X-Launchpad-Bug-Reporter: rjasmin (frazzledjazz)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20160527022808.17624.11582.malonedeb@soybean.canonical.com>
Message-Id: <155871850699.8234.11507608342612221479.launchpad@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 58701d28c4d8e51b89968b13908b0d00a58df8f0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1586229] Re: seabios hell
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1586229 <1586229@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1586229

Title:
  seabios hell

Status in QEMU:
  Invalid

Bug description:
  getting weird annoying seabios hell and not sure how to fix it.

  ok.

  there IS a SEA-BIOS. There IS a way in.

  -I found it by mistake.(and yall need to move the BIOS key...its in
  the wrong place)

  I was tryng to boot Yosemite to re-install. I mashed the key too early
  and it wanted to boot the hard drive.

  Apparently the bios loads AFTER the hard drive wants to boot, not
  BEFORE it.And it will ONLY load when booting a hard disk.

  ..Booting hard disk...[mash F8 here but let go and wait]
  eventually will want to load the OS and clear the screen[mash F8 again]

  --Youre in!

  Its tiny, like a mini award bios but youre in! =

  -Change anything HERE, though...and kiss booting a cd goodbye!

  Im trying to diagnose a black screen, seems related to seabios, not
  the vga driver.

  -mayhaps wants to boot hard disk but in fact its not bootable as the
  installer hung(and often unices install bootloader late in process)?

  I cant boot the disc to reinstall to tell. But I have a few dos iso
  lying around...hmmm.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1586229/+subscriptions

