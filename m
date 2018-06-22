Received: from eggs.gnu.org ([2001:4830:134:3::10]:34785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1fWG8v-0008VT-AZ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1fWG8r-00057B-Cu
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:06:01 -0400
References: <d5f8be99-9602-a628-bc43-486e7befc4dc@gmail.com>
	<90a232ff-74f7-8d10-74f4-87a0008c41df@redhat.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <cfbf2dd4-4f1c-8eae-5ce4-feb7b1547e2e@gmail.com>
Date: Fri, 22 Jun 2018 15:05:51 +0800
MIME-Version: 1.0
In-Reply-To: <90a232ff-74f7-8d10-74f4-87a0008c41df@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Questio] What the proper vfio NIC for emulation
 smmu?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

Hi Eric

On 6/22/2018 2:39 PM, Auger Eric Wrote:
> Hello Jia,
> 
> On 06/22/2018 03:44 AM, Jia He wrote:
>> Hi Eric
>> I want to test your smmu emulation patchset with vfio-pci ethernet device.
>> Could you kindly give me the NIC type information.
>> In my test, there is vf probe error for menallox connect 4 NIC and TX Unit
>> hang error for Intel X540 NIC. That's the reason why I ask this question.
>>
> virtual SMMUv3 is not integrated with VFIO and is not planned to be. It
> was tested with virtio-net-pci (without vhost-net).
> 
> With upstream code you should see the following warning:
> 
> "SMMUV3 does not support vhost/vfio integration yet: devices of those
> types will not function properly"
> 
> With "[PATCH v3 0/4] ARM SMMUv3: IOTLB Emulation and VHOST Support",
> vhost-net gets integrated. VFIO won't be integrated either. If vfio-pci
> device are attempted to be used along with vsmmu, you will get
> "SMMUv3 does not support notification on MAP: device %s will not
> function properly"

Thanks for the information. Actually, I am using your vsmmu-optim-v3 branch.
I assumed vfio worked fine since you removed that warning in commit
("hw/arm/smmuv3: Add notifications on invalidation"). Seems I am wrong ;-)

> 
> My attempt to integrate the vsmmu with VFIO in the same manner as intel
> iommu (using a fake caching mode) was rejected by the kernel maintainer.
> So for VFIO use case, we need either 2 stage enablement (not implemented
> yet) or virtio-iommu. I will respin this latter against v0.7 spec
> probably next week.
Ok. got it, thanks
> 
> Thanks
> 
> Eric
> 

-- 
Cheers,
Jia
