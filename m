Received: from eggs.gnu.org ([2001:4830:134:3::10]:42581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dUtL9-0007Ly-4b
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 07:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dUtL7-0005Ds-Nn
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 07:28:27 -0400
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<6f22079e-4b4b-6476-77be-51ec83104c0d@redhat.com>
	<AM5PR0401MB25459FDAA8C9AFA52503AAE99AC40@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<c80977c4-1955-4e9d-3fc8-4d884562fd28@redhat.com>
	<HE1PR0401MB2556D19D91F25DCE96FE7B199AD40@HE1PR0401MB2556.eurprd04.prod.outlook.com>
	<8a7fb667-e6c0-2412-6dca-a8233dd27836@redhat.com>
	<HE1PR0401MB255696A487DFEB2B8972980F9AD40@HE1PR0401MB2556.eurprd04.prod.outlook.com>
	<e9ea564a-f02b-0ed5-e700-b7b1dfd89722@arm.com>
	<AM5PR0401MB25459345E9533FFC3BBE00289AD50@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<15b631c8-5708-1426-90a2-9be51a796614@redhat.com>
	<BN4PR07MB2161B5CCE84496804B848326E3D50@BN4PR07MB2161.namprd07.prod.outlook.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D28807@SHSMSX101.ccr.corp.intel.com>
	<67cb3a84-9aa7-2b4f-43b6-be6dea15b66f@arm.com>
	<BN4PR07MB21615F830FCA5445EF4B7974E3AA0@BN4PR07MB2161.namprd07.prod.outlook.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <8933b36d-c552-c6d5-e4de-e4955f63fec3@arm.com>
Date: Tue, 11 Jul 2017 12:31:08 +0100
MIME-Version: 1.0
In-Reply-To: <BN4PR07MB21615F830FCA5445EF4B7974E3AA0@BN4PR07MB2161.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm]  [RFC v2 0/8] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Kalra, Ashish" <Ashish.Kalra@cavium.com>, "Tian, Kevin" <kevin.tian@intel.com>, Auger Eric <eric.auger@redhat.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On 07/07/17 23:11, Kalra, Ashish wrote:
> Hello Jean,
> 
> Thanks for the information.
> 
> Is someone already working on implementing this, or is this something I can look into and implementing ?

I'm still working on the specification, along with a prototype for the
Linux driver and the kvmtool device. I don't want to rush it because it's
a complicated subject, and we're barely supporting SVM in the host.
Supporting IO page faults is only part of the problem, we also need to
hand page tables over to the guest, which requires a new interface for
virtio-iommu. For the moment, my priority is on consolidating the base
device specification.

> Also, as Michael mentioned and I looked in the vfio iommu (type1) driver implementation that it supports mainly
> static mappings of user-space processes with  user-space pages pinned/locked in memory, so a generic support
> for ATS/PRI extensions needs to be added in VFIO too.

That's also in progress. As far as I know the latest version for fault
reporting is http://www.spinics.net/lists/kvm/msg146615.html

Thanks,
Jean

> Thanks,
> Ashish
> 
> -----Original Message-----
> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com] 
> Sent: Friday, July 07, 2017 8:45 PM
> To: Tian, Kevin; Kalra, Ashish; Auger Eric; Bharat Bhushan; eric.auger.pro@gmail.com; peter.maydell@linaro.org; alex.williamson@redhat.com; mst@redhat.com; qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: marc.zyngier@arm.com; tn@semihalf.com; will.deacon@arm.com; drjones@redhat.com; robin.murphy@arm.com; christoffer.dall@linaro.org
> Subject: Re: [Qemu-arm] [Qemu-devel] [RFC v2 0/8] VIRTIO-IOMMU device
> 
> Hi Ashish,
> 
> On 07/07/17 00:33, Tian, Kevin wrote:
>>> From: Kalra, Ashish [mailto:Ashish.Kalra@cavium.com]
>>> Sent: Friday, July 7, 2017 7:24 AM
>>>
>>> I have a generic question on vIOMMU support, is there any 
>>> proposal/plan to add ATS/PRI extension support to vIOMMUs and allow 
>>> handling for end to end (v)IOMMU Page faults (w/t the device side 
>>> implementation on Vhost) ?
>>>
>>> Again, the motivation will be to do DMA on paged guest memory and 
>>> potentially avoiding the requirement of pinned/locked guest physical 
>>> memory for DMA.
>>
>> yes, that's a necessary part to support SVM in both virtio-iommu 
>> approach and fully emulated approach (e.g. for Intel VTd). There are 
>> already patches and discussions in other thread about how to propagate 
>> IOMMU page fault to vIOMMU. Then after it is done vIOMMU page fault 
>> emulation will be further added.
>>
>> https://lkml.org/lkml/2017/6/27/964
> 
> For virtio-iommu, I'd like to add an event virtqueue for the device to send page faults to the driver, in a format similar to a PRI Page Request.
> The driver would then send a reply via the request virtqueue in a format similar to a PRG Response.
> 
> In Qemu the device implementation would hopefully be based on the same mechanism as VTd. The vhost implementation would receive IO Page Faults from VFIO and forward them on the event virtqueue similarly to the userspace implementation.
> 
> Thanks,
> Jean
> 
