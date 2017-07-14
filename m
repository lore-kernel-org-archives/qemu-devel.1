Received: from eggs.gnu.org ([2001:4830:134:3::10]:53239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dW3T4-0005vR-Qz
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dW3T2-0000U1-8Z
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:29:26 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1500029487-14822-1-git-send-email-peter.maydell@linaro.org>
	<1500029487-14822-3-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5ffe6736-841e-a451-f0e6-c32b36302a0c@amsat.org>
Date: Fri, 14 Jul 2017 13:29:19 -0300
MIME-Version: 1.0
In-Reply-To: <1500029487-14822-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/9] hw/char/cmsdk-apb-uart.c: Implement
 CMSDK APB UART
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

Hi Peter,

On 07/14/2017 07:51 AM, Peter Maydell wrote:
> Implement a model of the simple "APB UART" provided in
> the Cortex-M System Design Kit (CMSDK).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/char/Makefile.objs            |   1 +
>   include/hw/char/cmsdk-apb-uart.h |  78 ++++++++
>   hw/char/cmsdk-apb-uart.c         | 402 +++++++++++++++++++++++++++++++++++++++
>   default-configs/arm-softmmu.mak  |   2 +
>   hw/char/trace-events             |   9 +
>   5 files changed, 492 insertions(+)
>   create mode 100644 include/hw/char/cmsdk-apb-uart.h
>   create mode 100644 hw/char/cmsdk-apb-uart.c
> 
> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> index 55fcb68..1bcd37e 100644
> --- a/hw/char/Makefile.objs
> +++ b/hw/char/Makefile.objs
> @@ -19,6 +19,7 @@ obj-$(CONFIG_DIGIC) += digic-uart.o
>   obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
>   obj-$(CONFIG_RASPI) += bcm2835_aux.o
>   
> +common-obj-$(CONFIG_CMSDK_APB_UART) += cmsdk-apb-uart.o
>   common-obj-$(CONFIG_ETRAXFS) += etraxfs_ser.o
>   common-obj-$(CONFIG_ISA_DEBUG) += debugcon.o
>   common-obj-$(CONFIG_GRLIB) += grlib_apbuart.o
[...]> diff --git a/default-configs/arm-softmmu.mak 
b/default-configs/arm-softmmu.mak
> index bfd2a88..d128e9d 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -96,6 +96,8 @@ CONFIG_STM32F2XX_ADC=y
>   CONFIG_STM32F2XX_SPI=y
>   CONFIG_STM32F205_SOC=y
>   
> +CONFIG_CMSDK_APB_UART=y

I'd prefer:

CONFIG_CMSDK_APB_UART=$(CONFIG_MPS2)

> +
>   CONFIG_VERSATILE_PCI=y
>   CONFIG_VERSATILE_I2C=y
[...]
