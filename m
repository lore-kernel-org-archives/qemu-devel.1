Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7C3C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E8F21926
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E8F21926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqDeP-0004xF-0o
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 05:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47475)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hqDeE-0004Yu-2r
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hqDeC-00007c-Q9
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:33:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51198)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hqDeC-000079-H9
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:33:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8736030860D1;
 Wed, 24 Jul 2019 09:33:18 +0000 (UTC)
Received: from [10.36.116.102] (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C14110018F9;
 Wed, 24 Jul 2019 09:33:08 +0000 (UTC)
To: "Liu, Yi L" <yi.l.liu@intel.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-6-git-send-email-yi.l.liu@intel.com>
 <20190715025519.GE3440@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A00D8BB@SHSMSX104.ccr.corp.intel.com>
 <20190717030640.GG9123@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A0140E0@SHSMSX104.ccr.corp.intel.com>
 <20190723035741.GR25073@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A0160C9@SHSMSX104.ccr.corp.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <abf336b6-4c51-7742-44aa-5b51c8ea4af7@redhat.com>
Date: Wed, 24 Jul 2019 11:33:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A0160C9@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 24 Jul 2019 09:33:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v1 05/18] vfio/pci: add pasid alloc/free
 implementation
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yi, David,

On 7/24/19 6:57 AM, Liu, Yi L wrote:
>> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On Behalf
>> Of David Gibson
>> Sent: Tuesday, July 23, 2019 11:58 AM
>> To: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [RFC v1 05/18] vfio/pci: add pasid alloc/free implementation
>>
>> On Mon, Jul 22, 2019 at 07:02:51AM +0000, Liu, Yi L wrote:
>>>> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org]
>>>> On Behalf Of David Gibson
>>>> Sent: Wednesday, July 17, 2019 11:07 AM
>>>> To: Liu, Yi L <yi.l.liu@intel.com>
>>>> Subject: Re: [RFC v1 05/18] vfio/pci: add pasid alloc/free
>>>> implementation
>>>>
>>>> On Tue, Jul 16, 2019 at 10:25:55AM +0000, Liu, Yi L wrote:
>>>>>> From: kvm-owner@vger.kernel.org
>>>>>> [mailto:kvm-owner@vger.kernel.org] On
>>>> Behalf
>>>>>> Of David Gibson
>>>>>> Sent: Monday, July 15, 2019 10:55 AM
>>>>>> To: Liu, Yi L <yi.l.liu@intel.com>
>>>>>> Subject: Re: [RFC v1 05/18] vfio/pci: add pasid alloc/free
>>>>>> implementation
>>>>>>
>>>>>> On Fri, Jul 05, 2019 at 07:01:38PM +0800, Liu Yi L wrote:
>>>>>>> This patch adds vfio implementation PCIPASIDOps.alloc_pasid/free_pasid().
>>>>>>> These two functions are used to propagate guest pasid
>>>>>>> allocation and free requests to host via vfio container ioctl.
>>>>>>
>>>>>> As I said in an earlier comment, I think doing this on the
>>>>>> device is conceptually incorrect.  I think we need an explcit
>>>>>> notion of an SVM context (i.e. the namespace in which all the
>>>>>> PASIDs live) - which will IIUC usually be shared amongst
>>>>>> multiple devices.  The create and free PASID requests should be on that object.
>>>>>
>>>>> Actually, the allocation is not doing on this device. System wide,
>>>>> it is done on a container. So not sure if it is the API interface
>>>>> gives you a sense that this is done on device.
>>>>
>>>> Sorry, I should have been clearer.  I can see that at the VFIO level
>>>> it is done on the container.  However the function here takes a bus
>>>> and devfn, so this qemu internal interface is per-device, which
>>>> doesn't really make sense.
>>>
>>> Got it. The reason here is to pass the bus and devfn info, so that
>>> VFIO can figure out a container for the operation. So far in QEMU,
>>> there is no good way to connect the vIOMMU emulator and VFIO regards
>>> to SVM.
>>
>> Right, and I think that's an indication that we're not modelling something in qemu
>> that we should be.
>>
>>> hw/pci layer is a choice based on some previous discussion. But yes, I
>>> agree with you that we may need to have an explicit notion for SVM. Do
>>> you think it is good to introduce a new abstract layer for SVM (may
>>> name as SVMContext).
>>
>> I think so, yes.
>>
>> If nothing else, I expect we'll need this concept if we ever want to be able to
>> implement SVM for emulated devices (which could be useful for debugging, even if
>> it's not something you'd do in production).
>>
>>> The idea would be that vIOMMU maintain the SVMContext instances and
>>> expose explicit interface for VFIO to get it. Then VFIO register
>>> notifiers on to the SVMContext. When vIOMMU emulator wants to do PASID
>>> alloc/free, it fires the corresponding notifier. After call into VFIO,
>>> the notifier function itself figure out the container it is bound. In
>>> this way, it's the duty of vIOMMU emulator to figure out a proper
>>> notifier to fire. From interface point of view, it is no longer
>>> per-device.
>>
>> Exactly.
> 
> Cool, let me prepare another version with the ideas. Thanks for your
> review. :-)
> 
> Regards,
> Yi Liu
> 
>>> Also, it leaves the PASID management details to vIOMMU emulator as it
>>> can be vendor specific. Does it make sense?
>>> Also, I'd like to know if you have any other idea on it. That would
>>> surely be helpful. :-)
>>>
>>>>> Also, curious on the SVM context
>>>>> concept, do you mean it a per-VM context or a per-SVM usage context?
>>>>> May you elaborate a little more. :-)
>>>>
>>>> Sorry, I'm struggling to find a good term for this.  By "context" I
>>>> mean a namespace containing a bunch of PASID address spaces, those
>>>> PASIDs are then visible to some group of devices.
>>>
>>> I see. May be the SVMContext instance above can include multiple PASID
>>> address spaces. And again, I think this relationship should be
>>> maintained in vIOMMU emulator.
> 
So if I understand we now head towards introducing new notifiers taking
a "SVMContext" as argument instead of an IOMMUMemoryRegion.

I think we need to be clear about how both abstractions (SVMContext and
IOMMUMemoryRegion) differ. I would also need "SVMContext" abstraction
for 2stage SMMU integration (to notify stage 1 config changes and MSI
bindings) so I would need this new object to be not too much tied to SVM
use case.

Thanks

Eric


