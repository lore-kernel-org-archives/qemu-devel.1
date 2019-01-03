Received: from eggs.gnu.org ([208.118.235.92]:34379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gev4z-0001mW-52
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 23:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gev4x-0000VK-RI
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 23:58:01 -0500
Date: Thu, 3 Jan 2019 15:33:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190103043340.GT10853@umbus.fritz.box>
References: <20190102055743.5052-1-clg@kaod.org>
	<20190102055743.5052-9-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h1wVxq8aeHrvhZJz"
Content-Disposition: inline
In-Reply-To: <20190102055743.5052-9-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 08/10] ppc/xics: allow ICSState to have an
 offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--h1wVxq8aeHrvhZJz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 06:57:41AM +0100, C=E9dric Le Goater wrote:
> commit 15ed653fa49a ("ppc/xics: An ICS with offset 0 is assumed to be
> uninitialized") introduced an extra check on the ICS offset which is
> not strictly necessary.

The commit message for that suggests it was added to make pnv easier.
I take it you no longer need this for the current or expected pnv
code?

> Revert the change to be able to map the XICS IRQ number space on the
> XIVE IRQ number space.



>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xics.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 7668c381a887..07508cbd217e 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -139,8 +139,7 @@ struct ICSState {
> =20
>  static inline bool ics_valid_irq(ICSState *ics, uint32_t nr)
>  {
> -    return (ics->offset !=3D 0) && (nr >=3D ics->offset)
> -        && (nr < (ics->offset + ics->nr_irqs));
> +    return (nr >=3D ics->offset) && (nr < (ics->offset + ics->nr_irqs));
>  }
> =20
>  struct ICSIRQState {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--h1wVxq8aeHrvhZJz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwtkKEACgkQbDjKyiDZ
s5KVFRAAlI/RI/PxHkaRvwO5/cGq8DQf0C0bsG+bR5AHrE7cOnPQb3slhFhXvjnB
B4Ikek2xj2xvocVSEy/TTUh3dYpK9mSmmoPE+C7TXCXTU7vY6V5hwTaXcFhUV7cK
XD2RLXy0gSuOe4jtx4CvhNObkzrrQgOCNK9jSOt8MQ9p/zJAOBXPqg758mXCc2Xa
XC/W7CphXUYZU73uJgGq01PtkaZQclZRnAcFdRym6SYf63jUWVJ4o4LGnzBulOBg
Zs/ABkNcmVGDVTsc095wfSEJG4NrFiALTTdYfZbur0Q6W09/waX8+dxdGy+2Yb2A
JPs55grIj7tB3BeRNAQPun5RmNMAzofuMcF9fbb8aeYBRvXX2k4eNp1+HVhOGVvu
4djU0cbrW6qe4Cx0AX84sTvKfCCSsT6cLFnTRsmBxFmMmAkXELNf2cQCTY1UHjHc
EtMfhS1GC9rh4X0R7GkYrzPl9ohRG/yGmVlml7EAxeizvLIKb82QV3LxGijXgSL2
PCVknE6K2UcbaEvg0cj3ZFuSvfdTIwNLiWzuQ1yWLJFpiKp+aj4+bGSdfouBbBaR
U3QRL7jl1omqeCqtM9tFiDIjNtxR0RNvHhN+Sa3VqfaW/zx5B/q90j3K9Fs51xd2
rGrIxTj9mZ9fpvuArUTZuwrvTI2krHeac360tPOy5CesLPx9CvQ=
=5UvX
-----END PGP SIGNATURE-----

--h1wVxq8aeHrvhZJz--
