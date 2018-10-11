Received: from eggs.gnu.org ([2001:4830:134:3::10]:51320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAcGU-0005la-Ar
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAcGP-0002Ss-9E
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:48:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAcGO-0002Kt-Am
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:48:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so10026580wrw.3
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 07:48:21 -0700 (PDT)
References: <1539261534-2795-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ce1a63fd-772e-d11f-bb6f-a59f76377239@redhat.com>
Date: Thu, 11 Oct 2018 16:48:16 +0200
MIME-Version: 1.0
In-Reply-To: <1539261534-2795-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] piix: use TYPE_FOO constants than string
 constats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 11/10/2018 14:38, Li Qiang wrote:
> Make them more QOMConventional.
> Cc:qemu-trivial@nongnu.org 
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/pci-host/piix.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 230d5d2ea3..5881e63364 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -95,6 +95,9 @@ typedef struct PIIX3State {
>  #define I440FX_PCI_DEVICE(obj) \
>      OBJECT_CHECK(PCII440FXState, (obj), TYPE_I440FX_PCI_DEVICE)
>  
> +#define TYPE_PIIX3_DEVICE "PIIX3"
> +#define TYPE_PIIX3_XEN_DEVICE "PIIX3-xen"
> +
>  struct PCII440FXState {
>      /*< private >*/
>      PCIDevice parent_obj;
> @@ -413,13 +416,13 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
>       * These additional routes can be discovered through ACPI. */
>      if (xen_enabled()) {
>          PCIDevice *pci_dev = pci_create_simple_multifunction(b,
> -                             -1, true, "PIIX3-xen");
> +                             -1, true, TYPE_PIIX3_XEN_DEVICE);
>          piix3 = PIIX3_PCI_DEVICE(pci_dev);
>          pci_bus_irqs(b, xen_piix3_set_irq, xen_pci_slot_get_pirq,
>                  piix3, XEN_PIIX_NUM_PIRQS);
>      } else {
>          PCIDevice *pci_dev = pci_create_simple_multifunction(b,
> -                             -1, true, "PIIX3");
> +                             -1, true, TYPE_PIIX3_DEVICE);
>          piix3 = PIIX3_PCI_DEVICE(pci_dev);
>          pci_bus_irqs(b, piix3_set_irq, pci_slot_get_pirq, piix3,
>                  PIIX_NUM_PIRQS);
> @@ -737,7 +740,7 @@ static void piix3_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo piix3_info = {
> -    .name          = "PIIX3",
> +    .name          = TYPE_PIIX3_DEVICE,
>      .parent        = TYPE_PIIX3_PCI_DEVICE,
>      .class_init    = piix3_class_init,
>  };
> @@ -750,7 +753,7 @@ static void piix3_xen_class_init(ObjectClass *klass, void *data)
>  };
>  
>  static const TypeInfo piix3_xen_info = {
> -    .name          = "PIIX3-xen",
> +    .name          = TYPE_PIIX3_XEN_DEVICE,
>      .parent        = TYPE_PIIX3_PCI_DEVICE,
>      .class_init    = piix3_xen_class_init,
>  };
> 
