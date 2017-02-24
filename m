Received: from eggs.gnu.org ([2001:4830:134:3::10]:50510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1chIvQ-0003mT-98
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1chIvN-0001Jc-Gy
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:40:56 -0500
Date: Fri, 24 Feb 2017 18:40:41 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170224183952-mutt-send-email-mst@kernel.org>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
	<983a6cd6c33f273c0bcb7cb6632a8c23626d9fda.1487829585.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983a6cd6c33f273c0bcb7cb6632a8c23626d9fda.1487829585.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 04/12] Move virtio_mmio.h to fix
 update-linux-headers.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sjitindarsingh@gmail.com, david@gibson.dropbear.id.au

On Thu, Feb 23, 2017 at 04:59:57PM +1100, Sam Bobroff wrote:
> Currently, running update-linux-headers.sh will produce a patch that
> deletes virtio_mmio.h, which is still needed. This happens because
> virtio_mmio.h is in the directory used to store headers from the linux
> kernel that are copied by the kernel's "make headers_install" target
> (used by the update script) but it is not one of the files in that
> set.
> 
> Fix this by moving that file into a new directory.
> 
> In the future if that file is added to the "headers_install" target
> then this change should be reverted.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

This is a temporary condition. I'm merging a patch
exporting virtio_mmio.h for next linux and we'll
want to stay in sync, so I don't think we should make this
change.

> ---
> v2:
> * FWIW, here's one way of fixing it.
> 
>  hw/virtio/virtio-mmio.c                                          | 2 +-
>  include/{standard-headers => kernel-headers}/linux/virtio_mmio.h | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename include/{standard-headers => kernel-headers}/linux/virtio_mmio.h (100%)
> 
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 5807aa87fe..cc6afa9da1 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -20,7 +20,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "standard-headers/linux/virtio_mmio.h"
> +#include "kernel-headers/linux/virtio_mmio.h"
>  #include "hw/sysbus.h"
>  #include "hw/virtio/virtio.h"
>  #include "qemu/host-utils.h"
> diff --git a/include/standard-headers/linux/virtio_mmio.h b/include/kernel-headers/linux/virtio_mmio.h
> similarity index 100%
> rename from include/standard-headers/linux/virtio_mmio.h
> rename to include/kernel-headers/linux/virtio_mmio.h
> -- 
> 2.11.0
> 
