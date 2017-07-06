Received: from eggs.gnu.org ([2001:4830:134:3::10]:33898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT3iH-0001Dp-J4
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT3iE-00047v-BQ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:08:45 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dT3iE-00047b-3K
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:08:42 -0400
Received: by mail-lf0-x243.google.com with SMTP id f28so1641965lfi.3
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 03:08:42 -0700 (PDT)
Date: Thu, 6 Jul 2017 11:08:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170706100837.GI30447@stefanha-x1.localdomain>
References: <20170704122325.25634-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZOudaV4lSIjFTlHv"
Content-Disposition: inline
In-Reply-To: <20170704122325.25634-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-thread: Assert locks are initialized
 before using
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com


--ZOudaV4lSIjFTlHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2017 at 08:23:25PM +0800, Fam Zheng wrote:
> Not all platforms check whether a lock is initialized before used.  In
> particular Linux seems to be more permissive than OSX.
>=20
> Check initialization state explicitly in our code to catch such bugs
> earlier.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  include/qemu/thread-posix.h |  4 ++++
>  include/qemu/thread-win32.h |  5 +++++
>  util/qemu-thread-posix.c    | 27 +++++++++++++++++++++++++++
>  util/qemu-thread-win32.c    | 34 +++++++++++++++++++++++++++++++++-
>  4 files changed, 69 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZOudaV4lSIjFTlHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXgwlAAoJEJykq7OBq3PIyagH/3W6kkhDSWarYuUIFIJjQf/O
skP/XzOZ7kJvwPyF7U+ZveK3hC3xeM9JjD+yrbKoXZ6kKdWtoZy/J1XeafmoUPpT
GTMtcoNCHUUChEh9nFUbbP0HgsgstNTFH+xY7bLvqhHRWp6JYvQdJ8KcW0PWft4G
ZycDRr6Brd2jiP7C5kXZjGrjw/Cx/osBJpLvIgsBQX4RT/rCTMiFNR2eqm9kZK07
/19P2n6Y+uTEull5j33xSY4K0XZbLlBFAtWjEOO19W1QrQ01VafPFDdU1pptn/QJ
i82g5khJ5xTXX8VtEKBT4NDwgWxgePaNh9RRbALnAlDhE2ZQ2bCxIlp6K+/syBw=
=WS9q
-----END PGP SIGNATURE-----

--ZOudaV4lSIjFTlHv--
