Received: from eggs.gnu.org ([2001:4830:134:3::10]:40024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1elEoJ-0005DL-PM
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:10:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1elEoG-0001SA-Cc
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:10:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55598 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1elEoG-0001Ro-6W
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:10:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB09F9BA98
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 14:10:19 +0000 (UTC)
Date: Mon, 12 Feb 2018 14:10:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180212141018.GG4913@stefanha-x1.localdomain>
References: <20180208171807.24267-1-stefanha@redhat.com>
	<20180208171807.24267-3-stefanha@redhat.com>
	<012d5365-3c70-daff-4037-0253996abf98@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cgrdyab2wu3Akvjd"
Content-Disposition: inline
In-Reply-To: <012d5365-3c70-daff-4037-0253996abf98@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] block: test blk_aio_flush() with
 blk->root == NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>


--Cgrdyab2wu3Akvjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 09:23:53AM -0600, Eric Blake wrote:
> On 02/08/2018 11:18 AM, Stefan Hajnoczi wrote:
> > From: Kevin Wolf <kwolf@redhat.com>
> >=20
> > This patch adds test cases for the scenario where blk_aio_flush() is
> > called on a BlockBackend with no root.  Calling drain afterwards should
> > complete the requests with -ENOMEDIUM.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   tests/Makefile.include     |  2 ++
> >   tests/test-block-backend.c | 82 +++++++++++++++++++++++++++++++++++++=
+++++++++
> >   2 files changed, 84 insertions(+)
> >   create mode 100644 tests/test-block-backend.c
> >=20
>=20
> > +++ b/tests/test-block-backend.c
> > @@ -0,0 +1,82 @@
> > +/*
> > + * BlockBackend tests
> > + *
> > + * Copyright (c) 2017 Kevin Wolf <kwolf@redhat.com>
>=20
> Want to include 2018?  Using a redhat.com address but a personal copyrigh=
t?
> (Then again, Red Hat has some pretty cool policies on what it permits for
> code written on an employee's own time).
>=20
> As long as Kevin is happy with the final copyright line that goes into the
> commit:
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

This is how I got the test case from Kevin, I didn't change the
copyright line.

Stefan

--Cgrdyab2wu3Akvjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJagaBKAAoJEJykq7OBq3PI6IIH/1AOC8eC/Yv5eIH/3ew62j1P
DGiJMzywCGS1J97P9q2aTBL4dNQxjV/k+qbR7WEekqvnCa3OKQ8EgcjpZEOtRxue
6Bq0ihWggDbV2C60URnc2p0dao8XYloFP9jOBbmQZIRQYWZg6/6HXok6sBj1sNHQ
uPuy8TXVfh3SdqS9oxntHwdYf74GQmsSr/nVRy+yIA33LqmddyUXlQz1s766L+9q
Ypx3o+L6lMlbc6E9gF2Def2ppYryLFFJ6S0urkfLogMXSUUUx3DfZrLDNW314sYp
R9KfPHKlIkFuPYMsDEpFEucasmCHBhDEuEZA2v7CuHDFbDAj59WuKt4zd9R7pYs=
=3aA5
-----END PGP SIGNATURE-----

--Cgrdyab2wu3Akvjd--
