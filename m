Received: from eggs.gnu.org ([2001:4830:134:3::10]:38760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdMO-0005hu-CV
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdMK-0003Rg-Df
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:22:40 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFdMK-0003RL-3M
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:22:36 -0400
Received: by mail-wm0-x243.google.com with SMTP id k15so23726980wmh.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 02:22:36 -0700 (PDT)
Date: Tue, 30 May 2017 10:22:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530092232.GG11362@stefanha-x1.localdomain>
References: <20170526143826.27780-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KIzF6Cje4W/osXrF"
Content-Disposition: inline
In-Reply-To: <20170526143826.27780-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PULL v3 00/22] Misc patches for 2017-05-19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


--KIzF6Cje4W/osXrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 04:38:23PM +0200, Paolo Bonzini wrote:
> The following changes since commit 56821559f0ba682fe6b367815572e6f974d329=
ab:
>=20
>   Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into sta=
ging (2017-05-18 13:36:15 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/bonzini/qemu.git tags/for-upstream
>=20
> for you to fetch changes up to 7860f87b6523324bd35ee5e25f698bf0d779e767:
>=20
>   sockets: improve error reporting if UNIX socket path is too long (2017-=
05-26 13:22:52 +0200)
>=20
> ----------------------------------------------------------------
> * virtio-scsi use-after-free fix (Fam)
> * vhost-user-scsi support (Felipe)
> * SMM fixes and improvements for TCG (myself, Mihail)
> * irqchip and AddressSpaceDispatch cleanups and fixes (Peter)
> * Coverity fix (Stefano)
> * NBD cleanups (Vladimir)
> * RTC accuracy improvements and code cleanups (Guangrong+Yunfang)
> * socket error reporting improvement (Daniel)
>=20
> ----------------------------------------------------------------
>=20
> v2->v3: replaced one NBD patch, added the last two
>=20
> Daniel P. Berrange (1):
>       sockets: improve error reporting if UNIX socket path is too long
>=20
> Fam Zheng (1):
>       virtio-scsi: Unset hotplug handler when unrealize
>=20
> Felipe Franciosi (2):
>       vhost-user-scsi: Introduce vhost-user-scsi host device
>       vhost-user-scsi: Introduce a vhost-user-scsi sample application
>=20
> Mihail Abakumov (1):
>       i386: fix read/write cr with icount option
>=20
> Paolo Bonzini (2):
>       target/i386: enable A20 automatically in system management mode
>       target/i386: use multiple CPU AddressSpaces
>=20
> Peter Xu (4):
>       kvm: irqchip: trace changes on msi add/remove
>       msix: trace control bit write op
>       kvm: irqchip: skip update msi when disabled
>       exec: simplify phys_page_find() params
>=20
> Stefano Stabellini (1):
>       Check the return value of fcntl in qemu_set_cloexec
>=20
> Tai Yunfang (1):
>       mc146818rtc: precisely count the clock for periodic timer
>=20
> Vladimir Sementsov-Ogievskiy (5):
>       nbd: strict nbd_wr_syncv
>       nbd: read_sync and friends: return 0 on success
>       nbd: add errp parameter to nbd_wr_syncv()
>       nbd: add errp to read_sync, write_sync and drop_sync
>       nbd/client.c: use errp instead of LOG
>=20
> Xiao Guangrong (4):
>       mc146818rtc: update periodic timer only if it is needed
>       mc146818rtc: ensure LOST_TICK_POLICY_SLEW is only enabled on TARGET=
_I386
>       mc146818rtc: drop unnecessary '#ifdef TARGET_I386'
>       mc146818rtc: embrace all x86 specific code
>=20
>  .gitignore                                |   1 +
>  Makefile                                  |   3 +
>  Makefile.objs                             |   4 +
>  block/nbd-client.c                        |  11 +-
>  contrib/libvhost-user/libvhost-user.h     |  11 +-
>  contrib/vhost-user-scsi/Makefile.objs     |   1 +
>  contrib/vhost-user-scsi/vhost-user-scsi.c | 886 ++++++++++++++++++++++++=
++++++
>  default-configs/pci.mak                   |   1 +
>  default-configs/s390x-softmmu.mak         |   1 +
>  exec.c                                    |  13 +-
>  hw/pci/msix.c                             |  11 +-
>  hw/pci/trace-events                       |   3 +
>  hw/scsi/Makefile.objs                     |   1 +
>  hw/scsi/vhost-user-scsi.c                 | 211 +++++++
>  hw/scsi/virtio-scsi.c                     |   3 +
>  hw/timer/mc146818rtc.c                    | 206 ++++---
>  hw/virtio/virtio-pci.c                    |  54 ++
>  hw/virtio/virtio-pci.h                    |  11 +
>  include/block/nbd.h                       |   8 +-
>  include/hw/virtio/vhost-user-scsi.h       |  35 ++
>  include/hw/virtio/virtio-scsi.h           |   2 +
>  kvm-all.c                                 |   4 +-
>  nbd/client.c                              | 125 ++---
>  nbd/common.c                              |  23 +-
>  nbd/nbd-internal.h                        |  40 +-
>  nbd/server.c                              |  92 ++--
>  qemu-nbd.c                                |   3 +-
>  target/i386/arch_memory_mapping.c         |  18 +-
>  target/i386/cpu.c                         |  15 +-
>  target/i386/cpu.h                         |  20 +-
>  target/i386/helper.c                      |  96 ++--
>  target/i386/kvm.c                         |  12 +-
>  target/i386/machine.c                     |   4 -
>  target/i386/smm_helper.c                  |  18 -
>  target/i386/translate.c                   |  12 +
>  tests/qemu-iotests/083.out                |   2 +
>  trace-events                              |   3 +-
>  util/oslib-posix.c                        |   4 +-
>  util/qemu-sockets.c                       |  68 ++-
>  39 files changed, 1703 insertions(+), 333 deletions(-)
>  create mode 100644 contrib/vhost-user-scsi/Makefile.objs
>  create mode 100644 contrib/vhost-user-scsi/vhost-user-scsi.c
>  create mode 100644 hw/scsi/vhost-user-scsi.c
>  create mode 100644 include/hw/virtio/vhost-user-scsi.h
> --=20
> 2.13.0
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--KIzF6Cje4W/osXrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLTnYAAoJEJykq7OBq3PI76MH/1j+6ln2iO7+uEDKPqQPzRRC
EQtb0CUEA0HfshnNsvvMKxKaDoWpVb0/u9pHfoX3KdRxC3JfNLzhOmR5Hn9OFybF
j64Lz3luyFfJraxKq68/pGHAHMRv1IKZpNiFV9KWpcPG055qwKl/yrUh6D+RFQMh
9azEJ0uRu3vgBFEOk15k65j/8jkjKY4EEmD+83HDrrE9ioJ210PjowXUw+zvHXlX
MmN+G//owuk+WdMTHxJrfY5PD+DLpHgPur9adyPvuR8KzMZNLdJRCe/LZWioISNq
Jjat06KcCyLp6ML+mDPc4CGMoo9MAgKAGBYDg2nm7jvh1PFevjRq6j1JfvRl3jE=
=HGNK
-----END PGP SIGNATURE-----

--KIzF6Cje4W/osXrF--
