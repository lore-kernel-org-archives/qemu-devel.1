Received: from eggs.gnu.org ([2001:4830:134:3::10]:38528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eaw88-0006Z9-Aw
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 23:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eaw85-0002gz-7B
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 23:12:16 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:46755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eaw85-0002g6-1I
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 23:12:13 -0500
Received: by mail-pl0-x242.google.com with SMTP id 66so2783476plc.13
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 20:12:13 -0800 (PST)
References: <20180102052805.20498-1-aik@ozlabs.ru>
	<f14c0782-0f25-8bd0-8536-323bfc5fcbe4@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ad143758-227b-55fe-44a6-c62a48f74162@ozlabs.ru>
Date: Mon, 15 Jan 2018 15:12:07 +1100
MIME-Version: 1.0
In-Reply-To: <f14c0782-0f25-8bd0-8536-323bfc5fcbe4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH qemu 0/3] spapr/iommu: Enable in-kernel TCE
 acceleration via VFIO KVM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

On 03/01/18 04:51, Paolo Bonzini wrote:
> On 02/01/2018 06:28, Alexey Kardashevskiy wrote:
>> This is my current queue of the in-kernel TCE acceleration
>> enablement.
>>
>> Changes since https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg01918.html :
>> * 3 patches instead of one, one per maintainership area;
>> * added memory_region_iommu_get_attr();
>> * removed set_attr() as there is no use for it now;
>> * folded the chunk in vfio_listener_region_add() under
>> VFIO_SPAPR_TCE_v2_IOMMU branch as the acceleration is only
>> enabled when DMA memory is preregistered and this is only supported
>> by the v2 IOMMU.
>>
>> This is based on sha1
>> ad59cde Cédric Le Goater "target/ppc: more use of the PPC_*() macros".
>>
>> Please comment. Thanks.
>>
>>
>>
>> Alexey Kardashevskiy (3):
>>   memory/iommu: Add get_attr()
>>   vfio/spapr: Use iommu memory region's get_attr()
>>   spapr/iommu: Enable in-kernel TCE acceleration via VFIO KVM device
>>
>>  include/exec/memory.h | 22 ++++++++++++++++++++++
>>  target/ppc/kvm_ppc.h  |  6 ++++++
>>  hw/ppc/spapr_iommu.c  | 19 +++++++++++++++++++
>>  hw/vfio/common.c      | 26 ++++++++++++++++++++++++++
>>  memory.c              | 13 +++++++++++++
>>  target/ppc/kvm.c      |  7 ++++++-
>>  hw/vfio/trace-events  |  1 +
>>  7 files changed, 93 insertions(+), 1 deletion(-)
>>
> 
> Alex, if this is okay for you, please pick it up yourself.

Alex, ping?


> 
> Thanks,
> 
> Paolo
> 


-- 
Alexey
