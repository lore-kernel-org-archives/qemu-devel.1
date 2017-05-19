Received: from eggs.gnu.org ([2001:4830:134:3::10]:36767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBkAH-0004c8-Rg
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBkAD-0004kH-5l
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:50:05 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dBkAC-0004jy-Q3
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:50:01 -0400
Received: by mail-wm0-x243.google.com with SMTP id k15so17805439wmh.3
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 08:50:00 -0700 (PDT)
Date: Fri, 19 May 2017 16:49:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170519154957.GD30573@stefanha-x1.localdomain>
References: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/20] Misc patches for 2017-05-19
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


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 01:20:52PM +0200, Paolo Bonzini wrote:
> The following changes since commit 56821559f0ba682fe6b367815572e6f974d329=
ab:
>=20
>   Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into sta=
ging (2017-05-18 13:36:15 +0100)
>=20
> are available in the git repository at:
>=20
>=20
>   git://github.com/bonzini/qemu.git tags/for-upstream
>=20
> for you to fetch changes up to e10dc0ca6854c4f47cc5e9d47e20c62aa875f518:
>=20
>   target/i386: use multiple CPU AddressSpaces (2017-05-19 13:01:32 +0200)
>=20
> ----------------------------------------------------------------
> * virtio-scsi use-after-free fix (Fam)
> * vhost-user-scsi support (Felipe)
> * SMM fixes and improvements for TCG (myself)
> * irqchip and AddressSpaceDispatch cleanups and fixes (Peter)
> * Coverity fix (Stefano)
> * NBD cleanups (Vladimir)
> * RTC accuracy improvements and code cleanups (Guangrong+Yunfang)
>=20
> ----------------------------------------------------------------
> Fam Zheng (1):
>       virtio-scsi: Unset hotplug handler when unrealize
>=20
> Felipe Franciosi (2):
>       vhost-user-scsi: Introduce vhost-user-scsi host device
>       vhost-user-scsi: Introduce a vhost-user-scsi sample application
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
>  contrib/vhost-user-scsi/Makefile.objs     |   1 +
>  contrib/vhost-user-scsi/vhost-user-scsi.c | 886 ++++++++++++++++++++++++=
++++++
>  default-configs/pci.mak                   |   1 +
>  default-configs/s390x-softmmu.mak         |   1 +
>  exec.c                                    |  13 +-
>  hw/pci/msix.c                             |  11 +-
>  hw/pci/trace-events                       |   3 +
>  hw/scsi/Makefile.objs                     |   1 +
>  hw/scsi/vhost-user-scsi.c                 | 215 ++++++++
>  hw/scsi/virtio-scsi.c                     |   3 +
>  hw/timer/mc146818rtc.c                    | 206 ++++---
>  hw/virtio/virtio-pci.c                    |  54 ++
>  hw/virtio/virtio-pci.h                    |  11 +
>  include/block/nbd.h                       |   8 +-
>  include/hw/virtio/vhost-user-scsi.h       |  35 ++
>  include/hw/virtio/virtio-scsi.h           |   3 +
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
>  trace-events                              |   3 +-
>  util/oslib-posix.c                        |   4 +-
>  35 files changed, 1642 insertions(+), 306 deletions(-)
>  create mode 100644 contrib/vhost-user-scsi/Makefile.objs
>  create mode 100644 contrib/vhost-user-scsi/vhost-user-scsi.c
>  create mode 100644 hw/scsi/vhost-user-scsi.c
>  create mode 100644 include/hw/virtio/vhost-user-scsi.h
> --=20
> 1.8.3.1
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHxQlAAoJEJykq7OBq3PIVWYH/0kkEhWrZFgPKBANIrmSN+o/
4oqai2IKFFf9WbzUydzFwM3QTk7UXwRYcVLZvQHal9fkuf+STD/yeHhA0sNJgCjZ
PtRBnWdsm4BVj95MaKidWVzpSuOakjWt1aW3NlyPKlIxJp5/DVmNHVSZuQuP9vMa
Hq/txaW3LunzJgdxrwDKp7v8oGOh0vZcMDhMVKD4HJIiL0XEPisG/wAu+XZGhMTm
xiabt521siKC0PzC76MSZJRHyZdCIQ9OpE+RE2/wqESk27XmGswD2WapdmyFPQFL
MLZ4y+w+E4xrJW+BWpnWUG3KDwS4UcdgbzROvc6jR78wK7LtxgJcLlSfoyR/mLc=
=4/fr
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
