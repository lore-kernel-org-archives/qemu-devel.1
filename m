Received: from eggs.gnu.org ([2001:4830:134:3::10]:55081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dXOuk-0000FB-KI
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dXOug-0007ed-Il
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:35:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57162
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dXOug-0007eC-DB
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:35:30 -0400
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-8-git-send-email-yi.l.liu@intel.com>
	<cc330a8f-e087-9b6f-2a40-38b58688d300@arm.com>
	<20170702100659.GA22053@gmail.com>
	<0e4f2dd4-d553-b1b7-7bec-fe0ff5242c54@arm.com>
	<20170703103115.GB22053@gmail.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D25919@SHSMSX101.ccr.corp.intel.com>
	<1d63c1ae-ca10-0f9d-91de-0d9c9823c104@arm.com>
	<20170705112816.56554f65@w520.home>
	<A2975661238FB949B60364EF0F2C2574390A7C4F@shsmsx102.ccr.corp.intel.com>
	<20170714121555.7e64d849@w520.home>
	<A2975661238FB949B60364EF0F2C2574390A906A@shsmsx102.ccr.corp.intel.com>
	<20170717164515.2491b3bf@w520.home>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <d0abeefc-adcf-85c3-f5d9-8c90a18f8011@arm.com>
Date: Tue, 18 Jul 2017 10:38:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170717164515.2491b3bf@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 7/8] VFIO: Add new IOCTL for IOMMU TLB
 invalidate propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Will Deacon <Will.Deacon@arm.com>, "peterx@redhat.com" <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, Joerg Roedel <joro@8bytes.org>

On 17/07/17 23:45, Alex Williamson wrote:
[..]
>>>
>>> How does a user learn which model(s) are supported by the interface?
>>> How do they learn which ops are supported?  Perhaps a good use for one of those
>>> flag bits in the outer data structure is "probe".  
>>
>> My initial plan to user fills it, if the underlying HW doesn't support the
>> model, it refuses to service it. User should get a failure and stop to use
>> it. But your suggestion to have a probe or kinds of query makes sense.
>> How about we add one more operation for such purpose? Besides the
>> supported model query, I'd like to add more. E.g the HW IOMMU capabilities.
> 
> We also have VFIO_IOMMU_GET_INFO where the structure can be extended
> for missing capabilities.  Depending on the capability you want to
> describe, this might be a better, existing interface for it.

It might become hairy when physical IOMMUs start supporting multiple
formats, or when we want to describe multiple page table formats in
addition to PASID tables. I was wondering if sysfs iommu_group would be
better suited for this kind of hardware description with variable-length
properties, but a new ioctl-based probing mechanism would work as well.

Other things that we'll want to describe are fault reporting capability
and PASID range, which would fit better in vfio_device_info.

Thanks,
Jean
