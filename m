Received: from eggs.gnu.org ([209.51.188.92]:43322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hElmB-0000HR-SZ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hElmB-0001lE-1t
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:18:47 -0400
MIME-Version: 1.0
References: <20190411161013.4514-1-clg@kaod.org>
	<20190411161013.4514-3-clg@kaod.org>
In-Reply-To: <20190411161013.4514-3-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 12 Apr 2019 02:18:32 +0000
Message-ID: <CACPK8XezRXPFFiiK7_xXLs-ipnfw9400E1dSRHN0XnF2cc4=vA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] aspeed: add a per SoC mapping for the
 memory space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>

On Thu, 11 Apr 2019 at 16:10, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> This will simplify the definition of new SoCs, like the AST2600 which
> should use a slightly different address space and have a different set
> of controllers.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 5bbd1fb87d18..9b601709e93c 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c

> +static const hwaddr aspeed_soc_ast2400_memmap[] =3D {

> +static const hwaddr aspeed_soc_ast2500_memmap[] =3D {

Most of these arrays is common. And some of it will stay common in the
2600. Any ideas how we could avoid duplication?

This is fine for now.

Reviewed-by: Joel Stanley <joel@jms.id.au>
