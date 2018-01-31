Received: from eggs.gnu.org ([2001:4830:134:3::10]:47410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egy3a-0003jk-Ta
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egy3a-0006BY-3E
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:28:30 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<a2987bf9dffd69a7cc962a1e443618c9bad5f589.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <49aebcc5-fcc5-e3a2-0700-d273a97c4838@redhat.com>
Date: Wed, 31 Jan 2018 20:28:21 +0100
MIME-Version: 1.0
In-Reply-To: <a2987bf9dffd69a7cc962a1e443618c9bad5f589.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YZhkVb3oQTLztzY5ouoHYH7FPgOx2XrVT"
Subject: Re: [Qemu-devel] [PATCH v3 05/39] qcow2: Remove BDS parameter from
 qcow2_cache_table_release()
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
--YZhkVb3oQTLztzY5ouoHYH7FPgOx2XrVT
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <49aebcc5-fcc5-e3a2-0700-d273a97c4838@redhat.com>
Subject: Re: [PATCH v3 05/39] qcow2: Remove BDS parameter from
 qcow2_cache_table_release()
References: <cover.1516978645.git.berto@igalia.com>
 <a2987bf9dffd69a7cc962a1e443618c9bad5f589.1516978645.git.berto@igalia.com>
In-Reply-To: <a2987bf9dffd69a7cc962a1e443618c9bad5f589.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> This function was only using the BlockDriverState parameter to get the
> cache table size (since it was equal to the cluster size). This is no
> longer necessary so this parameter can be removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cache.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--YZhkVb3oQTLztzY5ouoHYH7FPgOx2XrVT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyGNUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A6GEIALnyDykK7Q/Jp0h0wtUvJ5mju++F7AGI
PQpRKRNovB6sn78iCRvgfmoeP9z2es/Ipi8esP476/xSfmtmr2XMd/c3S6UaKA5d
XW/55o1WnfXxkRIk/iGo0n6JozTKQp3ZARu13EJsG4bg0DWPlekfsys7CyoDRrjd
C5SnobTg1iePl+ndOOnZgUrcxFT9JlOcpAj64a0BI/COCNkZzG9gbiGtsqTQZp2Z
OQs7oXISQUy+pQ6aP9598U+cZRKkj8UEQI4ev1LXh4NwiqtBjasTSP3MdYxgpxpC
0PklVD/b7+J9cgI8unB/VKjWWlHtClqtYWJf0MNf6Qm9JcMGJN8JxRs=
=v897
-----END PGP SIGNATURE-----

--YZhkVb3oQTLztzY5ouoHYH7FPgOx2XrVT--
