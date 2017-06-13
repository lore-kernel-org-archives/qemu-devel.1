Received: from eggs.gnu.org ([2001:4830:134:3::10]:40221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKhSp-0002Fc-FP
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKhSm-0007Q4-C3
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:46:15 -0400
Date: Tue, 13 Jun 2017 16:45:55 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170613084555.GG30171@umbus>
References: <149734236294.28467.16891018961029258858.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Content-Disposition: inline
In-Reply-To: <149734236294.28467.16891018961029258858.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: exit gentfully when CPU doesn't
 support requested compat mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Andrea Bolognani <abologna@redhat.com>


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 10:26:02AM +0200, Greg Kurz wrote:
> QEMU currently aborts if the user asks something unrealistic like power9
> compat mode with a POWER8 CPU for example. Since this isn't a bug in QEMU,
> there's no point in aborting. The same goes with the other possible error
> paths in ppc_set_compat_all(). Let's just terminate QEMU instead.
>=20
> Reported-by: Andrea Bolognani <abologna@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Heh, I already folded an identical fix into ppc-for-2.10.


> ---
>  hw/ppc/spapr.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b2217f39eeea..d0cc124935c0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1345,7 +1345,7 @@ static void ppc_spapr_reset(void)
>          spapr_ovec_cleanup(spapr->ov5_cas);
>          spapr->ov5_cas =3D spapr_ovec_new();
> =20
> -        ppc_set_compat_all(spapr->max_compat_pvr, &error_abort);
> +        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
>      }
> =20
>      fdt =3D spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZP6ZAAAoJEGw4ysog2bOS96gQAK/9OZoP5gmsRE6f/pNGGNSj
M4X3UmjY4FyTUtNX3qDassEAL9xrlF7Ljgme8F69W02MQ9QuR7UB3E+bk2DKNqjS
fNAVYPmklvrxZSRI/fg4CcMOw3F+AXsH6plkWZRWdh4HhVULy73rSikkDFs5pxT7
g+dBWdivV+VEevgiSyvd5LZ7QZ4tUwb9HsUlU075pG6x9NV0s6Kec3UQhJ5afH9w
rQsCs2Dy1pygvqU4tZYHHqaeGqAvaMkfoSDuhywbkBsZhLcSLrLeY9m5iIzWucYM
c0tLuE6tDQUOGtfBXs7rOExNmYYZ7vpgBS1iar/2dVCPLN1wZZv9XOHuc1TwclW4
Rt2K5mgMGSjHkUy/l7q5CZ+VoAwNimoXiScqZxXSfwziQKZtgs/o6nhALUGehAPc
VXUbZDS9WGY3rNl3ACPdrv3LNng8WpH3Id1saATCplG49awF1FcqF0rr/AJl9N/C
P61f/a5vtj151qu8cTTuKr+hsxSrXozOdxnwYmPXaX85aC6VJ57BHLqJbDxLr60X
+nNpQplT7D4ytvljbtOZAPWWRQF0DFUiSGSRd2jBceeKAkYqrSsXfGilMFaAu8Ar
uZLNkL4n0xwNilcucOmF3sE+TRhDndsGYpfIiSEMSsHIavnjJqRplToIq+donJ4p
kk71we7PFFECY8F6ZH6j
=IRqv
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
