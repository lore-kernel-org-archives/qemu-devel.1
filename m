Received: from eggs.gnu.org ([2001:4830:134:3::10]:47639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVXHh-0001Qc-PQ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVXHg-00044z-90
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:12:05 -0400
Date: Wed, 20 Jun 2018 15:41:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180620054139.GC24636@umbus.fritz.box>
References: <cover.1529398335.git.balaton@eik.bme.hu>
	<453290537c0f31507ea5e44ac824f45427b9ac1e.1529398335.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <453290537c0f31507ea5e44ac824f45427b9ac1e.1529398335.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v4 06/11] target/ppc: Add missing opcode
 for icbt on PPC440
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 10:52:15AM +0200, BALATON Zoltan wrote:
> According to PPC440 User Manual PPC440 has multiple opcodes for icbt
> instruction: one for compatibility with older cores and two 440
> specific opcodes one of which is defined in BookE. QEMU only
> implements two of these, add the missing one.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied to ppc-for-3.0, thanks.

> ---
> v4: Updated commit message, for reference see bottom of:
> http://manualzilla.com/doc/6915682/ppc440-processor-user-s-manual?page=3D=
451
>=20
>  target/ppc/translate.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 5fe1ba6..3a215a1 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6707,6 +6707,8 @@ GEN_HANDLER_E(mbar, 0x1F, 0x16, 0x1a, 0x001FF801,
>  GEN_HANDLER(msync_4xx, 0x1F, 0x16, 0x12, 0x03FFF801, PPC_BOOKE),
>  GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
>                 PPC_BOOKE, PPC2_BOOKE206),
> +GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
> +               PPC_440_SPEC),
>  GEN_HANDLER(lvsl, 0x1f, 0x06, 0x00, 0x00000001, PPC_ALTIVEC),
>  GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
>  GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsp6REACgkQbDjKyiDZ
s5JmEQ//c82bMMuC8lN7SKEETWJEOKJz7XDvVLA08/FGlmA1ADBbmqaOW7IvkpnY
BkwdxjXH1S3nn1xRDEhr0RBpviPNKm1fSPvFe5//yEf/LUKRyRHzibfmy5WbPQPY
Ka0j0shcXN33T3gGLOSMORVn2fRkoXzqnXoLBPeI9rOnm1SSb/wVChjr7QXZA017
xsDqPgwbvP4BZMVRUMfIjN9nUrybxo9bkdpvsnB9IvS6SGnmgv8+70rlqrDin7dT
xjjcEs7uecrYIMHoJlIbbFnykhgf+K2to00PQwpdpzQHRMicPmllGMbYko523nfp
WlglqqHq1MiFaeyYQXeKUEqBLX636vlqOTGIHFz8DNnOBWq1z6pNm8a4+JFY/97q
0ol5xJOHq7Eu+Lzo71QSzowZoP2s3ilOtc7BCtuC5Dqs3byrDLkFi+nfCwbt6UVy
M9jqxyb01x+692UdHRlS/YUYkGUnk/RuSKn0gDlnD0uGgSo58aiZuIu/nWf0/CUn
xTSiQRfXWLc3j9tzDhrevB1K3cpQy+xwnj+IVHjgKyaty3Ro4ZogV1MKdijiqVM7
RrSE5CkLFMYbEZbzurttZYkl0I262lCEZIpBZzOwFWLh9WgcYpNhLFA0jgDyQIdO
EtMTHin/OY9TlZmyayrUnZOwhitzCqlE1u9q/w/AcjiDGTDnmXY=
=PR+Z
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
