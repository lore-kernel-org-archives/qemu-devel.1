Received: from eggs.gnu.org ([2001:4830:134:3::10]:60913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evlPy-0001DV-DU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evlPx-0004HQ-K4
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:00:46 -0400
References: <20180313144730.2184-1-kwolf@redhat.com>
	<20180313144730.2184-8-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ab3877bf-8d96-f307-ddc2-10c18f90b548@redhat.com>
Date: Tue, 13 Mar 2018 16:00:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180313144730.2184-8-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jzXhSBGH0gfY7lsxrJTUbb41WGQzn477u"
Subject: Re: [Qemu-devel] [PATCH v2 7/8] vpc: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jzXhSBGH0gfY7lsxrJTUbb41WGQzn477u
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <ab3877bf-8d96-f307-ddc2-10c18f90b548@redhat.com>
Subject: Re: [PATCH v2 7/8] vpc: Support .bdrv_co_create
References: <20180313144730.2184-1-kwolf@redhat.com>
 <20180313144730.2184-8-kwolf@redhat.com>
In-Reply-To: <20180313144730.2184-8-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-13 15:47, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to vpc, which
> enables image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  33 ++++++++++-
>  block/vpc.c          | 152 ++++++++++++++++++++++++++++++++++++++-----=
--------
>  2 files changed, 147 insertions(+), 38 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--jzXhSBGH0gfY7lsxrJTUbb41WGQzn477u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqn544SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AAccIAKXFoEksTA4lovpddTl/CGjw5VIL4nqX
01DdoGGEBsYwP2IDlrScR2med8UlsniQHa7QWqpOcRaaVvuqrkIyw3hKRzLg1+EF
kOQTRGG+P4pACq+MQ/st+vdU4+jTlaA2YTy9pwEMDKDapeDX0W0a8nxRUv7kwtbR
UB9DGdQFu0aT052XEsAVDDzdwoBWBFMMaAr0mWhdf17PWrK65FMlSBM5UXBHATEe
CfL/7bhvpmo0u/4R+skwumoOEb4kLXry9juyahQbOdxSVcD1l1Maslu0fGJs3VPx
CRTqeEtB2pJqcgF9pior09Q6YaqKUCCASRlUmN8aP/PexFEkeb5fZQg=
=llHY
-----END PGP SIGNATURE-----

--jzXhSBGH0gfY7lsxrJTUbb41WGQzn477u--
