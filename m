Received: from eggs.gnu.org ([2001:4830:134:3::10]:33847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP4BZ-0004h6-0F
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP4BU-0002AG-1a
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:22:44 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eP4BT-00029t-Pj
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:22:39 -0500
Received: by mail-wr0-x244.google.com with SMTP id h1so1598076wre.12
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 02:22:39 -0800 (PST)
Date: Wed, 13 Dec 2017 10:22:36 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171213102236.GD16782@stefanha-x1.localdomain>
References: <1513132143-10758-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
In-Reply-To: <1513132143-10758-1-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/4] Introduce a new vhost-user-blk host
 device to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 10:28:59AM +0800, Changpeng Liu wrote:
> Although virtio scsi specification was designed as a replacement for virt=
io_blk,
> there are still many users using virtio_blk. QEMU 2.9 introduced a new de=
vice
> vhost user scsi which can process I/O in user space for virtio_scsi, this=
 commit
> introduces a new vhost user block host device, which can support virtio_b=
lk in
> Guest OS, and I/O processing in another I/O target.
>=20
> Due to the limitation for virtio_blk specification, virtio_blk device can=
not get
> block information such as capacity, block size etc via the specification,=
 several
> new vhost user messages were added to deliver virtio config space
> information between Qemu and I/O target, VHOST_USER_GET_CONFIG/VHOST_USER=
_SET_CONFIG
> messages used for get/set config space from/to I/O target, VHOST_USER_SET=
_CONFIG_FD
> was added for event notifier in case the change of virtio config space. A=
lso, those
> messages can be used for vhost device live migration as well.
>=20
> Changes:
> v6-v7: change the parameter of set configuration function let it only con=
tain
> valid data buffer.
> v5-v6: add header flags for vhost-user master so that the slave can know =
the
> purpose for set config, also vhost-user get/set messages' payload doesn't
> contain invalid data buffers.
> v4-v5: add header offset and size for virtio config space.
> v3-v4: refactoring the vhost user block example patch based on new libvho=
st-user library.
> v2-v3: add new vhost user message to get/set virtio config space.
>=20
> Changpeng Liu (4):
>   vhost-user: add new vhost user messages to support virtio config space
>   vhost-user-blk: introduce a new vhost-user-blk host device
>   contrib/libvhost-user: enable virtio config space messages
>   contrib/vhost-user-blk: introduce a vhost-user-blk sample application
>=20
>  .gitignore                              |   1 +
>  Makefile                                |   3 +
>  Makefile.objs                           |   1 +
>  contrib/libvhost-user/libvhost-user.c   |  80 +++++
>  contrib/libvhost-user/libvhost-user.h   |  36 ++-
>  contrib/vhost-user-blk/Makefile.objs    |   1 +
>  contrib/vhost-user-blk/vhost-user-blk.c | 550 ++++++++++++++++++++++++++=
++++++
>  default-configs/pci.mak                 |   1 +
>  docs/interop/vhost-user.txt             |  45 +++
>  hw/block/Makefile.objs                  |   3 +
>  hw/block/vhost-user-blk.c               | 357 +++++++++++++++++++++
>  hw/virtio/vhost-user.c                  | 107 +++++++
>  hw/virtio/vhost.c                       |  64 ++++
>  hw/virtio/virtio-pci.c                  |  55 ++++
>  hw/virtio/virtio-pci.h                  |  18 ++
>  include/hw/virtio/vhost-backend.h       |  14 +
>  include/hw/virtio/vhost-user-blk.h      |  41 +++
>  include/hw/virtio/vhost.h               |  16 +
>  18 files changed, 1392 insertions(+), 1 deletion(-)
>  create mode 100644 contrib/vhost-user-blk/Makefile.objs
>  create mode 100644 contrib/vhost-user-blk/vhost-user-blk.c
>  create mode 100644 hw/block/vhost-user-blk.c
>  create mode 100644 include/hw/virtio/vhost-user-blk.h
>=20
> --=20
> 1.9.3
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMP9sAAoJEJykq7OBq3PItWEH/jhPKWvCrAORVw8pms+xNW4Y
eGm5R0aso+O2W+gdMNa/KvtXyVvSXUdfQtG5XXZMbHXwCFzkU7BYo82HmKL09ur9
NRyyDZkKms5+/hMenQi+WMOu7eLhyVCe1WLtJV6HT/cfXfxnPu7D8+D8oA1i20no
e9pI/MBDOEq5iD0KLOgKTZpfEHHTvQNccnDSWjvwSKWUWe5E78Qpi1wRKNeES4xs
/Te7ov32Senj0Aj5fJb7VWpFUYDLd/VBg0n05clHoKogrFprhzM7xSURyRwzVDHJ
vAiFcnFHqafZxvqkTvc1B1+Fq5672agF9i+MwBvpH5Dd+hOhCneYeHAmz8KIIk8=
=/bRA
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
