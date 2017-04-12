Received: from eggs.gnu.org ([2001:4830:134:3::10]:51716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cyAqL-0005yf-CR
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 01:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cyAqJ-0003j4-PY
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 01:29:25 -0400
Date: Wed, 12 Apr 2017 14:15:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170412041528.GF12900@umbus.fritz.box>
References: <1491924606-20026-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yH1ZJFh+qWm+VodA"
Content-Disposition: inline
In-Reply-To: <1491924606-20026-1-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 0/8] pnv: improvement of LPC support and
 IPMI support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--yH1ZJFh+qWm+VodA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 05:29:58PM +0200, C=E9dric Le Goater wrote:
> Hello,
>=20
> The first patches improve the LPC support for the POWER8NVL (nvlink)
> systems and for multichip systems. Next, we add IPMI support to the
> machine which is required to power off and reboot a PowerNV system. To
> make use of it, a BT device and an BMC simulator need to be defined on
> the command line:
>=20
>     -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10
>=20
> To improve the sensor and FRU support, one can use the following
> options for the simulator:
>=20
>     sdrfile=3D./palmetto-SDR.bin,fruareasize=3D256,frudatafile=3D./palmet=
to-FRU.bin
>=20
>=20
> To test, grab a kernel and a rootfs image here :
>=20
>   https://openpower.xyz/job/openpower-op-build/distro=3Dubuntu,target=3Dp=
almetto/lastSuccessfulBuild/artifact/images/zImage.epapr
>   https://openpower.xyz/job/openpower-op-build/distro=3Dubuntu,target=3Dp=
almetto/lastSuccessfulBuild/artifact/images/rootfs.cpio.xz
>=20
> The full patchset is available here :
>=20
>    https://github.com/legoater/qemu/commits/powernv-ipmi-2.9

Applied to ppc-for-2.10, thanks.

>=20
> Thanks,
>=20
> C.
>=20
> Changes since v2:
>=20
>  - used PNV_LPC() macro to cast the 'opaque' parameter
>  - introduced a pnv_chip_lpc_offset() routine to locate the LPC node
>    of a chip  =20
>  - set the "primary" property on the LPC bus of chip 0 from the machine
>  - used the pnv_chip_lpc_offset() routine to scan the default LPC bus
>  - removed the initializer of io_base
>=20
> Changes since v1:
>=20
>  - moved the IRQ handler in pnv_lpc.c and introduced pnv_lpc_isa_irq_crea=
te()
>  - only add the "primary" property on the LPC bus of chip 0
>  - reworked the assignement of the ISA IO base in the 'reg' array
>    property
>  - changed the type of the 'bmc' attribute of the machine
>=20
> Benjamin Herrenschmidt (1):
>   ppc/pnv: Add support for POWER8+ LPC Controller
>=20
> C=E9dric Le Goater (7):
>   ppc/pnv: enable only one LPC bus
>   ppc/pnv: scan ISA bus to populate device tree
>   ppc/pnv: populate device tree for RTC devices
>   ppc/pnv: populate device tree for serial devices
>   ppc/pnv: populate device tree for IPMI BT devices
>   ppc/pnv: add initial IPMI sensors for the BMC simulator
>   ppc/pnv: generate an OEM SEL event on shutdown
>=20
>  hw/ppc/Makefile.objs     |   2 +-
>  hw/ppc/pnv.c             | 228 ++++++++++++++++++++++++++++++++++++++---=
------
>  hw/ppc/pnv_bmc.c         | 122 +++++++++++++++++++++++++
>  hw/ppc/pnv_lpc.c         | 106 +++++++++++++++++++---
>  include/hw/ppc/pnv.h     |  11 +++
>  include/hw/ppc/pnv_lpc.h |   8 ++
>  6 files changed, 425 insertions(+), 52 deletions(-)
>  create mode 100644 hw/ppc/pnv_bmc.c
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7andAAoJEGw4ysog2bOStKoP/RQTHMUwJD8HpMIVTCtMYBt3
+tqaBrJPxiuBUE5uvAW5WsHYJJkXl2Kq8aQiqjld1Y7BleXehwg7OL9x4SLea2IR
Vcmh9esauYz/lcN63jEsp3Foz8HV1lsQmB62ulK4Bedzv/YZSDecJV9VrcEUeT6e
0Mm+HTLg10PcaR5TI9k9EnUmxYHkxM7fFh854/6fd0AVntZar1hkwcJSna/N6G6z
Bq+QJuJmIipOgElpR4GI39ymc17w9/QDmmbl8cmfjMnRbBV4yJHKvcLkQHs0vw6w
J8iC/M3qzrNiG+AacUTQmNy/0vRx8WNHJaV9QtYR7OMdjFSM6Hn0sZUC3uU4wu98
4FVovX1A34r7sAvKmTc0nzwNPdZP+rN15cAb1BIWA2h8IYEBxzWQzg4r1b4jgHgd
mnLRmEx/6jPkU0N6GUGB2QdPUvSIn1zGiRXxRSW5boUJpSCkuwS9I7tUhZiia1Dw
Dnk5JalXoma6bAcCZIQQ2pqG/uFagjY/gpNu6/3oIru+QlFlMeE1FXaGyYgN3WfT
No5cKIh90ybEEeOiFH9HB6sZnIem0Q66ty903uJYcH0J0ltYtgLE3RfSIBykJ5yv
F+vTWtLkbCXcgdONKjeWzMzP5RT6nOLeE9K4mOqUWJU/US2L3jODI40MB97J+gq1
6PD4RtZmq9A8RbKq/lwb
=xee7
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--
