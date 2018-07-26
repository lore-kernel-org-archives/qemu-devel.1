Received: from eggs.gnu.org ([2001:4830:134:3::10]:60450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fif0O-00031z-RB
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 08:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fif0L-0008T1-Qo
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 08:04:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58552 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fif0L-0008Io-CX
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 08:04:25 -0400
Date: Thu, 26 Jul 2018 14:04:08 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20180726120408.GA6511@vader>
References: <20180725141610.12075-1-otubo@redhat.com>
	<CAFEAcA-K-BAsMdn=0g3HCZEVfveLOjsmRutTgqOY96b_yvOs3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-K-BAsMdn=0g3HCZEVfveLOjsmRutTgqOY96b_yvOs3Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/2] seccomp branch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26/07/2018 - 11:47:46, Peter Maydell wrote:
> On 25 July 2018 at 15:16, Eduardo Otubo <otubo@redhat.com> wrote:
> > The following changes since commit 18a398f6a39df4b08ff86ac0d38384193ca5=
f4cc:
> >
> >   Update version for v3.0.0-rc2 release (2018-07-24 22:06:31 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/otubo/qemu.git tags/pull-seccomp-20180725
> >
> > for you to fetch changes up to 5b2f59307372bae13a2ff95706646674eccb65e0:
> >
> >   RFC: seccomp: prefer SCMP_ACT_KILL_PROCESS if available (2018-07-25 1=
6:07:31 +0200)
> >
> > ----------------------------------------------------------------
> > pull-seccomp-20180725
> >
> > ----------------------------------------------------------------
> > Marc-Andr=C3=A9 Lureau (2):
> >       seccomp: use SIGSYS signal instead of killing the thread
> >       RFC: seccomp: prefer SCMP_ACT_KILL_PROCESS if available
>=20
> Hi. This fails to compile with clang:
>=20
>   CC      qemu-seccomp.o
> qemu-seccomp.c:112:1: error: unused function 'qemu_seccomp'
> [-Werror,-Wunused-function]
> qemu_seccomp(unsigned int operation, unsigned int flags, void *args)
> ^
>=20
> This is because clang is stricter about warning about static inline
> functions defined in .c files but never used and your ifdef
> guard on the callsite is not matched by one around the function
> definition.
>=20

Peter, sorry for not catching that before.
Marc, can you fix and resend?

--=20
Eduardo Otubo

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbWbi4AAoJEN8y58Dw//miZeEIAMqdGNJv+Bj16OWnRCduRpil
7zHUT3TYi2pBzJMiJa9+f6jcE4E+cfC03BfWsA9ybDCi4EFVo8LtQpn10NZ+Ghla
Avm2lyDc/Z0QGSXfBq1MfN2bNXaYHbuuh/+2olCB86P3i9nYEliRxMN00ocJOB81
n+rz4mBs5WHZ/ggi+tZg2HsLe1EDia/cRWW56FeoHvHyJa9Mzg9FN+n8KdjGKwEZ
kRoFdbKR4YHscWEGgrvh96o+BFfNdbfp6YbxGiVKEm59H4A5TqBz6AHfHcZAZgHu
/IdDn+WE0MdWUuORMoqXBpBHN2FMTrlVd+mJqFdRDOsg1Licd7D1gZXhuA8A2GE=
=BjoS
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
