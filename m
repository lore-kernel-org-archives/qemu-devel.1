Received: from eggs.gnu.org ([2001:4830:134:3::10]:50313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIEUb-00039d-QU
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIEUV-0000Tp-TO
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:30:25 -0400
Date: Mon, 14 May 2018 15:30:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180514143017.GP5182@stefanha-x1.localdomain>
References: <20180511222052.8734-1-ehabkost@redhat.com>
	<20180511222052.8734-10-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJ8inJ6ig7iY3YX9"
Content-Disposition: inline
In-Reply-To: <20180511222052.8734-10-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC 09/10] python: futurize -f
 lib2to3.fixes.fix_except
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


--rJ8inJ6ig7iY3YX9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 07:20:51PM -0300, Eduardo Habkost wrote:
> Convert "except X, T" to "except X as T".
>=20
> This is necessary for Python 3 compatibility.
>=20
> Done using:
>=20
>   $ py=3D$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';=
) | \
>     sort -u | grep -v README.sh4)
>   $ futurize -w -f lib2to3.fixes.fix_except $py
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/simpletrace.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--rJ8inJ6ig7iY3YX9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+Z15AAoJEJykq7OBq3PIvj0H/1qn4e8YL9rKI0uK5LlXlbxC
PiKKS5yPfU4d9gcMVews0GfeXyCKjuZw1UoefUl7OEUMew/xrQLM3paB6PqvKegR
pk9nqbSE45Vs1wCxsKr7NqIEe/tzzguhGMCDdNwDgX0aakQ1OjsFH9u4R94EDJ3Q
7XLwzLQWuN27A23fF9isnRzauO/8fXEX/6H7ELmyLslDJaRO+7AF2e+hbhiPugQo
kjvodmNPAiqLF/3CCn7GNB1u4urLNVo8jG/V5VHeVFKNI2tsfLl3NL5byW57ZWB6
DZ/BPnTK0HZ0YMjw4iMkBrwcc5hwtYiq9ofWCH1phHZzDvs6IL3Qh5gzwLnRDT0=
=AkLo
-----END PGP SIGNATURE-----

--rJ8inJ6ig7iY3YX9--
