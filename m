Received: from eggs.gnu.org ([2001:4830:134:3::10]:52572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYZkF-0006cK-Ss
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYZkC-0006FF-LB
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:21:35 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dYZkC-0006DY-DT
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:21:32 -0400
Received: by mail-wm0-x22b.google.com with SMTP id w191so11124021wmw.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 08:21:32 -0700 (PDT)
Date: Fri, 21 Jul 2017 16:21:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170721152129.GJ18014@stefanha-x1.localdomain>
References: <20170717081152.17153-1-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fU0UwhtRbpo05rnG"
Content-Disposition: inline
In-Reply-To: <20170717081152.17153-1-lprosek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/9] virtio: enhance virtio_error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com


--fU0UwhtRbpo05rnG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2017 at 10:11:43AM +0200, Ladi Prosek wrote:
> Output like "Virtqueue size exceeded" is not much useful in identifying t=
he
> culprit. This series beefs up virtio_error to print the virtio device name
> and id, and introduces virtqueue_error which additionally includes the in=
dex
> of the virtqueue where the error occured.
>=20
> Patches 1 to 3 lay the groundwork, patches 4 to 8 convert virtio devices =
to
> use virtqueue_error instead of virtio_error. Patch 9 adds virtio_error and
> virtqueue_error to the list of error funcs in checkpatch.pl.
>=20
> v1->v2:
> * Modified virtio_error and added virtqueue_error (Stefan)
> * Now also printing device id (Stefan)
> * Went over all virtio_error call sites and converted them to virtqueue_e=
rror
>   as appropriate; added virtio device maintainers to cc
>=20
> v2->v3:
> * Removed patch 1 (Stefan, Markus)
> * Split patch 3 into 2 (adds virtqueue_error) and 3 (makes virtio.c call =
it)
>   (Cornelia)
> * Added patch 9 to modify $qemu_error_funcs in checkpatch.pl (Greg)
> * s/includes queue index/includes the queue index/ in patch 3-9 commit
>   messages (Cornelia)
> * Fixed virtio_get_device_id to return empty string instead of NULL if the
>   device doesn't have an id (Stefan)
> * Simplified the change in virtio-crypto.c to use vcrypto->ctrl_vq instead
>   of propagating the vq pointer in function arguments (Cornelia, Gonglei)
>=20
> Ladi Prosek (9):
>   virtio: enhance virtio_error messages
>   virtio: introduce virtqueue_error
>   virtio: use virtqueue_error for errors with queue context
>   virtio-9p: use virtqueue_error for errors with queue context
>   virtio-blk: use virtqueue_error for errors with queue context
>   virtio-net: use virtqueue_error for errors with queue context
>   virtio-scsi: use virtqueue_error for errors with queue context
>   virtio-crypto: use virtqueue_error for errors with queue context
>   checkpatch: add virtio_error and virtqueue_error to error funcs
>=20
>  hw/9pfs/virtio-9p-device.c |  37 ++++++--------
>  hw/block/virtio-blk.c      |   6 +--
>  hw/net/virtio-net.c        |  24 ++++-----
>  hw/scsi/virtio-scsi.c      |   2 +-
>  hw/virtio/virtio-crypto.c  |  49 ++++++++++---------
>  hw/virtio/virtio.c         | 119 +++++++++++++++++++++++++++++++--------=
------
>  include/hw/virtio/virtio.h |   1 +
>  scripts/checkpatch.pl      |   4 +-
>  8 files changed, 143 insertions(+), 99 deletions(-)

Looks good.  QEMU is currently in freeze for the 2.10 release.  You may
need to resend so Michael Tsirkin can merge it after the release, or if
he maintainers a -next branch he could merge it right away.

Stefan

--fU0UwhtRbpo05rnG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZchv5AAoJEJykq7OBq3PIieQH/3rxkwL6/5atjjA2QeP1ndX/
tRH0pJWTZP2BeI19b3HVJ9h0b7Bz3eG+bZOA+vuj1hDKi3XIusA70KlAee/VxtRf
I8lP3eJBQ1dPOdajdDpIJ/wI8Kbpizjact8BxDz1tfXbWh/qkIeddUNH4/yfItQm
21RbgLImZfG2F4YzdRVFG+8bCrDxlQht7YW636aolxQVICL+dRDihhXvZ3N+9lVy
tMaT+T1pg04zgeo4WowEhK6c26+TAAHOit0enxp8saXMU/J14YyxabF719sXg6lU
y9w4bzSyzEZsRBv8NDy0aVbnY5KbezfN2lZYEVFXfHfzQp3ULjSf/zaHtOEL46o=
=KNoX
-----END PGP SIGNATURE-----

--fU0UwhtRbpo05rnG--
