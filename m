Received: from eggs.gnu.org ([2001:4830:134:3::10]:46658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdeo-0000mj-H3
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdej-0001yr-PL
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:41:42 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFdej-0001yb-HY
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:41:37 -0400
Received: by mail-wm0-x241.google.com with SMTP id k15so23867988wmh.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 02:41:37 -0700 (PDT)
Date: Tue, 30 May 2017 10:41:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530094134.GK11362@stefanha-x1.localdomain>
References: <1496017081-24032-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOhpupldhMlYbdva"
Content-Disposition: inline
In-Reply-To: <1496017081-24032-1-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/13] pci, virtio, vhost: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


--BOhpupldhMlYbdva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2017 at 03:18:30AM +0300, Michael S. Tsirkin wrote:
> The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b=
60:
>=20
>   Merge remote-tracking branch 'jasowang/tags/net-pull-request' into stag=
ing (2017-05-23 15:01:31 +0100)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>=20
> for you to fetch changes up to 811bf15114bff4d46735acedbd72b906616ce365:
>=20
>   acpi-test: update expected files (2017-05-29 03:07:57 +0300)
>=20
> ----------------------------------------------------------------
> pci, virtio, vhost: fixes
>=20
> A bunch of fixes all over the place. Most notably this fixes
> the new MTU feature when using vhost.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> ----------------------------------------------------------------
> Ladi Prosek (1):
>       pc: ACPI BIOS: use highest NUMA node for hotplug mem hole SRAT entry
>=20
> Maxime Coquelin (2):
>       virtio_net: Bypass backends for MTU feature negotiation
>       vhost-user: pass message as a pointer to process_message_reply()
>=20
> Michael S. Tsirkin (1):
>       acpi-test: update expected files
>=20
> Peter Xu (9):
>       memory: tune last param of iommu_ops.translate()
>       memory: remove the last param in memory_region_iommu_replay()
>       x86-iommu: use DeviceClass properties
>       intel_iommu: renaming context entry helpers
>       intel_iommu: provide vtd_ce_get_type()
>       intel_iommu: use IOMMU_ACCESS_FLAG()
>       intel_iommu: allow dev-iotlb context entry conditionally
>       intel_iommu: support passthrough (PT)
>       intel_iommu: turn off pt before 2.9
>=20
>  hw/i386/intel_iommu_internal.h      |   1 +
>  include/exec/memory.h               |  15 +-
>  include/hw/compat.h                 |   8 +
>  include/hw/i386/x86-iommu.h         |   1 +
>  include/hw/virtio/virtio-net.h      |   1 +
>  include/hw/virtio/virtio.h          |   1 +
>  exec.c                              |   3 +-
>  hw/alpha/typhoon.c                  |   2 +-
>  hw/dma/rc4030.c                     |   2 +-
>  hw/i386/acpi-build.c                |   7 +-
>  hw/i386/amd_iommu.c                 |   4 +-
>  hw/i386/intel_iommu.c               | 313 ++++++++++++++++++++++++++----=
------
>  hw/i386/x86-iommu.c                 |  48 +-----
>  hw/net/virtio-net.c                 |  17 +-
>  hw/pci-host/apb.c                   |   2 +-
>  hw/ppc/spapr_iommu.c                |   2 +-
>  hw/s390x/s390-pci-bus.c             |   2 +-
>  hw/s390x/s390-pci-inst.c            |   2 +-
>  hw/vfio/common.c                    |   2 +-
>  hw/virtio/vhost-user.c              |  12 +-
>  memory.c                            |   7 +-
>  hw/i386/trace-events                |   2 +
>  tests/acpi-test-data/pc/SRAT.memhp  | Bin 264 -> 264 bytes
>  tests/acpi-test-data/q35/SRAT.memhp | Bin 264 -> 264 bytes
>  24 files changed, 299 insertions(+), 155 deletions(-)
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--BOhpupldhMlYbdva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLT5OAAoJEJykq7OBq3PIOjgH/jQ1qjmylGrbN1fb/qqT1l6J
jr1jZfhVsbdXkKJBDG0UIxT+z/TdyUrhQleMN1aR/DNsmS3VrSF9RTB3XgjpaOdx
rXFx9Wl/XwFc+b584LmKWhKsZCrlAaCaClrD61nkNECTgqKIuCLZckXgVs82dmvd
OcxO43xTBuPOlI0yyQbeLpxaslhf55oTDarE3q3k9Z25y2gpeJUXSppNydzuWeU3
GDSj6mNB35z4mcVQj/lOUB2LlmJVlkr9nR1WdCmTiwwt9sPFlG4y5AkoEyIPdtjb
0qmDkisIl41AmUYY1hrodOw+QFSUg8zxIDL76tV+OAsZVFawdXyPII4xLGBIE0c=
=xrZe
-----END PGP SIGNATURE-----

--BOhpupldhMlYbdva--
