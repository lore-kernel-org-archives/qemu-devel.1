Received: from eggs.gnu.org ([2001:4830:134:3::10]:53391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dhaFA-0002hE-8E
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dhaF9-00065Y-4c
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:42:44 -0400
Date: Tue, 15 Aug 2017 21:41:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170815114116.GT3452@umbus.fritz.box>
References: <20170809070357.28723-1-david@gibson.dropbear.id.au>
	<CAFEAcA_n88x0w1cVirQ61h+NOrvX1V7bXD1LCASVGyUZU=qDgg@mail.gmail.com>
	<20170811085157.GY13670@umbus.fritz.box>
	<CAFEAcA91j7zA2ptiLrcYL+cVF41_SJ2p0hL8Z=ejBiaqjfA--Q@mail.gmail.com>
	<20170814172001-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VjP/dwTbBl6I9PQk"
Content-Disposition: inline
In-Reply-To: <20170814172001-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PULL 0/6] ppc patch queue 2017-08-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--VjP/dwTbBl6I9PQk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 05:20:21PM +0300, Michael S. Tsirkin wrote:
> On Fri, Aug 11, 2017 at 09:59:00AM +0100, Peter Maydell wrote:
> > On 11 August 2017 at 09:51, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> > > On Thu, Aug 10, 2017 at 01:47:03PM +0100, Peter Maydell wrote:
> > >> On 9 August 2017 at 08:03, David Gibson <david@gibson.dropbear.id.au=
> wrote:
> > >> > I haven't completed a Travis build for this, which is part of my u=
sual
> > >> > test regime, since the first dozen or so Travis builds are failing
> > >> > more often than not on master as well.  I don't know why this is -
> > >> > seems to be failing some of the x86 tests.
> > >>
> > >> Doesn't look much worse than usual to me -- of the last 24 travis
> > >> builds for master 4 failed and 20 passed.
> > >
> > > Uh.. that's not been my experience.  I was a bit unclear in my
> > > description, though.  Until maybe a week and a half ago I found the
> > > Travis build was fairly reliable, though there were occasional
> > > transien failures.  Now, essentially every Travis build is failing for
> > > me.  Specifically most of the first dozen or so of the batch of build
> > > configurations on Travis fail (that's "X" not "!").  These seem to be
> > > transient failures in the sense that if I rebuild enough times they'll
> > > eventually pass, but unlike earlier when the builds would suceed most
> > > of the time, they now seem to succeed at best around 1/3 of the time
> > > (that's ~1/3 of the time for each configuration sub-build, so with a
> > > dozen or so apparently affected that means a complete passing build
> > > essentially never).
> > >
> > > See for example https://travis-ci.org/dgibson/qemu/builds/263312174
> > > where 5 subbuilds have failed (which is relatively few).  In each case
> > > the failing error seems to be something like:
> > >
> > > ERROR:tests/vhost-user-test.c:807:test_connect_fail: child process (/=
i386/vhost-user/connect-fail/subprocess [55883]) failed unexpectedly
> > >
> > > Seems to be i386 in some cases and x86_64 in others.
>=20
> And is it always the connect-fail test?

I think so, though I haven't checked every single failing output to
make sure.

>=20
> > Weird. https://travis-ci.org/qemu/qemu/builds is the master
> > build history and as you can see it's mostly greens.
> > Not sure why your setup would be significantly worse:
> > maybe one of the travis submaintainers has an idea.
> > It could just be our vhost-user-test is flaky but I don't
> > know why that should hit you much more than master...
> >=20
> >=20
> > thanks
> > -- PMM
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VjP/dwTbBl6I9PQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmS3dwACgkQbDjKyiDZ
s5JBghAAzhbanCCwXEs6cgAEzSzPgKwGR6OqQZ77T1Dm4nrLAdndHAGWgcTB4GSh
dbBBeQuttm74We4Ev+z/pzJPiSOlRhNa1J/nlGbwGJs9olUzc36Yn8B4z3CN1T0j
ixr7p9Ag+B5A1ZPVj6DFcvRXahxMXavTX9CFSvpN+dXlfopeVrJay3ce9/VCQUtS
6JP6EXle8lXbu0D6in8fu+mmzpWNS7cxcLNPlmdHfyCEW1D6lWGX5OY0fBWJgm3o
FV8+jTET3QFU5XmGUh0Ov1DNR92V1qPnbSw2Z2ibNCT6zNxDNLvIV+TzMLqIqXo+
GPqECQShX15tX3wZBrWmoD+bGQ21bCyrkaqNaMs7GBGpUC70VUh09Ew7JKJRSYEf
lH4UzL/riOYKBHE0q1HE/LbqhXnGe9tSaY/kgCfADyLt73lbuMMsfQkadRaJKtkG
Wf5hf8fw0QOBhipglySmd06s4UaquwaWhcwhf7BlpDYzzdnjD1J6vHoG3awYaxzf
IB+HIt2uH/2rUxrAJdS9ZYp4FiiNJrG0vgl4HSM3/MRJ/mcV632sVV/urfMzXLAI
0/1oEo6oJHNdDecBdfynblDxysYZnZR/AvYNqCMqyP8hRWa9ANRipsbATaJ6VGBL
XoCW+nBCmu+e5JE5EYYrxao8ELuwO7fzxOCjrSEWpiAEeYQmz4E=
=98Km
-----END PGP SIGNATURE-----

--VjP/dwTbBl6I9PQk--
