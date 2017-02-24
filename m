Received: from eggs.gnu.org ([2001:4830:134:3::10]:32901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chGCT-0006mV-T6
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chGCS-0002FH-Vt
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:46:21 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-30-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6f2ae71a-bac2-3332-a716-21b344f540d6@redhat.com>
Date: Fri, 24 Feb 2017 14:46:12 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-30-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="97kurrmev1B83PgEx8I5hR1JRMXkwFn4O"
Subject: Re: [Qemu-devel] [PATCH 29/54] hw/block: Request permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--97kurrmev1B83PgEx8I5hR1JRMXkwFn4O
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <6f2ae71a-bac2-3332-a716-21b344f540d6@redhat.com>
Subject: Re: [PATCH 29/54] hw/block: Request permissions
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-30-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-30-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> This makes all device emulations with a qdev drive property request
> permissions on their BlockBackend. The only thing we block at this poin=
t
> is resizing images for some devices that can't support it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/block/block.c                 | 22 +++++++++++++++++++++-
>  hw/block/fdc.c                   | 25 +++++++++++++++++++++++--
>  hw/block/m25p80.c                |  8 ++++++++
>  hw/block/nand.c                  |  7 +++++++
>  hw/block/nvme.c                  |  8 +++++++-
>  hw/block/onenand.c               |  7 +++++++
>  hw/block/pflash_cfi01.c          | 18 ++++++++++++------
>  hw/block/pflash_cfi02.c          | 19 +++++++++++++------
>  hw/block/virtio-blk.c            |  8 +++++++-
>  hw/core/qdev-properties-system.c |  1 -
>  hw/ide/qdev.c                    |  7 +++++--
>  hw/nvram/spapr_nvram.c           |  8 ++++++++
>  hw/scsi/scsi-disk.c              |  9 +++++++--
>  hw/sd/sd.c                       |  6 ++++++
>  hw/usb/dev-storage.c             |  6 +++++-
>  include/hw/block/block.h         |  3 ++-
>  tests/qemu-iotests/051.pc.out    |  6 +++---
>  17 files changed, 141 insertions(+), 27 deletions(-)

For all the SCSI disks, shouldn't @resizable be true only if the qdev
type is TYPE_DISK? At least hw/scsi/scsi-disk.c:scsi_realize() looks as
if that is not necessarily the case.

OTOH, I'm not sure how useful the condition in scsi_disk_resize_cb() is
in the first place. In my understanding, the SCSI device should always
be of TYPE_DISK there.

And for IDE devices, @resizable should be true only if the device is not
a CD ROM drive.

Max


--97kurrmev1B83PgEx8I5hR1JRMXkwFn4O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliwOSQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AwOMH/je27dD7F7MdPD6+1wvgU+5HCykzPU3F
3dqMZUNUIXiWBh6oHQV7DRmpNaJ9REHqo5tUgHbBWwVSU31HGNM37MKPQdLECGVw
iH2nKkXct4UtYdr/4+541a2VZ2oRteFqAjE3neL7iPxK7BQSlf9M/ERR+4HQpVGF
uOJU+BJ83lbsnQOiSLqDzU05UVFGzGeNKa4bsSGOSjMSzeenZvqzCperb0vT/PJE
bXzEVVKWNPICtn/zOwQbzdRJ1vlWgXfOjutQoUc9U/6iZYKRb16U/5VTYgHDjP6x
lzLVE8wSypKzzUA4ZQ/KNPGlwU7/gvaBk6X4ZJZEqoB8L2zvPcOQeZM=
=0TbU
-----END PGP SIGNATURE-----

--97kurrmev1B83PgEx8I5hR1JRMXkwFn4O--
