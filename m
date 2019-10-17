Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E34EECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2352720663
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2352720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL28n-0007Cn-4W
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 05:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iL27o-0006Gf-GV
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iL27n-0004mu-78
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:31:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:51638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iL27n-0004m6-1m
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:31:15 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iL27l-0005aq-NN
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 09:31:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A76852E80CC
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 09:31:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Oct 2019 09:15:53 -0000
From: "Laszlo Ersek \(Red Hat\)" <lersek@redhat.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: c-paetow dgilbert-h lersek psyhomb xanclic
X-Launchpad-Bug-Reporter: Claus Paetow (c-paetow)
X-Launchpad-Bug-Modifier: Laszlo Ersek (Red Hat) (lersek)
References: <157080798335.681.12255731732435282400.malonedeb@chaenomeles.canonical.com>
Message-Id: <157130375308.22066.2274851147127833321.malone@wampee.canonical.com>
Subject: [Bug 1847793] Re: qemu 4.1.0 - Corrupt guest filesystem after new vm
 install
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="186023fa645d8be19d403a76064f0643f510db2f";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b4be60f21cd7f32a8b72c8c02b0ba41e777824bb
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1847793 <1847793@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Max, from my
<https://bugs.launchpad.net/qemu/+bug/1846427/comments/8>: I've seen
corruption on ext4.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1847793

Title:
  qemu 4.1.0 - Corrupt guest filesystem after new vm install

Status in QEMU:
  New

Bug description:
  When I install a new vm with qemu 4.1.0 all the guest filesystems are
  corrupt. The first boot from the install dvd iso is ok and the
  installer work fine. But the guest system hangs after the installer
  finishes and I reboot the guest. I can see the grub boot menue but the
  system cannot load the initramfs.

  Testet with:
  - RedHat Enterprise Linux 7.5, 7.6 and 7.7 (RedHat uses xfs for the /boot=
 and / partition)
  Guided install with the graphical installer, no lvm selected.
  - Debian Stable/Buster (Debian uses ext4 for / and /home partition)
  Guidet install with the graphical installer and default options.

  Used commandline to create the vm disk image:
  qemu-img create -f qcow2 /volumes/disk2-part2/vmdisks/vmtest10-1.qcow2 20G

  Used qemu commandline for vm installation:
  #!/bin/sh
  # vmtest10 Installation
  #
  /usr/bin/qemu-system-x86_64  -cpu SandyBridge-IBRS \
      -soundhw hda \
      -M q35 \
      -k de \
      -vga qxl \
      -machine accel=3Dkvm \
      -m 4096 \
      -display gtk \
      -drive file=3D/volumes/disk2-part2/images/debian-10.0.0-amd64-DVD-1.i=
so,if=3Dide,media=3Dcdrom \
      -drive file=3D/volumes/disk2-part2/images/vmtest10-1.qcow2,if=3Dvirti=
o,media=3Ddisk,cache=3Dwriteback \
      -boot once=3Dd,menu=3Doff \
      -device virtio-net-pci,mac=3D52:54:00:2c:02:6c,netdev=3Dvlan0 \
      -netdev bridge,br=3Dbr0,id=3Dvlan0 \
      -rtc base=3Dlocaltime \
      -name "vmtest10" \
      -usb -device usb-tablet \
      -spice disable-ticketing \
      -device virtio-serial-pci \
      -device virtserialport,chardev=3Dspicechannel0,name=3Dcom.redhat.spic=
e.0 \
      -chardev spicevmc,id=3Dspicechannel0,name=3Dvdagent $*

  Host OS:
  Archlinux (last updated at 10.10.2019)
  Linux testing 5.3.5-arch1-1-ARCH #1 SMP PREEMPT Mon Oct 7 19:03:08 UTC 20=
19 x86_64 GNU/Linux
  No libvirt in use.

  =

  With qemu 4.0.0 it works fine without any errors.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1847793/+subscriptions

