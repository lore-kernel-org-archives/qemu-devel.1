Received: from eggs.gnu.org ([209.51.188.92]:54280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hBkUE-0004NK-NT
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 14:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hBkUD-0003fa-PD
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 14:19:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hBkUD-0003eS-EN
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 14:19:45 -0400
Date: Wed, 3 Apr 2019 21:19:38 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190403181937.GE3446@lap1>
References: <20190403113343.26384-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403113343.26384-1-kamalheib1@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] pvrdma: Add support for SRQ
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

On Wed, Apr 03, 2019 at 02:33:39PM +0300, Kamal Heib wrote:
> This series implements the SRQ (Shared Receive Queue) for the pvrdma
> device, It also includes all the needed functions and definitions for
> support SRQ in the backend and resource management layers.
> 
> Changes from v2->3:
> - Patch #1:
> -- Fix commit message.
> -- Remove initialization of backend_qp from rdma_backend_post_srq_recv().
> -- Add rx_srq counter.
> - Patch #2:
> -- Add checks for srq attrs.
> - Patch #3:
> -- Move initialization of recv_cq_handle to be under is_srq.
> -- Rearrange destroy_qp() to avoid use after free.
> - Patch #4:
> -- Avoid use after free.
> -- Fix indentation.
> 
> Changes from v1->v2:
> - Handle checkpatch.pl warnings. 

Appreciate if you can post v4 with a new patch to display the new counter
(function rdma_dump_device_counters).

> 
> Kamal Heib (4):
>   hw/rdma: Add SRQ support to backend layer
>   hw/rdma: Add support for managing SRQ resource
>   hw/rdma: Modify create/destroy QP to support SRQ
>   hw/pvrdma: Add support for SRQ
> 
>  hw/rdma/rdma_backend.c      | 125 +++++++++++++++++++++-
>  hw/rdma/rdma_backend.h      |  18 +++-
>  hw/rdma/rdma_backend_defs.h |   5 +
>  hw/rdma/rdma_rm.c           | 117 +++++++++++++++++++-
>  hw/rdma/rdma_rm.h           |  13 ++-
>  hw/rdma/rdma_rm_defs.h      |  10 ++
>  hw/rdma/vmw/pvrdma_cmd.c    | 206 ++++++++++++++++++++++++++++++++----
>  hw/rdma/vmw/pvrdma_main.c   |  16 +++
>  hw/rdma/vmw/pvrdma_qp_ops.c |  46 +++++++-
>  hw/rdma/vmw/pvrdma_qp_ops.h |   1 +
>  10 files changed, 521 insertions(+), 36 deletions(-)
> 
> -- 
> 2.20.1
> 
> 
