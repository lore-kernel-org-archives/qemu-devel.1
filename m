Received: from eggs.gnu.org ([209.51.188.92]:38185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwUIr-0005jA-6m
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwUIb-0002pQ-5i
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:00:49 -0500
Date: Wed, 20 Feb 2019 16:00:33 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190220160033.GD30403@stefanha-x1.localdomain>
References: <20190218140301.197408-1-sgarzare@redhat.com>
	<20190218140301.197408-5-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Content-Disposition: inline
In-Reply-To: <20190218140301.197408-5-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 04/10] virtio-net: make
 VirtIOFeature usable for other virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 03:02:55PM +0100, Stefano Garzarella wrote:
> In order to use VirtIOFeature also in other virtio devices, we move
> its declaration and the endof() macro (renamed in virtio_endof())
> in virtio.h.
> We add virtio_feature_get_config_size() function to iterate the array
> of VirtIOFeature and to return the config size depending on the
> features enabled. (as virtio_net_set_config_size() did)
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  hw/net/virtio-net.c        | 31 +++++++------------------------
>  hw/virtio/virtio.c         | 15 +++++++++++++++
>  include/hw/virtio/virtio.h | 15 +++++++++++++++
>  3 files changed, 37 insertions(+), 24 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcbXmhAAoJEJykq7OBq3PI4q8H/3vjKbpaEvjH590k9rslrAy2
eQtpbje3SKsmBpn8HqtpwAnBhmXoM7KLhN8Q2X23PAMDSvWOy0+e7opIUMpqhMAo
F6OXSBkQ4RpYs2APO1HbCU1RKrMSU/7UtEWMyxs17mjyffVzjCw++MTHgltdkJa5
otDui/XNg7ihtYBATgXOOevm5cjkiKiqJFloTCNQBZWxq2AN74LXj4ramPTZWxBr
ohA4SVxsaePFwSUpwAXbJGLqFdFL2LssEvMC2StxlCrUwDTbSZDGqzi9CBpmeGiB
jh54YkbbuJHQ5WH+wkBhyGzwto2GQdGGrkdDi4rxMaz3keOk+f1w5FQlW2TIMy4=
=CQDL
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
