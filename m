Received: from eggs.gnu.org ([208.118.235.92]:57555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gLXrh-0007e8-6c
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:20:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gLXpX-0005Tk-Et
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:18:02 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gLXpX-0005TI-8B
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:17:59 -0500
Received: by mail-wm1-x343.google.com with SMTP id r11-v6so4789400wmb.2
	for <qemu-devel@nongnu.org>; Sat, 10 Nov 2018 10:17:59 -0800 (PST)
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
	<20181108160818.5485-8-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <8688ab5e-3821-e4bf-4712-def5ceef1664@gmail.com>
Date: Sat, 10 Nov 2018 20:17:55 +0200
MIME-Version: 1.0
In-Reply-To: <20181108160818.5485-8-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 07/22] hw/pvrdma: Make default pkey
 0xFFFF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com



On 11/8/18 6:08 PM, Yuval Shaia wrote:
> Commit 6e7dba23af ("hw/pvrdma: Make default pkey 0xFFFF") exports
> default pkey as external definition but omit the change from 0x7FFF to
> 0xFFFF.
>
> Fixes: 6e7dba23af ("hw/pvrdma: Make default pkey 0xFFFF")
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/vmw/pvrdma.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
> index e3742d893a..15c3f28b86 100644
> --- a/hw/rdma/vmw/pvrdma.h
> +++ b/hw/rdma/vmw/pvrdma.h
> @@ -52,7 +52,7 @@
>   #define PVRDMA_FW_VERSION    14
>   
>   /* Some defaults */
> -#define PVRDMA_PKEY          0x7FFF
> +#define PVRDMA_PKEY          0xFFFF
>   
>   typedef struct DSRInfo {
>       dma_addr_t dma;


Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
