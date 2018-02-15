Received: from eggs.gnu.org ([2001:4830:134:3::10]:38419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emHjI-0005bU-PQ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 06:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emHjH-0008Uz-Qv
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 06:29:32 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:42060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emHjH-0008Uj-LQ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 06:29:31 -0500
Received: by mail-ot0-x244.google.com with SMTP id a7so23109384otk.9
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 03:29:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fa1d4990d897f61dd748ad7f10f6b88435e6cb46.1517532021.git.alistair.francis@xilinx.com>
References: <cover.1517532021.git.alistair.francis@xilinx.com>
	<fa1d4990d897f61dd748ad7f10f6b88435e6cb46.1517532021.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 11:29:10 +0000
Message-ID: <CAFEAcA_T4S8kU5GtatL+1Uos2oqBuYH-=GqhEWm=y3q4TmF+-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 4/6] raspi: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 2 February 2018 at 00:42, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> List all possible valid CPU options.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>
> V5:
>  - Use cpu_model names
> V4:
>  - Remove spaces
> V3:
>  - Add static property
> V2:
>  - Fix the indentation
>
>  hw/arm/raspi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index cd5fa8c3dc..745a880726 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -158,6 +158,11 @@ static void raspi2_init(MachineState *machine)
>      setup_boot(machine, 2, machine->ram_size - vcram_size);
>  }
>
> +static const char *raspi2_valid_cpus[] =3D {
> +    "cortex-a7",
> +    NULL
> +};

Is this definitely right? Looking at the code, the raspi2 board
creates a TYPE_BCM2836, and that creates cortex-a15 CPUs...

thanks
-- PMM
