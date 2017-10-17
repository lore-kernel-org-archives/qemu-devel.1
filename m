Received: from eggs.gnu.org ([2001:4830:134:3::10]:39915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4bPW-0002Ui-VZ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 19:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4bPV-0005QG-OG
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 19:36:34 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:50200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4bPV-0005Px-JW
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 19:36:33 -0400
Received: by mail-io0-x242.google.com with SMTP id 97so4108298iok.7
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 16:36:33 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <ef4e172df6cdf3d9ee8bb3aa896cacab5efdd1f1.1508279421.git.alistair.francis@xilinx.com>
References: <cover.1508279421.git.alistair.francis@xilinx.com>
	<ef4e172df6cdf3d9ee8bb3aa896cacab5efdd1f1.1508279421.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 17 Oct 2017 20:36:32 -0300
Message-ID: <CAAdtpL7R_xb7PX9_L95BBhv+VL5LabaC1mkf=cMWNGL10YJRAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/5] bcm2836: Use the Cortex-A7 instead
 of Cortex-A15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alistair Francis <alistair23@gmail.com>

On Tue, Oct 17, 2017 at 7:31 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> The BCM2836 uses a Cortex-A7 not a Cortex-A15. Update the device to use
> the correct CPU.
> https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2836/QA=
7_rev3.4.pdf
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
> V3:
>  - Use ARM_CPU_TYPE_NAME() macro
> V2:
>  - Fix the BCM2836 CPU
>
>  hw/arm/bcm2836.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 8c43291112..c477772484 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -30,7 +30,7 @@ static void bcm2836_init(Object *obj)
>
>      for (n =3D 0; n < BCM2836_NCPUS; n++) {
>          object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
> -                          "cortex-a15-" TYPE_ARM_CPU);
> +                          ARM_CPU_TYPE_NAME("cortex-a7"));
>          object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
>                                    &error_abort);
>      }
> --
> 2.11.0
>
>
