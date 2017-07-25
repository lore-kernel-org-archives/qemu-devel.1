Received: from eggs.gnu.org ([2001:4830:134:3::10]:48189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da1dv-0000j8-Ko
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da1ds-0002PZ-F1
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:21:03 -0400
Date: Tue, 25 Jul 2017 16:20:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725152052.GP23343@stefanha-x1.localdomain>
References: <20170721093416.17816-1-stefanha@redhat.com>
	<CAFEAcA_+ffmyvExhFvm2JTmoipum6GeWiFPP5kuxRKb9+ezRzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MM5RgFPKyuP3gDcV"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_+ffmyvExhFvm2JTmoipum6GeWiFPP5kuxRKb9+ezRzA@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-iotests: add a "how to"
 to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>


--MM5RgFPKyuP3gDcV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 11:20:44AM +0100, Peter Maydell wrote:
> On 21 July 2017 at 10:34, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > There is not much getting started documentation for qemu-iotests.  This
> > patch explains how to create a new test and covers the overall testing
> > approach.
> >
> > Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tests/qemu-iotests/README | 83 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 83 insertions(+)
> >
> > diff --git a/tests/qemu-iotests/README b/tests/qemu-iotests/README
> > index 6079b40..8259b9f 100644
> > --- a/tests/qemu-iotests/README
> > +++ b/tests/qemu-iotests/README
> > @@ -14,8 +14,91 @@ Just run ./check to run all tests for the raw image =
format, or ./check
> >  -qcow2 to test the qcow2 image format.  The output of ./check -h expla=
ins
> >  additional options to test further image formats or I/O methods.
> >
> > +* Testing approach
> > +
> > +Each test is an executable file (usually a bash script) that is run by=
 the
> > +./check test harness.  Standard out and standard error are captured to=
 an
> > +output file.  If the output file differs from the "golden master" outp=
ut file
> > +for the test then it fails.
>=20
> Should ./check be run from the source tree, or the build tree? The
> existing README text doesn't say and I don't think your additions
> do either.

It doesn't matter, both should work.  The script detects both
possibilities and rejigs itself to compensate.

Stefan

--MM5RgFPKyuP3gDcV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd2HUAAoJEJykq7OBq3PIDuoH/iM+SiznaARUC46BF5HJBmb1
MDEfjKpj3TyuAQA1rSD7neF5702FslddJflkOavZqXJnZOkeM3/GoEEuvpPI9X70
EsZTJkb2FH6MOaadgCUOVKKf2FruRe3NsJLJ7nzL3XKp/EpFsBEPYl6IFNwBHidB
V75eZmvO6ILj2IR4PoWC++DQ5FDKRVTqZ33wydSqaMYxlVC3vQKv7Kt16FMjYj48
0ODyoN55DgQ9t7iTn+Wwme1iO62NMoA1hb/vNwDqn3Tc/1RtsiVAqxI6Wy+nxD+U
GEDtViHeSdt8dvs0Dtt1wjlXi+bI5ifGVExEhwSU9nTWlFt5+bHuiXr8PcNqeZE=
=p+do
-----END PGP SIGNATURE-----

--MM5RgFPKyuP3gDcV--
