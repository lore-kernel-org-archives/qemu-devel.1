Received: from eggs.gnu.org ([2001:4830:134:3::10]:51018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dDVrK-0008U6-AJ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 08:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dDVrH-0007ag-8T
	for qemu-devel@nongnu.org; Wed, 24 May 2017 08:57:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dDVrG-0007Yn-Uc
	for qemu-devel@nongnu.org; Wed, 24 May 2017 08:57:47 -0400
Date: Wed, 24 May 2017 13:57:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170524125723.GD11609@stefanha-x1.localdomain>
References: <20170523111306.25493-1-cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline
In-Reply-To: <20170523111306.25493-1-cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL 00/21] s390x patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: peter.maydell@linaro.org, borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2017 at 01:12:45PM +0200, Cornelia Huck wrote:
> The following changes since commit 56821559f0ba682fe6b367815572e6f974d329=
ab:
>=20
>   Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into sta=
ging (2017-05-18 13:36:15 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/cohuck/qemu tags/s390x-20170523
>=20
> for you to fetch changes up to cb4f4bc3535f554daa3266aaa447843949a68193:
>=20
>   s390/kvm: do not reset riccb on initial cpu reset (2017-05-19 12:31:28 =
+0200)
>=20
> ----------------------------------------------------------------
> s390x updates:
> - support for vfio-ccw to passthrough channel devices
> - allow ccw bios to boot from scsi generic devices
> - bugfix for initial reset
>=20
> ----------------------------------------------------------------
>=20
> Christian Borntraeger (1):
>   s390/kvm: do not reset riccb on initial cpu reset
>=20
> Cornelia Huck (1):
>   linux-headers: update
>=20
> Dong Jia Shi (6):
>   s390x/css: realize css_create_sch
>   s390x/css: device support for s390-ccw passthrough
>   vfio/ccw: get io region info
>   vfio/ccw: get irqs info and set the eventfd fd
>   vfio/ccw: update sense data if a unit check is pending
>   MAINTAINERS: Add vfio-ccw maintainer
>=20
> Eric Farman (8):
>   pc-bios/s390-ccw: Remove duplicate blk_factor adjustment
>   pc-bios/s390-ccw: Move SCSI block factor to outer read
>   pc-bios/s390-ccw: Break up virtio-scsi read into multiples
>   pc-bios/s390-ccw: Refactor scsi_inquiry function
>   pc-bios/s390-ccw: Get list of supported VPD pages
>   pc-bios/s390-ccw: Get Block Limits VPD device data
>   pc-bios/s390-ccw: Build a reasonable max_sectors limit
>   pc-bios/s390-ccw.img: rebuild image
>=20
> Xiao Feng Ren (5):
>   s390x/css: add s390-squash-mcss machine option
>   s390x/css: realize css_sch_build_schib
>   vfio/ccw: vfio based subchannel passthrough driver
>   s390x/css: introduce and realize ccw-request callback
>   s390x/css: ccw translation infrastructure
>=20
>  MAINTAINERS                                        |   8 +
>  default-configs/s390x-softmmu.mak                  |   1 +
>  hw/s390x/3270-ccw.c                                |   6 +-
>  hw/s390x/Makefile.objs                             |   1 +
>  hw/s390x/css-bridge.c                              |   2 +
>  hw/s390x/css.c                                     | 290 +++++++++++++-
>  hw/s390x/s390-ccw.c                                | 153 ++++++++
>  hw/s390x/s390-virtio-ccw.c                         |  32 +-
>  hw/s390x/virtio-ccw.c                              |   7 +-
>  hw/vfio/Makefile.objs                              |   1 +
>  hw/vfio/ccw.c                                      | 434 +++++++++++++++=
++++++
>  include/hw/s390x/css-bridge.h                      |   1 +
>  include/hw/s390x/css.h                             |  67 ++--
>  include/hw/s390x/s390-ccw.h                        |  39 ++
>  include/hw/s390x/s390-virtio-ccw.h                 |   1 +
>  include/hw/vfio/vfio-common.h                      |   1 +
>  include/standard-headers/asm-x86/hyperv.h          |   7 +-
>  include/standard-headers/linux/input-event-codes.h |   1 +
>  include/standard-headers/linux/input.h             |  11 +-
>  include/standard-headers/linux/pci_regs.h          |   3 +-
>  linux-headers/asm-arm/kvm.h                        |  10 +-
>  linux-headers/asm-arm/unistd-common.h              |   1 +
>  linux-headers/asm-arm64/kvm.h                      |  10 +-
>  linux-headers/asm-powerpc/kvm.h                    |   3 +
>  linux-headers/asm-powerpc/unistd.h                 |   1 +
>  linux-headers/asm-s390/kvm.h                       |  29 +-
>  linux-headers/asm-s390/unistd.h                    |   4 +-
>  linux-headers/asm-x86/kvm.h                        |   3 +
>  linux-headers/asm-x86/unistd_32.h                  |   2 +
>  linux-headers/asm-x86/unistd_64.h                  |   1 +
>  linux-headers/asm-x86/unistd_x32.h                 |   1 +
>  linux-headers/linux/kvm.h                          |  25 ++
>  linux-headers/linux/userfaultfd.h                  |  11 +-
>  linux-headers/linux/vfio.h                         |  18 +
>  linux-headers/linux/vfio_ccw.h                     |  24 ++
>  pc-bios/s390-ccw.img                               | Bin 26472 -> 26480 =
bytes
>  pc-bios/s390-ccw/s390-ccw.h                        |   7 +
>  pc-bios/s390-ccw/scsi.h                            |  30 ++
>  pc-bios/s390-ccw/virtio-scsi.c                     |  85 +++-
>  pc-bios/s390-ccw/virtio-scsi.h                     |   2 +
>  pc-bios/s390-ccw/virtio.h                          |   1 +
>  qemu-options.hx                                    |   6 +-
>  scripts/update-linux-headers.sh                    |   2 +-
>  target/s390x/cpu.c                                 |   7 +-
>  target/s390x/cpu.h                                 |  16 +-
>  target/s390x/ioinst.c                              |   9 +
>  46 files changed, 1293 insertions(+), 81 deletions(-)
>  create mode 100644 hw/s390x/s390-ccw.c
>  create mode 100644 hw/vfio/ccw.c
>  create mode 100644 include/hw/s390x/s390-ccw.h
>  create mode 100644 linux-headers/linux/vfio_ccw.h
>=20
> --=20
> 2.13.0
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZJYMzAAoJEJykq7OBq3PITQ0IAJT9IwCBHVUHUCbpBrFGv2P3
+iPnP/uv+b6Q4xxQsclpfGS18m9mLGJZ1BszeWVlYJlBIiJPn7R6Rl7CcfFNZMh8
1ugkXsDdrgBa9G5QZGyG1YE4En27b97Csx61VNRemoc26Ryz+HS/4MEO0STzjmtR
6g2rQwDziUif0z1Nzu4hcN3j6ask89V1Pf2I/kbz42s6bQiapWAVu0pjWGzm1mD7
BOjj1p+Po0jE1ZN6amne2PNGN27nfBuXHnDKiiy4URCXqjsryqgPA8MUPrW210ls
AdqWfYGG9SCNxmx0Be3SoyDkK6IiQu2NNDSmt9cyeVmDOeF2FKI1OKG5P30dJS8=
=5Hzg
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
