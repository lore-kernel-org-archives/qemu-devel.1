Received: from eggs.gnu.org ([209.51.188.92]:49329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gjQFh-0004W2-F1
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gjQFg-0001LY-GF
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:03:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gjQFg-0001Jr-8k
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:03:40 -0500
Date: Tue, 15 Jan 2019 16:03:31 +0100
From: Christophe Fergeau <cfergeau@redhat.com>
Message-ID: <20190115150331.GK8828@natto.ory.fergeau.eu>
References: <20181214105642.673-1-cfergeau@redhat.com>
	<20190103105425.GF7733@stefanha-x1.localdomain>
	<20190103141455.GP20900@natto.ory.fergeau.eu>
	<20190104154034.GK30381@stefanha-x1.localdomain>
	<20190114115420.GR23773@natto.ory.fergeau.eu>
	<20190115140912.GA29056@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6Mt39TZj+HFMr11E"
Content-Disposition: inline
In-Reply-To: <20190115140912.GA29056@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v4] log: Make glib logging go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org


--6Mt39TZj+HFMr11E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 02:09:12PM +0000, Stefan Hajnoczi wrote:
> > In these codepaths, I'm confident up to
> > void monitor_vfprintf(FILE *stream, const char *fmt, va_list ap)
> > {
> >     if (cur_mon && !monitor_cur_is_qmp()) {
> >         monitor_vprintf(cur_mon, fmt, ap);
> >     } else {
> >         vfprintf(stream, fmt, ap);
> >     }
> > }
> >=20
> > From there, it was not obvious to me whether the monitor_vprintf
> > codepath can be triggered from info/warn/error_report or not. If they
> > can, I'd feel less confident that monitor_vprintf will never indirectly
> > call glib log functions.
>=20
> I think we're okay because otherwise monitor_vprintf() ->
> info/warn/error_report() would already be an infinite loop today.

Ah good point :)

Christophe

--6Mt39TZj+HFMr11E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElKn3VmH3emFoZJsjqdjCFCmsbIIFAlw99kMACgkQqdjCFCms
bIIAtg//Vyf0fcQxtDOOc2DmuzXQBhkoBXVVG61rdqT4QCRgEtzRkVY7WJwER7x+
gk7U3MUF+URnHjGFnNyfGcUILD6c++vbz6QRBEvBPoUyoSUBvJaMBNcgrv+zVVMv
USZhra9Lq8KZjFDJnODAvSQS7cqHbzBV2ePYsZr3zkeozQOaRLAUYRdAXK/ZB3OK
8ZJUj6iYTtV/m+3+hsGlwrIMzfWiDh5JINooouhbMtFLyGU1D/EUxidrYHW5rTHy
yOU9H2u0kOQtanRh2zDdSywAWpQugrxtdFXeON1WEZir1hZynQdwCvcrEHRYkVD2
8OR0NPxDZXA9QfohZfoLknzU/QH5Blm2CEIBmucxltVBl338L/Q4zUY4Q5E6t7kS
nCFd73Q6j2BHJRsK0o6VFr5RFNL6wsTpvNlsH+TnvsrCjclF3G6d+ERFJ2tr/W5u
szlgXiDy9IZpLaQUz9of9TeQfELKZmJtgukhbKLl20JRiYTFClAZiN1lZgJp9FZo
7YPMq3IFLGldwnx/zpNGa6DvSkryYmN1qs8k7kRLLNvh7p1hKysVUKOF+qmKCTUq
KweKJuopL6fAXh+225FOwjSzvCdYuYjsIBDsYOG9oiAR0z6XvKNjb8/L2oxA051M
s8fh0LyqLzK1UNx6idZjY77vvseLraFtNEzrVigwZJAnvpI2YGc=
=jCng
-----END PGP SIGNATURE-----

--6Mt39TZj+HFMr11E--
