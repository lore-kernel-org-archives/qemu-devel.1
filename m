Received: from eggs.gnu.org ([209.51.188.92]:38345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gpR0s-0007Oi-6k
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gpR0r-0003XZ-Ds
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:05:14 -0500
Date: Fri, 1 Feb 2019 13:04:55 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190201050455.GE23131@stefanha-x1.localdomain>
References: <20190131151914.164903-1-sgarzare@redhat.com>
	<20190131151914.164903-5-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline
In-Reply-To: <20190131151914.164903-5-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] tests/virtio-blk: change assert on
 data_size in virtio_blk_request()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 04:19:13PM +0100, Stefano Garzarella wrote:
> The size of data in the virtio_blk_request must be a multiple
> of 512 bytes for IN and OUT requests, or a multiple of the size
> of struct virtio_blk_discard_write_zeroes for DISCARD and
> WRITE_ZEROES requests.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tests/virtio-blk-test.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcU9N3AAoJEJykq7OBq3PIFWMH/14Czk77S9j0h9PYUgx3867A
XKsh0ARq6q+U5eLQ7lC37c5521YrNBat3Os5zoTN7dnIM1EvfRELXtUHr27Rj5P9
PqAKOf/sI1XHFGetWP3uL7EI7Ce82z79NX+9nv/vYLru97vqMJ0FAPC6H3dzq8b+
sSijSrlpZmVmPz9CUyXqyDn7WXtXDfEDfOcTDKEv1t2IHz8j+KsnP72PFLxKw9hC
hIdrq/nSqbardZMnh3fBuiS2K5wqvNGOqTiyh/3sQu2gxv4VfuM2WJyx/PIQBCf+
1amfbj+21Fh/CfiHJkUGVGBnKRnOVLq6bxYA/Cmd0ekLaCev8YXRW+MbuQCrt90=
=sCQT
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
