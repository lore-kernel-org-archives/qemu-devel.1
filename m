Received: from eggs.gnu.org ([209.51.188.92]:52155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1hEmoM-0001sV-1G
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1hEmoL-0004V5-6Q
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:25:06 -0400
Mime-Version: 1.0
Message-Id: <c007d615-4dbf-4525-9fb0-6e4feb28c344@www.fastmail.com>
In-Reply-To: <CACPK8XezRXPFFiiK7_xXLs-ipnfw9400E1dSRHN0XnF2cc4=vA@mail.gmail.com>
References: <20190411161013.4514-1-clg@kaod.org>
	<20190411161013.4514-3-clg@kaod.org>
	<CACPK8XezRXPFFiiK7_xXLs-ipnfw9400E1dSRHN0XnF2cc4=vA@mail.gmail.com>
Date: Thu, 11 Apr 2019 23:24:54 -0400
From: "Andrew Jeffery" <andrew@aj.id.au>
Content-Type: text/plain;charset=utf-8
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
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>



On Fri, 12 Apr 2019, at 11:48, Joel Stanley wrote:
> On Thu, 11 Apr 2019 at 16:10, C=C3=A9dric Le Goater <clg@kaod.org> wro=
te:
> >
> > This will simplify the definition of new SoCs, like the AST2600 whic=
h
> > should use a slightly different address space and have a different s=
et
> > of controllers.
> >
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> > diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> > index 5bbd1fb87d18..9b601709e93c 100644
> > --- a/hw/arm/aspeed_soc.c
> > +++ b/hw/arm/aspeed_soc.c
>=20
> > +static const hwaddr aspeed_soc_ast2400_memmap[] =3D {
>=20
> > +static const hwaddr aspeed_soc_ast2500_memmap[] =3D {
>=20
> Most of these arrays is common. And some of it will stay common in the=

> 2600. Any ideas how we could avoid duplication?

I dunno, I feel that any attempt to create some "common" layout concept =
is
more distracting than having soc-specific, complete layouts described.

There's no reason why they're common beyond coincidence (i.e. it's at
ASPEED's whim). I think this is fine.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

>=20
> This is fine for now.
>=20
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
