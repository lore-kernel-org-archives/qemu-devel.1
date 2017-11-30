Received: from eggs.gnu.org ([2001:4830:134:3::10]:57181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eKoL8-0006eW-9z
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eKoL6-0004vr-0b
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:39:02 -0500
Date: Thu, 30 Nov 2017 16:22:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171130162234.GC17703@stefanha-x1.localdomain>
References: <20171128121055.6954-1-den@openvz.org>
	<20171128121055.6954-2-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <20171128121055.6954-2-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] hmp: block qemu-io command for device
 without media
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2017 at 03:10:54PM +0300, Denis V. Lunev wrote:
> In this case blk->bs =3D=3D NULL and the code will just crash. Emulate er=
ror
> on that path.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hmp.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaIDBKAAoJEJykq7OBq3PICHMH/R5aIQHa3FEX/jVNtrhwvj+O
ChQK9J1GCVcvT76WJChZFM1H0ZAgRXGa7l6tCPwavdvIfVjFWsS5ln7UBaHqBT7g
xTywu2j+gGG6Am4IPhTFADzDd0OkwiM1T0uaQnNPLhqzY/Z2hOdmvfKug+FSsWDo
DymQQ2NI3aMI9+Uc5beMErKRA/fs6talXEzypPQ6rTUc+UzOoI1c7443nvVr9ATH
dh4Oix8NLjgSdb64yiOMYnqLThkFgrYQuj9pMyR7KcekyY+eey2vyCx7PHNiDn0o
p9LbnPD97gxz7Xafy7o6bIAY0Skh+Ta8ro42sgyRiQvhNPSmlUEbkm7YVdPpcb4=
=zO4X
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
