Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DC5C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D2D5233A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2D5233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0orD-0006Tz-5q
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 11:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i0onZ-00053v-HK
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i0onY-0006ER-EJ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:14:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7981)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i0onS-00066O-77; Thu, 22 Aug 2019 11:14:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF9ED10F23E2;
 Thu, 22 Aug 2019 15:14:40 +0000 (UTC)
Received: from [10.36.116.105] (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F3E660925;
 Thu, 22 Aug 2019 15:14:34 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190711061857.13086-1-eric.auger@redhat.com>
 <20190711061857.13086-4-eric.auger@redhat.com>
 <CAFEAcA_=Rz5f8RvZU7kjKXhM5sHKFDujoMRTuzanrauP3ChPVA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <778a20c0-7e59-7936-80d2-e245a948c00c@redhat.com>
Date: Thu, 22 Aug 2019 17:14:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_=Rz5f8RvZU7kjKXhM5sHKFDujoMRTuzanrauP3ChPVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 22 Aug 2019 15:14:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v3 3/5] hw/vfio/common: Assert in
 case of nested mode
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,
On 8/5/19 4:41 PM, Peter Maydell wrote:
> On Thu, 11 Jul 2019 at 07:19, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> As of today, VFIO only works along with vIOMMU supporting
>> caching mode. The SMMUv3 does not support this mode and
>> requires HW nested paging to work properly with VFIO.
>>
>> So any attempt to run a VFIO device protected by such IOMMU
>> would prevent the assigned device from working and at the
>> moment the guest does not even boot as the default
>> memory_region_iommu_replay() implementation attempts to
>> translate the whole address space and completely stalls
>> the execution.
>>
>> So let's assert if we recognize nested mode case.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/vfio/common.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index a859298fda..d622191fe6 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -604,9 +604,17 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>      if (memory_region_is_iommu(section->mr)) {
>>          VFIOGuestIOMMU *giommu;
>>          IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
>> +        bool nested;
>>          int iommu_idx;
>>
>>          trace_vfio_listener_region_add_iommu(iova, end);
>> +
>> +        if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_VFIO_NESTED,
>> +                                          (void *)&nested) && nested) {
>> +            error_report("VFIO/vIOMMU integration based on HW nested paging "
>> +                         "is not yet supported");
>> +            abort();
>> +        }
>>          /*
>>           * FIXME: For VFIO iommu types which have KVM acceleration to
>>           * avoid bouncing all map/unmaps through qemu this way, this
> 
> Other failure paths in this function mostly seem to do an
> error_report() and return (apart from the one call to hw_error()
> at the bottom of the function). Is an abort() OK here?

Yes I should rather jump to the fail label instead.

Thanks!

Eric
> 
> thanks
> -- PMM
> 

