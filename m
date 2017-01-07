Received: from eggs.gnu.org ([2001:4830:134:3::10]:55414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPlo3-0005ni-OS
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 02:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPlo2-0006HI-Qs
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 02:52:51 -0500
Date: Sat, 7 Jan 2017 12:02:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170107010249.GP13763@umbus.fritz.box>
References: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1483683296-32568-3-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170106075407.GO13763@umbus.fritz.box>
	<87pok01tjw.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QAdlk5ze2izLk3Ap"
Content-Disposition: inline
In-Reply-To: <87pok01tjw.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v1 02/14] target-ppc: Add xxinsertw
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--QAdlk5ze2izLk3Ap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2017 at 01:58:19PM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > [ Unknown signature status ]
> > On Fri, Jan 06, 2017 at 11:44:44AM +0530, Nikunj A Dadhania wrote:
> >> xxinsertw: VSX Vector Insert Word
> >>=20
> >> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> >
> > The comments I had about out of bounds shifts don't seem to have been
> > addressed here.
>=20
> Bounds are addressed inside the for condition:
>=20
> #if defined(HOST_WORDS_BIGENDIAN)
>     ins_index =3D index;
>     for (i =3D 0; i < es && ins_index < 16; i++, ins_index++) {
>                           ^^^^^^^^^^^^^^
>         xt.u8[ins_index] =3D xb.u8[8 - es + i];
>     }
> #else
>     ins_index =3D 15 - index;
>     for (i =3D es - 1; i >=3D 0 && ins_index >=3D 0; i--, ins_index--) {
>                                ^^^^^^^^^^^^^^
>         xt.u8[ins_index] =3D xb.u8[8 + i];
>     }
> #endif
>=20
> That way ins_index will be within 0 - 15. Let me know if I have missed
> something.

Oh, yes, I missed that.  Sorry.
--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QAdlk5ze2izLk3Ap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYcD43AAoJEGw4ysog2bOSZ8YP/1ZTtvg2Ghg46gr4uuI7k9JI
ZugnBcKg2w1W2jdnMTeB6NE462A+KPol1ewTTPoMy8NNsd8DiAj3u1ch5tItJr60
5LsKy6ADEQg1pwQlCXdEccLLd7BEuil1FOcm0XIeUHeBVPeyQWX0rFbuKqSAXLbW
CRZ1DJtagKnvk5htBRgCvhWYOX09i6wmYyswqmHa1IJDbDECG4RK3qDtkJTiuPoY
s2QQ8xVKmVfjw6+/iseo8NJfmfHsF9Rkmpmeqp7tlV2YOfYOIKO4kMp0jFVqrsKs
mDntDj+M75z1OQmxl+Ll+h/ulBX4gVI6OVinC5H+G3cNmH8T7cXrDxWzguIkoxxN
OtKELL78BR9P7AzJxs9rqlpE6OkiaAuIWSfOF8daRA2uK8pUY5H0husnqbMPfYXZ
jasVbZFrEaShNYCuprxHvC4cTyyulUsDw8jmsH9NRaXAyIvncfvV27BF3bJYDaDr
JZz8qsJ+BfojvBvbjvS01y3rxr7X2d3qq+lrPQjU9poZ2OrN215VBQX2ai3w9AKJ
D6CdZq0slB/SjoU2+XjUCoHT/PY0pmUNnGVxSKGMC/rtdbcp1V8GVJp6Z4AMqOVt
Jri49hPFpaOVZ1nB4ZaG4HtoZ4vAByRanIk539b2bn3J+ov42dNrjAFsvNLEbsmz
Ij4A1t7nH6Yu0IEJ9rgQ
=NTU2
-----END PGP SIGNATURE-----

--QAdlk5ze2izLk3Ap--
