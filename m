Received: from eggs.gnu.org ([2001:4830:134:3::10]:53290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csYir-0002tu-AD
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csYio-0000nE-5w
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1csYin-0000lh-TR
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:26 -0400
References: <CA+KKJYCOKxea1TJY0Uu8HSzYLoh3G=EX-DeKbM+r40HhoxfJrw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <468bcfd9-6a99-23f0-73fd-edfe9ef91c46@redhat.com>
Date: Mon, 27 Mar 2017 12:46:23 -0500
MIME-Version: 1.0
In-Reply-To: <CA+KKJYCOKxea1TJY0Uu8HSzYLoh3G=EX-DeKbM+r40HhoxfJrw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dqkuWf1mDSw1nIFBtwIGVR5r5v3J3pTRO"
Subject: Re: [Qemu-devel] [PATCH] debug: made printf always compile in debug
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Danil Antonov <g.danil.anto@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dqkuWf1mDSw1nIFBtwIGVR5r5v3J3pTRO
From: Eric Blake <eblake@redhat.com>
To: Danil Antonov <g.danil.anto@gmail.com>, qemu-devel@nongnu.org
Message-ID: <468bcfd9-6a99-23f0-73fd-edfe9ef91c46@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] debug: made printf always compile in debug
 output
References: <CA+KKJYCOKxea1TJY0Uu8HSzYLoh3G=EX-DeKbM+r40HhoxfJrw@mail.gmail.com>
In-Reply-To: <CA+KKJYCOKxea1TJY0Uu8HSzYLoh3G=EX-DeKbM+r40HhoxfJrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/27/2017 06:50 AM, Danil Antonov wrote:
>>From cddb60744808eedbadebdc4f0258ee6db694c4a3 Mon Sep 17 00:00:00 2001
> From: Danil Antonov <g.danil.anto@gmail.com>
> Date: Mon, 27 Mar 2017 14:43:10 +0300
> Subject: [PATCH] debug: made printf always compile in debug output
>=20
> Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
> This will ensure that printf function will always compile even if debug=

> output is turned off and, in turn, will prevent bitrot of the format
> strings. Also updated some debug messages to remove compiler errors and=

> warnings.
>=20
> Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
> ---
>  A patch for "Bitrot prevention" in BiteSizedTasks.

Thanks for tackling this.  However...

>  hw/acpi/pcihp.c               | 15 ++++++----
>  hw/acpi/piix4.c               | 16 ++++++-----
>  hw/arm/strongarm.c            | 17 +++++++----
>  hw/arm/z2.c                   | 16 +++++++----
>  hw/audio/lm4549.c             | 18 +++++++-----
>  hw/block/pflash_cfi01.c       | 18 ++++++------
>  hw/block/pflash_cfi02.c       | 19 ++++++------
>  hw/char/ipoctal232.c          | 24 +++++++++-------
>  hw/char/serial.c              | 16 ++++++-----
>  hw/core/empty_slot.c          | 15 ++++++----
>  hw/display/sm501.c            | 15 ++++++----
>  hw/display/ssd0303.c          | 26 ++++++++++-------
>  hw/display/ssd0323.c          | 28 +++++++++---------
>  hw/dma/i82374.c               | 18 +++++++-----
>  hw/dma/puv3_dma.c             |  8 +++---
>  hw/gpio/pl061.c               | 28 ++++++++++--------
>  hw/gpio/puv3_gpio.c           |  8 +++---
>  hw/i2c/bitbang_i2c.c          | 16 +++++++----
>  hw/i2c/pm_smbus.c             | 15 ++++++----
>  hw/i2c/smbus.c                | 28 +++++++++++-------
>  hw/i386/acpi-build.c          | 17 +++++++----
>  hw/i386/intel_iommu.c         | 18 ++++++------
>  hw/i386/pc.c                  | 16 +++++++----
>  hw/i386/xen/xen_platform.c    | 17 ++++++-----
>  hw/input/adb.c                | 17 ++++++-----
>  hw/input/pckbd.c              | 17 +++++++----
>  hw/input/vmmouse.c            | 15 ++++++----
>  hw/intc/arm_gicv3_kvm.c       | 16 ++++++-----
>  hw/intc/exynos4210_combiner.c | 18 ++++++------
>  hw/intc/heathrow_pic.c        | 17 ++++++-----
>  hw/intc/i8259.c               | 16 ++++++-----
>  hw/intc/ioapic.c              | 16 ++++++-----
>  hw/intc/puv3_intc.c           |  4 +--
>  hw/ipack/tpci200.c            | 16 +++++++----
>  hw/isa/apm.c                  | 14 +++++----
>  hw/isa/vt82c686.c             | 18 ++++++------
>  hw/mips/gt64xxx_pci.c         | 15 ++++++----
>  hw/misc/macio/cuda.c          | 15 ++++++----
>  hw/misc/puv3_pm.c             |  8 +++---
>  hw/net/dp8393x.c              | 15 ++++++----
>  hw/net/lan9118.c              | 20 +++++++++----
>  hw/net/mcf_fec.c              | 18 +++++++-----
>  hw/net/stellaris_enet.c       | 28 +++++++++++-------
>  hw/nvram/mac_nvram.c          | 16 +++++++----
>  hw/pci-bridge/dec.c           | 18 ++++++------
>  hw/pci-host/apb.c             | 16 +++++++----
>  hw/pci-host/bonito.c          | 19 +++++++-----
>  hw/pci-host/grackle.c         | 16 +++++++----
>  hw/pci-host/uninorth.c        | 16 +++++++----
>  hw/pci/msi.c                  | 17 +++++++----
>  hw/pci/pci.c                  | 16 +++++++----
>  hw/pci/pci_host.c             | 16 +++++++----
>  hw/pci/pcie.c                 | 18 ++++++++----
>  hw/pci/pcie_aer.c             | 18 ++++++++----
>  hw/s390x/s390-pci-bus.c       | 18 +++++++-----
>  hw/s390x/s390-pci-inst.c      | 18 +++++++-----
>  hw/scsi/lsi53c895a.c          | 26 ++++++++++-------
>  hw/scsi/scsi-disk.c           | 17 ++++++-----
>  hw/scsi/scsi-generic.c        | 17 +++++------
>  hw/sd/pl181.c                 | 16 +++++++----
>  hw/sd/sd.c                    | 14 +++++----
>  hw/sd/ssi-sd.c                | 27 ++++++++++-------
>  hw/sparc64/sparc64.c          | 36 ++++++++++++-----------
>  hw/sparc64/sun4u.c            | 16 ++++++-----
>  hw/ssi/pl022.c                | 28 ++++++++++--------
>  hw/timer/exynos4210_mct.c     | 43 +++++++++++++--------------
>  hw/timer/exynos4210_pwm.c     | 18 ++++++------
>  hw/timer/exynos4210_rtc.c     | 12 ++++----
>  hw/timer/hpet.c               | 24 +++++++++-------
>  hw/timer/mc146818rtc.c        | 33 ++++++++++++---------
>  hw/timer/pl031.c              | 17 +++++------
>  hw/timer/puv3_ost.c           |  4 +--
>  hw/timer/sun4v-rtc.c          | 18 ++++++------
>  hw/usb/dev-serial.c           | 17 +++++------
>  hw/usb/dev-storage.c          | 17 +++++------
>  hw/usb/hcd-ehci.h             | 10 +++----
>  hw/usb/hcd-xhci.c             | 19 +++++++-----
>  hw/virtio/virtio-bus.c        | 15 ++++++----
>  hw/virtio/virtio-mmio.c       | 17 ++++++-----
>  include/hw/unicore32/puv3.h   | 15 ++++++----
>  include/hw/vfio/vfio-common.h | 17 +++++------
>  kvm-all.c                     | 16 +++++------
>  migration/block.c             | 16 ++++++-----
>  page_cache.c                  | 17 ++++++-----
>  target/i386/kvm.c             | 18 ++++++------
>  target/ppc/kvm.c              | 18 ++++++------
>  target/s390x/kvm.c            | 18 ++++++------
>  target/sparc/ldst_helper.c    | 67
> +++++++++++++++++++++++++------------------
>  target/unicore32/helper.c     | 16 ++++++-----
>  target/unicore32/softmmu.c    | 14 +++++----
>  xen-common.c                  | 18 ++++++------
>  xen-hvm.c                     | 18 ++++++------
>  xen-mapcache.c                | 18 ++++++------
>  93 files changed, 992 insertions(+), 712 deletions(-)

This is a very large patch to review, and touches a LOT of files owned
by a large number of maintainers.  Best would be to split it into a
series of smaller patches, touching one directory or set of related
files per patch (where each patch is owned by a single maintainer), to
make it easier for various maintainers to review (and maybe even pull)
just the patches that affect their responsibilities.

Also, splitting it into multiple patches will make it easier to spot the
places where you fixed format mismatches found by the conversions.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--dqkuWf1mDSw1nIFBtwIGVR5r5v3J3pTRO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2U/vAAoJEKeha0olJ0Nq3y0H/2pk1Xf3Go83SK5FQm8scP1x
GIf6iJM5CUuVTn1WHtbJRsI7pIoTWFrLFMirkPqqxiZEe5n0n/SXlFKoyAw97j91
GBzDdtVhgcqF5Fo/gux/0J7vfOfeqkPCmUbvMmdFPpUK74K+JOndqdizZ/iJw3Az
4NgDT7cxnsx2EISvIC54bv4hOW7OKRNkm2DjzxFi2Wl4Fkeds9B5Agz8BkzuJd6f
NqNi5x7RN1cMaVns1CtFHJOkKWF1TEfJjthbVnerjaLxFZOhL/mFHBoKC1qJIpZr
tsNzhgW6CaLhS2vbOBnojUBLwA0/i9SPUl10dQO7kMBLSWTVyLqnH/kcHJqMAFI=
=C6/x
-----END PGP SIGNATURE-----

--dqkuWf1mDSw1nIFBtwIGVR5r5v3J3pTRO--
