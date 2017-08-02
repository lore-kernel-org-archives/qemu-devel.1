Received: from eggs.gnu.org ([2001:4830:134:3::10]:60788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dcuiW-00035K-FC
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dcuiV-0001ad-Ey
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:33:44 -0400
Date: Thu, 3 Aug 2017 00:22:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170802142253.GC394@umbus.fritz.box>
References: <20170802103259.25940-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <20170802103259.25940-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] cpu: don't allow negative core id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2017 at 12:32:59PM +0200, Laurent Vivier wrote:
> With pseries machine type a negative core-id is not managed properly:
> -1 gives an inaccurate error message ("core -1 already populated"),
> -2 crashes QEMU (core dump)
>=20
> As it seems a negative value is invalid for any architecture,
> instead of checking this in spapr_core_pre_plug() I think it's better
> to check this in the generic part, core_prop_set_core_id()
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/cpu/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/cpu/core.c b/hw/cpu/core.c
> index 2bf960d..bd578ab 100644
> --- a/hw/cpu/core.c
> +++ b/hw/cpu/core.c
> @@ -33,6 +33,11 @@ static void core_prop_set_core_id(Object *obj, Visitor=
 *v, const char *name,
>          return;
>      }
> =20
> +    if (value < 0) {
> +        error_setg(errp, "Invalid core id %"PRId64, value);
> +        return;
> +    }
> +
>      core->core_id =3D value;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmB4D0ACgkQbDjKyiDZ
s5Lx7hAAgx7Q4hV/aXZ+3tVrXzNL5sqO4wAZhJuQgFdyzFqmyC/EGIzfmN9v3mqy
9Qsn/gIhUeXLtoekJdHf1N8F2mW+hqqArsYFEezz/uV4G1xo7vEwf0NmFeq4cqnD
r54Qfu/l8SbcPHowYGw6jBxjuZZw0RhMKpmwP4alBOTyt96X1ch31ef3B+Abi1bn
aZ48bk4AE4z0Z0pOvHjqTT0G6I/vXWNIGNaR6blCMz39QGsK1ZmNU/vZLc9bXvL9
ZSMvxAKcPXxqrEi3l4jdR6vKIwkhVk5hgeFkkNf87hsU/FX6y/HVzaWGP0xVFA7z
RQmSi2QuWN2nwnON4T7fRbOkWszle1MaNhOPH5dd4QoLESOXhIpynk1KxvN6Vr6Z
eAzLE5T6ay/TrUu3vyckghIC11D27OiVCx+YactBOtDTQi2e5Ji93QY3VjRNePN2
emztLvxvETWcTrbY47h6fA/2br4vKO1c21bof0YnOwPhyeHbl5D+nlPsGOjPjEX6
JPcy1hrciJpZ3HaV1mq3C7DfassfWZjLkkb6zMPDgYI1pTjI6/vgbG7Ck5L25Hrl
g4edk5bAGedPf2ikt9NKMCopX/+0VCF2jfm4EC76rpvpk6HVp74t25+seuyg3mEl
Wwrtwx6qjJepAOL0g9v1KO7ROcKc82Z2B/cTrqNn+HLpxGOi2T4=
=8arz
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
