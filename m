Received: from eggs.gnu.org ([2001:4830:134:3::10]:56234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ek9iH-0003hl-7e
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ek9iG-0003GG-EO
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:31:41 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-6-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <05216384-aa35-404b-db04-0df8b6a35b1b@redhat.com>
Date: Fri, 9 Feb 2018 15:31:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-6-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zcJ5wMTTCDHuIXSaEsznTJTBHecojaBHD"
Subject: Re: [Qemu-devel] [PATCH 05/27] qcow2: Use BlockdevRef in
 qcow2_create2()
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
--zcJ5wMTTCDHuIXSaEsznTJTBHecojaBHD
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <05216384-aa35-404b-db04-0df8b6a35b1b@redhat.com>
Subject: Re: [PATCH 05/27] qcow2: Use BlockdevRef in qcow2_create2()
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-6-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> Instead of passing a separate BlockDriverState* into qcow2_create2(),
> make use of the BlockdevRef that is included in BlockdevCreateOptions.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block.h |  1 +
>  block.c               | 47 +++++++++++++++++++++++++++++++++++++++++++=
++++
>  block/qcow2.c         | 38 ++++++++++++++++++++++++--------------
>  3 files changed, 72 insertions(+), 14 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--zcJ5wMTTCDHuIXSaEsznTJTBHecojaBHD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp9sMISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AuVgIAJPIXUZtOdBvM/xgmFwSuj1Z/S5afIoj
eZCaSS9yBbQywIVbelMSUnbpkhziKUpHncWu6BJaLB3qIBD26Lbb9aal26HW2fW3
OjSlpEz/9b8i8kKS/HJxzeBVOaZ4nIZQLGxEVLbyLqTOeE5SbenIWZQa24ELr7QZ
eq/Ilt6q66nsiBrFN2zBG6nbHGnT3RYtf+sauAIzuAXo+AE5DXdVA7B+8tZCv/g0
WWnXORx1cqoZxOXG6YI3MBhChvhn9Sjf17OXffCSoa9SYcojZhC8zv37Z6BeVEvL
Qq6u3pYU2isBbKJ+q9rORzXRKbXkCrdp1Ai27t21ffsmTNbQ18fkVVA=
=axiB
-----END PGP SIGNATURE-----

--zcJ5wMTTCDHuIXSaEsznTJTBHecojaBHD--
