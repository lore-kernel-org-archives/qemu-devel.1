Received: from eggs.gnu.org ([2001:4830:134:3::10]:39503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLSL5-0005xT-E7
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLSL4-00068x-Kx
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:49:23 -0400
Date: Thu, 15 Jun 2017 11:49:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170615104910.GB27346@stefanha-x1.localdomain>
References: <20170613205726.13544-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <20170613205726.13544-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] block: Do not strcmp()
 with NULL uri->scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 10:57:26PM +0200, Max Reitz wrote:
> uri_parse(...)->scheme may be NULL. In fact, probably every field may be
> NULL, and the callers do test this for all of the other fields but not
> for scheme (except for block/gluster.c; block/vxhs.c does not access
> that field at all).
>=20
> We can easily fix this by using g_strcmp0() instead of strcmp().
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> v2:
> - Fix all affected block drivers, not just nfs [Peter]
> - Use g_strcmp0() [Markus]
> ---
>  block/nbd.c      | 6 +++---
>  block/nfs.c      | 2 +-
>  block/sheepdog.c | 6 +++---
>  block/ssh.c      | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZQmYmAAoJEJykq7OBq3PIX7kIAKFM1ktxglvQJS2SFVORtp6a
JLPP8rQzm1GaEcd52y1U1EXL35Dj43VPZyrVFCZuh5BfRa51cNzMfV+JRLAOr0Ks
mB9qUarI0oaxaXTNeqJKf04iCRcpSOjwJn75vWs2G3bhaaWR6cVWrIGjG8cYe4Na
Fpago6TXaAyNGymxJNgrxRObqpu6imyUMn4dHcJ4vu8t1RGTXrvCKLxkH3Fx0Qic
0Yk8ebBps+yci4s2TB5NeWAsNU/YXzJRariVjtgFRJYcAjFka+YA57TxEfCNv4bt
Z6/O7GPyUDUhHQOmnGH6tj6fEwPsFWrvDV0bXkqM5DHilGfL+Ay+BBAcEmaKCyg=
=q0K2
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
