Received: from eggs.gnu.org ([2001:4830:134:3::10]:39364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1dfKeB-0001PE-Sq
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1dfKeA-0005Tm-Or
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:39:15 -0400
Message-ID: <1502260737.7946.8.camel@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 09 Aug 2017 16:08:57 +0930
In-Reply-To: <20170809062828.3673-3-andrew@aj.id.au>
References: <20170809062828.3673-1-andrew@aj.id.au>
	<20170809062828.3673-3-andrew@aj.id.au>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-8XhJjBNpGSdVp8W+1GiW"
Mime-Version: 1.0
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
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org, joel@jms.id.au, ryan_chen@aspeedtech.com, f4bug@amsat.org, openbmc@lists.ozlabs.org


--=-8XhJjBNpGSdVp8W+1GiW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ugh, disregard this one; I changed the subject and reissued `git
format-patch`, which naturally doesn't overwrite any existing patch in
the output directory and so the old one got sent as well.

Andrew

On Wed, 2017-08-09 at 15:58 +0930, Andrew Jeffery wrote:
> This is required to configure differences in behaviour between the
> AST2400 and AST2500 watchdog IPs.
>=20
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> =C2=A0hw/arm/aspeed_soc.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 3034849c80bf..79804e1ee652 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -183,6 +183,8 @@ static void aspeed_soc_init(Object *obj)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object_initialize(&=
s->wdt[i], sizeof(s->wdt[i]),
> TYPE_ASPEED_WDT);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object_property_add=
_child(obj, "wdt[*]", OBJECT(&s->wdt[i]),=20
> NULL);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qdev_set_parent_bus=
(DEVICE(&s->wdt[i]),
> sysbus_get_default());
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qdev_prop_set_uint32(DEV=
ICE(&s->wdt[i]), "silicon-rev",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sc->in=
fo->silicon_rev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object_initialize(&s->ftgmac100, sizeof(s->=
ftgmac100),
> TYPE_FTGMAC100);
--=-8XhJjBNpGSdVp8W+1GiW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZiq4BAAoJEJ0dnzgO5LT5tA4P/065hV+GiIoAUi6VRVPPiKoA
KxXA3jfMAELdwniWC2XhCIBPr2pFXMLqLOGTwqRBs8tDR/+RF9/0EnyfxA9rDB2S
PmNyFfHiwmRlDn8nD9Sn7kYzM/JzHGQuKMjlLZHLSfU+B+y8mWUMdvujkp7NoFwx
MoNvJsq9y0eqDUsk4VEZd/MqJNhhuNylLmVd1ptsQRGDpHYSk+5dSvyq2/y4FjRU
OYY/5Dt9m86WA70Yiesyr0UgPaQ2u+/F9hCzienHLwnWgdJGaCVsCbIWQDZ9eDRi
IcpFUhVBcfjF4xwV5U0iuo2mbUBXdPtFU32EJJmVtaSMbD5PpGgFjOYd1sK4TEsu
SLRaQQ8TRMLfXqyS5hlrD3cEmF2aicJFpriLzVFJYFqtb8eX26hsTjPglbQC2DBg
OSyybGeU3YSiZvkzzQym4kktsxgQ1hM5NSLzqlxQjwWfc440fLgkPK3Iq0tNm6w8
eEKFEnfzB41mZ7zgVlJu8wB47ZP/pKNJZuZO8520bSRuiMuUC+NvqWQhoRV707jp
INWX7JDilvqDF/0VpETfEAatslAoRmbSItOrNbxwv6CTzyApmR4tqhbGeH9Upmj7
/t0jH9P4DjC9JX3g94Fz73rVimh0DzhMrcICeWnChqygcIBTo2B1LwXS7oc9W7nc
nQFRyMwa+RWGaFZo/uf5
=sEhT
-----END PGP SIGNATURE-----

--=-8XhJjBNpGSdVp8W+1GiW--
