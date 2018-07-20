Received: from eggs.gnu.org ([2001:4830:134:3::10]:44470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgRPe-0002eC-Vs
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 05:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgRPa-0000k6-2x
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 05:09:22 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fgRPZ-0000jd-Ma
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 05:09:17 -0400
Received: by mail-oi0-x241.google.com with SMTP id 13-v6so20162296ois.1
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 02:09:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180720083644.1431-1-tiwei.bie@intel.com>
References: <20180720083644.1431-1-tiwei.bie@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jul 2018 10:08:56 +0100
Message-ID: <CAFEAcA_9f9-gW+4JhaKYRRo2eZjR=6O=_0k69KfOGvagDh75gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] vhost: check region type before casting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 20 July 2018 at 09:36, Tiwei Bie <tiwei.bie@intel.com> wrote:
> Check region type first before casting the memory region
> to IOMMUMemoryRegion. Otherwise QEMU will abort with below
> error message when casting non-IOMMU memory region:
>
> vhost_iommu_region_add: Object 0x561f28bce4f0 is not an
> instance of type qemu:iommu-memory-region
>
> Fixes: cb1efcf462a2 ("iommu: Add IOMMU index argument to notifier APIs")
> Cc: Peter Maydell <peter.maydell@linaro.org>
>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
