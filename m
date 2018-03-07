Received: from eggs.gnu.org ([2001:4830:134:3::10]:52995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etYRP-0008F8-7r
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etYRK-0005mv-DQ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:45:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1etYRK-0005mU-8a
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:45:02 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B80478424D
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 12:45:01 +0000 (UTC)
Date: Wed, 7 Mar 2018 12:45:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180307124500.GG16861@stefanha-x1.localdomain>
References: <20180306154625.23910-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cgrdyab2wu3Akvjd"
Content-Disposition: inline
In-Reply-To: <20180306154625.23910-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trace: only permit standard C types and
 fixed size integer types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org


--Cgrdyab2wu3Akvjd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 03:46:25PM +0000, Daniel P. Berrang=E9 wrote:
> Some trace backends will compile code based on the declared trace
> events. It should not be assumed that the backends can resolve any QEMU
> specific typedefs. So trace events should restrict their argument
> types to the standard C types and fixed size integer types. Any complex
> pointer types can be declared as "void *" for purposes of trace events,
> since nothing will be dereferencing these pointer arguments.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  scripts/tracetool/__init__.py | 45 +++++++++++++++++++++++++++++++++++++=
++++++
>  trace-events                  |  6 +++---
>  2 files changed, 48 insertions(+), 3 deletions(-)

Looks good, thanks!  I'll merge the next revision.

Stefan

--Cgrdyab2wu3Akvjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJan97MAAoJEJykq7OBq3PIBqEH/jb4gFFu+k3YvGL6LdqjjHGp
rMiJwAZ5DB8Z+tw4VhMZCWFE3ylSwQ0+v+vnZulbWrpTujXhlKDS3wROU4e6QR2K
fMWXhoEvR3SQkLCjh3RHDDHrGKF6hCk66nTDJubXgkzmTkmBc/OsL0sul6lTO41W
5tRsXqlOZ7/tqwg/Sdc0mFFUhEW2ukZOT1rF9KTPyo94qz2rHja0YFTqsyCJVWDm
+xK129ypgoRAifTHcP67kjPiMl0Xn3kh7RIanGMT9mgzFxB1gle6MkBuf+FhxWzc
mxEmzh0SDMuirZWlG4L6t/ke1T6eOYeba9EsjOjjmS5qXnEQ1ZP+fI7V4CmDkz4=
=K23r
-----END PGP SIGNATURE-----

--Cgrdyab2wu3Akvjd--
