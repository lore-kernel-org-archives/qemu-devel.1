Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B4DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35CDB20684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CDB20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfOk-00014o-Nb
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iNe4W-0000kT-HQ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iNe4U-0003G2-S5
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:26:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:38396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iNe4U-0003EI-LA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:26:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iNe4S-0002tk-UJ
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 14:26:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C4F612E80CE
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 14:26:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Oct 2019 14:20:00 -0000
From: Max Reitz <1847793@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: c-paetow dgilbert-h lersek psyhomb sej7278 xanclic
X-Launchpad-Bug-Reporter: Claus Paetow (c-paetow)
X-Launchpad-Bug-Modifier: Max Reitz (xanclic)
References: <157080798335.681.12255731732435282400.malonedeb@chaenomeles.canonical.com>
Message-Id: <157192680088.29240.2272202812607798113.malone@soybean.canonical.com>
Subject: [Bug 1847793] Re: qemu 4.1.0 - Corrupt guest filesystem after new vm
 install
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: eeda9c9afb3a51f30911dc69e57a1d454affb8dd
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

I suppose that the problem described in bug 1846427 can also affect
guest data, so I think it makes sense to divide based on whether there
are only data corruptions or both data and metadata corruptions.

So far, I don=E2=80=99t know of a report of pure guest data corruptions (wi=
thout
qcow2 metadata being affected) that didn=E2=80=99t happen on XFS, so I assu=
me
there is an issue that affects both data and metadata on all filesystems
(described by 1846427; Kevin has sent a patch series upstream ot address
it), and another one that only affects guest data and only occurs on XFS
(this one).

Actually, there are two problems we know of on XFS:

The first one was a bug in qemu that has been fixed upstream by
b2c6f23f4a9f6d8f1b648705cd46d3713b78d6a2.  People that don=E2=80=99t use ma=
ster
but the 4.1 release instead are likely to hit that problem instead of
the other one.

The second one seems to be a kernel bug.  When fallocating (writing zeroes =
in our case) and writing to a file in parallel, the write is discarded if:
- The fallocated area begins at or after the EOF,
- The written area begins after the fallocated area,
- The write is submitted through the AIO interface (io_submit()),
- The write and the fallocate operation are submitted before either one fin=
ishes (i.e. concurrently),
- The fallocate operation finishes after the write.

In qemu, this happens only with aio=3Dnative, and then most of the time
when an FALLOC_FL_ZERO_RANGE happens after the EOF while a write after
that range is ongoing.


Claus as the reporter didn=E2=80=99t use aio=3Dnative, so if he=E2=80=99s i=
ndeed on XFS, he can=E2=80=99t have hit this second bug.  If he=E2=80=99s o=
n XFS, he will most likely have hit the first one that=E2=80=99s already fi=
xed in master.


Still, we need to fix the second bug.  As for how=E2=80=A6  It looks to me =
like a kernel bug, so in qemu we can=E2=80=99t do anything to fix it.  But =
we should probably work around it.  Kevin has proposed making zero-writes o=
n XFS serializing until infinity, basically (i.e. UINT64_MAX in practice). =
 That gives us some layering problems (either the file-posix block driver n=
eeds access to the TrackedRequest to extend its length, or the generic bloc=
k layer needs to know whether a file-posix node is on XFS), and it yields t=
he question of how to detect whether the bug has been fixed in the kernel.

Max

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

