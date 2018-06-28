Received: from eggs.gnu.org ([2001:4830:134:3::10]:44677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fYWNh-00023g-6Z
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fYWNf-0006Tb-P4
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:50:37 -0400
Date: Thu, 28 Jun 2018 13:50:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180628125023.GA24618@stefanha-x1.localdomain>
References: <20180621171257.14897-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20180621171257.14897-1-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 00/11] hw: various conversions to
 trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, qemu-trivial@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2018 at 02:12:46PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi,
>=20
> This series is a collection of various trivial patches from
> different stagnating branches. Time to share before loosing
> them.
>=20
> Only the first differs and is meant for Stefan, other will
> probably go via the Trivial tree once Acked.
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=E9 (11):
>   trace: Fix format string for the struct timeval members casted to size_t
>   sdcard: Reduce sdcard_set_blocklen() trace digits
>   hw/char/serial: Convert from DPRINTF macro to trace events
>   hw/char/parallel: Convert from pdebug() macro to trace events
>   hw/display/cirrus: Convert printf() calls to trace events
>   hw/input/tsc2005: Convert a fprintf() call to trace events
>   hw/net/ne2000: Add trace events
>   hw/net/ne2000: Convert printf() calls to trace events
>   hw/net/etraxfs_eth: Convert printf() calls to trace events
>   hw/block/fdc: Convert from FLOPPY_DPRINTF() macro to trace events
>   hw/block/pflash_cfi: Convert from DPRINTF() macro to trace events
>=20
>  hw/block/fdc.c                   |  6 ++---
>  hw/block/pflash_cfi01.c          | 42 ++++++++++++--------------------
>  hw/block/pflash_cfi02.c          | 18 +++++++-------
>  hw/char/parallel.c               | 16 +++++++++---
>  hw/char/serial.c                 |  5 ++--
>  hw/display/cirrus_vga.c          | 25 +++++--------------
>  hw/input/tsc2005.c               |  7 +++---
>  hw/net/etraxfs_eth.c             |  8 +++---
>  hw/net/ne2000.c                  | 25 ++++++++++---------
>  hw/block/trace-events            | 17 +++++++++++++
>  hw/char/trace-events             |  8 ++++++
>  hw/display/trace-events          |  2 ++
>  hw/input/trace-events            |  3 +++
>  hw/net/trace-events              | 11 +++++++++
>  hw/sd/trace-events               |  2 +-
>  scripts/tracetool/backend/log.py |  2 +-
>  16 files changed, 113 insertions(+), 84 deletions(-)
>=20
> --=20
> 2.18.0.rc2
>=20
>=20

Thanks, applied to my tracing-next tree:
https://github.com/stefanha/qemu/commits/tracing-next

Stefan

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbNNmOAAoJEJykq7OBq3PIg3sH/2kJp27tRpA4BD50tWr9DgsJ
GEo43xEr1qRrCYNEoS3pC/v7ASiYGf5MtNgkZWcEddOmLxfFm8O0KNwBfb5A3zLo
JRdaKczrdDax8fSTpaOCqE1zAYZYLWdnMyN3Jbxieu5uW39jeDQxaYhQO6NcssZj
AxsSowOi66DoTQ7CCMZo5/GyRs54C4mXiyXLVdchvM3WELGf+j+XL0FeuXDjAtza
5UHndoZMkxtipexCiwQfYvDeawiG1Fb8RYZuNFtua2pDl5mKFSr0sNDZ/WNX4Z6i
5vYDXPozEh/4ktIMLvrbsiB3s1M2MDizNC5Y/2pAm4XLMIiSco3P6XOf4F2QbkU=
=Nbbi
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
