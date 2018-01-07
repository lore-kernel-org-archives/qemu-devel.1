Received: from eggs.gnu.org ([2001:4830:134:3::10]:49951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYDxv-0001Gq-EZ
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 11:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYDxq-0007dR-LV
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 11:38:31 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:37971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYDxq-0007cT-Gh
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 11:38:26 -0500
Received: by mail-qk0-x244.google.com with SMTP id j185so747284qkc.5
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 08:38:26 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180106153730.30313-1-hpoussin@reactos.org>
	<20180106153730.30313-16-hpoussin@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2ba71955-6302-b2a6-abb4-47bf1b3ebe0a@amsat.org>
Date: Sun, 7 Jan 2018 13:38:20 -0300
MIME-Version: 1.0
In-Reply-To: <20180106153730.30313-16-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 15/16] piix4: rename PIIX4 object to
 piix4-isa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 01/06/2018 12:37 PM, Hervé Poussineau wrote:
> Other piix4 parts are already named piix4-ide and piix4-usb-uhci.
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>  hw/isa/piix4.c       | 1 -
>  hw/mips/mips_malta.c | 2 +-
>  include/hw/isa/isa.h | 3 +++
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 159a27d2d9..1447d41934 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -52,7 +52,6 @@ typedef struct PIIX4State {
>      uint8_t rcr;
>  } PIIX4State;
>  
> -#define TYPE_PIIX4_PCI_DEVICE "PIIX4"
>  #define PIIX4_PCI_DEVICE(obj) \
>      OBJECT_CHECK(PIIX4State, (obj), TYPE_PIIX4_PCI_DEVICE)
>  
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 3d304a6e0a..93ec013ea2 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1178,7 +1178,7 @@ void mips_malta_init(MachineState *machine)
>      ide_drive_get(hd, ARRAY_SIZE(hd));
>  
>      pci = pci_create_multifunction(pci_bus, PCI_DEVFN(10, 0),
> -                                   true, "PIIX4");
> +                                   true, TYPE_PIIX4_PCI_DEVICE);
>      dev = DEVICE(pci);
>  
>      /* Floppy */
> diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
> index 95593408ef..1f47692447 100644
> --- a/include/hw/isa/isa.h
> +++ b/include/hw/isa/isa.h
> @@ -153,4 +153,7 @@ static inline ISABus *isa_bus_from_device(ISADevice *d)
>  
>  /* i8257.c */
>  void DMA_init(ISABus *bus, int high_page_enable);
> +
> +#define TYPE_PIIX4_PCI_DEVICE "piix4-isa"

can this be a migration issue?

> +
>  #endif
> 
