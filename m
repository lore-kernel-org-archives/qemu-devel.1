Received: from eggs.gnu.org ([209.51.188.92]:57263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hHOdh-0007sl-GJ
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 04:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hHOdg-0008TR-Jk
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 04:12:53 -0400
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:57223)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hHOdg-0008SU-CK
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 04:12:52 -0400
Received: from player699.ha.ovh.net (unknown [10.109.160.253])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 2890BFAAE7
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 10:12:49 +0200 (CEST)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-16-thuth@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <46e2a455-45ef-a5b2-7bdb-f0d67ab270ba@kaod.org>
Date: Fri, 19 Apr 2019 10:12:20 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-16-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 15/29] hw/arm: Express
 dependencies of the aspeed boards with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: Beniamino Galvani <b.galvani@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Antony Pavlov <antonynpavlov@gmail.com>, Peter Chubb <peter.chubb@nicta.com.au>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, John Snow <jsnow@redhat.com>, Joel Stanley <joel@jms.id.au>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Alistair Francis <alistair@alistair23.me>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Dependencies have been determined by looking at hw/arm/aspeed.c

Looks correct to me.=20

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks Thomas,

C.

>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak |  7 +------
>  hw/arm/Kconfig                  | 10 ++++++++++
>  2 files changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-soft=
mmu.mak
> index 25e8f717ac..2580584281 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -26,15 +26,12 @@ CONFIG_SPITZ=3Dy
>  CONFIG_TOSA=3Dy
>  CONFIG_Z2=3Dy
>  CONFIG_COLLIE=3Dy
> +CONFIG_ASPEED_SOC=3Dy
> =20
>  CONFIG_VGA=3Dy
> -CONFIG_TMP421=3Dy
> -CONFIG_PCA9552=3Dy
>  CONFIG_SSI_M25P80=3Dy
>  CONFIG_ALLWINNER_EMAC=3Dy
>  CONFIG_IMX_FEC=3Dy
> -CONFIG_FTGMAC100=3Dy
> -CONFIG_DS1338=3Dy
>  CONFIG_PLATFORM_BUS=3Dy
>  CONFIG_VIRTIO_MMIO=3Dy
> =20
> @@ -92,8 +89,6 @@ CONFIG_I82801B11=3Dy
>  CONFIG_ACPI=3Dy
>  CONFIG_ARM_VIRT=3Dy
>  CONFIG_SMBIOS=3Dy
> -CONFIG_ASPEED_SOC=3Dy
> -CONFIG_SMBUS_EEPROM=3Dy
>  CONFIG_GPIO_KEY=3Dy
>  CONFIG_MSF2=3Dy
>  CONFIG_FW_CFG_DMA=3Dy
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 325133c129..abeaa54d88 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -254,6 +254,16 @@ config FSL_IMX6
> =20
>  config ASPEED_SOC
>      bool
> +    select DS1338
> +    select FTGMAC100
> +    select I2C
> +    select PCA9552
> +    select SERIAL
> +    select SMBUS_EEPROM
> +    select SSI
> +    select SSI_M25P80
> +    select TMP105
> +    select TMP421
> =20
>  config MPS2
>      bool
>=20
