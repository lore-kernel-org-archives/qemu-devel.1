Received: from eggs.gnu.org ([209.51.188.92]:39801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtFdj-0003YT-EA
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtFdi-000096-MY
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:45:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtFdi-00008h-FL
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:45:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id x7so126682wmj.0
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 09:45:06 -0800 (PST)
References: <1549694366-1284-1-git-send-email-thuth@redhat.com>
	<1549694366-1284-19-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <89cf88a6-d3c4-3034-02c2-13f1d0636f0c@redhat.com>
Date: Mon, 11 Feb 2019 18:45:03 +0100
MIME-Version: 1.0
In-Reply-To: <1549694366-1284-19-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 18/25] hw/arm: Express dependencies of
 canon-a1100 with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, yang.zhong@intel.com, pbonzini@redhat.com, qemu-arm@nongnu.org, Antony Pavlov <antonynpavlov@gmail.com>

On 2/9/19 7:39 AM, Thomas Huth wrote:
> Add Kconfig dependencies for the DIGIC / canon-a1100 machine.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak | 2 +-
>  hw/arm/Kconfig                  | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 6605786..20fcbcb 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -28,12 +28,12 @@ CONFIG_ASPEED_SOC=y
>  CONFIG_NETDUINO2=y
>  CONFIG_MPS2=y
>  CONFIG_RASPI=y
> +CONFIG_DIGIC=y
>  
>  CONFIG_VGA=y
>  CONFIG_SSI_M25P80=y
>  CONFIG_IMX_FEC=y
>  
> -CONFIG_DIGIC=y
>  CONFIG_NRF51_SOC=y
>  
>  CONFIG_FSL_IMX6=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 6b1522f..617a460 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -31,6 +31,7 @@ config CUBIEBOARD
>  config DIGIC
>      bool
>      select PTIMER
> +    select PFLASH_CFI02
>  
>  config EXYNOS4
>      bool
> 
