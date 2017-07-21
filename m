Received: from eggs.gnu.org ([2001:4830:134:3::10]:56304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYXHZ-0007g5-Q2
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYXHW-0003Km-NC
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:43:49 -0400
Date: Fri, 21 Jul 2017 13:43:43 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170721124343.GD18014@stefanha-x1.localdomain>
References: <CAOE=1Z0yXiscZWibFpUjaqZj7vK06nrWcnaWvga4B2Kw+Eta+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
Content-Disposition: inline
In-Reply-To: <CAOE=1Z0yXiscZWibFpUjaqZj7vK06nrWcnaWvga4B2Kw+Eta+g@mail.gmail.com>
Subject: Re: [Qemu-devel] Why "trace event does not exist"?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam <batmanustc@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-discuss@nongnu.org


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2017 at 10:38:07AM +0800, Sam wrote:
> Hi all,
>=20
> I want to add new trace-event and log it, so I add into $QEMU/trace-event
> like this:
>=20
> io_mem_init(void) ""
> >
>=20
> and after configure, $QEMU/build/trace-events-all also have this.
> then I add code like this into $QEMU/exec.c
>=20
> trace_io_mem_init();
> >
>=20
> then I `make` and `make install`.
>=20
> But when I run `qemu-system-x86_64 -D /qemu.log -trace events=3D/qemu-eve=
nts
> ...`
> it warn me that:
>=20
> qemu-system-x86_64:/qemu-events:1: WARNING: trace event 'io_mem_init' does
> > not exist
>=20
>=20
> and no io_mem_init log output. Why and what should I do to add this log?

Are you sure you're running the binary you compiled?  Please check that
"which qemu-system-x86_64" is really the QEMU binary you built and
installed.

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZcfb/AAoJEJykq7OBq3PIL2kIAK+6wvTVpqNSt9Uq3wxSzVt+
m3Hku8g8h2bOgKUHLvcBFxh61+oYMjMdEW8rB90EfLxEbqR2Uh4tPvUbMcOu49Rf
aUd70VtYkIuKb1H9g35/GkRmQSF9MyushoyW6qhkmuZHDJDPsmBQKspHg6qmxNF3
36hEFGmhgEv+uSCRm8oU1fFFJ8SYAB6FllxRiya+pmRE65O+fcKUdxpPdX2pPa89
c71WdknfRN5LiOP7l3Ab3fw9QQU50T4hXbjKULXJBd15d05Hzo7/tDyA1hyfnhKz
EZIAAK4FWWlsa+BxMXovkndzpgFGlsPppTTHl6qbqJdot7ix15RpCNbJ98B44wA=
=WfwL
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--
