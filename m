Received: from eggs.gnu.org ([2001:4830:134:3::10]:59896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG31j-0005Se-Fm
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG31g-0006H1-Bg
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:47:03 -0400
Date: Wed, 31 May 2017 13:46:55 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531124655.GY16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-25-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t3Rhqlz/9+3FgEet"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-25-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 24/29] qed: Remove recursion in
 qed_aio_next_io()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--t3Rhqlz/9+3FgEet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:22:05PM +0200, Kevin Wolf wrote:
> Instead of calling itself recursively as the last thing, just convert
> qed_aio_next_io() into a loop.
>=20
> This patch is best reviewed with 'git show -w' because most of it is
> just whitespace changes.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 63 +++++++++++++++++++++++++++++++------------------------=
------
>  1 file changed, 32 insertions(+), 31 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--t3Rhqlz/9+3FgEet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrs/AAoJEJykq7OBq3PIYjwH/3eHAipKXjQZ7OuJO+ZMq/Jg
psi3fKSjJD7L7rBMsKZlv+JQ0vxcr/4++oMWXx/jUSnqzAdyl2Mfg40BSYZv+f9E
nJP7LEYKHcJ3K6NG0T08XVTyznd4gP/AyfftoxCTtUpMHKFxUFLecSV3uz38j+Zr
KWORwyMTeafTypfK3V/jpOg2+o02J9/M5nARiJcbXYQn1PwhIg+CsIp8wo8a4ETX
dISpX77uGq7nRD+HsIBg0HNb9W09p4pwuh55ncjSFu39M0PXplhRGN1mXp/2YaOw
J8cIjNXHviUSMPD2f2RHVHqGgDzl8fHAQVYg9p/9N3OQ8+MQ8yplu9v2mXVO190=
=VrzV
-----END PGP SIGNATURE-----

--t3Rhqlz/9+3FgEet--
