Received: from eggs.gnu.org ([2001:4830:134:3::10]:34130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gAHXQ-0005Nh-GY
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gAHXP-00017Q-Ot
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:40:44 -0400
References: <1539145764-5730-1-git-send-email-liq3ea@gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ea51c064-d7e8-5e97-e7be-e70b6f69b5ca@redhat.com>
Date: Wed, 10 Oct 2018 12:40:35 -0400
MIME-Version: 1.0
In-Reply-To: <1539145764-5730-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ide: piix: convert constant device name to
 MACRO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>



On 10/10/2018 12:29 AM, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/ide/piix.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index a3afe1f..5f29cce 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -35,6 +35,10 @@
>  #include "hw/ide/pci.h"
>  #include "trace.h"
>  
> +#define TYPE_PIIX3_IDE "piix3-ide"
> +#define TYPE_PIIX3_IDE_XEN "piix3-ide-xen"
> +#define TYPE_PIIX4_IDE "piix4-ide"
> +
>  static uint64_t bmdma_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      BMDMAState *bm = opaque;
> @@ -204,7 +208,7 @@ PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
>  {
>      PCIDevice *dev;
>  
> -    dev = pci_create_simple(bus, devfn, "piix3-ide-xen");
> +    dev = pci_create_simple(bus, devfn, TYPE_PIIX3_IDE_XEN);
>      pci_ide_create_devs(dev, hd_table);
>      return dev;
>  }
> @@ -226,7 +230,7 @@ PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
>  {
>      PCIDevice *dev;
>  
> -    dev = pci_create_simple(bus, devfn, "piix3-ide");
> +    dev = pci_create_simple(bus, devfn, TYPE_PIIX3_IDE);
>      pci_ide_create_devs(dev, hd_table);
>      return dev;
>  }
> @@ -237,7 +241,7 @@ PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
>  {
>      PCIDevice *dev;
>  
> -    dev = pci_create_simple(bus, devfn, "piix4-ide");
> +    dev = pci_create_simple(bus, devfn, TYPE_PIIX4_IDE);
>      pci_ide_create_devs(dev, hd_table);
>      return dev;
>  }
> @@ -257,13 +261,13 @@ static void piix3_ide_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo piix3_ide_info = {
> -    .name          = "piix3-ide",
> +    .name          = TYPE_PIIX3_IDE,
>      .parent        = TYPE_PCI_IDE,
>      .class_init    = piix3_ide_class_init,
>  };
>  
>  static const TypeInfo piix3_ide_xen_info = {
> -    .name          = "piix3-ide-xen",
> +    .name          = TYPE_PIIX3_IDE_XEN,
>      .parent        = TYPE_PCI_IDE,
>      .class_init    = piix3_ide_class_init,
>  };
> @@ -283,7 +287,7 @@ static void piix4_ide_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo piix4_ide_info = {
> -    .name          = "piix4-ide",
> +    .name          = TYPE_PIIX4_IDE,
>      .parent        = TYPE_PCI_IDE,
>      .class_init    = piix4_ide_class_init,
>  };
> 

Reviewed-by: John Snow <jsnow@redhat.com>

Sure thing. This can actually go through the trivial queue:

Acked-by: John Snow <jsnow@redhat.com>

CC'd qemu-trivial.

--js
