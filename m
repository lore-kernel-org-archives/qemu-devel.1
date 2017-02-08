Received: from eggs.gnu.org ([2001:4830:134:3::10]:34194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jirislaby@gmail.com>) id 1cbM8i-0001qD-Ap
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jirislaby@gmail.com>) id 1cbM8d-0001Vj-SM
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:54:04 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jirislaby@gmail.com>) id 1cbM8d-0001Uy-MB
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:53:59 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so31652178wmi.1
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 22:53:58 -0800 (PST)
References: <589a933e.54c0620a.e6952.a4c6@mx.google.com>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <193b9259-ea12-2a97-572c-369e88533016@suse.cz>
Date: Wed, 8 Feb 2017 07:53:55 +0100
MIME-Version: 1.0
In-Reply-To: <589a933e.54c0620a.e6952.a4c6@mx.google.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] misc: edu: free dma timer in device unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: Li Qiang <liqiang6-s@360.cn>

On 02/08/2017, 04:40 AM, Li Qiang wrote:
> From: Li Qiang <liqiang6-s@360.cn>
> 
> This can avoid a memory leak when hotplug and unplug.
> 
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
>  hw/misc/edu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 401039c..7565552 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -375,6 +375,7 @@ static void pci_edu_uninit(PCIDevice *pdev)
>      qemu_mutex_destroy(&edu->thr_mutex);
>  
>      timer_del(&edu->dma_timer);
> +    timer_free(&edu->dma_timer);

Freeing a static timer does not sound correct to me?

thanks,
-- 
js
suse labs
