Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC03C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA41F2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA41F2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmVg-0003yq-6V
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46193)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hbmRU-0001Wo-7m
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hbmRS-0005hA-SP
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:40:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hbmRQ-0005aD-1V; Fri, 14 Jun 2019 09:40:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0DD63316290D;
 Fri, 14 Jun 2019 13:40:22 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A732F1001B1A;
 Fri, 14 Jun 2019 13:40:17 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190611142821.3874-1-eric.auger@redhat.com>
 <20190611142821.3874-3-eric.auger@redhat.com>
 <CAFEAcA_OYdL1TPN+OTdkZ0J2fx_4vFiXCs0fUVdGjkkMURCfZA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ef87a46b-06fc-a66d-37ca-4499afc76663@redhat.com>
Date: Fri, 14 Jun 2019 15:40:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_OYdL1TPN+OTdkZ0J2fx_4vFiXCs0fUVdGjkkMURCfZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 14 Jun 2019 13:40:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/smmuv3: Implement dummy replay
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 6/14/19 3:26 PM, Peter Maydell wrote:
> On Tue, 11 Jun 2019 at 15:29, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> On ARM we currently do not support VFIO-PCI devices protected
>> by the IOMMU. Any attempt to run such use case results in this
>> kind of warning:
>>
>> "-device vfio-pci,host=0004:01:00.0,id=hostdev0,bus=pci.1,addr=0x0:
>> warning: SMMUv3 does not support notification on MAP: device vfio-pci
>> will not function properly".
>>
>> However this is just a warning and this should not prevent the
>> guest from booting in a reasonable amount of time. This does not
>> happen currently.
>>
>> This is due to the fact the VFIO vfio_listener_region_add() calls
>> memory_region_iommu_replay(). As the SMMUv3 IOMMUMemoryRegionClass
>> currently does not implement the replay() callback, the default
>> memory_region_iommu_replay() implementation is used. This latter
>> loops on the whole notifier's range (48b address space), translates
>> each page and call the notifier on the resulting entry. This totally
>> freezes the guest.
>>
>> The Intel IOMMU implements the replay() function which only
>> notifies valid page table entries.
>>
>> In the looming SMMUv3 nested stage VFIO integration, there will be
>> no need to replay() anything as there will not be any shadow page
>> tables: the stage 1 page tables are owned by the guest.
>>
>> So let's implement a void replay() which satisfies both cases.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/smmuv3.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index e2f07d2864..1f578365ef 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1489,6 +1489,11 @@ static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
>>      }
>>  }
>>
>> +static inline void
>> +smmuv3_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>> +{
>> +}
> 
> This doesn't seem like a valid implementation of the replay
> method to me. The API doc comment says
>      * The default implementation of memory_region_iommu_replay() is to
>      * call the IOMMU translate method for every page in the address space
>      * with flag == IOMMU_NONE and then call the notifier if translate
>      * returns a valid mapping. If this method is implemented then it
>      * overrides the default behaviour, and must provide the full semantics
>      * of memory_region_iommu_replay(), by calling @notifier for every
>      * translation present in the IOMMU.
> 
> This empty function is definitely not going to call the notifier
> for every IOMMU translation...
The situation is a bit odd. SMMUv3 is not integrated with VFIO so VFIO
devices will not work anyway (we are not able to notify on MAP). There
is a warning already reporting the issue. However the default
implementation of memory_region_iommu_replay() prevents the guest from
booting. So what would you advise?

Thanks

Eric
> 
> thanks
> -- PMM
> 

