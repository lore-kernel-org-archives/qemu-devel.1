Received: from eggs.gnu.org ([209.51.188.92]:41413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk3o6-0003PF-5N
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:17:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk3o4-0004Zo-5u
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:17:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gk3o1-0004IU-OM
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:17:46 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-20-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6aaf7d2d-42d4-aaca-7634-4c44b9164c42@redhat.com>
Date: Thu, 17 Jan 2019 10:17:37 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-20-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 19/37] kconfig: introduce kconfig
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com

On 2019-01-15 15:10, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
>=20
> The Kconfig files were generated mostly with this script:
>=20
>   for i in `grep -ho CONFIG_[A-Z0-9_]* default-configs/* | sort -u`; do
>     set fnord `git grep -lw $i -- 'hw/*/Makefile.objs' `
>     shift
>     if test $# =3D 1; then
>       cat >> $(dirname $1)/Kconfig << EOF
> config ${i#CONFIG_}
>     bool
>=20
> EOF
>       git add $(dirname $1)/Kconfig
>     else
>       echo $i $*
>     fi
>   done
>   sed -i '$d' hw/*/Kconfig
>   for i in hw/*; do
>     if test -d $i && ! test -f $i/Kconfig; then
>       touch $i/Kconfig
>       git add $i/Kconfig
>     fi
>   done
>=20
> Whenever a symbol is referenced from multiple subdirectories, the
> script prints the list of directories that reference the symbol.
> These symbols have to be added manually to the Kconfig files.
>=20
> Kconfig.host and hw/Kconfig were created manually.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
[...]
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> new file mode 100644
> index 0000000000..34e4a32a71
> --- /dev/null
> +++ b/hw/arm/Kconfig
> @@ -0,0 +1,98 @@
> +config VIRT
> +    bool
> +
> +config DIGIC
> +    bool
> +
> +config EXYNOS4
> +    bool
> +
> +config HIGHBANK
> +    bool
> +
> +config INTEGRATOR
> +    bool
> +
> +config MAINSTONE
> +    bool
> +
> +config MUSICPAL
> +    bool
> +
> +config NETDUINO2
> +    bool
> +
> +config NSERIES
> +    bool
> +
> +config OMAP
> +    bool
> +
> +config PXA2XX
> +    bool
> +
> +config REALVIEW
> +    bool
> +
> +config STELLARIS
> +    bool
> +
> +config STRONGARM
> +    bool
> +
> +config VERSATILE
> +    bool
> +
> +config ZYNQ
> +    bool
> +
> +config ARM_V7M
> +    bool
> +
> +config EXYNOS4
> +    bool
> +
> +config ALLWINNER_A10
> +    bool
> +
> +config RASPI
> +    bool
> +
> +config STM32F205_SOC
> +    bool
> +
> +config XLNX_ZYNQMP_ARM
> +    bool
> +
> +config XLNX_VERSAL
> +    bool
> +
> +config FSL_IMX25
> +    bool
> +
> +config FSL_IMX31
> +    bool
> +
> +config FSL_IMX6
> +    bool
> +
> +config ASPEED_SOC
> +    bool
> +
> +config MPS2
> +    bool
> +
> +config IOTKIT
> +    bool
> +
> +config FSL_IMX7
> +    bool
> +
> +config ARM_SMMUV3
> +    bool
> +
> +config FSL_IMX6UL
> +    bool
> +
> +config NRF51_SOC
> +    bool

After playing with your patch series a little bit, I think we also need
the following config options here for arm:

config MSF2
    bool

config ZAURUS
    bool

config A9MPCORE
    bool

config A15MPCORE
    bool

config ARM11MPCORE
    bool

Could you please add them in v3?

> diff --git a/hw/nios2/Kconfig b/hw/nios2/Kconfig
> new file mode 100644
> index 0000000000..986c1cc0a1
> --- /dev/null
> +++ b/hw/nios2/Kconfig
> @@ -0,0 +1,2 @@
> +config NIOS2_10M50_BOARD
> +    bool

Some Makefiles use CONFIG_NIOS2, so we also need:

config NIOS2
    bool

> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> new file mode 100644
> index 0000000000..44b01acdd9
> --- /dev/null
> +++ b/hw/ppc/Kconfig
> @@ -0,0 +1,38 @@
> +config PSERIES
> +    bool
> +
> +config SPAPR_RNG
> +    bool
> +
> +config POWERNV
> +    bool
> +
> +config PPC405
> +    bool
> +
> +config PPC440
> +    bool
> +
> +config PPC4XX
> +    bool
> +
> +config SAM460EX
> +    bool
> +
> +config PREP
> +    bool
> +
> +config RS6000_MC
> +    bool
> +
> +config MAC_OLDWORLD
> +    bool
> +
> +config MAC_NEWWORLD
> +    bool
> +
> +config E500
> +    bool
> +
> +config VIRTEX
> +    bool

When I tried to compile the ppc part, I found out that the following
config options are still missing for ppc:

config MAC_DBDMA
    bool

config MAC_PMU
    bool

config XIVE
    bool

config MACIO_GPIO
    bool

config XIVE_SPAPR
    bool

config CUDA
    bool

Could you please add them in v3?

> diff --git a/hw/sh4/Kconfig b/hw/sh4/Kconfig
> new file mode 100644
> index 0000000000..b2faf1489e
> --- /dev/null
> +++ b/hw/sh4/Kconfig
> @@ -0,0 +1,8 @@
> +config R2D
> +    bool
> +
> +config SHIX
> +    bool
> +
> +config SH7750
> +    bool

Some Makefiles also use CONFIG_SH4, so please add:

config SH4
    bool

> diff --git a/hw/smbios/Kconfig b/hw/smbios/Kconfig
> new file mode 100644
> index 0000000000..553adf4bfc
> --- /dev/null
> +++ b/hw/smbios/Kconfig
> @@ -0,0 +1,2 @@
> +config SMBIOS
> +    bool
> diff --git a/hw/sparc/Kconfig b/hw/sparc/Kconfig
> new file mode 100644
> index 0000000000..529fca328f
> --- /dev/null
> +++ b/hw/sparc/Kconfig
> @@ -0,0 +1,5 @@
> +config SUN4M
> +    bool
> +
> +config LEON3
> +    bool

For sparc, we also need:

config GRLIB
    bool

config SLAVIO
    bool

 Thanks,
  Thomas
