Received: from eggs.gnu.org ([2001:4830:134:3::10]:49573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJklI-0008Jf-Lq
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 14:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJklF-0006RH-HR
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 14:05:24 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJklF-0006R6-EB
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 14:05:21 -0400
Received: by mail-qk0-x243.google.com with SMTP id j126so1815316qkj.2
	for <qemu-devel@nongnu.org>; Sat, 10 Jun 2017 11:05:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1497099616-2615-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497099616-2615-4-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1ba105d2-be1d-c05b-bc99-6426f6d9c487@amsat.org>
Date: Sat, 10 Jun 2017 15:05:16 -0300
MIME-Version: 1.0
In-Reply-To: <1497099616-2615-4-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] sun4u: expose NVRAM on ebus PCI IO
 address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

Hi Mark,

I'm not sure having this patch split from the previous (2/3) really 
helps bisecting, I'd rather squash them altogether.

Either way:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

On 06/10/2017 10:00 AM, Mark Cave-Ayland wrote:
> To allow future changes to the sun4u PCI topology.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/sparc64/sun4u.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 19e64be..bf738f8 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -492,7 +492,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      /* Map NVRAM into I/O (ebus) space */
>      nvram = m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
>      s = SYS_BUS_DEVICE(nvram);
> -    memory_region_add_subregion(get_system_io(), 0x2000,
> +    memory_region_add_subregion(pci_address_space_io(ebus), 0x2000,
>                                  sysbus_mmio_get_region(s, 0));
>
>      initrd_size = 0;
>
