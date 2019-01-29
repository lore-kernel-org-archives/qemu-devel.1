Received: from eggs.gnu.org ([209.51.188.92]:50455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1goLHW-0006jV-8J
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 23:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1goLHV-0004M5-Dz
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 23:45:54 -0500
Date: Tue, 29 Jan 2019 13:28:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190129022847.GG1870@umbus.fritz.box>
References: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
	<20190127090306.30826-3-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.9999.1901271251060.35973@zero.eik.bme.hu>
	<3dc12858-4254-9da1-7eb2-309948d0d376@ilande.co.uk>
	<5ea37d08-91f6-33cc-b220-f1a96796d794@linaro.org>
	<897875e0-fc56-c280-0cd0-c7e0dac04fa1@ilande.co.uk>
	<3f43ac97-26d0-98b3-a8b4-8102acb73457@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7uYPyRQQ5N0D02nI"
Content-Disposition: inline
In-Reply-To: <3f43ac97-26d0-98b3-a8b4-8102acb73457@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 2/8] target/ppc: rework
 vmrg{l, h}{b, h, w} instructions to use Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--7uYPyRQQ5N0D02nI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 27, 2019 at 10:07:12AM -0800, Richard Henderson wrote:
> On 1/27/19 9:45 AM, Mark Cave-Ayland wrote:
> >> I would expect the i < n/2 loop to be faster, because the assignments =
are
> >> unconditional.  FWIW.
> >=20
> > Do you have any idea as to how much faster? Is it something that would =
show
> > up as significant within the context of QEMU?
>=20
> I don't have any numbers on that, no.
>=20
> > As well as eliminating the HI_IDX/LO_IDX constants I do find the updated
> > version much easier to read, so I would prefer to keep it if possible.
> > What about unrolling the loop into 2 separate ones...
>=20
> I doubt that would be helpful.
>=20
> I would think that
>=20
> #define VMRG_DO(name, access, ofs)
> ...
>     int i, half =3D ARRAY_SIZE(r->access(0)) / 2;
> ...
>     for (i =3D 0; i < half; i++) {
>         result.access(2 * i + 0) =3D a->access(i + ofs);
>         result.access(2 * i + 1) =3D b->access(i + ofs);
>     }
>=20
> where OFS =3D 0 for HI and half for LO is best.  I find it quite readable=
, and it
> avoids duplicating code between LO and HI as you're currently doing.

Marc, Richard, where are we at with this?

Should I wait on a revised version of this patch before applying the
series?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7uYPyRQQ5N0D02nI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxPul8ACgkQbDjKyiDZ
s5Kr6Q/9EvM9DOvZ60SEPsefkt9RtgW5SNeT7aNPudXpeGPFXcpuN8a50r5I6UX9
6mS3XlMU0QcEGr71gu0kx4ADCsTNNh9oG+7kRnkHaW7NdCC5wJESyVMK9T+tR24r
MWGmfz4p+GPBTFtnvtZ4ZkuOMXpeD6hv/RWtbxIrHGVColjm9SoN6Pb/xBMJVh3W
hD2iOMW37Q08sYat4XCT2BquDai839TNuu9VRDoEAYJnab/ks1EVByiqCWCbIgR/
QHJwMfj4r6Z7IOF6+dWP/BjLDOLHF71GVCTOkr18cfivXCAxHOZtz/C0oZBZXpZg
MzyquYbMWdMcnoh2+HGwuXSo01ZjGkTr2pA1lFfudZlzG1XGPga7YB8C/qLKNRlO
+B3tnwQK3PDUqKYMUCnQncXOjakh+4uXW/NqOiVM2GrhT9f0tqSAEr8EK5/uY2rA
9OMkR3Gl/ajAmfpso4VQuQ5nphQg61TLSRU1WWSQ3umwfTsDOOy2wft2YrkvoWzx
wUz/7d0qQfH4e0YEkQl12qotleq0kIwRtVWVT7GimxnxfkRDtXegCfS0YuSqv2Mj
kB5zJ1XOUZYsqOBwaZ6v2cEOEH1nrBE4AMTryY0knkeX6qD51JLO0SetXX1QeK8s
RGUqcy+4JaE1zkVAsvbhI0uhbtUswGbU82dDo+x1iv4gULaZDPM=
=C5Rn
-----END PGP SIGNATURE-----

--7uYPyRQQ5N0D02nI--
