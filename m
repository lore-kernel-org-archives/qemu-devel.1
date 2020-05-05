Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C05DC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 12:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB70C206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 12:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvCyi5ey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB70C206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVwLW-00057F-1e
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 08:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jVwKL-0003wY-EQ
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:05:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28399
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jVwKJ-0006zY-Bi
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588680330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fCYeWJjfd/VutuZB7tg290Zt5ViMwrt/cMXn33FSDyg=;
 b=ZvCyi5ey5jFqUxDp65/03vuorRJOAfc/+b0azX8cqG7IRxjlebNOhX4JGgChHndQoiIaW3
 Q+v/iLgpBllSyPYqwfmp6VH0Arj1clR1aAjyE+JAU5rV0WNjYrpiI3ECcemqg3pxgbJfh7
 CBPyyassOQq7fCH6r+tEzV8FcJUUVmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-ZWHPEPD1NLuKqSs9Xf7rhg-1; Tue, 05 May 2020 08:05:25 -0400
X-MC-Unique: ZWHPEPD1NLuKqSs9Xf7rhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ED1684B8A2;
 Tue,  5 May 2020 12:05:23 +0000 (UTC)
Received: from [10.36.114.214] (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FB2F7054B;
 Tue,  5 May 2020 12:05:08 +0000 (UTC)
Subject: Re: [EXT] Re: [PATCH v9 1/9] hw/vfio/common: Remove error print on
 mmio region translation by viommu
To: Bharat Bhushan <bharatb.linux@gmail.com>
References: <20200323084617.1782-1-bbhushan2@marvell.com>
 <20200323084617.1782-2-bbhushan2@marvell.com>
 <20200323170835.5021f845@w520.home>
 <8ec6af3c-6bd7-a3dc-c531-16db6b2089c5@redhat.com>
 <20200326115318.094ab79a@x1.home>
 <MWHPR1801MB196612966851882A99A6D3F3E3C60@MWHPR1801MB1966.namprd18.prod.outlook.com>
 <72e3ea5c-c98c-3e02-26d1-b956ee81e30f@redhat.com>
 <CAAeCc_nnE2FBo2wW+NkJX-vOP3FF_wSvLg0KngND4HhFUAGf9Q@mail.gmail.com>
 <987c2781-ce4d-9c6a-eae6-ac53fdc581c0@redhat.com>
 <CAAeCc_m_+13YxByDQPU1VNFCNp2hhUWjMRc5LTC6CdvOm0q6Zw@mail.gmail.com>
 <CAAeCc_mLcgO3bPYnx5+265SVAcEL-2tw0AfojqNmyQyLjaKjVg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5a5f423b-88f0-1295-a107-025e5269fbc9@redhat.com>
Date: Tue, 5 May 2020 14:05:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAAeCc_mLcgO3bPYnx5+265SVAcEL-2tw0AfojqNmyQyLjaKjVg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "yang.zhong@intel.com" <yang.zhong@intel.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "Tomasz Nowicki \[C\]" <tnowicki@marvell.com>,
 "mst@redhat.com" <mst@redhat.com>, "drjones@redhat.com" <drjones@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "linuc.decode@gmail.com" <linuc.decode@gmail.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bharat,

On 5/5/20 12:18 PM, Bharat Bhushan wrote:
> Hi Eric,
> 
> On Tue, May 5, 2020 at 3:16 PM Bharat Bhushan <bharatb.linux@gmail.com> wrote:
>>
>> hi Eric,
>>
>> On Tue, May 5, 2020 at 3:00 PM Auger Eric <eric.auger@redhat.com> wrote:
>>>
>>> Hi Bharat,
>>>
>>> On 5/5/20 11:25 AM, Bharat Bhushan wrote:
>>>> Hi Eric,
>>>>
>>>> On Fri, Apr 24, 2020 at 7:47 PM Auger Eric <eric.auger@redhat.com> wrote:
>>>>>
>>>>> Hi Bharat,
>>>>>
>>>>> On 4/2/20 11:01 AM, Bharat Bhushan wrote:
>>>>>> Hi Eric/Alex,
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Alex Williamson <alex.williamson@redhat.com>
>>>>>>> Sent: Thursday, March 26, 2020 11:23 PM
>>>>>>> To: Auger Eric <eric.auger@redhat.com>
>>>>>>> Cc: Bharat Bhushan <bbhushan2@marvell.com>; peter.maydell@linaro.org;
>>>>>>> peterx@redhat.com; eric.auger.pro@gmail.com; kevin.tian@intel.com;
>>>>>>> mst@redhat.com; Tomasz Nowicki [C] <tnowicki@marvell.com>;
>>>>>>> drjones@redhat.com; linuc.decode@gmail.com; qemu-devel@nongnu.org; qemu-
>>>>>>> arm@nongnu.org; bharatb.linux@gmail.com; jean-philippe@linaro.org;
>>>>>>> yang.zhong@intel.com; David Gibson <david@gibson.dropbear.id.au>
>>>>>>> Subject: [EXT] Re: [PATCH v9 1/9] hw/vfio/common: Remove error print on mmio
>>>>>>> region translation by viommu
>>>>>>>
>>>>>>> External Email
>>>>>>>
>>>>>>> ----------------------------------------------------------------------
>>>>>>> On Thu, 26 Mar 2020 18:35:48 +0100
>>>>>>> Auger Eric <eric.auger@redhat.com> wrote:
>>>>>>>
>>>>>>>> Hi Alex,
>>>>>>>>
>>>>>>>> On 3/24/20 12:08 AM, Alex Williamson wrote:
>>>>>>>>> [Cc +dwg who originated this warning]
>>>>>>>>>
>>>>>>>>> On Mon, 23 Mar 2020 14:16:09 +0530
>>>>>>>>> Bharat Bhushan <bbhushan2@marvell.com> wrote:
>>>>>>>>>
>>>>>>>>>> On ARM, the MSI doorbell is translated by the virtual IOMMU.
>>>>>>>>>> As such address_space_translate() returns the MSI controller MMIO
>>>>>>>>>> region and we get an "iommu map to non memory area"
>>>>>>>>>> message. Let's remove this latter.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>>>> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>>>>>>>>>> ---
>>>>>>>>>>  hw/vfio/common.c | 2 --
>>>>>>>>>>  1 file changed, 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c index
>>>>>>>>>> 5ca11488d6..c586edf47a 100644
>>>>>>>>>> --- a/hw/vfio/common.c
>>>>>>>>>> +++ b/hw/vfio/common.c
>>>>>>>>>> @@ -426,8 +426,6 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb,
>>>>>>> void **vaddr,
>>>>>>>>>>                                   &xlat, &len, writable,
>>>>>>>>>>                                   MEMTXATTRS_UNSPECIFIED);
>>>>>>>>>>      if (!memory_region_is_ram(mr)) {
>>>>>>>>>> -        error_report("iommu map to non memory area %"HWADDR_PRIx"",
>>>>>>>>>> -                     xlat);
>>>>>>>>>>          return false;
>>>>>>>>>>      }
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I'm a bit confused here, I think we need more justification beyond
>>>>>>>>> "we hit this warning and we don't want to because it's ok in this
>>>>>>>>> one special case, therefore remove it".  I assume the special case
>>>>>>>>> is that the device MSI address is managed via the SET_IRQS ioctl and
>>>>>>>>> therefore we won't actually get DMAs to this range.
>>>>>>>> Yes exactly. The guest creates a mapping between one giova and this
>>>>>>>> gpa (corresponding to the MSI controller doorbell) because MSIs are
>>>>>>>> mapped on ARM. But practically the physical device is programmed with
>>>>>>>> an host chosen iova that maps onto the physical MSI controller's
>>>>>>>> doorbell. so the device never performs DMA accesses to this range.
>>>>>>>>
>>>>>>>>   But I imagine the case that
>>>>>>>>> was in mind when adding this warning was general peer-to-peer
>>>>>>>>> between and assigned and emulated device.
>>>>>>>> yes makes sense.
>>>>>>>>
>>>>>>>>   Maybe there's an argument to be made
>>>>>>>>> that such a p2p mapping might also be used in a non-vIOMMU case.  We
>>>>>>>>> skip creating those mappings and drivers continue to work, maybe
>>>>>>>>> because nobody attempts to do p2p DMA with the types of devices we
>>>>>>>>> emulate, maybe because p2p DMA is not absolutely reliable on bare
>>>>>>>>> metal and drivers test it before using it.
>>>>>>>> MSI doorbells are mapped using the IOMMU_MMIO flag (dma-iommu.c
>>>>>>>> iommu_dma_get_msi_page).
>>>>>>>> One idea could be to pass that flag through the IOMMU Notifier
>>>>>>>> mechanism into the iotlb->perm. Eventually when we get this in
>>>>>>>> vfio_get_vaddr() we would not print the warning. Could that make sense?
>>>>>>>
>>>>>>> Yeah, if we can identify a valid case that doesn't need a warning, that's fine by me.
>>>>>>> Thanks,
>>>>>>
>>>>>> Let me know if I understood the proposal correctly:
>>>>>>
>>>>>> virtio-iommu driver in guest will make map (VIRTIO_IOMMU_T_MAP) with VIRTIO_IOMMU_MAP_F_MMIO flag for MSI mapping.
>>>>>> In qemu, virtio-iommu device will set a new defined flag (say IOMMU_MMIO) in iotlb->perm in memory_region_notify_iommu(). vfio_get_vaddr() will check same flag and will not print the warning.>
>>>>>> Is above correct?
>>>>> Yes that's what I had in mind.
>>>>
>>>> In that case virtio-iommu driver in guest should not make map
>>>> (VIRTIO_IOMMU_T_MAP) call as it known nothing to be mapped.
>>> sorry I don't catch what you meant. Please can you elaborate?
>>
>> What I understood of the proposal is:
>> Linux:
>>  1) MSI doorbells are mapped using the IOMMU_MMIO flag (dma-iommu.c
>> iommu_dma_get_msi_page)
>>  2) virtio-iommu driver in guest will make map (VIRTIO_IOMMU_T_MAP)
>> with VIRTIO_IOMMU_MAP_F_MMIO flag for MSI mapping.
>>
>> GEMU:
>> 3) virtio-iommu device - If VIRTIO_IOMMU_MAP_F_MMIO flag set then will
>> set a new defined flag (say IOMMU_MMIO) in iotlb->perm in
>> memory_region_notify_iommu()
>> 4. vfio_get_vaddr() will check same flag and will not print the
>> warning. Also vfio_iommu_map_notify() will not do anything.
>>
>> So, rather than going down to step 3 and 4, can we avoid maling map()
>> calling in step-2 itself?
> 
> ohh, We need to setup msi translation mapping, correct.
The virtio-iommu driver is supposed to obey the map() operation argument
and cascade this to the device. I don't see why it would filter this out.

Now we should have means to declare the vITS GPA as an HW MSI reserved
region and avoid calling the map(). I will try this out.

Thanks

Eric

> 
> Thanks
> -Bharat
> 
>>
>> Thanks
>> -Bharat
>>
>>>
>>> Thanks
>>>
>>> Eric
>>>>
>>>> Stay Safe
>>>>
>>>> Thanks
>>>> -Bharat
>>>>
>>>>>
>>>>> Thanks
>>>>>
>>>>> Eric
>>>>>>
>>>>>> Thanks
>>>>>> -Bharat
>>>>>>
>>>>>>>
>>>>>>> Alex
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
> 


