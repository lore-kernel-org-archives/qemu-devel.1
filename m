Received: from eggs.gnu.org ([2001:4830:134:3::10]:49590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sahid.ferdjaoui@redhat.com>) id 1cwPaK-0002Ws-Sp
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sahid.ferdjaoui@redhat.com>) id 1cwPaH-0003R1-R9
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:49:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sahid.ferdjaoui@redhat.com>)
	id 1cwPaH-0003QN-Le
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:49:33 -0400
Date: Fri, 7 Apr 2017 10:49:31 +0200
From: Sahid Orentino Ferdjaoui <sferdjao@redhat.com>
Message-ID: <20170407084931.GC26482@redhat>
References: <1491548348-61640-1-git-send-email-weiqi4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491548348-61640-1-git-send-email-weiqi4@huawei.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] esp-pci: simple clean up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: weiqi <weiqi4@huawei.com>
Cc: pbonzini@redhat.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Fri, Apr 07, 2017 at 02:59:08PM +0800, weiqi wrote:
> From: Wei Qi <weiqi4@huawei.com>
> 
> It is unnecessary to assign variable 'size' here, because 'size' unused after assignment.
> 
> Signed-off-by: Wei Qi <weiqi4@huawei.com>
> ---
>  hw/scsi/esp-pci.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-By: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>

> 
> diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
> index e295d88..1f5980e 100644
> --- a/hw/scsi/esp-pci.c
> +++ b/hw/scsi/esp-pci.c
> @@ -192,7 +192,6 @@ static void esp_pci_io_write(void *opaque, hwaddr addr,
>          val <<= shift;
>          val |= current & ~(mask << shift);
>          addr &= ~3;
> -        size = 4;

I verified that 'size' is passed by value to 'esp_pci_io_write(...)',
no loop, no recursivity.

>      }
>  
>      if (addr < 0x40) {
> -- 
> 1.8.3.1
> 
> 
