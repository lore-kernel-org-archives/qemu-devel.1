Received: from eggs.gnu.org ([2001:4830:134:3::10]:36169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2aCW-0002IU-L8
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2aCV-0001Nt-NZ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:54:48 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:56097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2aCV-0001NH-GY
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:54:47 -0400
Received: by mail-wm0-x232.google.com with SMTP id u138so11790492wmu.4
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 02:54:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f3a263b7-27e6-26df-592d-a34902bab6fe@redhat.com>
References: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-0MK18DakmNPRXCNYbDpBvzE0h12nNjg7zr+F_m0EnDw@mail.gmail.com>
	<f3a263b7-27e6-26df-592d-a34902bab6fe@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 10:54:25 +0100
Message-ID: <CAFEAcA_2RaRsvm_=V4iDNk_vMOtiWUZs3-SdMh+DSYqGyPE0PQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v4 00/16] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Wei Huang <wei@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, Andrew Jones <drjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, jean-philippe.brucker@arm.com, Tomasz Nowicki <tn@semihalf.com>, Will Deacon <will.deacon@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, linuc.decode@gmail.com, Bharat Bhushan <bharat.bhushan@nxp.com>, Christoffer Dall <christoffer.dall@linaro.org>, eric.auger.pro@gmail.com

On 11 October 2017 at 17:08, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
>
> On 11/10/2017 16:56, Peter Maydell wrote:
>> On 19 September 2017 at 08:46, Eric Auger <eric.auger@redhat.com> wrote:
>>> This series implements the virtio-iommu device.
>>>
>>> This v4 is an upgrade to v0.4 spec [1] and applies on QEMU v2.10.0.
>>> - probe request support although no reserved region is returned at
>>>   the moment
>>> - unmap semantics less strict, as specified in v0.4
>>> - device registration, attach/detach revisited
>>> - split into smaller patches to ease review
>>> - propose a way to inform the IOMMU mr about the page_size_mask
>>>   of underlying HW IOMMU, if any
>>> - remove warning associated with the translation of the MSI doorbell
>>>
>>> The device gets instantiated using the "-device virtio-iommu-device"
>>> option. It currently works with ARM virt machine only, as the machine
>>> must handle the dt binding between the virtio-mmio "iommu" node and
>>> the PCI host bridge node.
>>
>> Could this work on x86, or is it inherently arm-only?
>
> Yes this is the goal. At the moment the ACPI probing is not yet properly
> specified but a Q35 prototype was developed in the Red Hat Virt team.
> This will be presented at the KVM forum.

Since I have very little familiarity with virtio or iommu code,
I'd be much happier if this was reviewed as a generic virtio-iommu
by the x86/virtio devs and then the arm specific parts done second...

I'm also not clear on what we're expecting the recommended or normal
way to do device passthrough is going to be -- this virtio-mmio,
or presenting the guest with an SMMUv3 interface? Do we really
need to implement both ?

thanks
-- PMM
