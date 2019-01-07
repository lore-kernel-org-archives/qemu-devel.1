Received: from eggs.gnu.org ([209.51.188.92]:41674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ggYk9-0007Nm-Rf
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ggYjp-0000zi-Fc
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:31:17 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1ggYjp-0000xu-7G
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:30:57 -0500
Received: by mail-wr1-x441.google.com with SMTP id l9so1239381wrt.13
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 09:30:57 -0800 (PST)
References: <20190103131251.49271-1-liq3ea@163.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <da2973f5-174e-2621-ce2b-c1d5a6cd5a00@gmail.com>
Date: Mon, 7 Jan 2019 19:31:06 +0200
MIME-Version: 1.0
In-Reply-To: <20190103131251.49271-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] hw: rdma: fix an off-by-one issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, yuval.shaia@oracle.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org



On 1/3/19 3:12 PM, Li Qiang wrote:
> In rdma_rm_get_backend_gid_index(), the 'sgid_idx' is used
> to index the array 'dev_res->port.gid_tbl' which size is
> MAX_PORT_GIDS. Current the 'sgid_idx' may be MAX_PORT_GIDS
> thus cause an off-by-one issue.
>
> Spotted by Coverity: CID 1398594
>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>   hw/rdma/rdma_rm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> index f5b1295890..1bbc5f128f 100644
> --- a/hw/rdma/rdma_rm.c
> +++ b/hw/rdma/rdma_rm.c
> @@ -576,7 +576,7 @@ int rdma_rm_del_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
>   int rdma_rm_get_backend_gid_index(RdmaDeviceResources *dev_res,
>                                     RdmaBackendDev *backend_dev, int sgid_idx)
>   {
> -    if (unlikely(sgid_idx < 0 || sgid_idx > MAX_PORT_GIDS)) {
> +    if (unlikely(sgid_idx < 0 || sgid_idx >= MAX_PORT_GIDS)) {
>           pr_dbg("Got invalid sgid_idx %d\n", sgid_idx);
>           return -EINVAL;
>       }

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
