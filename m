Received: from eggs.gnu.org ([209.51.188.92]:33835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDVim-0007Fv-1G
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDVil-00070N-3T
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:58:03 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190204231815.29661-1-philmd@redhat.com>
	<20190204231815.29661-4-philmd@redhat.com>
Date: Mon, 08 Apr 2019 16:57:41 +0200
In-Reply-To: <20190204231815.29661-4-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 5 Feb 2019 00:18:07
	+0100")
Message-ID: <87bm1go87u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/11] hw/devices: Move TC6393XB
 declarations into a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Philippe =?utf-8?Q?Mathieu-?= =?utf-8?Q?Daud=C3=A9?= <f4bug@amsat.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> The TC6393XB_RAM definition introduced in 64b40bc54a9 is no
> more used since a0b753dfd39. Remove it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
[...]
> diff --git a/include/hw/display/tc6393xb.h b/include/hw/display/tc6393xb.h
> new file mode 100644
> index 0000000000..387c143b44
> --- /dev/null
> +++ b/include/hw/display/tc6393xb.h
> @@ -0,0 +1,26 @@
> +/*
> + * Toshiba TC6393XB I/O Controller.
> + * Found in Sharp Zaurus SL-6000 (tosa) or some
> + * Toshiba e-Series PDAs.
> + *
> + * Copyright (c) 2007 Herv=C3=A9 Poussineau
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_DISPLAY_TC6393XB_H
> +#define HW_DISPLAY_TC6393XB_H
> +
> +#include "exec/memory.h"
> +#include "hw/irq.h"
> +
> +typedef struct TC6393xbState TC6393xbState;
> +
> +TC6393xbState *tc6393xb_init(struct MemoryRegion *sysmem,
> +                             uint32_t base, qemu_irq irq);
> +void tc6393xb_gpio_out_set(TC6393xbState *s, int line, qemu_irq handler);
> +qemu_irq *tc6393xb_gpio_in_get(TC6393xbState *s);

These two are actually unused.  Just an observation; I don't think this
patch should do anything about it.

> +qemu_irq tc6393xb_l3v_get(TC6393xbState *s);
> +
> +#endif
