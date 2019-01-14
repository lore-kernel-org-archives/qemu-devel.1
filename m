Received: from eggs.gnu.org ([209.51.188.92]:56032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gizoX-0002uQ-71
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gizoW-00071A-FH
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:49:53 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:55877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gizoW-0006zH-9K
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:49:52 -0500
Received: by mail-wm1-f42.google.com with SMTP id y139so8311885wmc.5
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 02:49:52 -0800 (PST)
References: <20190109201956.3982-1-yuval.shaia@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0cd4a9fc-9f61-6bcd-915d-8532b5506a18@redhat.com>
Date: Mon, 14 Jan 2019 11:49:49 +0100
MIME-Version: 1.0
In-Reply-To: <20190109201956.3982-1-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/rdma: Delete unused struct member
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org

On 1/9/19 9:19 PM, Yuval Shaia wrote:
> This member is used only in init_device_caps function, make it local.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/rdma/rdma_backend.c      | 26 ++++++++++++++------------
>  hw/rdma/rdma_backend_defs.h |  1 -
>  2 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index 16dca69ee9..b49edaacaf 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -917,23 +917,25 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp)
>  static int init_device_caps(RdmaBackendDev *backend_dev,
>                              struct ibv_device_attr *dev_attr)
>  {
> -    if (ibv_query_device(backend_dev->context, &backend_dev->dev_attr)) {
> +    struct ibv_device_attr bk_dev_attr;
> +
> +    if (ibv_query_device(backend_dev->context, &bk_dev_attr)) {
>          return -EIO;
>      }
>  
>      dev_attr->max_sge = MAX_SGE;
>  
> -    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_mr_size, "%" PRId64);
> -    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp, "%d");
> -    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_sge, "%d");
> -    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp_wr, "%d");
> -    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_cq, "%d");
> -    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_cqe, "%d");
> -    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_mr, "%d");
> -    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_pd, "%d");
> -    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp_rd_atom, "%d");
> -    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp_init_rd_atom, "%d");
> -    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_ah, "%d");
> +    CHK_ATTR(dev_attr, bk_dev_attr, max_mr_size, "%" PRId64);
> +    CHK_ATTR(dev_attr, bk_dev_attr, max_qp, "%d");
> +    CHK_ATTR(dev_attr, bk_dev_attr, max_sge, "%d");
> +    CHK_ATTR(dev_attr, bk_dev_attr, max_qp_wr, "%d");
> +    CHK_ATTR(dev_attr, bk_dev_attr, max_cq, "%d");
> +    CHK_ATTR(dev_attr, bk_dev_attr, max_cqe, "%d");
> +    CHK_ATTR(dev_attr, bk_dev_attr, max_mr, "%d");
> +    CHK_ATTR(dev_attr, bk_dev_attr, max_pd, "%d");
> +    CHK_ATTR(dev_attr, bk_dev_attr, max_qp_rd_atom, "%d");
> +    CHK_ATTR(dev_attr, bk_dev_attr, max_qp_init_rd_atom, "%d");
> +    CHK_ATTR(dev_attr, bk_dev_attr, max_ah, "%d");
>  
>      return 0;
>  }
> diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
> index 1e5c3dd3bf..15ae8b970e 100644
> --- a/hw/rdma/rdma_backend_defs.h
> +++ b/hw/rdma/rdma_backend_defs.h
> @@ -41,7 +41,6 @@ typedef struct RdmaCmMux {
>  } RdmaCmMux;
>  
>  typedef struct RdmaBackendDev {
> -    struct ibv_device_attr dev_attr;
>      RdmaBackendThread comp_thread;
>      PCIDevice *dev;
>      RdmaDeviceResources *rdma_dev_res;
> 
