Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6C1C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B358721883
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B358721883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paradoxo.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5UkI-0000M8-OL
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 08:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i5SsK-0001vq-Li
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 06:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i5SsJ-0002zn-Bf
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 06:50:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:56778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i5SsI-0002vH-Hv
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 06:50:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i5SsE-0001W0-1x
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 10:50:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E6B7A2E80CB
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 10:50:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Sep 2019 10:37:18 -0000
From: Felipe Franciosi <felipe@paradoxo.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: hvf macos
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: felipe-1 smartrejames
X-Launchpad-Bug-Reporter: James Smart (smartrejames)
X-Launchpad-Bug-Modifier: Felipe Franciosi (felipe-1)
References: <156448241864.18390.18158373201974266058.malonedeb@gac.canonical.com>
Message-Id: <156759343837.17462.17652029820495872531.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d05713b9767cb1646b603417d5d44958a9e6f4ff
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Wed, 04 Sep 2019 08:47:47 -0400
Subject: [Qemu-devel] [Bug 1838390] Re: vmx_write_mem: mmu_gva_to_gpa failed
 when using hvf
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

Also happens to me on a freshly built Qemu master (tip 23919ddfd561).
MBP15,2 OSX 10.14.6

Qemu command line:
qemu/x86_64-softmmu/qemu-system-x86_64 -cpu host -accel hvf -m 4G -smp 8 -v=
ga std -nographic -vnc :1 -netdev user,id=3Dnet0 -device e1000e,netdev=3Dne=
t0 buster.qcow

Guest works fine until I try to build a linux-stable tree with "make
-j8".

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

