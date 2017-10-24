Received: from eggs.gnu.org ([2001:4830:134:3::10]:53267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e72Jp-00030u-8f
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e72Jo-0004dx-BG
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:44:45 -0400
Date: Tue, 24 Oct 2017 18:31:23 +0200
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171024163123.GF15297@umbus>
References: <20171020175548.2566-1-programmingkidx@gmail.com>
	<f9bd98f1-d45c-6d3a-c35c-c67da67c881f@linaro.org>
	<20171022053315.GA15297@umbus>
	<4CE427C5-BD1A-4911-9B10-CC1C0F80FD12@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SnV5plBeK2Ge1I9g"
Content-Disposition: inline
In-Reply-To: <4CE427C5-BD1A-4911-9B10-CC1C0F80FD12@gmail.com>
Subject: Re: [Qemu-devel] [libfdt][PATCH v2] implement strnlen for systems
 that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, devicetree-compiler@vger.kernel.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--SnV5plBeK2Ge1I9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2017 at 12:16:47AM -0400, Programmingkid wrote:
>=20
> > On Oct 22, 2017, at 1:33 AM, David Gibson <david@gibson.dropbear.id.au>=
 wrote:
> >=20
> > On Fri, Oct 20, 2017 at 04:44:58PM -0700, Richard Henderson wrote:
> >> On 10/20/2017 10:55 AM, John Arbuckle wrote:
> >>> +static inline size_t strnlen(const char *string, size_t max_count)
> >>> +{
> >>> +    size_t count;
> >>> +    for (count =3D 0; count < max_count; count++) {
> >>> +        if (string[count] =3D=3D '\0') {
> >>> +            break;
> >>> +        }
> >>> +    }
> >>> +    return count;
> >>=20
> >> Not to nitpick, but
> >>=20
> >>  const char *p =3D memchr(string, 0, max_count);
> >>  return p ? max_count : p - string;
> >=20
> > Richard's right, that's definitely a better implementation.
>=20
> I was just wondering, what if we rewrote the code to use strlen()
> instead of strnlen(). Would that be an acceptable solution?

Only if you can do so safely - i.e. without accessing memory beyond
what we're supposed to.  I don't think you'll be able to do that
without effectively re-implementing strnlen(), there's a reason I used
it in the first place, after all.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SnV5plBeK2Ge1I9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnvatgACgkQbDjKyiDZ
s5KwLhAAmey8dTn74tEtPlMGB1lHJ9dliNd7Af2sXcDVOsj7A/TEc28vrgN1mjI0
52V9DmDkIjI0oMFW8nh6WNNUFJnHZ4JbZ8EMhp2/kHY6UPwCdKboAfEGK/xX99zj
qejrhAlg+urvleqgdtZ11Tvgl+nDZL0VCxcpbWJiDAKUQ3H8BdEa6TTfoZmZn8BH
fP/rekdJRBAKmGdrJfIrZWv+KUCKNuVb5x6dA8VN5/dl+I2BVB41V1O3LOCZ7wHG
ahSDHNu0r9LtCtddTBuFZH9gKGkvtT9c6O+y0CYD92Gzs1fg0VXqhFAJGOJWUup5
uYhMFVeCMHqyOzPmqa3dG04TfParBZUWar1BiUtXYxNujp89ce/hn4zH4RiiM9OR
ltmSwaQFMS9CFnQvDCCWWiQ0WXK1zRFCeg6h/SsaKPnJSNkLBjJ16IYLrjjlF3e3
/QQhUhaum/1gTrAynzH0se/chsiJULYwjtCDCsovsKs1MfbNEDmYSLuP8KrcBtN4
146uC+uNjHPQqol4nGLyMIGKH3ZfUD/FAcGrG9RY4DvsTJJongKGXPf0HOieoorg
EReANXffTTRxSiNfkufp1+jACzWgoocD9Lto1YdVXarcA9MaOYODog5ZePRYpfSC
uUAoW7UZbfTupASJxBVootIwBSnTGiNItwVsUnlLScjEjKh6O3Q=
=hESA
-----END PGP SIGNATURE-----

--SnV5plBeK2Ge1I9g--
