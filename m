Received: from eggs.gnu.org ([2001:4830:134:3::10]:55816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVfEL-0002fZ-0P
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVfEH-0001PV-0S
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:36:37 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:42493)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dVfEG-0001ON-PT
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:36:32 -0400
Received: from player796.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 27A7F9DA35
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 16:36:31 +0200 (CEST)
Date: Thu, 13 Jul 2017 16:36:20 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170713163620.48c6a93c@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170713110237.6712-1-lprosek@redhat.com>
References: <20170713110237.6712-1-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/PUpOc2aDCkRR6XXhYadEYHO";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 0/8] virtio: enhance virtio_error
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
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com, stefanha@redhat.com

--Sig_/PUpOc2aDCkRR6XXhYadEYHO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Jul 2017 13:02:29 +0200
Ladi Prosek <lprosek@redhat.com> wrote:

> Output like "Virtqueue size exceeded" is not much useful in identifying t=
he
> culprit. This series beefs up virtio_error to print the virtio device name
> and id, and introduces virtqueue_error which additionally includes the in=
dex
> of the virtqueue where the error occured.
>=20
> Patches 1 to 3 lay the groundwork, patches 4 to 8 convert virtio devices =
to
> use virtqueue_error instead of virtio_error.
>=20
> v1->v2:
> * Modified virtio_error and added virtqueue_error (Stefan)
> * Now also printing device id (Stefan)
> * Went over all virtio_error call sites and converted them to virtqueue_e=
rror
>   as appropriate; added virtio device maintainers to cc
>=20
> Ladi Prosek (8):
>   qemu-error: introduce error_report_nolf
>   virtio: enhance virtio_error messages
>   virtio: introduce virtqueue_error
>   virtio-9p: use virtqueue_error for errors with queue context
>   virtio-blk: use virtqueue_error for errors with queue context
>   virtio-net: use virtqueue_error for errors with queue context
>   virtio-scsi: use virtqueue_error for errors with queue context
>   virtio-crypto: use virtqueue_error for errors with queue context
>=20

While here, maybe you can add all the virtio_error related functions to the
$qemu_error_funcs variable in scripts/checkpatch.pl ?

Cheers,

--
Greg

>  hw/9pfs/virtio-9p-device.c  |  37 ++++++--------
>  hw/block/virtio-blk.c       |   6 +--
>  hw/net/virtio-net.c         |  24 ++++-----
>  hw/scsi/virtio-scsi.c       |   2 +-
>  hw/virtio/virtio-crypto.c   |  56 ++++++++++-----------
>  hw/virtio/virtio.c          | 116 ++++++++++++++++++++++++++++++--------=
------
>  include/hw/virtio/virtio.h  |   1 +
>  include/qemu/error-report.h |   3 +-
>  util/qemu-error.c           |  32 +++++++++---
>  9 files changed, 169 insertions(+), 108 deletions(-)
>=20


--Sig_/PUpOc2aDCkRR6XXhYadEYHO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllnhWQACgkQAvw66wEB28J0zACfU+Mp54iuc0ruebOnNDhGnu02
vnUAmgJYpVgMX7UrfcgRbSFIYMWCOPFk
=fzi/
-----END PGP SIGNATURE-----

--Sig_/PUpOc2aDCkRR6XXhYadEYHO--
