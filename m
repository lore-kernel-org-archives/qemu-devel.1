Received: from eggs.gnu.org ([2001:4830:134:3::10]:36295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT2DB-0005SP-Ms
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT2D6-0005jO-VA
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:32:33 -0400
Date: Thu, 6 Jul 2017 09:32:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170706083225.GA30447@stefanha-x1.localdomain>
References: <20170629162046.4135-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20170629162046.4135-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] backends: remove empty trace-events file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2017 at 05:20:46PM +0100, Daniel P. Berrange wrote:
> The content of the backends/trace-events file was entirely
> removed in
>=20
>   commit 6b10e573d15ef82dbc5c5b3726028e6642e134f6
>   Author: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>   Date:   Mon May 29 12:39:42 2017 +0400
>=20
>     char: move char devices to chardev/
>=20
> Leaving the empty file around, causes tracetool to generate
> an empty .dtrace file which makes the dtrace compiler throw
> a syntax error.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile.objs         | 1 -
>  backends/trace-events | 0
>  2 files changed, 1 deletion(-)
>  delete mode 100644 backends/trace-events

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXfWZAAoJEJykq7OBq3PIdTYH/2MHwB0155Zlz7Qt+PnrxBje
QUfBHZGkRcWmaNZBkrsFm6s4wROZZpPPtgn3E6XtylyBBwz4xu3sNIfL1RlVUjUr
Zc0MePCnaKqJevKEjp1kno21No470ylHu5gZh0W9QjT9DV7RLQoK+Yiaarz3wlVM
AbrgJCiuXPeQ+7VJ2j2lw7M32MurJVNmuGHDDlzPp1nQD92bl6QKEDbdtc8mCK7s
cOxpiElo4x7RUZni6tK/3PXBedH5VAEYAKU8gpBqOFkmi8AmnrP3OG/41+pfTeuV
NUwKHdxFsjpMCClkgWOaswsSOpLFKVlap2WH2Kqc+KIghhXWeduaCCoRR+IwmtU=
=ID6p
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
