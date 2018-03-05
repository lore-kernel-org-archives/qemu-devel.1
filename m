Received: from eggs.gnu.org ([2001:4830:134:3::10]:35595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esf5J-00010X-PO
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 20:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esf5H-0003iA-4K
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 20:38:37 -0500
Date: Mon, 5 Mar 2018 12:29:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180305012944.GD2650@umbus.fritz.box>
References: <cover.1519991414.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1sNVjLsmu1MXqwQ/"
Content-Disposition: inline
In-Reply-To: <cover.1519991414.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Firmware blob and git submodule for
 Sam460ex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Jeff Cody <jcody@redhat.com>


--1sNVjLsmu1MXqwQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 12:50:14PM +0100, BALATON Zoltan wrote:
> This is v2 of the firmware image for the ppc sam460ex machine type in
> case you choose to add it with external git repo first. In case you
> decide not to add it either as external git nor as a mirrored or
> copied to QEMU repo then probably some wiki page should be updated to
> point to a binary image for the machine to be usable but I'm not sure
> how to do that. Please advise which of the above options should be
> followed.

Applied, and moved before the same460ex board to avoid bisection breakage.

>=20
> Thank you,
> BALATON Zoltan
>=20
> BALATON Zoltan (2):
>   roms: Added git submodule for u-boot-sam460 (firmware for sam460ex)
>   pc-bios: Added u-boot-sam460 firmware binary
>=20
>  .gitmodules                        |   3 +++
>  Makefile                           |   2 +-
>  pc-bios/u-boot-sam460-20100605.bin | Bin 0 -> 524288 bytes
>  roms/Makefile                      |   7 +++++++
>  roms/u-boot-sam460ex               |   1 +
>  5 files changed, 12 insertions(+), 1 deletion(-)
>  create mode 100755 pc-bios/u-boot-sam460-20100605.bin
>  create mode 160000 roms/u-boot-sam460ex
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1sNVjLsmu1MXqwQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqcnYgACgkQbDjKyiDZ
s5JhrQ//WQ7YT9Yt03uXQSrJXx5DhZbmF5qmjRK7IgyusqWjSjknvQzo0hasVjUr
/hVRPQWBxht4U1B3ZeqAiPLN10xCJAx7vhe4oE0u7F4WWc78W1tjZx863A0adkUY
WYqqIvvC9b7JfhqkCVRbTFlF5BKhp58B7OR6cukJLADJf60R7sHv7/CnUA8s2w7q
9G5gMkSipe3q8v3AZclzgE2B2ZQ5bkPbQNie/XMvllthQG9qAMaDDpbpWd4C8RLv
6YDEykNdJ2y7ITiAvnXK9hXCwOip5CW/5GsyVp8uM91TX3ZWB6O7SDhv3h0Ws/4Y
uRep2XVLPzW7mAhNH+BicMHou/uyoAlQog9Uznfq91e+Eo+LttI9wmRf86mZRMs8
c1bpRWYDr441Ccp9919ExBeUgDpvCRCyFwhCR0KFC/kNMEehLUkKdzPJsnzuYJ/H
QlVEb2y6et82h6lvfFvsd+zPKvQz74CojRDrcEhi4RYJF3+VkXd1j0RrmUsBT/AW
vApxpfF0D0C9hyxPFYodgGF87kQOMantaI5qROuJ0dRFXUgBW0Cg49qpCYdVFz1l
jH6MSrysGEZEQYvwoVOZuGNLoCSuAAviFM08I5E2pYwE0j976613arONXNVCPUQT
cJiPXRiHyP8ZtFQXwZjoo1GxHUP+KeG6QB6tY1I+wEsFzRFVmls=
=khsM
-----END PGP SIGNATURE-----

--1sNVjLsmu1MXqwQ/--
