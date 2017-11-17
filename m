Received: from eggs.gnu.org ([2001:4830:134:3::10]:46059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eFhbR-0000lx-Lg
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:26:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eFhbQ-0006EN-Pt
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:26:45 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:35025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1eFhbQ-0006Dm-Kq
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:26:44 -0500
Received: by mail-io0-x243.google.com with SMTP id i38so8918376iod.2
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 06:26:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510926167-23326-14-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-14-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 17 Nov 2017 15:26:23 +0100
Message-ID: <CACXAS8DzoZO=zi_GRkXKbidMjLBLz855aUbUQO3vJOHhzGfucQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 13/15] apb: replace OBIO interrupt numbers
 in pci_pbmA_map_irq() with constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, Nov 17, 2017 at 2:42 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Following on from the previous commit, we can also do the same with
> with legacy OBIO interrupts in pci_pbmA_map_irq().
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  hw/pci-host/apb.c         |    4 ++--
>  include/hw/pci-host/apb.h |    2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index f092780c..31eb675 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -523,10 +523,10 @@ static int pci_pbmA_map_irq(PCIDevice *pci_dev, int irq_num)
>      switch (PCI_SLOT(pci_dev->devfn)) {
>      case 1:
>          /* Onboard NIC */
> -        return 0x21;
> +        return OBIO_NIC_IRQ;
>      case 3:
>          /* Onboard IDE */
> -        return 0x20;
> +        return OBIO_HDD_IRQ;
>      default:
>          /* Normal intno, fall through */
>          break;
> diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
> index 09ebd53..6194c8c 100644
> --- a/include/hw/pci-host/apb.h
> +++ b/include/hw/pci-host/apb.h
> @@ -53,6 +53,8 @@ typedef struct IOMMUState {
>  #define MAX_IVEC 0x40
>
>  /* OBIO IVEC IRQs */
> +#define OBIO_HDD_IRQ         0x20
> +#define OBIO_NIC_IRQ         0x21
>  #define OBIO_LPT_IRQ         0x22
>  #define OBIO_FDD_IRQ         0x27
>  #define OBIO_KBD_IRQ         0x29
> --
> 1.7.10.4
>



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
