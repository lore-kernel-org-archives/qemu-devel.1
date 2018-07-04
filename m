Received: from eggs.gnu.org ([2001:4830:134:3::10]:38717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faZs6-00011D-SR
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 00:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faZs6-00019a-3E
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 00:58:30 -0400
Date: Wed, 4 Jul 2018 13:31:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180704033134.GE14043@umbus.fritz.box>
References: <20180703151732.29843-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline
In-Reply-To: <20180703151732.29843-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-3.1 0/7] target/ppc fp cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, programmingkidx@gmail.com, qemu-ppc@nongnu.org


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 08:17:25AM -0700, Richard Henderson wrote:
> Beginning with John Arbuckle's fdiv test case, clean up some
> of the fp helpers.  As with fdiv, fre and fresqrt are missing
> divide-by-zero exceptions.
>=20
> I've also noticed that load/store were using arithmetic conversions
> to/from float32.  These should be using the non-arithmetic algorithms
> listed in the manual.
>=20
> Aside from cleaning up all of the rest of the helpers, I believe that
> the implementation of the single-precision operations are incorrect.
> They are currently implemented with the double-precision operation
> followed by a round-to-single.  This causes incorrect results via
> double rounding.  I believe better results could be had by using
> these non-arithmetic converters to produce float32 operands, use the
> proper float32 softfloat operations, and then convert back.
>=20
> Anyway, all of this has been broken long enough that it'll need to
> wait til next devel cycle before anything further gets done.

Applied to ppc-for-3.1 (newly created).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls8P5QACgkQbDjKyiDZ
s5LiQQ/9HV4VjL6bNDJ5ihhZkFTQ84/pBbt8LYVS/ibuUtMF0CKT5rbtHcLNbk6q
hGfaMNGmsd++8mT6cmzSWXVQAllB7f4W+jYn8gseTkCP/h5w7ZyKf8kNb8JscP4n
oSiH1QysV6BvGGWM2JridaEJVKxBq+KHJVsnOs8A6y+amdcWjDysgn+OS4fo7Im2
a0JOvQTjirPUDUMAI8m9gXcadu3H5cXxpUIUtq9/EsRwMDiIVOQIAZy+CYPBF4/R
RKjiOF/CKHhktWpEa8atjZB/F+glc7Q+z1bM2/4Oz4RbgfOCH9/cf03HSti1H1I2
qiM8wD5a6SXtNBevyXNQD9RwWeGmBuvye54KTCmUVqVK6KRQn/l1p4PSyzOjBuJS
yjnuPvh7m+cJrHuHR+oBrJUjKNvtiLc6zjWOk2U7brh7us2cTcWBWl7AT1uAHCu/
yKmu44SozxKHX7ceQV40nvcqT7EKJwOsG5Hgilbow2WxYDdpOFGuRGQj+KiDyWup
Xfo71+TdQwp1ePxNAF0sg/2PWhi0ERTiOge7Su+cbvbylbVulOWh/14gtPcMWuHs
0ueEqWys04UXUjn/ZPi0ytUzmIP6ZU8+H4a7JG9IoIAYA+tymBIRNkyde87PI57u
EBdbsCIFDh5Y98Z9RpPRdN8Tseenh/pKEdFzfsyPmQxyEINGrks=
=ATvr
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
