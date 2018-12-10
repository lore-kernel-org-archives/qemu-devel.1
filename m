Received: from eggs.gnu.org ([2001:4830:134:3::10]:42243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gWPBb-0006uO-Dy
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gWPBY-0003Wl-RB
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:17:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gWPBY-0003Vf-I5
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:17:36 -0500
References: <1544253511-82742-1-git-send-email-peng.hao2@zte.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <103eeca6-0af2-da88-fa17-d09466d29ba8@redhat.com>
Date: Mon, 10 Dec 2018 18:17:30 +0100
MIME-Version: 1.0
In-Reply-To: <1544253511-82742-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/watchdog/wdt_i6300esb : remove a
 unnecessary comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: qemu-devel@nongnu.org

On 08/12/18 08:18, Peng Hao wrote:
> The registered memory region of i6300esb is not suitable for coalesced
> mmio, because a write for the region may trigger an immediate action
> and can't be delayed.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  hw/watchdog/wdt_i6300esb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
> index 7b59469..1c6eddf 100644
> --- a/hw/watchdog/wdt_i6300esb.c
> +++ b/hw/watchdog/wdt_i6300esb.c
> @@ -449,7 +449,6 @@ static void i6300esb_realize(PCIDevice *dev, Error **errp)
>      memory_region_init_io(&d->io_mem, OBJECT(d), &i6300esb_ops, d,
>                            "i6300esb", 0x10);
>      pci_register_bar(&d->dev, 0, 0, &d->io_mem);
> -    /* qemu_register_coalesced_mmio (addr, 0x10); ? */
>  }
>  
>  static void i6300esb_exit(PCIDevice *dev)
> 

Queued, thanks.

Paolo
