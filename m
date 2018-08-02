Received: from eggs.gnu.org ([2001:4830:134:3::10]:51881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fl7iu-0006Xs-I9
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 03:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fl7it-0005Rd-Cx
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 03:08:36 -0400
Date: Thu, 2 Aug 2018 17:08:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180802070824.GC11211@umbus.fritz.box>
References: <20180801035357.7804-1-david@gibson.dropbear.id.au>
	<CAFEAcA-FitsqU3kQJTFGSFgOh6Zsf2Zy2fO3OTnL5c+Tzi5pog@mail.gmail.com>
	<alpine.BSF.2.21.1808011300070.7488@zero.eik.bme.hu>
	<CAFEAcA-=c7O+h3c-gQ=31q0oyLzJhDNmEBzv4X2Yp_TBfYhC-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-=c7O+h3c-gQ=31q0oyLzJhDNmEBzv4X2Yp_TBfYhC-w@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 0/2] ppc-for-3.0 queue 20180801
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 02:04:04PM +0100, Peter Maydell wrote:
> On 1 August 2018 at 12:24, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > On Wed, 1 Aug 2018, Peter Maydell wrote:
> >> So, we've just put out rc3, which in an ideal world is our
> >> final release candidate for 3.0. Are these bugs regressions from
> >> 2.12 ?
> >
> >
> > I don't know about the macio one but the sam460ex PCI interrupts were b=
roken
> > in 2.12 too. However it's a fix for a device only used in sam460ex whic=
h is
> > now fixed by this patch so including it is not high risk for breaking
> > anything else than sam460ex which is known to be not finished yet so I =
would
> > not worry too much. But which is better? Releasing 3.0 with a known bug=
 or
> > including this fix without an rc4?
>=20
> The problem with continuing to delay 3.0 while we have known bugs
> is that bugs generally come in at an even rate, so we *always*
> have known bugs, and so "we found another bug, let's delay 3.0
> again to put in a fix for it" is a recipe for never doing a release.
> That's why we gradually wind up the bar for "should this go in",
> from "any bug" to "regressions" to "really really serious showstopper
> regressions".
>=20
> We never do a final release without a last rc (it is too risky),
> so that is not an option.

Ugh, sorry about this.  I made an off-by-one error in my mental
calculation of whether it would be ok to include non-regression
bugfixes aet this point.  Also, I originally meant to send this before
the last -rc, but stuff happened.

So, the sam460 fix is, indeed, not a regression and I'm happy to punt
it to 3.1.

The macio fix, however, *is* a regression from 2.12.  Whether it's
severe enough to warrant another -rc, I'm not sure.  It is a bad
pointer access which is, well, bad.  It doesn't seem to bite
obviously, needing valgrind to pick it up, but possibly that's just
luck.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltireYACgkQbDjKyiDZ
s5LiHRAAi3AImBIJMJrCILuHcjFrgaPcyUnOSLl98YZti/8Qcb0wyoCZHthXeVVp
WUhdNM1sQviIr1xZPd0NRXIVYc+TWLXOwPpoaBjlSOYoM0EfifNcWZil8qmuR6jo
HrS1YC61y2KyAWr5qWDe08WFNXqm19p+LrdjwUUSTvg9v46Bd2zpsuggvFaaXztk
YoGRotxzfu3ERFtPUFJOViICoK6xP9AYEfaehGKuEdmJVgoyRT3tE3SZEnMHmFpw
o6e0PzRHoaGV8F8ZbfoquK9qrx8wBDJgSBXLLlhIkKyqJYAL1KF+SvbkPslU8IY2
9046tFVyU8ASyZ9YgoVTf9m4HX2YrtsXArkfc5kPFFGH1EvuI+QOzUHmWlZT35l2
HnUtpHBUzoH3KTVBkLH2syX96Og+Qlkv1rxOZna9rA3lntwx4LXTD0sT2BmSIQZe
ZCWM2XuGA9BkP23CjA6vr7DLm572RZwGI1daEd+gfIizwNSoOw3uTg2axntbEU+z
Ij+zwzJtNLZYl5z7gK5KV2p9HCRuoQ7hJhViG+1F0geRIj6n7pw0RmkKHbmxdC1+
hQodKbyBrm8WVFCUUbTjmOW8ONUjbk3Q3Z6OYRYCoJfC8rjTTk3E7uASSvjv8qz6
lWbOdiEtTbKCa+Gxpk8ut7Kp0ScurII7IyDkjoVvji91guXjyHs=
=oYvu
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
