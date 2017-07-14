Received: from eggs.gnu.org ([2001:4830:134:3::10]:60096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVsv3-00017R-Om
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 01:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVsv0-0007KA-KP
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 01:13:37 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
	<1499771839-32518-6-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <866ceb13-0f82-4bc7-b45d-4a48578f6919@amsat.org>
Date: Fri, 14 Jul 2017 02:13:30 -0300
MIME-Version: 1.0
In-Reply-To: <1499771839-32518-6-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 5/7] hw/arm/mps2: Add timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 07/11/2017 08:17 AM, Peter Maydell wrote:
> Add the CMSDK APB timers to the MPS2 board.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/arm/mps2.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
> index 1b60b12..b1a0df9 100644
> --- a/hw/arm/mps2.c
> +++ b/hw/arm/mps2.c
> @@ -33,6 +33,7 @@
>   #include "sysemu/sysemu.h"
>   #include "hw/misc/unimp.h"
>   #include "hw/char/cmsdk-apb-uart.h"
> +#include "hw/timer/cmsdk-apb-timer.h"
>   
>   typedef enum MPS2FPGAType {
>       FPGA_AN385,
> @@ -294,6 +295,9 @@ static void mps2_common_init(MachineState *machine)
>           g_assert_not_reached();
>       }
>   
> +    cmsdk_apb_timer_create(0x40000000, qdev_get_gpio_in(armv7m, 8), SYSCLK_FRQ);
> +    cmsdk_apb_timer_create(0x40001000, qdev_get_gpio_in(armv7m, 9), SYSCLK_FRQ);
> +
>       system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
>   
>       armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> 
