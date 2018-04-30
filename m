Received: from eggs.gnu.org ([2001:4830:134:3::10]:37100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDG81-0007hX-DK
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 17:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDG7y-0004C7-7K
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 17:14:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55334 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fDG7y-0004Bo-2j
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 17:14:30 -0400
References: <20180430200223.4119-1-marcel.apfelbaum@gmail.com>
	<20180430200223.4119-8-marcel.apfelbaum@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f68ec311-91fb-4823-2138-9e884343f2a2@redhat.com>
Date: Mon, 30 Apr 2018 16:14:16 -0500
MIME-Version: 1.0
In-Reply-To: <20180430200223.4119-8-marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] hw/rdma: Fix possible out of bounds
 access to port GID index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, yuval.shaia@oracle.com

On 04/30/2018 03:02 PM, Marcel Apfelbaum wrote:
> Make sure the backend GID index is less then port's
> git table length.

s/git/gid/

> 
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_backend.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index 5c7b3d8949..e9ced6f9ef 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -774,7 +774,7 @@ int rdma_backend_init(RdmaBackendDev *backend_dev,
>           goto out_destroy_comm_channel;
>       }
>   
> -    if (backend_dev->backend_gid_idx > port_attr.gid_tbl_len) {
> +    if (backend_dev->backend_gid_idx >= port_attr.gid_tbl_len) {
>           error_setg(errp, "Invalid backend_gid_idx, should be less than %d",
>                      port_attr.gid_tbl_len);
>           goto out_destroy_comm_channel;
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
