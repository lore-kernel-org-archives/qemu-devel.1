Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0685EC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D281820C01
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D281820C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36157 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmxAU-0008H6-55
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 05:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49567)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hmxA7-0007Hl-9y
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hmxA6-0004GH-3F
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:20:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:34552)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hmxA5-0004Fe-SX
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:20:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hmxA4-0000Hu-T9
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 09:20:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D6FE62E806E
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 09:20:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jul 2019 09:13:23 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell skandal
X-Launchpad-Bug-Reporter: Lutz (skandal)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <156313770910.15255.7682693906978508241.malonedeb@soybean.canonical.com>
Message-Id: <156318200389.15826.2973709945483446077.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 51e5b85511b516576b271804abc3bd9504a1770f
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

We do check for the incompatible option combination in hw/arm/virt.c:
    if (vms->secure) {
        if (kvm_enabled()) {
            error_report("mach-virt: KVM does not support Security extensio=
ns");
            exit(1);
        }

we just don't have anything equivalent in vexpress.c. We should probably
put something in target/arm/cpu.c so we don't have to modify every
board.


** Changed in: qemu
       Status: New =3D> Confirmed

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

