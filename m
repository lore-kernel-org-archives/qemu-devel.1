Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C1DC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BF120659
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BF120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKLAf-0002g9-Ev
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 08:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jKL9h-0001zn-P3
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jKL9f-0008E9-Da
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:10:37 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2097 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jKL9Y-0008Ai-Qq; Fri, 03 Apr 2020 08:10:29 -0400
Received: from lhreml720-chm.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 21F2CB0E129483F7FDE4;
 Fri,  3 Apr 2020 13:10:25 +0100 (IST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml720-chm.china.huawei.com (10.201.108.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 3 Apr 2020 13:10:24 +0100
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Fri, 3 Apr 2020 13:10:24 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Auger Eric <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>
Subject: RE: [RFC v6 00/24] vSMMUv3/pSMMUv3 2 stage VFIO integration
Thread-Topic: [RFC v6 00/24] vSMMUv3/pSMMUv3 2 stage VFIO integration
Thread-Index: AQHV/tjtElUg3ooerkCv3iR9cLdbcqhZLR3wgA4OWoCAABuFAA==
Date: Fri, 3 Apr 2020 12:10:24 +0000
Message-ID: <4795d8fcf5d244e79f0db6558a38bd21@huawei.com>
References: <20200320165840.30057-1-eric.auger@redhat.com>
 <779801971e964109bc46120dda541078@huawei.com>
 <93dccfc9-774c-9976-15ad-b484f0c5956c@redhat.com>
In-Reply-To: <93dccfc9-774c-9976-15ad-b484f0c5956c@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.24.31]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.176.76.210
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "tnowicki@marvell.com" <tnowicki@marvell.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "bbhushan2@marvell.com" <bbhushan2@marvell.com>,
 "will@kernel.org" <will@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

> -----Original Message-----
> From: Auger Eric [mailto:eric.auger@redhat.com]
> Sent: 03 April 2020 11:45
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> eric.auger.pro@gmail.com; qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> peter.maydell@linaro.org; mst@redhat.com; alex.williamson@redhat.com;
> jacob.jun.pan@linux.intel.com; yi.l.liu@intel.com
> Cc: peterx@redhat.com; jean-philippe@linaro.org; will@kernel.org;
> tnowicki@marvell.com; zhangfei.gao@foxmail.com; zhangfei.gao@linaro.org;
> maz@kernel.org; bbhushan2@marvell.com
> Subject: Re: [RFC v6 00/24] vSMMUv3/pSMMUv3 2 stage VFIO integration
>=20
> Hi Shameer,
>=20
> On 3/25/20 12:35 PM, Shameerali Kolothum Thodi wrote:
> > Hi Eric,
> >
> >> -----Original Message-----
> >> From: Eric Auger [mailto:eric.auger@redhat.com]
> >> Sent: 20 March 2020 16:58
> >> To: eric.auger.pro@gmail.com; eric.auger@redhat.com;
> >> qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> peter.maydell@linaro.org;
> >> mst@redhat.com; alex.williamson@redhat.com;
> >> jacob.jun.pan@linux.intel.com; yi.l.liu@intel.com
> >> Cc: peterx@redhat.com; jean-philippe@linaro.org; will@kernel.org;
> >> tnowicki@marvell.com; Shameerali Kolothum Thodi
> >> <shameerali.kolothum.thodi@huawei.com>; zhangfei.gao@foxmail.com;
> >> zhangfei.gao@linaro.org; maz@kernel.org; bbhushan2@marvell.com
> >> Subject: [RFC v6 00/24] vSMMUv3/pSMMUv3 2 stage VFIO integration
> >>
> >> Up to now vSMMUv3 has not been integrated with VFIO. VFIO
> >> integration requires to program the physical IOMMU consistently
> >> with the guest mappings. However, as opposed to VTD, SMMUv3 has
> >> no "Caching Mode" which allows easy trapping of guest mappings.
> >> This means the vSMMUV3 cannot use the same VFIO integration as VTD.
> >>
> >> However SMMUv3 has 2 translation stages. This was devised with
> >> virtualization use case in mind where stage 1 is "owned" by the
> >> guest whereas the host uses stage 2 for VM isolation.
> >>
> >> This series sets up this nested translation stage. It only works
> >> if there is one physical SMMUv3 used along with QEMU vSMMUv3 (in
> >> other words, it does not work if there is a physical SMMUv2).
> >
> > I was testing this series on one of our hardware board with SMMUv3. I d=
id
> > observe an issue while trying to bring up Guest with and without the
> vsmmuV3.
>=20
> I am currently investigating and up to now I fail to reproduce on my end.
> >
> > Steps are like below,
> >
> > 1. start a guest with "iommu=3Dsmmuv3" and a n/w vf device.
> >
> > 2.Exit the VM.
> how to you exit the VM?

QMP system_powerdown

> >
> > 3. start the guest again without "iommu=3Dsmmuv3"
> >
> > This time qemu crashes with,
> >
> > [ 0.447830] hns3 0000:00:01.0: enabling device (0000 -> 0002)
> >
> /home/shameer/qemu-eric/qemu/hw/vfio/pci.c:2851:vfio_dma_fault_notifier_
> handler:
> > Object 0xaaaaeeb47c00 is not an instance of type
> So I think I understand the qemu crash. At the moment the vfio_pci
> registers a fault handler even if we are not in nested mode. The smmuv3
> host driver calls any registered fault handler when it encounters an
> error in !nested mode. So the eventfd is triggered to userspace but qemu
> does not expect that. However the root case is we got some physical
> faults on the second run.

True. And qemu works fine if I run again with iommu=3Dsmmuv3 option.=20
That's why I suspect the mapping for the device in the phys smmu
is not cleared and on vfio-pci enable dev path it encounters error ?

> > qemu:iommu-memory-region
> > ./qemu_run-vsmmu-hns: line 9: 13609 Aborted                 (core
> > dumped) ./qemu-system-aarch64-vsmmuv3v10 -machine
> > virt,kernel_irqchip=3Don,gic-version=3D3 -cpu host -smp cpus=3D1 -kerne=
l
> > Image-ericv10-uacce -initrd rootfs-iperf.cpio -bios
> Just to double check with you,
> host: will-arm-smmu-updates-2stage-v10
> qemu: v4.2.0-2stage-rfcv6
> guest version?

Yes. And guest =3D host image.

> > QEMU_EFI_Dec2018.fd -device vfio-pci,host=3D0000:7d:02.1 -net none -m
> Do you assign exactly the same VF as during the 1st run?

Yes same. Only change is "iommu=3Dsmmuv3" omission.=20

> > 4096 -nographic -D -d -enable-kvm -append "console=3DttyAMA0
> > root=3D/dev/vda -m 4096 rw earlycon=3Dpl011,0x9000000"
> >
> > And you can see that host kernel receives smmuv3 C_BAD_STE event,
> >
> > [10499.379288] vfio-pci 0000:7d:02.1: enabling device (0000 -> 0002)
> > [10501.943881] arm-smmu-v3 arm-smmu-v3.2.auto: event 0x04 received:
> > [10501.943884] arm-smmu-v3 arm-smmu-v3.2.auto: 0x00007d1100000004
> > [10501.943886] arm-smmu-v3 arm-smmu-v3.2.auto: 0x0000100800000080
> > [10501.943887] arm-smmu-v3 arm-smmu-v3.2.auto: 0x00000000fe040000
> > [10501.943889] arm-smmu-v3 arm-smmu-v3.2.auto: 0x000000007e04c440
> I will try to prepare a kernel branch with additional traces.

Ok. You can find the qemu traces below (vfio*/smmu*) for with and without
iommu=3Dsmmuv3 runs(may be not that useful).

https://github.com/hisilicon/qemu/tree/v4.2.0-2stage-rfcv6-eric/traces

Thanks,
Shameer

> Thanks
>=20
> Eric
> >
> > So I suspect we didn't clear nested stage configuration and that affect=
s the
> > translation in the second run. I tried to issue(force) a
> vfio_detach_pasid_table() but
> > that didn't solve the problem.
> >
> > May be I am missing something. Could you please take a look and let me
> know.
> >
> > Thanks,
> > Shameer
> >
> >> - We force the host to use stage 2 instead of stage 1, when we
> >>   detect a vSMMUV3 is behind a VFIO device. For a VFIO device
> >>   without any virtual IOMMU, we still use stage 1 as many existing
> >>   SMMUs expect this behavior.
> >> - We use PCIPASIDOps to propage guest stage1 config changes on
> >>   STE (Stream Table Entry) changes.
> >> - We implement a specific UNMAP notifier that conveys guest
> >>   IOTLB invalidations to the host
> >> - We register MSI IOVA/GPA bindings to the host so that this latter
> >>   can build a nested stage translation
> >> - As the legacy MAP notifier is not called anymore, we must make
> >>   sure stage 2 mappings are set. This is achieved through another
> >>   prereg memory listener.
> >> - Physical SMMU stage 1 related faults are reported to the guest
> >>   via en eventfd mechanism and exposed trhough a dedicated VFIO-PCI
> >>   region. Then they are reinjected into the guest.
> >>
> >> Best Regards
> >>
> >> Eric
> >>
> >> This series can be found at:
> >> https://github.com/eauger/qemu/tree/v4.2.0-2stage-rfcv6
> >>
> >> Kernel Dependencies:
> >> [1] [PATCH v10 00/11] SMMUv3 Nested Stage Setup (VFIO part)
> >> [2] [PATCH v10 00/13] SMMUv3 Nested Stage Setup (IOMMU part)
> >> branch at:
> >> https://github.com/eauger/linux/tree/will-arm-smmu-updates-2stage-v10
> >>
> >> History:
> >>
> >> v5 -> v6:
> >> - just rebase work
> >>
> >> v4 -> v5:
> >> - Use PCIPASIDOps for config update notifications
> >> - removal of notification for MSI binding which is not needed
> >>   anymore
> >> - Use a single fault region
> >> - use the specific interrupt index
> >>
> >> v3 -> v4:
> >> - adapt to changes in uapi (asid cache invalidation)
> >> - check VFIO_PCI_DMA_FAULT_IRQ_INDEX is supported at kernel level
> >>   before attempting to set signaling for it.
> >> - sync on 5.2-rc1 kernel headers + Drew's patch that imports sve_conte=
xt.h
> >> - fix MSI binding for MSI (not MSIX)
> >> - fix mingw compilation
> >>
> >> v2 -> v3:
> >> - rework fault handling
> >> - MSI binding registration done in vfio-pci. MSI binding tear down cal=
led
> >>   on container cleanup path
> >> - leaf parameter propagated
> >>
> >> v1 -> v2:
> >> - Fixed dual assignment (asid now correctly propagated on TLB invalida=
tions)
> >> - Integrated fault reporting
> >>
> >>
> >> Eric Auger (23):
> >>   update-linux-headers: Import iommu.h
> >>   header update against 5.6.0-rc3 and IOMMU/VFIO nested stage APIs
> >>   memory: Add IOMMU_ATTR_VFIO_NESTED IOMMU memory region
> >> attribute
> >>   memory: Add IOMMU_ATTR_MSI_TRANSLATE IOMMU memory region
> >> attribute
> >>   memory: Introduce IOMMU Memory Region inject_faults API
> >>   memory: Add arch_id and leaf fields in IOTLBEntry
> >>   iommu: Introduce generic header
> >>   vfio: Force nested if iommu requires it
> >>   vfio: Introduce hostwin_from_range helper
> >>   vfio: Introduce helpers to DMA map/unmap a RAM section
> >>   vfio: Set up nested stage mappings
> >>   vfio: Pass stage 1 MSI bindings to the host
> >>   vfio: Helper to get IRQ info including capabilities
> >>   vfio/pci: Register handler for iommu fault
> >>   vfio/pci: Set up the DMA FAULT region
> >>   vfio/pci: Implement the DMA fault handler
> >>   hw/arm/smmuv3: Advertise MSI_TRANSLATE attribute
> >>   hw/arm/smmuv3: Store the PASID table GPA in the translation config
> >>   hw/arm/smmuv3: Fill the IOTLBEntry arch_id on NH_VA invalidation
> >>   hw/arm/smmuv3: Fill the IOTLBEntry leaf field on NH_VA invalidation
> >>   hw/arm/smmuv3: Pass stage 1 configurations to the host
> >>   hw/arm/smmuv3: Implement fault injection
> >>   hw/arm/smmuv3: Allow MAP notifiers
> >>
> >> Liu Yi L (1):
> >>   pci: introduce PCIPASIDOps to PCIDevice
> >>
> >>  hw/arm/smmuv3.c                 | 189 ++++++++++--
> >>  hw/arm/trace-events             |   3 +-
> >>  hw/pci/pci.c                    |  34 +++
> >>  hw/vfio/common.c                | 506
> >> +++++++++++++++++++++++++-------
> >>  hw/vfio/pci.c                   | 267 ++++++++++++++++-
> >>  hw/vfio/pci.h                   |   9 +
> >>  hw/vfio/trace-events            |   9 +-
> >>  include/exec/memory.h           |  49 +++-
> >>  include/hw/arm/smmu-common.h    |   1 +
> >>  include/hw/iommu/iommu.h        |  28 ++
> >>  include/hw/pci/pci.h            |  11 +
> >>  include/hw/vfio/vfio-common.h   |  16 +
> >>  linux-headers/COPYING           |   2 +
> >>  linux-headers/asm-x86/kvm.h     |   1 +
> >>  linux-headers/linux/iommu.h     | 375 +++++++++++++++++++++++
> >>  linux-headers/linux/vfio.h      | 109 ++++++-
> >>  memory.c                        |  10 +
> >>  scripts/update-linux-headers.sh |   2 +-
> >>  18 files changed, 1478 insertions(+), 143 deletions(-)
> >>  create mode 100644 include/hw/iommu/iommu.h
> >>  create mode 100644 linux-headers/linux/iommu.h
> >>
> >> --
> >> 2.20.1
> >


