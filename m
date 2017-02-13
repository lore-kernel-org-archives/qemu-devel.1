Received: from eggs.gnu.org ([2001:4830:134:3::10]:33195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd6Js-0004QT-TW
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 21:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd6Jp-0007v4-P8
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 21:24:48 -0500
Date: Mon, 13 Feb 2017 12:54:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170213015414.GN25381@umbus>
References: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1486636445-24109-6-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170210001035.GJ27610@umbus.fritz.box>
	<87k28yekze.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6yHiY5vv/BiPjcMt"
Content-Disposition: inline
In-Reply-To: <87k28yekze.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 5/6] target-ppc: support for 32-bit carry
 and overflow
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


--6yHiY5vv/BiPjcMt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 09:49:17AM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > [ Unknown signature status ]
> > On Thu, Feb 09, 2017 at 04:04:04PM +0530, Nikunj A Dadhania wrote:
> >> POWER ISA 3.0 adds CA32 and OV32 status in 64-bit mode. Add the flags
> >> and corresponding defines. Moreover, CA32 is set when CA is set and
> >> OV32 is set when OV is set, there is no need to have a new
> >> fields in the CPUPPCState structure.
> >>=20
> >> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> >
> > Um.. I don't quite understand this.  If CA always has the same value
> > as CA32, what's the point?
>=20
> I am not clear either. I think that as CA was set for both 32/64-bit
> mode, that couldn't be changed for backward compatibility. CA32 should
> have affected only the instructions working one word variants.
>=20
> Re-scanning the ISA 3.0, found this in 3.3.9 Fixed-Point Arithmetic
> Instructions:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> addic, addic., subfic, addc, subfc, adde, subfe,
> addme, subfme, addze, and subfze always set CA, to
> reflect the carry out of bit 0 in 64-bit mode and out of bit
> 32 in 32-bit mode. These instructions also always set
> CA32 to reflect the carry out of bit 32.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Which is conflicting to what is said in 3.2.2 Fixed-Point Exception
> Register:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Carry32 (CA32)
> CA32 is set whenever CA is set, and is set to
> the same value that CA is defined to be set to
> in 32-bit mode.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Well, that's certainly confusing.

Can you try and find out what's going on here within IBM, and repost
these patches once there's a straight story about how this bit works.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6yHiY5vv/BiPjcMt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoRHGAAoJEGw4ysog2bOS2ugQAJDDn9HzB9VIvEB9eg3BWDiZ
TzBbB1zJcJLfR+j2NngV5IqehrvntE2txC+l51sBvH07O426deSxGG2oPcLf6cJt
96ZPB0J11znW0mJSK7pcB4oI8PRZu9yWsdit7kaNZRauWEpiXEou7cOmXtaVlgBT
S2JBOfHlaHlqXIxtNMWghFJADo87w7BJFoz0X2MUjmpNjgFJWALXpTnwwrcuzQPd
/cOjCQFM0XheuteuJTxMJ2zXU9dKLU2HHM8cpO3Bd7SnfcgjK2eXZDUW+VXnTb+/
KQfRXmz17pK57QLXlwklZuF6xHXJSMbRUB2KsUrGYjvxWl631cptJWHj1Hko/N2M
YRkCuzaoZboMz4iTBOuD3aEfYUioJ99jqzCw1YgSGinrmkPQOBBfRpytcnAvjuMu
0ZpEuem/eg/DctQEL7QNxswktqq0Ui4sVqGeDIkw8Q/aPR8Y8+sce2uuDv00aDgW
yPfhLvU/T/KsIXH7UFPVRII0k1y5j0o+jF0d8Jw7w2RjnipiT11zlBOdNl0yJmuQ
T9J0oy/KX5YLW3gMy3WIOneR+mN0P5M78hQTv5huJb/OX81d245EJLv9wX8b496M
3NNneT4EWgsp1MwA+kIoyV4DG1Y6wIt50Ims/8u9nbB7LNPE7w5dfAIgDOWYMRB2
BOx+4hum28GKI8vbrVyR
=cHti
-----END PGP SIGNATURE-----

--6yHiY5vv/BiPjcMt--
