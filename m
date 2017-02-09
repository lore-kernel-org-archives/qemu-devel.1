Received: from eggs.gnu.org ([2001:4830:134:3::10]:42528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cbssQ-0002Sz-9t
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:51:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cbssP-0001NV-Fv
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:51:26 -0500
Received: from mail-io0-x232.google.com ([2607:f8b0:4001:c06::232]:35961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1cbssP-0001NE-C0
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:51:25 -0500
Received: by mail-io0-x232.google.com with SMTP id j13so22981600iod.3
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 09:51:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486644810-33181-1-git-send-email-agraf@suse.de>
References: <1486644810-33181-1-git-send-email-agraf@suse.de>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 9 Feb 2017 17:51:22 +0000
Message-ID: <CAKv+Gu_jrB4eJiR-j+no3OcHi68wusne5HosVL+Ri_y2Mowe_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 0/4] target-arm: Add some omitted dma
 cache coherency flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>

On 9 February 2017 at 12:53, Alexander Graf <agraf@suse.de> wrote:
> ARM is amazing when it comes to cache coherency and VMs. While any sane
> architecture allows the host to override the guest's caching attributes,
> that's very hard to do on ARM.
>
> That means that the guest may directly access guest memory bypassing the
> cache while QEMU happily writes to / reads from cache. The end result is
> very nasty, because both sides see very different views of the world.
>
> That means that we need to be very cautious to tell guests that devices
> that QEMU emulates are going to use data in the cache rather than directly
> on memory.
>
> We added this to PCI a while back for DT (5d636e21 "hw/arm/virt: mark the PCIe
> host controller as DMA coherent in the DT") and ACPI (bc64b96 "hw/arm/virt-
> acpi-build: _CCA attribute is compulsory") but never updated virtio-mmio or
> fw-cfg in DT or ACPI tables.
>
> This patch set adds the respective cache coherency flags for them in both DT and
> ACPI.
>
> Fortunately, no guests except for Linux 4.9.7 and 4.9.8 are broken because of
> this. Upstream realized quickly enough that every user of virtio-mmio out there
> describes its cache coherency incorrectly and reverted the patch that would
> require said dma coherency flag. But we should be safe for the future and "do
> the right thing".
>
> Alexander Graf (4):
>   target-arm: Declare virtio-mmio as dma-coherent in dt
>   hw/arm/virt: Declare virtio-mmio as dma cache coherent in ACPI
>   hw/arm/virt: Declare fwcfg as dma cache coherent in ACPI
>   hw/arm/virt: Declare fwcfg as dma cache coherent in dt
>

This looks correct to me.

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
