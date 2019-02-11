Received: from eggs.gnu.org ([209.51.188.92]:37277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gt3FH-0003PO-53
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 23:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gt32F-0006Ie-5U
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 23:17:37 -0500
Date: Mon, 11 Feb 2019 12:17:18 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190211041718.GF18083@stefanha-x1.localdomain>
References: <20190208134950.187665-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Content-Disposition: inline
In-Reply-To: <20190208134950.187665-1-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 0/6] virtio-blk: add
 DISCARD and WRITE_ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 02:49:44PM +0100, Stefano Garzarella wrote:
> This series adds the support of DISCARD and WRITE_ZEROES commands
> and extends the virtio-blk-test to test WRITE_ZEROES command when
> the feature is enabled.
>=20
> v4:
> - fixed error with mingw compiler in patch 4
>   gcc and clang want %lu, but mingw wants %llu for BDRV_REQUEST_MAX_SECTO=
RS.
>   Since is less than INT_MAX, I casted it to integer and I used %d in the
>   format string of error_setg. (mingw now is happy)
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
>  hw/block/virtio-blk.c          | 214 +++++++++++++++++++++++++++++++--
>  hw/core/machine.c              |   2 +
>  include/hw/virtio/virtio-blk.h |   5 +-
>  tests/virtio-blk-test.c        |  75 +++++++++++-
>  4 files changed, 282 insertions(+), 14 deletions(-)
>=20
> --=20
> 2.20.1
>=20
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcYPdOAAoJEJykq7OBq3PINnwH/R4XZi7A0ZZvOyl6RL6Cc5cZ
NO+cMd6gg5gmpLgZsMnu5DHgvlP2WmQLN6hSu//d8hD8S2l0yNbcGFTSZ1+JGqUW
IhNimbea3wenswX70wm32BYsiBSDywPmL2wRbPqs9aO7J9msZOUTwWs6dAkimxHK
lWrpkeQ1U90WZ27s0yBGXrY8HYWIYslf6gKXGJrQZ375MUs5NFhIRFQP8AlcbrXO
JyYndwP0ZiCq2ZNquYlJuD5OdrZuGVEx5mcNS3AOB9WtZW/CaWvpYuE4YnShbZ8a
GUh4OenTptxBzc+Q6DxRpO1nz4qUNji0MT/D1HinwjO45UQkww04VF0Xc4fAupQ=
=bkZ3
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--
