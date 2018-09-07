Received: from eggs.gnu.org ([2001:4830:134:3::10]:53075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fy5e0-0004u6-4D
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 21:33:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fy5dn-00072J-Nc
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 21:33:02 -0400
Received: from ozlabs.org ([203.11.71.1]:58463)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fy5dm-0006sq-5P
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 21:32:55 -0400
Date: Fri, 7 Sep 2018 11:30:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180907013010.GC26021@umbus.fritz.box>
References: <20180906065729.2487-1-sandipan@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
In-Reply-To: <20180906065729.2487-1-sandipan@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] target-ppc: Extend HWCAP2 bits for ISA 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandipan Das <sandipan@linux.ibm.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, laurent@vivier.eu, riku.voipio@iki.fi, nikunj@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2018 at 12:27:29PM +0530, Sandipan Das wrote:
> This adds the HWCAP2 bit to detect if a linux user process is
> running on an ISA 3.0 compliant cpu like POWER9. This can be
> verified using a simple test program that prints the value in
> the auxiliary vector for AT_HWCAP2 as shown below.
>=20
> Before:
>   $ qemu-ppc64le -cpu power8 test
>   0x8c000000
>=20
>   $ qemu-ppc64le -cpu power9 test
>   0x8c000000
>=20
> After:
>   $ qemu-ppc64le -cpu power8 test
>   0x8c000000
>=20
>   $ qemu-ppc64le -cpu power9 test
>   0x8c800000
>=20
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>

Applied, thanks.

> ---
>  linux-user/elfload.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 8638612aec..e97c4cde49 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -710,6 +710,7 @@ enum {
>      QEMU_PPC_FEATURE2_HAS_EBB =3D 0x10000000, /* Event Base Branching */
>      QEMU_PPC_FEATURE2_HAS_ISEL =3D 0x08000000, /* Integer Select */
>      QEMU_PPC_FEATURE2_HAS_TAR =3D 0x04000000, /* Target Address Register=
 */
> +    QEMU_PPC_FEATURE2_ARCH_3_00 =3D 0x00800000, /* ISA 3.00 */
>  };
> =20
>  #define ELF_HWCAP get_elf_hwcap()
> @@ -764,6 +765,7 @@ static uint32_t get_elf_hwcap2(void)
>      GET_FEATURE2(PPC2_BCTAR_ISA207, QEMU_PPC_FEATURE2_HAS_TAR);
>      GET_FEATURE2((PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207=
 |
>                    PPC2_ISA207S), QEMU_PPC_FEATURE2_ARCH_2_07);
> +    GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00);
> =20
>  #undef GET_FEATURE
>  #undef GET_FEATURE2

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluR1J8ACgkQbDjKyiDZ
s5JyfhAAnz/Kubk7WlVgSrUjeLHfyrBus4ECP1c1pk3Ucgp/rsR9RpO3ANhjbnb/
BVrOZEx6cbD8LN5I+lAEnP2zK8hs4373mT8+Lg+l+2K/G6lmhhJs717WiCYPiB6J
i3+WNXs3G5dweE2IvtwqZtucGNM3uNgpeKRdsJLujGJZNjKx5cGQMHxFNnRiE+gZ
VAFQzhYbv8UAoAt2G29AxosNi6FAno2rR0SUghFBLqu5AUxhFGkHiqgiAwOUN4DG
NLoDiwP9VA1hKyUGe+/cScaz9dA5VxNXUBvBVaDXLKKLPPWDx3Ea0g+hTlCqoqXJ
DRPj23aN3WAeFOsp246KoW3RZLR2KiMLKd86eLr6mAOg5SrOJXRY7aMhzwaXdvYZ
lHNXDa1bDeG2FLGXJZMS2mrqXTprVGjHcV3bOBHvaYZ9yqpVJQBHWYGij2tBM1N+
hvrV3vZAjsDeKgj222Q4hN/++J+mWHpRCmKirdSSxDXj6E5TUzB9rto+EG2OcNTP
zn+HfPlMmaP6tfqYmpzqTm4wvFyAaL6SGRr0NhkfBe8G38QRvY7uqN1+4b5SZfFl
0OKkngGYmrP/EANC6ws1J1KmnHaQ6FI2gsCZPebRNN3nt/tAiUI+uP6Vi592XFrW
LhASof1sak4QYf1p/mpku1BzZJ6T+XVvntA5sWU1I4OGOZ1VYfo=
=pDbb
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
