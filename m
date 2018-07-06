Received: from eggs.gnu.org ([2001:4830:134:3::10]:35626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fbFLj-0001Qc-BS
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 21:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fbFLi-0000QK-56
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 21:15:51 -0400
Date: Fri, 6 Jul 2018 11:03:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180706010315.GI3450@umbus.fritz.box>
References: <20180703151732.29843-1-richard.henderson@linaro.org>
	<20180703151732.29843-8-richard.henderson@linaro.org>
	<B9095EFA-A3D5-4EEE-A5DA-E4284FD8881E@gmail.com>
	<128b92a6-7b0e-5e27-2bad-63da14bb3a6a@linaro.org>
	<1106207A-1C28-4146-9F94-F9747BF8B345@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WHz+neNWvhIGAO8A"
Content-Disposition: inline
In-Reply-To: <1106207A-1C28-4146-9F94-F9747BF8B345@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 7/7] target/ppc: Use non-arithmetic
 conversions for fp load/store
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 12:51:00PM -0400, Programmingkid wrote:
>=20
> > On Jul 5, 2018, at 12:48 PM, Richard Henderson <richard.henderson@linar=
o.org> wrote:
> >=20
> > On 07/05/2018 09:31 AM, Programmingkid wrote:
> >>> On Jul 3, 2018, at 11:17 AM, Richard Henderson <richard.henderson@lin=
aro.org> wrote:
> >>>=20
> >>> Memory operations have no side effects on fp state.
> >>> The use of a "real" conversions between float64 and float32
> >>> would raise exceptions for SNaN and out-of-range inputs.
> >>=20
> >> Would you have any documentation that tells us about converting
> >> between 64 bit and 32 bit floating points?
> >=20
> > Spelled out right at the beginning of sections 4.6 (load) and 4.7 (stor=
e) of
> > Book 1 of the Power ISA manual (version 3.0B) [0].
> >=20
> > I've double-checked vs RISU[1] testing of LFS and STFS, with master tra=
ces
> > generated on Power 8 ppc64le, so I don't see anything immediately wrong=
 with
> > the patch.  But I haven't had time to look further than that.
> >=20
> >=20
> > r~
> >=20
> >=20
> > [0] https://openpowerfoundation.org/?resource_lib=3Dpower-isa-version-3=
-0
> > [1] https://git.linaro.org/people/peter.maydell/risu.git
>=20
> Thank you for the documentation. My guess is there are differences
> between the PowerPC and Power 8 implementations.

That seems very, very unlikely to me.

> PowerPC is big
> endian. Would you be able to do your testing again with your Power 8
> CPU in big endian mode?
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WHz+neNWvhIGAO8A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls+v9EACgkQbDjKyiDZ
s5Jwqw//U+65dZ2+DHx6/4nlAAT5Dp2vopAP1wYgqp8juUuP3ouoCesitcqSQaEi
8GhdmckGWgQjDp0E800hhyFDBg7ypxyvN7zIlKwQRvvCxj0mTmKUyLjKABEhz3nk
YqdyfkuoKVR2Tnyx4lO7xHD4mRGaS9uvxgbZhjIltmV41WVtHUJcV0fFjIT58lHF
mN81YuZm8kYgkSHst5AFGndFn6ewsRQCKAuyqUp0ALL8iGJAtRUWhv6UkP3/pXkt
j0w8ok1yYKVC1/QlZHkSP1oiRSsdbIqYylXz2WdGHULOYsH1WoQBLUoWOBAA26lD
756GAT/U0vZctFj1zmbSL/sP7zLxRMLEVDcmJE6mVxF+2tvz1vPSyVWvwc2QH6qY
WkUtAcxO/BsQLeXQEN6lVS1FXlYWFlgKzk/jdB/xRCc89ueukzEY4pJQtVwieBXS
mYE8YzL4D+B94o0KdFIz6c6UM5L2yh3mZchH6y1YULKWJlgnZ9JTJoowqCoYUeGq
pqAE/djjDofLiJIt54+YsloUX5assmWMWXgxRvrTwrE3dOjtrUKpSmhZrmdSCJBN
C/xnWHR/KnyB+jY4X9sAoG+SyctF+5L1U/m0Jc5EHuY1WA4HSjmVz7p044rdY4Bp
LEkmT1/asx/y8N9AIh9uv0+nrMFpd5OSoh+MLbdlJRXIR8xCyh0=
=zh7W
-----END PGP SIGNATURE-----

--WHz+neNWvhIGAO8A--
