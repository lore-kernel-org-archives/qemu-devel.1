Received: from eggs.gnu.org ([209.51.188.92]:51606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3XY6-0007fC-Gh
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3XY5-0004Cu-Ox
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:53:50 -0400
References: <20190311165017.32247-1-kwolf@redhat.com>
	<20190311165017.32247-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <039eaa9e-e2cc-fca0-f455-bd525529eec3@redhat.com>
Date: Mon, 11 Mar 2019 21:53:44 -0500
MIME-Version: 1.0
In-Reply-To: <20190311165017.32247-4-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0kfeKIIt3rERgJdgSvEyhC3BDevSVB8IT"
Subject: Re: [Qemu-devel] [PATCH v2 03/10] block: Avoid useless local_err
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, berto@igalia.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0kfeKIIt3rERgJdgSvEyhC3BDevSVB8IT
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, berto@igalia.com,
 qemu-devel@nongnu.org
Message-ID: <039eaa9e-e2cc-fca0-f455-bd525529eec3@redhat.com>
Subject: Re: [PATCH v2 03/10] block: Avoid useless local_err
References: <20190311165017.32247-1-kwolf@redhat.com>
 <20190311165017.32247-4-kwolf@redhat.com>
In-Reply-To: <20190311165017.32247-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/11/19 11:50 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/block.c b/block.c
> index ccf008c177..e18bd5eefd 100644
> --- a/block.c
> +++ b/block.c
> @@ -3155,14 +3155,12 @@ int bdrv_reopen_multiple(AioContext *ctx, Block=
ReopenQueue *bs_queue, Error **er
>  {
>      int ret =3D -1;
>      BlockReopenQueueEntry *bs_entry, *next;
> -    Error *local_err =3D NULL;
> =20
>      assert(bs_queue !=3D NULL);
> =20
>      QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
>          assert(bs_entry->state.bs->quiesce_counter > 0);
> -        if (bdrv_reopen_prepare(&bs_entry->state, bs_queue, &local_err=
)) {
> -            error_propagate(errp, local_err);
> +        if (bdrv_reopen_prepare(&bs_entry->state, bs_queue, errp)) {
>              goto cleanup;
>          }
>          bs_entry->prepared =3D true;
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--0kfeKIIt3rERgJdgSvEyhC3BDevSVB8IT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyHHzgACgkQp6FrSiUn
Q2pMZQgAhyltuSwyTz/fBB4rFucbBriLT3vbj59Uo6nbC1X69ceZyUjxq0F4QPAu
RArvFBW0MzKUHeOtYtPLkGcCjDSuAeRYS/kFT69Ct4jTLLBVxwHtSzS2jQTm/ckx
1dC90GWRUyzGmVUnz2OscquMWkAbh83qgZ0UNs9F6HM6T5wUXIaWEz3dqKS9dYza
aR7YBONOcTMu/a2Z0YAwuTjpHPv2OHijyzZEyLBRMUTTlbzVW9pypv68hGP6Jttw
haYO2Ot88vkRwJOBoYabQClZqT/HW/foiVgEcjjvUOEMuVQVesn6zsYtg5TPe+a+
j4kuEZFsUrySchWo4h/MaAE81E2kMA==
=4ozE
-----END PGP SIGNATURE-----

--0kfeKIIt3rERgJdgSvEyhC3BDevSVB8IT--
