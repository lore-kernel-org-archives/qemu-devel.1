Received: from eggs.gnu.org ([2001:4830:134:3::10]:53682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d2fAO-0004aR-Dn
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d2fAL-0005wc-Os
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:40:40 -0400
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
	<1492957997-28587-2-git-send-email-lidongchen@tencent.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c616dbd-f83f-1643-d211-f5be8d8b2dc4@redhat.com>
Date: Mon, 24 Apr 2017 09:40:23 -0500
MIME-Version: 1.0
In-Reply-To: <1492957997-28587-2-git-send-email-lidongchen@tencent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eumntpHFX4adhAoUbMruXA7sG0Mm3QLe4"
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: fix some spelling errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jemmy858585@gmail.com, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Lidong Chen <lidongchen@tencent.com>, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eumntpHFX4adhAoUbMruXA7sG0Mm3QLe4
From: Eric Blake <eblake@redhat.com>
To: jemmy858585@gmail.com, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Lidong Chen <lidongchen@tencent.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <7c616dbd-f83f-1643-d211-f5be8d8b2dc4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: fix some spelling errors
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
 <1492957997-28587-2-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1492957997-28587-2-git-send-email-lidongchen@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/23/2017 09:33 AM, jemmy858585@gmail.com wrote:
> From: Lidong Chen <lidongchen@tencent.com>
>=20
> Fix some spelling errors in is_allocated_sectors comment.
>=20
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>  qemu-img.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index df6d165..0b3349c 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1033,8 +1033,8 @@ done:
>  }
> =20
>  /*
> - * Returns true iff the first sector pointed to by 'buf' contains at l=
east
> - * a non-NUL byte.
> + * Returns true if the first sector pointed to by 'buf' contains at le=
ast
> + * a non-NULL byte.

NACK to both changes.  'iff' is an English word that is shorthand for
"if and only if".  "NUL" means the one-byte character, while "NULL"
means the 8-byte (or 4-byte, on 32-bit platform) pointer value.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eumntpHFX4adhAoUbMruXA7sG0Mm3QLe4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/g5XAAoJEKeha0olJ0Nq8gQIAJpe0XIe3OT/7PUUqQoI3ie3
RYPDmd4NyfDPnCyEIsYqqMa9xllcGxZ5K0CbhHDFr2Q020kpUFOsCHQ4lRayHQl0
u406/GJQJkK4OA69ixy0+TPKNMbKkWEC5Fd3wfftyD/SNsAZOp58LYA1csOBudZy
cTUAIGsKx6JTyWktgGEZCQM5Bs1noZYkMSpY4bLrgGyJCO31/3FdiYKt376j4QiO
LSO2YWfOZWybawq1dNAxaCKLj8ZiDYB2hq4pfpbjNRjEkmbSgPgFNyD5dLKiLM4u
Ldeq05jQsNg4vGw34xnhzIkKmn2j8DK8xBvs/OoZ/n/ad8M1lLjw/inwcFI2jy4=
=sNiG
-----END PGP SIGNATURE-----

--eumntpHFX4adhAoUbMruXA7sG0Mm3QLe4--
