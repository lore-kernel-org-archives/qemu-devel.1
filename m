Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D94C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C10621882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C10621882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibXZ-00044P-T7
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58268)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hibCQ-0002np-0X
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hibCO-0008Fq-CA
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:05:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hibCG-0007hE-OE; Wed, 03 Jul 2019 05:05:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0374230923DD;
 Wed,  3 Jul 2019 09:04:46 +0000 (UTC)
Received: from [10.36.116.95] (ovpn-116-95.ams2.redhat.com [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A572968C1;
 Wed,  3 Jul 2019 09:04:39 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>
References: <20190701093034.18873-1-eric.auger@redhat.com>
 <20190701093034.18873-4-eric.auger@redhat.com> <20190703054116.GD10408@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ac7cb635-b420-e04d-1a80-6fcfe81d12a8@redhat.com>
Date: Wed, 3 Jul 2019 11:04:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190703054116.GD10408@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 03 Jul 2019 09:04:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/6] hw/vfio/common: Do not replay IOMMU
 mappings in nested case
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 7/3/19 7:41 AM, Peter Xu wrote:
> On Mon, Jul 01, 2019 at 11:30:31AM +0200, Eric Auger wrote:
>> In nested mode, the stage 1 translation tables are owned by
>> the guest and there is no caching on host side. So there is
>> no need to replay the mappings.
>>
>> As of today, the SMMUv3 nested mode is not yet implemented
>> and there is no functional VFIO integration without. But
>> keeping the replay call would execute the default implementation
>> of memory_region_iommu_replay and attempt to translate the whole
>> address range, completely stalling qemu. Keeping the MAP/UNMAP
>> notifier registration allows to hit a warning message in the
>> SMMUv3 device that tells the user which VFIO device will not
>> function properly:
>>
>> "qemu-system-aarch64: -device vfio-pci,host=0000:89:00.0: warning:
>> SMMUv3 does not support notification on MAP: device vfio-pci will not
>> function properly"
>>
>> Besides, removing the replay call now allows the guest to boot.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/vfio/common.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index a859298fda..9ea58df67a 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -604,6 +604,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>      if (memory_region_is_iommu(section->mr)) {
>>          VFIOGuestIOMMU *giommu;
>>          IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
>> +        bool nested = false;
>>          int iommu_idx;
>>  
>>          trace_vfio_listener_region_add_iommu(iova, end);
>> @@ -631,8 +632,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>          QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
>>  
>>          memory_region_register_iommu_notifier(section->mr, &giommu->n);
>> -        memory_region_iommu_replay(giommu->iommu, &giommu->n);
>>  
>> +        memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_VFIO_NESTED,
>> +                                     (void *)&nested);
>> +        if (!nested) {
>> +            memory_region_iommu_replay(iommu_mr, &giommu->n);
>> +        }
> 
> For nested, do we need these IOMMU notifiers after all?
> 
> I'm asking because the no-IOMMU case of vfio_listener_region_add()
> seems to suite very well for nested page tables to me.  For example,
> vfio does not need to listen to MAP events any more because we'll
> simply share the guest IOMMU page table to be the 1st level page table
> of the host SMMU IIUC.
We don't need the MAP notifier but we need the UNMAP notifier: when the
guest invalidates an ASID/IOVA we need to propagate this to the physical
IOMMU.

As mentioned in the cover letter, at the moment, I still register both
MAP/UNMAP notifiers as the MAP notifier registration produces an
explicit warning message in the SMMUv3 device. If I remove the
registration we will loose this message. I hope this code is just an
intermediate state towards the actual nested stage support.

  And if we have 2nd page table changes (like
> memory hotplug) then IMHO vfio_listener_region_add() will do this for
> us as well just like when there's no SMMU.

In the current integration, see [RFC v4 20/27] hw/vfio/common: Setup
nested stage mappings (https://patchwork.kernel.org/patch/10962721/) I
use a prereg_listener for stage 2 mappings.
> 
> Another thing is that IOMMU_ATTR_VFIO_NESTED will be the same for all
> the memory regions, so it also seems a bit awkward to make it per
> memory region.  If you see the other real user of this flag (which is
> IOMMU_ATTR_SPAPR_TCE_FD) it's per memory region.

That's correct all SMMUv3 regions will return this value. But what other
API can be used to query IOMMU level attributes?

On the other hand,

Alexey's commit f1334de60b2 ("memory/iommu: Add get_attr()") says:
    This adds get_attr() to IOMMUMemoryRegionClass, like
    iommu_ops::domain_get_attr in the Linux kernel.

and DOMAIN_ATTR_NESTING is part of enum iommu_attr at kernel level.

Thanks

Eric



> 
> Regards,
> 

