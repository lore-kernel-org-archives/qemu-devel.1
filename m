Received: from eggs.gnu.org ([2001:4830:134:3::10]:33059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d92xA-0000wY-2l
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d92x6-0000LZ-2y
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:17:24 -0400
Date: Fri, 12 May 2017 15:13:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170512051313.GB12908@umbus.fritz.box>
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-8-f4bug@amsat.org>
	<20170511004159.GD14408@umbus.fritz.box>
	<5386fd20-8d13-408a-5b12-ba9468541e50@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <5386fd20-8d13-408a-5b12-ba9468541e50@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 7/8] target/ppc: optimize
 various functions using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 10:46:01AM +0200, Laurent Vivier wrote:
> On 11/05/2017 02:41, David Gibson wrote:
> > On Wed, May 10, 2017 at 05:05:34PM -0300, Philippe Mathieu-Daud=E9 wrot=
e:
> >> Applied using Coccinelle script.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >=20
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> David, look at Nikunj's comments: only the two first changes are correct.
>=20
> 'andi" uses a mask, but extract uses a 'width'. Philippe's changes work
> only when mask =3D 1.

Oops, that was sloppy of me, sorry.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZFURnAAoJEGw4ysog2bOS1PAQAJhASDtm7IOIwvnhb2RV8/ZV
3me/nVeBM2lURu/345+PUTrph84HVNNeu6A2MHjqyL8nTx0lAb0+D/WUlru21hHD
es0nCxACUnKYbYp9PMCgKLpQi1DfbMl2KCsphVJJadjD2dYWoGAuTd9GdKg9EQB8
TY1yA6TZs6pHLY1hLwfE7vECzHC6YReINaOdAY1A04Jow+VAYsEXzKTYgAjvGlJt
Cnk/+7h+RgUGxVYaJWerQGYls/e8KxlwIlm1/Yy5kvpjRSkStfk33Pn7CJatZ7ey
AGH9wQ+zou//QSl0lrDBShWrjMJsLm83g6s6JzQPEqsosEfoAbrUVt9890NfD5C3
Knv+XRA4SI/GG60yowldkEf+xAY5kjg8vMuVlMBIFlJeEvtdkNxL2j3HIQ1vH0T8
p1ghNm8mrUSry6pAWu5WIQbpqWOaKlLCxF5z3RSIhbM1nsEyNCcoPB0G4ywzKkSp
XX38Ht8BopXwah1rw2y3XbgjSB48hcMcnSKY3IiWmI1P6SqhniNJWwJzva2jiNUV
bwIfjYINZR83mOiELkdU1GJvBS+7McEpym4CEl6/bXKIhkEFblXCK0KjmQhwQfP5
Hw0VjJA6GtWfYeUjulM+lDHwujODxiq9P0/74ObRE7iGum5+jRe46p4K//8lqEmh
F9VIsm6ai0T5dvqBnGdj
=9Yhr
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
