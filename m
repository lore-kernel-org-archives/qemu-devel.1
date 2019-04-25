Received: from eggs.gnu.org ([209.51.188.92]:35092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJmXF-0000eg-Eb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJmJX-0006YZ-N6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:53:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJmJX-0006XB-52
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:53:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id c12so1433446wrt.8
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 14:53:54 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-20-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8c7e6aa5-3f74-7c63-486c-80e3e21e9da5@redhat.com>
Date: Thu, 25 Apr 2019 23:53:51 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-20-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 19/29] hw/arm: Express
 dependencies of the MPS2 boards with Kconfig
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
> Add Kconfig dependencies for the mps2-an* machines.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 20 +-------------------
>  hw/arm/Kconfig                  | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index a0b9016e3a..31d31d3f4a 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -30,6 +30,7 @@ CONFIG_Z2=y
>  CONFIG_COLLIE=y
>  CONFIG_ASPEED_SOC=y
>  CONFIG_NETDUINO2=y
> +CONFIG_MPS2=y
>  
>  CONFIG_VGA=y
>  CONFIG_SSI_M25P80=y
> @@ -38,28 +39,9 @@ CONFIG_IMX_FEC=y
>  CONFIG_FRAMEBUFFER=y
>  
>  CONFIG_DIGIC=y
> -CONFIG_MPS2=y
>  CONFIG_RASPI=y
>  CONFIG_NRF51_SOC=y
>  
> -CONFIG_CMSDK_APB_TIMER=y
> -CONFIG_CMSDK_APB_DUALTIMER=y
> -CONFIG_CMSDK_APB_UART=y
> -CONFIG_CMSDK_APB_WATCHDOG=y
> -
> -CONFIG_MPS2_FPGAIO=y
> -CONFIG_MPS2_SCC=y
> -
> -CONFIG_TZ_MPC=y
> -CONFIG_TZ_MSC=y
> -CONFIG_TZ_PPC=y
> -CONFIG_ARMSSE=y
> -CONFIG_IOTKIT_SECCTL=y
> -CONFIG_IOTKIT_SYSCTL=y
> -CONFIG_IOTKIT_SYSINFO=y
> -CONFIG_ARMSSE_CPUID=y
> -CONFIG_ARMSSE_MHU=y
> -
>  CONFIG_FSL_IMX6=y
>  CONFIG_FSL_IMX25=y
>  CONFIG_FSL_IMX7=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 2ef5696900..466b143fdf 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -301,6 +301,12 @@ config ASPEED_SOC
>  
>  config MPS2
>      bool
> +    select ARMSSE
> +    select LAN9118
> +    select MPS2_FPGAIO
> +    select MPS2_SCC
> +    select PL022    # Serial port
> +    select PL080    # DMA controller
>  
>  config FSL_IMX7
>      bool
> @@ -340,6 +346,18 @@ config ARM11MPCORE
>  
>  config ARMSSE
>      bool
> +    select ARMSSE_CPUID
> +    select ARMSSE_MHU
> +    select CMSDK_APB_TIMER
> +    select CMSDK_APB_DUALTIMER
> +    select CMSDK_APB_UART
> +    select CMSDK_APB_WATCHDOG
> +    select IOTKIT_SECCTL
> +    select IOTKIT_SYSCTL
> +    select IOTKIT_SYSINFO
> +    select TZ_MPC
> +    select TZ_MSC
> +    select TZ_PPC
>  
>  config ARMSSE_CPUID
>      bool
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
