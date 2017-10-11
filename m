Received: from eggs.gnu.org ([2001:4830:134:3::10]:56724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2IRl-00031Q-Kt
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2IRk-0007tE-RE
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:57:21 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:50520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2IRk-0007sI-L1
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:57:20 -0400
Received: by mail-wm0-x236.google.com with SMTP id u138so5524195wmu.5
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 07:57:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
References: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Oct 2017 15:56:59 +0100
Message-ID: <CAFEAcA-0MK18DakmNPRXCNYbDpBvzE0h12nNjg7zr+F_m0EnDw@mail.gmail.com>
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
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, jean-philippe.brucker@arm.com, Will Deacon <will.deacon@arm.com>, "Tian, Kevin" <kevin.tian@intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Peter Xu <peterx@redhat.com>, linuc.decode@gmail.com

On 19 September 2017 at 08:46, Eric Auger <eric.auger@redhat.com> wrote:
> This series implements the virtio-iommu device.
>
> This v4 is an upgrade to v0.4 spec [1] and applies on QEMU v2.10.0.
> - probe request support although no reserved region is returned at
>   the moment
> - unmap semantics less strict, as specified in v0.4
> - device registration, attach/detach revisited
> - split into smaller patches to ease review
> - propose a way to inform the IOMMU mr about the page_size_mask
>   of underlying HW IOMMU, if any
> - remove warning associated with the translation of the MSI doorbell
>
> The device gets instantiated using the "-device virtio-iommu-device"
> option. It currently works with ARM virt machine only, as the machine
> must handle the dt binding between the virtio-mmio "iommu" node and
> the PCI host bridge node.

Could this work on x86, or is it inherently arm-only?

thanks
-- PMM
