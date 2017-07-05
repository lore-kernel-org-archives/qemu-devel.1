Received: from eggs.gnu.org ([2001:4830:134:3::10]:40193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dSkYr-0000NE-AS
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dSkYo-0006DD-7J
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:41:45 -0400
Date: Wed, 5 Jul 2017 14:41:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170705134138.GE1280@stefanha-x1.localdomain>
References: <20170626101159.19676-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline
In-Reply-To: <20170626101159.19676-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sockets: avoid formatting buffer that may
 not be NULL terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 11:11:59AM +0100, Daniel P. Berrange wrote:
> The 'sun_path' field in the sockaddr_un struct is not required
> to be NULL termianted, so when reporting an error, we must use
> the separate 'path' variable which is guaranteed terminated.
>=20
> Fixes a bug spotted by coverity that was introduced in
>=20
>   commit ad9579aaa16d5b385922d49edac2c96c79bcfb62
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Thu May 25 16:53:00 2017 +0100
>=20
>     sockets: improve error reporting if UNIX socket path is too long
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXOySAAoJEJykq7OBq3PIFYUH/3WJTMmnlemPTvRUdDd/z0Cq
ZE+0CtGJS9y4Jkx6GEe7zuvHkGPJnkMvMiZUzsi3BYdY1A4InBJak1y34g+QhfQn
db8MMsCrX+RBE7PwUUaIDblRdnvvr/0kYl6TVxOPVazOHVkJVSerVHoP5p3jbeQE
DaufkCFrVtUL3JTQn0a1PK3XG5D3oPheEUir9FG8AV/4Cg+UJeZ99Eaoda2+viQR
JonaErNREqrTPvGbTw3KouonMqQCjjmEJbX6uHtGpnvI+I2IOE9uswBFOz8U9juw
zFDPy26suwmUWp8CBtn0ceIcYCFyAehaqvOj98GflJai9Xjtrilyga3G+He5Qu4=
=DyU5
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--
