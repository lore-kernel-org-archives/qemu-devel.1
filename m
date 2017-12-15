Received: from eggs.gnu.org ([2001:4830:134:3::10]:56405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePeKu-0004E0-KQ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePeKt-0007vy-WE
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:58:48 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213204436.5379-3-f4bug@amsat.org>
References: <20171213204436.5379-1-f4bug@amsat.org>
	<20171213204436.5379-3-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 16:58:13 -0800
Message-ID: <CAKmqyKNq92a3P-M9x3P2sRBHEq7QuyRqvbSyOFgUQLrN_ejVPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/11] bcm2835_peripherals: move GPIO
 'sdbus' property link from init() -> realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 12:44 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> We can then use dynamic sdbus creation (from realized HCI devices).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/arm/bcm2835_peripherals.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 12e0dd11af..7f30f19c4c 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -112,11 +112,6 @@ static void bcm2835_peripherals_init(Object *obj)
>      object_initialize(&s->gpio, sizeof(s->gpio), TYPE_BCM2835_GPIO);
>      object_property_add_child(obj, "gpio", OBJECT(&s->gpio), NULL);
>      qdev_set_parent_bus(DEVICE(&s->gpio), sysbus_get_default());
> -
> -    object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
> -                                   OBJECT(&s->sdhci.sdbus), &error_abort=
);
> -    object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
> -                                   OBJECT(&s->sdhost.sdbus), &error_abor=
t);
>  }
>
>  static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
> @@ -314,6 +309,10 @@ static void bcm2835_peripherals_realize(DeviceState =
*dev, Error **errp)
>      }
>
>      /* GPIO */
> +    object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
> +                                   OBJECT(&s->sdhci.sdbus), &error_abort=
);
> +    object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
> +                                   OBJECT(&s->sdhost.sdbus), &error_abor=
t);
>      object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
>      if (err) {
>          error_propagate(errp, err);
> --
> 2.15.1
>
>
