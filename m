Received: from eggs.gnu.org ([2001:4830:134:3::10]:57798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dunR6-00013r-Fu
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 18:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dunR3-0005Le-0W
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 18:25:40 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:50085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dunR2-0005Dq-R7
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 18:25:36 -0400
Received: from player687.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 91B9C72610
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 00:25:34 +0200 (CEST)
Date: Thu, 21 Sep 2017 00:25:24 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170921002524.29fc0e49@bahia.lan>
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/12] Patch Round-up for stable 2.10.1,
 freeze on 2017-09-27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Tue, 19 Sep 2017 19:45:09 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Hi everyone,
>=20
> The following new patches are queued for QEMU stable v2.10.1:
>=20
>   https://github.com/mdroth/qemu/commits/stable-2.10-staging
>=20
> The release is planned for 2017-10-02:
>=20
>   https://wiki.qemu.org/Planning/2.10
>=20
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
>=20

Hi Michael,

I'd like to suggest these patches that fix regressions introduced in 2.10:

6069537f4336a59054afda91a6545d3648c64619
"9pfs: fix readdir() for 9p2000.u"

4d8bc7334b06ef01a21cad3d1eb8dc183037a06b
"9pfs: fix name_to_path assertion in v9fs_complete_rename()"

772a73692ecb52bace0cff6f95df62f59b8cabe0
"9pfs: check the size of transport buffer before marshaling"

Cheers,

--
Greg

> Testing/feedback is greatly appreciated.
>=20
> Thanks!
>=20
> ----------------------------------------------------------------
> Alex Williamson (1):
>       vhost: Release memory references on cleanup
>=20
> Farhan Ali (1):
>       s390-ccw: Fix alignment for CCW1
>=20
> Greg Kurz (1):
>       virtfs: error out gracefully when mandatory suboptions are missing
>=20
> Hannes Reinecke (1):
>       scsi-bus: correct responses for INQUIRY and REQUEST SENSE
>=20
> Marc-Andr=C3=A9 Lureau (2):
>       libvhost-user: support resuming vq->last_avail_idx based on used_idx
>       vhost-user-bridge: fix resume regression (since 2.9)
>=20
> Pavel Butsykin (1):
>       qcow2: move qcow2_store_persistent_dirty_bitmaps() before cache flu=
shing
>=20
> Peter Maydell (1):
>       mps2-an511: Fix wiring of UART overflow interrupt lines
>=20
> Pranith Kumar (1):
>       arm_gicv3_kvm: Fix compile warning
>=20
> Richard Henderson (1):
>       target/arm: Fix aa64 ldp register writeback
>=20
> Samuel Thibault (1):
>       slirp: fix clearing ifq_so from pending packets
>=20
> Thomas Huth (1):
>       hw/arm/allwinner-a10: Mark the allwinner-a10 device with user_creat=
able =3D false
>=20
>  block/qcow2.c                         | 16 +++++++-------
>  contrib/libvhost-user/libvhost-user.c | 13 ++++++++++++
>  contrib/libvhost-user/libvhost-user.h |  7 +++++++
>  hw/arm/allwinner-a10.c                |  2 ++
>  hw/arm/mps2.c                         |  4 ++--
>  hw/intc/arm_gicv3_kvm.c               |  2 +-
>  hw/scsi/scsi-bus.c                    | 29 ++++++++++++++++++++++----
>  hw/virtio/vhost.c                     |  4 ++++
>  pc-bios/s390-ccw/cio.h                |  2 +-
>  scripts/device-crash-test             |  1 -
>  slirp/socket.c                        | 39 +++++++++++++++++++++--------=
------
>  target/arm/translate-a64.c            | 29 +++++++++++++++-----------
>  tests/vhost-user-bridge.c             |  7 +++++++
>  vl.c                                  | 16 ++++++++------
>  14 files changed, 120 insertions(+), 51 deletions(-)
>=20
>=20
>=20



--=20
Gregory Kurz                                     kurzgreg@fr.ibm.com
                                                 gkurz@linux.vnet.ibm.com
Software Engineer @ IBM/LTC                      http://www.ibm.com
Tel 33-5-6218-1607

"Anarchy is about taking complete responsibility for yourself."
        Alan Moore.
