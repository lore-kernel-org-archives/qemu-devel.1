Received: from eggs.gnu.org ([209.51.188.92]:56076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hC4DD-0004QA-IZ
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 11:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hC4DC-0000TD-GD
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 11:23:31 -0400
References: <20190404150746.12585-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9333ae6f-dea1-d8b4-cdeb-39668efd2d56@redhat.com>
Date: Thu, 4 Apr 2019 10:18:22 -0500
MIME-Version: 1.0
In-Reply-To: <20190404150746.12585-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pbPneq6G5IQhlgKc5LCtXVMMst2aziISA"
Subject: Re: [Qemu-devel] [PATCH for-4.0] block: Forward 'discard' to
 temporary overlay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pbPneq6G5IQhlgKc5LCtXVMMst2aziISA
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <9333ae6f-dea1-d8b4-cdeb-39668efd2d56@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0] block: Forward 'discard' to
 temporary overlay
References: <20190404150746.12585-1-kwolf@redhat.com>
In-Reply-To: <20190404150746.12585-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/4/19 10:07 AM, Kevin Wolf wrote:
> When bdrv_temp_snapshot_options() is called for snapshot=3Don, the
> 'discard' option in the options QDict hasn't been parsed and merged int=
o
> the flags yet. So copy the dict entry to make sure that the temporary
> overlay enables discard when it was requested for the drive.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block.c b/block.c
> index 3050854528..16615bc876 100644
> --- a/block.c
> +++ b/block.c
> @@ -950,8 +950,9 @@ static void bdrv_temp_snapshot_options(int *child_f=
lags, QDict *child_options,
>      qdict_set_default_str(child_options, BDRV_OPT_CACHE_DIRECT, "off")=
;
>      qdict_set_default_str(child_options, BDRV_OPT_CACHE_NO_FLUSH, "on"=
);
> =20
> -    /* Copy the read-only option from the parent */
> +    /* Copy the read-only and discard options from the parent */
>      qdict_copy_default(child_options, parent_options, BDRV_OPT_READ_ON=
LY);
> +    qdict_copy_default(child_options, parent_options, BDRV_OPT_DISCARD=
);
> =20
>      /* aio=3Dnative doesn't work for cache.direct=3Doff, so disable it=
 for the
>       * temporary snapshot */
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--pbPneq6G5IQhlgKc5LCtXVMMst2aziISA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlymID4ACgkQp6FrSiUn
Q2o1RQf/fEXOxwnPCVqEtJCYBbyb+NJgxfDZEw1idlNbw75WtL6wKomld7An6nKx
iESLCWH82fDg7ZryWZUTpjdxwPMynSYwoMGAwC2NoL4QQpb5Ix6NYs6GY05Uu01u
r3yys6kLB/+w/9iNH/BfXCaHeQM9vhvi0+zf7xIWH/PA+vJq23Y17AQmpyE4Bhvi
sAsmQQwo8ubjz5XbApTySuOLxOuTbH338Y+cHyhi5pJ6rSRoQXIrobMbyTNnu/wX
U8DKwQzPKBxIEeqXSodfelnyOdLH+q8MeYtb4iH7U7JUC8/lkGyAdJBofoRedL6R
e32kXsVBxZYPQJ+G5/JgQ0sjN4Vcbg==
=K9bh
-----END PGP SIGNATURE-----

--pbPneq6G5IQhlgKc5LCtXVMMst2aziISA--
