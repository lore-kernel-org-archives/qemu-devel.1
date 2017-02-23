Received: from eggs.gnu.org ([2001:4830:134:3::10]:50717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1ch2RA-0004IK-UR
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1ch2R7-00016N-G5
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:04:36 -0500
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:50107)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1ch2R7-00014a-8A
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:04:33 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	v1NN061Q034124
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 18:04:26 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id D1F046D
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 18:04:26 -0500 (EST)
Received: from sendprodmail01.cc.columbia.edu (sendprodmail01.cc.columbia.edu
	[128.59.72.13]) by hazelnut (Postfix) with ESMTP id BBA7181
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 18:04:26 -0500 (EST)
Received: from mail-ua0-f198.google.com (mail-ua0-f198.google.com
	[209.85.217.198])
	by sendprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	v1NN4QNt055431
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 18:04:26 -0500
Received: by mail-ua0-f198.google.com with SMTP id 48so3648068uaf.7
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 15:04:26 -0800 (PST)
Received: from mail-ua0-f182.google.com (mail-ua0-f182.google.com.
	[209.85.217.182]) by smtp.gmail.com with ESMTPSA id
	i28sm1644272uab.21.2017.02.23.15.04.23 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 Feb 2017 15:04:24 -0800 (PST)
Received: by mail-ua0-f182.google.com with SMTP id g30so3754657uac.3
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 15:04:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHyh4xg6oRVoW81QgdQRoL0Oc7jHm7prgyd--ghYQ4d4_aSUpQ@mail.gmail.com>
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
	<CAHyh4xg6oRVoW81QgdQRoL0Oc7jHm7prgyd--ghYQ4d4_aSUpQ@mail.gmail.com>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Thu, 23 Feb 2017 18:04:22 -0500
Message-ID: <CAHyh4xi0qOaL5X5E6yLpf2O=RYR=G8X=zjr7g+h8QtntYPnsFA@mail.gmail.com>
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
To: QEMU Devel Mailing List <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, "\\ Michael S . Tsirkin \\" <mst@redhat.com>, Bandan Das <bsd@makefile.in>, Alex Williamson <alex.williamson@redhat.com>

[cc Bandan]

On Tue, Feb 21, 2017 at 5:33 AM, Jintack Lim <jintack@cs.columbia.edu>
wrote:

>
>
> On Wed, Feb 15, 2017 at 9:47 PM, Alex Williamson <
> alex.williamson@redhat.com> wrote:
>
>> On Thu, 16 Feb 2017 10:28:39 +0800
>> Peter Xu <peterx@redhat.com> wrote:
>>
>> > On Wed, Feb 15, 2017 at 11:15:52AM -0700, Alex Williamson wrote:
>> >
>> > [...]
>> >
>> > > > Alex, do you like something like below to fix above issue that
>> Jintack
>> > > > has encountered?
>> > > >
>> > > > (note: this code is not for compile, only trying show what I
>> mean...)
>> > > >
>> > > > ------8<-------
>> > > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> > > > index 332f41d..4dca631 100644
>> > > > --- a/hw/vfio/pci.c
>> > > > +++ b/hw/vfio/pci.c
>> > > > @@ -1877,25 +1877,6 @@ static void vfio_add_ext_cap(VFIOPCIDevice
>> *vdev)
>> > > >       */
>> > > >      config = g_memdup(pdev->config, vdev->config_size);
>> > > >
>> > > > -    /*
>> > > > -     * Extended capabilities are chained with each pointing to the
>> next, so we
>> > > > -     * can drop anything other than the head of the chain simply
>> by modifying
>> > > > -     * the previous next pointer.  For the head of the chain, we
>> can modify the
>> > > > -     * capability ID to something that cannot match a valid
>> capability.  ID
>> > > > -     * 0 is reserved for this since absence of capabilities is
>> indicated by
>> > > > -     * 0 for the ID, version, AND next pointer.  However,
>> pcie_add_capability()
>> > > > -     * uses ID 0 as reserved for list management and will
>> incorrectly match and
>> > > > -     * assert if we attempt to pre-load the head of the chain with
>> this ID.
>> > > > -     * Use ID 0xFFFF temporarily since it is also seems to be
>> reserved in
>> > > > -     * part for identifying absence of capabilities in a root
>> complex register
>> > > > -     * block.  If the ID still exists after adding capabilities,
>> switch back to
>> > > > -     * zero.  We'll mark this entire first dword as emulated for
>> this purpose.
>> > > > -     */
>> > > > -    pci_set_long(pdev->config + PCI_CONFIG_SPACE_SIZE,
>> > > > -                 PCI_EXT_CAP(0xFFFF, 0, 0));
>> > > > -    pci_set_long(pdev->wmask + PCI_CONFIG_SPACE_SIZE, 0);
>> > > > -    pci_set_long(vdev->emulated_config_bits +
>> PCI_CONFIG_SPACE_SIZE, ~0);
>> > > > -
>> > > >      for (next = PCI_CONFIG_SPACE_SIZE; next;
>> > > >           next = PCI_EXT_CAP_NEXT(pci_get_long(config + next))) {
>> > > >          header = pci_get_long(config + next);
>> > > > @@ -1917,6 +1898,8 @@ static void vfio_add_ext_cap(VFIOPCIDevice
>> *vdev)
>> > > >          switch (cap_id) {
>> > > >          case PCI_EXT_CAP_ID_SRIOV: /* Read-only VF BARs confuse
>> OVMF */
>> > > >          case PCI_EXT_CAP_ID_ARI: /* XXX Needs next function
>> virtualization */
>> > > > +            /* keep this ecap header (4 bytes), but mask cap_id to
>> 0xffff */
>> > > > +            ...
>> > > >              trace_vfio_add_ext_cap_dropped(vdev->vbasedev.name,
>> cap_id, next);
>> > > >              break;
>> > > >          default:
>> > > > @@ -1925,11 +1908,6 @@ static void vfio_add_ext_cap(VFIOPCIDevice
>> *vdev)
>> > > >
>> > > >      }
>> > > >
>> > > > -    /* Cleanup chain head ID if necessary */
>> > > > -    if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) ==
>> 0xFFFF) {
>> > > > -        pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
>> > > > -    }
>> > > > -
>> > > >      g_free(config);
>> > > >      return;
>> > > >  }
>> > > > ----->8-----
>> > > >
>> > > > Since after all we need the assumption that 0xffff is reserved for
>> > > > cap_id. Then, we can just remove the "first 0xffff then 0x0" hack,
>> > > > which is imho error-prone and hacky.
>> > >
>> > > This doesn't fix the bug, which is that pcie_add_capability() uses a
>> > > valid capability ID for it's own internal tracking.  It's only doing
>> > > this to find the end of the capability chain, which we could do in a
>> > > spec complaint way by looking for a zero next pointer.  Fix that and
>> > > then vfio doesn't need to do this set to 0xffff then back to zero
>> > > nonsense at all.  Capability ID zero is valid.  Thanks,
>> >
>> > Yeah I see Michael's fix on the capability list stuff. However, imho
>> > these are two different issues? Or say, even if with that patch, we
>> > should still need this hack (first 0x0, then 0xffff) right? Since
>> > looks like that patch didn't solve the problem if the first pcie ecap
>> > is masked at 0x100.
>>
>> I thought the problem was that QEMU in the host exposes a device with a
>> capability ID of 0 to the L1 guest.  QEMU in the L1 guest balks at a
>> capability ID of 0 because that's how it finds the end of the chain.
>> Therefore if we make QEMU not use capability ID 0 for internal
>> purposes, things work.  vfio using 0xffff and swapping back to 0x0
>> becomes unnecessary, but doesn't hurt anything.  Thanks,
>>
>
> I've applied Peter's hack and Michael's patch below, but still can't use
> the assigned device in L2.
>  commit 4bb571d857d973d9308d9fdb1f48d983d6639bd4
>     Author: Michael S. Tsirkin <mst@redhat.com>
>     Date:   Wed Feb 15 22:37:45 2017 +0200
>
>     pci/pcie: don't assume cap id 0 is reserved
>
> I was able to boot L2 with following qemu warnings,
> qemu-system-x86_64: vfio: Cannot reset device 0000:00:03.0, no available
> reset mechanism.
> qemu-system-x86_64: vfio: Cannot reset device 0000:00:03.0, no available
> reset mechanism.
>
> but then I don't see the network device, which I was trying to assign to
> L2, in L2.
> This is from L2 dmesg, and it looks like the device is not initialized.
>
> [    5.884115] mlx4_core: Mellanox ConnectX core driver v2.2-1 (Feb, 2014)
> [    5.891563] mlx4_core: Initializing 0000:00:03.0
> [    5.896947] ACPI: PCI Interrupt Link [GSIH] enabled at IRQ 23
> [    6.913559] mlx4_core 0000:00:03.0: Installed FW has unsupported
> command interface revision 0
> [    6.920925] mlx4_core 0000:00:03.0: (Installed FW version is 0.0.000)
> [    6.926490] mlx4_core 0000:00:03.0: This driver version supports only
> revisions 2 to 3
> [    6.933300] mlx4_core 0000:00:03.0: QUERY_FW command failed, aborting
> [    6.940279] mlx4_core 0000:00:03.0: Failed to init fw, aborting.
>
> This is the full kernel log from L2.
> https://paste.ubuntu.com/24039462/
>
> L0, L1 and L2 are using the same kernel, so I think they are using the
> same device driver.
> This is the L0/L1 kernel log about the network device.
>
> --- From L0 ---
> [    8.175533] mlx4_core: Mellanox ConnectX core driver v2.2-1 (Feb, 2014)
> [    8.175543] mlx4_core: Initializing 0000:08:00.0
> [   14.524093] mlx4_core 0000:08:00.0: PCIe link speed is 8.0GT/s, device
> supports 8.0GT/s
> [   14.533030] mlx4_core 0000:08:00.0: PCIe link width is x8, device
> supports x8
> [   14.714296] mlx4_en: Mellanox ConnectX HCA Ethernet driver v2.2-1 (Feb
> 2014)
> [   14.722295] mlx4_en 0000:08:00.0: Activating port:2
> [   14.735186] mlx4_en: 0000:08:00.0: Port 2: Using 128 TX rings
> [   14.741608] mlx4_en: 0000:08:00.0: Port 2: Using 8 RX rings
> [   14.747826] mlx4_en: 0000:08:00.0: Port 2:   frag:0 - size:1522
> prefix:0 stride:1536
> [   14.756698] mlx4_en: 0000:08:00.0: Port 2: Initializing port
> [   14.764036] mlx4_en 0000:08:00.0: registered PHC clock
>
> --- From L1 ---
> [    3.790302] mlx4_core: Mellanox ConnectX core driver v2.2-1 (Feb, 2014)
> [    3.791089] mlx4_core: Initializing 0000:00:03.0
> [    9.053077] mlx4_core 0000:00:03.0: Unable to determine PCIe device BW
> capabilities
> [    9.203290] mlx4_en: Mellanox ConnectX HCA Ethernet driver v2.2-1 (Feb
> 2014)
> [    9.204503] mlx4_en 0000:00:03.0: Activating port:2
> [    9.212853] mlx4_en: 0000:00:03.0: Port 2: Using 32 TX rings
> [    9.213514] mlx4_en: 0000:00:03.0: Port 2: Using 4 RX rings
> [    9.214131] mlx4_en: 0000:00:03.0: Port 2:   frag:0 - size:1522
> prefix:0 stride:1536
> [    9.215260] mlx4_en: 0000:00:03.0: Port 2: Initializing port
> [    9.216377] mlx4_en 0000:00:03.0: registered PHC clock
> [    9.261518] mlx4_en: eth1: Link Up
> [    9.690730] mlx4_core 0000:00:03.0 eth2: renamed from eth1
>
> Any thoughts?
>

I've tried another network device on a different machine. It has "Intel
Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection" ethernet
controller. I got the same problem of getting the network device
initialization failure in L2. I think I'm missing something since I heard
from Bandan that he had no problem to assign a device to L2 with ixgbe.

This is the error message from dmesg in L2.

[    3.692871] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver -
version 4.2.1-k
[    3.697716] ixgbe: Copyright (c) 1999-2015 Intel Corporation.
[    3.964875] ixgbe 0000:00:02.0: HW Init failed: -12
[    3.972362] ixgbe: probe of 0000:00:02.0 failed with error -12

I checked that L2 indeed had that device.
root@guest0:~# lspci
00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM
Controller
00:01.0 VGA compatible controller: Device 1234:1111 (rev 02)
00:02.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+
Network Connection (rev 01)

I'm describing steps I took, so if you notice something wrong, PLEASE let
me know.

1. [L0] Check the device with lspci. Result is [1]
2. [L0] Unbind from the original driver and bind to vfio-pci driver
following [2][3]
3. [L0] Start L1 with this script. [4]
4. [L1] L1 is able to use the network device.
5. [L1] Unbind from the original driver and bind to vfio-pci driver same as
the step 2.
6. [L1] Start L2 with this script. [5]
7. [L2] Got the init failure error message above.

[1] https://paste.ubuntu.com/24055745/
[2] http://www.linux-kvm.org/page/10G_NIC_performance:_VFIO_vs_virtio
[3] http://www.linux-kvm.org/images/b/b4/2012-forum-VFIO.pdf
[4] https://paste.ubuntu.com/24055715/
[5] https://paste.ubuntu.com/24055720/

Thanks,
Jintack


>
>
>> Alex
>>
>>
>
