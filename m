Received: from eggs.gnu.org ([2001:4830:134:3::10]:59362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gH2Pd-0002EE-6u
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 03:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gH2PZ-0001AV-VY
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 03:56:37 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gH2PZ-00014H-NF
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 03:56:33 -0400
Received: by mail-wm1-x344.google.com with SMTP id 143-v6so7092014wmf.1
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 00:56:22 -0700 (PDT)
References: <20181025061700.17050-1-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <82b0b0d9-202c-3646-ae9a-429ab9dd577a@gmail.com>
Date: Mon, 29 Oct 2018 10:57:21 +0200
MIME-Version: 1.0
In-Reply-To: <20181025061700.17050-1-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] hw/pvrdma: Check the correct return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org



On 10/25/18 9:17 AM, Yuval Shaia wrote:
> Return value of 0 means ok, we want to free the memory only in case of
> error.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/vmw/pvrdma_cmd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index 4faeb21631..57d6f41ae6 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -232,7 +232,7 @@ static int create_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
>                                        cmd->start, cmd->length, host_virt,
>                                        cmd->access_flags, &resp->mr_handle,
>                                        &resp->lkey, &resp->rkey);
> -    if (host_virt && !resp->hdr.err) {
> +    if (resp->hdr.err && host_virt) {
>           munmap(host_virt, cmd->length);
>       }
>   

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
