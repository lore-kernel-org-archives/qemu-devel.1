Received: from eggs.gnu.org ([2001:4830:134:3::10]:32863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAe65-0007x1-KT
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAe64-0001px-Mu
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:09:13 -0400
Date: Tue, 16 May 2017 16:08:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170516150850.GQ8498@stefanha-x1.localdomain>
References: <20170511144208.24075-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mh8CTEa8Ax54aLHp"
Content-Disposition: inline
In-Reply-To: <20170511144208.24075-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/18] Block layer thread safety, part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--Mh8CTEa8Ax54aLHp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 04:41:50PM +0200, Paolo Bonzini wrote:
> This series uses mutexes or atomic operations around core block layer
> operations.  The remaining parts include:
>=20
> I've removed the failing assertion in bdrv_aligned_pwritev in order to
> test block migration.
>=20
> Paolo
>=20
> v1->v2: add missing comment for 'wakeup' member [Fam]
>         rewrite throttle-groups part [Stefan]
>         rename ThrottleState CoMutex [Fam]
>         minor stats64 changes [Fam, Roman, me]
>         fixed bdrv_flush [Fam, me]
>         dropped request spinlock optimization for now [Stefan]
>         avoid global dirty bitmap mutex [Fam]
>         avoid introducing unlocked bdrv_get_dirty API [Stefan]
>         replaced spinlock with mutex for accounting [Stefan]
>        =20
>=20
> Paolo Bonzini (18):
>   block: access copy_on_read with atomic ops
>   block: access quiesce_counter with atomic ops
>   block: access io_limits_disabled with atomic ops
>   block: access serialising_in_flight with atomic ops
>   block: access wakeup with atomic ops
>   block: access io_plugged with atomic ops
>   throttle-groups: only start one coroutine from drained_begin
>   throttle-groups: do not use qemu_co_enter_next
>   throttle-groups: protect throttled requests with a CoMutex
>   util: add stats64 module
>   block: use Stat64 for wr_highest_offset
>   block: access write_gen with atomics
>   block: protect tracked_requests and flush_queue with reqs_lock
>   block: introduce dirty_bitmap_mutex
>   migration/block: reset dirty bitmap before reading
>   block: protect modification of dirty bitmaps with a mutex
>   block: introduce block_account_one_io
>   block: make accounting thread-safe
>=20
>  block.c                        |   9 +-
>  block/accounting.c             |  64 ++++++++------
>  block/block-backend.c          |   5 +-
>  block/dirty-bitmap.c           | 112 ++++++++++++++++++++++--
>  block/io.c                     |  51 ++++++-----
>  block/mirror.c                 |  14 ++-
>  block/nfs.c                    |   4 +-
>  block/qapi.c                   |   2 +-
>  block/sheepdog.c               |   3 +-
>  block/throttle-groups.c        |  91 ++++++++++++++-----
>  blockdev.c                     |  46 ++--------
>  include/block/accounting.h     |   8 +-
>  include/block/block.h          |   5 +-
>  include/block/block_int.h      |  61 ++++++++-----
>  include/block/dirty-bitmap.h   |  25 ++++--
>  include/qemu/stats64.h         | 193 +++++++++++++++++++++++++++++++++++=
++++++
>  include/sysemu/block-backend.h |  10 +--
>  migration/block.c              |  17 ++--
>  util/Makefile.objs             |   1 +
>  util/stats64.c                 | 136 +++++++++++++++++++++++++++++
>  20 files changed, 679 insertions(+), 178 deletions(-)
>  create mode 100644 include/qemu/stats64.h
>  create mode 100644 util/stats64.c
>=20
> --=20
> 2.12.2
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Mh8CTEa8Ax54aLHp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGxYCAAoJEJykq7OBq3PIrUgH/RFpzydPPmG/5RCbkMoY9kv7
pz5vUaCahFxu36U8TMxaxweTZ9x+vPGCxgM+SZ+QhY5ccnGOtdGSPjCQnh/IdEjj
KNGx8RhYo4a6SbaivMIUwf1htjWg/tNaCuk3NktiXQZ6ZpwjTR2Dfad4I2mYJjsa
8xG2JPSYzEmsAs/9kMBgNj6Fs585l2so9wFc3xz/Xy2e0bg3XawsScnu7sXvE+J+
i7g55IPO5g9vozWsjNVvoVfQ/WG9qEsm2Etm2CSSRSABkKtMV93e5OvCLy4uy1Qz
mZa4zfJF58zspuHcOo+kaMR20GuXnxOkCxDM1M9aKQqGrM78Uar7F8WZv4KjDqI=
=eR3v
-----END PGP SIGNATURE-----

--Mh8CTEa8Ax54aLHp--
