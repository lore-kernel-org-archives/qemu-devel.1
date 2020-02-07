Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BD8C352A3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9DCF21775
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKGlhag9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DCF21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j03qu-0007nI-CK
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 08:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j03q4-0006SP-3m
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:38:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j03q2-0002rL-SG
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:38:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48594
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j03q2-0002r2-Nk
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581082710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/bLjlEOec6Nqi8ftlkNOVAh6ZKWATL3cYdEkNf/0Vg=;
 b=dKGlhag9cWrqs95rb4MYjeEN05hxGCCrKo/neNJiyXFCiTcQ9jqP+S51IIAHqm1UrP1agy
 3aEe11ASZAtunGwAMKKg2iKsMhpBz1HyMhf+Bogu8QPBOdkUN0Ae4EOdgjpyosSSFf2Nfp
 4PkpHuvK7EngBQK5wW1vlU0+iGBectw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-SAK_PBFePpmqaIUMnyoj0A-1; Fri, 07 Feb 2020 08:38:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E89F1800D42;
 Fri,  7 Feb 2020 13:38:27 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF58489F01;
 Fri,  7 Feb 2020 13:38:14 +0000 (UTC)
Subject: Re: [PATCH v14 08/11] virtio-iommu-pci: Introduce the x-dt-binding
 option
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200207093203.3788-1-eric.auger@redhat.com>
 <20200207093203.3788-9-eric.auger@redhat.com>
 <20200207052214-mutt-send-email-mst@kernel.org>
 <25d39300-46b9-571c-6fa6-44c5f8d0be99@redhat.com>
 <20200207065915-mutt-send-email-mst@kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <13aa254e-e300-b0d1-4f8b-4142bca40001@redhat.com>
Date: Fri, 7 Feb 2020 14:38:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200207065915-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: SAK_PBFePpmqaIUMnyoj0A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 2/7/20 1:00 PM, Michael S. Tsirkin wrote:
> On Fri, Feb 07, 2020 at 11:51:55AM +0100, Auger Eric wrote:
>> Hi,
>>
>> On 2/7/20 11:23 AM, Michael S. Tsirkin wrote:
>>> On Fri, Feb 07, 2020 at 10:32:00AM +0100, Eric Auger wrote:
>>>> At the moment, the kernel only supports device tree
>>>> integration of the virtio-iommu. DT bindings between the
>>>> PCI root complex and the IOMMU must be created by the machine
>>>> in conformance to:
>>>>
>>>> Documentation/devicetree/bindings/virtio/iommu.txt.
>>>>
>>>> To make sure the end-user is aware of this, force him to use the
>>>> temporary device option "x-dt-binding" and also double check the
>>>> machine has a hotplug handler for the virtio-iommu-pci device.
>>>> This hotplug handler is in charge of creating those DT bindings.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>>>
>>> how about setting it by default from machine class?
>> Do you mean in ARM virt machine class? But this wouldn't prevent a user
>> from launching an ACPI booted guest. I thought you wanted the end-user
>> to know what he does.
>>
>> I don't figure out a way to know if the guest is booted in dt or acpi
>> mode. I can get access to those info:
>> - whether acpi is enabled
>> - whether a FW is loaded
>>
>> But a FW can be loaded, acpi enabled and eventually the guest is DT
>> booted with acpi=off in kernel opts.
> 
> So let's say this configuration does not support the virtio-iommu
> at the moment. Is that a big deal?
> 
>> Maybe at this point I could only support the case where no FW is loaded.
>> In machvirt I would not register the virtio-iommu-pci hotplug handler in
>> case a FW is loaded. Then I could get rid of the new x-dt-binding prop.
>>
>> Thoughts?
>>
>> Eric
> 
> Also an option.
OK so I will drop the x-dt-binding property and implement this option.

Thanks

Eric
> 
>>> See
>>> [PATCH 1/2] spapr: Disable legacy virtio devices for pseries-5.0 and later
>>> [PATCH 2/2] spapr: Enable virtio iommu_platform=on by default
>>> which does it for spapr.
>>
>>>
>>>> ---
>>>>
>>>> May be squashed with previous patch
>>>> ---
>>>>  hw/virtio/virtio-iommu-pci.c | 18 ++++++++++++++++++
>>>>  1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
>>>> index d539fcce75..3d06e14000 100644
>>>> --- a/hw/virtio/virtio-iommu-pci.c
>>>> +++ b/hw/virtio/virtio-iommu-pci.c
>>>> @@ -14,6 +14,7 @@
>>>>  #include "virtio-pci.h"
>>>>  #include "hw/virtio/virtio-iommu.h"
>>>>  #include "hw/qdev-properties.h"
>>>> +#include "qapi/error.h"
>>>>  
>>>>  typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
>>>>  
>>>> @@ -27,10 +28,12 @@ typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
>>>>  struct VirtIOIOMMUPCI {
>>>>      VirtIOPCIProxy parent_obj;
>>>>      VirtIOIOMMU vdev;
>>>> +    bool dt_binding;
>>>>  };
>>>>  
>>>>  static Property virtio_iommu_pci_properties[] = {
>>>>      DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
>>>> +    DEFINE_PROP_BOOL("x-dt-binding", VirtIOIOMMUPCI, dt_binding, false),
>>>>      DEFINE_PROP_END_OF_LIST(),
>>>>  };
>>>>  
>>>> @@ -39,6 +42,21 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>>>>      VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(vpci_dev);
>>>>      DeviceState *vdev = DEVICE(&dev->vdev);
>>>>  
>>>> +    if (!dev->dt_binding) {
>>>> +        error_setg(errp,
>>>> +                   "Instantiation currently only is possible if the machine "
>>>> +                   "creates device tree iommu-map bindings, ie. ACPI is not "
>>>> +                   "yet supported");
>>>> +        error_append_hint(errp, "use -virtio-iommu-pci,x-dt-binding\n");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (!qdev_get_machine_hotplug_handler(DEVICE(vpci_dev))) {
>>>> +        error_setg(errp,
>>>> +                   "The machine does not implement a virtio-iommu-pci hotplug "
>>>> +                   " handler that creates the device tree iommu-map bindings");
>>>> +       return;
>>>> +    }
>>>>      qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
>>>>      object_property_set_link(OBJECT(dev),
>>>>                               OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
>>>> -- 
>>>> 2.20.1
>>>
> 
> 


