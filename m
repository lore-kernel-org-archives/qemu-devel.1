Received: from eggs.gnu.org ([2001:4830:134:3::10]:46305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDLo5-0000Zj-CV
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 23:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDLo4-0007Vj-F8
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 23:18:21 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1525073539-27991-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ba65d189-1963-1134-195f-5aa2f5dcd531@amsat.org>
Date: Tue, 1 May 2018 00:18:01 -0300
MIME-Version: 1.0
In-Reply-To: <1525073539-27991-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] trivial: Do not include pci.h if it is not
 necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>

On 04/30/2018 04:32 AM, Thomas Huth wrote:
> There is no need to include pci.h in these files.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/hw/ppc/ppc4xx.h            | 2 --
>  include/hw/virtio/virtio-balloon.h | 1 -
>  include/hw/virtio/virtio-gpu.h     | 1 -
>  3 files changed, 4 deletions(-)
> 
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index cb0bb55..3a2a04c 100644
> --- a/include/hw/ppc/ppc4xx.h
> +++ b/include/hw/ppc/ppc4xx.h
> @@ -25,8 +25,6 @@
>  #ifndef PPC4XX_H
>  #define PPC4XX_H
>  
> -#include "hw/pci/pci.h"
> -
>  /* PowerPC 4xx core initialization */
>  PowerPCCPU *ppc4xx_init(const char *cpu_model,
>                          clk_setup_t *cpu_clk, clk_setup_t *tb_clk,

"ppc4xx.h" misses various includes...

> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> index 1ea13bd..e0df352 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -17,7 +17,6 @@
>  
>  #include "standard-headers/linux/virtio_balloon.h"
>  #include "hw/virtio/virtio.h"
> -#include "hw/pci/pci.h"
>  
>  #define TYPE_VIRTIO_BALLOON "virtio-balloon-device"
>  #define VIRTIO_BALLOON(obj) \
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 22ac3c2..79bb3fb 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -18,7 +18,6 @@
>  #include "ui/qemu-pixman.h"
>  #include "ui/console.h"
>  #include "hw/virtio/virtio.h"
> -#include "hw/pci/pci.h"
>  #include "qemu/log.h"
>  
>  #include "standard-headers/linux/virtio_gpu.h"
> 

Weirdness of virtio-gpu.h, it uses VIRTIO_PCI_FLAG_USE_IOEVENTFD which
is defined in the local hw/virtio/virtio-pci.h (local = not under include/)

Anyway any of those requires "hw/pci/pci.h", so:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
