Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A276EC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 19:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F58A214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 19:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F58A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsuXT-00056j-RG
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 15:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47197)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hsuWv-0004Wk-6U
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hsuWt-0002vj-VP
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:44:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hsuWn-0002oZ-CZ; Wed, 31 Jul 2019 15:44:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E21DA307CDEA;
 Wed, 31 Jul 2019 19:44:46 +0000 (UTC)
Received: from [10.36.116.49] (ovpn-116-49.ams2.redhat.com [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0E7F5D6B2;
 Wed, 31 Jul 2019 19:44:37 +0000 (UTC)
To: "Michael S. Tsirkin" <mst@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-12-eric.auger@redhat.com>
 <20190730153628-mutt-send-email-mst@kernel.org>
 <AADFC41AFE54684AB9EE6CBC0274A5D19CAF8E1B@SHSMSX104.ccr.corp.intel.com>
 <20190731151834-mutt-send-email-mst@kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <95de34e9-1b1a-3eff-cebb-ee146e9acc78@redhat.com>
Date: Wed, 31 Jul 2019 21:44:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190731151834-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 31 Jul 2019 19:44:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 11/15] virtio-iommu: Expose the
 IOAPIC MSI reserved region when relevant
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "tn@semihalf.com" <tn@semihalf.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 7/31/19 9:25 PM, Michael S. Tsirkin wrote:
> On Tue, Jul 30, 2019 at 11:20:44PM +0000, Tian, Kevin wrote:
>>> From: Michael S. Tsirkin [mailto:mst@redhat.com]
>>> Sent: Wednesday, July 31, 2019 3:38 AM
>>>
>>> On Tue, Jul 30, 2019 at 07:21:33PM +0200, Eric Auger wrote:
>>>> We introduce a new msi_bypass field which indicates whether
>>>> the IOAPIC MSI window [0xFEE00000 - 0xFEEFFFFF] must be exposed
>>
>> it's not good to call it IOAPIC MSI window. any write to this range, either
>> from IOAPIC or PCI device, is interpreted by the platform as interrupt
>> request. I'd call it "x86 interrupt address range".
> 
> Isn't this APIC_DEFAULT_ADDRESS? I'm not sure guests can't change it
> even though I'm not sure qemu supports changing it.

That's indeed matching:

#define APIC_DEFAULT_ADDRESS 0xfee00000
#define APIC_SPACE_SIZE      0x100000

> 
> And if so I'd say integrating IOAPIC defaults into the device itself is
> inelegant.

I agree.

  How about having guest supply the range through config
> space? It's a small change that won't be too late for Linux.

Isn't it a property of the platform instead. I mean isn't it the job of
the machine model to set this. The guest driver is arch agnostic if I am
not wrong.


> 
>>>> as a reserved region. By default the field is set to true at
>>>> instantiation time. Later on we will introduce a property at
>>>> virtio pci proxy level to turn it off.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> ---
>>>>
>>>> v8 -> v9:
>>>> - pass IOAPIC_RANGE_END to virtio_iommu_register_resv_region
>>>> - take into account the change in the struct virtio_iommu_probe_resv_mem
>>>>   definition
>>>> - We just introduce the field here. A property will be introduced later on
>>>>   at pci proxy level.
>>>> ---
>>>>  hw/virtio/virtio-iommu.c         | 36 ++++++++++++++++++++++++++++++++
>>>>  include/hw/virtio/virtio-iommu.h |  1 +
>>>>  2 files changed, 37 insertions(+)
>>>>
>>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>>> index 66be9a4627..74038288b0 100644
>>>> --- a/hw/virtio/virtio-iommu.c
>>>> +++ b/hw/virtio/virtio-iommu.c
>>>> @@ -39,6 +39,9 @@
>>>>  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
>>>>  #define VIOMMU_PROBE_SIZE 512
>>>>
>>>> +#define IOAPIC_RANGE_START      (0xfee00000)
>>>> +#define IOAPIC_RANGE_END        (0xfeefffff)
>>>> +
>>>>  #define SUPPORTED_PROBE_PROPERTIES (\
>>>>      1 << VIRTIO_IOMMU_PROBE_T_RESV_MEM)
>>>>
>>>
>>> Sorry where are these numbers coming from?
>>
>> this is architecturally defined in x86 SDM.
>>
>>> Does this really work on all platforms?
>>
>> x86 only. 
> 
> But you seem to add this code for all platforms:
> 
> 	@@ -6,6 +6,11 @@ config VIRTIO_RNG
> 	     default y
> 	     depends on VIRTIO
> 
> 	+config VIRTIO_IOMMU
> 	+    bool
> 	+    default y
> 	+    depends on VIRTIO
> 	+
Actually it was supposed to be integrated with ARM first and then with x86.

Thanks

Eric
> 
> 
>>> With all guests?
>>
>> yes.
>>
>>>
>>>> @@ -100,6 +103,30 @@ static void
>>> virtio_iommu_detach_endpoint_from_domain(viommu_endpoint *ep)
>>>>      ep->domain = NULL;
>>>>  }
>>>>
>>>> +static void virtio_iommu_register_resv_region(viommu_endpoint *ep,
>>>> +                                              uint8_t subtype,
>>>> +                                              uint64_t start, uint64_t end)
>>>> +{
>>>> +    viommu_interval *interval;
>>>> +    struct virtio_iommu_probe_resv_mem *resv_reg_prop;
>>>> +    size_t prop_size = sizeof(struct virtio_iommu_probe_resv_mem);
>>>> +    size_t value_size = prop_size -
>>>> +                sizeof(struct virtio_iommu_probe_property);
>>>> +
>>>> +    interval = g_malloc0(sizeof(*interval));
>>>> +    interval->low = start;
>>>> +    interval->high = end;
>>>> +
>>>> +    resv_reg_prop = g_malloc0(prop_size);
>>>> +    resv_reg_prop->head.type = VIRTIO_IOMMU_PROBE_T_RESV_MEM;
>>>> +    resv_reg_prop->head.length = cpu_to_le64(value_size);
>>>> +    resv_reg_prop->subtype = cpu_to_le64(subtype);
>>>> +    resv_reg_prop->start = cpu_to_le64(start);
>>>> +    resv_reg_prop->end = cpu_to_le64(end);
>>>> +
>>>> +    g_tree_insert(ep->reserved_regions, interval, resv_reg_prop);
>>>> +}
>>>> +
>>>>  static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
>>>>                                                    uint32_t ep_id)
>>>>  {
>>>> @@ -117,6 +144,12 @@ static viommu_endpoint
>>> *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
>>>>      ep->reserved_regions =
>>> g_tree_new_full((GCompareDataFunc)interval_cmp,
>>>>                                              NULL, (GDestroyNotify)g_free,
>>>>                                              (GDestroyNotify)g_free);
>>>> +    if (s->msi_bypass) {
>>>> +        virtio_iommu_register_resv_region(ep,
>>> VIRTIO_IOMMU_RESV_MEM_T_MSI,
>>>> +                                          IOAPIC_RANGE_START,
>>>> +                                          IOAPIC_RANGE_END);
>>>> +    }
>>>> +
>>>>      return ep;
>>>>  }
>>>>
>>>> @@ -822,6 +855,9 @@ static void virtio_iommu_set_status(VirtIODevice
>>> *vdev, uint8_t status)
>>>>
>>>>  static void virtio_iommu_instance_init(Object *obj)
>>>>  {
>>>> +    VirtIOIOMMU *s = VIRTIO_IOMMU(obj);
>>>> +
>>>> +    s->msi_bypass = true;
>>>>  }
>>>>
>>>>  static const VMStateDescription vmstate_virtio_iommu = {
>>>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-
>>> iommu.h
>>>> index f55f48d304..56c8b4e57f 100644
>>>> --- a/include/hw/virtio/virtio-iommu.h
>>>> +++ b/include/hw/virtio/virtio-iommu.h
>>>> @@ -59,6 +59,7 @@ typedef struct VirtIOIOMMU {
>>>>      GTree *domains;
>>>>      QemuMutex mutex;
>>>>      GTree *endpoints;
>>>> +    bool msi_bypass;
>>>>  } VirtIOIOMMU;
>>>>
>>>>  #endif
>>>> --
>>>> 2.20.1

