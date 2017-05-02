Received: from eggs.gnu.org ([2001:4830:134:3::10]:41221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5YUd-0008JL-UE
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5YUZ-0007Rw-UZ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:09:31 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d5YUZ-0007R5-MS
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:09:27 -0400
Received: by mail-wr0-x22e.google.com with SMTP id l50so81548538wrc.3
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 07:09:27 -0700 (PDT)
Date: Tue, 2 May 2017 15:09:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170502140923.GF22502@stefanha-x1.localdomain>
References: <20170428122444.23361-1-berrange@redhat.com>
	<a3f22a00-1f2e-6d22-f2a2-edc233cd6c64@twiddle.net>
	<8737cq4drt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
Content-Disposition: inline
In-Reply-To: <8737cq4drt.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] (RFC) remove the GThread coroutine
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 30, 2017 at 07:20:54AM +0100, Alex Benn=E9e wrote:
>=20
> Richard Henderson <rth@twiddle.net> writes:
>=20
> > On 04/28/2017 02:24 PM, Daniel P. Berrange wrote:
> >> At the 2016 summit it was suggested that we delete the GThread
> >> coroutine impl since it is not fully functional, and you can
> >> debug the ucontext impl with our GDB helper script.
> >>
> >> I don't recall the subject being raised again since the summit
> >> so here's a proposal to delete the GThread impl, as a way to
> >> trigger input from anyone who thinks we need to keep it......
> >
> > The last time this was mentioned, the reason that we were keeping it
> > was to make clang's thread-sanitizer module happy.  Whether we can
> > still find relevant bugs with that, I don't know.
>=20
> It's been a while since I last did a ThreadSanitizer run. The correct
> fix is teaching the sanitizer about set context so we can use our normal
> build - however this has been at the bottom of a pile for such a long
> time.

Any objections to merging this patch?

Stefan

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCJMTAAoJEJykq7OBq3PIGREH/iG5dyLJV/jAxbnMemTuWGaL
nBA+AIH7ngHc9fPVDl41iY2Le/9FmDdow8uP9gheoVxTvgOzwR4POc7N8orL/9Jo
J+PbYdd+x06AMeyd8gH2xUC+WzyC1lqNx6idI7bbepd4UlNis1kciIfGfNrC1i1w
Qetb3Qo4aCJSTgD/SwmzNdxMNbR2t+Zueab811XQdM4uBnJRbPYJwj/d9nCeyZPX
C10f2UarhoMItd0iUF5/5BUqkd50Ha3Xd0MTpF6PpG/Qm7YEnd6cDziHkjTJ/b8X
QWNYtvgULz5nCzMsHqKoRQDsmKNxAkXA2ry0hn6Pe4iseOP7SeH6kQ6yF1jrxlg=
=kIDM
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--
