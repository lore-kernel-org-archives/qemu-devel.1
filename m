Received: from eggs.gnu.org ([2001:4830:134:3::10]:53583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBHKG-0001z4-2y
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBHKC-0001EK-5i
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:02:28 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dBHKC-0001E7-0B
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:02:24 -0400
Received: by mail-wm0-x241.google.com with SMTP id v4so9604914wmb.2
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 02:02:23 -0700 (PDT)
Date: Thu, 18 May 2017 10:02:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170518090220.GC30862@stefanha-x1.localdomain>
References: <1494443192-17177-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
In-Reply-To: <1494443192-17177-1-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/9] pci, virtio, vhost: fixes
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


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2017 at 10:07:58PM +0300, Michael S. Tsirkin wrote:
> The following changes since commit 76d20ea0f1b26ebd5da2f5fb2fdf3250cde887=
bb:
>=20
>   Merge remote-tracking branch 'armbru/tags/pull-qapi-2017-05-04-v3' into=
 staging (2017-05-09 15:49:14 -0400)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>=20
> for you to fetch changes up to 8b12e48950a3d59188489b2ff6c5ad9cc09e9866:
>=20
>   acpi-defs: clean up open brace usage (2017-05-10 22:04:23 +0300)
>=20
> ----------------------------------------------------------------
> pci, virtio, vhost: fixes
>=20
> A bunch of fixes that missed the release.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> ----------------------------------------------------------------
> Ard Biesheuvel (2):
>       hw/acpi-defs: replace leading X with x_ in FADT field names
>       hw/arm/virt: generate 64-bit addressable ACPI objects
>=20
> Bruce Rogers (1):
>       ACPI: don't call acpi_pcihp_device_plug_cb on xen
>=20
> Eduardo Habkost (1):
>       iommu: Don't crash if machine is not PC_MACHINE
>=20
> Igor Mammedov (1):
>       pc/fwcfg: unbreak migration from qemu-2.5 and qemu-2.6 during firmw=
are boot
>=20
> Marc-Andr=E9 Lureau (1):
>       libvhost-user: fix crash when rings aren't ready
>=20
> Michael S. Tsirkin (1):
>       acpi-defs: clean up open brace usage
>=20
> Peter Xu (1):
>       pc: add 2.10 machine type
>=20
> Zhiyong Yang (1):
>       hw/virtio: fix vhost user fails to startup when MQ
>=20
>  contrib/libvhost-user/libvhost-user.h |  6 ++---
>  include/hw/acpi/acpi-defs.h           | 45 ++++++++++++++++++-----------=
------
>  include/hw/acpi/aml-build.h           |  3 +++
>  include/hw/i386/pc.h                  | 10 ++++----
>  contrib/libvhost-user/libvhost-user.c | 26 +++++++++++++++-----
>  hw/acpi/aml-build.c                   | 27 +++++++++++++++++++++
>  hw/acpi/piix4.c                       | 11 ++++++---
>  hw/arm/virt-acpi-build.c              | 26 ++++++++++----------
>  hw/i386/acpi-build.c                  |  4 ++--
>  hw/i386/amd_iommu.c                   | 15 +++++++++++-
>  hw/i386/intel_iommu.c                 | 14 +++++++++--
>  hw/i386/pc.c                          |  9 ++++---
>  hw/i386/pc_piix.c                     | 16 ++++++++++---
>  hw/i386/pc_q35.c                      | 14 +++++++++--
>  hw/virtio/vhost-user.c                | 21 +++++++++-------
>  tests/bios-tables-test.c              |  4 ++--
>  16 files changed, 175 insertions(+), 76 deletions(-)
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHWMcAAoJEJykq7OBq3PIwv8H/iMbB/VD7C8xLgmKKu956EuW
Fx02UwoK69UPj5Dfv5ccJB/Ow9V6iQv4Pkwso/HBvNH59+7w7N4CCwH77VzoEHAG
DmFB3TwIEgiJxuKDx2vDzScap2BzhXa8lZ4manTDaWTzhzYrKgFHpBU1OkorVmvp
d8vfRRu1ekZameDW1TT2DNhMUbUDuKsiBHXyZRNDs1UlVeoFKseRj0w8hzXZ6fgp
d6iUL3MVoIvXG9CDZn5JfiFhDROyvBnUQiDJwbnYHXkvLcBDnPdcKOOWwlRlT1Vk
39sXJrxz54XS4W6RcbvyK/lkRpzhBZTyzxwFNYmZP5tm8IENgy3VQXfJhS85yTQ=
=MuyL
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
