Received: from eggs.gnu.org ([2001:4830:134:3::10]:51180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG0mI-0001BH-Ur
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG0mI-0006F4-1M
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:22:58 -0400
Date: Wed, 31 May 2017 11:22:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531102250.GF15666@stefanha-x1.localdomain>
References: <20170526165518.7580-1-mreitz@redhat.com>
	<20170526165518.7580-10-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Content-Disposition: inline
In-Reply-To: <20170526165518.7580-10-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/16] block/qcow2: Generalize
 preallocate()
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


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 06:55:11PM +0200, Max Reitz wrote:
> This patch adds two new parameters to the preallocate() function so we
> will be able to use it not just for preallocating a new image but also
> for preallocated image growth.
>=20
> The offset parameter allows the caller to specify a virtual offset from
> which to start preallocating. For newly created images this is always 0,
> but for preallocating growth this will be the old image length.
>=20
> The new_length parameter specifies the supposed new length of the image
> (basically the "end offset" for preallocation). During image truncation,
> bdrv_getlength() will return the old image length so we cannot rely on
> its return value then.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLpl6AAoJEJykq7OBq3PIf/cIAI4+0ZYud/4YUY04zhB/gPJg
IeD6XoYvlNhURFOl3KVnHPJ2RKRFpNJ2FZna74Mofx7l1vw6OzR0P876o8hp8Jfv
PJoZ4L6Y8eEddEqKP7OX15MhOToE5tuub3n59upy6esNdVTtvg+xTOyWDWWs5Xhv
CBtaTzti1tYOgmJt4BZVkV1NJawg6ZLM88UrT7gvhN3H2Y0nmNtp7BVepKhms6Dt
0XJlTHJ5RE4viuR0DexYPyljh0eTp8UJ2ImRIYjlJPlsn3u9+yTAjLlNMiJWiI0O
0hUrVAUOrgGYURjb4N1/vI6O/bwFQ12IGC5D+c87cKnhRRstbMmAiP21OMfY8z0=
=C75i
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--
