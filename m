Received: from eggs.gnu.org ([2001:4830:134:3::10]:35588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dwaPk-0003zw-2P
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dwaPg-0004WT-5E
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:55:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35040
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dwaPf-0004W3-VW
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:55:36 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8PKss6b131755
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:55:31 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d777ydxhk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:55:31 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 25 Sep 2017 16:55:30 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
Date: Mon, 25 Sep 2017 15:55:19 -0500
Message-Id: <150637291959.8417.14832530795506547523@sif>
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
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

Quoting Michael Roth (2017-09-19 19:45:09)
> Hi everyone,
> =

> The following new patches are queued for QEMU stable v2.10.1:
> =

>   https://github.com/mdroth/qemu/commits/stable-2.10-staging
> =

> The release is planned for 2017-10-02:
> =

>   https://wiki.qemu.org/Planning/2.10

Thank you for the suggestions. The following additional patches are now que=
ued:

  s390x/ais: for 2.10 stable: disable ais facility (Christian Borntraeger)
  9pfs: check the size of transport buffer before marshaling (Jan Dakinevic=
h)
  9pfs: fix name_to_path assertion in v9fs_complete_rename() (Jan Dakinevic=
h)
  9pfs: fix readdir() for 9p2000.u (Jan Dakinevich)
  console: fix dpy_gfx_replace_surface assert (Gerd Hoffmann)
  ide: ahci: unparent children buses before freeing their memory (Igor Mamm=
edov)
  hw/ide/microdrive: Mark the dscm1xxxx device with user_creatable =3D fals=
e (Thomas Huth)
  hw/arm/aspeed_soc: Mark devices as user_creatable =3D false (Thomas Huth)
  hw/arm/digic: Mark device with user_creatable =3D false (Thomas Huth)
  s390x/ipl: The s390-ipl device is not hot-pluggable (Thomas Huth)
  watchdog/wdt_diag288: Mark diag288 watchdog as non-hotpluggable (Thomas H=
uth)
  multiboot: validate multiboot header address values (Prasad J Pandit)
  vga: stop passing pointers to vga_draw_line* functions (Gerd Hoffmann)
  vga: fix display update region calculation (split screen) (Gerd Hoffmann)

The following patches are tagged for inclusion, but still awaiting pull
requests:

  block/qcow2-bitmap: fix use of uninitialized pointer
  migration: disable auto-converge during bulk block migration
  accel/tcg/cputlb: avoid recursive BQL (fixes #1706296)
  virtio/vhost: reset dev->log after syncing
  block/throttle-groups.c: allocate RestartData on the heap
  throttle-groups: update tg->any_timer_armed[] on detach

> =

> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
> =

> Testing/feedback is greatly appreciated.
> =

> Thanks!
> =

> ----------------------------------------------------------------
> Alex Williamson (1):
>       vhost: Release memory references on cleanup
> =

> Farhan Ali (1):
>       s390-ccw: Fix alignment for CCW1
> =

> Greg Kurz (1):
>       virtfs: error out gracefully when mandatory suboptions are missing
> =

> Hannes Reinecke (1):
>       scsi-bus: correct responses for INQUIRY and REQUEST SENSE
> =

> Marc-Andr=C3=A9 Lureau (2):
>       libvhost-user: support resuming vq->last_avail_idx based on used_idx
>       vhost-user-bridge: fix resume regression (since 2.9)
> =

> Pavel Butsykin (1):
>       qcow2: move qcow2_store_persistent_dirty_bitmaps() before cache flu=
shing
> =

> Peter Maydell (1):
>       mps2-an511: Fix wiring of UART overflow interrupt lines
> =

> Pranith Kumar (1):
>       arm_gicv3_kvm: Fix compile warning
> =

> Richard Henderson (1):
>       target/arm: Fix aa64 ldp register writeback
> =

> Samuel Thibault (1):
>       slirp: fix clearing ifq_so from pending packets
> =

> Thomas Huth (1):
>       hw/arm/allwinner-a10: Mark the allwinner-a10 device with user_creat=
able =3D false
> =

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
> =

> =

>=20
