Received: from eggs.gnu.org ([2001:4830:134:3::10]:36084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD8xy-0006CM-CR
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD8xx-0006yA-JC
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:35:42 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:43449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fD8xx-0006y4-E1
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:35:41 -0400
Received: by mail-ot0-x242.google.com with SMTP id y10-v6so9436304otg.10
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 06:35:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6c90618c-ec1b-7a73-5a76-b98fe5df589a@redhat.com>
References: <20180430122404.10741-1-peter.maydell@linaro.org>
	<c1c3c88f-75c6-44f2-684c-d9d179bb128c@redhat.com>
	<CAFEAcA-frhSPZePsQJy8DJTpFX0iFw52ND_VK8Z=hGz-v1A_jA@mail.gmail.com>
	<6c90618c-ec1b-7a73-5a76-b98fe5df589a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 14:35:20 +0100
Message-ID: <CAFEAcA9R5Ycq0aT3pCe1mdrmqAM2dVUjJ=MSJuN5+a+crvxzMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 30 April 2018 at 14:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 30/04/2018 14:57, Peter Maydell wrote:
>> On 30 April 2018 at 13:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> On 30/04/2018 14:24, Peter Maydell wrote:
>>>> -    /* Set this up to provide customized IOMMU replay function */
>>>> +    /* Set this up to provide customized IOMMU replay function.
>>>> +     * Optional method.
>>>> +     */
>>>>      void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);
>>>
>>> replay is needed if you want to support IOMMU notifiers.  After
>>> memory_region_register_iommu_notifier you're only notified about future
>>> changes to the mappings; memory_region_iommu_replay calls the replay
>>> method so that the IOMMUNotifier is called for each existing mapping.
>>
>> Is it then unrelated to record-and-replay ? That's what I guessed
>> it was for... Also, some IOMMUs (eg spapr_iommu.c) seem to support
>> notifiers but don't implement it.
>
> Yes, it's completely unrelated.  I have no idea why spapr_iommu.c
> doesn't need it, so I am CCing the sPAPR and VFIO experts...

There does seem to be a default implementation in
memory_region_iommu_replay(), maybe that is sufficient for spapr?

thanks
-- PMM
