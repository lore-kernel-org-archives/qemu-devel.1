Received: from eggs.gnu.org ([2001:4830:134:3::10]:53184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1dxhRI-00047i-4W
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 18:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1dxhRE-0004PL-63
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 18:37:52 -0400
Message-Id: <59CD79B7020000480014A1DF@prv-mh.provo.novell.com>
Date: Thu, 28 Sep 2017 16:37:43 -0600
From: "Bruce Rogers" <brogers@suse.com>
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
	<150637291959.8417.14832530795506547523@sif>
In-Reply-To: <150637291959.8417.14832530795506547523@sif>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH 00/12] Patch Round-up for
 stable 2.10.1, freeze on 2017-09-27
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
List-ID: <qemu-devel.nongnu.org>

>>> On 9/25/2017 at 2:55 PM, <mdroth@linux.vnet.ibm.com> wrote:
> Quoting Michael Roth (2017-09-19 19:45:09)
>> Hi everyone,
>>=20
>> The following new patches are queued for QEMU stable v2.10.1:
>>=20
>>   https://github.com/mdroth/qemu/commits/stable-2.10-staging=20
>>=20
>> The release is planned for 2017-10-02:
>>=20
>>   https://wiki.qemu.org/Planning/2.10=20
>=20
> Thank you for the suggestions. The following additional patches are =
now=20
> queued:
>=20
>   s390x/ais: for 2.10 stable: disable ais facility (Christian Borntraeger=
)
>   9pfs: check the size of transport buffer before marshaling (Jan=20
> Dakinevich)
>   9pfs: fix name_to_path assertion in v9fs_complete_rename() (Jan=20
> Dakinevich)
>   9pfs: fix readdir() for 9p2000.u (Jan Dakinevich)
>   console: fix dpy_gfx_replace_surface assert (Gerd Hoffmann)
>   ide: ahci: unparent children buses before freeing their memory =
(Igor=20
> Mammedov)
>   hw/ide/microdrive: Mark the dscm1xxxx device with user_creatable =3D =
false=20
> (Thomas Huth)
>   hw/arm/aspeed_soc: Mark devices as user_creatable =3D false (Thomas =
Huth)
>   hw/arm/digic: Mark device with user_creatable =3D false (Thomas Huth)
>   s390x/ipl: The s390-ipl device is not hot-pluggable (Thomas Huth)
>   watchdog/wdt_diag288: Mark diag288 watchdog as non-hotpluggable =
(Thomas=20
> Huth)
>   multiboot: validate multiboot header address values (Prasad J Pandit)
>   vga: stop passing pointers to vga_draw_line* functions (Gerd Hoffmann)
>   vga: fix display update region calculation (split screen) (Gerd =
Hoffmann)
>=20
> The following patches are tagged for inclusion, but still awaiting pull
> requests:
>=20
>   block/qcow2-bitmap: fix use of uninitialized pointer
>   migration: disable auto-converge during bulk block migration
>   accel/tcg/cputlb: avoid recursive BQL (fixes #1706296)
>   virtio/vhost: reset dev->log after syncing
>   block/throttle-groups.c: allocate RestartData on the heap
>   throttle-groups: update tg->any_timer_armed[] on detach
>=20
>>=20
>> Please respond here or CC qemu-stable@nongnu.org on any patches you
>> think should be included in the release.
>>=20
>> Testing/feedback is greatly appreciated.
>>=20
>> Thanks!
>>=20
>> ----------------------------------------------------------------
>> Alex Williamson (1):
>>       vhost: Release memory references on cleanup
>>=20
>> Farhan Ali (1):
>>       s390-ccw: Fix alignment for CCW1
>>=20
>> Greg Kurz (1):
>>       virtfs: error out gracefully when mandatory suboptions are =
missing
>>=20
>> Hannes Reinecke (1):
>>       scsi-bus: correct responses for INQUIRY and REQUEST SENSE
>>=20
>> Marc-Andr=E9 Lureau (2):
>>       libvhost-user: support resuming vq->last_avail_idx based on =
used_idx
>>       vhost-user-bridge: fix resume regression (since 2.9)
>>=20
>> Pavel Butsykin (1):
>>       qcow2: move qcow2_store_persistent_dirty_bitmaps() before =
cache=20
> flushing
>>=20
>> Peter Maydell (1):
>>       mps2-an511: Fix wiring of UART overflow interrupt lines
>>=20
>> Pranith Kumar (1):
>>       arm_gicv3_kvm: Fix compile warning
>>=20
>> Richard Henderson (1):
>>       target/arm: Fix aa64 ldp register writeback
>>=20
>> Samuel Thibault (1):
>>       slirp: fix clearing ifq_so from pending packets
>>=20
>> Thomas Huth (1):
>>       hw/arm/allwinner-a10: Mark the allwinner-a10 device with=20
> user_creatable =3D false
>>=20
>>  block/qcow2.c                         | 16 +++++++-------
>>  contrib/libvhost-user/libvhost-user.c | 13 ++++++++++++
>>  contrib/libvhost-user/libvhost-user.h |  7 +++++++
>>  hw/arm/allwinner-a10.c                |  2 ++
>>  hw/arm/mps2.c                         |  4 ++--
>>  hw/intc/arm_gicv3_kvm.c               |  2 +-
>>  hw/scsi/scsi-bus.c                    | 29 ++++++++++++++++++++++----
>>  hw/virtio/vhost.c                     |  4 ++++
>>  pc-bios/s390-ccw/cio.h                |  2 +-
>>  scripts/device-crash-test             |  1 -
>>  slirp/socket.c                        | 39=20
> +++++++++++++++++++++--------------
>>  targ
et/arm/translate-a64.c            | 29 +++++++++++++++-----------
>>  tests/vhost-user-bridge.c             |  7 +++++++
>>  vl.c                                  | 16 ++++++++------
>>  14 files changed, 120 insertions(+), 51 deletions(-)
>>=20
>>=20
>>=20

Sounds like this one is also targeted for 2.10.1:
s390x/cpumodel: remove ais from z14 default model-> also for 2.10.1
Bruce
