Received: from eggs.gnu.org ([2001:4830:134:3::10]:51935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e6BHs-000615-86
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 04:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e6BHo-0002V3-0S
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 04:07:12 -0400
Date: Sun, 22 Oct 2017 16:33:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171022053315.GA15297@umbus>
References: <20171020175548.2566-1-programmingkidx@gmail.com>
	<f9bd98f1-d45c-6d3a-c35c-c67da67c881f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <f9bd98f1-d45c-6d3a-c35c-c67da67c881f@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: John Arbuckle <programmingkidx@gmail.com>, devicetree-compiler@vger.kernel.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2017 at 04:44:58PM -0700, Richard Henderson wrote:
> On 10/20/2017 10:55 AM, John Arbuckle wrote:
> > +static inline size_t strnlen(const char *string, size_t max_count)
> > +{
> > +    size_t count;
> > +    for (count =3D 0; count < max_count; count++) {
> > +        if (string[count] =3D=3D '\0') {
> > +            break;
> > +        }
> > +    }
> > +    return count;
>=20
> Not to nitpick, but
>=20
>   const char *p =3D memchr(string, 0, max_count);
>   return p ? max_count : p - string;

Richard's right, that's definitely a better implementation.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnsLZYACgkQbDjKyiDZ
s5K9kBAAop+caHzn2iij3iA9mNQV52uY2KdWbKW1+s9SL874WYAQFasuB0lkoAwI
yLvnYg+XMoFIjC8G+++Q7kJhbt3a01XdbDH/+/ZfVBHGe52HshLjd1VTISGwp7Cf
wVolYbIFW83EIwU1OTXZynmfbFC8Rrb1lsgrHah93GHCLnFnk4814BaPdd0rVnee
sjOMykWnHGfcgVi8TuoAfoBKl771AOWo4sbq8j+bqWSz8/sThTIceTbSFux6NNTD
ImzHLKiYqBAVKrH+4Ix6USrEn6Ka/bmatVGcAKOtJ/qMBelLvK7kFLg2YIJfSUNI
mfsh+ii398lHuethEtnERyeiVE6suXnPYTUgS9u97Xe67VeuE2B0IHscWcNMuist
f1wpBmVduLVyC4r28d+zxlaiUg82l62hJ8etZ/3yCDZF8EFYQTvym8sgiq8RgoPb
rYj4qVtP34OqRgPWO0oGV6WKGFY2kGthgnse532FGJj5dxMGRcFGEdmE2BPuC9zQ
rKJVZQCuU4fHajj8lm03zyh2mEPplYgd7sTmJM2ZKM7Z5Y8LuqKcrUkW4RSKSrD2
rM6epXgtnOTsiYuGUFSbNkCsz3/DV7SCBJktyMG7OpHpaL4kX8H33LpGriLY36lM
K57u1rzy1OH1rYXtU9wp/IpXm6l/uU8Bll11nKP3kHLSLJv9KUk=
=CIw8
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
