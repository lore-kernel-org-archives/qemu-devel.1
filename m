Received: from eggs.gnu.org ([2001:4830:134:3::10]:41517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fvG8H-0000Ay-BO
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 02:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fvG8G-0001ng-AX
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 02:08:41 -0400
Date: Thu, 30 Aug 2018 16:07:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180830060737.GK2222@umbus.fritz.box>
References: <d14d97226c3b432fa70513dcd7bacf59c6881cbd.1535608432.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJAclU0AInkryoed"
Content-Disposition: inline
In-Reply-To: <d14d97226c3b432fa70513dcd7bacf59c6881cbd.1535608432.git.sbobroff@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] spapr: Correct reference count on
 spapr-cpu-core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sbobroff@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com


--IJAclU0AInkryoed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 03:54:40PM +1000, Sam Bobroff wrote:
11;rgb:ffff/ffff/ffff> spapr_init_cpus() currently creates spapr-cpu-core o=
bjects via
> object_new() and setting their realized property to true. This leaves
> their reference count at two, because object_new() adds an initial
> reference and the realization attaches them to a default parent object
> which also increments the reference count.
>=20
> This causes a problem if one of these cores is hot unplugged: no
> delete event is generated for it because it's reference count doesn't
> reach zero when it is detached from it's parent.
>=20
> Correct this by adding a call to object_unref() in spapr_init_cpus().
>=20
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>

Applied to ppc-for-3.1.

> ---
>  hw/ppc/spapr.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0d032a1ad0..fbb00f0c56 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2502,6 +2502,8 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
>              object_property_set_int(core, core_id, CPU_CORE_PROP_CORE_ID,
>                                      &error_fatal);
>              object_property_set_bool(core, true, "realized", &error_fata=
l);
> +
> +            object_unref(core);
>          }
>      }
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IJAclU0AInkryoed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluHiZ0ACgkQbDjKyiDZ
s5IdLg//cm3KOMvhJAf1b3y1EG/K9SNNm+bJbToF8AzFfwQ8CH+Xn3Ec0hmViHdD
b9lFrBv9L4/78fmoDAT1wnnMkPNoZ5+FNor2/BfMtfLeG+31dH3B6NZn5XGa0/QW
oOIU71wgoCUYKbS0y+OMl/98EvqtJ+o0TLZcAgvBy6U9zh1Nj3TLhy0VGS4Kc3LY
QGAXWGUWzL9OkPAHp6cEa2pi7cN0oBWtIDJ4oHf7rtQgJXMNvXiXcxUwfEZxC9ii
APs8JNmS2mArsMVmfkncVKnc3w6fXP0AIGvAIr0yoQXTtT1sOS8t0czP6Uj20vEy
NaCdv+/eGmGwvOxVl9dwEmedyclZ3lLf0hUz/rbO8pzTazzMIdBqjzRo5zT5sVDs
7taElbhnVMhEdoTNT/APdJme/aGAqPInBda3n+bqRTdoRXsjrySvgcGiLdO5n2ue
7vdqPL5M3T1YRZn5z6ekeOcjQhpZDJGVpSmdWY6tZr7DQn2q865+I4w0/AV1bACC
kRy4mbuoXjsRKxKkdoAd8xAVeDGzwcukQTNv33ZolpveWQsIc9gGxAr8enEcz4iZ
U1/sg9i9NYwBbYCRa1U1a5QzTYWog+bfmu38vRlZishHs1wfNvpkHbc6joSVDteE
bjmpebzrQ/6fqmhUyyPrk5rYx5IYPdfHIhZg+umyYQJMGnaBjaA=
=ga1x
-----END PGP SIGNATURE-----

--IJAclU0AInkryoed--
