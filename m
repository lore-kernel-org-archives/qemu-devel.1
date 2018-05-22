Received: from eggs.gnu.org ([2001:4830:134:3::10]:54636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLEEv-00087O-1m
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLEEr-0000LV-TY
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:50:37 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:42165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLEEr-0000LQ-PA
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:50:33 -0400
Received: by mail-qt0-x244.google.com with SMTP id c2-v6so25315571qtn.9
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 13:50:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180522165058.15404-1-kraxel@redhat.com>
	<20180522165058.15404-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <af8c9ef0-5dac-5ce9-6b7c-6e6deec7253c@amsat.org>
Date: Tue, 22 May 2018 17:50:27 -0300
MIME-Version: 1.0
In-Reply-To: <20180522165058.15404-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] vga-pci: use PCI_VGA_MMIO_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 05/22/2018 01:50 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/display/vga-pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
> index fb3e4cd400..700ac58c69 100644
> --- a/hw/display/vga-pci.c
> +++ b/hw/display/vga-pci.c
> @@ -232,7 +232,8 @@ static void pci_std_vga_realize(PCIDevice *dev, Error **errp)
>  
>      /* mmio bar for vga register access */
>      if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_MMIO)) {
> -        memory_region_init(&d->mmio, NULL, "vga.mmio", 4096);
> +        memory_region_init(&d->mmio, NULL, "vga.mmio",
> +                           PCI_VGA_MMIO_SIZE);
>  
>          if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT)) {
>              qext = true;
> @@ -267,7 +268,8 @@ static void pci_secondary_vga_realize(PCIDevice *dev, Error **errp)
>      s->con = graphic_console_init(DEVICE(dev), 0, s->hw_ops, s);
>  
>      /* mmio bar */
> -    memory_region_init(&d->mmio, OBJECT(dev), "vga.mmio", 4096);
> +    memory_region_init(&d->mmio, OBJECT(dev), "vga.mmio",
> +                       PCI_VGA_MMIO_SIZE);
>  
>      if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT)) {
>          qext = true;
> 
