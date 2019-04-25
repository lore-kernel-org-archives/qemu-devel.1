Received: from eggs.gnu.org ([209.51.188.92]:45388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJf1Z-000815-Jf
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJf1X-0006Ae-H7
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:06:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJf1W-00068H-Tg
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:06:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id b1so19194922wru.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:06:48 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7d4fdf95-f3b9-786a-9869-fdfca87d6a59@redhat.com>
Date: Thu, 25 Apr 2019 16:06:42 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-2-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 01/29] hw/pci/pci-stub: Add
 msi_enabled() and msi_notify() to the pci stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Rob Herring <robh@kernel.org>, qemu-block@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Some machines have an AHCI adapter, but no PCI. To be able to
> compile hw/ide/ahci.c without CONFIG_PCI, we still need the two
> functions msi_enabled() and msi_notify() for linking.
> This is required for the new Kconfig-like build system, if a user
> wants to compile a QEMU binary with just one machine that has AHCI,
> but no PCI, like the ARM "cubieboard" for example.
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/pci/pci-stub.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index b941a0e842..c04a5df651 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -53,3 +53,14 @@ uint16_t pci_requester_id(PCIDevice *dev)
>      g_assert(false);
>      return 0;
>  }
> +
> +/* Required by ahci.c */
> +bool msi_enabled(const PCIDevice *dev)
> +{
> +    return false;
> +}
> +
> +void msi_notify(PCIDevice *dev, unsigned int vector)
> +{
> +    g_assert_not_reached();
> +}
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
