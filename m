Received: from eggs.gnu.org ([2001:4830:134:3::10]:54860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dg5fz-0000xs-01
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 04:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dg5fw-0002yi-EI
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 04:52:15 -0400
Date: Fri, 11 Aug 2017 18:51:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170811085157.GY13670@umbus.fritz.box>
References: <20170809070357.28723-1-david@gibson.dropbear.id.au>
	<CAFEAcA_n88x0w1cVirQ61h+NOrvX1V7bXD1LCASVGyUZU=qDgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="utG8zEvBNE7w4yrA"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_n88x0w1cVirQ61h+NOrvX1V7bXD1LCASVGyUZU=qDgg@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>


--utG8zEvBNE7w4yrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 01:47:03PM +0100, Peter Maydell wrote:
> On 9 August 2017 at 08:03, David Gibson <david@gibson.dropbear.id.au> wro=
te:
> > The following changes since commit 54affb3a3623b1d36c95e34faa722a583132=
3a74:
> >
> >   Update version for v2.10.0-rc2 release (2017-08-08 19:07:46 +0100)
> >
> > are available in the git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170809
> >
> > for you to fetch changes up to f57467e3b326c7736f8e481fd6b680f30e575c87:
> >
> >   spapr: Fix bug in h_signal_sys_reset() (2017-08-09 14:04:28 +1000)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2017-08-09
> >
> > This series contains a number of bugfixes for ppc and related
> > machines, for the qemu-2.10.release.  Some are true regressions,
> > others are serious enough and non-invasive enough to fix that it's
> > worth putting in 2.10 this late.
> >
> > ----------------------------------------------------------------
>=20
> Applied, thanks.
>=20
> > I haven't completed a Travis build for this, which is part of my usual
> > test regime, since the first dozen or so Travis builds are failing
> > more often than not on master as well.  I don't know why this is -
> > seems to be failing some of the x86 tests.
>=20
> Doesn't look much worse than usual to me -- of the last 24 travis
> builds for master 4 failed and 20 passed.

Uh.. that's not been my experience.  I was a bit unclear in my
description, though.  Until maybe a week and a half ago I found the
Travis build was fairly reliable, though there were occasional
transien failures.  Now, essentially every Travis build is failing for
me.  Specifically most of the first dozen or so of the batch of build
configurations on Travis fail (that's "X" not "!").  These seem to be
transient failures in the sense that if I rebuild enough times they'll
eventually pass, but unlike earlier when the builds would suceed most
of the time, they now seem to succeed at best around 1/3 of the time
(that's ~1/3 of the time for each configuration sub-build, so with a
dozen or so apparently affected that means a complete passing build
essentially never).

See for example https://travis-ci.org/dgibson/qemu/builds/263312174
where 5 subbuilds have failed (which is relatively few).  In each case
the failing error seems to be something like:

ERROR:tests/vhost-user-test.c:807:test_connect_fail: child process (/i386/v=
host-user/connect-fail/subprocess [55883]) failed unexpectedly

Seems to be i386 in some cases and x86_64 in others.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--utG8zEvBNE7w4yrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmNcCsACgkQbDjKyiDZ
s5IsbhAA2aEht62YsOtg/KaF5ootLTJzKmh9SeK6p8XWoOG+AuG1DYmesJ/FLwA+
KMmy6+97sgjMSI3BzIOKDJATByewjiyqodMkCiaMnCm8udaT/OsPMkpNteI6nHuQ
UbAaT2Xb7yXdPOl9KBwQ+a3TBNZY0FxMeD5X3iz6rPffndUTzIiBJ8DkGErebiRF
VOASR7xsdflGrfQwJInvshWy2qNA+HRPFjddqFyAPbYV9UfkEn6GJyL4ErG1bVv7
F8vIffgvWCBrZAuzE6ym3VNPxipFBtx+aSVIORDR/Lop5clZXtqCH2xatgiGg/jc
RAoxfJXhMBvtYsUelLWJSqbhm9wNW9T6QOe4g1OkEECv60+lIa6alMdCPHOGjqoA
R2Tul731ply1OYJ3ruxNpu5653/qiyg2EPsYNL8/oasCDWtvEVBcDC7jXCbPY7Y1
RFfLI234d1ZP5z8m7hwE/ECeZpaXH/c8YylpR4SRJ1bullKFUj9Ajq0BncIzlM7c
ysVvXbtpvqPvb91Di9UWgAYsx6YwKWka9wwQ2tuz386Nc0fgdVnJlatO/FCKDPGs
k2XZhFj0LrYoHFsIcQT+s7WKl08UifK/pU+TPGhfBZY7YrOzq1svIj+KJv0xMle3
kjxNQZXW/P4Gmec3qIuQC9xir8f0BypcIjtN0tizVQVKPT0faQE=
=eKxM
-----END PGP SIGNATURE-----

--utG8zEvBNE7w4yrA--
