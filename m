Received: from eggs.gnu.org ([209.51.188.92]:47655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gyvqr-0002fO-HW
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 04:50:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gyvqq-0003RV-P7
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 04:50:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gyvqq-0003Qi-Ee
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 04:50:08 -0500
Date: Wed, 27 Feb 2019 11:50:00 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190227095000.GB3287@lap1>
References: <20190227085546.23690-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227085546.23690-1-kamalheib1@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/rdma: Fix the error prints in
 create_qp_rings()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamal Heib <kamalheib1@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, Feb 27, 2019 at 10:55:46AM +0200, Kamal Heib wrote:
> The prints should indicate that we are talking about QP and not CQ.
> 
> Fixes: 98d176f8e592 ("hw/rdma: PVRDMA commands and data-path ops")
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  hw/rdma/vmw/pvrdma_cmd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index 21a55e225a61..8bc24e952073 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -374,13 +374,13 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
>  
>      dir = rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
>      if (!dir) {
> -        rdma_error_report("Failed to map to CQ page directory");
> +        rdma_error_report("Failed to map to QP page directory");

I guess it is based on latest patch-set, suggesting to specify it next
time.

>          goto out;
>      }
>  
>      tbl = rdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
>      if (!tbl) {
> -        rdma_error_report("Failed to map to CQ page table");
> +        rdma_error_report("Failed to map to QP page table");
>          goto out;
>      }
>  
> @@ -393,7 +393,7 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
>      sr->ring_state = (struct pvrdma_ring *)
>          rdma_pci_dma_map(pci_dev, tbl[0], TARGET_PAGE_SIZE);
>      if (!sr->ring_state) {
> -        rdma_error_report("Failed to map to CQ ring state");
> +        rdma_error_report("Failed to map to QP ring state");
>          goto out_free_sr_mem;
>      }
>  

Thanks!

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

> -- 
> 2.20.1
> 
> 
