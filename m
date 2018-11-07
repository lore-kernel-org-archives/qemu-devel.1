Received: from eggs.gnu.org ([2001:4830:134:3::10]:50949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKFQL-0007kC-Di
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 23:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKFQG-00059N-Qa
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 23:26:36 -0500
Date: Wed, 7 Nov 2018 15:24:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181107042445.GB5575@umbus.fritz.box>
References: <20181030170353.7447-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <20181030170353.7447-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-3.1] hw/ppc/ppc440_uc: Remove dead code
 in sdram_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 05:03:53PM +0000, Peter Maydell wrote:
> Coverity points out in CID 1390588 that the test for sh =3D=3D 0
> in sdram_size() can never fire, because we calculate sh with
>     sh =3D 1024 - ((bcr >> 6) & 0x3ff);
> which must result in a value between 1 and 1024 inclusive.
>=20
> Without the relevant manual for the SoC, we're not completely
> sure of the correct behaviour here, but we can remove the
> dead code without changing how QEMU currently behaves.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Applied to ppc-for-3.1, thanks.

> ---
> We had a discussion about this coverity error a while back:
> https://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg05187.html
> I'd just like to squash the Coverity warning, I think.
>=20
>  hw/ppc/ppc440_uc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index 09ccda548f3..9360f781cef 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -559,11 +559,7 @@ static target_ulong sdram_size(uint32_t bcr)
>      int sh;
> =20
>      sh =3D 1024 - ((bcr >> 6) & 0x3ff);
> -    if (sh =3D=3D 0) {
> -        size =3D -1;
> -    } else {
> -        size =3D 8 * MiB * sh;
> -    }
> +    size =3D 8 * MiB * sh;
> =20
>      return size;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlviaQwACgkQbDjKyiDZ
s5K4yA/+O+f2qNse5i//p8fN93iUX0y71DaGZQs/T1uCiJlAykxfJcYG2qgDAGdQ
7tg08pHA/OzfWqLGHN72Txc1YXyv+0jeLazYpGs7smibfpPBUu65nHV50KQIpuPV
GpMTtAE9ESMiqKZbe4P4YKHfiypXB3Gt3PpVIPlwsgQQbe+wwojPWAC9foMDQUo+
GKyjzfWT2oATVu00aqu3/Rszf/GRog8tLqmfJbUqF2g31ItNAFI2Aq0vNkRds/An
6m9/tPkxk1vlaAHWFtFDMBgJUfacsE9q/bauzWnh+hH7Qr1RVRgBNTuoNxPTO1As
FrsK6xWxrZ/aRdz2PMi47u5MIB+QSzKmW5MoXwJ/P/eCo1p48v0rN5EHzPU5JXPM
tFIIpVLnamtwuryOGD4rHJKSSW3gV2DklJX0ZN8a8623syVl1f7P9uhBEK3va8qC
cY8zmE33xwjqH3dAMBIc3ygE3ghGzG7VqTiNWA7T+Uc4SvYDtdgjVF0fv9eY0dC4
Fe2AEA9GX907CL59BdviKljVSM3FV7OvGPRmkt7saRqdljAA/VYCtkiNmeJceXIO
kh7uDmInsTwJp/qW260fnvAa/Tl6P0qkTnAfNEtoK1CSgJMDRVVxVvI9/ogu3q3L
RClyS/ToifXW4Ard0y9keamxfPIZV7xOLnrG97hGj4U7xKsLbsQ=
=PMj9
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
