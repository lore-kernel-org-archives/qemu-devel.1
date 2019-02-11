Received: from eggs.gnu.org ([209.51.188.92]:46229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gt6ij-0008Re-19
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gt6ii-00007I-89
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:13:41 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gt6ih-00004v-VG
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:13:40 -0500
Received: by mail-wm1-x342.google.com with SMTP id b11so15727270wmj.1
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 00:13:39 -0800 (PST)
References: <20190210104537.1488-1-yuval.shaia@oracle.com>
	<20190210104537.1488-9-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <dd45a1a5-df73-8413-4e1b-6fef345044bb@gmail.com>
Date: Mon, 11 Feb 2019 10:14:06 +0200
MIME-Version: 1.0
In-Reply-To: <20190210104537.1488-9-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v1 8/9] hw/pvrdma: Delete pvrdma_exit
 function
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
> This hook is not called and was implemented by mistake.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/vmw/pvrdma_main.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index 90dc9b191b..8b379c6435 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -701,18 +701,12 @@ out:
>       }
>   }
>   
> -static void pvrdma_exit(PCIDevice *pdev)
> -{
> -    pvrdma_fini(pdev);
> -}
> -
>   static void pvrdma_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>   
>       k->realize = pvrdma_realize;
> -    k->exit = pvrdma_exit;
>       k->vendor_id = PCI_VENDOR_ID_VMWARE;
>       k->device_id = PCI_DEVICE_ID_VMWARE_PVRDMA;
>       k->revision = 0x00;


Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel
