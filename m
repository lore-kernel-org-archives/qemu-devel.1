Received: from eggs.gnu.org ([2001:4830:134:3::10]:46115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1cg7kw-0004Fe-Mg
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1cg7kt-00082S-DX
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:33:14 -0500
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:51229)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1cg7kt-00081i-6H
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:33:11 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	v1LAW7gb010809
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 05:33:03 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id CC59582
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 05:33:03 -0500 (EST)
Received: from sendprodmail01.cc.columbia.edu (sendprodmail01.cc.columbia.edu
	[128.59.72.13]) by hazelnut (Postfix) with ESMTP id D788982
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 05:33:02 -0500 (EST)
Received: from mail-vk0-f72.google.com (mail-vk0-f72.google.com
	[209.85.213.72])
	by sendprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	v1LAX2BU065109
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 05:33:02 -0500
Received: by mail-vk0-f72.google.com with SMTP id x75so50655259vke.5
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 02:33:02 -0800 (PST)
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com.
	[209.85.213.50]) by smtp.gmail.com with ESMTPSA id
	j201sm5409296vkf.28.2017.02.21.02.33.01 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 Feb 2017 02:33:01 -0800 (PST)
Received: by mail-vk0-f50.google.com with SMTP id k127so76586842vke.0
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 02:33:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170215194758.4622d73c@t450s.home>
References: <20170208031216.GA5151@pxdev.xzpeter.org>
	<CAHyh4xg7NVPjXu3c+xGWNzQqwLgFqFJTPo4SgN-X+FNuHjGihQ@mail.gmail.com>
	<CAHyh4xhOPmfLoU_fvtbBF1Wqbzji9q6rp_bRN38qfnwvhQq+9A@mail.gmail.com>
	<20170209035250.GB22153@pxdev.xzpeter.org>
	<CAHyh4xi9KZm13mJnE3-EyYkkyN4YDKKwbeJ68AumCBM7kgr+MQ@mail.gmail.com>
	<20170214073551.GA9055@pxdev.xzpeter.org>
	<CAHyh4xiATAV801U7zjK1F_B+7e2bDWhH1-gpFKF3U1jNmCfScw@mail.gmail.com>
	<20170215025243.GA3988@pxdev.xzpeter.org>
	<20170215033452.GB3988@pxdev.xzpeter.org>
	<20170215111552.5405418a@t450s.home>
	<20170216022839.GC15985@pxdev.xzpeter.org>
	<20170215194758.4622d73c@t450s.home>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Tue, 21 Feb 2017 05:33:00 -0500
Message-ID: <CAHyh4xg6oRVoW81QgdQRoL0Oc7jHm7prgyd--ghYQ4d4_aSUpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] iommu emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, mst@redhat.com, QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Wed, Feb 15, 2017 at 9:47 PM, Alex Williamson <alex.williamson@redhat.com
> wrote:

> On Thu, 16 Feb 2017 10:28:39 +0800
> Peter Xu <peterx@redhat.com> wrote:
>
> > On Wed, Feb 15, 2017 at 11:15:52AM -0700, Alex Williamson wrote:
> >
> > [...]
> >
> > > > Alex, do you like something like below to fix above issue that
> Jintack
> > > > has encountered?
> > > >
> > > > (note: this code is not for compile, only trying show what I mean...)
> > > >
> > > > ------8<-------
> > > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > > index 332f41d..4dca631 100644
> > > > --- a/hw/vfio/pci.c
> > > > +++ b/hw/vfio/pci.c
> > > > @@ -1877,25 +1877,6 @@ static void vfio_add_ext_cap(VFIOPCIDevice
> *vdev)
> > > >       */
> > > >      config = g_memdup(pdev->config, vdev->config_size);
> > > >
> > > > -    /*
> > > > -     * Extended capabilities are chained with each pointing to the
> next, so we
> > > > -     * can drop anything other than the head of the chain simply by
> modifying
> > > > -     * the previous next pointer.  For the head of the chain, we
> can modify the
> > > > -     * capability ID to something that cannot match a valid
> capability.  ID
> > > > -     * 0 is reserved for this since absence of capabilities is
> indicated by
> > > > -     * 0 for the ID, version, AND next pointer.  However,
> pcie_add_capability()
> > > > -     * uses ID 0 as reserved for list management and will
> incorrectly match and
> > > > -     * assert if we attempt to pre-load the head of the chain with
> this ID.
> > > > -     * Use ID 0xFFFF temporarily since it is also seems to be
> reserved in
> > > > -     * part for identifying absence of capabilities in a root
> complex register
> > > > -     * block.  If the ID still exists after adding capabilities,
> switch back to
> > > > -     * zero.  We'll mark this entire first dword as emulated for
> this purpose.
> > > > -     */
> > > > -    pci_set_long(pdev->config + PCI_CONFIG_SPACE_SIZE,
> > > > -                 PCI_EXT_CAP(0xFFFF, 0, 0));
> > > > -    pci_set_long(pdev->wmask + PCI_CONFIG_SPACE_SIZE, 0);
> > > > -    pci_set_long(vdev->emulated_config_bits +
> PCI_CONFIG_SPACE_SIZE, ~0);
> > > > -
> > > >      for (next = PCI_CONFIG_SPACE_SIZE; next;
> > > >           next = PCI_EXT_CAP_NEXT(pci_get_long(config + next))) {
> > > >          header = pci_get_long(config + next);
> > > > @@ -1917,6 +1898,8 @@ static void vfio_add_ext_cap(VFIOPCIDevice
> *vdev)
> > > >          switch (cap_id) {
> > > >          case PCI_EXT_CAP_ID_SRIOV: /* Read-only VF BARs confuse
> OVMF */
> > > >          case PCI_EXT_CAP_ID_ARI: /* XXX Needs next function
> virtualization */
> > > > +            /* keep this ecap header (4 bytes), but mask cap_id to
> 0xffff */
> > > > +            ...
> > > >              trace_vfio_add_ext_cap_dropped(vdev->vbasedev.name,
> cap_id, next);
> > > >              break;
> > > >          default:
> > > > @@ -1925,11 +1908,6 @@ static void vfio_add_ext_cap(VFIOPCIDevice
> *vdev)
> > > >
> > > >      }
> > > >
> > > > -    /* Cleanup chain head ID if necessary */
> > > > -    if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) ==
> 0xFFFF) {
> > > > -        pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
> > > > -    }
> > > > -
> > > >      g_free(config);
> > > >      return;
> > > >  }
> > > > ----->8-----
> > > >
> > > > Since after all we need the assumption that 0xffff is reserved for
> > > > cap_id. Then, we can just remove the "first 0xffff then 0x0" hack,
> > > > which is imho error-prone and hacky.
> > >
> > > This doesn't fix the bug, which is that pcie_add_capability() uses a
> > > valid capability ID for it's own internal tracking.  It's only doing
> > > this to find the end of the capability chain, which we could do in a
> > > spec complaint way by looking for a zero next pointer.  Fix that and
> > > then vfio doesn't need to do this set to 0xffff then back to zero
> > > nonsense at all.  Capability ID zero is valid.  Thanks,
> >
> > Yeah I see Michael's fix on the capability list stuff. However, imho
> > these are two different issues? Or say, even if with that patch, we
> > should still need this hack (first 0x0, then 0xffff) right? Since
> > looks like that patch didn't solve the problem if the first pcie ecap
> > is masked at 0x100.
>
> I thought the problem was that QEMU in the host exposes a device with a
> capability ID of 0 to the L1 guest.  QEMU in the L1 guest balks at a
> capability ID of 0 because that's how it finds the end of the chain.
> Therefore if we make QEMU not use capability ID 0 for internal
> purposes, things work.  vfio using 0xffff and swapping back to 0x0
> becomes unnecessary, but doesn't hurt anything.  Thanks,
>

I've applied Peter's hack and Michael's patch below, but still can't use
the assigned device in L2.
 commit 4bb571d857d973d9308d9fdb1f48d983d6639bd4
    Author: Michael S. Tsirkin <mst@redhat.com>
    Date:   Wed Feb 15 22:37:45 2017 +0200

    pci/pcie: don't assume cap id 0 is reserved

I was able to boot L2 with following qemu warnings,
qemu-system-x86_64: vfio: Cannot reset device 0000:00:03.0, no available
reset mechanism.
qemu-system-x86_64: vfio: Cannot reset device 0000:00:03.0, no available
reset mechanism.

but then I don't see the network device, which I was trying to assign to
L2, in L2.
This is from L2 dmesg, and it looks like the device is not initialized.

[    5.884115] mlx4_core: Mellanox ConnectX core driver v2.2-1 (Feb, 2014)
[    5.891563] mlx4_core: Initializing 0000:00:03.0
[    5.896947] ACPI: PCI Interrupt Link [GSIH] enabled at IRQ 23
[    6.913559] mlx4_core 0000:00:03.0: Installed FW has unsupported command
interface revision 0
[    6.920925] mlx4_core 0000:00:03.0: (Installed FW version is 0.0.000)
[    6.926490] mlx4_core 0000:00:03.0: This driver version supports only
revisions 2 to 3
[    6.933300] mlx4_core 0000:00:03.0: QUERY_FW command failed, aborting
[    6.940279] mlx4_core 0000:00:03.0: Failed to init fw, aborting.

This is the full kernel log from L2.
https://paste.ubuntu.com/24039462/

L0, L1 and L2 are using the same kernel, so I think they are using the same
device driver.
This is the L0/L1 kernel log about the network device.

--- From L0 ---
[    8.175533] mlx4_core: Mellanox ConnectX core driver v2.2-1 (Feb, 2014)
[    8.175543] mlx4_core: Initializing 0000:08:00.0
[   14.524093] mlx4_core 0000:08:00.0: PCIe link speed is 8.0GT/s, device
supports 8.0GT/s
[   14.533030] mlx4_core 0000:08:00.0: PCIe link width is x8, device
supports x8
[   14.714296] mlx4_en: Mellanox ConnectX HCA Ethernet driver v2.2-1 (Feb
2014)
[   14.722295] mlx4_en 0000:08:00.0: Activating port:2
[   14.735186] mlx4_en: 0000:08:00.0: Port 2: Using 128 TX rings
[   14.741608] mlx4_en: 0000:08:00.0: Port 2: Using 8 RX rings
[   14.747826] mlx4_en: 0000:08:00.0: Port 2:   frag:0 - size:1522 prefix:0
stride:1536
[   14.756698] mlx4_en: 0000:08:00.0: Port 2: Initializing port
[   14.764036] mlx4_en 0000:08:00.0: registered PHC clock

--- From L1 ---
[    3.790302] mlx4_core: Mellanox ConnectX core driver v2.2-1 (Feb, 2014)
[    3.791089] mlx4_core: Initializing 0000:00:03.0
[    9.053077] mlx4_core 0000:00:03.0: Unable to determine PCIe device BW
capabilities
[    9.203290] mlx4_en: Mellanox ConnectX HCA Ethernet driver v2.2-1 (Feb
2014)
[    9.204503] mlx4_en 0000:00:03.0: Activating port:2
[    9.212853] mlx4_en: 0000:00:03.0: Port 2: Using 32 TX rings
[    9.213514] mlx4_en: 0000:00:03.0: Port 2: Using 4 RX rings
[    9.214131] mlx4_en: 0000:00:03.0: Port 2:   frag:0 - size:1522 prefix:0
stride:1536
[    9.215260] mlx4_en: 0000:00:03.0: Port 2: Initializing port
[    9.216377] mlx4_en 0000:00:03.0: registered PHC clock
[    9.261518] mlx4_en: eth1: Link Up
[    9.690730] mlx4_core 0000:00:03.0 eth2: renamed from eth1

Any thoughts?


> Alex
>
>
