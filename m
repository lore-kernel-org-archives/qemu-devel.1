Received: from eggs.gnu.org ([2001:4830:134:3::10]:56039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dexwA-0007Ou-UQ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dexw5-0007lR-TQ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:24:18 -0400
Date: Tue, 8 Aug 2017 16:09:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170808060937.GA25081@umbus.fritz.box>
References: <150212666472.12227.5292551535430570753.stgit@bahia>
	<150212667952.12227.2933198220121691613.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <150212667952.12227.2933198220121691613.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.10 PATCH 1/3] spapr_drc: abort if
 object_property_add_child() fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2017 at 07:24:39PM +0200, Greg Kurz wrote:
> object_property_add_child() can only fail in two cases:
> - the child already has a parent, which shouldn't happen since the DRC was
>   allocated a few lines above
> - the parent already has a child with the same name, which would mean the
>   caller tries to create a DRC that already exists
>=20
> In both case, this is a QEMU bug and we should abort.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

This is definitely a fix, so applied for 2.10.

> ---
>  hw/ppc/spapr_drc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 47d94e782ac2..5260b5d363a0 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -541,7 +541,7 @@ sPAPRDRConnector *spapr_dr_connector_new(Object *owne=
r, const char *type,
>      drc->owner =3D owner;
>      prop_name =3D g_strdup_printf("dr-connector[%"PRIu32"]",
>                                  spapr_drc_index(drc));
> -    object_property_add_child(owner, prop_name, OBJECT(drc), NULL);
> +    object_property_add_child(owner, prop_name, OBJECT(drc), &error_abor=
t);
>      object_property_set_bool(OBJECT(drc), true, "realized", NULL);
>      g_free(prop_name);
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmJVZ4ACgkQbDjKyiDZ
s5KeoBAAy9Vptt0tTRq/DimOH8FFYtDitmiNsV0irkW+LefBcZyAk2VCcWfhi1tv
mXobBLkgmJpMLFoZfX46hf4Ln6LdoY2hwWKeNqtW+jQ88Aio0iAqUhMhZZ1WnVXP
AFuOv+MujfK3KTCF04yqqgmbNhRmZwFgCAKK0OxDUpan9tw0rxNGCV2s635KmKc0
lgfQ2fwj8KFNPTPPVPOflbX8T2bcwjTI7F6RZX1rg/ikBZZqMTsrA96MLNCVD5Af
Ljr+TXLg6Y3uyd2lAhCH0Tvi0mb/1gzx9PzZV2zivLsyYKn0/YsbdFZjQHeoM2/D
2FacaJCdpXyDt59gumQLJncekZ2/o7K6xpD2NJ9GKZczms6qrod9XRbgcwDIKT7d
bqRv6fe72NWepQNW+OPEyxsL0/obl7iO98F1BhN6lEevOrNa9f6xnGz42F67gbrc
OTUOUxVifU8u3ecb+04MGj6mpIu/8KFEIrwnYQG0exj7eaKyOnWXKN7oC9XM3Oel
v8kBPgYfjW48QwGd4umSHDgL82c1pU3T2eNkpl0RPVVEIdAWk3ZgaQNZIcmvsl/x
kDvdit6hkNA8W1zjTZOh+kWKT6OiBWw+fI+VaPPUFX8s4LLbsDhdxcniyGMIjjPJ
CukImzREKyjHJxZ/wQcJlrMAqw6Uf7D2E/dsKOLYjVweqwBM0w4=
=/5/u
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
