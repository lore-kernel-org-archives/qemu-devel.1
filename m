Received: from eggs.gnu.org ([2001:4830:134:3::10]:44106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dJIpC-0003KO-2P
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dJIpA-0003I7-Lc
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:15:34 -0400
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<AM5PR0401MB2545AFD256A96420ACC44CD89ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<14c83c14-1e7e-f142-77b0-fa8c873e2d41@redhat.com>
	<AM5PR0401MB2545C0E76C4BE6F82FE376D09ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <445b60fe-a0da-ee93-fab3-be88fe269846@redhat.com>
Date: Fri, 9 Jun 2017 14:15:10 +0200
MIME-Version: 1.0
In-Reply-To: <AM5PR0401MB2545C0E76C4BE6F82FE376D09ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 0/8] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharat Bhushan <bharat.bhushan@nxp.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>
Cc: "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "drjones@redhat.com" <drjones@redhat.com>, "wei@redhat.com" <wei@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>, Peter Xu <peterx@redhat.com>

Hi,

On 09/06/2017 13:30, Bharat Bhushan wrote:
> Hi Eric,
> 
>> -----Original Message-----
>> From: Auger Eric [mailto:eric.auger@redhat.com]
>> Sent: Friday, June 09, 2017 12:14 PM
>> To: Bharat Bhushan <bharat.bhushan@nxp.com>;
>> eric.auger.pro@gmail.com; peter.maydell@linaro.org;
>> alex.williamson@redhat.com; mst@redhat.com; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org; jean-philippe.brucker@arm.com
>> Cc: will.deacon@arm.com; robin.murphy@arm.com; kevin.tian@intel.com;
>> marc.zyngier@arm.com; christoffer.dall@linaro.org; drjones@redhat.com;
>> wei@redhat.com; tn@semihalf.com
>> Subject: Re: [RFC v2 0/8] VIRTIO-IOMMU device
>>
>> Hi Bharat,
>>
>> On 09/06/2017 08:16, Bharat Bhushan wrote:
>>> Hi Eric,
>>>
>>>> -----Original Message-----
>>>> From: Eric Auger [mailto:eric.auger@redhat.com]
>>>> Sent: Wednesday, June 07, 2017 9:31 PM
>>>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com;
>>>> peter.maydell@linaro.org; alex.williamson@redhat.com;
>> mst@redhat.com;
>>>> qemu-arm@nongnu.org; qemu-devel@nongnu.org; jean-
>>>> philippe.brucker@arm.com
>>>> Cc: will.deacon@arm.com; robin.murphy@arm.com;
>> kevin.tian@intel.com;
>>>> marc.zyngier@arm.com; christoffer.dall@linaro.org;
>>>> drjones@redhat.com; wei@redhat.com; tn@semihalf.com; Bharat
>> Bhushan
>>>> <bharat.bhushan@nxp.com>
>>>> Subject: [RFC v2 0/8] VIRTIO-IOMMU device
>>>>
>>>> This series implements the virtio-iommu device. This is a proof of
>>>> concept based on the virtio-iommu specification written by Jean-Philippe
>> Brucker [1].
>>>> This was tested with a guest using the virtio-iommu driver [2] and
>>>> exposed with a virtio-net-pci using dma ops.
>>>>
>>>> The device gets instantiated using the "-device virtio-iommu-device"
>>>> option. It currently works with ARM virt machine only as the machine
>>>> must handle the dt binding between the virtio-mmio "iommu" node and
>>>> the PCI host bridge node. ACPI booting is not yet supported.

For those who may play with the device, this was tested with a
virtio-net-pci device using the following command:

-device
virtio-net-pci,netdev=tap0,mac=<MAC>,iommu_platform,disable-modern=off,disable-legacy=on
\

I tried to run the guest using a virtio-blk-pci device using
-device
virtio-blk-pci,scsi=off,drive=<>,iommu_platform=off,disable-modern=off,disable-legacy=on,werror=stop,rerror=stop
\

and the guest does *not* boot whereas it does without any iommu.

However I am not sure the issue is related to the actual virtual iommu
device as I have the exact same issue with vsmmuv3 emulated device (This
was originally reported by Tomasz). So the issue may come from the
infrastructure around. To be further investigated ...

Thanks

Eric

>>>>
>>>> This should allow to start some benchmarking activities against pure
>>>> emulated IOMMU (especially ARM SMMU).
>>>
>>> I am testing this on ARM64 and see below continuous error prints:
>>>
>>> 	virtio_iommu_translate sid=8 is not known!!
>>> 	virtio_iommu_translate sid=8 is not known!!
>>> 	virtio_iommu_translate sid=8 is not known!!
>>> 	virtio_iommu_translate sid=8 is not known!!
>>> 	virtio_iommu_translate sid=8 is not known!!
>>> 	virtio_iommu_translate sid=8 is not known!!
>>> 	virtio_iommu_translate sid=8 is not known!!
>>> 	virtio_iommu_translate sid=8 is not known!!
>>> 	virtio_iommu_translate sid=8 is not known!!
>>> 	virtio_iommu_translate sid=8 is not known!!
>>>
>>>
>>> Also in guest I do not see device-tree node with virtio-iommu.
>> do you mean the virtio-mmio with #iommu-cells property?
>>
>> This one is created statically by virt machine. I would be surprised if it were
>> not there. Are you using the virt = virt2.10 machine. Machines before do not
>> support its instantiation.
>>
>> Please can you add a printf in hw/arm/virt.c create_virtio_mmio() at the
>> moment when this node is created. Also you can add a printf in
>> bind_virtio_iommu_device() to make sure the binding with the PCI host
>> bridge is added on machine init done.
>>
>> Also worth to check, CONFIG_VIRTIO_IOMMU=y on guest side.
> 
> It works on my side. The driver config was disabled and also I was using guest kernel which was not have deferred-probing. Now after fixing it works on my side
> I placed some prints to see dma-map are mapping regions in virtio-iommu, it uses emulated iommu.
> 
> I will continue to add VFIO support now on this and more testing !!
> 
> Thanks
> -Bharat
> 
>>
>> Thanks
>>
>> Eric
>>
>>> I am using qemu-tree you mentioned below and iommu-driver patches
>> published by Jean-P.
>>> Qemu command line have additional ""-device virtio-iommu-device". What
>> I am missing ?
>>
>>
>>>
>>> Thanks
>>> -Bharat
>>>
>>>>
>>>> Best Regards
>>>>
>>>> Eric
>>>>
>>>> This series can be found at:
>>>> https://github.com/eauger/qemu/tree/virtio-iommu-rfcv2
>>>>
>>>> References:
>>>> [1] [RFC 0/3] virtio-iommu: a paravirtualized IOMMU, [2] [RFC PATCH
>>>> linux]
>>>> iommu: Add virtio-iommu driver [3] [RFC PATCH kvmtool 00/15] Add
>>>> virtio- iommu
>>>>
>>>> History:
>>>> v1 -> v2:
>>>> - fix redifinition of viommu_as typedef
>>>>
>>>> Eric Auger (8):
>>>>   update-linux-headers: import virtio_iommu.h
>>>>   linux-headers: Update for virtio-iommu
>>>>   virtio_iommu: add skeleton
>>>>   virtio-iommu: Decode the command payload
>>>>   virtio_iommu: Add the iommu regions
>>>>   virtio-iommu: Implement the translation and commands
>>>>   hw/arm/virt: Add 2.10 machine type
>>>>   hw/arm/virt: Add virtio-iommu the virt board
>>>>
>>>>  hw/arm/virt.c                                 | 116 ++++-
>>>>  hw/virtio/Makefile.objs                       |   1 +
>>>>  hw/virtio/trace-events                        |  14 +
>>>>  hw/virtio/virtio-iommu.c                      | 623
>> ++++++++++++++++++++++++++
>>>>  include/hw/arm/virt.h                         |   5 +
>>>>  include/hw/virtio/virtio-iommu.h              |  60 +++
>>>>  include/standard-headers/linux/virtio_ids.h   |   1 +
>>>>  include/standard-headers/linux/virtio_iommu.h | 142 ++++++
>>>>  linux-headers/linux/virtio_iommu.h            |   1 +
>>>>  scripts/update-linux-headers.sh               |   3 +
>>>>  10 files changed, 957 insertions(+), 9 deletions(-)  create mode
>>>> 100644 hw/virtio/virtio-iommu.c  create mode 100644
>>>> include/hw/virtio/virtio- iommu.h  create mode 100644
>>>> include/standard- headers/linux/virtio_iommu.h  create mode 100644
>>>> linux-headers/linux/virtio_iommu.h
>>>>
>>>> --
>>>> 2.5.5
>>>
