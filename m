Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B9FC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3664A2064B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3664A2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmxrf-0008UD-8S
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 06:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59968)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hmxrT-00083k-8I
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hmxrS-00063R-33
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:05:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:42784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hmxrR-00063E-TX
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:05:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hmxrQ-0005io-OY
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 10:05:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B85782E8058
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 10:05:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jul 2019 09:57:50 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell skandal
X-Launchpad-Bug-Reporter: Lutz (skandal)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <156313770910.15255.7682693906978508241.malonedeb@soybean.canonical.com>
Message-Id: <156318467095.16001.16829598362129428859.launchpad@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 221928ecec10c0f150a09225cf7d97715e380a24
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1836501] Re: cpu_address_space_init fails with
 assertion
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
Reply-To: Bug 1836501 <1836501@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Tags added: arm

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1836501

Title:
  cpu_address_space_init fails with assertion

Status in QEMU:
  Confirmed

Bug description:
  qemu-system-arm does not start with version >=3D 2.6 and KVM enabled.

    cpu_address_space_init: Assertion `asidx =3D=3D 0 || !kvm_enabled()'
  failed.

  Hardware is Odroid XU4 with Exynos with 4.9.61+ Tested with Debian
  Stretch (9) or Buster (10).

  Without KVM it is running fine but slow. I'm operating Debian Jessie
  with qemu 2.1 for a long time with KVM virtualization working
  flawlessly. When I upgraded to Stretch I ran into the trouble
  described before. I tried Debian Stretch and Buster with all Kernels
  provided by the Board manufacturer (Hardkernel).

  It seems to be related to the feature introduced in Version 2.6:
  https://wiki.qemu.org/ChangeLog/2.6
  - Support for a separate EL3 address space

  KVM is enabled, so I assume the adress space index asidx to be causing
  the assert to fail.

  dmesg | grep -i KVM
  [    0.741714] kvm [1]: 8-bit VMID
  [    0.741721] kvm [1]: IDMAP page: 40201000
  [    0.741729] kvm [1]: HYP VA range: c0000000:ffffffff
  [    0.742543] kvm [1]: Hyp mode initialized successfully
  [    0.742600] kvm [1]: vgic-v2@10484000
  [    0.742924] kvm [1]: vgic interrupt IRQ16
  [    0.742943] kvm [1]: virtual timer IRQ60

  Full command line is:
  qemu-system-arm -M vexpress-a15 -smp 2 -m 512 -cpu host -enable-kvm -kern=
el vmlinuz -initrd initrd.gz -dtb vexpress-v2p-ca15-tc1.dtb -device virtio-=
blk-device,drive=3Dinst-blk -drive file=3DPATHTOFILE,id=3Dinst-blk,if=3Dnon=
e,format=3Draw -append "vga=3Dnormal rw console=3DttyAMA0" -nographic

  Is there anything to do to understand, if this is a hardware related
  failure or probably just a missing parameter?

  Regards

  Lutz

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1836501/+subscriptions

