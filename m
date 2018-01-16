Received: from eggs.gnu.org ([2001:4830:134:3::10]:42063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebY5K-00036n-Qy
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebY5J-0002SG-UV
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:43:54 -0500
References: <1516107870-8110-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516107870-8110-5-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <45a18aa0-113b-a87e-39ee-97beb205c922@redhat.com>
Date: Tue, 16 Jan 2018 14:43:28 -0600
MIME-Version: 1.0
In-Reply-To: <1516107870-8110-5-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nDIlh0zswpni3gKFb7CizEITdFEZSBw3N"
Subject: Re: [Qemu-devel] [PATCH v6 4/9] block: treat BDRV_REQ_ALLOCATE as
 serialising
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nDIlh0zswpni3gKFb7CizEITdFEZSBw3N
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 den@virtuozzo.com, berto@igalia.com
Message-ID: <45a18aa0-113b-a87e-39ee-97beb205c922@redhat.com>
Subject: Re: [PATCH v6 4/9] block: treat BDRV_REQ_ALLOCATE as serialising
References: <1516107870-8110-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516107870-8110-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516107870-8110-5-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2018 07:04 AM, Anton Nefedov wrote:
> The idea is that ALLOCATE requests may overlap with other requests.
> Reuse the existing block layer infrastructure for serialising requests.=

> Use the following approach:
>   - mark ALLOCATE serialising, so subsequent requests to the area wait
>   - ALLOCATE request itself must never wait if another request is in fl=
ight
>     already. Return EAGAIN, let the caller reconsider.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/io.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nDIlh0zswpni3gKFb7CizEITdFEZSBw3N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeY/AACgkQp6FrSiUn
Q2pvwwf9HfSDCQ9EQ8pb7wRKHujLpIpH2e6XiPTrQbN4ckQ5QBWpCsk3NeJ3WhPd
RcCzp2OBdOOk9Ak8XiQqza7aXDffGXY0Ar1r2ggrmfCGUhAt8BWPkS+Vxxd4qguI
bKlUaCyGO/InhHZs3b/2TijOMbkc2RRNtZGYB/ddXpkhwRpLLtY9fCG1C0Aecnjq
4vdAMKcbVgErXQOaaVqidRKh7lhpMZTiQlldleNoAy0JH3AnKEprd8lZKutcaFzH
b24YaaaRvQ9xp0GEPU5h8VSRn65Rg3Dp/kiPHsflW4/DaLOsTPUVKiGa3AUQW9ZI
zYKF8TXUbY5nZL478txC1VXT8VtpQQ==
=N3Zl
-----END PGP SIGNATURE-----

--nDIlh0zswpni3gKFb7CizEITdFEZSBw3N--
