Received: from eggs.gnu.org ([2001:4830:134:3::10]:38597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWWZw-0007QL-63
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:06:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWWZv-0002TE-C2
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:06:44 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eWWZv-0002Sh-5v
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:06:43 -0500
Received: by mail-wr0-x244.google.com with SMTP id o15so60081wrf.12
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 16:06:43 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171229174933.1781-4-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
	<20171229174933.1781-4-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 2 Jan 2018 16:06:11 -0800
Message-ID: <CAKmqyKP_WA0Ziso09kXOZ5jXZV+b04jkkmqzuwa2v6jzyA5T6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/42] sdhci: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Dec 29, 2017 at 9:48 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  include/hw/sd/sdhci.h | 2 --
>  hw/sd/sdhci.c         | 2 --
>  2 files changed, 4 deletions(-)
>
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index 749cc279ed..a6fe064f51 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -44,8 +44,6 @@ typedef struct SDHCIState {
>
>      QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
>      QEMUTimer *transfer_timer;
> -    qemu_irq eject_cb;
> -    qemu_irq ro_cb;
>      qemu_irq irq;
>
>      /* Registers cleared on reset */
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index b7d2a20985..365bc80009 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1200,8 +1200,6 @@ static void sdhci_uninitfn(SDHCIState *s)
>      timer_free(s->insert_timer);
>      timer_del(s->transfer_timer);
>      timer_free(s->transfer_timer);
> -    qemu_free_irq(s->eject_cb);
> -    qemu_free_irq(s->ro_cb);
>
>      g_free(s->fifo_buffer);
>      s->fifo_buffer =3D NULL;
> --
> 2.15.1
>
>
