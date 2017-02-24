Received: from eggs.gnu.org ([2001:4830:134:3::10]:40134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1chBHw-0000ov-8V
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 03:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1chBHt-0000PQ-4s
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 03:31:40 -0500
Date: Fri, 24 Feb 2017 17:16:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170224061612.GE17615@umbus.fritz.box>
References: <20170224045531.7026-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UOi+gfmBpEZPw9cU"
Content-Disposition: inline
In-Reply-To: <20170224045531.7026-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] sysemu: support up to 1024 vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, Greg Kurz <gkurz@linux.vnet.ibm.com>


--UOi+gfmBpEZPw9cU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 03:55:31PM +1100, Alexey Kardashevskiy wrote:
> From: Greg Kurz <gkurz@linux.vnet.ibm.com>
>=20
> Some systems can already provide more than 255 hardware threads.
>=20
> Bumping the QEMU limit to 1024 seems reasonable:
> - it has no visible overhead in top;
> - the limit itself has no effect on hot paths.
>=20
> Cc: Greg Kurz <gkurz@linux.vnet.ibm.com>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>=20
> With ulimit -u/-n bumped (nproc and nofile), I was able to boot a guest
> with 1024 CPUs, both with threads=3D1 and threads=3D8.
>=20
> It takes time though - 3:15 to get to the guest shell but it is probably
> expected on 160-threads machine.

Applied, thanks.

>=20
> ---
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e465d7ac98..46b81a625d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2712,7 +2712,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      mc->init =3D ppc_spapr_init;
>      mc->reset =3D ppc_spapr_reset;
>      mc->block_default_type =3D IF_SCSI;
> -    mc->max_cpus =3D 255;
> +    mc->max_cpus =3D 1024;
>      mc->no_parallel =3D 1;
>      mc->default_boot_order =3D "";
>      mc->default_ram_size =3D 512 * M_BYTE;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UOi+gfmBpEZPw9cU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYr8+qAAoJEGw4ysog2bOSQEYQAK0FaCVzIFrpL/YGL/EgvN3p
uN2/RKu+8rele52LZoJj34JtdZRifKWz6qYA9HeX0QWYEgr79q5hNojWNByxZtNr
ZhOR+yrpjs11cRbl3AgQXDmDY9sbTUjWMzZ4LFhXRXVTtRe8iJdO5CEZXLjS0zxF
0STB4A5EMWa5s4qZ19y8axoJHnZ0lYBI5TsyrvL1jn1uNMUN7bYACaqxNnMIbTMA
QERlnQkSQzNa/5qP/Nu4vD33CP1rFk+KOI5t53QkU8Aeh8HQMhOKV6TuACmSKKZ9
IgWGEAmaqFqJPSJuilprWimUYJg3AeBS+X4Lato4wMpzkOHqU79er4LF4hfyC1s3
VrFqLsNXBuPYD9X1QlTFajje/kdyKgX4OBmMrJXWzcYo0uZW4O1qKtBGTK2r8wb+
ks3jv2zb66csqyADHXt4Ymj4Df4iw6Mj/XR8/+2ROGMrcCZ7tbP/RFtBZJQDlDLs
J0skKRnrnSTWCtqD6qDWVC0dm68CyvFpJhfFGCI0sCpaLR3UbYGY2Ud93Q1OPAxV
YcSmkHRRGTNlIgKRprARdpJd1tdsojLHa+kS9CMp1TtArwtalMzyitBbf6+lXRiN
NddO7UKgX5M4X5NE8p1OUl0+dweHAfKxEHdtrfc6bo5bwZO95o7+az1g6EwF93mz
Z0qZ6HlRcDirRXmyG0P7
=hbwY
-----END PGP SIGNATURE-----

--UOi+gfmBpEZPw9cU--
