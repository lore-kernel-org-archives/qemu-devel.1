Received: from eggs.gnu.org ([2001:4830:134:3::10]:40910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ek8bB-0007CS-02
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ek8b7-0006TG-Sh
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:20:16 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-2-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <888b241e-aa1f-24f1-f8d2-a5019a5764ec@redhat.com>
Date: Fri, 9 Feb 2018 14:19:45 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vLGn3bNHVndk6afsdDTmNc5KgPgv1svBV"
Subject: Re: [Qemu-devel] [PATCH 01/27] block/qapi: Introduce
 BlockdevCreateOptions
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
--vLGn3bNHVndk6afsdDTmNc5KgPgv1svBV
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <888b241e-aa1f-24f1-f8d2-a5019a5764ec@redhat.com>
Subject: Re: [PATCH 01/27] block/qapi: Introduce BlockdevCreateOptions
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-2-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> This creates a BlockdevCreateOptions union type that will contain all o=
f
> the options for image creation. We'll start out with an empty struct
> type BlockdevCreateDummy for all drivers.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 61 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 61 insertions(+)

With the commit message fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--vLGn3bNHVndk6afsdDTmNc5KgPgv1svBV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp9n/ESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9APD4H/RLNs1kOviFnJRRQq52i+opE8+iXoMu+
wq/1rCidB3gEKmil1S/w6DLBIdnTvsYoMqbS8d35yHkJPzQn4WjwmQ+XflG6IQ0T
f2t38+iYtyB+kFw2zqUbjvHCfZAZfNskRdnnI5DfConJDPyHXhWjO3OMtBtLjlig
SazP9EbWqxwRnzCS8QJYIgxCG6bHrlgCp4Ublrx65ON+4noTMrG2eIXKT/O+HyZA
dZXaJM1C7Mn85VfpExQz9JiDyMO3/w+Pgk6YQsuG5MkB2aYR5/4BMmGHVLQn/v/a
nVaG0yDY+/bCgRoVW49DzK6ZZAa8RMQ4MSs4foHcHK3Oqs4NovE61io=
=8VKU
-----END PGP SIGNATURE-----

--vLGn3bNHVndk6afsdDTmNc5KgPgv1svBV--
