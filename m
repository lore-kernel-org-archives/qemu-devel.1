Received: from eggs.gnu.org ([209.51.188.92]:39662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj2IE-0005Fc-Sl
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:28:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj2IE-0000P9-6F
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:28:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gj2ID-0000OQ-WA
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:28:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so22834341wrs.10
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 05:28:41 -0800 (PST)
References: <20190114131015.52967-1-lifei1214@126.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ac0015a7-5fcf-f5f6-a1a5-6c3846459b8c@redhat.com>
Date: Mon, 14 Jan 2019 14:28:39 +0100
MIME-Version: 1.0
In-Reply-To: <20190114131015.52967-1-lifei1214@126.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/misc/edu: add msi_uninit() for
 pci_edu_uninit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: qemu-devel@nongnu.org, Jiri Slaby <jslaby@suse.cz>, shirley17fei@gmail.com

Cc'ing qemu-trivial

On 1/14/19 2:10 PM, Fei Li wrote:
> From: Fei Li <shirley17fei@gmail.com>
> 
> Let's supplement the msi_uninit() when failing to realize
> the pci edu device.
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fei Li <shirley17fei@gmail.com>
> Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/misc/edu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index cdcf550dd7..ceaf688bfb 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -377,6 +377,7 @@ static void pci_edu_uninit(PCIDevice *pdev)
>      qemu_mutex_destroy(&edu->thr_mutex);
>  
>      timer_del(&edu->dma_timer);
> +    msi_uninit(pdev);
>  }
>  
>  static void edu_obj_uint64(Object *obj, Visitor *v, const char *name,
> 
