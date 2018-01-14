Received: from eggs.gnu.org ([2001:4830:134:3::10]:35081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eai2x-0001KH-Uu
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eai2s-0006Tp-JA
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:09:59 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:39590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eai2s-0006Tb-Eb
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:09:54 -0500
Received: by mail-qk0-x243.google.com with SMTP id c69so4797419qkg.6
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 05:09:54 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
	<20180114104751.21965-5-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <02f95520-0fb7-b369-667d-9414dfc5b47f@amsat.org>
Date: Sun, 14 Jan 2018 10:09:35 -0300
MIME-Version: 1.0
In-Reply-To: <20180114104751.21965-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/11] apb: change pbm_pci_host prefix
 functions to use sabre_pci prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 01/14/2018 07:47 AM, Mark Cave-Ayland wrote:
> This is the proper name for the PBM host bridge as referenced in the Sun
> documentation.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci-host/apb.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index d5c459a2df..98c5f344f7 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -472,7 +472,7 @@ static void sabre_init(Object *obj)
>      sysbus_init_mmio(sbd, &s->pci_ioport);
>  }
>  
> -static void sabre_pci_host_realize(PCIDevice *d, Error **errp)
> +static void sabre_pci_realize(PCIDevice *d, Error **errp)
>  {
>      pci_set_word(d->config + PCI_COMMAND,
>                   PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> @@ -481,12 +481,12 @@ static void sabre_pci_host_realize(PCIDevice *d, Error **errp)
>                   PCI_STATUS_DEVSEL_MEDIUM);
>  }
>  
> -static void sabre_pci_host_class_init(ObjectClass *klass, void *data)
> +static void sabre_pci_class_init(ObjectClass *klass, void *data)
>  {
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> -    k->realize = sabre_pci_host_realize;
> +    k->realize = sabre_pci_realize;
>      k->vendor_id = PCI_VENDOR_ID_SUN;
>      k->device_id = PCI_DEVICE_ID_SUN_SABRE;
>      k->class_id = PCI_CLASS_BRIDGE_HOST;
> @@ -497,11 +497,11 @@ static void sabre_pci_host_class_init(ObjectClass *klass, void *data)
>      dc->user_creatable = false;
>  }
>  
> -static const TypeInfo pbm_pci_host_info = {
> +static const TypeInfo sabre_pci_info = {
>      .name          = "pbm-pci",
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIDevice),
> -    .class_init    = sabre_pci_host_class_init,
> +    .class_init    = sabre_pci_class_init,
>      .interfaces = (InterfaceInfo[]) {
>          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>          { },
> @@ -535,7 +535,7 @@ static const TypeInfo sabre_info = {
>  static void sabre_register_types(void)
>  {
>      type_register_static(&sabre_info);
> -    type_register_static(&pbm_pci_host_info);
> +    type_register_static(&sabre_pci_info);
>  }
>  
>  type_init(sabre_register_types)
> 
