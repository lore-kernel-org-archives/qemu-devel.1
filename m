Received: from eggs.gnu.org ([2001:4830:134:3::10]:42920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqKVo-00055M-CU
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqKVk-0004b3-40
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:48:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fqKVj-0004UM-T4
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:48:32 -0400
References: <20180816151637.24553-1-marcel.apfelbaum@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e69c3f04-acce-b6e8-7254-22edd5d04e4e@redhat.com>
Date: Thu, 16 Aug 2018 17:48:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180816151637.24553-1-marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2] config: split PVRDMA from RDMA
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

On 08/16/2018 05:16 PM, Marcel Apfelbaum wrote:
> In some BSD systems RDMA migration is possible while
> the pvrdma device can't be used because the mremap system call
> is missing.
> 
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> ---
>  configure             | 55 ++++++++++++++++++++++++++++++++++++++++++-
>  hw/rdma/Makefile.objs |  2 +-
>  2 files changed, 55 insertions(+), 2 deletions(-)
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
> 

Again: Shouldn't the CONFIG_PVRDMA only guard the second line? I thought
the first list should be fine with CONFIG_RDMA?

 Thomas
