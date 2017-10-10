Received: from eggs.gnu.org ([2001:4830:134:3::10]:38893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kU0-0004Mu-Rz
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kTz-0004WD-Pc
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:24 -0400
Date: Tue, 10 Oct 2017 13:10:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171010021016.GK2668@umbus.fritz.box>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
	<1507578671-158758-20-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x1F0m3RQhDZyj8sd"
Content-Disposition: inline
In-Reply-To: <1507578671-158758-20-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 19/24] ppc: pnv: use generic cpu_model
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--x1F0m3RQhDZyj8sd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2017 at 09:51:06PM +0200, Igor Mammedov wrote:
> use common cpu_model prasing in vl.c and set default cpu_model
> using generic MachineClass::default_cpu_type.
>=20
> Beside of switching to generic infrastructure it solves several
> issues.
>=20
>  * ppc_cpu_class_by_name() is used to deal with lower/upper case
>    and alias translations into actual cpu type, which fixes
>     '-M powernv -cpu power8' and '-M powernv -cpu power9_v1.0'
>    usecases which error out with:
>     'invalid CPU model 'FOO' for powernv machine'
>  * allows to switch to lower-case typenames in pnv chip/core name
>    (by convention typnames should be lower-case)
>  * replace aliased names /power8, power9, .../ with exact cpu model
>    names (i.e. typenames should be stable but aliases might decide to
>    point to other cpu model withi family or changed by kvm). It will
>    also help to simplify pnv_chip/core code and get rid of dependency
>    on cpu_model parsing.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

It wouldn't have had an actual patch collision, but this should have
the new power9 v2.0...

[...]
> -#define TYPE_PNV_CHIP_POWER9 TYPE_PNV_CHIP "-POWER9"
> +#define TYPE_PNV_CHIP_POWER9 TYPE_PNV_CHIP "-power9_v1.0"
>  #define PNV_CHIP_POWER9(obj) \
>      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER9)


here

[...]
> @@ -781,7 +778,7 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
> =20
> -    k->cpu_model =3D "POWER9";
> +    k->cpu_model =3D "power9_v1.0";
>      k->chip_type =3D PNV_CHIP_POWER9;
>      k->chip_cfam_id =3D 0x100d104980000000ull; /* P9 Nimbus DD1.0 */
>      k->cores_mask =3D POWER9_CORE_MASK;

=2E.and here..

>  static const char *pnv_core_models[] =3D {
> -    "POWER8E", "POWER8", "POWER8NVL", "POWER9"
> +    "power8e_v2.1", "power8_v2.0", "power8nvl_v1.0", "power9_v1.0"
>  };

=2E.and here.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--x1F0m3RQhDZyj8sd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlncLAgACgkQbDjKyiDZ
s5KF5hAA5u4Ydt34STB4sN1+ERGoMXtbUZ2bk/0JrnVoHDs2z7Od0YrsQZLvCIqE
9SQmHJofvL7u12aRytcWHTq5Q8EYLYHrdz046X5f7TO+ACx8nDGTmtP6tgRScIxn
TDfEZqE4qfeExQGXzUaXt+mqt/Kc1b8HiHkxsGQmpDwi3RXR11+depEGV4O2FyOt
RFjuPPmNId8kg9rqskUQxOMrSRHJpGuh1qi+6CGJ5z8NUMcCAjiJKl+1es3DaeIf
kK2/yX3Bq6pLYzIRz3w0vuQFGyCFoZ6XUlAYeCoqCcXjAdeNCkRBPB4MpqKGbORW
ASzHNIvVFSQe3MW7S7Ex+L9fe9Ef69UZNMuymFonqPeYQdBtXXoVDFBQy0BV9R1+
k63+mQqBg41ovDniSWwdEh/zsqt1z5y4vgMIV69RJhFadYVP7ZGIf7eC2WVBbpND
hAMf35TpTW7eZGW7x8yfo2SI3A/cSvbvU+vW85sASqwIFxWwlsQqnTuC55qZNwJR
NrLNKCi/fOGz6mRFi7EaeUzEO+oYrxOcakgIqDOPlQeydauaO5urt2FK8DfZm6tV
PCQ0u8GEPAyQFcfS2kjfIzd7XCcCaRv5bdYElhO/8xZRqwsPCD1puf88Jr2j72T0
25qCIe1JCW+1xEk4Ck5mOlXGA6g6duhuEzh3lJwBwgmmveVsp+Q=
=6j0z
-----END PGP SIGNATURE-----

--x1F0m3RQhDZyj8sd--
