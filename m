Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=FORGED_HOTMAIL_RCVD2,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC142C76194
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B87AE20823
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87AE20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpvJ9-0004cK-Kg
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 09:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39385)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hpsE2-0001j3-TG
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hpsE1-0003TQ-LG
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:40:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:48934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hpsE1-0003Ss-CA
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:40:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hpsE0-0000It-8K
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 10:40:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3D8972E80C7
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 10:40:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jul 2019 10:30:49 -0000
From: "lentilwallop@hotmail.com" <lentilwallop@hotmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: sparc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: atar4qemu lentilwallop michal-nowak-b
X-Launchpad-Bug-Reporter: Michal Nowak (michal-nowak-b)
X-Launchpad-Bug-Modifier: lentilwallop@hotmail.com (lentilwallop)
References: <20170305181803.7371.53021.malonedeb@chaenomeles.canonical.com>
Message-Id: <156387784923.30009.27491983100646267.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 5d6cec54d48527486f699633687be9ac4433934d
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Tue, 23 Jul 2019 09:58:03 -0400
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

S10image directory in this archive holds the rom images in case anyone
is looking....

http://download.oracle.com/technetwork/systems/opensparc/OpenSPARCT1_Arch.1=
.5.tar.bz2

not that it really helps for qemu-4.1.0-rc1

moo-PowerEdge-R710 qemu-4.1.0-rc1 # qemu-system-sparc64 -machine niagara
qemu: fatal: Trap 0x0032 while trap level (6) >=3D MAXTL (6), Error state

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

