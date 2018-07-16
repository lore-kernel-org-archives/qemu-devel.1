Received: from eggs.gnu.org ([2001:4830:134:3::10]:42354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff0x9-0006nQ-HQ
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff0x6-0006lx-Ds
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:42:03 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:54578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1ff0x6-0006lk-4w
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:42:00 -0400
Received: by mail-wm0-x242.google.com with SMTP id c14-v6so4340171wmb.4
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 03:42:00 -0700 (PDT)
References: <20180716074038.3364-1-yuval.shaia@oracle.com>
	<20180716074038.3364-5-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <736ad191-05e6-e083-fb6f-e158a23d9447@gmail.com>
Date: Mon, 16 Jul 2018 13:41:56 +0300
MIME-Version: 1.0
In-Reply-To: <20180716074038.3364-5-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 04/13] hw/pvrdma: Clean CQE before use
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
> Next CQE is fetched from CQ ring, clean it before usage as it still
> carries old CQE values.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/vmw/pvrdma_qp_ops.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> index 99bb51111e..a8664f40c8 100644
> --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> @@ -69,6 +69,7 @@ static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
>           return -EINVAL;
>       }
>   
> +    memset(cqe1, 0, sizeof(*cqe1));
>       cqe1->wr_id = cqe->wr_id;
>       cqe1->qp = cqe->qp;
>       cqe1->opcode = cqe->opcode;

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>



Thanks,

Marcel
