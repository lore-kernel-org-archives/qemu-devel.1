Received: from eggs.gnu.org ([2001:4830:134:3::10]:38356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYmv0-0001Eg-Lj
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYmuz-0000Xh-L1
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:30:06 -0400
Date: Fri, 29 Jun 2018 16:29:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180629062949.GO3422@umbus.fritz.box>
References: <20180629062024.20477-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2/+Vq7w28QOSGzSM"
Content-Disposition: inline
In-Reply-To: <20180629062024.20477-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH] ppc/tcg: Ignore bit 6 in the
 eieio instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--2/+Vq7w28QOSGzSM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 04:20:24PM +1000, Suraj Jitindar Singh wrote:
> The kernel patch
> "powerpc/64s: Add support for a store forwarding barrier at kernel entry/=
exit"
> adds an eieio barrier instruction to kernel entry and exit points on
> the POWER9 platform. The eieio instruction form used has bit 6 set.
> This bit is ignored by hardware however under tcg it causes an illegal
> instruction.
>=20
> To allow these kernels to run under tcg, modify the eieio instruction
> to ignore bit 6.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Already done by commit c8fd8373 "target/ppc: extend eieio for POWER9".

> ---
>  target/ppc/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 3457d29f8e..b1ad1e2a22 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6496,7 +6496,7 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC=
_STRING),
>  GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
>  GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
>  GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
> -GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x03FFF801, PPC_MEM_EIEIO),
> +GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x01FFF801, PPC_MEM_EIEIO),
>  GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
>  GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
>  GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2/+Vq7w28QOSGzSM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls10doACgkQbDjKyiDZ
s5Li5Q//f+RLVHFQjb6rixspO/oIJ+M2vGkGv2Fb+3C7CeK7q3RX1o1jxm73CrT+
ooG8uNsyPHeXFderTtaLbxh1o4nVsEbFzAaL+iSYxDIXRNJEJYN91Y/mFmx1XeyT
znh+3LZnJtr3wT46ItnsCmg1LdZSuDJ5BzVjIJvcIKM6v2o6f93pzl335WrZ0WB+
bLL78nUrD+mP7K5PmzAGRKUYZ9GjrIk+DVw/JnAEte+yROLrdPS5A8WaYgXvbphF
QxOlKqQvHtgIEjCYsKV2LkA4Q+uddThrrx6OFs137X587Sq/a0nJwwofH6oZ9m4S
dehx37ZC6kzUn/S5zvonZEFv0VWPpsfTEg5Lf+lrJStBVmpR6m71R7emh9gm/D8E
R9HQlQ22sL742iWkEV5zeSEZ/ly0WSz0mXjnJ/cJbSj2FzAGSEI+H3cBMz+T0TLU
rabwTtoKetQfEcTudueMmCCOj+x2yuPXuEDhRyIYJsdVJJ0jy6HwX3/oJn0teZvl
AVSps45EnAnMoq9DXPCsSio0JCJnvcK6Bvi64iI19RGBIeBK1n4V18m+IWM+0QNR
RtcA/SFOJAYj2AR2R9EshtZM/SR0DPWDjw/Uspw+SHkdQ0maQwzcaJDuXT/rIeZY
V6+Dz/LsxHRwndwUyD7g7kd1XKuBwsNBOXtnQ9Ohp7otmK6fUok=
=2b3i
-----END PGP SIGNATURE-----

--2/+Vq7w28QOSGzSM--
