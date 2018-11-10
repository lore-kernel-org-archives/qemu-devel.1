Received: from eggs.gnu.org ([2001:4830:134:3::10]:48890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gLXri-0007gM-08
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:20:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gLXoz-00053s-NB
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:17:30 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gLXoz-00053V-GY
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:17:25 -0500
Received: by mail-wm1-x344.google.com with SMTP id p2-v6so4626220wmc.2
	for <qemu-devel@nongnu.org>; Sat, 10 Nov 2018 10:17:25 -0800 (PST)
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
	<20181108160818.5485-7-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <c25ce88b-a090-412a-1d3b-4fa5a5ddac27@gmail.com>
Date: Sat, 10 Nov 2018 20:17:20 +0200
MIME-Version: 1.0
In-Reply-To: <20181108160818.5485-7-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 06/22] hw/pvrdma: Make function
 reset_device return void
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
> This function cannot fail - fix it to return void
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/vmw/pvrdma_main.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index 6c8c0154fa..fc2abd34af 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -369,13 +369,11 @@ static int unquiesce_device(PVRDMADev *dev)
>       return 0;
>   }
>   
> -static int reset_device(PVRDMADev *dev)
> +static void reset_device(PVRDMADev *dev)
>   {
>       pvrdma_stop(dev);
>   
>       pr_dbg("Device reset complete\n");
> -
> -    return 0;
>
>   
>   static uint64_t regs_read(void *opaque, hwaddr addr, unsigned size)

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
