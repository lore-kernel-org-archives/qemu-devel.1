Received: from eggs.gnu.org ([2001:4830:134:3::10]:53354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ew02q-0004Fl-9k
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 02:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ew02m-0002Cp-CG
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 02:37:52 -0400
Date: Wed, 14 Mar 2018 16:39:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180314053950.GI4182@umbus.fritz.box>
References: <1521001735-24149-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4C6bbPZ6c/S1npyF"
Content-Disposition: inline
In-Reply-To: <1521001735-24149-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/boot-serial: Test the sam460ex board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, balaton@eik.bme.hu


--4C6bbPZ6c/S1npyF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 05:28:55AM +0100, Thomas Huth wrote:
> We've got a U-Boot firmware for this board in our repository, and
> the firmware prints some output to the serial console, so we can
> check this board in the boot-serial tester, too.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied, thanks.

> ---
>  Note: Patch has to be applied on top of the ppc-for-2.12 branch
>=20
>  tests/boot-serial-test.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 5b24cd2..011525d 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -79,12 +79,14 @@ static testdef_t tests[] =3D {
>      { "ppc", "40p", "-boot d", "Booting from device d" },
>      { "ppc", "g3beige", "", "PowerPC,750" },
>      { "ppc", "mac99", "", "PowerPC,G4" },
> +    { "ppc", "sam460ex", "-m 256", "DRAM:  256 MiB" },
>      { "ppc64", "ppce500", "", "U-Boot" },
>      { "ppc64", "prep", "-boot e", "Booting from device e" },
>      { "ppc64", "40p", "-m 192", "Memory size: 192 MB" },
>      { "ppc64", "mac99", "", "PowerPC,970FX" },
>      { "ppc64", "pseries", "", "Open Firmware" },
>      { "ppc64", "powernv", "-cpu POWER8", "OPAL" },
> +    { "ppc64", "sam460ex", "-device e1000", "8086  100e" },
>      { "i386", "isapc", "-cpu qemu32 -device sga", "SGABIOS" },
>      { "i386", "pc", "-device sga", "SGABIOS" },
>      { "i386", "q35", "-device sga", "SGABIOS" },

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4C6bbPZ6c/S1npyF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqotaQACgkQbDjKyiDZ
s5KmtA//WkXsz+XnnvGjWmmtbP84BPk/RiIL/6Ot3tvjPj01B3U7RBAUBNAjp8HN
YaUCJZkTZGV1BcCX6/vTYJB/5usZGbStep6xZmRDVRJgnuaxKjzAjtoSr3i49bnM
zI7E/DjBWUQ5Pvzj3r8dmhAIbDKulPXX0L35LnSWZIR+h7KNuT+z91og9R3LM81L
X8Hg1MnsmO7tu+0aPOjCAJU49+8cxrvOajTB78fIaamsJdAtrY/Mf41dr7piLORb
iYUe2EanzZGXsZJkqsrMBCvZdmp/hHJHSvCRll90/lkd0RvbsM/ywb6Emzo996TF
AwcEIR2kqhRvv0FlZlt2Pxa/hNVeyrCMM0ofYPr54ocZZbvMU04ZZNZov71p0pJA
gZlf9+qv+xQc97iBhMo7IFtCLa64Hr4vkDYWlFs6cwhqIt2a5zn65ABoxxfRzxxp
Cui+lTQyVPA30++xrveruWEU8MDzTh4hxakzru3VAX88EuVrzXjv+jrjjCb09uDx
B5vQeTXWbB0RuRsALM4N+6qbBaRBUeHYbpj3waxmbS0TPAV/cCdqQPZE9edNVPkh
fKpm2JdA632GVcjLIbXn4XJkMG/qGlnp4Rw7ZfnU7j/plbt2iUNQaj0eef0aM+kW
FXvL9oeF0t1Dvh4hljdSuAyLSAef6t3V8A+KszLHFw7YUKHoavQ=
=SFZO
-----END PGP SIGNATURE-----

--4C6bbPZ6c/S1npyF--
