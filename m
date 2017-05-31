Received: from eggs.gnu.org ([2001:4830:134:3::10]:41267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG09p-000233-80
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG09k-0001RF-Dp
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:43:13 -0400
Date: Wed, 31 May 2017 10:43:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531094305.GC15666@stefanha-x1.localdomain>
References: <20170524025235.32190-1-famz@redhat.com>
	<20170524025235.32190-11-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <20170524025235.32190-11-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 10/16] mirror: Do initial
 aio context move of target via BB interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 10:52:29AM +0800, Fam Zheng wrote:
> While blockdev-backup tried to verify before moving target's aio context,=
 the
> same is missing for blockdev-mirror. Now that we have the right interface=
, fix
> this as well.
>=20
> As a bonus, the aio context move is now conditional, which avoids some
> unnecessary operations in bdrv_set_aio_context.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/mirror.c | 54 ++++++++++++++++++++++++++++++++--------------------=
--
>  blockdev.c     |  4 ----
>  2 files changed, 32 insertions(+), 26 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLpApAAoJEJykq7OBq3PI9JoH/iwYH597y+TJkDSVppeFWxJY
di12rvvn8/Q/da7cSejKCBaa5+1K/YcydaImTR1WVAKUoym1t/x8B623y9MRFrNR
IGe2XbOaTDewirNKEyzk7D4wSRpqaYEzqvlwKRSDYAdOMZpDxAEmblVNi2FJX5bU
+s7YJ/GejJzh0RFhApw5PwfNlXQUkNt+kvNYiuWfv34DoAut41zA5vpTPDIsD8jp
kgrdC7iD29ghfIJuY9c46QRgS/WTFK1qqCGEly3sJ2Ox1HmcknX4g8q/iuP4cO/r
uxEekK7A6m8gh72Y3J2TarkRvvpBM2Ezya1SVDHBTUcYk9YaeDfgJm9F92tB1Ic=
=Hu8r
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
