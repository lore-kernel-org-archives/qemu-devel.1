Received: from eggs.gnu.org ([2001:4830:134:3::10]:51914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dfMpX-0002Rm-SV
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 04:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dfMpT-0004Ny-UA
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 04:59:07 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:58759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dfMpT-0004NT-Nh
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 04:59:03 -0400
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 2A9BF743BA
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 10:59:02 +0200 (CEST)
References: <20170809062828.3673-1-andrew@aj.id.au>
	<20170809062828.3673-3-andrew@aj.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <78e09d93-ba07-c882-8830-737691f83a3c@kaod.org>
Date: Wed, 9 Aug 2017 10:58:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170809062828.3673-3-andrew@aj.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.11 v2 2/2] ARM: aspeed_soc: Propagate
 silicon-rev to watchdog
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, joel@jms.id.au, ryan_chen@aspeedtech.com, f4bug@amsat.org, openbmc@lists.ozlabs.org

On 08/09/2017 08:28 AM, Andrew Jeffery wrote:
> This is required to configure differences in behaviour between the
> AST2400 and AST2500 watchdog IPs.
>=20
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/arm/aspeed_soc.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 3034849c80bf..79804e1ee652 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -183,6 +183,8 @@ static void aspeed_soc_init(Object *obj)
>          object_initialize(&s->wdt[i], sizeof(s->wdt[i]), TYPE_ASPEED_W=
DT);
>          object_property_add_child(obj, "wdt[*]", OBJECT(&s->wdt[i]), N=
ULL);
>          qdev_set_parent_bus(DEVICE(&s->wdt[i]), sysbus_get_default());
> +        qdev_prop_set_uint32(DEVICE(&s->wdt[i]), "silicon-rev",
> +                                    sc->info->silicon_rev);
>      }
> =20
>      object_initialize(&s->ftgmac100, sizeof(s->ftgmac100), TYPE_FTGMAC=
100);
>=20
