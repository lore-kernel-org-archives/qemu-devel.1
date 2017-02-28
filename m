Received: from eggs.gnu.org ([2001:4830:134:3::10]:49169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cihfZ-0000aF-Na
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:18:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cihfV-0003AD-Nz
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:18:21 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cihfV-00039o-HP
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:18:17 -0500
Received: by mail-wm0-x244.google.com with SMTP id u63so2352294wmu.2
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:18:17 -0800 (PST)
Date: Tue, 28 Feb 2017 13:18:14 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170228131814.GD22992@stefanha-x1.localdomain>
References: <20170222163734.13104-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <20170222163734.13104-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] virtio: migration fixes for memory
 region cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2017 at 04:37:32PM +0000, Stefan Hajnoczi wrote:
> v2:
>  * Avoid early region cache initialization in virtio_load() with wrong ri=
ng
>    addresses for VIRTIO-1 in Patch 2 [Cornelia]
>=20
> Bug fixes for the recently added memory region cache in virtio.  This ser=
ies
> fixes live migration, see patches for details.
>=20
> Stefan Hajnoczi (2):
>   virtio: invalidate memory in vring_set_avail_event()
>   virtio: add missing region cache init in virtio_load()
>=20
>  hw/virtio/virtio.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)

Michael: Ping?

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtXiWAAoJEJykq7OBq3PIQkIIAKJ53CBTZI0OyZC81ZpK+bXu
gnNdd8Kt+qvecQOzmJdQCqfcBI5jzEoQzd7Nt/htQeiqghmcwT0ftJSmaraT6U3Z
gGphCyWIt+bOq075gmDO9ckzOhHD0lFWYXfX8Gk7w74YTuAVdxMUWJaRk1QA6bXw
UdkTF0XCSRsHElcY7/h6RZt4uruAHJym8GHLTUI7wLIZVL3NuBzNKWBsrcuVF6+m
0B5QhzXDw3KE31vw2+FVduQj2KxlXBpkZ7hmganLiXGomSBFo/RCwuViUT8DWONS
3+UKQSdf/blcsqXzQGbCb5P2tMiODf4f1Tu4hhyZb61JZidpgDmvRPLZHgW18Q4=
=Wf+x
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
