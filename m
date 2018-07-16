Received: from eggs.gnu.org ([2001:4830:134:3::10]:43576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff11o-0001Su-VK
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff11l-0000uF-S7
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:46:53 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:51707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1ff11l-0000tz-KC
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:46:49 -0400
Received: by mail-wm0-x22f.google.com with SMTP id s12-v6so14702989wmc.1
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 03:46:49 -0700 (PDT)
References: <20180716074038.3364-1-yuval.shaia@oracle.com>
	<20180716074038.3364-12-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <b6cba2ec-2589-97ea-dc63-7d1e48dc4cc2@gmail.com>
Date: Mon, 16 Jul 2018 13:46:46 +0300
MIME-Version: 1.0
In-Reply-To: <20180716074038.3364-12-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 11/13] hw/rdma: Print backend QP number in
 hex format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org



On 07/16/2018 10:40 AM, Yuval Shaia wrote:
> To be consistent with other prints throughout the code fix places that
> print it as decimal number.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_rm.c           | 4 ++--
>   hw/rdma/vmw/pvrdma_qp_ops.c | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> index 1f014b4ab2..859c900003 100644
> --- a/hw/rdma/rdma_rm.c
> +++ b/hw/rdma/rdma_rm.c
> @@ -389,7 +389,7 @@ int rdma_rm_modify_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
>       RdmaRmQP *qp;
>       int ret;
>   
> -    pr_dbg("qpn=%d\n", qp_handle);
> +    pr_dbg("qpn=0x%x\n", qp_handle);
>   
>       qp = rdma_rm_get_qp(dev_res, qp_handle);
>       if (!qp) {
> @@ -447,7 +447,7 @@ int rdma_rm_query_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
>   {
>       RdmaRmQP *qp;
>   
> -    pr_dbg("qpn=%d\n", qp_handle);
> +    pr_dbg("qpn=0x%x\n", qp_handle);
>   
>       qp = rdma_rm_get_qp(dev_res, qp_handle);
>       if (!qp) {
> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> index a8664f40c8..c668afd0ed 100644
> --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> @@ -130,7 +130,7 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>       PvrdmaSqWqe *wqe;
>       PvrdmaRing *ring;
>   
> -    pr_dbg("qp_handle=%d\n", qp_handle);
> +    pr_dbg("qp_handle=0x%x\n", qp_handle);
>   
>       qp = rdma_rm_get_qp(&dev->rdma_dev_res, qp_handle);
>       if (unlikely(!qp)) {
> @@ -174,7 +174,7 @@ int pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
>       PvrdmaRqWqe *wqe;
>       PvrdmaRing *ring;
>   
> -    pr_dbg("qp_handle=%d\n", qp_handle);
> +    pr_dbg("qp_handle=0x%x\n", qp_handle);
>   
>       qp = rdma_rm_get_qp(&dev->rdma_dev_res, qp_handle);
>       if (unlikely(!qp)) {

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
