Received: from eggs.gnu.org ([2001:4830:134:3::10]:33679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chGFy-0002Bq-FL
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chGFt-0003ZG-K5
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:49:58 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-31-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <622e561d-0fc3-f310-781e-b1469b4cb288@redhat.com>
Date: Fri, 24 Feb 2017 14:49:47 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-31-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VQTAjv3csbd5LuvBCiC2epM2r7Pr8H5Hr"
Subject: Re: [Qemu-devel] [PATCH 30/54] hw/block: Introduce share-rw qdev
 property
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
--VQTAjv3csbd5LuvBCiC2epM2r7Pr8H5Hr
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <622e561d-0fc3-f310-781e-b1469b4cb288@redhat.com>
Subject: Re: [PATCH 30/54] hw/block: Introduce share-rw qdev property
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-31-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-31-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> By default, don't allow another writer for block devices that are
> attached to a guest device. For the cases where this setup is intended
> (e.g. using a cluster filesystem on the disk), the new option can be
> used to allow it.
>=20
> This change affects only devices using DEFINE_BLOCK_PROPERTIES().
> Devices directly using DEFINE_PROP_DRIVE() still accept writers
> unconditionally.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/block/block.c           |  6 ++++--
>  include/hw/block/block.h   |  4 +++-
>  tests/qemu-iotests/172.out | 53 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 60 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--VQTAjv3csbd5LuvBCiC2epM2r7Pr8H5Hr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliwOfsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AXDwIAIUy3oOvVCrcVTJoUnOtx3pDCcDBf6A4
t+AVdGME96ud7HVbJ8LZeUCXjqTmjRBSnX9BlaIxR7OH4a23Tm2ohObH6bxsPdFZ
Og0KcdS/lgcETDl2eIWkeFbNw6xqTzlsolkrIhxjrqg6cCDSardKCOWklpyqU8ay
3zSsr56CbTugaFCEVa2hvhdz81/76zcVS0FgpPc6qurWSw6vRs3ExuaYzNFTsHgO
C7Sh4K1hdx3YUFJJewrJq1ANESaNm7VMeFkl5Lsx4oAeyCcl15vnlHSVOH62DJZQ
872ZRyUJ7GUJifnH5KyCftBi+QDgMieedNBLKzG5VfNLTVLZXsZ7YIc=
=JWuF
-----END PGP SIGNATURE-----

--VQTAjv3csbd5LuvBCiC2epM2r7Pr8H5Hr--
