Received: from eggs.gnu.org ([2001:4830:134:3::10]:51407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG0nY-0001n9-8n
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG0nU-00074Z-Ef
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:24:16 -0400
Date: Wed, 31 May 2017 11:24:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531102402.GG15666@stefanha-x1.localdomain>
References: <20170526165518.7580-1-mreitz@redhat.com>
	<20170526165518.7580-11-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RMedoP2+Pr6Rq0N2"
Content-Disposition: inline
In-Reply-To: <20170526165518.7580-11-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 10/16] block/qcow2: Lock
 s->lock in preallocate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--RMedoP2+Pr6Rq0N2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 06:55:12PM +0200, Max Reitz wrote:
> preallocate() is and will be called only from places that do not lock
> s->lock: Currently that is qcow2_create2(), as of a future patch it will
> be called from qcow2_truncate(), too.
>=20
> It therefore makes sense to move locking that mutex into preallocate()
> itself.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RMedoP2+Pr6Rq0N2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLpnCAAoJEJykq7OBq3PI8ZgH/iIGN2vr9HBihF0XC0cpcpir
dxe1kCV66JypYUHFToOKtjSl4y4F459ZPPT32ZgLpWEKTTQyRQxDn0p5tOsmMXrc
DLAIlQ9CcXx41fG6wqs8lW4L/tlD/8N+P0rj0neCIIRms/+6hnoqBmnfUqIkPSvg
VNLitNsjtICLEgt2JRW47n+BEcJ6SuO9oClDEHAIFWRwsmY++FXLf0dcgz7IjidU
+7Pnh7cTo8DZbm9JxgqY7SuLJN5DuRqLNWQXvSqsqB3aRy6QrtLSFx/78mHWGY7V
Wjl9BXU3ooNoDYar4ch1PlzOYFx31sTWEPb003DKv1WZejFhuvFimy8OFQcn138=
=wWu+
-----END PGP SIGNATURE-----

--RMedoP2+Pr6Rq0N2--
