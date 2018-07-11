Received: from eggs.gnu.org ([2001:4830:134:3::10]:46187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdEjp-0007i6-I0
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdEjm-0003wf-FQ
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:00:57 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:53145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fdEjm-0003wS-6u
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:00:54 -0400
Received: by mail-wm0-x241.google.com with SMTP id w16-v6so2349298wmc.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 06:00:53 -0700 (PDT)
Date: Wed, 11 Jul 2018 14:00:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180711130050.GG31228@stefanha-x1.localdomain>
References: <20180705222115.17013-1-jusual@mail.ru>
	<20180705222115.17013-3-jusual@mail.ru>
	<CAFEAcA8TPN=05ncaSp8k7gAvwF7cmSoykTcG5YdLvByvhgasHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8TPN=05ncaSp8k7gAvwF7cmSoykTcG5YdLvByvhgasHg@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC v3 2/2] tests: Add ARMv6-M reserved register
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Julia Suvorova <jusual@mail.ru>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 06, 2018 at 03:55:14PM +0100, Peter Maydell wrote:
> On 5 July 2018 at 23:21, Julia Suvorova <jusual@mail.ru> wrote:
> > Check that reserved SCS registers return 0 at read,
> > and writes are ignored.
> >
> > Based-on: <20180627143815.1829-1-joel@jms.id.au>
> > Based-on: <20180630091343.14391-1-stefanha@redhat.com>
> >
> > Signed-off-by: Julia Suvorova <jusual@mail.ru>
> > ---
> > Test will work if Joel's patches will use ARMv6-M.
> >
> >  tests/Makefile.include            |  2 ++
> >  tests/tcg/arm/test-reserved-reg.c | 60 +++++++++++++++++++++++++++++++
> >  2 files changed, 62 insertions(+)
> >  create mode 100644 tests/tcg/arm/test-reserved-reg.c
>=20
> Is this in the wrong place? It doesn't look like a
> tests/tcg test -- those directories are for test
> programs which need to be compiled with a cross compiler
> for the guest CPU and then run on it.

Yes, this test should go in tests/ along with the other qtests.

>=20
> I tried running 'make check' and I got this error:
>=20
>   CC      tests/tcg/arm/test-reserved-reg.o
> /home/petmay01/linaro/qemu-from-laptop/qemu/tests/tcg/arm/test-reserved-r=
eg.c:60:1:
> fatal error: opening dependency file
> tests/tcg/arm/test-reserved-reg.d: No such file or directory
>  }
>  ^
>=20
> which is a bit weird.
>=20
> thanks
> -- PMM
>=20

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRf+CAAoJEJykq7OBq3PIXmIH/j9kHcI8SM7xOE3QXm07IxzN
iVU/SxUMiyWUNih0Rp/S6DosY6G3DlJwYV/YEgU6ocNdkkjicJyv3DNTlZxcrXmP
EhT3sjgjnKCEDqI3q99aODDrlEZXmJ8NWmUqBy5YaqqdR/B6IX409FvsJlUhjnvU
Y2746ZqJNEWvf7BpMJG6gOEMuu26p5hNsWUcVE7nohKsHJBEKISrk+/rXCexaP4q
pn4rUMliN0/F+uNK75E+yaw/jzQAdbj7oGGaKPCcYPKnt0eHJPQ8ielxEBZMlhJu
9TjPyFZfkGHLl2JeUBY2CngieC9YfvTmiQU+Wp/Cg58jGNc+kF9ffm2+eoOhpKk=
=NczO
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
