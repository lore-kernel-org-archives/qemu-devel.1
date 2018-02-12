Received: from eggs.gnu.org ([2001:4830:134:3::10]:54760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elI7N-000118-3Z
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elI7M-0007l4-9w
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:42:17 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-26-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ced77ead-b486-1041-2f10-45a226e03c33@redhat.com>
Date: Mon, 12 Feb 2018 18:42:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-26-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8fQwlOQeFIjEreHnH1qihRXfz0A1gX1bC"
Subject: Re: [Qemu-devel] [PATCH 25/27] block: Fail bdrv_truncate() with
 negative size
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
--8fQwlOQeFIjEreHnH1qihRXfz0A1gX1bC
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <ced77ead-b486-1041-2f10-45a226e03c33@redhat.com>
Subject: Re: [PATCH 25/27] block: Fail bdrv_truncate() with negative size
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-26-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-26-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> Most callers have their own checks, but something like this should also=

> be checked centrally. As it happens, x-blockdev-create can pass negativ=
e
> image sizes to format drivers (because there is no QAPI type that would=

> reject negative numbers) and triggers the check added by this patch.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--8fQwlOQeFIjEreHnH1qihRXfz0A1gX1bC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqB0fASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATmQH/09/792VRjagAO68hpP13nVKGVNxBa7z
bhE5p8vdxduO1N4zEBXuUGbJiQxE1QUljc3gbxBuDcdInJrhBTzv/cfUe0KCBeBr
/DOWsf0OvsVsPAnFkZey7aqtqD08BszhrhiwWtgYzcKgi+QkbD2felWM90muqh59
AO1Al5iHU3xrMvi9e3edbFGHp3XZlSbsXu9yWWbOVHTwzO8QkbQnndYNJmiAukth
ZSDZd4V+c3ZVW6AByXlSNqDL6ia8EaLu2KRIj8oJ1A7SISEBbM1IDDDF4p8YXgwC
HdYTaaG3NG6Qo0WhBq2q9i5YFkqlVNnNczusFk/2CtlC+zcIKbAKzYM=
=UjdE
-----END PGP SIGNATURE-----

--8fQwlOQeFIjEreHnH1qihRXfz0A1gX1bC--
