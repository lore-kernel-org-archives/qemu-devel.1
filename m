Received: from eggs.gnu.org ([2001:4830:134:3::10]:55984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gNyzs-0008OP-9K
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 06:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gNyzq-0008JW-ON
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 06:42:44 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gNyzq-0008IY-D8
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 06:42:42 -0500
Received: by mail-wr1-x441.google.com with SMTP id j10so13174999wru.4
	for <qemu-devel@nongnu.org>; Sat, 17 Nov 2018 03:42:42 -0800 (PST)
References: <20181113071336.6242-1-yuval.shaia@oracle.com>
	<20181113071336.6242-4-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <da0bd9ec-1b82-8906-ac12-929877bdce97@gmail.com>
Date: Sat, 17 Nov 2018 13:42:38 +0200
MIME-Version: 1.0
In-Reply-To: <20181113071336.6242-4-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 03/23] hw/rdma: Return qpn 1 if ibqp is
 NULL
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
> Device is not supporting QP0, only QP1.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_backend.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
> index 86e8fe8ab6..3ccc9a2494 100644
> --- a/hw/rdma/rdma_backend.h
> +++ b/hw/rdma/rdma_backend.h
> @@ -33,7 +33,7 @@ static inline union ibv_gid *rdma_backend_gid(RdmaBackendDev *dev)
>   
>   static inline uint32_t rdma_backend_qpn(const RdmaBackendQP *qp)
>   {
> -    return qp->ibqp ? qp->ibqp->qp_num : 0;
> +    return qp->ibqp ? qp->ibqp->qp_num : 1;
>   }
>   
>   static inline uint32_t rdma_backend_mr_lkey(const RdmaBackendMR *mr)

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
