Received: from eggs.gnu.org ([2001:4830:134:3::10]:57268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elEcI-0004lW-E5
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elEcH-0001kx-PB
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:57:58 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-14-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cdebabfe-1450-7f80-49fb-0bccd73ec542@redhat.com>
Date: Mon, 12 Feb 2018 14:57:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-14-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kHEntKrS4trQ89NXzNMRjeQIxsZfoY737"
Subject: Re: [Qemu-devel] [PATCH 13/27] file-win32: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kHEntKrS4trQ89NXzNMRjeQIxsZfoY737
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <cdebabfe-1450-7f80-49fb-0bccd73ec542@redhat.com>
Subject: Re: [PATCH 13/27] file-win32: Support .bdrv_co_create
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-14-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-14-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to file-win32, which
> enables image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-win32.c | 45 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--kHEntKrS4trQ89NXzNMRjeQIxsZfoY737
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqBnVwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AalsIAK/rDrp9GQS+2lyls55eso+cxFIUT0uC
IL0Zb/9buwoVDG2tWqi4fmvmm8TkqdsHqcnodDwSwoOYy7GKLvBjVqN6VRzGO/H6
e7fzcC83yZ3lNoJBarvcdtTdAAQYtsAo5/phWG3R1/E702nYm7HmPd2ywEkkK16E
bgnziq/NWXzvPGzkrB5ucRBP7dj4LUasNQQwJL99BPqKKZAPgtADLlleJSExtab3
xh7KPsOEJ4lIJQTg4KJA50CTFalxeYSmE4oxWumi0tEMnMbzEvLDYBSJhItf+cSB
Qw3Ia0hJWEIAOsRYZ8rJYcHTWZDOUVZt/LGaBOECDPJAaBuiqPzsMjc=
=rm/A
-----END PGP SIGNATURE-----

--kHEntKrS4trQ89NXzNMRjeQIxsZfoY737--
