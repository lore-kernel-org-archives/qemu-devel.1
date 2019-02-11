Received: from eggs.gnu.org ([209.51.188.92]:39061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtFan-0002QJ-Ib
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtFam-0007V8-TS
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:42:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtFam-0007UF-O3
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:42:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so90521wmh.4
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 09:42:04 -0800 (PST)
References: <1549694366-1284-1-git-send-email-thuth@redhat.com>
	<1549694366-1284-21-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7aefa814-491d-2a5b-e940-5a7c3e6fbde5@redhat.com>
Date: Mon, 11 Feb 2019 18:42:00 +0100
MIME-Version: 1.0
In-Reply-To: <1549694366-1284-21-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/25] hw/arm: Express dependencies of the
 MSF2 machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: yang.zhong@intel.com, qemu-arm@nongnu.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>

Hi Thomas,

On 2/9/19 7:39 AM, Thomas Huth wrote:
> Add Kconfig dependencies for the emcraft-sf2 machine.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 3 +--
>  hw/arm/Kconfig                  | 4 ++++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index f6193b1..729e4b8 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -30,9 +30,9 @@ CONFIG_MPS2=y
>  CONFIG_RASPI=y
>  CONFIG_DIGIC=y
>  CONFIG_SABRELITE=y
> +CONFIG_MSF2=y
>  
>  CONFIG_VGA=y
> -CONFIG_SSI_M25P80=y
>  CONFIG_IMX_FEC=y
>  
>  CONFIG_NRF51_SOC=y
> @@ -45,5 +45,4 @@ CONFIG_PCIE_PORT=y
>  CONFIG_XIO3130=y
>  CONFIG_IOH3420=y
>  CONFIG_I82801B11=y
> -CONFIG_MSF2=y
>  CONFIG_PCI_EXPRESS_DESIGNWARE=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index d98d39e..7823a16 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -362,7 +362,11 @@ config NRF51_SOC
>  

I'd split the SoC:

>  config MSF2
>      bool
> +    select ARM_V7M
>      select PTIMER
> +    select SERIAL
> +    select SSI

from the board, moving SSI_M25P80 to:

config EMCRAFT_SF2
    bool
    select MSF2
    select SSI_M25P80

>  
>  config ZAURUS
>      bool
> 
