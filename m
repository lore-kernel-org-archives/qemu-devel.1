Received: from eggs.gnu.org ([209.51.188.92]:45827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJnQL-0000sy-6q
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 19:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJnDI-0005RZ-T8
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:51:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJnDG-0005PA-Sb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:51:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id c1so1246934wml.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 15:51:27 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2f02bf38-4bb0-9ca4-438a-b753d6ab5f49@redhat.com>
Date: Fri, 26 Apr 2019 00:51:20 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 00/29] Kconfig dependencies
 for ARM machines
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

Hi Thomas,

On 4/18/19 8:00 PM, Thomas Huth wrote:
> This series reworks the default-configs/arm-softmmu.mak and
> default-configs/aarch64-softmmu.mak files to use the new Kconfig-style
> dependencies instead.
> 
> Some of the patches are slightly based on the work by Ákos Kovács:
> 
>  https://lists.nongnu.org/archive/html/qemu-devel/2013-08/msg03730.html
> 
> The other patches have been created by looking at the sources and finding
> out the dependencies the hard way via trial-and-error (i.e. by enabling
> only one machine at a time and checking whether it can be compiled and
> started).
> 
> v5:
>  - Rebased the series to the current master branch
>  - Added "hw/usb/hcd-ohci: Move PCI-related code into a separate file"
>    patch and got rid of unneeded dependencies to CONFIG_PCI in the
>    ARM machines that do not have a PCI bus
> 
> v4:
>  - Rebased the series to Paolo's latest kconfig tree
> 
> v3:
>  - Addressed review feedback from v2
>  - Included patches to clean up the PCI dependencies of AHCI and SDHCI
>    (so CONFIG_AHCI and CONFIG_SDHCI do not depend on CONFIG_PCI anymore)
>  - Added an additional patch for the new "musca" machines
> 
> v2: Adressed review-feedback from v1
>  - CONFIG_SDHCI and CONFIG_AHCI now select CONFIG_PCI
>  - Added switches for MICROBIT and EMCRAFT_SF2
> 
> Thomas Huth (29):
>   hw/pci/pci-stub: Add msi_enabled() and msi_notify() to the pci stubs
>   hw/ide/ahci: Add a Kconfig switch for the AHDI-ICH9 device
>   hw/usb/hcd-ohci: Move PCI-related code into a separate file
>   hw/arm: Express dependencies of the exynos machines with Kconfig
>   hw/arm: Express dependencies of the highbank machines with Kconfig
>   hw/arm: Express dependencies of integratorcp with Kconfig
>   hw/arm: Express dependencies of the fsl-imx31 machine with Kconfig
>   hw/arm: Express dependencies of musicpal with Kconfig
>   hw/arm: Express dependencies of the OMAP machines with Kconfig
>   hw/arm: Express dependencies of stellaris with Kconfig
>   hw/arm: Express dependencies of realview, versatile and vexpress with
>     Kconfig
>   hw/arm: Express dependencies of the PXA2xx machines with Kconfig
>   hw/arm: Express dependencies of xilinx-zynq with Kconfig
>   hw/arm: Express dependencies of collie with Kconfig
>   hw/arm: Express dependencies of the aspeed boards with Kconfig
>   hw/arm: Express dependencies of the virt machine with Kconfig
>   hw/arm: Express dependencies of netduino / stm32f2xx with Kconfig
>   hw/arm: Express dependencies of allwinner / cubieboard with Kconfig
>   hw/arm: Express dependencies of the MPS2 boards with Kconfig
>   hw/arm: Express dependencies of the raspi machines with Kconfig
>   hw/arm: Express dependencies of canon-a1100 with Kconfig
>   hw/arm: Express dependencies of sabrelite with Kconfig
>   hw/arm: Express dependencies of the MSF2 / EMCRAFT_SF2 machine with
>     Kconfig
>   hw/arm: Express dependencies for remaining IMX boards with Kconfig
>   hw/arm: Express dependencies of the microbit / nrf51 machine with
>     Kconfig
>   hw/arm: Express dependencies of the ZynqMP zcu102 machine with Kconfig
>   hw/arm: Express dependencies of the xlnx-versal-virt machine with
>     Kconfig
>   hw/arm: Express dependencies of the musca machines with Kconfig
>   hw/arm: Remove hard-enablement of the remaining PCI devices

I tested each machines of your series.
I replaced patch #3 "hw/usb/hcd-ohci: Move PCI-related code into a
separate file" by your more recent series "Fix ohci_die() and move PCI
code to separate file",
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03344.html

So for all patches except 3/29:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
(well, I also tested it, but expect you to use the splitted respin)

Regards,

Phil.
