Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F6BC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7CE21537
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7CE21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52286 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbnYq-0001dL-1X
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56067)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hbmts-0008Tu-IC
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hbmtr-0003yP-Gt
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:09:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23046)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hbmtn-0003ui-Vs; Fri, 14 Jun 2019 10:09:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6BDDD3082A8F;
 Fri, 14 Jun 2019 14:09:44 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F7D019700;
 Fri, 14 Jun 2019 14:09:40 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190611142821.3874-1-eric.auger@redhat.com>
 <20190611142821.3874-3-eric.auger@redhat.com>
 <CAFEAcA_OYdL1TPN+OTdkZ0J2fx_4vFiXCs0fUVdGjkkMURCfZA@mail.gmail.com>
 <ef87a46b-06fc-a66d-37ca-4499afc76663@redhat.com>
 <CAFEAcA-Zo_qSsRfjrr-ewRU5ozc083Lw_vxaR1DufVOmtw5mdA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <51a91dd1-1eab-afc5-a5c9-77a3f189f41f@redhat.com>
Date: Fri, 14 Jun 2019 16:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Zo_qSsRfjrr-ewRU5ozc083Lw_vxaR1DufVOmtw5mdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 14 Jun 2019 14:09:44 +0000 (UTC)
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

On 6/14/19 3:45 PM, Peter Maydell wrote:
> On Fri, 14 Jun 2019 at 14:40, Auger Eric <eric.auger@redhat.com> wrote:
>>
>> Hi Peter,
>>
>> On 6/14/19 3:26 PM, Peter Maydell wrote:
>>> On Tue, 11 Jun 2019 at 15:29, Eric Auger <eric.auger@redhat.com> wrote:
>>>>
>>>> On ARM we currently do not support VFIO-PCI devices protected
>>>> by the IOMMU. Any attempt to run such use case results in this
>>>> kind of warning:
>>>>
>>>> "-device vfio-pci,host=0004:01:00.0,id=hostdev0,bus=pci.1,addr=0x0:
>>>> warning: SMMUv3 does not support notification on MAP: device vfio-pci
>>>> will not function properly".
> 
>>>> +static inline void
>>>> +smmuv3_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>>>> +{
>>>> +}
>>>
>>> This doesn't seem like a valid implementation of the replay
>>> method to me. The API doc comment says
>>>      * The default implementation of memory_region_iommu_replay() is to
>>>      * call the IOMMU translate method for every page in the address space
>>>      * with flag == IOMMU_NONE and then call the notifier if translate
>>>      * returns a valid mapping. If this method is implemented then it
>>>      * overrides the default behaviour, and must provide the full semantics
>>>      * of memory_region_iommu_replay(), by calling @notifier for every
>>>      * translation present in the IOMMU.
>>>
>>> This empty function is definitely not going to call the notifier
>>> for every IOMMU translation...
>> The situation is a bit odd. SMMUv3 is not integrated with VFIO so VFIO
>> devices will not work anyway (we are not able to notify on MAP). There
>> is a warning already reporting the issue. However the default
>> implementation of memory_region_iommu_replay() prevents the guest from
>> booting. So what would you advise?
> 
> I dunno, but if the API isn't supposed to behave the way we've
> documented it to, we should fix the documentation...

fair enough

 Since
> the only user of memory_region_iommu_replay() is the vfio code
> I guess we can define it however is most convenient for vfio,
> but we should document what the method has to do to make things
> work.

OK I need to think about it. Maybe an alternative is to call
memory_region_iommu_replay() only when it makes sense.
> 
> PS: we have a memory_region_iommu_replay_all() which currently
> appears to be not used by anybody, could we get rid of it?

I will do that

Thanks

Eric
> 
> thanks
> -- PMM
> 

