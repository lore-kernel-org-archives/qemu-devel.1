Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C170C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F15820714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F15820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHZ5D-0001hs-7e
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jHZ4M-0000RJ-Ms
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jHZ4L-0002Qg-FK
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:25:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:52200)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jHZ4L-0002QL-9l
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:25:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jHZ4K-0007Tt-IG
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 20:25:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 88DE92E8047
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 20:25:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Mar 2020 20:16:26 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm passthrough tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alex-l-williamson dgilbert-h hrw pmaydell
X-Launchpad-Bug-Reporter: Marcin Juszkiewicz (hrw)
X-Launchpad-Bug-Modifier: Dr. David Alan Gilbert (dgilbert-h)
References: <158514404728.11288.8869885318197124821.malonedeb@soybean.canonical.com>
Message-Id: <158525378711.18657.12345515496182587542.malone@chaenomeles.canonical.com>
Subject: [Bug 1869006] Re: PCIe cards passthrough to TCG guest works on 2GB of
 guest memory but fails on 4GB (vfio_dma_map invalid arg)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 83ced78154e828d4ad132d878f0d5810c46deb1f
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
Reply-To: Bug 1869006 <1869006@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do we need something like a table of excluded IOVA regions in ACPI or somew=
here; in a similar way we have a region of exluded physical ram areas?
Or is the range of excluded IOVA's constant on any one architecture so it d=
oesn't normally need to worry about it?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1869006

Title:
  PCIe cards passthrough to TCG guest works on 2GB of guest memory but
  fails on 4GB (vfio_dma_map invalid arg)

Status in QEMU:
  New

Bug description:
  During one meeting coworker asked "did someone tried to passthrough
  PCIe card to other arch guest?" and I decided to check it.

  Plugged SATA and USB3 controllers into spare slots on mainboard and
  started playing. On 1GB VM instance it worked (both cold- and hot-
  plugged). On 4GB one it did not:

  B=C5=82=C4=85d podczas uruchamiania domeny: internal error: process exite=
d while connecting to monitor: 2020-03-25T13:43:39.107524Z qemu-system-aarc=
h64: -device vfio-pci,host=3D0000:29:00.0,id=3Dhostdev0,bus=3Dpci.3,addr=3D=
0x0: VFIO_MAP_DMA: -22
  2020-03-25T13:43:39.107560Z qemu-system-aarch64: -device vfio-pci,host=3D=
0000:29:00.0,id=3Dhostdev0,bus=3Dpci.3,addr=3D0x0: vfio 0000:29:00.0: faile=
d to setup container for group 28: memory listener initialization failed: R=
egion mach-virt.ram: vfio_dma_map(0x563169753c80, 0x40000000, 0x100000000, =
0x7fb2a3e00000) =3D -22 (Invalid argument)

  Traceback (most recent call last):
    File "/usr/share/virt-manager/virtManager/asyncjob.py", line 75, in cb_=
wrapper
      callback(asyncjob, *args, **kwargs)
    File "/usr/share/virt-manager/virtManager/asyncjob.py", line 111, in tm=
pcb
      callback(*args, **kwargs)
    File "/usr/share/virt-manager/virtManager/object/libvirtobject.py", lin=
e 66, in newfn
      ret =3D fn(self, *args, **kwargs)
    File "/usr/share/virt-manager/virtManager/object/domain.py", line 1279,=
 in startup
      self._backend.create()
    File "/usr/lib64/python3.8/site-packages/libvirt.py", line 1234, in cre=
ate
      if ret =3D=3D -1: raise libvirtError ('virDomainCreate() failed', dom=
=3Dself)
  libvirt.libvirtError: internal error: process exited while connecting to =
monitor: 2020-03-25T13:43:39.107524Z qemu-system-aarch64: -device vfio-pci,=
host=3D0000:29:00.0,id=3Dhostdev0,bus=3Dpci.3,addr=3D0x0: VFIO_MAP_DMA: -22
  2020-03-25T13:43:39.107560Z qemu-system-aarch64: -device vfio-pci,host=3D=
0000:29:00.0,id=3Dhostdev0,bus=3Dpci.3,addr=3D0x0: vfio 0000:29:00.0: faile=
d to setup container for group 28: memory listener initialization failed: R=
egion mach-virt.ram: vfio_dma_map(0x563169753c80, 0x40000000, 0x100000000, =
0x7fb2a3e00000) =3D -22 (Invalid argument)

  =

  I played with memory and 3054 MB is maximum value possible to boot VM wit=
h coldplugged host PCIe cards.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1869006/+subscriptions

