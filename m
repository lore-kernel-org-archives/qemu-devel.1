Received: from eggs.gnu.org ([2001:4830:134:3::10]:49835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIETY-0001wb-VI
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIETV-0008QY-Pa
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:29:20 -0400
Date: Mon, 14 May 2018 15:29:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180514142914.GN5182@stefanha-x1.localdomain>
References: <20180511222052.8734-1-ehabkost@redhat.com>
	<20180511222052.8734-8-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kK1uqZGE6pgsGNyR"
Content-Disposition: inline
In-Reply-To: <20180511222052.8734-8-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC 07/10] python: futurize -f
 lib2to3.fixes.fix_tuple_params
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


--kK1uqZGE6pgsGNyR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 07:20:49PM -0300, Eduardo Habkost wrote:
> Remove implicit tuple parameter unpacking.
>=20
> This is necessary for Python 3 compatibility.
>=20
> Done using:
>=20
>   $ py=3D$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';=
) | \
>     sort -u | grep -v README.sh4)
>   $ futurize -w -f lib2to3.fixes.fix_tuple_params $py
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/analyse-locks-simpletrace.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kK1uqZGE6pgsGNyR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+Z06AAoJEJykq7OBq3PI36IIALJBS+UR2w0Uhq/ShDt2R4xV
zQC+O11wf3yka3uB6uCebsdkJ5TaMXWrFqimwQsazFA19s+yCi9aLIbLdAVZBzlF
50/B5q9M5a7ogdEknQVNtSM3XxfzKZS+BvYFus9BitYh+A1SLw87wZNxEKAxrSJ0
NsC4suZHZ4R9ogyd9o9fD5ARVf9tE/5xqXFJ1H2YgVdGu5ixTxqWrq+wJ0K36RbW
XyHDK7GGZlwND4E9edPoi6dgWZ+GvcA47B2GzxmFfjrB2C39BtzevKubRyowkPGS
srE1Py94EIpCJEcr/eoLfkPwTNZ/qFjjPNK+Gqx48kI6DkRb3i6hAg/OrhmljJc=
=fedp
-----END PGP SIGNATURE-----

--kK1uqZGE6pgsGNyR--
