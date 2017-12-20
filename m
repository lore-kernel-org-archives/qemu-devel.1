Received: from eggs.gnu.org ([2001:4830:134:3::10]:52236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRn0N-0003KW-EJ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 17:38:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRn0M-0005ze-2W
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 17:38:27 -0500
Date: Thu, 21 Dec 2017 00:45:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171220134550.GH5981@umbus.fritz.box>
References: <20171219042942.29297-1-david@gibson.dropbear.id.au>
	<CAFEAcA_CrLPQDBxYs6bzYX1Venpau1McP5o7-6PKuL1H-NJR4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Gk0KcsbyUMelFU1"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_CrLPQDBxYs6bzYX1Venpau1McP5o7-6PKuL1H-NJR4Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/14] ppc-for-2.12 queue 20171219
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>


--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2017 at 11:29:36AM +0000, Peter Maydell wrote:
> On 19 December 2017 at 04:29, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> > The following changes since commit eaefea537b476cb853e2edbdc68e969ec777=
e4bb:
> >
> >   Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch'=
 into staging (2017-12-18 14:17:42 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20171219
> >
> > for you to fetch changes up to eec745d4366076dee068750ea80245e1a46e9c13:
> >
> >   hw/ide: Emulate SiI3112 SATA controller (2017-12-19 15:24:28 +1100)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2017-12-19
> >
> > Here's a second batch of patches for qemu-2.12.  Highlights are:
> >
> >   * Optional capabilities for the "pseries" machine.  This removes
> >     some places where we were changing guest visible properties based
> >     on host capabilities, which makes life very bad for migration.
> >   * SLOF update
> >   * Significant TCG speedup from Paolo
> >   * Several new devices for embedded platforms
> >   * Some minor cleanups
> >
>=20
> Migration test hangs on aarch32 host/ppc guest:
>=20
> peter.m+  3942  0.0  0.0   1452   412 pts/0    S+   Dec19   0:00  |
>                    \_ /bin/sh -c
> QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64
> QTEST_QEMU_IMG=3Dqemu-img MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$((
> ${RANDOM:-0} % 255 + 1))} gtester -k --verbose -m=3Dquick
> tests/spapr-phb-test tests/endianness-test tests/boot-order-test
> tests/prom-env-test tests/pnv-xscom-test tests/drive_del-test
> tests/migration-test tests/boot-serial-test tests/rtas-test
> tests/pxe-test tests/usb-hcd-ohci-test tests/usb-hcd-uhci-test
> tests/usb-hcd-xhci-test tests/virtio-net-test
> tests/virtio-balloon-test tests/virtio-blk-test tests/virtio-rng-test
> tests/virtio-scsi-test tests/virtio-9p-test tests/virtio-serial-test
> tests/virtio-console-test tests/test-netfilter
> tests/test-filter-mirror tests/test-filter-redirector
> tests/display-vga-test tests/numa-test tests/ivshmem-test
> tests/qmp-test tests/device-introspect-test tests/qom-test
> tests/test-hmp
> peter.m+  3943  0.0  0.0  11984  1828 pts/0    Sl+  Dec19   0:00  |
>                        \_ gtester -k --verbose -m=3Dquick
> tests/spapr-phb-test tests/endianness-test tests/boot-order-test
> tests/prom-env-test tests/pnv-xscom-test tests/drive_del-test
> tests/migration-test tests/boot-serial-test tests/rtas-test
> tests/pxe-test tests/usb-hcd-ohci-test tests/usb-hcd-uhci-test
> tests/usb-hcd-xhci-test tests/virtio-net-test
> tests/virtio-balloon-test tests/virtio-blk-test tests/virtio-rng-test
> tests/virtio-scsi-test tests/virtio-9p-test tests/virtio-serial-test
> tests/virtio-console-test tests/test-netfilter
> tests/test-filter-mirror tests/test-filter-redirector
> tests/display-vga-test tests/numa-test tests/ivshmem-test
> tests/qmp-test tests/device-introspect-test tests/qom-test
> tests/test-hmp
> peter.m+  4041 99.9  0.0   3460   824 pts/0    R+   Dec19 809:16  |
>                            \_ tests/migration-test --quiet
> --keep-going -m=3Dquick --GTestLogFD=3D6
> peter.m+  4042 99.9  0.4 607804 72924 pts/0    Sl+  Dec19 809:50  |
>                                \_ ppc64-softmmu/qemu-system-ppc64
> -qtest unix:/tmp/qtest-4041.sock,nowait -qtest-log /dev/null -qmp
> unix:/tmp/qtest-4041.qmp,nowait -machine accel=3Dqtest -display none
> -machine accel=3Dtcg -m 256M -name pcsource,debug-threads=3Don -serial
> file:/tmp/migration-test-vxvkIZ/src_serial -drive
> file=3D/tmp/migration-test-vxvkIZ/bootsect,if=3Dpflash,format=3Draw
> peter.m+  4046  0.0  0.3 596596 49696 pts/0    Sl+  Dec19   0:01  |
>                                \_ ppc64-softmmu/qemu-system-ppc64
> -qtest unix:/tmp/qtest-4041.sock,nowait -qtest-log /dev/null -qmp
> unix:/tmp/qtest-4041.qmp,nowait -machine accel=3Dqtest -display none
> -machine accel=3Dtcg -m 256M -name pcdest,debug-threads=3Don -serial
> file:/tmp/migration-test-vxvkIZ/dest_serial -incoming
> unix:/tmp/migration-test-vxvkIZ/migsocket
>=20
>=20
> Process 4041/4042 are using 100% CPU.
>=20
> $ QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64 gtester -k
> --verbose -m=3Dquick tests/migration-test
> TEST: tests/migration-test... (pid=3D5441)
>   /ppc64/migration/postcopy/unix:
> [hangs]
>=20
> My first guess is that this is a general 32-bit host issue
> rather than an arm-host specific one; arm just happens to
> be the only 32-bit system in my test set.

Oh :(.  I ran make check SPEED=3Dslow in a 32-bit x86 container before
sending the pull request, and I just retried it now, so that doesn't
appear to be the case.

I haven't the foggiest what could be broken in an arm host specific
way, though.  Nor do I have easy access to an arm system to track it
down on.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/Gk0KcsbyUMelFU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo6aYkACgkQbDjKyiDZ
s5JzxQ//WW6lUrf8m0Vne0S8k0dwdJJqkKmea6J7xIwc0LLczzkIayIu/K+aTPrT
e+DyEsMHSC6fMGkRF+z4EPy4vv7igJ6F+ltbhJOEjzhFiCBUSFsA9Vm/NmfEPyJB
BoA+I5wWaEQyTKQK4h6kRWDj1LxVrHKjT59a1G5A4uvTK/8i+Nq0zCcpqznqyTsF
FSdGfdUXNoa/d7dzqXl45J6AIcSRP3qa9x7YxtJ/HF2puXhwQraXajDRyTjTN7tP
CBVT6vobbEdQVD9o1jPxTTn0dnFjLghLJg4Z7dA9cKDnN83b/g15ECl1oWgwcCM9
WRzaJ90e5oZAXEi8EKu/RWbc0siZ1CkdwqLFRVRxiRDWBWdR1QEPZ0wn1DVyzq6e
MdBGsbH3P0coAmcU5oRbGYCJ1RAjwsFohF/mH9aABB7C+ujLBedGAVStROkWOa1A
+TTSfwwxEtRUtSPRDINo+fbTWmSbAOJlfbS9VNtwJz6KQp+IP4xzXsVrcYCfAiat
s2HgI1xaFhI5VxlKi7JLh+Yf6naN+uHqCVTh4ExaF8/ziWoaMT2O5kpIxFjRf2AK
cokS48PFq9K6xJsnotK8MxqiZgjqsTshpe+LhgrO3q7M8+8uUdqLg2s0DX/gf5Ac
iwBz6exrGNXaHk96aJDWNm5ZsIHDzr0W4IxWL9+SkojSo4HiI6I=
=UlYm
-----END PGP SIGNATURE-----

--/Gk0KcsbyUMelFU1--
