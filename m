Received: from eggs.gnu.org ([2001:4830:134:3::10]:59487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gNzO8-00066o-Ef
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gNzO3-0007fW-In
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:07:48 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gNzO3-0007bW-CS
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:07:43 -0500
Received: by mail-wm1-x344.google.com with SMTP id 124-v6so1035310wmw.0
	for <qemu-devel@nongnu.org>; Sat, 17 Nov 2018 04:07:43 -0800 (PST)
References: <20181113071336.6242-1-yuval.shaia@oracle.com>
	<20181113071336.6242-10-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <e9370e48-b8e4-3280-fe64-f6bc3457af64@gmail.com>
Date: Sat, 17 Nov 2018 14:07:39 +0200
MIME-Version: 1.0
In-Reply-To: <20181113071336.6242-10-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 09/23] hw/pvrdma: Set the correct opcode
 for send completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com



On 11/13/18 9:12 AM, Yuval Shaia wrote:
> opcode for WC should be set by the device and not taken from work
> element.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/vmw/pvrdma_qp_ops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> index 7b0f440fda..3388be1926 100644
> --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> @@ -154,7 +154,7 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>           comp_ctx->cq_handle = qp->send_cq_handle;
>           comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
>           comp_ctx->cqe.qp = qp_handle;
> -        comp_ctx->cqe.opcode = wqe->hdr.opcode;
> +        comp_ctx->cqe.opcode = IBV_WC_SEND;
>   
>           rdma_backend_post_send(&dev->backend_dev, &qp->backend_qp, qp->qp_type,
>                                  (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Thanks,
Marcel
