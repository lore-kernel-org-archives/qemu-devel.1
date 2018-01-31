Received: from eggs.gnu.org ([2001:4830:134:3::10]:43530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egxs0-0003wc-RJ
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egxs0-00075B-4N
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:16:32 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<df62458916992c91d7d4203f95ca5fa49d59d613.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3d7bc686-e203-8f63-321b-b0b0470592a3@redhat.com>
Date: Wed, 31 Jan 2018 20:16:20 +0100
MIME-Version: 1.0
In-Reply-To: <df62458916992c91d7d4203f95ca5fa49d59d613.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n8oX6P18kbOZqilDwzwgKCsyJEUraTd4n"
Subject: Re: [Qemu-devel] [PATCH v3 01/39] qcow2: Fix documentation of
 get_cluster_table()
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
--n8oX6P18kbOZqilDwzwgKCsyJEUraTd4n
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <3d7bc686-e203-8f63-321b-b0b0470592a3@redhat.com>
Subject: Re: [PATCH v3 01/39] qcow2: Fix documentation of get_cluster_table()
References: <cover.1516978645.git.berto@igalia.com>
 <df62458916992c91d7d4203f95ca5fa49d59d613.1516978645.git.berto@igalia.com>
In-Reply-To: <df62458916992c91d7d4203f95ca5fa49d59d613.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> This function has not been returning the offset of the L2 table since
> commit 3948d1d4876065160583e79533bf604481063833
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cluster.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--n8oX6P18kbOZqilDwzwgKCsyJEUraTd4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyFgQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AIXEIAII52qIKKJXR5wj3G2zS/s6wPmYHfHha
IrGP2x436LLXkoYy0uzAvwZLj9QM8iOh7h9nYrTyoX5CWZ6VIA81c4SLIjs89huW
AsD7Caaqp4e570QigE/KSmW0+x+EF1KQkJeWopMRAATytg3DIawta54DiRYKfezr
I7ZIRjcgZZ9Y2LOeaZX9eEO/zYtPPxal/AYsI5rS1eLHdfAHPjPrH8Gzl3Yvc8qZ
M75fZ38iJvcm7Kk+hEzqCSUjZZKHAkXWq8gfn6tuStH8iHqqUKYWsw1Gu1P2/z74
EX46FQq5UZafloPn5fNVjXJASrgCRu/eoNAP7nMXEdm7zbsTbzSjNrY=
=ywUx
-----END PGP SIGNATURE-----

--n8oX6P18kbOZqilDwzwgKCsyJEUraTd4n--
