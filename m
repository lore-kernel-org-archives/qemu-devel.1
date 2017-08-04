Received: from eggs.gnu.org ([2001:4830:134:3::10]:54126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddeIi-0004rN-0P
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddeIh-0006Yi-07
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:07 -0400
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1501597152-25342-2-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9fc51026-6e93-dd87-d43f-226ef5223565@redhat.com>
Date: Fri, 4 Aug 2017 10:13:59 -0500
MIME-Version: 1.0
In-Reply-To: <1501597152-25342-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WpCgk1FHb3rsAo5iFo5nC2wuFv2nojgSO"
Subject: Re: [Qemu-devel] [PATCH v4 for-2.10 01/15] mirror: inherit
 supported write/zero flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WpCgk1FHb3rsAo5iFo5nC2wuFv2nojgSO
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com,
 mreitz@redhat.com
Message-ID: <9fc51026-6e93-dd87-d43f-226ef5223565@redhat.com>
Subject: Re: [PATCH v4 for-2.10 01/15] mirror: inherit supported write/zero
 flags
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1501597152-25342-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1501597152-25342-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/01/2017 09:18 AM, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/mirror.c | 5 +++++
>  1 file changed, 5 insertions(+)

I think this one counts as a bug fix worthy of inclusion in 2.10.

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index d46dace..7e539f1 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1056,6 +1056,11 @@ static void bdrv_mirror_top_refresh_filename(Blo=
ckDriverState *bs, QDict *opts)
>      bdrv_refresh_filename(bs->backing->bs);
>      pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
>              bs->backing->bs->filename);
> +    bs->supported_write_flags =3D BDRV_REQ_FUA &
> +        bs->backing->bs->supported_write_flags;
> +    bs->supported_zero_flags =3D
> +        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
> +        bs->backing->bs->supported_zero_flags;
>  }
> =20
>  static void bdrv_mirror_top_close(BlockDriverState *bs)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WpCgk1FHb3rsAo5iFo5nC2wuFv2nojgSO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmEjzcACgkQp6FrSiUn
Q2pmigf+KRFRdiVjjwK8Hmy+ATfUxeSffgvEXKV0BOUfklZZ2Pqr1v4hXdBPAzsy
r2ndS9G/h5n0csCO2SrqsKKh32CG5YZLsSEn+lnbKt7Le0KMCuQ88ZQ/xDwaGoBt
yU4rREucNJ2HI/b7Ayf3rh6koXAXcMUJLUIDSRRn4uGosJLrEDe7/pWv26g32UcK
DoUiUDy1NtLu41ZBdIBnNsguaHDODtTTKoL4j/mgwrRcLdEGiag+rOALmY6eeQCE
gsL2YBeGpf3UXCua9SOweOG04ft68ATGWludChhjJFjW/XTotF9wGNMd7B6jirx3
bN9lvPewLd4PGflQj8hfX75WCjL3EA==
=EeGb
-----END PGP SIGNATURE-----

--WpCgk1FHb3rsAo5iFo5nC2wuFv2nojgSO--
