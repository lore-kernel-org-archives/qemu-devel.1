Received: from eggs.gnu.org ([2001:4830:134:3::10]:36978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dhCNx-00019d-WB
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dhCNt-0004Vm-UJ
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:14:13 -0400
Date: Mon, 14 Aug 2017 20:13:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170814101323.GK3452@umbus.fritz.box>
References: <20170809070357.28723-1-david@gibson.dropbear.id.au>
	<CAFEAcA_n88x0w1cVirQ61h+NOrvX1V7bXD1LCASVGyUZU=qDgg@mail.gmail.com>
	<20170811085157.GY13670@umbus.fritz.box>
	<CAFEAcA91j7zA2ptiLrcYL+cVF41_SJ2p0hL8Z=ejBiaqjfA--Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="huBJOJF9BsF479P6"
Content-Disposition: inline
In-Reply-To: <CAFEAcA91j7zA2ptiLrcYL+cVF41_SJ2p0hL8Z=ejBiaqjfA--Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/6] ppc patch queue 2017-08-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "Michael S. Tsirkin" <mst@redhat.com>


--huBJOJF9BsF479P6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2017 at 09:59:00AM +0100, Peter Maydell wrote:
> On 11 August 2017 at 09:51, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
> > On Thu, Aug 10, 2017 at 01:47:03PM +0100, Peter Maydell wrote:
> >> On 9 August 2017 at 08:03, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >> > I haven't completed a Travis build for this, which is part of my usu=
al
> >> > test regime, since the first dozen or so Travis builds are failing
> >> > more often than not on master as well.  I don't know why this is -
> >> > seems to be failing some of the x86 tests.
> >>
> >> Doesn't look much worse than usual to me -- of the last 24 travis
> >> builds for master 4 failed and 20 passed.
> >
> > Uh.. that's not been my experience.  I was a bit unclear in my
> > description, though.  Until maybe a week and a half ago I found the
> > Travis build was fairly reliable, though there were occasional
> > transien failures.  Now, essentially every Travis build is failing for
> > me.  Specifically most of the first dozen or so of the batch of build
> > configurations on Travis fail (that's "X" not "!").  These seem to be
> > transient failures in the sense that if I rebuild enough times they'll
> > eventually pass, but unlike earlier when the builds would suceed most
> > of the time, they now seem to succeed at best around 1/3 of the time
> > (that's ~1/3 of the time for each configuration sub-build, so with a
> > dozen or so apparently affected that means a complete passing build
> > essentially never).
> >
> > See for example https://travis-ci.org/dgibson/qemu/builds/263312174
> > where 5 subbuilds have failed (which is relatively few).  In each case
> > the failing error seems to be something like:
> >
> > ERROR:tests/vhost-user-test.c:807:test_connect_fail: child process (/i3=
86/vhost-user/connect-fail/subprocess [55883]) failed unexpectedly
> >
> > Seems to be i386 in some cases and x86_64 in others.
>=20
> Weird. https://travis-ci.org/qemu/qemu/builds is the master
> build history and as you can see it's mostly greens.
> Not sure why your setup would be significantly worse:
> maybe one of the travis submaintainers has an idea.
> It could just be our vhost-user-test is flaky but I don't
> know why that should hit you much more than master...

So, Travis is telling me my builds are being done on a trusty
environment (even the sub-builds which don't specify a distro
explicitly).  That doesn't seem to be the case for the master tree
builds.  Then again, the sub-builds which do specifically ask for
trusty seem to be working, so I'm not sure why implicity choosing
trusty would break things.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--huBJOJF9BsF479P6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmRd8AACgkQbDjKyiDZ
s5LGfw//VJub2hL/rswkDEkiKtoMd8qRlRO1Co9F0uTMBJUrK1htxzW9BEZhdpho
aVmf/OBC0UXnUd5FWdLe0FzHV98pLSegGduFpAMV2OgZWuyQyIgN1VlKVDv1srm5
Lv81TyfUZPoN5vYL6CBXKAte9zGpgC8WVfHVIJTUdwnJDc3Y40t2sxaJVECtF5S1
+4IbFkVPT7+9QZvccCcHNq+76ilhMmbE/gU3yVuDe4bDqo6OT9q/ncz1jggSf8lX
lSSmOunfDUP1aslIvQK6TF1Cou6n6bl97U1cLieMpsX3XaC3WkWnZQ68DdiPTwhn
1e5A1gucQ93pnxVMXymOGg2rTZ8Gri07LjKBKYRMw1vZeHosDn1rgLSGIrqmSfPL
6rcI8KE6uTEZuDHV29z91DriGfI9uJeEEFyyR1u/vjml/dFrVHdAZDH4/H9ysSn5
AAAo4oMI9vwK46MVQYVvdlVEVamtURulZpW+1ReGL/ZHIDaS1Kf+hJR7Rxn9Oyin
XCDHwkha0F0SLG0f51zbHSTU8lUxwxvocj4viQ9DiV3ateEB7qirBM2tAGRWetzb
m9O5Hj7R53d1U97Vin0IIaSdjVk5KDgz7rSNCTelXNZAI3ikpPQX1rkTwqcXz+cG
BIx9pVMFf2SLK62YM9d6WErnCD3Pc86RXXZP/DQkHN+xYHlK/LE=
=vYRp
-----END PGP SIGNATURE-----

--huBJOJF9BsF479P6--
