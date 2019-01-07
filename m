Received: from eggs.gnu.org ([209.51.188.92]:35070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ggPUt-0008Bn-Hb
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ggPUs-0006ay-Sf
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:38:55 -0500
References: <20190104175847.6290-1-philmd@redhat.com>
	<20190104175847.6290-16-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3d94c028-7163-4bdb-0006-5fb09e6cb152@redhat.com>
Date: Mon, 7 Jan 2019 08:38:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190104175847.6290-16-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/16] hw/devices: Move SMSC 91C111
 declaration into a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>, Richard Henderson <rth@twiddle.net>, Jan Kiszka <jan.kiszka@web.de>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Rob Herring <robh@kernel.org>

On 2019-01-04 18:58, Philippe Mathieu-Daud=C3=A9 wrote:
> This commit finally deletes "hw/devices.h".
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/arm/gumstix.c           |  2 +-
>  hw/arm/integratorcp.c      |  2 +-
>  hw/arm/mainstone.c         |  2 +-
>  hw/arm/realview.c          |  2 +-
>  hw/arm/versatilepb.c       |  2 +-
>  hw/net/smc91c111.c         |  2 +-
>  include/hw/devices.h       | 11 -----------
>  include/hw/net/smc91c111.h | 18 ++++++++++++++++++
>  8 files changed, 24 insertions(+), 17 deletions(-)
>  delete mode 100644 include/hw/devices.h
>  create mode 100644 include/hw/net/smc91c111.h
[...]
> diff --git a/include/hw/net/smc91c111.h b/include/hw/net/smc91c111.h
> new file mode 100644
> index 0000000000..46f7d9a5d4
> --- /dev/null
> +++ b/include/hw/net/smc91c111.h
> @@ -0,0 +1,18 @@
> +/*
> + * SMSC 91C111 Ethernet interface emulation
> + *
> + * Copyright (c) 2005 CodeSourcery, LLC.
> + * Written by Paul Brook
> + *
> + * This code is licensed under the GPL

I'd like to suggest to use here GPLv2+, too, since just "GPL" is quite
inaccurate.

> + */
> +
> +#ifndef HW_NET_SMC91C111_H
> +#define HW_NET_SMC91C111_H
> +
> +#include "hw/irq.h"
> +#include "net/net.h"
> +
> +void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
> +
> +#endif
>=20

 Thomas
