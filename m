Received: from eggs.gnu.org ([2001:4830:134:3::10]:56953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj1VQ-0007Xk-RG
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj1VN-0000ZC-Lv
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:06:00 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180727113854.20283-1-peter.maydell@linaro.org>
	<20180727113854.20283-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9c2441dd-717d-0272-e386-a936bf3da17f@amsat.org>
Date: Fri, 27 Jul 2018 09:05:52 -0300
MIME-Version: 1.0
In-Reply-To: <20180727113854.20283-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-3.0 2/2] hw/arm/iotkit: Fix
 IRQ number for timer1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On 07/27/2018 08:38 AM, Peter Maydell wrote:
> A cut-and-paste error meant we were incorrectly wiring up the timer1
> IRQ to IRQ3. IRQ3 is the interrupt for timer0 -- move timer0 to
> IRQ4 where it belongs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
(ARM-ECM-0601256 Table 66 Interrupt Map)

> ---
>  hw/arm/iotkit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
> index c76d3ed7435..8cadc8b1608 100644
> --- a/hw/arm/iotkit.c
> +++ b/hw/arm/iotkit.c
> @@ -382,7 +382,7 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer1), 0,
> -                       qdev_get_gpio_in(DEVICE(&s->armv7m), 3));
> +                       qdev_get_gpio_in(DEVICE(&s->armv7m), 4));
>      mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->timer1), 0);
>      object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[1]", &err);
>      if (err) {
> 
