Received: from eggs.gnu.org ([2001:4830:134:3::10]:37646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOgcx-0001VL-4i
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 04:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOgcw-0002fM-4i
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 04:13:27 -0500
Date: Tue, 12 Dec 2017 09:13:14 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171212091314.GD6089@stefanha-x1.localdomain>
References: <cover.1513004957.git.mark.kanda@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline
In-Reply-To: <cover.1513004957.git.mark.kanda@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] virtio-blk: miscellaneous changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Kanda <mark.kanda@oracle.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, konrad.wilk@oracle.com, martin.petersen@oracle.com, ameya.more@oracle.com, karl.heubaum@oracle.com


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2017 at 09:16:23AM -0600, Mark Kanda wrote:
> v2: add check for maximum queue size [Stefan]
>=20
> This series is for two minor virtio-blk changes. The first patch
> makes the virtio-blk queue size user configurable. The second patch
> rejects logical block size > physical block configurations (similar
> to a recent change in virtio-scsi).
>=20
> Mark Kanda (2):
>   virtio-blk: make queue size configurable
>   virtio-blk: reject configs with logical block size > physical block
>     size
>=20
>  hw/block/virtio-blk.c          | 17 ++++++++++++++++-
>  include/hw/virtio/virtio-blk.h |  1 +
>  2 files changed, 17 insertions(+), 1 deletion(-)
>=20
> --=20
> 1.8.3.1
>=20

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaL52qAAoJEJykq7OBq3PISjcIAJGLoNBniespZ+9namqXmWbB
mkeDgQZoYchx4AhasYMvscH6hxD6Hbq47k/Vn9Fji0Y2h2d6Wii1dmQfthZPmsGp
G0fgMuKdBQMWKmgRB/JylocjFqEgnGRt7NAWhkTWdwz77VHeSwdTqCZX4HvqoZM/
VUJeBgIVnezU7DWfxkCIXvyjYDtVetV/pQHWd0hkOA4xrwcwR/LRN2yYI3biuIIj
+576JU0ztzpwsWHHkoUZoy0MdQ9HLzJOHjwIv/Q6YF42jbeyHSSbkO2O6UrAEbcC
n0/3uURe2iLrIn4jc2xxN+3k+tKr6o62LoVYXmTOJxLDMCfUyyU47fLrgjls0Ow=
=SVxf
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--
