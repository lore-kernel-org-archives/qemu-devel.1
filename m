Received: from eggs.gnu.org ([2001:4830:134:3::10]:53169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e03fw-0001sP-Dy
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e03fv-0006Kz-6C
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:46:44 -0400
References: <1506494000-31982-1-git-send-email-Bharat.Bhushan@nxp.com>
	<20170927074109.GA31587@virtx40>
	<AM5PR0401MB25450ACC804B20D93C4F2D9D9A780@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<9700cf30-65ed-9c55-c1b9-14bb8deb669f@redhat.com>
	<20170927092147.GA32183@virtx40>
	<0af599c0-f859-f90c-c999-bc4a0a678768@redhat.com>
	<20171004114910.GA6932@virtx40>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <79234c56-c524-5359-de8a-f266b19821eb@redhat.com>
Date: Thu, 5 Oct 2017 12:46:25 +0200
MIME-Version: 1.0
In-Reply-To: <20171004114910.GA6932@virtx40>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 0/5] virtio-iommu: VFIO
 integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linu Cherian <linuc.decode@gmail.com>
Cc: Bharat Bhushan <bharat.bhushan@nxp.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>, linu.cherian@cavium.com

Hi Linu,
On 04/10/2017 13:49, Linu Cherian wrote:
> Hi Eric,
> 
> 
> On Wed Sep 27, 2017 at 11:24:01AM +0200, Auger Eric wrote:
>> Hi Linu,
>>
>> On 27/09/2017 11:21, Linu Cherian wrote:
>>> On Wed Sep 27, 2017 at 10:55:07AM +0200, Auger Eric wrote:
>>>> Hi Linu,
>>>>
>>>> On 27/09/2017 10:30, Bharat Bhushan wrote:
>>>>> Hi,
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Linu Cherian [mailto:linuc.decode@gmail.com]
>>>>>> Sent: Wednesday, September 27, 2017 1:11 PM
>>>>>> To: Bharat Bhushan <bharat.bhushan@nxp.com>
>>>>>> Cc: eric.auger@redhat.com; eric.auger.pro@gmail.com;
>>>>>> peter.maydell@linaro.org; alex.williamson@redhat.com; mst@redhat.com;
>>>>>> qemu-arm@nongnu.org; qemu-devel@nongnu.org; kevin.tian@intel.com;
>>>>>> marc.zyngier@arm.com; tn@semihalf.com; will.deacon@arm.com;
>>>>>> drjones@redhat.com; robin.murphy@arm.com; christoffer.dall@linaro.org;
>>>>>> bharatb.yadav@gmail.com
>>>>>> Subject: Re: [Qemu-arm] [PATCH v4 0/5] virtio-iommu: VFIO integration
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On Wed Sep 27, 2017 at 12:03:15PM +0530, Bharat Bhushan wrote:
>>>>>>> This patch series integrates VFIO/VHOST with virtio-iommu.
>>>>>>>
>>>>>>> This version is mainly about rebasing on v4 version on virtio-iommu
>>>>>>> device framework from Eric Augur and addresing review comments.
>>>>>>>
>>>>>>> This patch series allows PCI pass-through using virtio-iommu.
>>>>>>>
>>>>>>> This series is based on:
>>>>>>>  - virtio-iommu kernel driver by Jean-Philippe Brucker
>>>>>>>     [1] [RFC] virtio-iommu version 0.4
>>>>>>>     git://linux-arm.org/virtio-iommu.git branch viommu/v0.4
>>>>
>>>> Just to make sure, do you use the v0.4 virtio-iommu driver from above
>>>> branch?
>>>>
>>>> Thanks
>>>
>>> I am using git://linux-arm.org/linux-jpb.git branch virtio-iommu/v0.4.
>>> Hope you are referring to the same.
>>
>> Yes that's the right one. I will also investigate on my side this afternoon.
>>
>> Thanks
>>
>> Eric
> 
> With the below workaround, atleast ping works for me.
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 249964a..2904617 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
>         .attach_dev             = viommu_attach_dev,
>         .map                    = viommu_map,
>         .unmap                  = viommu_unmap,
> -       .map_sg                 = viommu_map_sg,
> +       .map_sg                 = default_iommu_map_sg,
>         .iova_to_phys           = viommu_iova_to_phys,
>         .add_device             = viommu_add_device,
>         .remove_device          = viommu_remove_device,
> 
> 
> Looks like the qemu backend doesnt have support to handle the map requests from 
> virtio_iommu_map_sg, since it  merges multiple map requests into one with 
> mapsize larger than page size(for eg. 0x5000). 
On my side I understand viommu_map_sg builds a VIRTIO_IOMMU_T_MAP
request for each sg element. The map size matches the sg element size.
Then each request is sent separately in _viommu_send_reqs_sync. I don't
see any concatenation. Looks Jean has a plan to check if it can
concatenate anything (/* TODO: merge physically-contiguous mappings if
any */) but this is not implemented yet.

However you should be allowed to map 1 sg element of 5 pages and then
notify the host about this event I think. Still looking at the code...

I still can't reproduce the issue at the moment. What kind of device are
you assigning?

Thanks

Eric
> 
> Atleast vfio_get_vaddr called from vfio_iommu_map_notify in Qemu expects 
> the map size to be a power of 2.
> 
>  if (len & iotlb->addr_mask) {
>         error_report("iommu has granularity incompatible with target AS");
>         return false;
>     }
> 
> Just trying to understand how this is not hitting in your case. 
>  
> 
