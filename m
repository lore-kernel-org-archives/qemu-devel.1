Received: from eggs.gnu.org ([2001:4830:134:3::10]:33836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d5MxB-0007M0-Q5
	for qemu-devel@nongnu.org; Mon, 01 May 2017 21:50:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d5MxA-0007tk-RD
	for qemu-devel@nongnu.org; Mon, 01 May 2017 21:50:13 -0400
Date: Tue, 2 May 2017 11:50:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170502015002.GD10741@umbus.fritz.box>
References: <1493646214-3342-1-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
In-Reply-To: <1493646214-3342-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 0/5] Add qemu_vga.ndrv MacOS PPC VGA driver
 from QemuMacDrivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, benh@kernel.crashing.org


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 01, 2017 at 02:43:29PM +0100, Mark Cave-Ayland wrote:
> Last year Ben posted an initial set of patches for OpenBIOS which provide=
d a
> MacOS PPC VGA driver enabling MacOS guests to control the colour depth and
> resolution of the QEMU stdvga device. The QemuMacDrivers repository was s=
et up on
> qemu-project.org [1] but due to personal circumstances in the second half=
 of last
> year, I was unable to spend much time on it.
>=20
> Over the last few months I've reworked the OpenBIOS patches and applied a=
ll the
> required dependencies upstream which makes it possible to enable the driv=
er with
> a fairly simple patch [2] to OpenBIOS's vga.fs (binary provided for testi=
ng, but not
> to be included in the final merge).
>=20
> The main change I've made is that instead of serving the driver binary di=
rectly
> through the VGA PCI BAR (with the relevant binary inlined within OpenBIOS=
), the
> driver is now hosted by QEMU and is installed via the fw_cfg interface by=
 the
> OpenBIOS vga.fs driver during startup. Not only does this make it possibl=
e to
> further develop the driver without also having to rebuild OpenBIOS every =
time but
> it also leaves us with the ability to serve a proper IEEE-1275 FCode ROM =
via the
> VGA PCI BAR later if needed.
>=20
> In addition to this I've added a new OpenBIOS NVRAM variable "vga-ndrv?" =
which
> defaults to "true" but can be overidden via -prom-env to force disable the
> driver if any incompatibilities are found. I've tested it locally against=
 my
> OS X 10.2 and MacOS 9.2.1 images and it seems to work there, but as I don=
't
> have an exhaustive set of MacOS images available I'd be grateful for some=
 more
> testing.
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg06159.html
> [2] https://mail.coreboot.org/pipermail/openbios/2017-May/009909.html
>=20
> This patchset can also be found on my github repository at
> https://github.com/mcayland/qemu/tree/ppc-vga-upstream.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-2.10, thanks.


>=20
>=20
> Mark Cave-Ayland (5):
>   Add QemuMacDrivers as submodule
>   Add QemuMacDrivers qemu_vga.ndrv revision d4e7d7a built as submodule
>   ppc: add qemu_vga.ndrv ROM to fw_cfg interface for OldWorld Macs
>   ppc: add qemu_vga.ndrv ROM to fw_cfg interface for NewWorld Macs
>   [Testing] Provide NDRV-capable openbios-ppc binary for testing
>=20
>  .gitmodules           |    3 +++
>  Makefile              |    3 ++-
>  hw/ppc/mac_newworld.c |   18 +++++++++++++++++-
>  hw/ppc/mac_oldworld.c |   18 +++++++++++++++++-
>  pc-bios/README        |    3 +++
>  pc-bios/openbios-ppc  |  Bin 750840 -> 754936 bytes
>  pc-bios/qemu_vga.ndrv |  Bin 0 -> 14752 bytes
>  roms/QemuMacDrivers   |    1 +
>  8 files changed, 43 insertions(+), 3 deletions(-)
>  create mode 100644 pc-bios/qemu_vga.ndrv
>  create mode 160000 roms/QemuMacDrivers
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZB+XKAAoJEGw4ysog2bOSPQEP/jfFNV20cGM8UEU+j2xIbYio
0bkeRFYFb806t8OZw9qyyf+Dm0xANK8VFcC9kkYLlqDosZto2oT5EjpP8rJ3+51m
jcw4OCbaqI81szKpk/V4G41c99MJwip0jg+ZJItjtAIrXi+jTcsCxi1auvE3dK+h
kxsfKwpYDhB7g5CeY4CpP0BV8iP5eXKA01gDiu/fsvqa3lCaBURo8RXXgxk+VLVL
kTNFHcW8bpwREwoDH07aHSE7goQ7vHnQDj6ll2ROfQMenJHx2NrnTxCJ05RcaVWx
9lW6zwCON/cD+exsrFsOdNtdqyhGqXs6/DKr0wpZIATyu5nZPufPjkYRy5JzXi02
Er7n95S38Ko/Qe8oJrF7htspWhVpe1QvuZEWtqw0kqoUFlIR6Ux+6stjQoHcfX4+
3F+kj3H/qtwXRxYdl83VHC5xiHGbA0ReA2Kk28N6dfWfx2uzsYTvZ/qAWqwYUxic
ibBHCuLUlppCKLwgjCPAliDu7z+3SE8+9pSeWdMy54u836J53SOUNOAG9kTbjqLt
8M+/F8KzjEcbcrZAVN+IMBh2RDIcWPUSTm6tV6TU3gpmioG+6n7F5WYmkqSBgyu5
IEfdx7481BDqPZ48g/2FXPVMA1UE0p7yEEZlWwUkSaLzHXmZGrR7/SY5Qfe32JKf
kiekmCDKi3FiVfCkqkuQ
=YN3b
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
