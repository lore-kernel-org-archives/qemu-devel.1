Received: from eggs.gnu.org ([2001:4830:134:3::10]:54271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSsx8-000673-9s
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 19:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSsx7-0001zs-3E
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 19:43:54 -0400
Date: Wed, 13 Jun 2018 09:42:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612234211.GK30690@umbus.fritz.box>
References: <20180612164402.28680-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M0YLxmUXciMpOLPE"
Content-Disposition: inline
In-Reply-To: <20180612164402.28680-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 0/7] mac99: add via-pmu support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--M0YLxmUXciMpOLPE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 05:43:55PM +0100, Mark Cave-Ayland wrote:
> This patchset is based upon Ben H's experimental branch which adds PMU
> support to the QEMU mac99 machine. Currently mac99 uses the via-cuda
> device which works in a lot of cases, but many OSs such as MacOS 10.5
> only support via-pmu.
>=20
> A lot of the work I've been doing on the Mac machines over the past
> year or so has been to enable me to remove all the hacks from the PMU
> work to enable it to be submitted upstream, and here we are.
>=20
> The choice of via is controlled with a new "via" machine option which
> has 3 values:
>=20
>   via=3Dcuda
>   - Use via-cuda as per the current mac99 machine but largely unsupported
>=20
>   via=3Dpmu-adb
>   - Use via-pmu but attach the mouse and keyboard to the PMU ADB bus
>     rather than USB (useful for esoteric OS X images)
>    =20
>   via=3Dpmu
>   - Use via-pmu with USB mouse and keyboards, as per a real PowerMac3,1
>     machine
>  =20
> Eventually the aim is to switch the mac99 default option to via=3Dpmu but
> there are some minor issues with older OS X related to timer calibration
> and USB that means I'm not ready to do that just yet.
>=20
> Note that the via-pmu device also requires an updated OpenBIOS containing
> a suitable PMU driver which have been posted over to the OpenBIOS mailing
> list at https://mail.coreboot.org/pipermail/openbios/2018-June/010384.htm=
l.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-3.0, thanks.

>=20
>=20
> Mark Cave-Ayland (7):
>   ppc: introduce Core99MachinesState for the mac99 machine
>   mac_newworld: add via machine option to control mac99 VIA/ADB
>     configuration
>   mac_newworld: add gpios to macio devices with PMU enabled
>   mac_newworld: wire up programmer switch to NMI handler
>   adb: fix read reg 3 byte ordering
>   adb: add property to disable direct reg 3 writes
>   mac_newworld: add PMU device
>=20
>  default-configs/ppc-softmmu.mak |   2 +
>  hw/input/adb-kbd.c              |  29 +-
>  hw/input/adb-mouse.c            |  41 +-
>  hw/input/adb.c                  |   7 +
>  hw/misc/macio/Makefile.objs     |   2 +
>  hw/misc/macio/gpio.c            | 231 +++++++++++
>  hw/misc/macio/macio.c           |  89 +++-
>  hw/misc/macio/pmu.c             | 871 ++++++++++++++++++++++++++++++++++=
++++++
>  hw/misc/macio/trace-events      |  28 ++
>  hw/ppc/mac.h                    |  20 +
>  hw/ppc/mac_newworld.c           |  84 +++-
>  include/hw/input/adb.h          |   1 +
>  include/hw/misc/macio/gpio.h    |  47 +++
>  include/hw/misc/macio/macio.h   |   7 +
>  include/hw/misc/macio/pmu.h     | 237 +++++++++++
>  include/hw/ppc/ppc.h            |   1 +
>  16 files changed, 1639 insertions(+), 58 deletions(-)
>  create mode 100644 hw/misc/macio/gpio.c
>  create mode 100644 hw/misc/macio/pmu.c
>  create mode 100644 include/hw/misc/macio/gpio.h
>  create mode 100644 include/hw/misc/macio/pmu.h
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--M0YLxmUXciMpOLPE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsgWlMACgkQbDjKyiDZ
s5JifRAAnLtCgTzFHdOrNIJj5Kg9OxnPju5GbgaJtq2bjVAhDYvRblaMZM/rWAKL
opR03uthdZxApQnXBGSDTNgBiW2OWSR5p9eq/MHDIYCrc+thVMGwyXs9sNFBd9Ts
kzYF1tbIFM3jkgnlYaKLy2YjxggzNArlK+8aDzJKIp67gRm6+ftUCknyYXLMtIad
JaC3YcfLshOs8lbRTx/GzF0fUJpB5KXx9uNaNOY/Sz9Nq4ZlZEg+99M5fhslu1xY
N0O3ViVpoSrXDBcIrwcRh4Kgd17I3Mf05oJ3SXObbUkbhHxDLjFgVpHifq+O2HO7
sWkkLE2d6gli5HSTJpQFQBeFCH50RjH53AQf2KQ3lX3F1HM0uHheBT8tuUud2/jO
l3zyhgUCMpgDFolNwKsvsH7kIZ2Liq6nHdHUBncZZXc2/RvX3FPS8ruQ+Tm6c4hd
WwDV755DwjfXK7iyj/4bX/eLFf77kPpjBNg6d91c30AmzO2cmyvHQe5aESG6wZN9
RTU7d91/ABQOK3L6f/HUhYoN8r4/nWa8rZs6cRwO+utPx/7XgPVdGrA6//0wexow
6twKFSvovkIyBqcs4pOarWmh1seTsezVFlAKbSd/uft0n2X1VsmaG4/KM6yZZJV/
oKZDh6Vy1EnFaeJbtJgYZ5FHQ6p1KCvj/ZfnPrwwq7KnukCRG1I=
=Eplo
-----END PGP SIGNATURE-----

--M0YLxmUXciMpOLPE--
