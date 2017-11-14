Received: from eggs.gnu.org ([2001:4830:134:3::10]:40805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEePp-0004OX-6M
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:50:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEePo-0002jn-9q
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:50:25 -0500
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510654613-47868-2-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7ce0d647-14c7-6874-b9d8-606a58c66b6e@redhat.com>
Date: Tue, 14 Nov 2017 10:50:04 -0600
MIME-Version: 1.0
In-Reply-To: <1510654613-47868-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9Wa3I3S9f7JtFsXXl2UI7oI7pJngG80dO"
Subject: Re: [Qemu-devel] [PATCH 1/5 for-2.11?] qcow2: reject unaligned
 offsets in write compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9Wa3I3S9f7JtFsXXl2UI7oI7pJngG80dO
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com
Message-ID: <7ce0d647-14c7-6874-b9d8-606a58c66b6e@redhat.com>
Subject: Re: [PATCH 1/5 for-2.11?] qcow2: reject unaligned offsets in write
 compressed
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1510654613-47868-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1510654613-47868-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/14/2017 04:16 AM, Anton Nefedov wrote:
> Misaligned compressed write is not supported.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/qcow2.c | 4 ++++
>  1 file changed, 4 insertions(+)

Should this one be applied in 2.11?

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 92cb9f9..45c5651 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3349,6 +3349,10 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs=
, uint64_t offset,
>          return bdrv_truncate(bs->file, cluster_offset, PREALLOC_MODE_O=
FF, NULL);
>      }
> =20
> +    if (offset_into_cluster(s, offset)) {
> +        return -EINVAL;
> +    }
> +
>      buf =3D qemu_blockalign(bs, s->cluster_size);
>      if (bytes !=3D s->cluster_size) {
>          if (bytes > s->cluster_size ||
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9Wa3I3S9f7JtFsXXl2UI7oI7pJngG80dO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloLHrwACgkQp6FrSiUn
Q2rm/gf/Yvla8UtEGYO+RSA7XkXJJt2Jy53meVBzI4PJrOLjWiW+EzDmjI1jDgbS
edQxCJIQLE1hNwqZbw1NG4dozVAcaMi9Ndg/tXXQZR+YIX1Z1K/vIoI595K7S8IP
Bt/VGuNrxjIAdGdGWsq2zn/MF7sz2ZxVUPyuIsN31+Wgr7hsGvbWAwIDQojrhRsU
U5+1JQuwNwI84Se3gBEkIIXpEINCOiBQ08RtDqCw4vLYGBQHWBIhfaIu3BDnqmyK
dAv9QmR3CAcR6lgp63AMrYR5UREON07H2VvS2PcMnk5zrJSAI2fwrs1ykiBO27sk
hP5gRhoxmCpcnJUU7IlUWIofCk8lrA==
=Q3De
-----END PGP SIGNATURE-----

--9Wa3I3S9f7JtFsXXl2UI7oI7pJngG80dO--
