Received: from eggs.gnu.org ([2001:4830:134:3::10]:59050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fasLw-0000aG-F9
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 20:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fasLt-0008VB-BG
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 20:42:32 -0400
Date: Thu, 5 Jul 2018 10:09:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180705000951.GA3450@umbus.fritz.box>
References: <20180703151732.29843-1-richard.henderson@linaro.org>
	<20180704033134.GE14043@umbus.fritz.box>
	<5DE66F68-07F2-4494-9CC7-51632A386542@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <5DE66F68-07F2-4494-9CC7-51632A386542@gmail.com>
Subject: Re: [Qemu-devel] [PATCH for-3.1 0/7] target/ppc fp cleanups
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


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2018 at 09:42:16AM -0400, Programmingkid wrote:
>=20
> > On Jul 3, 2018, at 11:31 PM, David Gibson <david@gibson.dropbear.id.au>=
 wrote:
> >=20
> > On Tue, Jul 03, 2018 at 08:17:25AM -0700, Richard Henderson wrote:
> >> Beginning with John Arbuckle's fdiv test case, clean up some
> >> of the fp helpers.  As with fdiv, fre and fresqrt are missing
> >> divide-by-zero exceptions.
> >>=20
> >> I've also noticed that load/store were using arithmetic conversions
> >> to/from float32.  These should be using the non-arithmetic algorithms
> >> listed in the manual.
> >>=20
> >> Aside from cleaning up all of the rest of the helpers, I believe that
> >> the implementation of the single-precision operations are incorrect.
> >> They are currently implemented with the double-precision operation
> >> followed by a round-to-single.  This causes incorrect results via
> >> double rounding.  I believe better results could be had by using
> >> these non-arithmetic converters to produce float32 operands, use the
> >> proper float32 softfloat operations, and then convert back.
> >>=20
> >> Anyway, all of this has been broken long enough that it'll need to
> >> wait til next devel cycle before anything further gets done.
> >=20
> > Applied to ppc-for-3.1 (newly created)
>=20
> Could I have the address for your ppc-for-3.1 repo please? Would you
> like future floating point patches to be based on this repo?

See https://github.com/dgibson/qemu/tree/ppc-for-3.1

Same repo as my existing ppc-for-3.0 tree, different branch.

And yes, patches should be based on this tree, unless they're
important bugfixes that are aimed at 3.0.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls9Yc0ACgkQbDjKyiDZ
s5I45g/9FasxME9Ak2w7JYpn7YJPbo4ks3XkIbITQV/2pDJhrQuJRBb7gStV1gil
U30vOqZ4hpKQnOguVvnmi9URqwDLEatVTBQ1CBZ0csT/EfMyH/T+Fh1PrLhLGv3b
x3cBdNCmjOVBmqUj85oAEItfOttG6RVVrh+mpXydLL3dNNCjtIYHRktn9Edrd2J/
PL3mIhkVkYJdt/xwYUqC8sERu8hwGbDekBGTDdX7jq7+m/DWE6lJ9jSr4505INGm
fD8BlzsmVEMz/zJ8HOJ8gilnMBUDtauvsesdXw2oXLasZnkEUmhCJ6DGUHb47tt+
J+1KKvCzJi5lbWBRsAjkw978pin+OnuEofkYbhJzSaVUGHtGf5XprMYjfzicV9rr
uobBOf3CU8xdLe2a4Ibv9uK93cdBIamOPlgWQqn+HDkBPKJpmQaL2/7G0mOqafhS
VIdfV4mRj9FsIczPICSncxoJajWitAsEurCKPDrW8KpgeeEaDkC9y8wZ9Z5APzSl
c+pB0ru02La4DtG/yKmk+8i5Qe5IkzN//fl4SRHwuSuRxYp5sK7FsYCIbYxK8BfW
ea+FDWObAA+laAhK0vYU7+J59ERNZEBR/a23TdJbzIpQY9JK+pNOsKdwlLOUBHX6
fFIVDkvWiqnt2uK1Htj7/2bk4zqO/D9R0aIaJ2Pwpn+OWZe4tWk=
=6ag6
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
