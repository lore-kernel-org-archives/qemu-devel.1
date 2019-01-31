Received: from eggs.gnu.org ([209.51.188.92]:60694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gp3IY-0005A3-Fo
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 22:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gp3IX-0003uI-EF
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 22:45:54 -0500
Date: Thu, 31 Jan 2019 14:09:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190131030921.GH1771@umbus.fritz.box>
References: <20190130203638.21179-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OgApRN/oydYDdnYz"
Content-Disposition: inline
In-Reply-To: <20190130203638.21179-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v5 0/8] target/ppc: remove various endian
 hacks from int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org


--OgApRN/oydYDdnYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 08:36:30PM +0000, Mark Cave-Ayland wrote:
> >From working on the TCG vector operations patchset, it is apparent that =
there
> are a large number of endian-based hacks in int_helper.c which can be rem=
oved by
> making use of the various Vsr* macros.
>=20
> Patch 1 is simple enough, and implements the complete set of Vsr* macros =
for
> both big endian and little endian hosts.
>=20
> Patches 2 and 3 rework the vector merge and multiply algorithms so that t=
hey
> no longer require the endian-dependent HI_IDX and LO_IDX macros.
>=20
> Patches 4 and 5 then completely remove the HI_IDX/LO_IDX and EL_IDX macro=
s by
> replacing the element accesses with their equivalent Vsr* macro instead.
>=20
> Patches 6 and 7 tidy up the VEXT_SIGNED macro and fix a potential shift b=
ug
> in the ROTRu32 and ROTRu64 macros pointed out by Richard during the revie=
w of
> v1.
>=20
> Finally patch 8 is an inspection-based removal of other HOST_WORDS_BIGEND=
IAN
> hacks in int_helper.c, again replacing accesses with the relevant Vsr* ma=
cro
> instead.
>=20
> Note that there are still some endian hacks left in int_helper.c after th=
is
> patchset: in particular the delightfully evil VECTOR_FOR_INORDER_I macro =
still
> remains in places where the index variable was used for purposes other th=
an
> accessing elements within the vector.
>=20
> There were also some parts where additional conversion could be done, but=
 I
> wasn't confident enough to make the change without access to PPC64 test i=
mages
> or real big-endian host hardware.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-4.0, thanks.

>=20
>=20
> v5:
> - Rebase onto master
> - Update vmrg{l,h} algorithm macros in patch 2 as per Richard's suggestion
>=20
> v4:
> - Rebase onto master
> - Add R-B tag from Richard for patch 4
> - Use Richard's improved vmrg{l,h} algorithm in patch 2
>=20
> v3:
> - Rebase onto master
> - Add R-B tags from Richard
>=20
> v2:
> - Add R-B tags from Richard
> - Add patches 6 and 7 to simplify the VEXT_SIGNED macro and fix a potenti=
al
>   shift bug in the ROTRu32 and ROTRu64 macros
> - Don't require ordered access for VNEG and VGENERIC_DO macros as pointed=
 out
>   by Richard
>=20
>=20
> Mark Cave-Ayland (8):
>   target/ppc: implement complete set of Vsr* macros
>   target/ppc: rework vmrg{l,h}{b,h,w} instructions to use Vsr* macros
>   target/ppc: rework vmul{e,o}{s,u}{b,h,w} instructions to use Vsr*
>     macros
>   target/ppc: eliminate use of HI_IDX and LO_IDX macros from
>     int_helper.c
>   target/ppc: eliminate use of EL_IDX macros from int_helper.c
>   target/ppc: simplify VEXT_SIGNED macro in int_helper.c
>   target/ppc: remove ROTRu32 and ROTRu64 macros from int_helper.c
>   target/ppc: remove various HOST_WORDS_BIGENDIAN hacks in int_helper.c
>=20
>  target/ppc/int_helper.c | 523 +++++++++++++++++++-----------------------=
------
>  target/ppc/internal.h   |   9 +-
>  2 files changed, 217 insertions(+), 315 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OgApRN/oydYDdnYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxSZt8ACgkQbDjKyiDZ
s5KIZxAA4yj2KObQfhkCqd2PVUi2HiX7rtunVrXVnsKrC9/vfhLGxoxGgw2AKrTL
TcXMNsoE7nVC2uXAqYJD2QYOrPIxQ+bn5ocgB/vmsP9DrVQrbKaxipxXk6ABBdmc
fdLYzYRI3Aloi2roWsyxwk0f7CPbFW5voTsTDIx+ChM3QfVvDUyl9tVft0pmAR7q
sqwgMOawyHcat3loDBw/j5s5j4yqkKqUE/j+6ZOlakP+q8VSRD+M/5Bau09v1LJ1
Be/QcI0d7Z2EuVyv9tdp/FKnfiTP1MGDjYTiwWu0A012CGmYrNk2PvpmBuvjzkdv
Bp7PQW7TUKYwp4Jh5qhglYRLUFheVoL6xJehNul3tloddn02vEZDd6B4aYXNK1vc
PzCD5F35xu9VyVUP6N4SI2LJHmqaT1NJzVLacDpcvexoNjHRPi+z4QbwuodRVABe
voPc9Tj+2BzsISd2WmWvJPqmNzkgt/WuxENPJWrQs0jYDDpnbFh7+pulboQegjil
CNFpIsB0EEPgXDCklLGGOtr9q+MP0ErF8nvLndXt7BSCYUU1JvrVLkgSnwhU3V6I
T3PRFMkKSwR7tZ4dHKT7I1qibnONN+yX7yAuEnib9jT6JpcYhxor6AZNgElDX7Es
rLj/HSvv2/zTSxA8cvGvGlQqQ0YUH2QHvTGqO3+0wGpoR5USgRU=
=QoBk
-----END PGP SIGNATURE-----

--OgApRN/oydYDdnYz--
