Received: from eggs.gnu.org ([209.51.188.92]:46395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gt6jB-0000Qz-Dy
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gt6j9-0000NB-Pc
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:14:09 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gt6j9-0000Mh-Ix
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:14:07 -0500
Received: by mail-wm1-x343.google.com with SMTP id q21so15177113wmc.5
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 00:14:07 -0800 (PST)
References: <20190210104537.1488-1-yuval.shaia@oracle.com>
	<20190210104537.1488-10-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <53e8beec-7d4d-269a-ec45-d4babf4cfe82@gmail.com>
Date: Mon, 11 Feb 2019 10:14:35 +0200
MIME-Version: 1.0
In-Reply-To: <20190210104537.1488-10-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v1 9/9] hw/pvrdma: Unregister from shutdown
 notifier when device goes down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, dgilbert@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, eblake@redhat.com



On 2/10/19 12:45 PM, Yuval Shaia wrote:
> This hook was installed to close the device when VM is going down.
> After the device is closed there is no need to be informed on VM
> shutdown.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/vmw/pvrdma_main.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index 8b379c6435..1177c0822f 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -359,6 +359,8 @@ static void pvrdma_fini(PCIDevice *pdev)
>   {
>       PVRDMADev *dev = PVRDMA_DEV(pdev);
>   
> +    notifier_remove(&dev->shutdown_notifier);
> +
>       pvrdma_qp_ops_fini();
>   
>       rdma_backend_stop(&dev->backend_dev);


Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel
