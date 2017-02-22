Received: from eggs.gnu.org ([2001:4830:134:3::10]:35291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXc5-0003MX-OI
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXc4-0001Rf-RI
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:09:49 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-20-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9702da7f-4d7d-2b5f-d3ba-7ed610e836d9@redhat.com>
Date: Wed, 22 Feb 2017 15:09:38 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-20-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PPg2ulbeNBvtewTHVrQE8p2sTSWX0mIEa"
Subject: Re: [Qemu-devel] [PATCH 19/54] block: Request child permissions in
 format drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PPg2ulbeNBvtewTHVrQE8p2sTSWX0mIEa
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <9702da7f-4d7d-2b5f-d3ba-7ed610e836d9@redhat.com>
Subject: Re: [PATCH 19/54] block: Request child permissions in format drivers
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-20-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-20-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> This makes use of the .bdrv_child_perm() implementation for formats tha=
t
> we just added. All format drivers expose the permissions they actually
> need nows, so that they can be set accordingly and updated when parents=

> are attached or detached.
>=20
> The only format not included here is raw, which was already converted
> with the other filter drivers.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/bochs.c     | 1 +
>  block/cloop.c     | 1 +
>  block/crypto.c    | 1 +
>  block/dmg.c       | 1 +
>  block/parallels.c | 1 +
>  block/qcow.c      | 1 +
>  block/qcow2.c     | 1 +
>  block/qed.c       | 1 +
>  block/vdi.c       | 1 +
>  block/vhdx.c      | 1 +
>  block/vmdk.c      | 1 +
>  block/vpc.c       | 1 +
>  12 files changed, 12 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--PPg2ulbeNBvtewTHVrQE8p2sTSWX0mIEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitm6ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATBkIALztP2l98VmRCatjmEF+uyV3HRZQsLUv
2kN0mtEWV3ulTCf41lPaxVhW+KrW/2B3uMOuGOMkwsKpTjufiZ8JVbj8c0dOUk3k
K+6uvdkqwAwZHlEzZVpQJ4WUao51Ix6S/8T6MuxQnddhC5q72pDby3ms6DPKOCpz
eH5qajJctAfklOc/vMjGBVo/4tLQuP61iX0jWVBGm+hUasuQDhmOIf1Hzd10qrvz
qmzKfbW8pb57uESi1jdyvEXOje11/x7cDkoFVyC3Wj4mmML0zLx3z8p3CRZh9Hu9
r93T7IRrlMFy/W9FAZ33LGcEQp6NR7CAvOBpQiklKOLhLwRJdQFekhQ=
=ZEBB
-----END PGP SIGNATURE-----

--PPg2ulbeNBvtewTHVrQE8p2sTSWX0mIEa--
