Received: from eggs.gnu.org ([2001:4830:134:3::10]:48828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1folup-0006rq-9g
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 04:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1folum-0003x8-77
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 04:39:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1folul-0003wa-SH
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 04:39:56 -0400
Date: Sun, 12 Aug 2018 11:39:44 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20180812083943.GB3004@lap1>
References: <20180811171534.11917-1-marcel.apfelbaum@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811171534.11917-1-marcel.apfelbaum@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/pvrdma: remove not needed include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On Sat, Aug 11, 2018 at 08:15:34PM +0300, Marcel Apfelbaum wrote:
> No need to include linux/types.h, is empty anyway.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> ---
>  hw/rdma/vmw/pvrdma_cmd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index 14255d609f..3f697c8db7 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -16,7 +16,6 @@
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
>  #include "cpu.h"
> -#include <linux/types.h>
>  #include "hw/hw.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_ids.h"

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

> -- 
> 2.17.1
> 
