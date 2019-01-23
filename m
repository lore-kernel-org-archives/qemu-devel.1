Received: from eggs.gnu.org ([209.51.188.92]:54838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmC7P-00076F-HM
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmBtM-0004X3-8o
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:20:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmBtL-0004Up-W1
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:20:04 -0500
References: <20190122162924.26491-1-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a60dbcd8-df39-ebe9-a86b-92bc468b8ec2@redhat.com>
Date: Wed, 23 Jan 2019 07:19:57 +0100
MIME-Version: 1.0
In-Reply-To: <20190122162924.26491-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: update microbit ARM board
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com, contrib@steffen-goertz.de, joel@jms.id.au, jusual@mail.ru

On 2019-01-22 17:29, Stefan Hajnoczi wrote:
> New source files were added without corresponding ./MAINTAINERS file
> entries.  Let's get things up to date.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> This also includes the I2C/TWI stub which Peter has merged into his
> target-arm.next tree but isn't in qemu.git/master yet.
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af339b86db..e3cb67e81d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -833,7 +833,19 @@ L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/nrf51_soc.c
>  F: hw/arm/microbit.c
> +F: hw/char/nrf51_uart.c
> +F: hw/gpio/nrf51_gpio.c
> +F: hw/i2c/microbit_i2c.c
> +F: hw/misc/nrf51_rng.c
> +F: hw/timer/nrf51_timer.c
>  F: include/hw/arm/nrf51_soc.h
> +F: include/hw/arm/nrf51.h
> +F: include/hw/char/nrf51_uart.h
> +F: include/hw/gpio/nrf51_gpio.h
> +F: include/hw/i2c/microbit_i2c.h
> +F: include/hw/misc/nrf51_rng.h
> +F: include/hw/timer/nrf51_timer.h
> +F: tests/microbit-test.c

Looks like using wildcards would be easier here:

F: hw/*/nrf51*.c
F: hw/*/microbit*.c
F: include/hw/*/nrf51*.h
...

?

Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
