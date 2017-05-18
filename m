Received: from eggs.gnu.org ([2001:4830:134:3::10]:32835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBHo8-0002zf-FL
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBHo3-0002c5-NL
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:33:20 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dBHo3-0002bz-EH
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:33:15 -0400
Received: by mail-wm0-x242.google.com with SMTP id v4so9808975wmb.2
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 02:33:15 -0700 (PDT)
Date: Thu, 18 May 2017 10:33:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170518093312.GH30862@stefanha-x1.localdomain>
References: <1495057396-13387-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jHkwA2TBA/ec6v+"
Content-Disposition: inline
In-Reply-To: <1495057396-13387-1-git-send-email-mst@redhat.com>
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


--9jHkwA2TBA/ec6v+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2017 at 12:44:59AM +0300, Michael S. Tsirkin wrote:
> This includes the previous pull request which still
> does not appear to be in - not rebased so merging twice
> will not cause conflicts. Note that patch 08 makes checkpatch
> complain, patch 9 fixes that.
>=20
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
> for you to fetch changes up to a764040cc831cfe5b8bf1c80e8341b9bf2de3ce8:
>=20
>   exec: abstract address_space_do_translate() (2017-05-18 00:35:15 +0300)
>=20
> ----------------------------------------------------------------
> pci, virtio, vhost: fixes
>=20
> A bunch of fixes that missed the release.
> Most notably we are reverting shpc back to enabled by default state
> as guests uses that as an indicator that hotplug is supported
> (even though it's unused). Unfortunately we can't fix this
> on the stable branch since that would break migration.
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
> Greg Kurz (1):
>       virtio: allow broken device to notify guest
>=20
> Herongguang (Stephen) (1):
>       pci: deassert intx when pci device unrealize
>=20
> Igor Mammedov (1):
>       pc/fwcfg: unbreak migration from qemu-2.5 and qemu-2.6 during firmw=
are boot
>=20
> Marc-Andr=E9 Lureau (1):
>       libvhost-user: fix crash when rings aren't ready
>=20
> Marcel Apfelbaum (1):
>       Revert "hw/pci: disable pci-bridge's shpc by default"
>=20
> Michael S. Tsirkin (1):
>       acpi-defs: clean up open brace usage
>=20
> Peter Xu (2):
>       pc: add 2.10 machine type
>       exec: abstract address_space_do_translate()
>=20
> Zhiyong Yang (1):
>       hw/virtio: fix vhost user fails to startup when MQ
>=20
>  contrib/libvhost-user/libvhost-user.h |   6 +-
>  include/hw/acpi/acpi-defs.h           |  45 +++++++--------
>  include/hw/acpi/aml-build.h           |   3 +
>  include/hw/compat.h                   |   6 +-
>  include/hw/i386/pc.h                  |  10 ++--
>  contrib/libvhost-user/libvhost-user.c |  26 +++++++--
>  exec.c                                | 103 +++++++++++++++++++++++-----=
------
>  hw/acpi/aml-build.c                   |  27 +++++++++
>  hw/acpi/piix4.c                       |  11 +++-
>  hw/arm/virt-acpi-build.c              |  26 ++++-----
>  hw/i386/acpi-build.c                  |   4 +-
>  hw/i386/amd_iommu.c                   |  15 ++++-
>  hw/i386/intel_iommu.c                 |  14 ++++-
>  hw/i386/pc.c                          |   9 ++-
>  hw/i386/pc_piix.c                     |  16 +++++-
>  hw/i386/pc_q35.c                      |  14 ++++-
>  hw/pci-bridge/pci_bridge_dev.c        |   2 +-
>  hw/pci/pci.c                          |   1 +
>  hw/virtio/vhost-user.c                |  21 ++++---
>  hw/virtio/virtio.c                    |   4 +-
>  tests/bios-tables-test.c              |   4 +-
>  21 files changed, 253 insertions(+), 114 deletions(-)
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--9jHkwA2TBA/ec6v+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHWpYAAoJEJykq7OBq3PIERMIAKPTFOkpW83hbvZeLxPkSEgE
8ZPSKQbWttMr2stVVb24LaShirpEGU14p3/8q45VfJTScblfvBF10rADoFyUdry6
sZi95Pm3TkBxvZjpNWBrMBVc4bC2Lcz70TSUXJLaDrj23EhnWfxPpBeLV9a0KLG1
d51vuPGo7GtKkuni53vgSv88F4xJNjFojt/BP7pK9cZLCvovh3WDJL+1gzyop8Sv
q7NijsaZyUMooJZT+5rGEehfs9kNqxqsbe4azSuxye6HSpZ6xbOI1Qi41cHQTSq2
f7VM4T+23a9YVQu+Hj1xiXrWIO20K8hosIdfKvdTRo8eZSM+wM7zbOOohbtfalw=
=itO9
-----END PGP SIGNATURE-----

--9jHkwA2TBA/ec6v+--
