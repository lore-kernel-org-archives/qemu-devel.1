Received: from eggs.gnu.org ([209.51.188.92]:35519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hL9iH-0007zJ-FK
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hL9iG-0000J5-J2
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:05:09 -0400
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <66eb4e1a-7fad-a531-aa11-bff9429be87a@redhat.com>
Date: Mon, 29 Apr 2019 19:05:02 +0200
MIME-Version: 1.0
In-Reply-To: <20190402153730.54145-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u6ltYODhI1fzReeYF1TLjqIMZkgEwcjRU"
Subject: Re: [Qemu-devel] [PATCH v5 00/10] qcow2: encryption threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, den@openvz.org, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u6ltYODhI1fzReeYF1TLjqIMZkgEwcjRU
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, den@openvz.org,
 berrange@redhat.com
Message-ID: <66eb4e1a-7fad-a531-aa11-bff9429be87a@redhat.com>
Subject: Re: [PATCH v5 00/10] qcow2: encryption threads
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190402153730.54145-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.04.19 17:37, Vladimir Sementsov-Ogievskiy wrote:
> v5: rebase on master, some conflicts resolved due to data-file feature
>=20
> 01: new patch, just move test from cover letter to a file. I really hop=
e that it
>     will not hang the whole series, so, if we don't want it as is or wi=
th really
>     tiny improvements, I'd prefer to skip it and queue 02-10 first.
> 09: "true" parameter added to moved qcow2_pre_write_overlap_check() cal=
l due to
>     rebase on master (both before and after patch). Seems OK, so keep A=
lberto's r-b.

Patches 2 =E2=80=93 6, 8 =E2=80=93 10:

Reviewed-by: Max Reitz <mreitz@redhat.com>

For 7 I wonder whether the locking can be even tighter.

Max


--u6ltYODhI1fzReeYF1TLjqIMZkgEwcjRU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzHLr4ACgkQ9AfbAGHV
z0D+dQgAtYLEy6I8TMhoePg8fXiaSaJ2Pq2e+3JfZPVamr7LwwDEYrbpVXTIUxSB
DFtZZVp7ZybN0IHYg1XdzoKU4Pge8UaawJeNLRhVf5zvTYDDVniTMMUOJNGED5QK
ZBHZAEwUTDhIbolKZmVQmF8S1XEGkTMDnP3MlnXZ64m+FDDFbYmB4uUKDlwWzcUH
aiveWqxUrg+1twMDTZqBWsA02oE1pvs41Ejl4GbIma29BNdZsrru894KOEfnx2ik
3uJnD/GSRj16Fd2EbxqDo5JgJ5F2sDsK3rni8HtM53xFXr+ncqNnfzZzspvq+KWT
h9wiOvtN/hmqgx+pPg60dFgrAJ1WMw==
=xjVr
-----END PGP SIGNATURE-----

--u6ltYODhI1fzReeYF1TLjqIMZkgEwcjRU--
