Received: from eggs.gnu.org ([2001:4830:134:3::10]:44285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqGtl-0006Cw-FR
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqGtg-0007fh-S5
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:20:17 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:42124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cqGtg-0007dD-Lo
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:20:12 -0400
Received: from player695.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id DFBA0E127F
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 11:20:09 +0100 (CET)
Date: Tue, 21 Mar 2017 11:20:00 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170321112000.56a9737f@bahia.lan>
In-Reply-To: <alpine.DEB.2.10.1703201117560.23684@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1703201117560.23684@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/TwHqMk6lxnKgiP=w/4N=4ca";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4 0/8] xen/9pfs: introduce the Xen 9pfs
 backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, jgross@suse.com, aneesh.kumar@linux.vnet.ibm.com

--Sig_/TwHqMk6lxnKgiP=w/4N=4ca
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Mar 2017 11:18:46 -0700 (PDT)
Stefano Stabellini <sstabellini@kernel.org> wrote:

> Hi all,
>=20
> This patch series implements a new transport for 9pfs, aimed at Xen
> systems.
>=20
> The transport is based on a traditional Xen frontend and backend drivers
> pair. This patch series implements the backend, which typically runs in
> Dom0. I sent another series to implement the frontend in Linux
> (http://marc.info/?l=3Dlinux-kernel&m=3D148883047125960&w=3D2).
>=20
> The backend complies to the Xen transport for 9pfs specification
> version 1, available here:
>=20
> https://xenbits.xen.org/docs/unstable/misc/9pfs.html
>=20
>=20
> Changes in v4:
> - add reviewed-bys
> - remove useless if(NULL) checks around g_free
> - g_free g_malloc'ed sgs
> - remove XEN_9PFS_RING_ORDER, make the ring order dynamic per ring,
>   reading the ring_order field in xen_9pfs_data_intf
> - remove patch not to build Xen backends on non-Xen capable targets
>   because it is already upstream
>=20

Hi Stefano,

This looks good to me. Do you want these patches to go through my 9p
tree or through your xen tree ? Also, I guess you may want to add
F: hw/9pfs/xen-9p-backend.c to the Xen section in MAINTAINERS.

Cheers,

--
Greg

> Changes in v3:
> - do not build backends for targets that do not support xen
> - remove xen_9pfs.h, merge its content into xen-9p-backend.c
> - remove xen_9pfs_header, introduce P9MsgHeader
> - use le32_to_cpu to access P9MsgHeader fields
> - many coding style fixes
> - run checkpatch on all patches
> - add check if num_rings < 1
> - use g_strdup_printf
> - free fsdev_id in xen_9pfs_free
> - add comments
>=20
> Changes in v2:
> - fix coding style
> - compile xen-9p-backend.c if CONFIG_XEN_BACKEND
> - add patch to set CONFIG_XEN_BACKEND only for the right targets
> - add review-bys
>=20
>=20
> Stefano Stabellini (8):
>       xen: import ring.h from xen
>       9p: introduce a type for the 9p header
>       xen/9pfs: introduce Xen 9pfs backend
>       xen/9pfs: connect to the frontend
>       xen/9pfs: receive requests from the frontend
>       xen/9pfs: implement in/out_iov_from_pdu and vmarshal/vunmarshal
>       xen/9pfs: send responses back to the frontend
>       xen/9pfs: build and register Xen 9pfs backend
>=20
>  hw/9pfs/9p.h                 |   6 +
>  hw/9pfs/Makefile.objs        |   1 +
>  hw/9pfs/virtio-9p-device.c   |   6 +-
>  hw/9pfs/xen-9p-backend.c     | 444 +++++++++++++++++++++++++++++++++++++=
++++
>  hw/block/xen_blkif.h         |   2 +-
>  hw/usb/xen-usb.c             |   2 +-
>  hw/xen/xen_backend.c         |   3 +
>  include/hw/xen/io/ring.h     | 455 +++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/xen/xen_backend.h |   3 +
>  9 files changed, 915 insertions(+), 7 deletions(-)
>  create mode 100644 hw/9pfs/xen-9p-backend.c
>  create mode 100644 include/hw/xen/io/ring.h


--Sig_/TwHqMk6lxnKgiP=w/4N=4ca
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljQ/lAACgkQAvw66wEB28KGsACghJJAdV3Qkst6THI+axsOwCiZ
OhQAoJNo/W/VyzJR3IncqZxL8YyVaCe8
=IGfJ
-----END PGP SIGNATURE-----

--Sig_/TwHqMk6lxnKgiP=w/4N=4ca--
