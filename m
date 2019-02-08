Received: from eggs.gnu.org ([209.51.188.92]:41116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1grzJ8-0001fL-JM
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 01:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1grzJ6-0000fN-Dc
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 01:06:38 -0500
Date: Fri, 8 Feb 2019 14:06:18 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190208060618.GE16257@stefanha-x1.localdomain>
References: <20190206112729.37761-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Content-Disposition: inline
In-Reply-To: <20190206112729.37761-1-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/6] virtio-blk: add DISCARD and
 WRITE_ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 12:27:23PM +0100, Stefano Garzarella wrote:
> This series adds the support of DISCARD and WRITE_ZEROES commands
> and extends the virtio-blk-test to test WRITE_ZEROES command when
> the feature is enabled.
>=20
> v3:
> - rebased on master (I removed Based-on tag since the new virtio headers =
=66rom
>   linux v5.0-rc1 are merged)
> - added patch 2 to add host_features field (as in virtio-net) [Michael]
> - fixed patch 3 (previously 2/5) using the new host_features field
> - fixed patch 4 (previously 3/5) following the Stefan's comments:
>                 - fixed name of functions and fields
>                 - used vdev and s pointers
>                 - removed "wz-may-unmap" property
>                 - split "dwz-max-sectors" in two properties
>=20
> v2:
> - added patch 1 to use virtio_blk_handle_rw_error() with discard operation
> - added patch 2 to make those new features machine-type dependent (thanks=
 David)
> - fixed patch 3 (previously patch 1/2) adding more checks, block_acct_sta=
rt()
>                 for WRITE_ZEROES requests, and configurable parameters to
>                 initialize the limits (max_sectors, wzeroes_may_unmap).
>                 (thanks Stefan)
>                 I moved in a new function the code to handle a single seg=
ment,
>                 in order to simplify the support of multiple segments in =
the
>                 future.
> - added patch 4 to change the assert on data_size following the discussio=
n with
>                 Thomas, Changpeng, Michael, and Stefan (thanks all)
> - fixed patch 5 (previously patch 2/2) using local dwz_hdr variable inste=
ad of
>                 dynamic allocation (thanks Thomas)
>=20
> Thanks,
> Stefano
>=20
> Stefano Garzarella (6):
>   virtio-blk: add acct_failed param to virtio_blk_handle_rw_error()
>   virtio-blk: add host_features field in VirtIOBlock
>   virtio-blk: add "discard" and "write-zeroes" properties
>   virtio-blk: add DISCARD and WRITE_ZEROES features
>   tests/virtio-blk: change assert on data_size in virtio_blk_request()
>   tests/virtio-blk: add test for WRITE_ZEROES command
>=20
>  hw/block/virtio-blk.c          | 213 +++++++++++++++++++++++++++++++--
>  hw/core/machine.c              |   2 +
>  include/hw/virtio/virtio-blk.h |   5 +-
>  tests/virtio-blk-test.c        |  75 +++++++++++-
>  4 files changed, 281 insertions(+), 14 deletions(-)
>=20
> --=20
> 2.20.1
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcXRxaAAoJEJykq7OBq3PIW3kIAIKt5N3GP1sI3aaIEgMt1x3c
yQmGtL44NjsKeoxdnGqwyFuA4Z0jNDhR0UPxCjpNy2aAGd2um5BIaLhgzp6CibfS
fjF7rIc0VX4jAMQS7AOWpTFPAHjNkpOaMj04PeW+IGm3ybUNaKs8A4an+MSaBhs0
6ayR1lAqNl16nI9y0cP8BXEAceGyPKfCa7r3MJ5KKEQoL6coTxCK4lgCuJkNYMGU
OY39vMSY9lqr8sI5XLP4AHdi2ox2ajcUuB7iitqTBRnbaDF48uO2yH3SJB8JbQlj
VY6L4X67vQ/EkFm8g/NhIz0ngjF1NWQM8hA6XXgbhVuuQmLoAyCv6Eg1zALPYm4=
=Y5zg
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
