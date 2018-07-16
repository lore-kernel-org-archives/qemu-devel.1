Received: from eggs.gnu.org ([2001:4830:134:3::10]:43278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff0zz-00005m-Ve
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff0zw-0008NI-RT
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:45:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1ff0zw-0008Mw-Kb
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:44:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id b15-v6so31415609wrv.10
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 03:44:56 -0700 (PDT)
References: <20180716074038.3364-1-yuval.shaia@oracle.com>
	<20180716074038.3364-9-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <754fc01d-1b3a-0cd1-b0d2-1ec8e331088a@gmail.com>
Date: Mon, 16 Jul 2018 13:44:53 +0300
MIME-Version: 1.0
In-Reply-To: <20180716074038.3364-9-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 08/13] hw/rdma: Reorder resource cleanup
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
> To be consistence with allocation do the reverse order in deallocation
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_rm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> index bf4a5c71b4..1f014b4ab2 100644
> --- a/hw/rdma/rdma_rm.c
> +++ b/hw/rdma/rdma_rm.c
> @@ -543,8 +543,9 @@ void rdma_rm_fini(RdmaDeviceResources *dev_res)
>       res_tbl_free(&dev_res->uc_tbl);
>       res_tbl_free(&dev_res->cqe_ctx_tbl);
>       res_tbl_free(&dev_res->qp_tbl);
> -    res_tbl_free(&dev_res->cq_tbl);
>       res_tbl_free(&dev_res->mr_tbl);
> +    res_tbl_free(&dev_res->cq_tbl);
>       res_tbl_free(&dev_res->pd_tbl);
> +
>       g_hash_table_destroy(dev_res->qp_hash);
>   }


Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
