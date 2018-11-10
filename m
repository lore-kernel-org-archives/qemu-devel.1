Received: from eggs.gnu.org ([2001:4830:134:3::10]:40140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gLYne-0006YL-HI
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 14:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gLYnX-0005fc-Bi
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 14:20:04 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gLXXE-0002LR-2m
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 12:59:04 -0500
Received: by mail-wr1-x441.google.com with SMTP id k15-v6so5064654wre.12
	for <qemu-devel@nongnu.org>; Sat, 10 Nov 2018 09:59:03 -0800 (PST)
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
	<20181108160818.5485-4-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <ae430ac0-aa00-92b8-1453-d0eb47372d69@gmail.com>
Date: Sat, 10 Nov 2018 19:59:00 +0200
MIME-Version: 1.0
In-Reply-To: <20181108160818.5485-4-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 03/22] hw/rdma: Return qpn 1 if ibqp is
 NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com

Hi Yuval,

On 11/8/18 6:07 PM, Yuval Shaia wrote:
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

Just to be sure, what are the cases we don't get  a qp_num?
Can we assume all of them are MADs?

Thanks,
Marcel

>   }
>   
>   static inline uint32_t rdma_backend_mr_lkey(const RdmaBackendMR *mr)
