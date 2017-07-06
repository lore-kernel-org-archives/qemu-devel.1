Received: from eggs.gnu.org ([2001:4830:134:3::10]:37125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dTE8z-0003v0-DA
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 17:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dTE8x-0005sM-Vf
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 17:17:01 -0400
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<AM5PR0401MB2545AFD256A96420ACC44CD89ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<14c83c14-1e7e-f142-77b0-fa8c873e2d41@redhat.com>
	<AM5PR0401MB2545C0E76C4BE6F82FE376D09ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<6f22079e-4b4b-6476-77be-51ec83104c0d@redhat.com>
	<AM5PR0401MB25459FDAA8C9AFA52503AAE99AC40@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<c80977c4-1955-4e9d-3fc8-4d884562fd28@redhat.com>
	<HE1PR0401MB2556D19D91F25DCE96FE7B199AD40@HE1PR0401MB2556.eurprd04.prod.outlook.com>
	<8a7fb667-e6c0-2412-6dca-a8233dd27836@redhat.com>
	<HE1PR0401MB255696A487DFEB2B8972980F9AD40@HE1PR0401MB2556.eurprd04.prod.outlook.com>
	<e9ea564a-f02b-0ed5-e700-b7b1dfd89722@arm.com>
	<AM5PR0401MB25459345E9533FFC3BBE00289AD50@AM5PR0401MB2545.eurprd04.prod.outlook.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <15b631c8-5708-1426-90a2-9be51a796614@redhat.com>
Date: Thu, 6 Jul 2017 23:16:41 +0200
MIME-Version: 1.0
In-Reply-To: <AM5PR0401MB25459345E9533FFC3BBE00289AD50@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 0/8] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "wei@redhat.com" <wei@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

Hi Bharat,

On 06/07/2017 13:24, Bharat Bhushan wrote:
>=20
>=20
>> -----Original Message-----
>> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
>> Sent: Thursday, July 06, 2017 3:33 PM
>> To: Bharat Bhushan <bharat.bhushan@nxp.com>; Auger Eric
>> <eric.auger@redhat.com>; eric.auger.pro@gmail.com;
>> peter.maydell@linaro.org; alex.williamson@redhat.com; mst@redhat.com;
>> qemu-arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: wei@redhat.com; kevin.tian@intel.com; marc.zyngier@arm.com;
>> tn@semihalf.com; will.deacon@arm.com; drjones@redhat.com;
>> robin.murphy@arm.com; christoffer.dall@linaro.org
>> Subject: Re: [Qemu-devel] [RFC v2 0/8] VIRTIO-IOMMU device
>>
>> On 05/07/17 09:49, Bharat Bhushan wrote:>>> Also when setup msi-route
>> kvm_irqchip_add_msi_route() we needed to
>>>> provide the translated address.
>>>>> According to my understanding this is required because kernel does
>>>>> no go
>>>> through viommu translation when generating interrupt, no?
>>>>
>>>> yes this is needed when KVM MSI routes are set up, ie. along with GI=
CV3
>> ITS.
>>>> With GICv2M, qemu direct gsi mapping is used and this is not needed.
>>>>
>>>> So I do not understand your previous sentence saying "MSI interrupts
>>>> works without any change".
>>>
>>> I have almost completed vfio integration with virtio-iommu and now
>>> testing the changes by assigning e1000 device to VM. For this I have
>>> changed virtio-iommu driver to use IOMMU_RESV_MSI rather than sw-msi
>>> and this does not need changed in vfio_get_addr()  and
>>> kvm_irqchip_add_msi_route()
>>
>> I understand you're reserving region 0x08000000-0x08100000 as
>> IOMMU_RESV_MSI instead of IOMMU_RESV_SW_MSI? I think this only
>> works because Qemu places the vgic in that area as well (in hw/arm/vir=
t.c).
>> It's not a coincidence if the addresses are the same, because Eric cho=
se them
>> for the Linux SMMU drivers and I copied them.
>>
>> We can't rely on that behavior, though, it will break MSIs in emulated
>> devices. And if Qemu happens to move the MSI doorbell in future machin=
e
>> revisions, then it would also break VFIO.
>=20
> Yes, make sense to me
>=20
>>
>> Just for my own understanding -- what happens, I think, is that in Lin=
ux
>> iova_reserve_iommu_regions initially reserves the guest-physical doorb=
ell
>> 0x08000000-0x08100000. Then much later, when the device driver request=
s
>> an MSI, the irqchip driver calls iommu_dma_map_msi_msg with the guest-
>> physical gicv2m address 0x08020000. The function finds the right page =
in
>> msi_page_list, which was added by cookie_init_hw_msi_region, therefore
>> bypassing the viommu and the GPA gets written in the MSI-X table.
>=20
> This means in case tomorrow when qemu changes virt machine address map =
and vgic-its (its-translator register address) address range does not fal=
l in the msi_page_list then it will allocate a new iova, create mapping i=
n iommu. So this will no longer be identity mapped and fail to work with =
new qemu?
>=20
Yes that's correct.
>>
>> If an emulated device such as virtio-net-pci were to generate an MSI, =
then
>> Qemu would attempt to access the doorbell written by Linux into the MS=
I-X
>> table, 0x08020000, and fault because that address wasn't mapped in the
>> viommu.
>>
>> So for VFIO, you either need to translate the MSI-X entry using the vi=
ommu,
>> or just assume that the vaddr corresponds to the only MSI doorbell
>> accessible by this device (because how can we be certain that the gues=
t
>> already mapped the doorbell before writing the entry?)
>>
>> For ARM machines it's probably best to stick with IOMMU_RESV_SW_MSI.
>> However, a nice way to use IOMMU_RESV_MSI would be for the virtio-
>> iommu device to advertise identity-mapped/reserved regions, and bypass
>> translation on these regions. Then the driver could reserve those with
>> IOMMU_RESV_MSI.
>=20
> Correct me if I did not understood you correctly, today iommu-driver de=
cides msi-reserved region, what if we change this and virtio-iommu device=
 will provide the reserved msi region as per the emulated machine (virt/i=
ntel). So virtio-iommu driver will use the address advertised by virtio-i=
ommu device as IOMMU_RESV_MSI. In this case msi-page-list will always hav=
e the reserved region for MSI.
> On qemu side, for emulated devices we will let virtio-iommu return same=
 address as translated address as it falls in MSI-reserved page already k=
nown to it.

I think what you're proposing here corresponds to the 1st approach that
was followed for PCIe passthrough/MSI on ARM, ie. the userspace was
providing the reserved region base address & size. This was ruled out
and now this region is arbitrarily set by the smmu-driver. At the moment
this means this region cannot contain guest RAM.

>=20
>=20
>> For x86 we will need such a system, with an added IRQ
>> remapping feature.
>=20
> I do not understand x86 MSI interrupt generation, but If above understa=
nd is correct, then why we need IRQ remapping for x86?
To me x86 IR corresponds simply corresponds to the ITS MSI controller
modality on ARM. So as you still need vITS along with virtio-iommu on
ARM, you need vIRQ alongs with virtio-iommu on Intel. Does that make sens=
e?

So in any case we need to make sure the guest uses a vITS or vIR to make
sure MSIs are correctly isolated.


> Will the x86 machine emulated in QEMU provides a big address range for =
MSIs and when actually generating MSI it needed some extra processing (IR=
Q-remapping processing) before actually generating write transaction for =
MSI interrupt ?=20
My understanding is on x86, the MSI window is fixed and matches
[FEE0_0000h =E2=80=93 FEF0_000h]. MSIs are conveyed on a separate address=
 space
than usual DMA accesses. And yes they end up in IR if supported in the HW=
.

Thanks

Eric
>=20
> Thanks
> -Bharat
>=20
>>
>> Thanks,
>> Jean
