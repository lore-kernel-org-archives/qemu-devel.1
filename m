Received: from eggs.gnu.org ([2001:4830:134:3::10]:41171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gH6iw-0008Sb-KO
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gH6it-00018V-0n
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:32:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gH6is-00012t-Mx
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:32:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id f1-v6so9444975wmg.1
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 05:32:44 -0700 (PDT)
References: <1540794581-33578-1-git-send-email-liq3ea@gmail.com>
	<1540794581-33578-3-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4ba86a48-10da-e40c-971e-7e4bbbe6c7e8@redhat.com>
Date: Mon, 29 Oct 2018 13:32:41 +0100
MIME-Version: 1.0
In-Reply-To: <1540794581-33578-3-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] nvme: free cmbuf in nvme_exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 29/10/18 7:29, Li Qiang wrote:
> This avoid a memory leak in unhotplug nvme device.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/block/nvme.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 359a06d0ad..09d7c90259 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1332,6 +1332,9 @@ static void nvme_exit(PCIDevice *pci_dev)
>       g_free(n->cq);
>       g_free(n->sq);
>   
> +    if (n->cmb_size_mb) {
> +        g_free(n->cmbuf);
> +    }
>       msix_uninit_exclusive_bar(pci_dev);
>   }
>   
> 
