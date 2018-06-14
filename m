Received: from eggs.gnu.org ([2001:4830:134:3::10]:38693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTISX-0000VH-0X
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTIST-0004UZ-3e
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:58:01 -0400
Date: Thu, 14 Jun 2018 11:36:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614013612.GF3042@umbus.fritz.box>
References: <cover.1528935420.git.balaton@eik.bme.hu>
	<79692361d82a4d0b1f9c36b0d988369062351f00.1528935420.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gneEPciiIl/aKvOT"
Content-Disposition: inline
In-Reply-To: <79692361d82a4d0b1f9c36b0d988369062351f00.1528935420.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v3 9/9] target/ppc: Add missing opcode for
 icbt on PPC440
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


--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 02:17:00AM +0200, BALATON Zoltan wrote:
> PPC440 has two opcodes for icbt, add the missing one.

A document reference to confim this would be nice.

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
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

--gneEPciiIl/aKvOT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlshxowACgkQbDjKyiDZ
s5Lziw/8CwGdW/KeM/aKrkskZFsm3+eSkuVFkildFml3UGiD/AzUx1J9cz5Pe+G2
iVbLqPVaF5eK3pTPacyfnfGNTjHHW6dujv2UGCFiiuPbJgfhv/FtjPNXdk1EYbt/
jZ8Cx/JPtyfYyLdBjbrLXvQDbeijRXALd8KuJ8iTtmARmZRA/L8aJ9Rsxym/Awnh
kDSPAhbkamhOdN1InQx9VYHkB8HYpxuN8IeAKmh0mY6y0SOrlmBfjnl3m+3bbsJx
ChuAx99rMmsXuEok0+t+noO4OK/DxK1z0ulfYVcN8GGkOz+viyCpnNoHR75y0ZHr
gvSCySeQVaEJmS64V20tMrD2R6hxABw6DsWAuovxnjeMlGHOatOeD6/PvfSrwjLd
5Lf6ojN42HQAYyIHiPPAVEvt326YEQo13VuB8n1/XRgic7goNr3s0cN+RdXxvtHy
cn9dFvRFrtrkYtIzVBJFLJvKzQD/HksSwN7PsqLVsk7/n2/JxHWhMwmecYtQIKoz
DfbDE0fiFm7e2B1CA2rDcxMOJW8eoHgSlf751CkltAm50gi+uKGggE/JW9ohndAn
/X0bU4tYj2qsB33xyI356Z3i4oQgVgAmWhoCUQFvmKSAJGGtsu+ZtRQjZApBuQxV
3oH9DmhMezw4F6VTepwYm840IlBuRBV65LJY3sMN7NlURKUZfQ4=
=Ii6h
-----END PGP SIGNATURE-----

--gneEPciiIl/aKvOT--
