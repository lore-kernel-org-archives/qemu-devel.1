Received: from eggs.gnu.org ([2001:4830:134:3::10]:40242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1flShL-0005qk-95
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 01:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1flShI-0000zO-66
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 01:32:23 -0400
Date: Fri, 3 Aug 2018 15:31:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180803053143.GE11211@umbus.fritz.box>
References: <20180802144430.13870-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N1GIdlSm9i+YlY4t"
Content-Disposition: inline
In-Reply-To: <20180802144430.13870-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 0/3] hw/ppc: Convert various devices away
 from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Alexander Graf <agraf@suse.de>


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 02, 2018 at 03:44:27PM +0100, Peter Maydell wrote:
> This patchset removes various uses of old_mmio from minor PPC
> devices:
>  * hw/ppc/prep had an entirely ifdeffed-out stub of an XCSR device,
>    which we remove
>  * hw/ppc/ppc_boards had ref405ep_fpga
>  * hw/ppc/ppc405_uc had three minor devices
>=20
> As you can see from the diffstat, the new API provides much
> cleaner ways to handle the various different access sizes.
>=20
> This knocks another five old_mmio uses out of the codebase,
> leaving us with just five to go.
>=20
> NB: Tested only with 'make check'.

Applied to ppc-for-3.1, thanks.

>=20
> thanks
> -- PMM
>=20
> Peter Maydell (3):
>   hw/ppc/prep: Remove ifdeffed-out stub of XCSR code
>   hw/ppc/ppc_boards: Don't use old_mmio for ref405ep_fpga
>   hw/ppc/ppc405_uc: Convert away from old_mmio
>=20
>  hw/ppc/ppc405_boards.c |  60 +++-----------
>  hw/ppc/ppc405_uc.c     | 173 ++++++-----------------------------------
>  hw/ppc/prep.c          |  97 +----------------------
>  3 files changed, 39 insertions(+), 291 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltj6LwACgkQbDjKyiDZ
s5JNjw//Y4WzbVxCM18EU4Sd4Cf6JZ2wYGO7xIwXFBBUZGBzJxeBMYdxfS50iaEl
z/a8eXDwzuLV0Ithwjortd1vn41y5jB1rLmGsOjUcmcECTaDMfLya0CSozOvsesH
UlXFXPsbY48H9nUizQ1/JQ3lENxXKCjzeDEIRi4UzMKR7djS/G8F9bix6lwS51iH
lXtZgjX9InQrGM/kNQXwfPXDLoNH4OynWztXOzgx8oQ9COsTcCJLOdB+jvwauO/T
V78jPym0Y11uEOV2v4gvfi9UVfovkICikhjyoSbbBTUPWBEsusIqR4333jyEaNxi
ggl4jlwDhJLOJ3y15vHEl/0WMPkyyroeFJibQfllPuk8GIgfUcei4Ugqa87mZjda
EGwXr4yzir4iaYxljvGMcpM8Ox5hAI7gnGk6ugMIzLu7gpDa/YUBiSYYNhup2KwP
JX17f+QRF+QK3BqyHm5o3VXN/mt7APQh9nZ8JLGpmPFlRzkbKLhognb6drHSSoVx
Ohz7DyieB0swBxS9WhBl6t1UKe8yKoPapn8Y9jdHAKl9R8HNCkkDNWc2hvF8viVt
ZChxmiJVDh9rwS28o4w/HO+Iv1Qycju6VTGyHNaip/YuqOTz0ikZIDKeHHniYjoo
pTfXVUz/tpAuRkqQUIl57Fxr+eSQ2KHvxc3/w1aGubSBgbn0Oss=
=P5xx
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--
