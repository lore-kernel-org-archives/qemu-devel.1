Received: from eggs.gnu.org ([2001:4830:134:3::10]:55202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD8Nn-00042U-Nl
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD8Nn-00066g-3Q
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:58:19 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:37255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fD8Nm-00066U-U4
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:58:19 -0400
Received: by mail-oi0-x229.google.com with SMTP id f63-v6so7295527oic.4
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 05:58:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c1c3c88f-75c6-44f2-684c-d9d179bb128c@redhat.com>
References: <20180430122404.10741-1-peter.maydell@linaro.org>
	<c1c3c88f-75c6-44f2-684c-d9d179bb128c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 13:57:57 +0100
Message-ID: <CAFEAcA-frhSPZePsQJy8DJTpFX0iFw52ND_VK8Z=hGz-v1A_jA@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 30 April 2018 at 13:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 30/04/2018 14:24, Peter Maydell wrote:
>> -    /* Set this up to provide customized IOMMU replay function */
>> +    /* Set this up to provide customized IOMMU replay function.
>> +     * Optional method.
>> +     */
>>      void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);
>
> replay is needed if you want to support IOMMU notifiers.  After
> memory_region_register_iommu_notifier you're only notified about future
> changes to the mappings; memory_region_iommu_replay calls the replay
> method so that the IOMMUNotifier is called for each existing mapping.

Is it then unrelated to record-and-replay ? That's what I guessed
it was for... Also, some IOMMUs (eg spapr_iommu.c) seem to support
notifiers but don't implement it.

thanks
-- PMM
