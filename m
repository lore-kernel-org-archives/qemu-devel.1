Received: from eggs.gnu.org ([2001:4830:134:3::10]:49276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXu3t-0001al-Oq
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 15:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXu3q-000256-OK
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 15:55:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36612 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1fXu3q-00024y-Bp
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 15:55:34 -0400
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
Date: Tue, 26 Jun 2018 21:55:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180625131253.11218-2-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G8Ef4azFXpxJqt5eytGEAP99ZdvPffwhU"
Subject: Re: [Qemu-devel] [PULL 1/6] audio/hda: create millisecond timers
 that handle IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Martin Schrodt <martin@schrodt.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G8Ef4azFXpxJqt5eytGEAP99ZdvPffwhU
From: Max Reitz <mreitz@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Martin Schrodt <martin@schrodt.org>
Message-ID: <6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
Subject: Re: [Qemu-devel] [PULL 1/6] audio/hda: create millisecond timers that
 handle IO
References: <20180625131253.11218-1-kraxel@redhat.com>
 <20180625131253.11218-2-kraxel@redhat.com>
In-Reply-To: <20180625131253.11218-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-25 15:12, Gerd Hoffmann wrote:
> Currently, the HDA device tries to sync itself with the QEMU audio
> backend by waiting for the guest driver to handle buffer completion
> interrupts. This causes the backend to often read too much data from th=
e
> device, as well as running out of data whenever the guest takes too lon=
g
> to handle the interrupt.
>=20
> According to the HDA specification, the guest is also not required to
> use interrupts, but can also sync itself by polling the LPIB registers.=

>=20
> This patch will introduce high frequency (1000Hz) timers that interface=

> with the device and allow for much smoother emulation of the LPIB
> registers. Since the timing is now provided by these timers, the need
> to wait for buffer completion interrupts also ceases.
>=20
> Signed-off-by: Martin Schrodt <martin@schrodt.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Message-id: 20180622111200.30561-2-kraxel@redhat.com
> Message-id: 20171015184033.2951-3-martin@schrodt.org
>=20
> [ kraxel: keep old code for compatibility with older qemu versions,
>           add property to switch code paths at runtime ]
> [ kraxel: new code is disabled by default, use-timer=3Don enables it ]
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/audio/hda-codec.c | 263 +++++++++++++++++++++++++++++++++++++++++++=
+++-----
>  hw/audio/intel-hda.c |   7 --
>  2 files changed, 237 insertions(+), 33 deletions(-)

This patch breaks compilation on clang with -m32 for me, because I
apparently I don't have 64 bit atomics there.  Should there be
CONFIG_ATOMIC64 guards and handling for when that isn't defined?

Max


--G8Ef4azFXpxJqt5eytGEAP99ZdvPffwhU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsymjEACgkQ9AfbAGHV
z0Dm5QgArLQlyV4wmEk+eGty+D0kL4T1hIOWkyzA/JaCE6pbc9IAilwUswtfTz2G
0g2SCaMNrMaIpvbiTqoiRw51NNPpFUC0x9ETHZpxn4+9Rs2g4zHz0w6P7gLJRGpS
thQ9k1TkkW5qOYp5s04bK+GD7BALJngHcebryXMbHpYo6F/NOkO5vJlBB8TJOklh
b8/DZZAkboynM2xo0JDUE/EqVsUYaMnHSr6qzPUNgR5e9wOLcPsSnTzN0TNiu0h5
buMk9W2kbyI7YUptzbsE6bWWy4FBweo4yzjMKntX6TmvyVQ92QJD78Z3CHJ4GFeL
5WPuR87sxa0rWsjJkdt4wGupyP/Mmg==
=VOBN
-----END PGP SIGNATURE-----

--G8Ef4azFXpxJqt5eytGEAP99ZdvPffwhU--
