Received: from eggs.gnu.org ([2001:4830:134:3::10]:58085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gZG84-000585-EA
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gZG81-000495-AG
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:13:48 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gZG81-00048r-2X
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:13:45 -0500
Received: by mail-wr1-x442.google.com with SMTP id z5so16042764wrt.11
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 06:13:45 -0800 (PST)
Date: Tue, 18 Dec 2018 13:12:01 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181218131201.GB30223@stefanha-x1.localdomain>
References: <20181213210057.3676-1-quintela@redhat.com>
	<20181213210057.3676-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20181213210057.3676-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/16] virtio: split vhost vsock bits
 from virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 10:00:42PM +0100, Juan Quintela wrote:
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> ---
>=20
> Updated copyright info
> Also split virtio-pci.h bits
> ---
>  hw/virtio/Makefile.objs     |  3 ++
>  hw/virtio/vhost-vsock-pci.c | 82 +++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c      | 51 -----------------------
>  hw/virtio/virtio-pci.h      | 18 --------
>  4 files changed, 85 insertions(+), 69 deletions(-)
>  create mode 100644 hw/virtio/vhost-vsock-pci.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcGPIgAAoJEJykq7OBq3PIlrMIAKhi8Knyk6N21Y6+whRQQ72j
w6N1WE+OsjZGPLncgQ/h8WLt3GRCxF+TKGuBrbvigkvfYqmaMzpFwPtfS1/xRXUX
3HS9MYHMiUa0mVD9XVTA4kxI+4QXt3gCmf8EMSqZI7ndmitzX7cagjaETt2ew1Hs
wjqBOEevKURLpyfXWotH9COcuYSNXGGWQAKDfBBNQr7VumAJszlwCeghBrzd2p0s
1WUcNdzpbM5sJx1Wn61boisL0F4gLWnBlq4giXE4ENN1hXH86KjVxWJ5+YPgZQs5
sz8igt7BaIZM9+CU/ZDVrcKZz1JSGZ+CFrnfiJTrqu5FxwOSixE9rHGmrwKi1TA=
=Qk0B
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
