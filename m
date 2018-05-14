Received: from eggs.gnu.org ([2001:4830:134:3::10]:49541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIESy-0001DV-JW
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIESv-0008GJ-9S
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:28:44 -0400
Date: Mon, 14 May 2018 15:28:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180514142838.GM5182@stefanha-x1.localdomain>
References: <20180511222052.8734-1-ehabkost@redhat.com>
	<20180511222052.8734-7-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MsEL38XAg4rx1uDx"
Content-Disposition: inline
In-Reply-To: <20180511222052.8734-7-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC 06/10] python: futurize -f
 lib2to3.fixes.fix_reduce
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


--MsEL38XAg4rx1uDx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 07:20:48PM -0300, Eduardo Habkost wrote:
> Handle the move of reduce() to functools.reduce().
>=20
> This is necessary for Python 3 compatibility.
>=20
> Done using:
>=20
>   $ py=3D$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';=
) | \
>     sort -u | grep -v README.sh4)
>   $ futurize -w -f lib2to3.fixes.fix_reduce $py
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/image-fuzzer/qcow2/fuzz.py | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--MsEL38XAg4rx1uDx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+Z0WAAoJEJykq7OBq3PIbF4IAKi1352MXNmS7iefG7oUAipV
gEseZbrZ/USIC05n3i9/xpgbPzla75qA/6IwN3n0NCRo25B5z/9DvWphexyIcD9W
oAPG0h7r0E8RCZN0tdBJMZ5NDsq9JbBNactZ36UqRFq7ZyORaCvtmLeQUT8/0Qm3
vuUkD3u0InwwEJb2P9+1avMHVX81Q3HbL46fLld/vMdzuFwX4Yt8C9rLtyZIh6Ik
IW/RoUIGzcSIIPhRKVwTD0NHdXrPde9d6wrlrUKlIRKjQHksvtB7camZHO0PxLla
AynoPdVJtDFj/rS1mycw75cXoMBGgT7XlrO79qOMwXw4IAFNEl4x+Dz3oEp9Uo0=
=VWQx
-----END PGP SIGNATURE-----

--MsEL38XAg4rx1uDx--
