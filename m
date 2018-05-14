Received: from eggs.gnu.org ([2001:4830:134:3::10]:49363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIESP-0000jW-N0
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIESL-00087W-Kd
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:28:09 -0400
Date: Mon, 14 May 2018 15:28:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180514142802.GL5182@stefanha-x1.localdomain>
References: <20180511222052.8734-1-ehabkost@redhat.com>
	<20180511222052.8734-6-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9/GiYV45wF7IL3Iq"
Content-Disposition: inline
In-Reply-To: <20180511222052.8734-6-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC 05/10] python: futurize -f
 lib2to3.fixes.fix_standarderror
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


--9/GiYV45wF7IL3Iq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 07:20:47PM -0300, Eduardo Habkost wrote:
> Rename StandardError to Exception.
>=20
> This is necessary for Python 3 compatibility.
>=20
> Done using:
>=20
>   $ py=3D$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';=
) | \
>     sort -u | grep -v README.sh4)
>   $ futurize -w -f lib2to3.fixes.fix_standarderror $py
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qmp/qemu-ga-client | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9/GiYV45wF7IL3Iq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+ZzyAAoJEJykq7OBq3PIOb0H/R33RlxIwa1tRjrbZihgS4EF
bzMMCLuselN0lAEZ+Ks5Qknf+0mcyaA1JslKfuEeRxyG93V0BzbPlKBfxTwd4/UC
IbCAgQcN7yPN0BR1KL3fHQjZjFVQzzEbUaIpDe780cpYGZ8xkAsYKzXPAOa4h+JS
H3+j6pnsgudHO5kb8OqM81qUhSdgPoemEMaLxujTOu6uG+ZWiupSkpnTCUcpzYCI
bW7xS0ieg1TpxMFYst2PrhUbqvttaFBRL0CzggeXpQwwLN/LBZyQsDqChXGS5Hou
l5OOJ+JdvLTVBPtZ3k5x2XgBK68jZbluun6A3Rn6RY9pH0DXHE6jUGzs/zNfA6w=
=8Ef1
-----END PGP SIGNATURE-----

--9/GiYV45wF7IL3Iq--
