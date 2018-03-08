Received: from eggs.gnu.org ([2001:4830:134:3::10]:33821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etzdN-00053U-H3
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:47:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etzdJ-0003Vc-K9
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:47:17 -0500
Date: Thu, 8 Mar 2018 17:47:10 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180308174710.GI2769@stefanha-x1.localdomain>
References: <20180307144205.20619-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3eH4Qcq5fItR5cpy"
Content-Disposition: inline
In-Reply-To: <20180307144205.20619-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/4] vl: introduce
 vm_shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


--3eH4Qcq5fItR5cpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 02:42:01PM +0000, Stefan Hajnoczi wrote:
> v3:
>  * Rebase on qemu.git/master after AIO_WAIT_WHILE() was merged [Fam]
> v2:
>  * Tackle the .ioeventfd_stop() vs vq handler race by removing the ioeven=
tfd
>    from a BH in the IOThread [Fam]
>=20
> There are several race conditions in virtio-blk/virtio-scsi dataplane cod=
e.
> This patch series addresses them, see the commit description for details =
on the
> individual cases.
>=20
> Stefan Hajnoczi (4):
>   block: add aio_wait_bh_oneshot()
>   virtio-blk: fix race between .ioeventfd_stop() and vq handler
>   virtio-scsi: fix race between .ioeventfd_stop() and vq handler
>   vl: introduce vm_shutdown()
>=20
>  include/block/aio-wait.h        | 13 +++++++++++++
>  include/sysemu/iothread.h       |  1 -
>  include/sysemu/sysemu.h         |  1 +
>  cpus.c                          | 16 +++++++++++++---
>  hw/block/dataplane/virtio-blk.c | 24 +++++++++++++++++-------
>  hw/scsi/virtio-scsi-dataplane.c |  9 +++++----
>  iothread.c                      | 31 -------------------------------
>  util/aio-wait.c                 | 31 +++++++++++++++++++++++++++++++
>  vl.c                            | 13 +++----------
>  9 files changed, 83 insertions(+), 56 deletions(-)
>=20
> --=20
> 2.14.3
>=20
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--3eH4Qcq5fItR5cpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaoXceAAoJEJykq7OBq3PIjDsH/AsZb/1p+05Qc0g3rNTAu6jS
EXJggEGrkO/qQuCWQ3kn5WCPdHeM3cr2aF6ekq+7QHDcBV/61NTjZAOkTP6LJKz3
S8pCKnaUO/tcpeRnyYlbg1stuLHP169962oFsUBKvR9fMN/2xSdN9dmMsm2uOwpq
7UEAy6ObjwO+eQE2cM3734jq2waRI+/KWotiP7q8IY/7py/kksYSeJU+28kx/csz
xi6nV1h6XphakBBRMSZGA5g3a5I1lF9Z7HTNXTgMMS5F26jRnfVXtnQ6N6ufTnU9
F2Yvw9dN3Bxnv1zsWqp6Bnz0BFMTJIDu3oXh7P8PEKonvVD6zth6gcHLz5oFymI=
=UYQu
-----END PGP SIGNATURE-----

--3eH4Qcq5fItR5cpy--
