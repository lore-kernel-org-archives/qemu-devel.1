Received: from eggs.gnu.org ([2001:4830:134:3::10]:40577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d5mbD-0002o8-7l
	for qemu-devel@nongnu.org; Wed, 03 May 2017 01:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d5mbB-0004MP-Tv
	for qemu-devel@nongnu.org; Wed, 03 May 2017 01:13:15 -0400
Date: Wed, 3 May 2017 12:31:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170503023157.GI10741@umbus.fritz.box>
References: <1493646214-3342-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170502015002.GD10741@umbus.fritz.box>
	<8f067ee2-4e57-d514-7e6c-47dbd75a91dd@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GBuTPvBEOL0MYPgd"
Content-Disposition: inline
In-Reply-To: <8f067ee2-4e57-d514-7e6c-47dbd75a91dd@ilande.co.uk>
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


--GBuTPvBEOL0MYPgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2017 at 08:38:56AM +0100, Mark Cave-Ayland wrote:
> On 02/05/17 02:50, David Gibson wrote:
>=20
> > On Mon, May 01, 2017 at 02:43:29PM +0100, Mark Cave-Ayland wrote:
> >> Last year Ben posted an initial set of patches for OpenBIOS which prov=
ided a
> >> MacOS PPC VGA driver enabling MacOS guests to control the colour depth=
 and
> >> resolution of the QEMU stdvga device. The QemuMacDrivers repository wa=
s set up on
> >> qemu-project.org [1] but due to personal circumstances in the second h=
alf of last
> >> year, I was unable to spend much time on it.
> >>
> >> Over the last few months I've reworked the OpenBIOS patches and applie=
d all the
> >> required dependencies upstream which makes it possible to enable the d=
river with
> >> a fairly simple patch [2] to OpenBIOS's vga.fs (binary provided for te=
sting, but not
> >> to be included in the final merge).
> >>
> >> The main change I've made is that instead of serving the driver binary=
 directly
> >> through the VGA PCI BAR (with the relevant binary inlined within OpenB=
IOS), the
> >> driver is now hosted by QEMU and is installed via the fw_cfg interface=
 by the
> >> OpenBIOS vga.fs driver during startup. Not only does this make it poss=
ible to
> >> further develop the driver without also having to rebuild OpenBIOS eve=
ry time but
> >> it also leaves us with the ability to serve a proper IEEE-1275 FCode R=
OM via the
> >> VGA PCI BAR later if needed.
> >>
> >> In addition to this I've added a new OpenBIOS NVRAM variable "vga-ndrv=
?" which
> >> defaults to "true" but can be overidden via -prom-env to force disable=
 the
> >> driver if any incompatibilities are found. I've tested it locally agai=
nst my
> >> OS X 10.2 and MacOS 9.2.1 images and it seems to work there, but as I =
don't
> >> have an exhaustive set of MacOS images available I'd be grateful for s=
ome more
> >> testing.
> >>
> >> [1] https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg06159.html
> >> [2] https://mail.coreboot.org/pipermail/openbios/2017-May/009909.html
> >>
> >> This patchset can also be found on my github repository at
> >> https://github.com/mcayland/qemu/tree/ppc-vga-upstream.
> >>
> >> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >=20
> > Applied to ppc-for-2.10, thanks.
>=20
> Hi David,
>=20
> I just had a look at your ppc-for-2.10 branch and I see that you've also
> included patch 5 which is a custom made OpenBIOS binary.

Done.

> Can you drop patch 5 from the series and then I will do a manual pull
> request to update OpenBIOS and activate the new functionality once this
> is in?
>=20
>=20
> Many thanks,
>=20
> Mark.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GBuTPvBEOL0MYPgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZCUEbAAoJEGw4ysog2bOSgb4P/2SSU/E1Fn7DM1iuOgNdbkDn
kLXxGUMKYqAqa4YBa3fl5l07x4ExBj699hRE7Xu9fQQNd0LqhHgQmW3b+Zhys5v2
SZp2ELpIf1HK4dw1K5L8AbhLXrKjcjZPmHVwpGmCsDPJRYbZyDWHDphZzyQrwSGf
AM/LcSRP6EkImGjG0GqmH9ibolEacxYdTbX4TELJSY02oThFnV+hWqMhnEdq/WqE
rgEtK0xy2mriBxt+wg/eYk9Rva+nq/Wi5oje+y+QXQqDQIC0mO4nHnJNhtV00Yl5
E0se6UjRPRQXtwqS2HOtFbA3GhT3+4TU5LsxWBzPCu4NGPQDjBEdgj+ECre2QRqh
Ef+OKs/CM2dL1LFmeMIKdRXB36Sj2DjBgmMpPAb0sWSEAueejuI5UMGz4m0WA7Uq
jCTbT5ZGoorX0xXrjEet3HQNSJFUd6/lS8004QhHWggrOYorWd59Zb61ASfHUDja
yqGk0BmegMNBdSuP52cBpZSN9FsJfFOhujXEnpcYD3FeI4jLZEMFCmlM3WqV7w55
24O0cNgIIEMCu/OkMSokFDScELCGTlwdCZRwvuiNQV3o0NsUyElco7NW8m+sR/wV
W3Vh4RWKIFq5+FkDdETmcz98g8ENzx9oGHdhcjn7abElKTcmulDipg233l3c+JFj
wjZbth0MWCCY3I/2yciK
=8ucm
-----END PGP SIGNATURE-----

--GBuTPvBEOL0MYPgd--
