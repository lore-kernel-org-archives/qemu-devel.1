Received: from eggs.gnu.org ([209.51.188.92]:60358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gt2ee-0004qF-Fp
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 22:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gt2ed-0000mJ-0P
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 22:53:12 -0500
Date: Mon, 11 Feb 2019 11:53:05 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190211035305.GE18083@stefanha-x1.localdomain>
References: <20190208142347.214815-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline
In-Reply-To: <20190208142347.214815-1-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] virtio-blk: cleanup using
 VirtIOBlock *s and VirtIODevice *vdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 03:23:47PM +0100, Stefano Garzarella wrote:
> In several part we still using req->dev or VIRTIO_DEVICE(req->dev)
> when we have already defined s and vdev pointers:
>     VirtIOBlock *s =3D req->dev;
>     VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  hw/block/virtio-blk.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcYPGhAAoJEJykq7OBq3PIgmkH/i/VWN6/Knu7ifMjwq+fCLwb
uimSurwV1dmvgAHQk8XsiqgeiBY9moKW/pICUldMZ7J1kwK7EVXaty13scV72YQp
i9IgImmhmhWxZ64yM0Z3dl7wq79eg7mmwSnS+23eNSEPzOgdxwbmYSm0CIC5PVjE
YWg+SbTD18+DS8wWOzS5rLr4SfFDNsv7Y4RRqNR5PjFaSvGISXbB5PvVuQj1cyHh
eIIOrlWAFc7Efwh2QcMxE+lKCUh7LVfWXvwSdwat4Hd4BLENEGUoCsM8Na83gMEM
FTRPhaINTlLRrBPgi0qvqrh/Z7R0e4+MO5LYW+AEA/WJ5nC10p6ZXI8KDGMs2cQ=
=PPJb
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--
