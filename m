Received: from eggs.gnu.org ([209.51.188.92]:33961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ggPR4-0006Ng-Bz
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ggPR3-0003fe-OC
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:34:58 -0500
References: <20190104175847.6290-1-philmd@redhat.com>
	<20190104175847.6290-14-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5b87c418-4260-eb4a-2918-b8105abd816d@redhat.com>
Date: Mon, 7 Jan 2019 08:34:39 +0100
MIME-Version: 1.0
In-Reply-To: <20190104175847.6290-14-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/16] hw/net/ne2000-isa: Add guards to the
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-trivial@nongnu.org, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>, Richard Henderson <rth@twiddle.net>, Jan Kiszka <jan.kiszka@web.de>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Rob Herring <robh@kernel.org>

On 2019-01-04 18:58, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/hw/net/ne2000-isa.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/include/hw/net/ne2000-isa.h b/include/hw/net/ne2000-isa.h
> index ff2bed9c95..527337c454 100644
> --- a/include/hw/net/ne2000-isa.h
> +++ b/include/hw/net/ne2000-isa.h
> @@ -6,6 +6,10 @@
>   * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
>   * See the COPYING file in the top-level directory.
>   */
> +
> +#ifndef HW_NET_NE2K_ISA_H
> +#define HW_NET_NE2K_ISA_H
> +
>  #include "hw/hw.h"
>  #include "hw/qdev.h"
>  #include "hw/isa/isa.h"
> @@ -31,3 +35,5 @@ static inline ISADevice *isa_ne2000_init(ISABus *bus,=
 int base, int irq,
>      }
>      return d;
>  }
> +
> +#endif
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
