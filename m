Received: from eggs.gnu.org ([2001:4830:134:3::10]:44559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDx2b-0006nk-IL
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDx2a-0001Dv-Ej
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:59:17 -0400
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
	<20170525152628.37628-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c13a59b-f0d0-df1b-04ad-0177e576ff08@redhat.com>
Date: Thu, 25 May 2017 12:59:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170525152628.37628-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wRccpK4irNvxmtxdiM11eki3RwwBqDDxc"
Subject: Re: [Qemu-devel] [PATCH 5/7] qemu-img check: add format unallocated
 size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wRccpK4irNvxmtxdiM11eki3RwwBqDDxc
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <7c13a59b-f0d0-df1b-04ad-0177e576ff08@redhat.com>
Subject: Re: [PATCH 5/7] qemu-img check: add format unallocated size
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
 <20170525152628.37628-6-vsementsov@virtuozzo.com>
In-Reply-To: <20170525152628.37628-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 10:26 AM, Vladimir Sementsov-Ogievskiy wrote:
> Shows format 'sparseness' of the image top level.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json |  3 ++-
>  qemu-img.c           | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ea0b3e8b13..c7ed5dc970 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -185,7 +185,8 @@
>             '*image-end-offset': 'int', '*corruptions': 'int', '*leaks'=
: 'int',
>             '*corruptions-fixed': 'int', '*leaks-fixed': 'int',
>             '*total-clusters': 'int', '*allocated-clusters': 'int',
> -           '*fragmented-clusters': 'int', '*compressed-clusters': 'int=
' } }
> +           '*fragmented-clusters': 'int', '*compressed-clusters': 'int=
',
> +           '*format-unallocated-size': 'uint64'} }

Missing documentation (including a since 2.10 blurb).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wRccpK4irNvxmtxdiM11eki3RwwBqDDxc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJxtpAAoJEKeha0olJ0Nqx2QH/2rQle4ALPAY1afjzwVxZDwg
0YHx49tP9OQ8Uvp3u3DS0YNDBvfwOddF4dmU33d7lq4ahpxXXFfstT4YjQrON7aj
NeVuwR/nI7PGzECBFQeE/8C5UJutySPqCz0ZJTmF06NKoGb8+ga4TCJ6vW4o757U
aCBJFUjVQm0KaEsoO/bvHj1eohiHjWPRsGnn8jDWXQESSeaH+5oyCJp6zvMslwxh
4d+RK4YQRG1QzFkDDHU7OMYWcxMXUTj5pAP7HHLLWpfHT9fhoWzRyT2l0EKbihwx
eI0iChnH5mPycTCE6tc6oMMpUyvPEdtmQClPcfGPN32dMuucSKyGGc9JmdMkSIM=
=FurD
-----END PGP SIGNATURE-----

--wRccpK4irNvxmtxdiM11eki3RwwBqDDxc--
