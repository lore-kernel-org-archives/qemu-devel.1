Received: from eggs.gnu.org ([2001:4830:134:3::10]:60134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dufyu-00084z-0x
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dufyp-0002CQ-US
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:28:04 -0400
References: <20170920135833.20472-1-pbutsykin@virtuozzo.com>
	<20170920135833.20472-2-pbutsykin@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d897c151-f2a4-fa44-11dd-e12503b41b61@redhat.com>
Date: Wed, 20 Sep 2017 09:27:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170920135833.20472-2-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WoHFxAR3fPmIc7ep5niifqQPVhOsJLI62"
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: fix return error code in
 qcow2_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WoHFxAR3fPmIc7ep5niifqQPVhOsJLI62
From: Eric Blake <eblake@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <d897c151-f2a4-fa44-11dd-e12503b41b61@redhat.com>
Subject: Re: [PATCH 1/2] qcow2: fix return error code in qcow2_truncate()
References: <20170920135833.20472-1-pbutsykin@virtuozzo.com>
 <20170920135833.20472-2-pbutsykin@virtuozzo.com>
In-Reply-To: <20170920135833.20472-2-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/20/2017 08:58 AM, Pavel Butsykin wrote:
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  block/qcow2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Wow, bdrv_truncate() has had problems!  You found fixes unrelated to my
current struggles to fix the dirty-bitmap failure.

Reviewed-by: Eric Blake <eblake@redhat.com>
CC: qemu-stable@nongnu.org

>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 2174a84d1f..8a4311d338 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3166,7 +3166,7 @@ static int qcow2_truncate(BlockDriverState *bs, i=
nt64_t offset,
>          if (old_file_size < 0) {
>              error_setg_errno(errp, -old_file_size,
>                               "Failed to inquire current file length");=

> -            return ret;
> +            return old_file_size;
>          }
> =20
>          nb_new_data_clusters =3D DIV_ROUND_UP(offset - old_length,
> @@ -3195,7 +3195,7 @@ static int qcow2_truncate(BlockDriverState *bs, i=
nt64_t offset,
>          if (allocation_start < 0) {
>              error_setg_errno(errp, -allocation_start,
>                               "Failed to resize refcount structures");
> -            return -allocation_start;
> +            return allocation_start;
>          }
> =20
>          clusters_allocated =3D qcow2_alloc_clusters_at(bs, allocation_=
start,
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WoHFxAR3fPmIc7ep5niifqQPVhOsJLI62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCeuEACgkQp6FrSiUn
Q2peWgf/Xfm2j1/0utZcGkMt0myQpZNz+s8S/38ejrA9UUZthLLTWH9NXVboVRx8
3eSt4fa9rBEmFYW19duFMLH66crH/+RP2/hsA+mKMnWKv2g/BuOeF4/bCPR1rikZ
qERYgt7tWIk5xS+2gOngmFsR1qE/kKpP1efjw9Tw5lM0VHOgBXMyOKQkpMP1Qs0a
rw9CuEVMNE9wG4iAQnfJ7XS3jTbGJwyb2BxVfFvBSrcoekevCMxANtaSoOrReULK
HpkjLQxYWDxMRKqW4GYWotuyTa8z/xV2CtCgipm/GKvcm/2xquYx151UgG+bJtPi
xR5eyuRXyQtDppvLV/alVeyxQfsKOw==
=NNBW
-----END PGP SIGNATURE-----

--WoHFxAR3fPmIc7ep5niifqQPVhOsJLI62--
