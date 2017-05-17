Received: from eggs.gnu.org ([2001:4830:134:3::10]:41241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dB17G-0005if-Ew
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dB17C-0007Yq-4U
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:43:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dB17B-0007Y4-Qv
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:43:54 -0400
Date: Wed, 17 May 2017 16:43:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170517154347.GA16710@stefanha-x1.localdomain>
References: <20170517134003.17110-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20170517134003.17110-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/22] x86 and machine queue, 2017-05-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 10:39:41AM -0300, Eduardo Habkost wrote:
> The following changes since commit 599c9cb641cc484876d5bb92189d09ba27bbfd=
fd:
>=20
>   Merge remote-tracking branch 'sstabellini/tags/xen-20170516-tag' into s=
taging (2017-05-17 14:03:35 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request
>=20
> for you to fetch changes up to 17e8f541263fd771aef58e9818a2060b81904c3f:
>=20
>   tests: Add [+-]feature and feature=3Don|off test cases (2017-05-17 10:3=
7:15 -0300)
>=20
> ----------------------------------------------------------------
> x86 and machine queue, 2017-05-17
>=20
> ----------------------------------------------------------------
>=20
> Eduardo Habkost (22):
>   qdev: Replace cannot_instantiate_with_device_add_yet with
>     !user_creatable
>   sysbus: Set user_creatable=3Dfalse by default on TYPE_SYS_BUS_DEVICE
>   xen-backend: Remove FIXME comment about user_creatable flag
>   iommu: Remove FIXME comment about user_creatable=3Dtrue
>   fdc: Remove user_creatable flag from sysbus-fdc & SUNW,fdtwo
>   pflash_cfi01: Remove user_creatable flag
>   kvmclock: Remove user_creatable flag
>   ioapic: Remove user_creatable flag
>   kvmvapic: Remove user_creatable flag
>   sysbus-ahci: Remove user_creatable flag
>   allwinner-ahci: Remove user_creatable flag
>   isabus-bridge: Remove user_creatable flag
>   unimplemented-device: Remove user_creatable flag
>   fw_cfg: Remove user_creatable flag
>   esp: Remove user_creatable flag
>   generic-sdhci: Remove user_creatable flag
>   hpet: Remove user_creatable flag
>   sysbus-ohci: Remove user_creatable flag
>   virtio-mmio: Remove user_creatable flag
>   xen-sysdev: Remove user_creatable flag
>   s390-pcibus: No need to set user_creatable=3Dfalse explicitly
>   tests: Add [+-]feature and feature=3Don|off test cases
>=20
>  include/hw/qdev-core.h              |   9 +--
>  include/hw/qdev-properties.h        |   4 +-
>  hw/acpi/piix4.c                     |   2 +-
>  hw/arm/spitz.c                      |   2 +-
>  hw/audio/marvell_88w8618.c          |   2 +-
>  hw/audio/pcspk.c                    |   2 +-
>  hw/core/or-irq.c                    |   2 +-
>  hw/core/qdev.c                      |   1 +
>  hw/core/register.c                  |   2 +-
>  hw/core/sysbus.c                    |  11 ++++
>  hw/dma/i8257.c                      |   2 +-
>  hw/dma/sparc32_dma.c                |   2 +-
>  hw/gpio/omap_gpio.c                 |   4 +-
>  hw/i2c/omap_i2c.c                   |   2 +-
>  hw/i2c/smbus_eeprom.c               |   2 +-
>  hw/i2c/smbus_ich9.c                 |   2 +-
>  hw/i386/amd_iommu.c                 |   2 +
>  hw/i386/intel_iommu.c               |   2 +
>  hw/i386/pc.c                        |   2 +-
>  hw/input/vmmouse.c                  |   2 +-
>  hw/intc/apic_common.c               |   2 +-
>  hw/intc/etraxfs_pic.c               |   2 +-
>  hw/intc/grlib_irqmp.c               |   2 +-
>  hw/intc/i8259_common.c              |   2 +-
>  hw/intc/nios2_iic.c                 |   2 +-
>  hw/intc/omap_intc.c                 |   4 +-
>  hw/isa/lpc_ich9.c                   |   2 +-
>  hw/isa/piix4.c                      |   2 +-
>  hw/isa/vt82c686.c                   |   2 +-
>  hw/mips/gt64xxx_pci.c               |   2 +-
>  hw/misc/vmport.c                    |   2 +-
>  hw/net/dp8393x.c                    |   2 +-
>  hw/net/etraxfs_eth.c                |   2 +-
>  hw/net/fsl_etsec/etsec.c            |   2 +
>  hw/net/lance.c                      |   2 +-
>  hw/pci-bridge/dec.c                 |   2 +-
>  hw/pci-bridge/pci_expander_bridge.c |   2 +-
>  hw/pci-host/apb.c                   |   2 +-
>  hw/pci-host/bonito.c                |   2 +-
>  hw/pci-host/gpex.c                  |   2 +-
>  hw/pci-host/grackle.c               |   2 +-
>  hw/pci-host/piix.c                  |   6 +-
>  hw/pci-host/ppce500.c               |   2 +-
>  hw/pci-host/prep.c                  |   2 +-
>  hw/pci-host/q35.c                   |   4 +-
>  hw/pci-host/uninorth.c              |   8 +--
>  hw/pci-host/versatile.c             |   2 +-
>  hw/pci-host/xilinx-pcie.c           |   2 +-
>  hw/ppc/ppc4xx_pci.c                 |   2 +-
>  hw/ppc/spapr_drc.c                  |   2 +-
>  hw/ppc/spapr_pci.c                  |   2 +
>  hw/s390x/s390-pci-bus.c             |   1 -
>  hw/sd/milkymist-memcard.c           |   2 +-
>  hw/sd/pl181.c                       |   2 +-
>  hw/sh4/sh_pci.c                     |   2 +-
>  hw/timer/i8254_common.c             |   2 +-
>  hw/timer/mc146818rtc.c              |   2 +-
>  hw/vfio/amd-xgbe.c                  |   2 +
>  hw/vfio/calxeda-xgmac.c             |   2 +
>  hw/xen/xen_backend.c                |   2 +
>  monitor.c                           |   2 +-
>  qdev-monitor.c                      |   6 +-
>  qom/cpu.c                           |   2 +-
>  target/i386/cpu.c                   |   2 +-
>  tests/test-x86-cpuid-compat.c       | 111 ++++++++++++++++++++++++++++++=
++++++
>  65 files changed, 206 insertions(+), 69 deletions(-)
>=20
> --=20
> 2.11.0.259.g40922b1
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHG+zAAoJEJykq7OBq3PIHnUIAK/QqTCXR8cPzg1LePb8very
ySOQkVfiKri+S9+EcrVOQqtF17YQQhqJiV2Q45vaKinzynDcj/7oyoX4CeVt97p8
KH7xpdUchwgDrliZxG4oh/gBs4/9Ft/Gc4mn9Jvqcoc5n4JeOK6fMZx23stpjPFN
4SRMEQfpVRH3rvB2iQk1naH0YHJgusazS1veNKuKVhq3PsO+S9no46BB4rFKy1wG
w8+QPveK+Z/j331VOc9D7+j6Creny+ZMWuxUro/eA2044t0kJQhYgNhjLkDAS+y4
wusjm8FkLOay6g3CMx7/ezacbZbLoDZxCAsyidaTL+ZUW770974nI8MGslXn0EE=
=xhfl
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
