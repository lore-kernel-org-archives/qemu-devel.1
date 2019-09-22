Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2732C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 21:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBDA720830
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 21:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDA720830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iC9Sd-0002y0-5K
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 17:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iC9RL-0002VA-O5
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 17:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iC9RK-00063l-EX
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 17:30:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:51600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iC9RK-000635-8p
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 17:30:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iC9RI-0004Ti-Hv
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2019 21:30:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 85F4F2E80C7
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2019 21:30:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Sep 2019 21:21:21 -0000
From: Adam Strzelecki <1844946@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: nanoant
X-Launchpad-Bug-Reporter: Adam Strzelecki (nanoant)
X-Launchpad-Bug-Modifier: Adam Strzelecki (nanoant)
Message-Id: <156918728216.32759.756692081712593785.malonedeb@wampee.canonical.com>
Subject: [Bug 1844946] [NEW] macOS HVF broken with WinXP after Aug 21 2018
 92d5f1a414
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 3d2860324f91c216cdb2adbef9cd1eef8f7e5271
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
Reply-To: Bug 1844946 <1844946@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I use macOS with own built Qemu to run old XP system that I have migrated f=
rom physical machine. My setup is very simple qemu-system-x86_64 with args:
-machine pc,accel=3Dhvf,usb=3Doff,vmport=3Doff
-cpu host
-vga std
-m 2048
-drive file=3D"$img",format=3Dqcow2,cache=3Dnone,detect-zeroes=3Don
-usb -device usb-tablet

Unfortunately as soon I enable HVF with first 2 lines WinXP SP3 hangs on
boot (famous mup.sys). It works fine in TCG.

I dived into the code checking the differences between HVF, KVM and HAXM
and my analysis is:

1. Sergio Andres Gomez Del Real b7394c8394 - replaces explicit
VMCS_GUEST_INTERRUPTIBILITY checks with hflags/hflags2.

2. Paolo Bonzini 92d5f1a414 - changes hflags/hflags2 behavior which
breaks in the end HVF interrupt handling and makes WinXP unable to boot.
NOTE: This does not break I believe KVM and HAXM as they still do
explicit check instead what HVF does in 1. That's why it was probably
not reported and Qemu macOS users are rather niche ;)

Reverting 92d5f1a414 makes WinXP boot well and work flawlessly.
Unfortunately b7394c8394 is not easy anymore as too many changes on the way=
, so it may be not an option.

This can be reproduced simply by installing /Users/ono/VM/ISO/en_windows_xp=
_professional_with_service_pack_3_x86_cd_vl_x14-73974.iso
with HAL as "Standard PC" selectable with F5 on first run.

I can also provide fresh ~600MB qcow2 image (without activation key
entered yet) that is created before boot that fails. No need for full XP
installation to test that.

Nevertheless I would really appreciate Paolo looking into this.
Many thanks for great software,
Adam

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1844946

Title:
  macOS HVF broken with WinXP after Aug 21 2018 92d5f1a414

Status in QEMU:
  New

Bug description:
  I use macOS with own built Qemu to run old XP system that I have migrated=
 from physical machine. My setup is very simple qemu-system-x86_64 with arg=
s:
  -machine pc,accel=3Dhvf,usb=3Doff,vmport=3Doff
  -cpu host
  -vga std
  -m 2048
  -drive file=3D"$img",format=3Dqcow2,cache=3Dnone,detect-zeroes=3Don
  -usb -device usb-tablet

  Unfortunately as soon I enable HVF with first 2 lines WinXP SP3 hangs
  on boot (famous mup.sys). It works fine in TCG.

  I dived into the code checking the differences between HVF, KVM and
  HAXM and my analysis is:

  1. Sergio Andres Gomez Del Real b7394c8394 - replaces explicit
  VMCS_GUEST_INTERRUPTIBILITY checks with hflags/hflags2.

  2. Paolo Bonzini 92d5f1a414 - changes hflags/hflags2 behavior which
  breaks in the end HVF interrupt handling and makes WinXP unable to
  boot. NOTE: This does not break I believe KVM and HAXM as they still
  do explicit check instead what HVF does in 1. That's why it was
  probably not reported and Qemu macOS users are rather niche ;)

  Reverting 92d5f1a414 makes WinXP boot well and work flawlessly.
  Unfortunately b7394c8394 is not easy anymore as too many changes on the w=
ay, so it may be not an option.

  This can be reproduced simply by installing /Users/ono/VM/ISO/en_windows_=
xp_professional_with_service_pack_3_x86_cd_vl_x14-73974.iso
  with HAL as "Standard PC" selectable with F5 on first run.

  I can also provide fresh ~600MB qcow2 image (without activation key
  entered yet) that is created before boot that fails. No need for full
  XP installation to test that.

  Nevertheless I would really appreciate Paolo looking into this.
  Many thanks for great software,
  Adam

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1844946/+subscriptions

