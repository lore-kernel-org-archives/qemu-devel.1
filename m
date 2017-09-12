Received: from eggs.gnu.org ([2001:4830:134:3::10]:43492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1drv2L-0006o7-0h
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 19:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1drv2K-0000qT-44
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 19:56:13 -0400
MIME-Version: 1.0
In-Reply-To: <1505232834-20890-1-git-send-email-peter.maydell@linaro.org>
References: <1505232834-20890-1-git-send-email-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 12 Sep 2017 16:55:40 -0700
Message-ID: <CAKmqyKP7cPa66H84Em3LiJqrQUYm8s3kPkWBpVvxFHmMH6ZKdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] mps2-an511: Fix wiring of UART overflow
 interrupt lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-stable@nongnu.org, Patch Tracking <patches@linaro.org>

On Tue, Sep 12, 2017 at 9:13 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> Fix an error that meant we were wiring every UART's overflow
> interrupts into the same inputs 0 and 1 of the OR gate,
> rather than giving each its own input.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  hw/arm/mps2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
> index abb0ab6..769cff8 100644
> --- a/hw/arm/mps2.c
> +++ b/hw/arm/mps2.c
> @@ -287,8 +287,8 @@ static void mps2_common_init(MachineState *machine)
>              cmsdk_apb_uart_create(uartbase[i],
>                                    qdev_get_gpio_in(txrx_orgate_dev, 0),
>                                    qdev_get_gpio_in(txrx_orgate_dev, 1),
> -                                  qdev_get_gpio_in(orgate_dev, 0),
> -                                  qdev_get_gpio_in(orgate_dev, 1),
> +                                  qdev_get_gpio_in(orgate_dev, i * 2),
> +                                  qdev_get_gpio_in(orgate_dev, i * 2 + 1),
>                                    NULL,
>                                    uartchr, SYSCLK_FRQ);
>          }
> --
> 2.7.4
>
>
