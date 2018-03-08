Received: from eggs.gnu.org ([2001:4830:134:3::10]:42919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1etlaI-0005HR-JG
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 21:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1etlaF-0007pV-Gx
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 21:47:10 -0500
Date: Thu, 8 Mar 2018 13:02:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180308020240.GL3083@umbus.fritz.box>
References: <1520424915-9794-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HLsZ5Z1opAQvdr2J"
Content-Disposition: inline
In-Reply-To: <1520424915-9794-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/boot-serial: Check the 40p machine,
 too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org


--HLsZ5Z1opAQvdr2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 01:15:15PM +0100, Thomas Huth wrote:
> The "40p" machine is using the Open Hack'Ware BIOS, just like the "prep"
> machine, so we can test it accordingly with the boot-serial tester, too.
> While we're at it, also change the strings that we are using for the
> "prep" machine, so that this test now also checks some CLI parameters.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied, thanks.

> ---
>  NB: The 40p machine is currently broken - when the emulator is quit,
>  there is a rcu_read_unlock assertion message printed out. This test
>  here succeeds anyway since the qtest framework does not care about
>  errors in the shutdown path yet.
>=20
>  tests/boot-serial-test.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index ece25c6..5b24cd2 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -75,11 +75,13 @@ typedef struct testdef {
>  static testdef_t tests[] =3D {
>      { "alpha", "clipper", "", "PCI:" },
>      { "ppc", "ppce500", "", "U-Boot" },
> -    { "ppc", "prep", "", "Open Hack'Ware BIOS" },
> +    { "ppc", "prep", "-m 96", "Memory size: 96 MB" },
> +    { "ppc", "40p", "-boot d", "Booting from device d" },
>      { "ppc", "g3beige", "", "PowerPC,750" },
>      { "ppc", "mac99", "", "PowerPC,G4" },
>      { "ppc64", "ppce500", "", "U-Boot" },
> -    { "ppc64", "prep", "", "Open Hack'Ware BIOS" },
> +    { "ppc64", "prep", "-boot e", "Booting from device e" },
> +    { "ppc64", "40p", "-m 192", "Memory size: 192 MB" },
>      { "ppc64", "mac99", "", "PowerPC,970FX" },
>      { "ppc64", "pseries", "", "Open Firmware" },
>      { "ppc64", "powernv", "-cpu POWER8", "OPAL" },

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HLsZ5Z1opAQvdr2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqgmcAACgkQbDjKyiDZ
s5LGnBAAoDd2tCG6rriyvl9h5rhJK2IDG2nLPJFd4+Wr0/yqmeOjmGE6OndnFCcU
03tO6wb3k9gp8SUv9wdIbBXeAECPiy43HBobCPkUp6m2T+ZdOnHisBvTsrRhe8LL
IDIO2iUfOZCMx5Hfbfd54zlY+FDncKuwg/0O2BjK1cb2l4VKhCIyAj+LIRqwE2O9
F92purhoC84JkbM3+hhSp/dWd0UjLQcek/1RstZ1kQs2h82V0NIs2erdtr0DVHZy
sUHj5WWnzphrxhe1uMlFnuXXa903XWLnV9AL/PwQoSNmfZZ6HbrLZanek7LCBsjU
EX2hvGBGY+IBp8EiTpGr2UjsKwfXpMMZ7lri/A1kwPBjlHSD2AUthT156/WJ/bkw
yGiBTudxEEIL0KuxbArXkdh0bSTzB9Ud43kjtYFrmemdKtFlkUR/wz1NTGikevch
uOEb+AI1CJHnoz4mtrpyFP8HTeowFp5zKbNJeF7VxUpz5KpXf4sntoePaULsqqzt
G1qLsII4Cpwb+95rBvowfTUXYgqnZXOiL9NVWIoXwMSKqIVNH0YWQCJ1tTK0ZRrC
mdQEY+cAZSUgsLZ4jM8xfN0/rrZy/9rTY2fk2fDIfePJyMbELxskOGQo8ZXKs6rh
mz2yZYJBBKS5zAg9mqEbWbCimBR+g5W1g8XAzFwqqMKkvHvlHzU=
=vLb6
-----END PGP SIGNATURE-----

--HLsZ5Z1opAQvdr2J--
