Received: from eggs.gnu.org ([2001:4830:134:3::10]:53757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW3Uy-0007W6-AR
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW3Ux-0001Qm-Fp
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:31:24 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dW3Ux-0001QX-AY
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:31:23 -0400
Received: by mail-wr0-x229.google.com with SMTP id k67so69618747wrc.2
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 09:31:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5ffe6736-841e-a451-f0e6-c32b36302a0c@amsat.org>
References: <1500029487-14822-1-git-send-email-peter.maydell@linaro.org>
	<1500029487-14822-3-git-send-email-peter.maydell@linaro.org>
	<5ffe6736-841e-a451-f0e6-c32b36302a0c@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 17:31:01 +0100
Message-ID: <CAFEAcA8KrH5yd9t+6AMo-kBNPs7kZP8fuzyfva_Gx2GJzJcrDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>

On 14 July 2017 at 17:29, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Hi Peter,
>
> On 07/14/2017 07:51 AM, Peter Maydell wrote:
>>
>> Implement a model of the simple "APB UART" provided in
>> the Cortex-M System Design Kit (CMSDK).
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   hw/char/Makefile.objs            |   1 +
>>   include/hw/char/cmsdk-apb-uart.h |  78 ++++++++
>>   hw/char/cmsdk-apb-uart.c         | 402
>> +++++++++++++++++++++++++++++++++++++++
>>   default-configs/arm-softmmu.mak  |   2 +
>>   hw/char/trace-events             |   9 +
>>   5 files changed, 492 insertions(+)
>>   create mode 100644 include/hw/char/cmsdk-apb-uart.h
>>   create mode 100644 hw/char/cmsdk-apb-uart.c
>>
>> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
>> index 55fcb68..1bcd37e 100644
>> --- a/hw/char/Makefile.objs
>> +++ b/hw/char/Makefile.objs
>> @@ -19,6 +19,7 @@ obj-$(CONFIG_DIGIC) +=3D digic-uart.o
>>   obj-$(CONFIG_STM32F2XX_USART) +=3D stm32f2xx_usart.o
>>   obj-$(CONFIG_RASPI) +=3D bcm2835_aux.o
>>   +common-obj-$(CONFIG_CMSDK_APB_UART) +=3D cmsdk-apb-uart.o
>>   common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_ser.o
>>   common-obj-$(CONFIG_ISA_DEBUG) +=3D debugcon.o
>>   common-obj-$(CONFIG_GRLIB) +=3D grlib_apbuart.o
>
> [...]> diff --git a/default-configs/arm-softmmu.mak
> b/default-configs/arm-softmmu.mak
>>
>> index bfd2a88..d128e9d 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -96,6 +96,8 @@ CONFIG_STM32F2XX_ADC=3Dy
>>   CONFIG_STM32F2XX_SPI=3Dy
>>   CONFIG_STM32F205_SOC=3Dy
>>   +CONFIG_CMSDK_APB_UART=3Dy
>
>
> I'd prefer:
>
> CONFIG_CMSDK_APB_UART=3D$(CONFIG_MPS2)

That would just need changing when we add the next
board that uses this UART. None of the other config switches
in this file set themselves based on a board config switch.

thanks
-- PMM
