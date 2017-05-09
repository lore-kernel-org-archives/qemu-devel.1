Received: from eggs.gnu.org ([2001:4830:134:3::10]:59715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1d83Pm-0005RW-Bn
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1d83Pi-0002hf-DG
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:34:50 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1d83Pi-0002hQ-4B
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:34:46 -0400
Received: by mail-wr0-x241.google.com with SMTP id 6so12914289wrb.1
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 04:34:46 -0700 (PDT)
References: <20170505101930.45837-1-aik@ozlabs.ru>
	<20170509091451.GJ2820@pxdev.xzpeter.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2d7d85cc-a90e-fba1-ede9-2b71c7f68224@ozlabs.ru>
Date: Tue, 9 May 2017 21:34:34 +1000
MIME-Version: 1.0
In-Reply-To: <20170509091451.GJ2820@pxdev.xzpeter.org>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v6] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 09/05/17 19:14, Peter Xu wrote:

>> +void memory_region_init_iommu(IOMMUMemoryRegion *iommu_mr,
>> +                              Object *owner,
>> +                              const MemoryRegionIOMMUOps *ops,
>> +                              const char *name,
>> +                              uint64_t size)
>> +{
>> +    memory_region_init_iommu_type(TYPE_IOMMU_MEMORY_REGION, iommu_mr,
>> +                                  owner, ops, name, size);
> 
> I see that memory_region_init_iommu_type() is only used to create
> TYPE_IOMMU_MEMORY_REGION typed MRs. Then would
> memory_region_init_iommu() enough for us? Or do you have plan to add
> new memory region types?

Yes, I am still thinking of adding TYPE_SPAPR_TCE_IOMMU_MEMORY_REGION
later, for strict types checking when enabling in-kernel DMA operations
support (our SPAPR thingy).



-- 
Alexey
