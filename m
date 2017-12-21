Received: from eggs.gnu.org ([2001:4830:134:3::10]:46297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRwSU-0006Xw-QI
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRwSR-0006eO-1E
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:44:06 -0500
Date: Thu, 21 Dec 2017 19:40:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171221084041.GA19441@umbus.fritz.box>
References: <20171219042942.29297-1-david@gibson.dropbear.id.au>
	<CAFEAcA_CrLPQDBxYs6bzYX1Venpau1McP5o7-6PKuL1H-NJR4Q@mail.gmail.com>
	<20171220134550.GH5981@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20171220134550.GH5981@umbus.fritz.box>
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


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2017 at 12:45:50AM +1100, David Gibson wrote:
> On Wed, Dec 20, 2017 at 11:29:36AM +0000, Peter Maydell wrote:
> > On 19 December 2017 at 04:29, David Gibson <david@gibson.dropbear.id.au=
> wrote:
> > > The following changes since commit eaefea537b476cb853e2edbdc68e969ec7=
77e4bb:
> > >
> > >   Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetc=
h' into staging (2017-12-18 14:17:42 +0000)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20171219
> > >
> > > for you to fetch changes up to eec745d4366076dee068750ea80245e1a46e9c=
13:
> > >
> > >   hw/ide: Emulate SiI3112 SATA controller (2017-12-19 15:24:28 +1100)
> > >
> > > ----------------------------------------------------------------
> > > ppc patch queue 2017-12-19
> > >
> > > Here's a second batch of patches for qemu-2.12.  Highlights are:
> > >
> > >   * Optional capabilities for the "pseries" machine.  This removes
> > >     some places where we were changing guest visible properties based
> > >     on host capabilities, which makes life very bad for migration.
> > >   * SLOF update
> > >   * Significant TCG speedup from Paolo
> > >   * Several new devices for embedded platforms
> > >   * Some minor cleanups
> > >
> >=20
> > Migration test hangs on aarch32 host/ppc guest:
> >=20
> > peter.m+  3942  0.0  0.0   1452   412 pts/0    S+   Dec19   0:00  |
> >                    \_ /bin/sh -c
> > QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64
> > QTEST_QEMU_IMG=3Dqemu-img MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$((
> > ${RANDOM:-0} % 255 + 1))} gtester -k --verbose -m=3Dquick
> > tests/spapr-phb-test tests/endianness-test tests/boot-order-test
> > tests/prom-env-test tests/pnv-xscom-test tests/drive_del-test
> > tests/migration-test tests/boot-serial-test tests/rtas-test
> > tests/pxe-test tests/usb-hcd-ohci-test tests/usb-hcd-uhci-test
> > tests/usb-hcd-xhci-test tests/virtio-net-test
> > tests/virtio-balloon-test tests/virtio-blk-test tests/virtio-rng-test
> > tests/virtio-scsi-test tests/virtio-9p-test tests/virtio-serial-test
> > tests/virtio-console-test tests/test-netfilter
> > tests/test-filter-mirror tests/test-filter-redirector
> > tests/display-vga-test tests/numa-test tests/ivshmem-test
> > tests/qmp-test tests/device-introspect-test tests/qom-test
> > tests/test-hmp
> > peter.m+  3943  0.0  0.0  11984  1828 pts/0    Sl+  Dec19   0:00  |
> >                        \_ gtester -k --verbose -m=3Dquick
> > tests/spapr-phb-test tests/endianness-test tests/boot-order-test
> > tests/prom-env-test tests/pnv-xscom-test tests/drive_del-test
> > tests/migration-test tests/boot-serial-test tests/rtas-test
> > tests/pxe-test tests/usb-hcd-ohci-test tests/usb-hcd-uhci-test
> > tests/usb-hcd-xhci-test tests/virtio-net-test
> > tests/virtio-balloon-test tests/virtio-blk-test tests/virtio-rng-test
> > tests/virtio-scsi-test tests/virtio-9p-test tests/virtio-serial-test
> > tests/virtio-console-test tests/test-netfilter
> > tests/test-filter-mirror tests/test-filter-redirector
> > tests/display-vga-test tests/numa-test tests/ivshmem-test
> > tests/qmp-test tests/device-introspect-test tests/qom-test
> > tests/test-hmp
> > peter.m+  4041 99.9  0.0   3460   824 pts/0    R+   Dec19 809:16  |
> >                            \_ tests/migration-test --quiet
> > --keep-going -m=3Dquick --GTestLogFD=3D6
> > peter.m+  4042 99.9  0.4 607804 72924 pts/0    Sl+  Dec19 809:50  |
> >                                \_ ppc64-softmmu/qemu-system-ppc64
> > -qtest unix:/tmp/qtest-4041.sock,nowait -qtest-log /dev/null -qmp
> > unix:/tmp/qtest-4041.qmp,nowait -machine accel=3Dqtest -display none
> > -machine accel=3Dtcg -m 256M -name pcsource,debug-threads=3Don -serial
> > file:/tmp/migration-test-vxvkIZ/src_serial -drive
> > file=3D/tmp/migration-test-vxvkIZ/bootsect,if=3Dpflash,format=3Draw
> > peter.m+  4046  0.0  0.3 596596 49696 pts/0    Sl+  Dec19   0:01  |
> >                                \_ ppc64-softmmu/qemu-system-ppc64
> > -qtest unix:/tmp/qtest-4041.sock,nowait -qtest-log /dev/null -qmp
> > unix:/tmp/qtest-4041.qmp,nowait -machine accel=3Dqtest -display none
> > -machine accel=3Dtcg -m 256M -name pcdest,debug-threads=3Don -serial
> > file:/tmp/migration-test-vxvkIZ/dest_serial -incoming
> > unix:/tmp/migration-test-vxvkIZ/migsocket
> >=20
> >=20
> > Process 4041/4042 are using 100% CPU.
> >=20
> > $ QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64 gtester -k
> > --verbose -m=3Dquick tests/migration-test
> > TEST: tests/migration-test... (pid=3D5441)
> >   /ppc64/migration/postcopy/unix:
> > [hangs]
> >=20
> > My first guess is that this is a general 32-bit host issue
> > rather than an arm-host specific one; arm just happens to
> > be the only 32-bit system in my test set.
>=20
> Oh :(.  I ran make check SPEED=3Dslow in a 32-bit x86 container before
> sending the pull request, and I just retried it now, so that doesn't
> appear to be the case.
>=20
> I haven't the foggiest what could be broken in an arm host specific
> way, though.  Nor do I have easy access to an arm system to track it
> down on.

After I sent that I remembered my Raspberry Pi.  Unfortunately, after
spending most of the day getting it compiled, I wasn't able to
reproduce the problem.  The migration-test completed just fine with my
ppc-for-2.12 tree.

I'm not sure where to go from here, I don't even have a guess as to
which patch in the series might be causing the problem, since none of
them seem likely candidates.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo7c4YACgkQbDjKyiDZ
s5ILmRAAn9esj3EoxkZkx20eB2dsvcF57Nvp2An4b5LZLYcBorjH49swmM9++3kz
gNSy8UjRzIdkQWIS7c/6zpCNVckHrmmXO05hI5vFUXaWoJmUb0ISov9CN9ZmwwQN
yxGx/MjusykCatEZ/rgw0JPiptWXd+t8r27WkEm/KM+vj2SwAI4gXPN1/bnpFAvC
NWci3xCIDQS4WSE/QnFwDMF2lB1SfV0BIldebj7K/0pp3xNONbaijdp+FGfm8SY3
IsvjTv8gzRzlDKHxp3MLPSxnZ4cx3GcQLUTWZfDFvnMYkW2PuXtdM8D7B3bRTYpN
+Et2ofYF+4JfI+dyfXZ6lwYEzPEX0KjWopL4mafBtE649C3M1onYmz2LmJ4q6EIL
7JdiVtNdMYIE7GSrXqlp5KapTXKJy6WnJHCHzVtsiRI1Ghj+uh7zkN6KxqLbptB6
PpfHByLILtyVqXZR76j1GzCk/2u84xhYbEMQwPUKtlvUmKerKsfORjxsDCBLlMNf
Med1BgvHOrb98LYw+WRsr2m8JwKiX5dmFSfqmcCtHhFNBI/AQgjnUwBZgITf0uKb
/hlnYrrgbMe1VRO1yvnAUq3PCtNH/q0500NwAzJh4tJFK42YmZbZKKG1GG4sjmgd
5XBo/9QGpxrMWm6tZxqnqC4fQPX7EUfxD9UCecTODIvU3HEpdJI=
=J3qZ
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
