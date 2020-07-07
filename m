Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6148C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9176E2078A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9176E2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsrW3-0007wo-TV
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 13:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jsrVK-00079o-4L
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 13:35:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:38388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jsrVH-000512-1f
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 13:35:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jsrVE-0006l4-C3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 17:35:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3AD842E8106
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2020 17:35:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2020 17:27:06 -0000
From: Alex Williamson <1869006@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm passthrough tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alex-l-williamson costinel dgilbert-h hrw pmaydell
X-Launchpad-Bug-Reporter: Marcin Juszkiewicz (hrw)
X-Launchpad-Bug-Modifier: Alex Williamson (alex-l-williamson)
References: <158514404728.11288.8869885318197124821.malonedeb@soybean.canonical.com>
Message-Id: <159414282604.31801.690802489009465603.malone@gac.canonical.com>
Subject: [Bug 1869006] Re: PCIe cards passthrough to TCG guest works on 2GB of
 guest memory but fails on 4GB (vfio_dma_map invalid arg)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ffd32ad7291fe66b5578d7c1407aaae58d1e0170";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: fa27e34fe4ab25cde4174f38c27f7da3c2c027c6
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 11:43:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1869006 <1869006@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> When you say "qemu has no support", do you actually mean "qemu people
> are unable to help you if you break things by bypassing the in-place
> restrictions", or "qemu is designed to not work when restrictions are
> bypassed"?

The former.  There are two aspects to this.  The first is that the
device has address space restrictions which therefore impose address
space restrictions on the VM.  That makes things like hotplug difficult
or impossible to support.  That much is something that could be
considered a feature which QEMU has not yet implemented.

The more significant aspect when RMRRs are involved in this restriction
is that an RMRR is essentially the platform firmware dictating that the
host OS must maintain an identity map between the device and a range of
physical address space.  We don't know the purpose of that mapping, but
we can assume that it allows the device to provide ongoing data for
platform firmware to consume.  This data might included health or sensor
information that's vital to the operation of the system.  It's therefore
not simply a matter that QEMU needs to avoid RMRR ranges, we need to
maintain the required identity maps while also manipulating the VM
address space, but the former requirement implies that a user owns a
device that has DMA access to a range of host memory that's been
previously defined as vital to the operation of the platform and
therefore likely exploitable by the user.

The configuration you've achieved appears to have disabled the host
kernel restrictions preventing RMRR encumbered devices from
participating in the IOMMU API, but left in place the VM address space
implications of those RMRRs.  This means that once the device is opened
by the user, that firmware mandated identity mapping is removed and
whatever health or sensor data was being reported by the device to that
range is no longer available to the host firmware, which might adversely
affect the behavior of the system.  Upstream put this restriction in
place as the safe thing to do to honor the firmware mapping requirement
and you've circumvented it, therefore you are your own support.

> Do I understand correctly that the BIOS can modify portions of the
> system usable RAM, so the vendor specific software tools can read
> those addresses, and if yes, does this mean is there a risk for
> data corruption if the RMRR restrictions are bypassed?

RMRRs used for devices other than IGD or USB are often associated with
reserved memory regions to prevent the host OS from making use of those
ranges.  It is possible that privileged utilities might interact with
these ranges, but AIUI the main use case is for the device to interact
with the range, which firmware then consumes.  If you were to ignore the
RMRR mapping altogether, there is a risk that the device will continue
to write whatever health or sensor data it's programmed to report to
that IOVA mapping, which could be a guest mapping and cause data
corruption.

> Is there other place in the kernel 5.4 source that must be modified
> to bring back the v5.3 kernel behaviour? (ie. I have a stable home
> windows vm with the gpu passthrough despite all)

I think the scenarios is that previously the RMRR patch worked because
the vfio IOMMU backend was not imposing the IOMMU reserved region
mapping restrictions, meaning that it was sufficient to simply allow the
device to participate in the IOMMU API and the remaining restrictions
were ignored.  Now the vfio IOMMU backend recognizes the address space
mapping restrictions and disallows creating those mappings that I
describe above as a potential source of data corruption.  Sorry, you are
your own support for this.  The system is not fit for this use case due
to the BIOS imposed restrictions.

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

