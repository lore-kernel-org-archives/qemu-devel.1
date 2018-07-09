Received: from eggs.gnu.org ([2001:4830:134:3::10]:37089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcN8a-0003Up-6T
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 23:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcN8X-0005a5-41
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 23:46:56 -0400
Date: Mon, 9 Jul 2018 13:32:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180709033236.GB22363@umbus.fritz.box>
References: <20180708221932.E95CC74569D@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <20180708221932.E95CC74569D@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH for-3.0] sam460ex: Update u-boot-sam460ex
 firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Sebastian Bauer <mail@sebastianbauer.info>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 12:01:46AM +0200, BALATON Zoltan wrote:
> Update the submodule and u-boot-sam460-20100605.bin to include
> following fixes from Sebastian Bauer:
> - Fix build with newer gcc
> - Decrease unnecessary delay which fixes slow booting from CD
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied to ppc-for-3.0, just barely in time for my final pull before
hard freeze.

> ---
>  pc-bios/u-boot-sam460-20100605.bin | Bin 524288 -> 524288 bytes
>  roms/u-boot-sam460ex               |   2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/pc-bios/u-boot-sam460-20100605.bin b/pc-bios/u-boot-sam460-2=
0100605.bin
> index 99408f8e957b26e735e5befa98fa3d51a90d95f6..e17de77c1974382144625632c=
709c29a1a86edef 100755
> GIT binary patch
> delta 84
> zcmZo@P-tjSm>@3hRhpw<V4+}SU}&MBt6*egWnyY&Y^*tXBiE%S#%+v@Tql?qjHdIP
> gWSj-0+gF@q1Y#y2W(HywAZ7((w(ToUvPYN!05~lj7ytkO
>=20
> delta 84
> zcmZo@P-tjSm>@3hpIo9~WTaqZU}&zOt6*quWny4uV5B*DBiE%S#%+v@Tql@>JErrT
> gWSj-0+gF@q1Y#y2W(HywAZ7((w(ToUvPYN!08um@+W-In
>=20
> diff --git a/roms/u-boot-sam460ex b/roms/u-boot-sam460ex
> index 8ee007c..60b3916 160000
> --- a/roms/u-boot-sam460ex
> +++ b/roms/u-boot-sam460ex
> @@ -1 +1 @@
> -Subproject commit 8ee007c4216fd6a0d760589e8405ce4494497aa0
> +Subproject commit 60b3916f33e617a815973c5a6df77055b2e3a588

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltC11QACgkQbDjKyiDZ
s5KJ8xAAsPCC0nBb1eTJp7ebxhZfg1TdSnZw2F63no9xoJOjR/lP3JR9fohfL9Ws
KCC/9WivPHJ/Kb34Rpwgz6Ygpw5UGZmE5wyiP8o7gDkmduJcNEoPIaQqrJK++Wqn
HXyyK9uHlUhIRPstw0MKi/hoxR0Q7c3q/n1KxvJDT/1HszXBJzxBTpdtZAP18G02
Z7JhRsb2ZEYxWGlgPLdwwTo28FVjLW+5V5i17BiYuGXQak1kbxgVX9MfOa01T0Ih
YavNKoB1EFoPXkpiSAw5pjqyjT5neObaqjnCc4SDtRbHmvmiXBxUC0W0s9maOhbb
NeamgGQ7i4Cyp0jBmGP+xQEHwilCeIiX50FrklHRB+gwG6WsssDaJ36VGKvN2b4C
mi9QLmU+xZQRMUUSfKIyK/VueLn5+N1IDxXcjp9fKLt2tRoSIzv7Weg0GLzHaIkC
bKBDeOhVOfKXXmKfjTmaIZUdkoBp0e+E6oHp0SvzHcTJHNUm0otfETFKupoQEELc
dJm4FZC8qEtMP4/xPid7Bb8debPNyhSpjZltcap/b52h5qa8WBZQ5O159fccv8SM
SAxRxgm/TKCWI+fuwFQpKSrR4cSxV7iEUDUzGKxg0HtJ4TLvDPrRhRAkt41iGfSi
sYmI1zDC8xNybEvNk1zcliBhIexajjZ2gBvix/EEw9H8ld6lYGU=
=pzmp
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
