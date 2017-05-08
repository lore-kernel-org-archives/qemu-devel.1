Received: from eggs.gnu.org ([2001:4830:134:3::10]:42006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7nbA-0007y8-W8
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7nbA-0008Jb-6E
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:41:33 -0400
References: <20170508171302.17805-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4d045f6a-15ce-7659-94d2-fb573fa621b1@redhat.com>
Date: Mon, 8 May 2017 20:41:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170508171302.17805-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pdHekqHPQlvEJIN7c4b5oWnEieP6u2n3q"
Subject: Re: [Qemu-devel] [PATCH] block: Tweak error message related to
 qemu-img convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pdHekqHPQlvEJIN7c4b5oWnEieP6u2n3q
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <4d045f6a-15ce-7659-94d2-fb573fa621b1@redhat.com>
Subject: Re: [PATCH] block: Tweak error message related to qemu-img convert
References: <20170508171302.17805-1-eblake@redhat.com>
In-Reply-To: <20170508171302.17805-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.2017 19:13, Eric Blake wrote:
> When converting a 1.1 image down to 0.10, qemu-iotests 060 forces
> a contrived failure where allocating a cluster used to replace a
> zero cluster reads unaligned data.  Since it is a zero cluster
> rather than a data cluster being converted, changing the error
> message to match our earlier change in 'qcow2: Make distinction
> bewteen zero cluster types obvious' is worthwhile.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> There's one more instance of "Data cluster offset" in qcow2-cluster.c,
> but that one in handle_copied() is contained inside a
> cluster_type =3D=3D QCOW2_CLUSTER_NORMAL conditional.
>=20
>  block/qcow2-cluster.c      | 3 ++-
>  tests/qemu-iotests/060.out | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Looks good, except for one thing: This is for qemu-img amend, not
qemu-img convert.

I can handle that, if you'd like, though. :-)

Max


--pdHekqHPQlvEJIN7c4b5oWnEieP6u2n3q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkQu9QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AAQQIAIcWKUsdpeAVNGvRN+ZlrGaDwryv+Ytn
+UJrPdIFlVVkW3x25ZtWM6DWYzaoLhXedlt7Sh6vcXhcKsbwe9gxofBaFai4bl5f
OW0Xxar+Ef/EkTHPgqc3ntljrbJSarFW6q9LxP+QmScgwOLbOMlvjes+b8WRedHR
dIAFaLfSIzUWnFN8j3MY7LrA0/Gn1qz3Vz3x3obvp16nWIK8zHLzfec+Cv3KwQ5F
5DmnOFdV3iyjvaF8HjF5MDCd4CmXVnJklJC/HNqiaRxOVaGHGDVJMWmqnE0W8qvv
U63T9KirTWwLXEs9zO/gkgR4Fgf5hPMl/rWq7Hhsc6iZeWUn9DV6ai8=
=XARE
-----END PGP SIGNATURE-----

--pdHekqHPQlvEJIN7c4b5oWnEieP6u2n3q--
