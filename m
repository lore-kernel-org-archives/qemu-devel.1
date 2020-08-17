Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB425C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 01:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D44C2075D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 01:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D44C2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7U9P-0004Go-Pe
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 21:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k7U8r-0003qK-1y
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 21:40:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:47992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k7U8o-0006kE-U4
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 21:40:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k7U8n-0008Fp-96
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:40:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3B8EA2E80DB
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:40:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2020 01:32:53 -0000
From: Michael Slade <1891830@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: msmouse
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mslade
X-Launchpad-Bug-Reporter: Michael Slade (mslade)
X-Launchpad-Bug-Modifier: Michael Slade (mslade)
Message-Id: <159762797324.26708.16374390576065274837.malonedeb@soybean.canonical.com>
Subject: [Bug 1891830] [NEW] msmouse serial mouse emulation broken? No id byte
 sent on reset
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d6d0b96812d8def2ca0ffcc25cb4d200f2f30aeb";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1bb20d308d4329f3fa6dea37479d6274bcf85749
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/16 20:00:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1891830 <1891830@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I took a shot at getting Windows 1.01 working.  It doesn't support a
PS/2 mouse out-of-the-box but does support MS serial mice.  It doesn't
seem to detect qemu's emulated msmouse.

When I run this command:

> qemu-system-i386 -nodefaults -hda my_windows1_hd.qcow2 -vga std
-serial msmouse -trace enable=3D'serial*'  -icount shift=3D10,align=3Don

I get this output (edited):

251908@1597626456.800452:serial_ioport_write write addr 0x04 val 0x01
251908@1597626456.800460:serial_ioport_read read addr 0x00 val 0x00
251908@1597626456.800462:serial_ioport_read read addr 0x00 val 0x00

[snip]

251908@1597626456.961641:serial_ioport_read read addr 0x00 val 0x00
251908@1597626456.961642:serial_ioport_read read addr 0x00 val 0x00
251908@1597626456.961644:serial_ioport_read read addr 0x00 val 0x00
251908@1597626456.961647:serial_ioport_write write addr 0x04 val 0x0b
251908@1597626456.961648:serial_ioport_read read addr 0x05 val 0x60
251908@1597626456.961684:serial_ioport_read read addr 0x05 val 0x60
251908@1597626456.961685:serial_ioport_read read addr 0x05 val 0x60

[snip]

251908@1597626457.045894:serial_ioport_read read addr 0x05 val 0x60
251908@1597626457.045895:serial_ioport_read read addr 0x05 val 0x60
251908@1597626457.045897:serial_ioport_read read addr 0x05 val 0x60
251908@1597626457.045932:serial_ioport_read read addr 0x00 val 0x00

The write of 0x01 and then 0x0b to reg 0x04 is the guest turning the RTS
line off then on.  A real mouse will respond to this by sending 0x4d,
which is how the guest detects the mouse.

Reproducible in current stable-4.2 and 5.0 (debian's build).  I am able
to get the guest to use a real passed-through serial mouse (with a minor
hack, separate bug filed for this)

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: msmouse

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1891830

Title:
  msmouse serial mouse emulation broken? No id byte sent on reset

Status in QEMU:
  New

Bug description:
  I took a shot at getting Windows 1.01 working.  It doesn't support a
  PS/2 mouse out-of-the-box but does support MS serial mice.  It doesn't
  seem to detect qemu's emulated msmouse.

  When I run this command:

  > qemu-system-i386 -nodefaults -hda my_windows1_hd.qcow2 -vga std
  -serial msmouse -trace enable=3D'serial*'  -icount shift=3D10,align=3Don

  I get this output (edited):

  251908@1597626456.800452:serial_ioport_write write addr 0x04 val 0x01
  251908@1597626456.800460:serial_ioport_read read addr 0x00 val 0x00
  251908@1597626456.800462:serial_ioport_read read addr 0x00 val 0x00

  [snip]

  251908@1597626456.961641:serial_ioport_read read addr 0x00 val 0x00
  251908@1597626456.961642:serial_ioport_read read addr 0x00 val 0x00
  251908@1597626456.961644:serial_ioport_read read addr 0x00 val 0x00
  251908@1597626456.961647:serial_ioport_write write addr 0x04 val 0x0b
  251908@1597626456.961648:serial_ioport_read read addr 0x05 val 0x60
  251908@1597626456.961684:serial_ioport_read read addr 0x05 val 0x60
  251908@1597626456.961685:serial_ioport_read read addr 0x05 val 0x60

  [snip]

  251908@1597626457.045894:serial_ioport_read read addr 0x05 val 0x60
  251908@1597626457.045895:serial_ioport_read read addr 0x05 val 0x60
  251908@1597626457.045897:serial_ioport_read read addr 0x05 val 0x60
  251908@1597626457.045932:serial_ioport_read read addr 0x00 val 0x00

  The write of 0x01 and then 0x0b to reg 0x04 is the guest turning the
  RTS line off then on.  A real mouse will respond to this by sending
  0x4d, which is how the guest detects the mouse.

  Reproducible in current stable-4.2 and 5.0 (debian's build).  I am
  able to get the guest to use a real passed-through serial mouse (with
  a minor hack, separate bug filed for this)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1891830/+subscriptions

