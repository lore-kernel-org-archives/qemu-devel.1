Received: from eggs.gnu.org ([2001:4830:134:3::10]:54419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cJGwG-0006yy-F6
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 04:42:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cJGwA-0006A9-CH
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 04:42:27 -0500
Date: Tue, 20 Dec 2016 09:42:15 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161220094215.GC5602@stefanha-x1.localdomain>
References: <20161219154444.13143-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
In-Reply-To: <20161219154444.13143-1-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] virtio: fix vq->inuse recalc after
 migr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2016 at 04:44:44PM +0100, Halil Pasic wrote:
> Correct recalculation of vq->inuse after migration for the corner case
> where the avail_idx has already wrapped but used_idx not yet.
>=20
> Also change the type of the VirtQueue.inuse to unsigned int. This is
> done to be consistent with other members representing sizes (VRing.num),
> and because C99 guarantees max ring size < UINT_MAX but does not
> guarantee max ring size < INT_MAX.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Fixes: bccdef6b ("virtio: recalculate vq->inuse after migration")
> CC: qemu-stable@nongnu.org
> ---
> v1 -> v2:
> * Reworded comment explaining the cast. (thanks Stefan)
> * Changed type of vq->inuse from signed to unsigned
> * Fixed misnomer %s/vring->inuse/vq->inuse/
> ---
>  hw/virtio/virtio.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYWPz3AAoJEJykq7OBq3PIFisH/205Yk4GlI1s5NW8dxZCgHQi
a6r+waUZUkB4LP0MzhFP7nxacuD0iC4MSY5JpCLX7eTeuNHiQ86bbzZz/ZSe7smz
+cM3DWvJMWeWO/wVFhuaVFoB9ndrLshwr5x5BFqkH1jtcAPWCtg5IgROJ2nFOhCL
sBBGwNTEJBpH8EoKO3Y7wY9gt7XJgrIjJYR+z1DHFKpTchcRj7ueccLxtsbX5Xv4
nTpFSdaPXch9SxCCts1AcJuPGh0huvXEHOaQh/ED+hPiLSZqcxzb6nUvHAmRAZgQ
iIjKl1xHfUPpleGDq/ZOPTjdR1bW+WvyKLZqCYqqRkhK3Twh88/TSt1ByuP3HtI=
=icPk
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
