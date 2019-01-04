Received: from eggs.gnu.org ([208.118.235.92]:56158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfVYf-0007oO-TG
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfVYb-0007N0-76
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:55:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gfVYa-0007LK-Cv
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:55:00 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-22-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <71bf251a-461e-8967-8b92-1bbca638f6a9@redhat.com>
Date: Fri, 4 Jan 2019 20:54:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-22-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 21/25] virtio: make virtio dependencies
 with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org

On 2018-12-27 07:34, Yang Zhong wrote:
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/i386-softmmu.mak |  1 -
>  hw/9pfs/Kconfig                  |  2 ++
>  hw/block/Kconfig                 |  2 ++
>  hw/char/Kconfig                  |  2 ++
>  hw/display/Kconfig               |  5 +++++
>  hw/input/Kconfig                 |  2 ++
>  hw/net/Kconfig                   |  2 ++
>  hw/pci-host/Kconfig              |  2 ++
>  hw/virtio/Kconfig                | 10 +++++++++-
>  9 files changed, 26 insertions(+), 2 deletions(-)

Shouldn't this patch also get rid of default-configs/virtio.mak ?

[...]
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index aabd6d4d96..9127daed5e 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -3,18 +3,26 @@ config VIRTIO
>  
>  config VIRTIO_RNG
>      bool
> +    default y
> +    depends on VIRTIO
>  
>  config VIRTIO_PCI
>      bool
>      default y
>      depends on PCI
> -    select VIRTIO
> +    depends on VIRTIO
>  
>  config VIRTIO_MMIO
>      bool
> +    default y
> +    depends on VIRTIO

I don't think we should enable VIRTIO_MMIO by default - it's only used
on arm and riscv, but not on x86 and the other architectures.

>  config VIRTIO_BALLOON
>      bool
> +    default y
> +    depends on VIRTIO
>  
>  config VIRTIO_CRYPTO
>      bool
> +    default y
> +    depends on VIRTIO
> 

 Thomas
