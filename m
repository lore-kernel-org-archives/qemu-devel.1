Received: from eggs.gnu.org ([208.118.235.92]:36489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehLAx-0006EO-9d
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehL9e-000730-5n
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:09:24 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<c034843507c57cc91762702070307d0aa88e56b1.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dc89a69f-03ef-81a6-3186-1c6981e41069@redhat.com>
Date: Thu, 1 Feb 2018 21:05:55 +0100
MIME-Version: 1.0
In-Reply-To: <c034843507c57cc91762702070307d0aa88e56b1.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RDqdtY6ElkBkS6miMmXDvuhziEpvNEOaI"
Subject: Re: [Qemu-devel] [PATCH v3 37/39] iotests: Test valid values of
 l2-cache-entry-size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RDqdtY6ElkBkS6miMmXDvuhziEpvNEOaI
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <dc89a69f-03ef-81a6-3186-1c6981e41069@redhat.com>
Subject: Re: [PATCH v3 37/39] iotests: Test valid values of
 l2-cache-entry-size
References: <cover.1516978645.git.berto@igalia.com>
 <c034843507c57cc91762702070307d0aa88e56b1.1516978645.git.berto@igalia.com>
In-Reply-To: <c034843507c57cc91762702070307d0aa88e56b1.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 16:00, Alberto Garcia wrote:
> The l2-cache-entry-size setting can only contain values that are
> powers of two between 512 and the cluster size.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/103     | 17 +++++++++++++++++
>  tests/qemu-iotests/103.out |  3 +++
>  2 files changed, 20 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--RDqdtY6ElkBkS6miMmXDvuhziEpvNEOaI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzcyMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ads0H/3zb0zFsUvxGClnQtDy1g7zyjQOiaxdF
oYKy+cNedktFKjV/zfReViFnjlV1DLXcuu0nJ2QKj0GNTudAUdpYgyb0b4L9tlO3
edzHtA9uUqKsEIymMMOfcOjk6D60+0/Mt29H7xsF1GijgcXBDf1g1sf24ZhN50ug
l9WztNbTX0ZbzNe2AkmhKIlYK3J4QeX/fGk+BGrg/WELKf8h7cP+OMTXur5dBYVW
jpZaa1ZZ5ESIVNrcwTntbZ5AdYevL2r+oTLxKvQP1PNxVhiHhHSo3hfH05ca6jWu
RYp5oSzEqzhjK94EJgjZOlCoEcShDaiW578bQ1em86jXaDOHuLOUv6A=
=L+vv
-----END PGP SIGNATURE-----

--RDqdtY6ElkBkS6miMmXDvuhziEpvNEOaI--
