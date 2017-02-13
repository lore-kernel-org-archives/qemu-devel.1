Received: from eggs.gnu.org ([2001:4830:134:3::10]:33188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHdj-00018X-63
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHdi-0005mi-2U
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:30:03 -0500
Date: Mon, 13 Feb 2017 14:29:55 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213142955.GL10361@stefanha-x1.localdomain>
References: <20170207235757.2026-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2EnvhqpWJq810sZn"
Content-Disposition: inline
In-Reply-To: <20170207235757.2026-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] progress: Show current
 progress on SIGINFO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--2EnvhqpWJq810sZn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2017 at 12:57:57AM +0100, Max Reitz wrote:
> Currently we only print progress information on retrieval of SIGUSR1.
> Some systems have a dedicated SIGINFO for this, however, so it should be
> handled appropriately if it is available.
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1662468
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Can anyone test this on a BSD system? O:-)
> ---
>  util/qemu-progress.c | 3 +++
>  qemu-img.texi        | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2EnvhqpWJq810sZn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYocLjAAoJEJykq7OBq3PIBdIH/15yRcjDExe0/oKVDHe/X42y
jK379QZOAkkw9lgy/ito7JxSvUK75wMa5OHiTu2IwNOE/oiYkV4YN/VQJ+OY2NW3
e9ItEaA3ujU4jeyn5voR0cG6WIbeSq7fihuG7B5C9yORKykBSlqi3oKxg7Zo0aSp
xijDi59KbGvqsmQ7EozD/OR+LESHgQY+hpo750LM4XmSct2YaVXTpeYVntV7i41u
J3uBT5XsnoP3J7jPHbIal3REvSG4lMpR2KpXMfIHfHqd+RYgT6moDHFywJSOM6Ql
bOMus6LE536iWZ2xmKEtV/d8rGiqSxQ/kzp1HRQVkzFKLlndo/phUmgvcBaCATU=
=v25i
-----END PGP SIGNATURE-----

--2EnvhqpWJq810sZn--
