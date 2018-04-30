Received: from eggs.gnu.org ([2001:4830:134:3::10]:58064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD8Y7-0006xG-TI
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD8Y3-0002zd-Sv
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:08:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33878 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fD8Y3-0002zQ-N1
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:08:55 -0400
References: <20180430122404.10741-1-peter.maydell@linaro.org>
	<c1c3c88f-75c6-44f2-684c-d9d179bb128c@redhat.com>
	<CAFEAcA-frhSPZePsQJy8DJTpFX0iFw52ND_VK8Z=hGz-v1A_jA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c90618c-ec1b-7a73-5a76-b98fe5df589a@redhat.com>
Date: Mon, 30 Apr 2018 15:08:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-frhSPZePsQJy8DJTpFX0iFw52ND_VK8Z=hGz-v1A_jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory.h: Improve IOMMU related
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 30/04/2018 14:57, Peter Maydell wrote:
> On 30 April 2018 at 13:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 30/04/2018 14:24, Peter Maydell wrote:
>>> -    /* Set this up to provide customized IOMMU replay function */
>>> +    /* Set this up to provide customized IOMMU replay function.
>>> +     * Optional method.
>>> +     */
>>>      void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);
>>
>> replay is needed if you want to support IOMMU notifiers.  After
>> memory_region_register_iommu_notifier you're only notified about future
>> changes to the mappings; memory_region_iommu_replay calls the replay
>> method so that the IOMMUNotifier is called for each existing mapping.
> 
> Is it then unrelated to record-and-replay ? That's what I guessed
> it was for... Also, some IOMMUs (eg spapr_iommu.c) seem to support
> notifiers but don't implement it.

Yes, it's completely unrelated.  I have no idea why spapr_iommu.c
doesn't need it, so I am CCing the sPAPR and VFIO experts...

Paolo
