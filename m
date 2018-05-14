Received: from eggs.gnu.org ([2001:4830:134:3::10]:49252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIES3-0000PF-0P
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIES0-000831-2x
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:27:47 -0400
Date: Mon, 14 May 2018 15:27:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180514142741.GK5182@stefanha-x1.localdomain>
References: <20180511222052.8734-1-ehabkost@redhat.com>
	<20180511222052.8734-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+RZeZVNR8VILNfK"
Content-Disposition: inline
In-Reply-To: <20180511222052.8734-5-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC 04/10] python: futurize -f
 lib2to3.fixes.fix_has_key
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


--x+RZeZVNR8VILNfK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 07:20:46PM -0300, Eduardo Habkost wrote:
> Change "dict.has_key(key)" to "key in dict"
>=20
> This is necessary for Python 3 compatibility.
>=20
> Done using:
>=20
>   $ py=3D$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';=
) | \
>     sort -u | grep -v README.sh4)
>   $ futurize -w -f lib2to3.fixes.fix_has_key $py
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qmp/qmp        | 4 ++--
>  scripts/qmp/qmp-shell  | 2 +-
>  scripts/qmp/qom-fuse   | 2 +-
>  scripts/qmp/qom-get    | 2 +-
>  scripts/qmp/qom-list   | 2 +-
>  scripts/qmp/qom-set    | 2 +-
>  scripts/qmp/qom-tree   | 2 +-
>  tests/qemu-iotests/093 | 2 +-
>  tests/qemu-iotests/096 | 4 ++--
>  tests/qemu-iotests/136 | 2 +-
>  10 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--x+RZeZVNR8VILNfK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+ZzdAAoJEJykq7OBq3PIZiYIAK4A7mTJ8SvhiLlhAjkVX6aZ
8nRnOkK0f6mSM+JEkn4Jq3XGX9xJzbRgwRNESozrwasNjp5DvBFdOahIQIxIEO39
IsZsQGOYRNe56yrcrMNyBQb5m1vaQHOyhiD+ipAsAeOo3iS8kV6KMRPpMqdf7UPT
9PlRbYNwsCutaz2CvspGzOKIwoEgENMecSUczo626HH0GaWce3PJ3IzV1+i6Rg+C
yTTyQKxaMjBU9mQNFXely9He9YSV62llGWWjJ45R0g5SOaM5hpjmvi9zvbLQv5A+
/CmFK7++JW5zRb40ETcFZuKsteKDonvzXKdQaUWiWxaQjPBmO8Y2srHZENKQwG8=
=/Tss
-----END PGP SIGNATURE-----

--x+RZeZVNR8VILNfK--
