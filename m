Received: from eggs.gnu.org ([2001:4830:134:3::10]:53545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dW3U8-00071X-DN
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dW3U7-0000qE-JG
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:30:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1500029487-14822-1-git-send-email-peter.maydell@linaro.org>
	<1500029487-14822-5-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4eea5d43-b770-f543-b8f7-bce12378498a@amsat.org>
Date: Fri, 14 Jul 2017 13:30:27 -0300
MIME-Version: 1.0
In-Reply-To: <1500029487-14822-5-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/9] hw/char/cmsdk-apb-timer: Implement
 CMSDK APB timer device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Alistair Francis <alistair.francis@xilinx.com>

On 07/14/2017 07:51 AM, Peter Maydell wrote:
> Implement a model of the simple timer device found in the CMSDK.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/timer/Makefile.objs             |   1 +
>   include/hw/timer/cmsdk-apb-timer.h |  59 +++++++++
>   hw/timer/cmsdk-apb-timer.c         | 253 +++++++++++++++++++++++++++++++++++++
>   default-configs/arm-softmmu.mak    |   1 +
>   hw/timer/trace-events              |   5 +
>   5 files changed, 319 insertions(+)
>   create mode 100644 include/hw/timer/cmsdk-apb-timer.h
>   create mode 100644 hw/timer/cmsdk-apb-timer.c
> 
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index dd6f27e..15cce1c 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -41,3 +41,4 @@ common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
>   common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o
>   
>   common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
> +common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
[...]
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index d128e9d..c75f52c 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -96,6 +96,7 @@ CONFIG_STM32F2XX_ADC=y
>   CONFIG_STM32F2XX_SPI=y
>   CONFIG_STM32F205_SOC=y
>   
> +CONFIG_CMSDK_APB_TIMER=y

and here:

CONFIG_CMSDK_APB_TIMER=$(CONFIG_MPS2)

>   CONFIG_CMSDK_APB_UART=y
>   
>   CONFIG_VERSATILE_PCI=y
[...]
