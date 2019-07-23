Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C30AC76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 16:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9F2223BA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 16:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9F2223BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpxY1-0004ib-MI
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 12:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59931)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hpxXq-0004KC-SH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hpxXp-0005X5-Kw
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:21:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:58178)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hpxXp-0005UI-Dw
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:21:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hpxXn-0000CG-SL
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 16:21:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AABC12E80CC
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 16:21:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jul 2019 16:13:02 -0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: sparc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: atar4qemu lentilwallop mark-cave-ayland
 michal-nowak-b
X-Launchpad-Bug-Reporter: Michal Nowak (michal-nowak-b)
X-Launchpad-Bug-Modifier: Mark Cave-Ayland (mark-cave-ayland)
References: <20170305181803.7371.53021.malonedeb@chaenomeles.canonical.com>
Message-Id: <156389838208.8493.14286293039125124489.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 0c334af1147ecfee3d20a53c8bf22f3acf07a99b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1670170] Re: `qemu-system-sparc64 -M Niagara`
 Aborted (core dumped)
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
Reply-To: Bug 1670170 <1670170@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's difficult to tell as you haven't posted your complete command line,
however it looks as if you're missing the path to the rom images:

https://qemu.weilnetz.de/doc/qemu-doc.html#Sparc64-System-emulator
https://wiki.qemu.org/Documentation/Platforms/SPARC#Compatibility


ATB,

Mark.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1670170

Title:
  `qemu-system-sparc64 -M Niagara` Aborted (core dumped)

Status in QEMU:
  Fix Released

Bug description:
  > qemu-system-sparc64 -M Niagara
  qemu: fatal: Trap 0x0064 while trap level (6) >=3D MAXTL (6), Error state
  pc: 0000000000004c80  npc: 0000000000004c84
  %g0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %g4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %o0-3: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0 =

  %o4-7: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0 =

  %l0-3: 0000000007f00000 000001ff00000000 000001fff0080000 000000000000000=
0 =

  %l4-7: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0 =

  %i0-3: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0 =

  %i4-7: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0 =

  %f00:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f08:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f16:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f24:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f32:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f40:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f48:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f56:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  pstate: 00000414 ccr: 44 (icc: -Z-- xcc: -Z--) asi: 00 tl: 6 pil: 0
  cansave: 6 canrestore: 0 otherwin: 0 wstate: 0 cleanwin: 6 cwp: 7
  fsr: 0000000000000000 y: 0000000000000000 fprs: 0000000000000000

  Aborted (core dumped)

  > qemu-system-sparc64 -M help
  Supported machines are:
  Niagara              Sun4v platform, Niagara
  none                 empty machine
  sun4u                Sun4u platform (default)
  sun4v                Sun4v platform

  > qemu-system-sparc64 -version
  QEMU emulator version 2.8.0(Virtualization:Staging / SLE_12_SP2)

  from
  https://build.opensuse.org/package/show/Virtualization:Staging/qemu on
  openSUSE Leap 42.2.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1670170/+subscriptions

