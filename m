Received: from eggs.gnu.org ([2001:4830:134:3::10]:42667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff0y4-0007GJ-RA
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff0y4-0007F5-1n
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:43:00 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1ff0y3-0007Ec-Q9
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:42:59 -0400
Received: by mail-wm0-x241.google.com with SMTP id z6-v6so9677169wma.0
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 03:42:59 -0700 (PDT)
References: <20180716074038.3364-1-yuval.shaia@oracle.com>
	<20180716074038.3364-6-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <d066f4ad-c69f-80f9-fcac-495af5001dde@gmail.com>
Date: Mon, 16 Jul 2018 13:42:56 +0300
MIME-Version: 1.0
In-Reply-To: <20180716074038.3364-6-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 05/13] hw/pvrdma: Make default pkey 0xFFFF
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
> 0x7FFF is not the default pkey - fix it.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/vmw/pvrdma_cmd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index e7d6589cdc..bb898265a3 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -166,7 +166,7 @@ static int query_pkey(PVRDMADev *dev, union pvrdma_cmd_req *req,
>       resp->hdr.ack = PVRDMA_CMD_QUERY_PKEY_RESP;
>       resp->hdr.err = 0;
>   
> -    resp->pkey = 0x7FFF;
> +    resp->pkey = 0xFFFF;
>       pr_dbg("pkey=0x%x\n", resp->pkey);
>   
>       return 0;

A MACRO will be more readable. It doesn't worth a re-spin though.

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
