Received: from eggs.gnu.org ([2001:4830:134:3::10]:60245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqEPO-0007JO-EW
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqEPL-0001YS-4j
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:17:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58806 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fqEPK-0001XD-Ry
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:17:31 -0400
References: <20180816090604.3970-1-marcel.apfelbaum@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <566396da-8e93-9f7e-f327-1bead84e23d4@redhat.com>
Date: Thu, 16 Aug 2018 11:17:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180816090604.3970-1-marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] config: split PVRDMA from RDMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com, rebecca@bluestop.org, peter.maydell@linaro.org

On 08/16/2018 11:06 AM, Marcel Apfelbaum wrote:
> In some BSD systems RDMA migration is possible while
> the pvrdma device can't be compiled because the mremap
> system call is missing.
> 
> Reported-by: Rebecca Cran <rebecca@bluestop.org>
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> ---
>  configure             | 41 ++++++++++++++++++++++++++++++++++++++++-
>  hw/rdma/Makefile.objs |  2 +-
>  2 files changed, 41 insertions(+), 2 deletions(-)
[...]
> diff --git a/hw/rdma/Makefile.objs b/hw/rdma/Makefile.objs
> index 3504c39d21..bd36cbf51c 100644
> --- a/hw/rdma/Makefile.objs
> +++ b/hw/rdma/Makefile.objs
> @@ -1,4 +1,4 @@
> -ifeq ($(CONFIG_RDMA),y)
> +ifeq ($(CONFIG_PVRDMA),y)
>  obj-$(CONFIG_PCI) += rdma_utils.o rdma_backend.o rdma_rm.o
>  obj-$(CONFIG_PCI) += vmw/pvrdma_dev_ring.o vmw/pvrdma_cmd.o \
>                       vmw/pvrdma_qp_ops.o vmw/pvrdma_main.o

Shouldn't just the second line be guarded by CONFIG_PVRDMA ?

 Thomas
