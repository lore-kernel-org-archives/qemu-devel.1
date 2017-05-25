Received: from eggs.gnu.org ([2001:4830:134:3::10]:44830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDx3W-000826-TV
	for qemu-devel@nongnu.org; Thu, 25 May 2017 14:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDx3V-0001ZY-Uk
	for qemu-devel@nongnu.org; Thu, 25 May 2017 14:00:15 -0400
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
	<20170525152628.37628-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <59df5eae-d5c5-7edb-cc69-15b768406dfd@redhat.com>
Date: Thu, 25 May 2017 12:59:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170525152628.37628-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bjRK0iiaDieXbXAgSsrJ6WJbwhIoDJ301"
Subject: Re: [Qemu-devel] [PATCH 6/7] qemu-img check: add file-size
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
--bjRK0iiaDieXbXAgSsrJ6WJbwhIoDJ301
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <59df5eae-d5c5-7edb-cc69-15b768406dfd@redhat.com>
Subject: Re: [PATCH 6/7] qemu-img check: add file-size
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
 <20170525152628.37628-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170525152628.37628-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 10:26 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add bdrv_getlength() of underlying bs->file->bs, to improve
> 'Format unallocated size' section of qemu-img check output.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json |  2 +-
>  qemu-img.c           | 11 ++++++++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index c7ed5dc970..f720a29512 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -186,7 +186,7 @@
>             '*corruptions-fixed': 'int', '*leaks-fixed': 'int',
>             '*total-clusters': 'int', '*allocated-clusters': 'int',
>             '*fragmented-clusters': 'int', '*compressed-clusters': 'int=
',
> -           '*format-unallocated-size': 'uint64'} }
> +           '*format-unallocated-size': 'uint64', '*file-size': 'uint64=
'} }

Missing documentation, including a since 2.10 blurb.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bjRK0iiaDieXbXAgSsrJ6WJbwhIoDJ301
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJxueAAoJEKeha0olJ0Nq8i8IAKuuSQ30x1HZCHLRowFV8XYn
96LaCYlXOIbwDSihN+raSs0usWNLZye56sMZBmXbdJ9L+m7DvHu/YFI+Ve9j7dIW
bFm5WNwLU3gZVIVJHHnytaESIu6v4Rs9A4Vism/cNG/lTq5yyRt1oiK8aIjG8/al
A+OFzWS3vzv5q0CmAiJABshALd4Mos+hcZk7B4QoNJ+wBzJ1OgnmF3Us4cYJP8f4
Pv0Q8m0GkB6h3YdzDzzES7FaLngb7//aNm1MbBfdEcDGcLYclUzcO7gIS/l+N368
0xkj1Oe7Ei++e5tqV+0V9HAyBvlZpPtI9arHew7Kl1oYrvgtpQg6Mjgh+kKMRqA=
=rrGx
-----END PGP SIGNATURE-----

--bjRK0iiaDieXbXAgSsrJ6WJbwhIoDJ301--
