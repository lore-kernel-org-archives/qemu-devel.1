Received: from eggs.gnu.org ([2001:4830:134:3::10]:50220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIEUQ-0002vF-Js
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIEUM-0000PU-Q9
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:30:14 -0400
Date: Mon, 14 May 2018 15:30:07 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180514143007.GO5182@stefanha-x1.localdomain>
References: <20180511222052.8734-1-ehabkost@redhat.com>
	<20180511222052.8734-9-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9kDAZ2EyO0AcRYa"
Content-Disposition: inline
In-Reply-To: <20180511222052.8734-9-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC 08/10] python: futurize -f
 lib2to3.fixes.fix_renames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


--s9kDAZ2EyO0AcRYa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 07:20:50PM -0300, Eduardo Habkost wrote:
> Change sys.maxint to sys.maxsize.
>=20
> This is necessary for Python 3 compatibility.
>=20
> Done using:
>=20
>   $ py=3D$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';=
) | \
>     sort -u | grep -v README.sh4)
>   $ futurize -w -f lib2to3.fixes.fix_renames $py
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/image-fuzzer/runner.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--s9kDAZ2EyO0AcRYa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+Z1vAAoJEJykq7OBq3PIeygH/RqC4ry+hirDk/VnW9VxZNQ2
TEn0XOXNlF5ratOxLxtsOSSMBRP/05wahSNqaApr9wOKrCfqKNtu6repkNWQmpzO
uTfkEwIbXd7EE+e2ycebCdCE9Oxte14i7TNKz+bZKWAsxJmcor8CDPqzgBxhB0PN
uBmq44xghVkaB5NPBti2eH21et2q+tkIBD3R5NAQrztZ9wnVJaEGoLxKyAj0XbRO
qxzr74XMQ9TDazYVy5ZX7iig7u46Msjeaj8BcGpJUSmAvGC55QqZinDvAawZpgjt
Bqzpb8IE8CiHAOnifz0z0FyLEZRWefivXC/4ZJiGl3no6RF5vViAOytqUkvfZXA=
=tgKO
-----END PGP SIGNATURE-----

--s9kDAZ2EyO0AcRYa--
