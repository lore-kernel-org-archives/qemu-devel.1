Received: from eggs.gnu.org ([2001:4830:134:3::10]:43250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDwyE-0003gn-98
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDwyD-0007nl-Hx
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:54:46 -0400
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
	<20170525152628.37628-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4d041d0a-ed17-4d72-fce2-e2500e9ec0fc@redhat.com>
Date: Thu, 25 May 2017 12:54:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170525152628.37628-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C0NHvGsadEAXWJ8I7O2o8MEukXl11VsDg"
Subject: Re: [Qemu-devel] [PATCH 2/7] block: add
 bdrv_get_format_allocated_size format interface
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
--C0NHvGsadEAXWJ8I7O2o8MEukXl11VsDg
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <4d041d0a-ed17-4d72-fce2-e2500e9ec0fc@redhat.com>
Subject: Re: [PATCH 2/7] block: add bdrv_get_format_allocated_size format
 interface
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
 <20170525152628.37628-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170525152628.37628-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 10:26 AM, Vladimir Sementsov-Ogievskiy wrote:
> The function should return actually used by top-level format driver

s/actually/the allocation actually/

> space (in it's .file). It differs from bdrv_get_allocated_file_size,

s/it's/its/ (remember, "it's" is only appropriate if "it is" can be used
in its place)

> which returns allocated on fs file size.

s/allocated on fs file size/the disk usage of the underlying file/

So this is a measure of how many clusters a qcow2 image is currently
using (including metadata clusters, and regardless of whether those
clusters happen to point to a hole in the underlying protocol layer)?

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c                   | 15 +++++++++++++++
>  include/block/block.h     |  1 +
>  include/block/block_int.h |  1 +
>  3 files changed, 17 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index ba22fc0dfb..6e1a435490 100644
> --- a/block.c
> +++ b/block.c
> @@ -3407,6 +3407,21 @@ int64_t bdrv_get_allocated_file_size(BlockDriver=
State *bs)
>  }
> =20
>  /**
> + * Actually used by top-level format driver space (in it's .file) in b=
ytes

s/it's/its/

I think we can do better.  How about:

Return the amount of space allocated by the format driver (including
metadata) in bytes, even if some of that space currently maps to holes
in the underlying protocol file.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--C0NHvGsadEAXWJ8I7O2o8MEukXl11VsDg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJxpcAAoJEKeha0olJ0Nqzl8H/A29GOH0JtTl4ISGApcuEVi6
1q8f35R8QbuIJMOte0JqWRqi1Y10+2kEebCx9Xue/dweraFXf5IjrvG4UjwPTe7U
3osXb1iFv1RbZJNHYu3cefEb7O5NPlXmZcdNp4Hvy2pHj8S4SkA2GNNfN3fnoMQU
lb/rzZ2B9MUMbM7zyKWFG+gdOz9oLplSmUm0eNLOAeM7W9YTzw5EPPQpfhszFxUH
7qphV7iswx2WE2oG8JH4rIlHXC5lz0FXm7plaE0Ltw6dPGpfS4ll/jxsyht/g7nk
wAyXBkcaJ5flksP2sVx11e3g1ybCy02oC8YFjHHH/CWLoaSxI1JSaSesZP/HR4U=
=mtKT
-----END PGP SIGNATURE-----

--C0NHvGsadEAXWJ8I7O2o8MEukXl11VsDg--
