Received: from eggs.gnu.org ([209.51.188.92]:43516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hCM9a-0006bv-0m
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hCM9Z-0007Ue-38
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:32:57 -0400
Date: Fri, 5 Apr 2019 11:32:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190405103247.GG25152@stefanha-x1.localdomain>
References: <20190328182810.21497-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kadn00tgSopKmJ1H"
Content-Disposition: inline
In-Reply-To: <20190328182810.21497-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/2] file-posix:
 query-qemu-features for auto-read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, armbru@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org


--kadn00tgSopKmJ1H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2019 at 07:28:08PM +0100, Kevin Wolf wrote:
> auto-read-only=3Don changed its behaviour in file-posix for the 4.0
> release. This change cannot be detected through the usual mechanisms
> like schema introspection.
>=20
> I took Stefan's patch 'qmp: add query-qemu-capabilities', removed the
> feature that he originally wanted this for and addressed the review
> comments. The introduction of the file-posix-dynamic-auto-read-only
> feature is a separate patch.
>=20
> Stefan, I kept you as the author of the first patch and also your
> Signed-off-by. Is this okay with you or would you prefer a change?

Sorry I was unresponsive.  I'm fine with the authorship and
Signed-off-by: but won't be offended if either or both are removed when
the patch is reworked (my code is trivial).

Stefan

--kadn00tgSopKmJ1H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEbBAEBAgAGBQJcpy7PAAoJEJykq7OBq3PIq28H9i8gw8+Ff/dAJQ8MWHiX8Yja
23Y9Z0Fvv8iMkEMxDKvNX8Datf/FrUIVSwJSbY1AYmdEWtR6gYcZpp3UARlr5xJ7
iGjrFqJW2dxGdzgay7M8MSVivTQwCZVuDhYVNJ++7CWYozpC3H5T1G/rD4j28ttA
LdLoaLOAu2tVD7IEA1qaCowJ3k0SM59vFVnQsK0nKHCSU1E4RR63hM/cK9+hOoeC
C+SSzp+HcBTi0KIb/tBecY/1jQGN3eJ2ZgCeZd7e0XebVg7EwDCvuPOc3SiJb08R
YCr7aOBcHuO5X6N7i1riEBvOp2uKwyREY6L+EffPUF137hxvLWWcNDGQaKyItw==
=GC5L
-----END PGP SIGNATURE-----

--kadn00tgSopKmJ1H--
