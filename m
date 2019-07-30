Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33436C41514
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 10:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6902089E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 10:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6902089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsPUT-0005gw-8M
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 06:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43928)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hsPTm-0004VF-Mj
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 06:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hsPTl-0007nN-Kl
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 06:35:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:56288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hsPTl-0007mq-FJ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 06:35:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hsPTj-00050C-5w
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 10:35:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 294012E80D6
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 10:35:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jul 2019 10:26:58 -0000
From: James Smart <1838390@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: hvf macos
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: smartrejames
X-Launchpad-Bug-Reporter: James Smart (smartrejames)
X-Launchpad-Bug-Modifier: James Smart (smartrejames)
Message-Id: <156448241864.18390.18158373201974266058.malonedeb@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 6862c9b1c9b3a0c28e09c138c0380d8d2a77a954
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1838390] [NEW] vmx_write_mem: mmu_gva_to_gpa
 failed when using hvf
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
Reply-To: Bug 1838390 <1838390@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Installed qemu 4.0.0 by homebrew, used below commands:

1. qemu-img create -f raw arch-vm.img 100G
2. qemu-system-x86_64 -show-cursor -only-migratable -nodefaults -boot order=
=3Dd -cdrom archlinux-2019.07.01-x86_64.iso -cpu host -device virtio-keyboa=
rd -device virtio-mouse -device virtio-tablet -drive file=3Darch-vm.img,for=
mat=3Draw,if=3Dvirtio -m 4096 -machine q35,accel=3Dhvf,vmport=3Doff -nic us=
er,ipv6=3Doff,model=3Dvirtio -smp 4,sockets=3D1,cores=3D2,threads=3D2 -soun=
dhw hda -vga virtio

Displayed bootloader menu successfully, select "Boot Arch Linux" then
crashed with message: vmx_write_mem: mmu_gva_to_gpa ffff91953b540000
failed.

Use tcg accelerator has no problem but very slow.

See attachment for full crash report.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: hvf macos

** Attachment added: "Untitled-1"
   https://bugs.launchpad.net/bugs/1838390/+attachment/5280003/+files/Untit=
led-1

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1838390

Title:
  vmx_write_mem: mmu_gva_to_gpa failed when using hvf

Status in QEMU:
  New

Bug description:
  Installed qemu 4.0.0 by homebrew, used below commands:

  1. qemu-img create -f raw arch-vm.img 100G
  2. qemu-system-x86_64 -show-cursor -only-migratable -nodefaults -boot ord=
er=3Dd -cdrom archlinux-2019.07.01-x86_64.iso -cpu host -device virtio-keyb=
oard -device virtio-mouse -device virtio-tablet -drive file=3Darch-vm.img,f=
ormat=3Draw,if=3Dvirtio -m 4096 -machine q35,accel=3Dhvf,vmport=3Doff -nic =
user,ipv6=3Doff,model=3Dvirtio -smp 4,sockets=3D1,cores=3D2,threads=3D2 -so=
undhw hda -vga virtio

  Displayed bootloader menu successfully, select "Boot Arch Linux" then
  crashed with message: vmx_write_mem: mmu_gva_to_gpa ffff91953b540000
  failed.

  Use tcg accelerator has no problem but very slow.

  See attachment for full crash report.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1838390/+subscriptions

