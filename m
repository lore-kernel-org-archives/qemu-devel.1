Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC2CC2BBFD
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 12:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549C420692
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 12:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549C420692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNFDW-0001xP-Dw
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 08:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jNFCv-0001Y8-LB
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 08:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jNFCt-0004rm-OT
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 08:25:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:42294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jNFCt-0004ra-6p
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 08:25:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jNFCq-0007ip-Mr
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 12:25:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AAE792E8107
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 12:25:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2020 12:18:58 -0000
From: Thomas Huth <1863441@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Won't Fix; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fysnet jnsnow
X-Launchpad-Bug-Reporter: Benjamin David Lunt (fysnet)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <158179973601.15520.14709037359293558924.malonedeb@soybean.canonical.com>
Message-Id: <158660753979.28111.9893565524056330200.launchpad@gac.canonical.com>
Subject: [Bug 1863441] Re: cmd_mode_sense always reports 0x70, no CDROM present
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a1617dae2d8e7b427829f215f129fac9e8205f9f
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
Reply-To: Bug 1863441 <1863441@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863441

Title:
  cmd_mode_sense always reports 0x70, no CDROM present

Status in QEMU:
  Won't Fix

Bug description:
  cmd_mode_sense
    https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/ide/atapi.c;hb=3Dref=
s/heads/master#l852
  always reports 0x70 in byte 2 returned, indicating no CD-ROM present.

  If CD-ROM is present, should report 0x01 (or 0x11).
  If CD-ROM absent, should report 0x70.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863441/+subscriptions

