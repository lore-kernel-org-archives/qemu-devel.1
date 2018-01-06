Received: from eggs.gnu.org ([2001:4830:134:3::10]:46400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eXe5g-0006US-Tt
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 21:20:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eXe5g-0004nT-0P
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 21:20:08 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180104144046.30793-4-f4bug@amsat.org>
References: <20180104144046.30793-1-f4bug@amsat.org>
	<20180104144046.30793-4-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 5 Jan 2018 18:19:35 -0800
Message-ID: <CAKmqyKOfGcNAGVvdmEohB79_w8a=Hr2xsuXT=56Q_d+EeijRAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 3/6] hw/char/cadence_uart: add FDT
 aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Fam Zheng <famz@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jan 4, 2018 at 6:40 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/char/cadence_uart.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
> index 6143494060..6880827947 100644
> --- a/hw/char/cadence_uart.c
> +++ b/hw/char/cadence_uart.c
> @@ -552,6 +552,13 @@ static void cadence_uart_class_init(ObjectClass *kla=
ss, void *data)
>
>  static const TypeInfo cadence_uart_info =3D {
>      .name          =3D TYPE_CADENCE_UART,
> +    .aliases       =3D (const char * []) {
> +                        "cdns,uart-r1p8",
> +                        "xlnx,xuartps",     /* Zynq-7xxx SoC */
> +                        "cdns,uart-r1p12",
> +                        "xlnx,zynqmp-uart", /* Zynq Ultrascale+ MPSoC */
> +                        NULL
> +                     },
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(CadenceUARTState),
>      .instance_init =3D cadence_uart_init,
> --
> 2.15.1
>
>
