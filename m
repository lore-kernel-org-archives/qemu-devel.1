Received: from eggs.gnu.org ([2001:4830:134:3::10]:35782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXex-0006JS-A3
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXew-0001sI-BP
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:12:47 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-21-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <347c75b2-6466-d9d3-827f-de67d362b179@redhat.com>
Date: Wed, 22 Feb 2017 15:12:36 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-21-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HoiALKSVVMooJWdpD5PwJ7hWXGarI8R9d"
Subject: Re: [Qemu-devel] [PATCH 20/54] vvfat: Implement .bdrv_child_perm()
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
--HoiALKSVVMooJWdpD5PwJ7hWXGarI8R9d
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <347c75b2-6466-d9d3-827f-de67d362b179@redhat.com>
Subject: Re: [PATCH 20/54] vvfat: Implement .bdrv_child_perm()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-21-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-21-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> vvfat is the last remaining driver that can have children, but doesn't
> implement .bdrv_child_perm() yet. The default handlers aren't suitable
> here, so let's implement a very simple driver-specific one that protect=
s
> the internal child from being used by other users as good as our
> permissions permit.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   |  2 +-
>  block/vvfat.c             | 22 ++++++++++++++++++++++
>  include/block/block_int.h |  1 +
>  3 files changed, 24 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--HoiALKSVVMooJWdpD5PwJ7hWXGarI8R9d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitnFQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AOvgH+gOTcem37pFCoJh5ZfFHw+Z/wRWPJjYu
3wxxbGS+vlzrOp1XZ2WkNP8GuHvZqugWIWHMfn5RZnivo+9NHO2QEEFnunGgSlj0
myQKbXzy1fPpiyR8zFZZ9DPQ0sRq4DI+kBlqPu1l7AUTENPjVQZRGMDittFVoAfV
klR98RM6nhycf0d4JotI+kWJPqtsE4giYSn+3DURDjakxvrvoP2KKElP1cp2w47S
6sThlRxQBzgGRMDNsMzwkN8sfRV6o4ALziXmuv4+91C4XeENwGpRK6lNnuKNedG5
3xIrae4A1egG4Y4Xo9sPLab/nMw+ngDEuhAmFM1X8+B5oJrx3+m5sts=
=f8p9
-----END PGP SIGNATURE-----

--HoiALKSVVMooJWdpD5PwJ7hWXGarI8R9d--
