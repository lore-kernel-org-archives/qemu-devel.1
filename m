Received: from eggs.gnu.org ([2001:4830:134:3::10]:40237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee7Kl-0004JC-MN
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee7Kj-0003Y0-U1
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:46:27 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123030630.26613-9-f4bug@amsat.org>
References: <20180123030630.26613-1-f4bug@amsat.org>
	<20180123030630.26613-9-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 23 Jan 2018 14:45:53 -0800
Message-ID: <CAKmqyKMBYoNqUVALJzpg8b=LtXr7wrOkMLiMeqhoe8rrMq0sNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 08/14] hw/arm/bcm2835_peripherals:
 change maximum block size to 1kB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, "open list:ARM" <qemu-arm@nongnu.org>

On Mon, Jan 22, 2018 at 7:06 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> following the datasheet.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/arm/bcm2835_peripherals.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 0570cc4ad3..6b86a99b14 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -19,7 +19,7 @@
>  #define BCM2835_VC_PERI_BASE 0x7e000000
>
>  /* Capabilities for SD controller: no DMA, high-speed, default clocks et=
c. */
> -#define BCM2835_SDHC_CAPAREG 0x52034b4
> +#define BCM2835_SDHC_CAPAREG 0x52134b4
>
>  static void bcm2835_peripherals_init(Object *obj)
>  {
> --
> 2.15.1
>
>
